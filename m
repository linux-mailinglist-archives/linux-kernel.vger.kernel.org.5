Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1688F78D87A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjH3Sah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244773AbjH3N6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:58:01 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3623FC2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693403878;
        bh=/YABsqbHD7MudnnQOTcU6MvoETFjlxMzuet8DJKii/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=stzm8KH+8URdY17DYLHw/KUfFXKYzqOeauSYTCPIJUmqKG0Qq1btzY9nfQwKpRI2K
         cyU7h0PCrU5zFSYGfzgu9DisCzWrPoUArXdQsDQzI1jwisiyyia2mASS1huhD3stzs
         FWErBBB6uXuSLzwTMEDWxWyY79N0ecvHge55Z2cfMeGGnsP7F6QUU5qC2rC9lKZZ9Y
         ed1hMGg0VmnlEnm0DZEUJbzjUfp5+2QoRatZsL2wNQ/TrbDxjx0ASGxkZmlDZhZdQq
         uNcKEmuFoqZz4+AuDziQLPje+ERaQeXtotowFQRu+7DmJfYClsD6D39AsVQZXMLSON
         1Imyn02uZqU/g==
Received: from localhost.localdomain (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 6ACE024B337;
        Wed, 30 Aug 2023 20:57:55 +0700 (WIB)
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v1 5/5] tools/nolibc: string: Remove the `_nolibc_memcpy_up()` function
Date:   Wed, 30 Aug 2023 20:57:26 +0700
Message-Id: <20230830135726.1939997-6-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
References: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
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
index b0d7d8e143f61741..920a0a6c922dbc42 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -29,18 +29,6 @@ int memcmp(const void *s1, const void *s2, size_t n)
 }
 #endif /* #ifndef NOLIBC_ARCH_HAS_MEMCMP */
 
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
@@ -72,7 +60,13 @@ void *memmove(void *dst, const void *src, size_t len)
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
 
-- 
Ammar Faizi

