Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3090E79081A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 15:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjIBNfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 09:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjIBNfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 09:35:33 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFE8170D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 06:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693661728;
        bh=wAfHXdyA6GZWEdNku2JSukYgPjxVsfGqEuLvT3ts0Qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=MoKloUN1AB+uCPhoOkH+B8dTdUtg25rvGmSQ2zJRsOXnOfI8Eg9ojr5uoAteXuNgW
         sqDJSJww6eO+4F8T02uQHy+cXH7Dlnc6xS9vkapSxl7Ka403QURiktG/flguNnOSJm
         /neqy3u61I7f0G2fNssUOGeG0PGw3Vj2YE/v96ZudgCO8vNBiVGQRLXy59yxlfNSYm
         Am2O7w3Kct2QtYHseinj0W8O8Mei7KLr8hP6whpfSgrk0QY8Ri9d8xvjGxc1WiEDcv
         mI1Gq2LQFLWL25N6CPzwC21Xj/F6iIwEai/RqtldbwCU2zpbJXRkd1EWXEojbGQwr2
         YqB7aXePs7vEw==
Received: from localhost.localdomain (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 28FA924B3DD;
        Sat,  2 Sep 2023 20:35:24 +0700 (WIB)
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
Subject: [RFC PATCH v3 3/4] tools/nolibc: string: Remove the `_nolibc_memcpy_down()` function
Date:   Sat,  2 Sep 2023 20:35:04 +0700
Message-Id: <20230902133505.2176434-4-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230902133505.2176434-1-ammarfaizi2@gnuweeb.org>
References: <20230902133505.2176434-1-ammarfaizi2@gnuweeb.org>
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

This nolibc internal function is not used. Delete it. It was probably
supposed to handle memmove(), but today the memmove() has its own
implementation.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/string.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 1bad6121ef8c4ab5..22dcb3f566baeefe 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -22,50 +22,40 @@ int memcmp(const void *s1, const void *s2, size_t n)
 	int c1 = 0;
 
 	while (ofs < n && !(c1 = ((unsigned char *)s1)[ofs] - ((unsigned char *)s2)[ofs])) {
 		ofs++;
 	}
 	return c1;
 }
 
 static __attribute__((unused))
 void *_nolibc_memcpy_up(void *dst, const void *src, size_t len)
 {
 	size_t pos = 0;
 
 	while (pos < len) {
 		((char *)dst)[pos] = ((const char *)src)[pos];
 		pos++;
 	}
 	return dst;
 }
 
-static __attribute__((unused))
-void *_nolibc_memcpy_down(void *dst, const void *src, size_t len)
-{
-	while (len) {
-		len--;
-		((char *)dst)[len] = ((const char *)src)[len];
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
-- 
Ammar Faizi

