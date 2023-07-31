Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9340C769F1F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjGaRPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjGaRPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:15:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3153919A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:12:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d20d99c03fbso5239289276.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690823559; x=1691428359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OgBnAtPoNKX+KJs8/FKp+BmtZpXa1bCkw8iPPxm9v3Y=;
        b=Gui0GRYVBMuJeIPTHfyhHWRf3ZvvQ9Lj3V7ipXxNJcDko805MiAWbxKx8mDUarhmuB
         q/olN0XhD4l8TaoIpr8gDksobmmqELsiDOw3r+0sx6ApTaHKI74YK3XC55P8mWDFy5hP
         3P9FBMAEa8e8vsor78FFzDcyQVY4zchDIvDwMMlMLiDHo0y8hhkXv10ZVpjqVjdyAN4b
         24xpkaWLkyKWOoC6+J3sDFsPEf08qqJ9mcoY4tSZQR7CAVRPQDvaUPVk6cI7UdE14AbJ
         cOpcpUcuFLJ9bBngvUSa13BpF0/aqtlVAHc6CDPFkqJFkVTb8czwRnhttfFT6igKBYZ4
         1B8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823559; x=1691428359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OgBnAtPoNKX+KJs8/FKp+BmtZpXa1bCkw8iPPxm9v3Y=;
        b=Ozpa6R5Tt27hfRGDcR6QZAjQWcrXTdYfZ79JYt6G1vch2KhZA3aMREHnxSXHThTUkh
         IbSAgu4lXzTq0SM7eZZqAMlqIYzFGAne40D81GQOoNlN18PUYm+eXss2H4MxcZDns+yA
         boxD96836pVgi8KntkD4eL9rttJQa3LHxz89FzIBPL/AwdVQDIidtjz9hk+D/iJFNUkH
         4l9TGwxAnGxgFARdfgAPfhZxN8J5va+842Jgkh2xFkw4gvISYCF4norPvSKBFLG7az7x
         f09RrjUmrJ/XAow3WMINmpQL/Z/gkFjqIhfplRZfKpwNpvTfiSBLlgbDcEGrWGWr8kkW
         KRWg==
X-Gm-Message-State: ABy/qLbtBORC4m4VWGOzlgKstItxQqXgfYtouhKcV3V/IET58dJ+r4cD
        FuTj3gHO7Vo65osXkW8035dqEjczAT4=
X-Google-Smtp-Source: APBJJlFnvcCtbJZ73O/WCx8iV93eYXfURurzOhWScTRkBXD7hwc1ky41TRPGayUXZ/7QplAeardfbFpzlyQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:d4d3:7e41:cb80:21ea])
 (user=surenb job=sendgmr) by 2002:a25:2055:0:b0:d27:bbcf:44ba with SMTP id
 g82-20020a252055000000b00d27bbcf44bamr66443ybg.1.1690823559416; Mon, 31 Jul
 2023 10:12:39 -0700 (PDT)
Date:   Mon, 31 Jul 2023 10:12:27 -0700
In-Reply-To: <20230731171233.1098105-1-surenb@google.com>
Mime-Version: 1.0
References: <20230731171233.1098105-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230731171233.1098105-2-surenb@google.com>
Subject: [PATCH 1/6] mm: enable page walking API to lock vmas during the walk
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, jannh@google.com,
        willy@infradead.org, liam.howlett@oracle.com, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

walk_page_range() and friends often operate under write-locked mmap_lock.
With introduction of vma locks, the vmas have to be locked as well
during such walks to prevent concurrent page faults in these areas.
Add an additional parameter to walk_page_range() functions to indicate the
walks which should lock the vmas before operating on them.

