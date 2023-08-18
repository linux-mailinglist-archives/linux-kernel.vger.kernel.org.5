Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696F978147B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 22:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbjHRU62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 16:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjHRU6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 16:58:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB0D10E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 13:58:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4A0563146
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 20:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BE8C433C7;
        Fri, 18 Aug 2023 20:58:12 +0000 (UTC)
Date:   Fri, 18 Aug 2023 22:58:09 +0200
From:   Helge Deller <deller@gmx.de>
To:     linux-arm-kernel@lists.infradead.org,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH][RESEND] arm: Fix flush_dcache_page() for usage from irq
 context
Message-ID: <ZN/bYak6eLE02LJP@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since at least kernel 6.1, flush_dcache_page() is called with IRQs
disabled, e.g. from aio_complete().

But the current implementation for flush_dcache_page() on ARM (32-bit)
unintentionally re-enables IRQs, which may lead to deadlocks.

Fix it by using xa_lock_irqsave() and xa_unlock_irqrestore()
for the flush_dcache_mmap_*lock() macros instead.

Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Helge Deller <deller@gmx.de>

---

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index a094f964c869..5b8a1ef0dc50 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -315,6 +315,10 @@ static inline void flush_anon_page(struct vm_area_struct *vma,
 
 #define flush_dcache_mmap_lock(mapping)		xa_lock_irq(&mapping->i_pages)
 #define flush_dcache_mmap_unlock(mapping)	xa_unlock_irq(&mapping->i_pages)
+#define flush_dcache_mmap_lock_irqsave(mapping, flags)		\
+		xa_lock_irqsave(&mapping->i_pages, flags)
+#define flush_dcache_mmap_unlock_irqrestore(mapping, flags)	\
+		xa_unlock_irqrestore(&mapping->i_pages, flags)
 
 /*
  * We don't appear to need to do anything here.  In fact, if we did, we'd
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 2508be91b7a0..e70dd5e354ae 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -238,6 +238,7 @@ static void __flush_dcache_aliases(struct address_space *mapping, struct page *p
 {
 	struct mm_struct *mm = current->active_mm;
 	struct vm_area_struct *mpnt;
+	unsigned long flags;
 	pgoff_t pgoff;
 
 	/*
@@ -248,7 +249,7 @@ static void __flush_dcache_aliases(struct address_space *mapping, struct page *p
 	 */
 	pgoff = page->index;
 
-	flush_dcache_mmap_lock(mapping);
+	flush_dcache_mmap_lock_irqsave(mapping, flags);
 	vma_interval_tree_foreach(mpnt, &mapping->i_mmap, pgoff, pgoff) {
 		unsigned long offset;
 
@@ -262,7 +263,7 @@ static void __flush_dcache_aliases(struct address_space *mapping, struct page *p
 		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
 		flush_cache_page(mpnt, mpnt->vm_start + offset, page_to_pfn(page));
 	}
-	flush_dcache_mmap_unlock(mapping);
+	flush_dcache_mmap_unlock_irqrestore(mapping, flags);
 }
 
 #if __LINUX_ARM_ARCH__ >= 6
