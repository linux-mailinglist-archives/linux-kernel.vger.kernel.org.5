Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580497639A2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbjGZOym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbjGZOyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:54:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF451FF2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:54:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61CC461B0D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC13C433C7;
        Wed, 26 Jul 2023 14:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690383278;
        bh=6COAuBhHi+E6Wb3ufv0iUJ71l4MhF1eap+s4qSwyeU4=;
        h=From:To:Cc:Subject:Date:From;
        b=Um6LU4UQwX8QYWM2zwHJ2pvxGQ2sJOCrDvQkIIsUMJH0MYu6M2Y98v5/TPkfwMszS
         uOz8UxRFkjPHsdLtcsgR6Te4Xok49IEO5sHwMIZbaxvZ1mVL/6M3kFzDUMUmwYMF1o
         B3Pa115+S1LpK8afkcrIOkFP3w4NyjqGvbXrOb6lM6YJbnoVG4akmhgwrKsgh1Uwr8
         bGW+zq0hRuu8f/hYTbJJQeOsMTN5Dx0J+qa6woriDly0FGUCgcKtLh+ONJeIkmzgOT
         BwPh/tq9yd1LQt+ps/aLxLM2pgnwkLzKDr4Pkq/AVRwr4FO9SbIbcm2B2V+0ZeMdM2
         xjnjLP6CgEbTA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iomem: remove __weak ioremap_cache helper
Date:   Wed, 26 Jul 2023 16:54:09 +0200
Message-Id: <20230726145432.1617809-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

No portable code calls into this function any more, and on
architectures that don't use or define their own, it causes
a warning:

kernel/iomem.c:10:22: warning: no previous prototype for 'ioremap_cache' [-Wmissing-prototypes]
   10 | __weak void __iomem *ioremap_cache(resource_size_t offset, unsigned long size)

Fold it into the only caller that uses it on architectures
without the #define.

Note that the fallback to ioremap is probably still wrong on
those architectures, but this is what it's always done there.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/iomem.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/iomem.c b/kernel/iomem.c
index 9682471e64717..dc2120776e1c3 100644
--- a/kernel/iomem.c
+++ b/kernel/iomem.c
@@ -5,18 +5,14 @@
 #include <linux/mm.h>
 #include <linux/ioremap.h>
 
-#ifndef ioremap_cache
-/* temporary while we convert existing ioremap_cache users to memremap */
-__weak void __iomem *ioremap_cache(resource_size_t offset, unsigned long size)
-{
-	return ioremap(offset, size);
-}
-#endif
-
 #ifndef arch_memremap_wb
 static void *arch_memremap_wb(resource_size_t offset, unsigned long size)
 {
+#ifdef ioremap_cache
 	return (__force void *)ioremap_cache(offset, size);
+#else
+	return (__force void *)ioremap(offset, size);
+#endif
 }
 #endif
 
-- 
2.39.2