Cc: stable@vger.kernel.org # 6.4.x
Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/powerpc/mm/book3s64/subpage_prot.c |  2 +-
 arch/riscv/mm/pageattr.c                |  4 ++--
 arch/s390/mm/gmap.c                     | 10 +++++-----
 fs/proc/task_mmu.c                      | 10 +++++-----
 include/linux/pagewalk.h                |  6 +++---
 mm/damon/vaddr.c                        |  4 ++--
 mm/hmm.c                                |  2 +-
 mm/ksm.c                                | 16 ++++++++--------
 mm/madvise.c                            |  8 ++++----
 mm/memcontrol.c                         |  4 ++--
 mm/memory-failure.c                     |  2 +-
 mm/mempolicy.c                          | 12 ++++--------
 mm/migrate_device.c                     |  2 +-
 mm/mincore.c                            |  2 +-
 mm/mlock.c                              |  2 +-
 mm/mprotect.c                           |  2 +-
 mm/pagewalk.c                           | 13 ++++++++++---
 mm/vmscan.c                             |  3 ++-
 18 files changed, 54 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/subpage_prot.c b/arch/powerpc/mm/book3s64/subpage_prot.c
index 0dc85556dec5..177e5c646d9c 100644
--- a/arch/powerpc/mm/book3s64/subpage_prot.c
+++ b/arch/powerpc/mm/book3s64/subpage_prot.c
@@ -159,7 +159,7 @@ static void subpage_mark_vma_nohuge(struct mm_struct *mm, unsigned long addr,
 	 */
 	for_each_vma_range(vmi, vma, addr + len) {
 		vm_flags_set(vma, VM_NOHUGEPAGE);
-		walk_page_vma(vma, &subpage_walk_ops, NULL);
+		walk_page_vma(vma, &subpage_walk_ops, true, NULL);
 	}
 }
 #else
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index ea3d61de065b..95207994cbf0 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -167,7 +167,7 @@ int set_direct_map_invalid_noflush(struct page *page)
 	};
 
 	mmap_read_lock(&init_mm);
-	ret = walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
+	ret = walk_page_range(&init_mm, start, end, &pageattr_ops, false, &masks);
 	mmap_read_unlock(&init_mm);
 
 	return ret;
@@ -184,7 +184,7 @@ int set_direct_map_default_noflush(struct page *page)
 	};
 
 	mmap_read_lock(&init_mm);
-	ret = walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
+	ret = walk_page_range(&init_mm, start, end, &pageattr_ops, false, &masks);
 	mmap_read_unlock(&init_mm);
 
 	return ret;
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 9c8af31be970..16a58c860c74 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2523,7 +2523,7 @@ static inline void thp_split_mm(struct mm_struct *mm)
 
 	for_each_vma(vmi, vma) {
 		vm_flags_mod(vma, VM_NOHUGEPAGE, VM_HUGEPAGE);
-		walk_page_vma(vma, &thp_split_walk_ops, NULL);
+		walk_page_vma(vma, &thp_split_walk_ops, true, NULL);
 	}
 	mm->def_flags |= VM_NOHUGEPAGE;
 }
@@ -2584,7 +2584,7 @@ int s390_enable_sie(void)
 	mm->context.has_pgste = 1;
 	/* split thp mappings and disable thp for future mappings */
 	thp_split_mm(mm);
-	walk_page_range(mm, 0, TASK_SIZE, &zap_zero_walk_ops, NULL);
+	walk_page_range(mm, 0, TASK_SIZE, &zap_zero_walk_ops, true, NULL);
 	mmap_write_unlock(mm);
 	return 0;
 }
@@ -2672,7 +2672,7 @@ int s390_enable_skey(void)
 		mm->context.uses_skeys = 0;
 		goto out_up;
 	}
-	walk_page_range(mm, 0, TASK_SIZE, &enable_skey_walk_ops, NULL);
+	walk_page_range(mm, 0, TASK_SIZE, &enable_skey_walk_ops, true, NULL);
 
 out_up:
 	mmap_write_unlock(mm);
