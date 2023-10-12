Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF697C76EE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442560AbjJLTc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442269AbjJLTck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:32:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911F0EE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:32:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBC9C43395;
        Thu, 12 Oct 2023 19:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697139156;
        bh=pphMddfrgHcoIgmzZWe7AThL9XYOSaOTFelQzzfUfsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LdazeWMBWcAQZfED1qwdpEIQorVe9/eBbjPS3DMhBBM8Z4UUpdQWPEmRT8xIvv9KL
         w/15YUSQAie+QUB/Gw/qy2T201551+DDjkBrERGlhlne3I4PT6MlyVT/qtt3MxxZGp
         XbRp4NVSUeaMvtME8tuDbxSSuGvKCiBH87ooFlHmA59mJOVb/dnOKAEoPS91Y3g5Cw
         lr8OkHjfjnUxN76mJxKB/uXXSIAGnq8PFCS2SjB0zqAc/3xFY26BEsJD13a7htGCeb
         mOAWrzKaQER7m4T3SdT/y+DneSMgNFLSNo6awgO2/I/7vdYPbP2QqW8bJ11ShXWTqe
         4WQ48jTxsUm3w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 51D99CE0C3B; Thu, 12 Oct 2023 12:32:35 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Willy Tarreau <w@1wt.eu>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH nolibc 09/19] tools/nolibc: string: Remove the `_nolibc_memcpy_up()` function
Date:   Thu, 12 Oct 2023 12:32:23 -0700
Message-Id: <20231012193233.207857-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b34ce3cf-3fcc-4eb0-a658-229c197455ef@paulmck-laptop>
References: <b34ce3cf-3fcc-4eb0-a658-229c197455ef@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

This function is only called by memcpy(), there is no real reason to
have this wrapper. Delete this function and move the code to memcpy()
directly.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Reviewed-by: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/string.h | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 22dcb3f566ba..a01c69dd495f 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -27,18 +27,6 @@ int memcmp(const void *s1, const void *s2, size_t n)
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
@@ -70,7 +58,13 @@ void *memmove(void *dst, const void *src, size_t len)
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
2.40.1

