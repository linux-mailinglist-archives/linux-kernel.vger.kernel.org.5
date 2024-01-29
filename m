Return-Path: <linux-kernel+bounces-42866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 955B48407F8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FC06B242A5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8AE65BBB;
	Mon, 29 Jan 2024 14:15:46 +0000 (UTC)
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [49.12.208.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A815965BA3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.208.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537745; cv=none; b=dWun18TdkVANlsQmrttlaZnfhqt8+C5ie9OcMSPUoi1slDF/3Pj4E0O2Pi5+MYNCFuoq5jzLwbrhSUArs4DGo4u8lY/CA97c/VRYIDFkSE78WwIiwnMOd8NOHNrRtJ/xKXjkGqmSpKppgkfPJ3Y/z2nH4TxApwnC8AvaNSQ3z2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537745; c=relaxed/simple;
	bh=yW/KTPvl1LdQSw2p4A5TjI0BdCEzeZVKTkHAyd72DpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmyex+tYlzMUwABkBdUm/+QEPSB9z8ZLp3WXLv/c9HIiulODjw6IjhsCs8Mg3ooo7blhzfibQZsuP5M22tyTH5lgM3uJ+Mw0aCAfLoe3mrqUTsMloYl1uNcW4ALTzQdZdYyd8df2vKGJswI9dx/8zOZZeL1/+u16DIM/xUeGQNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar; spf=pass smtp.mailfrom=sdfg.com.ar; arc=none smtp.client-ip=49.12.208.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdfg.com.ar
Received: from localhost.localdomain
	by sdfg.com.ar (chasquid) with ESMTPSA
	tls TLS_AES_128_GCM_SHA256
	(over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
	; Mon, 29 Jan 2024 14:15:35 +0000
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org,
	Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH 1/4] tools/nolibc/string: export strlen()
Date: Mon, 29 Jan 2024 15:15:13 +0100
Message-ID: <20240129141516.198636-2-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129141516.198636-1-rodrigo@sdfg.com.ar>
References: <20240129141516.198636-1-rodrigo@sdfg.com.ar>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As with commit 8d304a374023, "tools/nolibc/string: export memset() and
memmove()", gcc -Os without -ffreestanding may fail to compile with:

	cc -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib -lgcc  -static -o test test.c
	/usr/bin/ld: /tmp/cccIasKL.o: in function `main':
	test.c:(.text.startup+0x1e): undefined reference to `strlen'
	collect2: error: ld returned 1 exit status

As on the aforementioned commit, this patch adds a section to export
this function so compilation works on those cases too.

Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
---
 tools/include/nolibc/string.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index a01c69dd495f..ed15c22b1b2a 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -123,7 +123,7 @@ char *strcpy(char *dst, const char *src)
  * thus itself, hence the asm() statement below that's meant to disable this
  * confusing practice.
  */
-static __attribute__((unused))
+__attribute__((weak,unused,section(".text.nolibc_strlen")))
 size_t strlen(const char *str)
 {
 	size_t len;
-- 
2.43.0