@@ -2697,7 +2697,7 @@ static const struct mm_walk_ops reset_cmma_walk_ops = {
 void s390_reset_cmma(struct mm_struct *mm)
 {
 	mmap_write_lock(mm);
-	walk_page_range(mm, 0, TASK_SIZE, &reset_cmma_walk_ops, NULL);
+	walk_page_range(mm, 0, TASK_SIZE, &reset_cmma_walk_ops, true, NULL);
 	mmap_write_unlock(mm);
 }
 EXPORT_SYMBOL_GPL(s390_reset_cmma);
@@ -2771,7 +2771,7 @@ int __s390_uv_destroy_range(struct mm_struct *mm, unsigned long start,
 	while (r > 0) {
 		state.count = 0;
 		mmap_read_lock(mm);
-		r = walk_page_range(mm, state.next, end, &gather_pages_ops, &state);
+		r = walk_page_range(mm, state.next, end, &gather_pages_ops, false, &state);
 		mmap_read_unlock(mm);
 		cond_resched();
 		s390_uv_destroy_pfns(state.count, state.pfns);
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 507cd4e59d07..f0d0f2959f91 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -804,9 +804,9 @@ static void smap_gather_stats(struct vm_area_struct *vma,
 
 	/* mmap_lock is held in m_start */
 	if (!start)
-		walk_page_vma(vma, ops, mss);
+		walk_page_vma(vma, ops, false, mss);
 	else
-		walk_page_range(vma->vm_mm, start, vma->vm_end, ops, mss);
+		walk_page_range(vma->vm_mm, start, vma->vm_end, ops, false, mss);
 }
 
 #define SEQ_PUT_DEC(str, val) \
@@ -1307,7 +1307,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 						0, mm, 0, -1UL);
 			mmu_notifier_invalidate_range_start(&range);
 		}
-		walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
+		walk_page_range(mm, 0, -1, &clear_refs_walk_ops, true, &cp);
 		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			mmu_notifier_invalidate_range_end(&range);
 			flush_tlb_mm(mm);
@@ -1720,7 +1720,7 @@ static ssize_t pagemap_read(struct file *file, char __user *buf,
 		ret = mmap_read_lock_killable(mm);
 		if (ret)
 			goto out_free;
-		ret = walk_page_range(mm, start_vaddr, end, &pagemap_ops, &pm);
+		ret = walk_page_range(mm, start_vaddr, end, &pagemap_ops, false, &pm);
 		mmap_read_unlock(mm);
 		start_vaddr = end;
 
@@ -1981,7 +1981,7 @@ static int show_numa_map(struct seq_file *m, void *v)
 		seq_puts(m, " huge");
 
 	/* mmap_lock is held by m_start */
-	walk_page_vma(vma, &show_numa_ops, md);
+	walk_page_vma(vma, &show_numa_ops, false, md);
 
 	if (!md->pages)
 		goto out;
diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 27a6df448ee5..69656ec44049 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -105,16 +105,16 @@ struct mm_walk {
 
 int walk_page_range(struct mm_struct *mm, unsigned long start,
 		unsigned long end, const struct mm_walk_ops *ops,
-		void *private);
+		bool lock_vma, void *private);
 int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 			  unsigned long end, const struct mm_walk_ops *ops,
 			  pgd_t *pgd,
 			  void *private);
 int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end, const struct mm_walk_ops *ops,
-			void *private);
+			bool lock_vma, void *private);
 int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
-		void *private);
+		  bool lock_vma, void *private);
 int walk_page_mapping(struct address_space *mapping, pgoff_t first_index,
 		      pgoff_t nr, const struct mm_walk_ops *ops,
 		      void *private);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 2fcc9731528a..54f50b1aefe4 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -391,7 +391,7 @@ static const struct mm_walk_ops damon_mkold_ops = {
 static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
 {
 	mmap_read_lock(mm);
-	walk_page_range(mm, addr, addr + 1, &damon_mkold_ops, NULL);
+	walk_page_range(mm, addr, addr + 1, &damon_mkold_ops, false, NULL);
 	mmap_read_unlock(mm);
 }
 
@@ -536,7 +536,7 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
 	};
 
 	mmap_read_lock(mm);
-	walk_page_range(mm, addr, addr + 1, &damon_young_ops, &arg);
+	walk_page_range(mm, addr, addr + 1, &damon_young_ops, false, &arg);
 	mmap_read_unlock(mm);
 	return arg.young;
 }
diff --git a/mm/hmm.c b/mm/hmm.c
index 855e25e59d8f..f94f5e268e40 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -600,7 +600,7 @@ int hmm_range_fault(struct hmm_range *range)
 					     range->notifier_seq))
 			return -EBUSY;
 		ret = walk_page_range(mm, hmm_vma_walk.last, range->end,
-				      &hmm_walk_ops, &hmm_vma_walk);
+				      &hmm_walk_ops, false, &hmm_vma_walk);
 		/*
 		 * When -EBUSY is returned the loop restarts with
 		 * hmm_vma_walk.last set to an address that has not been stored
diff --git a/mm/ksm.c b/mm/ksm.c
index ba266359da55..494a1f3fcb97 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -470,7 +470,7 @@ static const struct mm_walk_ops break_ksm_ops = {
  * of the process that owns 'vma'.  We also do not want to enforce
  * protection keys here anyway.
  */
