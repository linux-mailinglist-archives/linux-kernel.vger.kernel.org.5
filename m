Return-Path: <linux-kernel+bounces-40177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D15F83DBD1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 524A1287013
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33801C2AE;
	Fri, 26 Jan 2024 14:25:31 +0000 (UTC)
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [49.12.208.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBE61D556
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.208.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279131; cv=none; b=dQgKhnijdb9k0hWuIZSgZvIXsF8/sg/5Vmycr3l9KUlgFdSkJmEr1Hot+LTec+rUeZIz1TzW3TRRKIw3rQrVW+dLR/OFof1R74badSBh3Lr/FyV2R0rVrOx9rW+8b0IMLRrUHTAHLCWj/bP0gt0lfOYOWS9vY982TfDXWujFSVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279131; c=relaxed/simple;
	bh=sbhZ/NdHAucnYQnxUho3gN2gMhD/hGaKGFKuXYzPsA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uM5y9RNOHrGHKmpcybsVOio5KThJpKKOo+vdm1ev56h2+PvL6p+n56oSwKChtQB/s6XtiFWdfrTrMsoqY3zmW/fUGwnJttRiwFWf0ZHbJZl0igQzEp5sSqWLYUmzcoMQs7+TK4iHYs4EFvTk1wU4J7lTAy1Lrct3kJNmdnEoMiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar; spf=pass smtp.mailfrom=sdfg.com.ar; arc=none smtp.client-ip=49.12.208.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdfg.com.ar
Received: from localhost.localdomain
	by sdfg.com.ar (chasquid) with ESMTPSA
	tls TLS_AES_128_GCM_SHA256
	(over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
	; Fri, 26 Jan 2024 14:25:25 +0000
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org,
	Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH 1/1] tools/nolibc/string: export strlen()
Date: Fri, 26 Jan 2024 15:24:11 +0100
Message-ID: <20240126142411.22972-2-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126142411.22972-1-rodrigo@sdfg.com.ar>
References: <20240126142411.22972-1-rodrigo@sdfg.com.ar>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As with commit 8d304a374023, "tools/nolibc/string: export memset() and
memmove()", gcc -Os without -ffreestanding may fail to compile with:

	cc -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib -lgcc -c test.c -o test.o
	cc test.o -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib -lgcc  -static -o test
	/usr/bin/ld: test.o: in function `main':
	test.c:(.text.startup+0x32): undefined reference to `strlen'
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


