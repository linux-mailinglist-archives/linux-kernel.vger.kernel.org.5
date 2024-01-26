Return-Path: <linux-kernel+bounces-40181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F3383DBDB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F5BA2837A1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE2C1D548;
	Fri, 26 Jan 2024 14:27:17 +0000 (UTC)
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [49.12.208.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B06F1D542
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.208.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279236; cv=none; b=TQtqnhkznFCWEvWLzudZuIK/I9bi8xTsWU5f3dPpgPacTGSmEI+qY0fyENatx4UD93zek5nWKtHrz+USHcfIlGiE+RU5bPdZr7eOlV6pKJCWBUtFea3Ujl7Dx5dO/5HzggGDxzE82oWK1arbPGZWKcDwvXKgXvdfAGGDynL61eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279236; c=relaxed/simple;
	bh=cZBJLKefiwIoCqsp24IQdNQsW6/wBIH4IUtTtYyyoSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TMV4OZvbpVIV0fA2g1qipNtzBKDaySdXKdt2qjtijPLAES1BaSiJUqrdHoWyGkPL6VawpXDGms9Qg0yy+wPHPfr2841XGgbPQB0UTC+k3zAKc2f1a8D/NqMUfEGXOyUeGNshCNnpEzpC8eaum9ReetHKx9jRs7zVNX2L/ZYcDEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar; spf=pass smtp.mailfrom=sdfg.com.ar; arc=none smtp.client-ip=49.12.208.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdfg.com.ar
Received: from localhost.localdomain
	by sdfg.com.ar (chasquid) with ESMTPSA
	tls TLS_AES_128_GCM_SHA256
	(over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
	; Fri, 26 Jan 2024 14:25:10 +0000
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org,
	Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH 0/1] tools/nolibc/string: export strlen()
Date: Fri, 26 Jan 2024 15:24:10 +0100
Message-ID: <20240126142411.22972-1-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, while using nolibc on debian testing, I found that compilation fails when using strlcat().

The compilation fails with:

            cc -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib -lgcc  -static -o test test.c
            /usr/bin/ld: /tmp/cccIasKL.o: in function `main':
            test.c:(.text.startup+0x1e): undefined reference to `strlen'
            collect2: error: ld returned 1 exit status

This is using debian testing, with gcc 13.2.0.

A small repro case that fails with this error on debian is:

	int main(void) {
		char dst[6] = "12";
		char *src = "abc";
		strlcat(dst, src, 6);
	
		printf("dst is: %s\n", dst);
	
		return 0;
	}

Please note that this code is not using strlen() and strlcat() doesn't seems to use it either.

First I noted that removing the attribute unused in strlen(), the compilation worked fine. And then
I noticied that other functions had the attribute weak, a custom section and export the function.

In particular, what happens here seems to be the same as in commit "tools/nolibc/string: export memset() and
memmove()" (8d304a374023), as removing the -Os or adding the -ffreestanding seem to fix the issue.
So, I did the same as that commit, for strlen().

However, I'm not 100% confident on how to check that this is done by the compiler to later replace
it and provide a builtin. I'm not sure how that was verified for commit 8d304a374023, but if you let
me know, I can verify it too.

What do you think?


As a side note, it seems strlcat()/strlcpy() fail to set the terminating null byte on some cases,
and the return code is not always the same as when using libbsd. It seems to be only on "error"
cases, and not sure if it's worth fixing all/some of those cases.

Let me know if you think it is worth adding some _simple_ patches (I don't think it is worth fixing
all the cases, the code is to fix all of the cases is probably not nice and not worth it).


Best,
Rodrigo

---


Rodrigo Campos (1):
  tools/nolibc/string: export strlen()

 tools/include/nolibc/string.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0