-static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
+static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_vma)
 {
 	vm_fault_t ret = 0;
 
@@ -479,7 +479,7 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
 
 		cond_resched();
 		ksm_page = walk_page_range_vma(vma, addr, addr + 1,
-					       &break_ksm_ops, NULL);
+					       &break_ksm_ops, lock_vma, NULL);
 		if (WARN_ON_ONCE(ksm_page < 0))
 			return ksm_page;
 		if (!ksm_page)
@@ -565,7 +565,7 @@ static void break_cow(struct ksm_rmap_item *rmap_item)
 	mmap_read_lock(mm);
 	vma = find_mergeable_vma(mm, addr);
 	if (vma)
-		break_ksm(vma, addr);
+		break_ksm(vma, addr, false);
 	mmap_read_unlock(mm);
 }
 
@@ -871,7 +871,7 @@ static void remove_trailing_rmap_items(struct ksm_rmap_item **rmap_list)
  * in cmp_and_merge_page on one of the rmap_items we would be removing.
  */
 static int unmerge_ksm_pages(struct vm_area_struct *vma,
-			     unsigned long start, unsigned long end)
+			     unsigned long start, unsigned long end, bool lock_vma)
 {
 	unsigned long addr;
 	int err = 0;
@@ -882,7 +882,7 @@ static int unmerge_ksm_pages(struct vm_area_struct *vma,
 		if (signal_pending(current))
 			err = -ERESTARTSYS;
 		else
-			err = break_ksm(vma, addr);
+			err = break_ksm(vma, addr, lock_vma);
 	}
 	return err;
 }
@@ -1029,7 +1029,7 @@ static int unmerge_and_remove_all_rmap_items(void)
 			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
 				continue;
 			err = unmerge_ksm_pages(vma,
-						vma->vm_start, vma->vm_end);
+						vma->vm_start, vma->vm_end, false);
 			if (err)
 				goto error;
 		}
@@ -2530,7 +2530,7 @@ static int __ksm_del_vma(struct vm_area_struct *vma)
 		return 0;
 
 	if (vma->anon_vma) {
-		err = unmerge_ksm_pages(vma, vma->vm_start, vma->vm_end);
+		err = unmerge_ksm_pages(vma, vma->vm_start, vma->vm_end, true);
 		if (err)
 			return err;
 	}
@@ -2668,7 +2668,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 			return 0;		/* just ignore the advice */
 
 		if (vma->anon_vma) {
-			err = unmerge_ksm_pages(vma, start, end);
+			err = unmerge_ksm_pages(vma, start, end, true);
 			if (err)
 				return err;
 		}
diff --git a/mm/madvise.c b/mm/madvise.c
index 886f06066622..0e484111a1d2 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -287,7 +287,7 @@ static long madvise_willneed(struct vm_area_struct *vma,
 	*prev = vma;
 #ifdef CONFIG_SWAP
 	if (!file) {
-		walk_page_range(vma->vm_mm, start, end, &swapin_walk_ops, vma);
+		walk_page_range(vma->vm_mm, start, end, &swapin_walk_ops, false, vma);
 		lru_add_drain(); /* Push any new pages onto the LRU now */
 		return 0;
 	}
@@ -546,7 +546,7 @@ static void madvise_cold_page_range(struct mmu_gather *tlb,
 	};
 
 	tlb_start_vma(tlb, vma);
-	walk_page_range(vma->vm_mm, addr, end, &cold_walk_ops, &walk_private);
+	walk_page_range(vma->vm_mm, addr, end, &cold_walk_ops, false, &walk_private);
 	tlb_end_vma(tlb, vma);
 }
 
@@ -584,7 +584,7 @@ static void madvise_pageout_page_range(struct mmu_gather *tlb,
 	};
 
 	tlb_start_vma(tlb, vma);
