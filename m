Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8EA7D8D9B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 05:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345297AbjJ0DlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 23:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbjJ0Dko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 23:40:44 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94225170E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 20:40:16 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5b93ddb10b8so300922a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 20:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698378016; x=1698982816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ky4w3uAtFSkvxKCreCTuy48cfBYAXj8C3Bu1f6A1ISE=;
        b=iR7AfGiolMO0wCI8tmev6lBsE3Io897zDNZtnA1m6XQ7MxpBDOYswtpPELVgHmDrq4
         dQn2l05U70mcGhTNR/4mAsJlgiTfButxyBvN3efrT8l1vqxnHaz7ZXnWp5GTzjBvUJEI
         2j2w1K+OWWSNUhhxTZVMznD3ByP9z4sW/aNCggNu6pnHNFQikykqOm8PIdMewZjPbKB6
         Bum0b0koucpVaK6dz8Zxy8LovNl1nvDNFDVt13i18BAp8+LjJD5vf5nF/5EDJb3g2Xyt
         BLmBHDbY28szVfxjrmpHOcJSB93mnj5p6w1bPIOHNMqjoHnzSJ7Um6oFqSz3EqTQcqgk
         bipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698378016; x=1698982816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ky4w3uAtFSkvxKCreCTuy48cfBYAXj8C3Bu1f6A1ISE=;
        b=JHBXf84HF+HsaN7+B9iX+BOQGni0ZW2W7VZqW5zRSdp0HD/3l94uE+ghpP64LBlVUy
         u0PGFucX0K1z0vfoX58R55r1UjoZ2pQSfuykCGgxbwpm8VtP0Iabr3a4dXmJ4qT6CqK+
         VVHCxmlQzSgGM00tA9r02P6ojIJ7WN9mrS8KZCQ7CSDYfYhLDsalnzBDFBY8IBpEwuVC
         958kR5K9+zzp521ClK8Zob0LovP0w0PLClVWEsm1v+h4lQREGc5qA9ADlW+D91M3dzOC
         WhBraZ6nYrpv04QweLZC3Aj1UHk4K7zeuy451JsT+tidsi6G/8mvM4Edtek1tkIwJLNV
         rRkA==
X-Gm-Message-State: AOJu0Yz9ODJKvFgzFc4fe9toHeX/bNJFvZxE0IbFUT6oWoE1to/GKcZ8
        IzOK2GcyLo4aPPOMWQv+r5Q1zQ==
X-Google-Smtp-Source: AGHT+IFJRCeA+OUFMxyndHyvFf1XFZD0IulFfw6dGetvqF75UjjqNY1IEWlGGaZ1U8Eieo7P5Fin/w==
X-Received: by 2002:a17:90b:1bc6:b0:27d:4935:8d9a with SMTP id oa6-20020a17090b1bc600b0027d49358d9amr5489370pjb.4.1698378015924;
        Thu, 26 Oct 2023 20:40:15 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id ms19-20020a17090b235300b00267d9f4d340sm2345676pjb.44.2023.10.26.20.40.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Oct 2023 20:40:15 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com
Cc:     zhangpeng.00@bytedance.com, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 10/10] fork: Use __mt_dup() to duplicate maple tree in dup_mmap()
Date:   Fri, 27 Oct 2023 11:38:45 +0800
Message-Id: <20231027033845.90608-11-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231027033845.90608-1-zhangpeng.00@bytedance.com>
References: <20231027033845.90608-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dup_mmap(), using __mt_dup() to duplicate the old maple tree and then
directly replacing the entries of VMAs in the new maple tree can result
in better performance. __mt_dup() uses DFS pre-order to duplicate the
maple tree, so it is efficient.

The average time complexity of __mt_dup() is O(n), where n is the number
of VMAs. The proof of the time complexity is provided in the commit log
that introduces __mt_dup(). After duplicating the maple tree, each element
is traversed and replaced (ignoring the cases of deletion, which are rare).
Since it is only a replacement operation for each element, this process is
also O(n).

Analyzing the exact time complexity of the previous algorithm is
challenging because each insertion can involve appending to a node, pushing
data to adjacent nodes, or even splitting nodes. The frequency of each
action is difficult to calculate. The worst-case scenario for a single
insertion is when the tree undergoes splitting at every level. If we
consider each insertion as the worst-case scenario, we can determine that
the upper bound of the time complexity is O(n*log(n)), although this is a
loose upper bound. However, based on the test data, it appears that the
actual time complexity is likely to be O(n).

