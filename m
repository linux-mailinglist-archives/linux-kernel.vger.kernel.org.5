Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69A27F07DA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 17:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjKSQ7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 11:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjKSQ6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 11:58:48 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBAA01706;
        Sun, 19 Nov 2023 08:58:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87A641042;
        Sun, 19 Nov 2023 08:59:18 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40DE23F6C4;
        Sun, 19 Nov 2023 08:58:27 -0800 (PST)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
        maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
        rppt@kernel.org, hughd@google.com
Cc:     pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
        vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
        kcc@google.com, hyesoo.yu@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC v2 10/27] mm: Call arch_swap_prepare_to_restore() before arch_swap_restore()
Date:   Sun, 19 Nov 2023 16:57:04 +0000
Message-Id: <20231119165721.9849-11-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231119165721.9849-1-alexandru.elisei@arm.com>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 uses arch_swap_restore() to restore saved tags before the page is
swapped in and it's called in atomic context (with the ptl lock held).

Introduce arch_swap_prepare_to_restore() that will allow an architecture to
perform extra work during swap in and outside of a critical section.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 include/linux/pgtable.h | 7 +++++++
 mm/memory.c             | 4 ++++
 mm/shmem.c              | 9 +++++++++
 mm/swapfile.c           | 7 +++++++
 4 files changed, 27 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index b1001ce361ac..ffdb9b6bed6c 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -938,6 +938,13 @@ static inline void arch_swap_invalidate_area(int type)
 }
 #endif
 
+#ifndef __HAVE_ARCH_SWAP_PREPARE_TO_RESTORE
+static inline vm_fault_t arch_swap_prepare_to_restore(swp_entry_t entry, struct folio *folio)
+{
+	return 0;
+}
+#endif
+
 #ifndef __HAVE_ARCH_SWAP_RESTORE
 static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
 {
diff --git a/mm/memory.c b/mm/memory.c
index 1f18ed4a5497..e137f7673749 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3957,6 +3957,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 	folio_throttle_swaprate(folio, GFP_KERNEL);
 
+	ret = arch_swap_prepare_to_restore(entry, folio);
+	if (ret)
+		goto out_page;
+
 	/*
 	 * Back out if somebody else already faulted in this pte.
 	 */
diff --git a/mm/shmem.c b/mm/shmem.c
index 71ce5fe5c779..0449c03dbdfd 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1840,6 +1840,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	struct swap_info_struct *si;
 	struct folio *folio = NULL;
 	swp_entry_t swap;
+	vm_fault_t ret;
 	int error;
 
 	VM_BUG_ON(!*foliop || !xa_is_value(*foliop));
@@ -1888,6 +1889,14 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	}
 	folio_wait_writeback(folio);
 
+	ret = arch_swap_prepare_to_restore(swap, folio);
+	if (ret) {
+		if (fault_type)
+			*fault_type = ret;
+		error = -EINVAL;
+		goto unlock;
+	}
+
 	/*
 	 * Some architectures may have to restore extra metadata to the
 	 * folio after reading from swap.
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4bc70f459164..9983dffce47b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1746,6 +1746,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	spinlock_t *ptl;
 	pte_t *pte, new_pte, old_pte;
 	bool hwpoisoned = PageHWPoison(page);
+	vm_fault_t err;
 	int ret = 1;
 
 	swapcache = page;
@@ -1779,6 +1780,12 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		goto setpte;
 	}
 
+	err = arch_swap_prepare_to_restore(entry, page_folio(page));
+	if (err) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/*
 	 * Some architectures may have to restore extra metadata to the page
 	 * when reading from swap. This metadata may be indexed by swap entry
-- 
2.42.1

