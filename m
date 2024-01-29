Return-Path: <linux-kernel+bounces-42868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307F88407FA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1780285170
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435DC664B1;
	Mon, 29 Jan 2024 14:15:47 +0000 (UTC)
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [49.12.208.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092E86311F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.208.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537746; cv=none; b=buy9MJ62aG9s0QGXYDOAZKQZu7CvRb7vKypUBNHQiAWiV5scp17IXWSpXDVFF56CTCvNNIf56mWCpKM56/7peWgxnY4usP3QrcEA0CEASylomgvlmmDXjNwhu/EZrLnDTMYN807DccqvoQTUroRoajYOujAWpwXapRMgCvSBC8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537746; c=relaxed/simple;
	bh=mH5A9hH5XvVo2T9vZBvlGm1W3LlxcYXSTb48Acf7hK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=shWIsQogf5UOyGlku248JW/2Y/ruzv1p2Ye8Ge5Sar/g+RAWrgrQzBAsvX5JKRGHRe5xzLXqk5j0e38rd1HREpiuFcfzdTtU3W9HFOq+LtofINBYA6YEYHQ5ctnbgoTclMExSSJ0Ard5n0BfEgv5N8cnHBMc6szFBAwXkO8ZsTs=
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
Subject: [PATCH 0/4] tools/nolibc: Misc fixes for strlcpy() and strlcat()
Date: Mon, 29 Jan 2024 15:15:12 +0100
Message-ID: <20240129141516.198636-1-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As requested by Willy and Thomas[1], here go some more fixes and tests for
strlcpy() and strlcat().

From the previous discussion, I uderstand that we want to apply the first patch
(export strlen()) as is, I've included it again here just in case. Maybe we should just include the
-Wl,--gc-sections in the nolibc.h comment about the flags to use when compiling?

The rest of the commits are quite simple too, they just:
	* Fix the return code of both functions
	* Make sure to always null-terminate the dst buffer
	* Don't copy more than what size allows us (this handles the size=0 case
	  for free too)

All has been checked against the corresponding libbsd implementation[2].

I thought the manpage was clear, but when checking against that, I noted a few
twists (like the manpage says the return code of strlcat is strlen(src) +
strlen(dst), but it was not clear it is not that if size < strlen(dst). When
looking at the libbsd implementation and re-reading the manpage, I understood
what it really meant).

Let me know what you think :)

Best,
Rodrigo


[1]: https://lore.kernel.org/all/9538a8fe-b92f-42a5-99d1-25969cf51647@sdfg.com.ar/
[2]: https://gitlab.freedesktop.org/libbsd/libbsd.git


Rodrigo Campos (4):
  tools/nolibc/string: export strlen()
  tools/nolibc: Fix strlcat() return code and size usage
  tools/nolibc: Fix strlcpy() return code and size usage
  selftests/nolibc: Add tests for strlcat() and strlcpy()

 tools/include/nolibc/string.h                | 25 +++++++-------
 tools/testing/selftests/nolibc/nolibc-test.c | 34 ++++++++++++++++++++
 2 files changed, 47 insertions(+), 12 deletions(-)

-- 
2.43.0