As the entire maple tree is duplicated using __mt_dup(), if dup_mmap()
fails, there will be a portion of VMAs that have not been duplicated in
the maple tree. To handle this, we mark the failure point with
XA_ZERO_ENTRY. In exit_mmap(), if this marker is encountered, stop
releasing VMAs that have not been duplicated after this point.

There is a "spawn" in byte-unixbench[1], which can be used to test the
performance of fork(). I modified it slightly to make it work with
different number of VMAs.

Below are the test results. The first row shows the number of VMAs.
The second and third rows show the number of fork() calls per ten seconds,
corresponding to next-20231006 and the this patchset, respectively. The
test results were obtained with CPU binding to avoid scheduler load
balancing that could cause unstable results. There are still some
fluctuations in the test results, but at least they are better than the
original performance.

21     121   221    421    821    1621   3221   6421   12821  25621  51221
112100 76261 54227  34035  20195  11112  6017   3161   1606   802    393
114558 83067 65008  45824  28751  16072  8922   4747   2436   1233   599
2.19%  8.92% 19.88% 34.64% 42.37% 44.64% 48.28% 50.17% 51.68% 53.74% 52.42%

[1] https://github.com/kdlucas/byte-unixbench/tree/master

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h | 11 +++++++++++
 kernel/fork.c      | 40 +++++++++++++++++++++++++++++-----------
 mm/internal.h      | 11 -----------
 mm/memory.c        |  7 ++++++-
 mm/mmap.c          |  9 ++++++---
 5 files changed, 52 insertions(+), 26 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 14d5aaff96d0..e9111ec5808c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -996,6 +996,17 @@ static inline int vma_iter_bulk_alloc(struct vma_iterator *vmi,
 	return mas_expected_entries(&vmi->mas, count);
 }
 