-	walk_page_range(vma->vm_mm, addr, end, &cold_walk_ops, &walk_private);
+	walk_page_range(vma->vm_mm, addr, end, &cold_walk_ops, false, &walk_private);
 	tlb_end_vma(tlb, vma);
 }
 
@@ -786,7 +786,7 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
 	mmu_notifier_invalidate_range_start(&range);
 	tlb_start_vma(&tlb, vma);
 	walk_page_range(vma->vm_mm, range.start, range.end,
-			&madvise_free_walk_ops, &tlb);
+			&madvise_free_walk_ops, false, &tlb);
 	tlb_end_vma(&tlb, vma);
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_finish_mmu(&tlb);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e8ca4bdcb03c..76aaadbd4bf9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6031,7 +6031,7 @@ static unsigned long mem_cgroup_count_precharge(struct mm_struct *mm)
 	unsigned long precharge;
 
 	mmap_read_lock(mm);
-	walk_page_range(mm, 0, ULONG_MAX, &precharge_walk_ops, NULL);
+	walk_page_range(mm, 0, ULONG_MAX, &precharge_walk_ops, false, NULL);
 	mmap_read_unlock(mm);
 
 	precharge = mc.precharge;
@@ -6332,7 +6332,7 @@ static void mem_cgroup_move_charge(void)
 	 * When we have consumed all precharges and failed in doing
 	 * additional charge, the page walk just aborts.
 	 */
-	walk_page_range(mc.mm, 0, ULONG_MAX, &charge_walk_ops, NULL);
+	walk_page_range(mc.mm, 0, ULONG_MAX, &charge_walk_ops, false, NULL);
 	mmap_read_unlock(mc.mm);
 	atomic_dec(&mc.from->moving_account);
 }
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ece5d481b5ff..763297df9240 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -860,7 +860,7 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
 
 	mmap_read_lock(p->mm);
 	ret = walk_page_range(p->mm, 0, TASK_SIZE, &hwp_walk_ops,
-			      (void *)&priv);
+			      false, (void *)&priv);
 	if (ret == 1 && priv.tk.addr)
 		kill_proc(&priv.tk, pfn, flags);
 	else
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index c53f8beeb507..70ba53c70700 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -738,7 +738,7 @@ static const struct mm_walk_ops queue_pages_walk_ops = {
 static int
 queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
 		nodemask_t *nodes, unsigned long flags,
-		struct list_head *pagelist)
+		struct list_head *pagelist, bool lock_vma)
 {
 	int err;
 	struct queue_pages qp = {
@@ -750,7 +750,7 @@ queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
 		.first = NULL,
 	};
 
-	err = walk_page_range(mm, start, end, &queue_pages_walk_ops, &qp);
+	err = walk_page_range(mm, start, end, &queue_pages_walk_ops, lock_vma, &qp);
 
 	if (!qp.first)
 		/* whole range in hole */
@@ -1078,7 +1078,7 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 	vma = find_vma(mm, 0);
 	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)));
 	queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
