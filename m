Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACE5790558
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 07:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351598AbjIBFva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 01:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351582AbjIBFv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 01:51:29 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A3F10FE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 22:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693633881;
        bh=adKYv+UWCAtL6RnGzj9nIBJ/HQrhFBvKNcQpOXq1TGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lVAKBh4PEvXzamNP7IgFYjyUlSSIHtsv+itkbldEfvOGPycWYZcQ1nY4WLXOWcF9N
         UUj0TiGlFnWC5Mgwqmu+yvEfZMceFCEcjur4g2ujMNF0l6jIRTuJaX2BfJMxlkxhGB
         DU7P2Y4dYb2mHZaI3M3qUUIa6NfqzLuUWIIjWm859jM+YSR0vl1u9SFvCh2Bpy75WV
         LLBgbp57Dfqt4NXy8b/VoGzoaQmD2NMzGKK20jELwMbSOjCLrbx8ubkwhi7QkVhrns
         qpmfkSH7Jy8KUf0e91BjU/h3+cCSCgFwv3tW35X6pgwpXMhTO5IvQaRiAvcJp1pljH
         DFpp6ohZioF4g==
Received: from localhost.localdomain (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 90ACB24B3B5;
        Sat,  2 Sep 2023 12:51:17 +0700 (WIB)
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        David Laight <David.Laight@aculab.com>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 4/4] tools/nolibc: string: Remove the `_nolibc_memcpy_up()` function
Date:   Sat,  2 Sep 2023 12:50:45 +0700
Message-Id: <20230902055045.2138405-5-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230902055045.2138405-1-ammarfaizi2@gnuweeb.org>
References: <20230902055045.2138405-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is only called by memcpy(), there is no real reason to
have this wrapper. Delete this function and move the code to memcpy()
directly.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/string.h | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 22dcb3f566baeefe..a01c69dd495f550c 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -10,84 +10,78 @@
 #include "std.h"
 
 static void *malloc(size_t len);
 
 /*
  * As much as possible, please keep functions alphabetically sorted.
  */
 
 static __attribute__((unused))
 int memcmp(const void *s1, const void *s2, size_t n)
 {
 	size_t ofs = 0;
 	int c1 = 0;
 
 	while (ofs < n && !(c1 = ((unsigned char *)s1)[ofs] - ((unsigned char *)s2)[ofs])) {
 		ofs++;
 	}
 	return c1;
 }
 
-static __attribute__((unused))
-void *_nolibc_memcpy_up(void *dst, const void *src, size_t len)
-{
-	size_t pos = 0;
-
-	while (pos < len) {
-		((char *)dst)[pos] = ((const char *)src)[pos];
-		pos++;
-	}
-	return dst;
-}
-
 #ifndef NOLIBC_ARCH_HAS_MEMMOVE
 /* might be ignored by the compiler without -ffreestanding, then found as
  * missing.
  */
 __attribute__((weak,unused,section(".text.nolibc_memmove")))
 void *memmove(void *dst, const void *src, size_t len)
 {
 	size_t dir, pos;
 
 	pos = len;
 	dir = -1;
 
 	if (dst < src) {
 		pos = -1;
 		dir = 1;
 	}
 
 	while (len) {
 		pos += dir;
 		((char *)dst)[pos] = ((const char *)src)[pos];
 		len--;
 	}
 	return dst;
 }
 #endif /* #ifndef NOLIBC_ARCH_HAS_MEMMOVE */
 
 #ifndef NOLIBC_ARCH_HAS_MEMCPY
 /* must be exported, as it's used by libgcc on ARM */
 __attribute__((weak,unused,section(".text.nolibc_memcpy")))
 void *memcpy(void *dst, const void *src, size_t len)
 {
-	return _nolibc_memcpy_up(dst, src, len);
+	size_t pos = 0;
+
+	while (pos < len) {
+		((char *)dst)[pos] = ((const char *)src)[pos];
+		pos++;
+	}
+	return dst;
 }
 #endif /* #ifndef NOLIBC_ARCH_HAS_MEMCPY */
 
 #ifndef NOLIBC_ARCH_HAS_MEMSET
 /* might be ignored by the compiler without -ffreestanding, then found as
  * missing.
  */
 __attribute__((weak,unused,section(".text.nolibc_memset")))
 void *memset(void *dst, int b, size_t len)
 {
 	char *p = dst;
 
 	while (len--) {
 		/* prevent gcc from recognizing memset() here */
 		__asm__ volatile("");
 		*(p++) = b;
 	}
 	return dst;
 }
 #endif /* #ifndef NOLIBC_ARCH_HAS_MEMSET */
-- 
Ammar Faizi