+static inline int vma_iter_clear_gfp(struct vma_iterator *vmi,
+			unsigned long start, unsigned long end, gfp_t gfp)
+{
+	__mas_set_range(&vmi->mas, start, end - 1);
+	mas_store_gfp(&vmi->mas, NULL, gfp);
+	if (unlikely(mas_is_err(&vmi->mas)))
+		return -ENOMEM;
+
+	return 0;
+}
+
 /* Free any unused preallocations */
 static inline void vma_iter_free(struct vma_iterator *vmi)
 {
diff --git a/kernel/fork.c b/kernel/fork.c
index 1e6c656e0857..1552ee66517b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -650,7 +650,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	int retval;
 	unsigned long charge = 0;
 	LIST_HEAD(uf);
-	VMA_ITERATOR(old_vmi, oldmm, 0);
 	VMA_ITERATOR(vmi, mm, 0);
 
 	uprobe_start_dup_mmap();
@@ -678,16 +677,22 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		goto out;
 	khugepaged_fork(mm, oldmm);
 
-	retval = vma_iter_bulk_alloc(&vmi, oldmm->map_count);
-	if (retval)
+	/* Use __mt_dup() to efficiently build an identical maple tree. */
+	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
+	if (unlikely(retval))
 		goto out;
 
 	mt_clear_in_rcu(vmi.mas.tree);
-	for_each_vma(old_vmi, mpnt) {
+	for_each_vma(vmi, mpnt) {
 		struct file *file;
 
 		vma_start_write(mpnt);
 		if (mpnt->vm_flags & VM_DONTCOPY) {
+			retval = vma_iter_clear_gfp(&vmi, mpnt->vm_start,
+						    mpnt->vm_end, GFP_KERNEL);
+			if (retval)
+				goto loop_out;
+
 			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
 			continue;
 		}
@@ -749,9 +754,11 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		if (is_vm_hugetlb_page(tmp))
 			hugetlb_dup_vma_private(tmp);
 
-		/* Link the vma into the MT */
-		if (vma_iter_bulk_store(&vmi, tmp))
-			goto fail_nomem_vmi_store;
+		/*
+		 * Link the vma into the MT. After using __mt_dup(), memory
+		 * allocation is not necessary here, so it cannot fail.
+		 */
+		vma_iter_bulk_store(&vmi, tmp);
 
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
@@ -760,15 +767,28 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		if (tmp->vm_ops && tmp->vm_ops->open)
 			tmp->vm_ops->open(tmp);
 
-		if (retval)
+		if (retval) {
+			mpnt = vma_next(&vmi);
 			goto loop_out;
+		}
 	}
 	/* a new mm has just been created */
 	retval = arch_dup_mmap(oldmm, mm);
 loop_out:
 	vma_iter_free(&vmi);
-	if (!retval)
+	if (!retval) {
 		mt_set_in_rcu(vmi.mas.tree);
+	} else if (mpnt) {
+		/*
+		 * The entire maple tree has already been duplicated. If the
+		 * mmap duplication fails, mark the failure point with
+		 * XA_ZERO_ENTRY. In exit_mmap(), if this marker is encountered,
+		 * stop releasing VMAs that have not been duplicated after this
+		 * point.
+		 */
+		mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
+		mas_store(&vmi.mas, XA_ZERO_ENTRY);
+	}
 out:
 	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
@@ -778,8 +798,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	uprobe_end_dup_mmap();
 	return retval;
 
-fail_nomem_vmi_store:
-	unlink_anon_vmas(tmp);
 fail_nomem_anon_vma_fork:
 	mpol_put(vma_policy(tmp));
 fail_nomem_policy:
diff --git a/mm/internal.h b/mm/internal.h
index b61034bd50f5..89a5a794d68f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1154,17 +1154,6 @@ static inline void vma_iter_clear(struct vma_iterator *vmi)
 	mas_store_prealloc(&vmi->mas, NULL);
 }
 
-static inline int vma_iter_clear_gfp(struct vma_iterator *vmi,
-			unsigned long start, unsigned long end, gfp_t gfp)
-{
-	__mas_set_range(&vmi->mas, start, end - 1);
-	mas_store_gfp(&vmi->mas, NULL, gfp);
-	if (unlikely(mas_is_err(&vmi->mas)))
-		return -ENOMEM;
-
-	return 0;
-}
-
 static inline struct vm_area_struct *vma_iter_load(struct vma_iterator *vmi)
 {
 	return mas_walk(&vmi->mas);
diff --git a/mm/memory.c b/mm/memory.c
index 1f18ed4a5497..20cc6e3586e7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -374,6 +374,8 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 		 * be 0.  This will underflow and is okay.
 		 */
 		next = mas_find(mas, ceiling - 1);
+		if (unlikely(xa_is_zero(next)))
+			next = NULL;
 
 		/*
 		 * Hide vma from rmap and truncate_pagecache before freeing
@@ -395,6 +397,8 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 			       && !is_vm_hugetlb_page(next)) {
 				vma = next;
 				next = mas_find(mas, ceiling - 1);
+				if (unlikely(xa_is_zero(next)))
+					next = NULL;
 				if (mm_wr_locked)
 					vma_start_write(vma);
 				unlink_anon_vmas(vma);
@@ -1743,7 +1747,8 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
 		unmap_single_vma(tlb, vma, start, end, &details,
 				 mm_wr_locked);
 		hugetlb_zap_end(vma, &details);
-	} while ((vma = mas_find(mas, tree_end - 1)) != NULL);
+		vma = mas_find(mas, tree_end - 1);
+	} while (vma && likely(!xa_is_zero(vma)));
 	mmu_notifier_invalidate_range_end(&range);
 }
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 984804d77ae1..e98e9715afb2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3300,10 +3300,11 @@ void exit_mmap(struct mm_struct *mm)
 	arch_exit_mmap(mm);
 
 	vma = mas_find(&mas, ULONG_MAX);
-	if (!vma) {
+	if (!vma || unlikely(xa_is_zero(vma))) {
 		/* Can happen if dup_mmap() received an OOM */
 		mmap_read_unlock(mm);
-		return;
+		mmap_write_lock(mm);
+		goto destroy;
 	}
 
 	lru_add_drain();
@@ -3338,11 +3339,13 @@ void exit_mmap(struct mm_struct *mm)
 		remove_vma(vma, true);
 		count++;
 		cond_resched();
-	} while ((vma = mas_find(&mas, ULONG_MAX)) != NULL);
+		vma = mas_find(&mas, ULONG_MAX);
+	} while (vma && likely(!xa_is_zero(vma)));
 
 	BUG_ON(count != mm->map_count);
 
 	trace_exit_mmap(mm);
+destroy:
 	__mt_destroy(&mm->mm_mt);
 	mmap_write_unlock(mm);
 	vm_unacct_memory(nr_accounted);
-- 
2.20.1

