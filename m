Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915367BBCE4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjJFQjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjJFQjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:39:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E666AD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 09:39:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7730C433C8;
        Fri,  6 Oct 2023 16:39:36 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Collingbourne <pcc@google.com>
Subject: [RESEND PATCH] mm: slab: Do not create kmalloc caches smaller than arch_slab_minalign()
Date:   Fri,  6 Oct 2023 17:39:34 +0100
Message-Id: <20231006163934.3273940-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b035f5a6d852 ("mm: slab: reduce the kmalloc() minimum alignment
if DMA bouncing possible") allows architectures with non-coherent DMA to
define a small ARCH_KMALLOC_MINALIGN (e.g. sizeof(unsigned long long))
and this has been enabled on arm64. With KASAN_HW_TAGS enabled, however,
ARCH_SLAB_MINALIGN becomes 16 on arm64 (arch_slab_minalign() dynamically
selects it since commit d949a8155d13 ("mm: make minimum slab alignment a
runtime property")). This can lead to a situation where kmalloc-8 caches
are attempted to be created with a kmem_caches.size aligned to 16. When
the cache is mergeable, it can lead to kernel warnings like:

sysfs: cannot create duplicate filename '/kernel/slab/:d-0000016'
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc1-00001-gda98843cd306-dirty #5
Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
Call trace:
 dump_backtrace+0x90/0xe8
 show_stack+0x18/0x24
 dump_stack_lvl+0x48/0x60
 dump_stack+0x18/0x24
 sysfs_warn_dup+0x64/0x80
 sysfs_create_dir_ns+0xe8/0x108
 kobject_add_internal+0x98/0x264
 kobject_init_and_add+0x8c/0xd8
 sysfs_slab_add+0x12c/0x248
 slab_sysfs_init+0x98/0x14c
 do_one_initcall+0x6c/0x1b0
 kernel_init_freeable+0x1c0/0x288
 kernel_init+0x24/0x1e0
 ret_from_fork+0x10/0x20
kobject: kobject_add_internal failed for :d-0000016 with -EEXIST, don't try to register things with the same name in the same directory.
SLUB: Unable to add boot slab dma-kmalloc-8 to sysfs

Limit the __kmalloc_minalign() return value (used to create the
kmalloc-* caches) to arch_slab_minalign() so that kmalloc-8 caches are
skipped when KASAN_HW_TAGS is enabled (both config and runtime).

Fixes: b035f5a6d852 ("mm: slab: reduce the kmalloc() minimum alignment if DMA bouncing possible")
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Peter Collingbourne <pcc@google.com>
Cc: <stable@vger.kernel.org> # 6.5.x
---

The previous post was messed up by my git send-email configuration, so
sending it again. Also cc'ing Vlastimil since he reviewed the previous
slab changes for ARCH_KMALLOC_MINALIGN. Thanks.

 mm/slab_common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index cd71f9581e67..8b45922ed295 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -895,10 +895,13 @@ void __init setup_kmalloc_cache_index_table(void)
 
 static unsigned int __kmalloc_minalign(void)
 {
+	unsigned int minalign = dma_get_cache_alignment();
+
 	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
 	    is_swiotlb_allocated())
-		return ARCH_KMALLOC_MINALIGN;
-	return dma_get_cache_alignment();
+		minalign = ARCH_KMALLOC_MINALIGN;
+
+	return ALIGN(minalign, arch_slab_minalign());
 }
 
 void __init