-			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
+			flags | MPOL_MF_DISCONTIG_OK, &pagelist, false);
 
 	if (!list_empty(&pagelist)) {
 		err = migrate_pages(&pagelist, alloc_migration_target, NULL,
@@ -1321,12 +1321,8 @@ static long do_mbind(unsigned long start, unsigned long len,
 	 * Lock the VMAs before scanning for pages to migrate, to ensure we don't
 	 * miss a concurrently inserted page.
 	 */
-	vma_iter_init(&vmi, mm, start);
-	for_each_vma_range(vmi, vma, end)
-		vma_start_write(vma);
-
 	ret = queue_pages_range(mm, start, end, nmask,
-			  flags | MPOL_MF_INVERT, &pagelist);
+			  flags | MPOL_MF_INVERT, &pagelist, true);
 
 	if (ret < 0) {
 		err = ret;
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 8365158460ed..1bc9937bf1fb 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -304,7 +304,7 @@ static void migrate_vma_collect(struct migrate_vma *migrate)
 	mmu_notifier_invalidate_range_start(&range);
 
 	walk_page_range(migrate->vma->vm_mm, migrate->start, migrate->end,
-			&migrate_vma_walk_ops, migrate);
+			&migrate_vma_walk_ops, false, migrate);
 
 	mmu_notifier_invalidate_range_end(&range);
 	migrate->end = migrate->start + (migrate->npages << PAGE_SHIFT);
diff --git a/mm/mincore.c b/mm/mincore.c
index b7f7a516b26c..a06288c6c126 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -198,7 +198,7 @@ static long do_mincore(unsigned long addr, unsigned long pages, unsigned char *v
 		memset(vec, 1, pages);
 		return pages;
 	}
-	err = walk_page_range(vma->vm_mm, addr, end, &mincore_walk_ops, vec);
+	err = walk_page_range(vma->vm_mm, addr, end, &mincore_walk_ops, false, vec);
 	if (err < 0)
 		return err;
 	return (end - addr) >> PAGE_SHIFT;
diff --git a/mm/mlock.c b/mm/mlock.c
index 0a0c996c5c21..3634de0b28e3 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -389,7 +389,7 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
 	vm_flags_reset_once(vma, newflags);
 
 	lru_add_drain();
-	walk_page_range(vma->vm_mm, start, end, &mlock_walk_ops, NULL);
+	walk_page_range(vma->vm_mm, start, end, &mlock_walk_ops, true, NULL);
 	lru_add_drain();
 
 	if (newflags & VM_IO) {
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 6f658d483704..f781f709c39d 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -599,7 +599,7 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 		pgprot_t new_pgprot = vm_get_page_prot(newflags);
 
 		error = walk_page_range(current->mm, start, end,
-				&prot_none_walk_ops, &new_pgprot);
+				&prot_none_walk_ops, true, &new_pgprot);
 		if (error)
 			return error;
 	}
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 2022333805d3..7503885fae75 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -406,6 +406,7 @@ static int __walk_page_range(unsigned long start, unsigned long end,
  * @start:	start address of the virtual address range
  * @end:	end address of the virtual address range
  * @ops:	operation to call during the walk
+ * @lock_vma	write-lock the vma before operating on it
  * @private:	private data for callbacks' usage
  *
  * Recursively walk the page table tree of the process represented by @mm
@@ -442,7 +443,7 @@ static int __walk_page_range(unsigned long start, unsigned long end,
  */
 int walk_page_range(struct mm_struct *mm, unsigned long start,
 		unsigned long end, const struct mm_walk_ops *ops,
-		void *private)
+		bool lock_vma, void *private)
 {
 	int err = 0;
 	unsigned long next;
@@ -474,6 +475,8 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 			if (ops->pte_hole)
 				err = ops->pte_hole(start, next, -1, &walk);
 		} else { /* inside vma */
+			if (lock_vma)
+				vma_start_write(vma);
 			walk.vma = vma;
 			next = min(end, vma->vm_end);
 			vma = find_vma(mm, vma->vm_end);
@@ -535,7 +538,7 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 
 int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end, const struct mm_walk_ops *ops,
-			void *private)
+			bool lock_vma, void *private)
 {
 	struct mm_walk walk = {
 		.ops		= ops,
@@ -550,11 +553,13 @@ int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
 		return -EINVAL;
 
 	mmap_assert_locked(walk.mm);
+	if (lock_vma)
+		vma_start_write(vma);
 	return __walk_page_range(start, end, &walk);
 }
 
 int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
-		void *private)
+		  bool lock_vma, void *private)
 {
 	struct mm_walk walk = {
 		.ops		= ops,
@@ -567,6 +572,8 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 		return -EINVAL;
 
 	mmap_assert_locked(walk.mm);
+	if (lock_vma)
+		vma_start_write(vma);
 	return __walk_page_range(vma->vm_start, vma->vm_end, &walk);
 }
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1080209a568b..d85f86871fd9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4306,7 +4306,8 @@ static void walk_mm(struct lruvec *lruvec, struct mm_struct *mm, struct lru_gen_
 
 		/* the caller might be holding the lock for write */
 		if (mmap_read_trylock(mm)) {
-			err = walk_page_range(mm, walk->next_addr, ULONG_MAX, &mm_walk_ops, walk);
+			err = walk_page_range(mm, walk->next_addr, ULONG_MAX,
+					      &mm_walk_ops, false, walk);
 
 			mmap_read_unlock(mm);
 		}
-- 
2.41.0.487.g6d72f3e995-goog

