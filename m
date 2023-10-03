Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5C07B6572
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239476AbjJCJ0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjJCJ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:26:53 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFA5AB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 02:26:46 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59bf1dde73fso8550567b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 02:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696325206; x=1696930006; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3qvCe1A/3kG45e5iAe6KCdJKaMNhAMxBLRsWH7ioZ0U=;
        b=Cb5yjeJDFwZJRM5xKZEe7TiR6F4ab1Cf0Iwm5z6pHjYJbisxnULBy1yT7m3d1NWajX
         uRkznjubPWg7RvoYHmbG+HZToyq4F004NUCDG+bTtdwZ5U+MBuGpo0eBvwZYu4OLIG/k
         0kTF9zwOr52wx42/MxvkzqqYXHwf7gWXnQr+6arqbEFe5+iXXt/H1lEkUD/q+llUqq4h
         Puc3DOIwgoUg723rgkmoXnaBmWEtiRUexGiKI0HEGuSYFWcE43sHf5ilzBZtP3VPyCvg
         CSxsjgTpTEZjwe9yhjQAgJa9D69Ffo3v/9v9HT1eDdk5Cd9FdXduTuU9KcQKPyudXT6m
         +6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696325206; x=1696930006;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qvCe1A/3kG45e5iAe6KCdJKaMNhAMxBLRsWH7ioZ0U=;
        b=Oa2+gw91I2myoZVTrBB2deJ4CFgVyi/G5TGR/L9IteOhWjLP7WZouqGUQfcnrObEby
         O+xrHBAddsStZcbCRfAUEmMeI0i8LjSEs4cRmKjCtLlwhkZFN1YWCwKSC98NHBPsKPEs
         /caIBThM7eCJPtpZuAcgoOF4L437IBpPKRz+WEmuQouoe1JIhxWJr0hvyeHhcyHtxiYi
         /mdB+Erej3lpauV2qVRe0bEaK7a4+IJ915X/6XVYDdZDvdhq1uqzPDYpcz0zBJW5jwGe
         Mea4E877TVJXcFhqSAk7US50maegIrzANlS/JHx4mC8Rb4qhnr88SxJKwXOpQBhSQ3fr
         EvZA==
X-Gm-Message-State: AOJu0YwRZG0pehxYVrA8hVRD25OO6ouzT2H8zHbjTbY9dnrPu3qxI4P1
        BlgHSWsIuMHlHr+W3Cri9y/X1g==
X-Google-Smtp-Source: AGHT+IEiJBMPsx5lZyUfrAW2d97Mf6lLD0VXN7F7UoDg63fILqX2qt+2gRYWSAcMyi0o5mfws8q+uA==
X-Received: by 2002:a0d:eb16:0:b0:59c:8b3:6850 with SMTP id u22-20020a0deb16000000b0059c08b36850mr14504709ywe.4.1696325205371;
        Tue, 03 Oct 2023 02:26:45 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h4-20020a0df704000000b0058fc7604f45sm252385ywf.130.2023.10.03.02.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 02:26:44 -0700 (PDT)
Date:   Tue, 3 Oct 2023 02:26:42 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Andi Kleen <ak@linux.intel.com>, Christoph Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 10/12] mempolicy: alloc_pages_mpol() for NUMA policy
 without vma
In-Reply-To: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
Message-ID: <74e34633-6060-f5e3-aee-7040d43f2e93@google.com>
References: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shrink shmem's stack usage by eliminating the pseudo-vma from its folio
allocation.  alloc_pages_mpol(gfp, order, pol, ilx, nid) becomes the
principal actor for passing mempolicy choice down to __alloc_pages(),
rather than vma_alloc_folio(gfp, order, vma, addr, hugepage).

vma_alloc_folio() and alloc_pages() remain, but as wrappers around
alloc_pages_mpol().  alloc_pages_bulk_*() untouched, except to provide
the additional args to policy_nodemask(), which subsumes policy_node().
Cleanup throughout, cutting out some unhelpful "helpers".

It would all be much simpler without MPOL_INTERLEAVE, but that adds a
dynamic to the constant mpol: complicated by v3.6 commit 09c231cb8bfd
("tmpfs: distribute interleave better across nodes"), which added ino
bias to the interleave, hidden from mm/mempolicy.c until this commit.

Hence "ilx" throughout, the "interleave index".  Originally I thought it
could be done just with nid, but that's wrong: the nodemask may come from
the shared policy layer below a shmem vma, or it may come from the task
layer above a shmem vma; and without the final nodemask then nodeid
cannot be decided.  And how ilx is applied depends also on page order.

The interleave index is almost always irrelevant unless MPOL_INTERLEAVE:
with one exception in alloc_pages_mpol(), where the NO_INTERLEAVE_INDEX
passed down from vma-less alloc_pages() is also used as hint not to use
THP-style hugepage allocation - to avoid the overhead of a hugepage arg
(though I don't understand why we never just added a GFP bit for THP -
if it actually needs a different allocation strategy from other pages of
the same order).  vma_alloc_folio() still carries its hugepage arg here,
but it is not used, and should be removed when agreed.

get_vma_policy() no longer allows a NULL vma: over time I believe we've
eradicated all the places which used to need it e.g. swapoff and madvise
used to pass NULL vma to read_swap_cache_async(), but now know the vma.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 fs/proc/task_mmu.c        |   5 +-
 include/linux/gfp.h       |  10 +-
 include/linux/mempolicy.h |  13 +-
 include/linux/mm.h        |   2 +-
 ipc/shm.c                 |  21 +--
 mm/mempolicy.c            | 383 +++++++++++++++++-----------------------
 mm/shmem.c                |  92 +++++-----
 mm/swap.h                 |   9 +-
 mm/swap_state.c           |  83 +++++----
 9 files changed, 297 insertions(+), 321 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5a302f1b8d68..6cc4720eabf0 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2637,8 +2637,9 @@ static int show_numa_map(struct seq_file *m, void *v)
 	struct numa_maps *md = &numa_priv->md;
 	struct file *file = vma->vm_file;
 	struct mm_struct *mm = vma->vm_mm;
-	struct mempolicy *pol;
 	char buffer[64];
+	struct mempolicy *pol;
+	pgoff_t ilx;
 	int nid;
 
 	if (!mm)
@@ -2647,7 +2648,7 @@ static int show_numa_map(struct seq_file *m, void *v)
 	/* Ensure we start with an empty set of numa_maps statistics. */
 	memset(md, 0, sizeof(*md));
 
-	pol = __get_vma_policy(vma, vma->vm_start);
+	pol = __get_vma_policy(vma, vma->vm_start, &ilx);
 	if (pol) {
 		mpol_to_str(buffer, sizeof(buffer), pol);
 		mpol_cond_put(pol);
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 5b917e5b9350..de292a007138 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -8,6 +8,7 @@
 #include <linux/topology.h>
 
 struct vm_area_struct;
+struct mempolicy;
 
 /* Convert GFP flags to their corresponding migrate type */
 #define GFP_MOVABLE_MASK (__GFP_RECLAIMABLE|__GFP_MOVABLE)
@@ -262,7 +263,9 @@ static inline struct page *alloc_pages_node(int nid, gfp_t gfp_mask,
 
 #ifdef CONFIG_NUMA
 struct page *alloc_pages(gfp_t gfp, unsigned int order);
-struct folio *folio_alloc(gfp_t gfp, unsigned order);
+struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
+		struct mempolicy *mpol, pgoff_t ilx, int nid);
+struct folio *folio_alloc(gfp_t gfp, unsigned int order);
 struct folio *vma_alloc_folio(gfp_t gfp, int order, struct vm_area_struct *vma,
 		unsigned long addr, bool hugepage);
 #else
@@ -270,6 +273,11 @@ static inline struct page *alloc_pages(gfp_t gfp_mask, unsigned int order)
 {
 	return alloc_pages_node(numa_node_id(), gfp_mask, order);
 }
+static inline struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
+		struct mempolicy *mpol, pgoff_t ilx, int nid)
+{
+	return alloc_pages(gfp, order);
+}
 static inline struct folio *folio_alloc(gfp_t gfp, unsigned int order)
 {
 	return __folio_alloc_node(gfp, order, numa_node_id());
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index c69f9480d5e4..3c208d4f0ee9 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -128,7 +128,9 @@ struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
 
 struct mempolicy *get_task_policy(struct task_struct *p);
 struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
-		unsigned long addr);
+		unsigned long addr, pgoff_t *ilx);
+struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
+		unsigned long addr, int order, pgoff_t *ilx);
 bool vma_policy_mof(struct vm_area_struct *vma);
 
 extern void numa_default_policy(void);
@@ -142,8 +144,6 @@ extern int huge_node(struct vm_area_struct *vma,
 extern bool init_nodemask_of_mempolicy(nodemask_t *mask);
 extern bool mempolicy_in_oom_domain(struct task_struct *tsk,
 				const nodemask_t *mask);
-extern nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy);
-
 extern unsigned int mempolicy_slab_node(void);
 
 extern enum zone_type policy_zone;
@@ -215,6 +215,13 @@ mpol_shared_policy_lookup(struct shared_policy *sp, pgoff_t idx)
 	return NULL;
 }
 
+static inline struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
+				unsigned long addr, int order, pgoff_t *ilx)
+{
+	*ilx = 0;
+	return NULL;
+}
+
 #define vma_policy(vma) NULL
 
 static inline int
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52c40b3d0813..9b86a9c35427 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -619,7 +619,7 @@ struct vm_operations_struct {
 	 * policy.
 	 */
 	struct mempolicy *(*get_policy)(struct vm_area_struct *vma,
-					unsigned long addr);
+					unsigned long addr, pgoff_t *ilx);
 #endif
 	/*
 	 * Called by vm_normal_page() for special PTEs to find the
diff --git a/ipc/shm.c b/ipc/shm.c
index 576a543b7cff..222aaf035afb 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -562,30 +562,25 @@ static unsigned long shm_pagesize(struct vm_area_struct *vma)
 }
 
 #ifdef CONFIG_NUMA
-static int shm_set_policy(struct vm_area_struct *vma, struct mempolicy *new)
+static int shm_set_policy(struct vm_area_struct *vma, struct mempolicy *mpol)
 {
-	struct file *file = vma->vm_file;
-	struct shm_file_data *sfd = shm_file_data(file);
+	struct shm_file_data *sfd = shm_file_data(vma->vm_file);
 	int err = 0;
 
 	if (sfd->vm_ops->set_policy)
-		err = sfd->vm_ops->set_policy(vma, new);
+		err = sfd->vm_ops->set_policy(vma, mpol);
 	return err;
 }
 
 static struct mempolicy *shm_get_policy(struct vm_area_struct *vma,
-					unsigned long addr)
+					unsigned long addr, pgoff_t *ilx)
 {
-	struct file *file = vma->vm_file;
-	struct shm_file_data *sfd = shm_file_data(file);
-	struct mempolicy *pol = NULL;
+	struct shm_file_data *sfd = shm_file_data(vma->vm_file);
+	struct mempolicy *mpol = vma->vm_policy;
 
 	if (sfd->vm_ops->get_policy)
-		pol = sfd->vm_ops->get_policy(vma, addr);
-	else if (vma->vm_policy)
-		pol = vma->vm_policy;
-
-	return pol;
+		mpol = sfd->vm_ops->get_policy(vma, addr, ilx);
+	return mpol;
 }
 #endif
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index bfcc523a2860..8cf76de12acd 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -114,6 +114,8 @@
 #define MPOL_MF_INVERT       (MPOL_MF_INTERNAL << 1)	/* Invert check for nodemask */
 #define MPOL_MF_WRLOCK       (MPOL_MF_INTERNAL << 2)	/* Write-lock walked vmas */
 
+#define NO_INTERLEAVE_INDEX (-1UL)
+
 static struct kmem_cache *policy_cache;
 static struct kmem_cache *sn_cache;
 
@@ -918,6 +920,7 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 	}
 
 	if (flags & MPOL_F_ADDR) {
+		pgoff_t ilx;		/* ignored here */
 		/*
 		 * Do NOT fall back to task policy if the
 		 * vma/shared policy at addr is NULL.  We
@@ -929,10 +932,7 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 			mmap_read_unlock(mm);
 			return -EFAULT;
 		}
-		if (vma->vm_ops && vma->vm_ops->get_policy)
-			pol = vma->vm_ops->get_policy(vma, addr);
-		else
-			pol = vma->vm_policy;
+		pol = __get_vma_policy(vma, addr, &ilx);
 	} else if (addr)
 		return -EINVAL;
 
@@ -1190,6 +1190,15 @@ static struct folio *new_folio(struct folio *src, unsigned long start)
 			break;
 	}
 
+	/*
+	 * __get_vma_policy() now expects a genuine non-NULL vma. Return NULL
+	 * when the page can no longer be located in a vma: that is not ideal
+	 * (migrate_pages() will give up early, presuming ENOMEM), but good
+	 * enough to avoid a crash by syzkaller or concurrent holepunch.
+	 */
+	if (!vma)
+		return NULL;
+
 	if (folio_test_hugetlb(src)) {
 		return alloc_hugetlb_folio_vma(folio_hstate(src),
 				vma, address);
@@ -1198,9 +1207,6 @@ static struct folio *new_folio(struct folio *src, unsigned long start)
 	if (folio_test_large(src))
 		gfp = GFP_TRANSHUGE;
 
-	/*
-	 * if !vma, vma_alloc_folio() will use task or system default policy
-	 */
 	return vma_alloc_folio(gfp, folio_order(src), vma, address,
 			folio_test_large(src));
 }
@@ -1710,34 +1716,19 @@ bool vma_migratable(struct vm_area_struct *vma)
 }
 
 struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
-						unsigned long addr)
+				   unsigned long addr, pgoff_t *ilx)
 {
-	struct mempolicy *pol = NULL;
-
-	if (vma) {
-		if (vma->vm_ops && vma->vm_ops->get_policy) {
-			pol = vma->vm_ops->get_policy(vma, addr);
-		} else if (vma->vm_policy) {
-			pol = vma->vm_policy;
-
-			/*
-			 * shmem_alloc_page() passes MPOL_F_SHARED policy with
-			 * a pseudo vma whose vma->vm_ops=NULL. Take a reference
-			 * count on these policies which will be dropped by
-			 * mpol_cond_put() later
-			 */
-			if (mpol_needs_cond_ref(pol))
-				mpol_get(pol);
-		}
-	}
-
-	return pol;
+	*ilx = 0;
+	return (vma->vm_ops && vma->vm_ops->get_policy) ?
+		vma->vm_ops->get_policy(vma, addr, ilx) : vma->vm_policy;
 }
 
 /*
- * get_vma_policy(@vma, @addr)
+ * get_vma_policy(@vma, @addr, @order, @ilx)
  * @vma: virtual memory area whose policy is sought
  * @addr: address in @vma for shared policy lookup
+ * @order: 0, or appropriate huge_page_order for interleaving
+ * @ilx: interleave index (output), for use only when MPOL_INTERLEAVE
  *
  * Returns effective policy for a VMA at specified address.
  * Falls back to current->mempolicy or system default policy, as necessary.
@@ -1746,14 +1737,18 @@ struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
  * freeing by another task.  It is the caller's responsibility to free the
  * extra reference for shared policies.
  */
-static struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
-						unsigned long addr)
+struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
+				 unsigned long addr, int order, pgoff_t *ilx)
 {
-	struct mempolicy *pol = __get_vma_policy(vma, addr);
+	struct mempolicy *pol;
 
+	pol = __get_vma_policy(vma, addr, ilx);
 	if (!pol)
 		pol = get_task_policy(current);
-
+	if (pol->mode == MPOL_INTERLEAVE) {
+		*ilx += vma->vm_pgoff >> order;
+		*ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);
+	}
 	return pol;
 }
 
@@ -1763,8 +1758,9 @@ bool vma_policy_mof(struct vm_area_struct *vma)
 
 	if (vma->vm_ops && vma->vm_ops->get_policy) {
 		bool ret = false;
+		pgoff_t ilx;		/* ignored here */
 
-		pol = vma->vm_ops->get_policy(vma, vma->vm_start);
+		pol = vma->vm_ops->get_policy(vma, vma->vm_start, &ilx);
 		if (pol && (pol->flags & MPOL_F_MOF))
 			ret = true;
 		mpol_cond_put(pol);
@@ -1799,54 +1795,6 @@ bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
 	return zone >= dynamic_policy_zone;
 }
 
-/*
- * Return a nodemask representing a mempolicy for filtering nodes for
- * page allocation
- */
-nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
-{
-	int mode = policy->mode;
-
-	/* Lower zones don't get a nodemask applied for MPOL_BIND */
-	if (unlikely(mode == MPOL_BIND) &&
-		apply_policy_zone(policy, gfp_zone(gfp)) &&
-		cpuset_nodemask_valid_mems_allowed(&policy->nodes))
-		return &policy->nodes;
-
-	if (mode == MPOL_PREFERRED_MANY)
-		return &policy->nodes;
-
-	return NULL;
-}
-
-/*
- * Return the  preferred node id for 'prefer' mempolicy, and return
- * the given id for all other policies.
- *
- * policy_node() is always coupled with policy_nodemask(), which
- * secures the nodemask limit for 'bind' and 'prefer-many' policy.
- */
-static int policy_node(gfp_t gfp, struct mempolicy *policy, int nid)
-{
-	if (policy->mode == MPOL_PREFERRED) {
-		nid = first_node(policy->nodes);
-	} else {
-		/*
-		 * __GFP_THISNODE shouldn't even be used with the bind policy
-		 * because we might easily break the expectation to stay on the
-		 * requested node and not break the policy.
-		 */
-		WARN_ON_ONCE(policy->mode == MPOL_BIND && (gfp & __GFP_THISNODE));
-	}
-
-	if ((policy->mode == MPOL_BIND ||
-	     policy->mode == MPOL_PREFERRED_MANY) &&
-	    policy->home_node != NUMA_NO_NODE)
-		return policy->home_node;
-
-	return nid;
-}
-
 /* Do dynamic interleaving for a process */
 static unsigned int interleave_nodes(struct mempolicy *policy)
 {
@@ -1906,11 +1854,11 @@ unsigned int mempolicy_slab_node(void)
 }
 
 /*
- * Do static interleaving for a VMA with known offset @n.  Returns the n'th
- * node in pol->nodes (starting from n=0), wrapping around if n exceeds the
- * number of present nodes.
+ * Do static interleaving for interleave index @ilx.  Returns the ilx'th
+ * node in pol->nodes (starting from ilx=0), wrapping around if ilx
+ * exceeds the number of present nodes.
  */
-static unsigned offset_il_node(struct mempolicy *pol, unsigned long n)
+static unsigned int interleave_nid(struct mempolicy *pol, pgoff_t ilx)
 {
 	nodemask_t nodemask = pol->nodes;
 	unsigned int target, nnodes;
@@ -1928,33 +1876,54 @@ static unsigned offset_il_node(struct mempolicy *pol, unsigned long n)
 	nnodes = nodes_weight(nodemask);
 	if (!nnodes)
 		return numa_node_id();
-	target = (unsigned int)n % nnodes;
+	target = ilx % nnodes;
 	nid = first_node(nodemask);
 	for (i = 0; i < target; i++)
 		nid = next_node(nid, nodemask);
 	return nid;
 }
 
-/* Determine a node number for interleave */
-static inline unsigned interleave_nid(struct mempolicy *pol,
-		 struct vm_area_struct *vma, unsigned long addr, int shift)
+/*
+ * Return a nodemask representing a mempolicy for filtering nodes for
+ * page allocation, together with preferred node id (or the input node id).
+ */
+static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
+				   pgoff_t ilx, int *nid)
 {
-	if (vma) {
-		unsigned long off;
+	nodemask_t *nodemask = NULL;
 
+	switch (pol->mode) {
+	case MPOL_PREFERRED:
+		/* Override input node id */
+		*nid = first_node(pol->nodes);
+		break;
+	case MPOL_PREFERRED_MANY:
+		nodemask = &pol->nodes;
+		if (pol->home_node != NUMA_NO_NODE)
+			*nid = pol->home_node;
+		break;
+	case MPOL_BIND:
+		/* Restrict to nodemask (but not on lower zones) */
+		if (apply_policy_zone(pol, gfp_zone(gfp)) &&
+		    cpuset_nodemask_valid_mems_allowed(&pol->nodes))
+			nodemask = &pol->nodes;
+		if (pol->home_node != NUMA_NO_NODE)
+			*nid = pol->home_node;
 		/*
-		 * for small pages, there is no difference between
-		 * shift and PAGE_SHIFT, so the bit-shift is safe.
-		 * for huge pages, since vm_pgoff is in units of small
-		 * pages, we need to shift off the always 0 bits to get
-		 * a useful offset.
+		 * __GFP_THISNODE shouldn't even be used with the bind policy
+		 * because we might easily break the expectation to stay on the
+		 * requested node and not break the policy.
 		 */
-		BUG_ON(shift < PAGE_SHIFT);
-		off = vma->vm_pgoff >> (shift - PAGE_SHIFT);
-		off += (addr - vma->vm_start) >> shift;
-		return offset_il_node(pol, off);
-	} else
-		return interleave_nodes(pol);
+		WARN_ON_ONCE(gfp & __GFP_THISNODE);
+		break;
+	case MPOL_INTERLEAVE:
+		/* Override input node id */
+		*nid = (ilx == NO_INTERLEAVE_INDEX) ?
+			interleave_nodes(pol) : interleave_nid(pol, ilx);
+		break;
+	}
+
+	return nodemask;
 }
 
 #ifdef CONFIG_HUGETLBFS
@@ -1970,27 +1939,16 @@ static inline unsigned interleave_nid(struct mempolicy *pol,
  * to the struct mempolicy for conditional unref after allocation.
  * If the effective policy is 'bind' or 'prefer-many', returns a pointer
  * to the mempolicy's @nodemask for filtering the zonelist.
- *
- * Must be protected by read_mems_allowed_begin()
  */
 int huge_node(struct vm_area_struct *vma, unsigned long addr, gfp_t gfp_flags,
-				struct mempolicy **mpol, nodemask_t **nodemask)
+		struct mempolicy **mpol, nodemask_t **nodemask)
 {
+	pgoff_t ilx;
 	int nid;
-	int mode;
 
-	*mpol = get_vma_policy(vma, addr);
-	*nodemask = NULL;
-	mode = (*mpol)->mode;
-
-	if (unlikely(mode == MPOL_INTERLEAVE)) {
-		nid = interleave_nid(*mpol, vma, addr,
-					huge_page_shift(hstate_vma(vma)));
-	} else {
-		nid = policy_node(gfp_flags, *mpol, numa_node_id());
-		if (mode == MPOL_BIND || mode == MPOL_PREFERRED_MANY)
-			*nodemask = &(*mpol)->nodes;
-	}
+	nid = numa_node_id();
+	*mpol = get_vma_policy(vma, addr, hstate_vma(vma)->order, &ilx);
+	*nodemask = policy_nodemask(gfp_flags, *mpol, ilx, &nid);
 	return nid;
 }
 
@@ -2068,27 +2026,8 @@ bool mempolicy_in_oom_domain(struct task_struct *tsk,
 	return ret;
 }
 
-/* Allocate a page in interleaved policy.
-   Own path because it needs to do special accounting. */
-static struct page *alloc_page_interleave(gfp_t gfp, unsigned order,
-					unsigned nid)
-{
-	struct page *page;
-
-	page = __alloc_pages(gfp, order, nid, NULL);
-	/* skip NUMA_INTERLEAVE_HIT counter update if numa stats is disabled */
-	if (!static_branch_likely(&vm_numa_stat_key))
-		return page;
-	if (page && page_to_nid(page) == nid) {
-		preempt_disable();
-		__count_numa_event(page_zone(page), NUMA_INTERLEAVE_HIT);
-		preempt_enable();
-	}
-	return page;
-}
-
 static struct page *alloc_pages_preferred_many(gfp_t gfp, unsigned int order,
-						int nid, struct mempolicy *pol)
+						int nid, nodemask_t *nodemask)
 {
 	struct page *page;
 	gfp_t preferred_gfp;
@@ -2101,7 +2040,7 @@ static struct page *alloc_pages_preferred_many(gfp_t gfp, unsigned int order,
 	 */
 	preferred_gfp = gfp | __GFP_NOWARN;
 	preferred_gfp &= ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
-	page = __alloc_pages(preferred_gfp, order, nid, &pol->nodes);
+	page = __alloc_pages(preferred_gfp, order, nid, nodemask);
 	if (!page)
 		page = __alloc_pages(gfp, order, nid, NULL);
 
@@ -2109,55 +2048,29 @@ static struct page *alloc_pages_preferred_many(gfp_t gfp, unsigned int order,
 }
 
 /**
- * vma_alloc_folio - Allocate a folio for a VMA.
+ * alloc_pages_mpol - Allocate pages according to NUMA mempolicy.
  * @gfp: GFP flags.
- * @order: Order of the folio.
- * @vma: Pointer to VMA or NULL if not available.
- * @addr: Virtual address of the allocation.  Must be inside @vma.
- * @hugepage: For hugepages try only the preferred node if possible.
+ * @order: Order of the page allocation.
+ * @pol: Pointer to the NUMA mempolicy.
+ * @ilx: Index for interleave mempolicy (also distinguishes alloc_pages()).
+ * @nid: Preferred node (usually numa_node_id() but @mpol may override it).
  *
- * Allocate a folio for a specific address in @vma, using the appropriate
- * NUMA policy.  When @vma is not NULL the caller must hold the mmap_lock
- * of the mm_struct of the VMA to prevent it from going away.  Should be
- * used for all allocations for folios that will be mapped into user space.
- *
- * Return: The folio on success or NULL if allocation fails.
+ * Return: The page on success or NULL if allocation fails.
  */
-struct folio *vma_alloc_folio(gfp_t gfp, int order, struct vm_area_struct *vma,
-		unsigned long addr, bool hugepage)
+struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
+		struct mempolicy *pol, pgoff_t ilx, int nid)
 {
-	struct mempolicy *pol;
-	int node = numa_node_id();
-	struct folio *folio;
-	int preferred_nid;
-	nodemask_t *nmask;
+	nodemask_t *nodemask;
+	struct page *page;
 
-	pol = get_vma_policy(vma, addr);
+	nodemask = policy_nodemask(gfp, pol, ilx, &nid);
 
-	if (pol->mode == MPOL_INTERLEAVE) {
-		struct page *page;
-		unsigned nid;
-
-		nid = interleave_nid(pol, vma, addr, PAGE_SHIFT + order);
-		mpol_cond_put(pol);
-		gfp |= __GFP_COMP;
-		page = alloc_page_interleave(gfp, order, nid);
-		return page_rmappable_folio(page);
-	}
-
-	if (pol->mode == MPOL_PREFERRED_MANY) {
-		struct page *page;
-
-		node = policy_node(gfp, pol, node);
-		gfp |= __GFP_COMP;
-		page = alloc_pages_preferred_many(gfp, order, node, pol);
-		mpol_cond_put(pol);
-		return page_rmappable_folio(page);
-	}
-
-	if (unlikely(IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && hugepage)) {
-		int hpage_node = node;
+	if (pol->mode == MPOL_PREFERRED_MANY)
+		return alloc_pages_preferred_many(gfp, order, nid, nodemask);
 
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
+	    /* filter "hugepage" allocation, unless from alloc_pages() */
+	    order == HPAGE_PMD_ORDER && ilx != NO_INTERLEAVE_INDEX) {
 		/*
 		 * For hugepage allocation and non-interleave policy which
 		 * allows the current node (or other explicitly preferred
@@ -2168,39 +2081,68 @@ struct folio *vma_alloc_folio(gfp_t gfp, int order, struct vm_area_struct *vma,
 		 * If the policy is interleave or does not allow the current
 		 * node in its nodemask, we allocate the standard way.
 		 */
-		if (pol->mode == MPOL_PREFERRED)
-			hpage_node = first_node(pol->nodes);
-
-		nmask = policy_nodemask(gfp, pol);
-		if (!nmask || node_isset(hpage_node, *nmask)) {
-			mpol_cond_put(pol);
+		if (pol->mode != MPOL_INTERLEAVE &&
+		    (!nodemask || node_isset(nid, *nodemask))) {
 			/*
 			 * First, try to allocate THP only on local node, but
 			 * don't reclaim unnecessarily, just compact.
 			 */
-			folio = __folio_alloc_node(gfp | __GFP_THISNODE |
-					__GFP_NORETRY, order, hpage_node);
-
+			page = __alloc_pages_node(nid,
+				gfp | __GFP_THISNODE | __GFP_NORETRY, order);
+			if (page || !(gfp & __GFP_DIRECT_RECLAIM))
+				return page;
 			/*
 			 * If hugepage allocations are configured to always
 			 * synchronous compact or the vma has been madvised
 			 * to prefer hugepage backing, retry allowing remote
 			 * memory with both reclaim and compact as well.
 			 */
-			if (!folio && (gfp & __GFP_DIRECT_RECLAIM))
-				folio = __folio_alloc(gfp, order, hpage_node,
-						      nmask);
-
-			goto out;
 		}
 	}
 
-	nmask = policy_nodemask(gfp, pol);
-	preferred_nid = policy_node(gfp, pol, node);
-	folio = __folio_alloc(gfp, order, preferred_nid, nmask);
+	page = __alloc_pages(gfp, order, nid, nodemask);
+
+	if (unlikely(pol->mode == MPOL_INTERLEAVE) && page) {
+		/* skip NUMA_INTERLEAVE_HIT update if numa stats is disabled */
+		if (static_branch_likely(&vm_numa_stat_key) &&
+		    page_to_nid(page) == nid) {
+			preempt_disable();
+			__count_numa_event(page_zone(page), NUMA_INTERLEAVE_HIT);
+			preempt_enable();
+		}
+	}
+
+	return page;
+}
+
+/**
+ * vma_alloc_folio - Allocate a folio for a VMA.
+ * @gfp: GFP flags.
+ * @order: Order of the folio.
+ * @vma: Pointer to VMA.
+ * @addr: Virtual address of the allocation.  Must be inside @vma.
+ * @hugepage: Unused (was: For hugepages try only preferred node if possible).
+ *
+ * Allocate a folio for a specific address in @vma, using the appropriate
+ * NUMA policy.  The caller must hold the mmap_lock of the mm_struct of the
+ * VMA to prevent it from going away.  Should be used for all allocations
+ * for folios that will be mapped into user space, excepting hugetlbfs, and
+ * excepting where direct use of alloc_pages_mpol() is more appropriate.
+ *
+ * Return: The folio on success or NULL if allocation fails.
+ */
+struct folio *vma_alloc_folio(gfp_t gfp, int order, struct vm_area_struct *vma,
+		unsigned long addr, bool hugepage)
+{
+	struct mempolicy *pol;
+	pgoff_t ilx;
+	struct page *page;
+
+	pol = get_vma_policy(vma, addr, order, &ilx);
+	page = alloc_pages_mpol(gfp | __GFP_COMP, order,
+				pol, ilx, numa_node_id());
 	mpol_cond_put(pol);
-out:
-	return folio;
+	return page_rmappable_folio(page);
 }
 EXPORT_SYMBOL(vma_alloc_folio);
 
@@ -2218,33 +2160,23 @@ EXPORT_SYMBOL(vma_alloc_folio);
  * flags are used.
  * Return: The page on success or NULL if allocation fails.
  */
-struct page *alloc_pages(gfp_t gfp, unsigned order)
+struct page *alloc_pages(gfp_t gfp, unsigned int order)
 {
 	struct mempolicy *pol = &default_policy;
-	struct page *page;
-
-	if (!in_interrupt() && !(gfp & __GFP_THISNODE))
-		pol = get_task_policy(current);
 
 	/*
 	 * No reference counting needed for current->mempolicy
 	 * nor system default_policy
 	 */
-	if (pol->mode == MPOL_INTERLEAVE)
-		page = alloc_page_interleave(gfp, order, interleave_nodes(pol));
-	else if (pol->mode == MPOL_PREFERRED_MANY)
-		page = alloc_pages_preferred_many(gfp, order,
-				  policy_node(gfp, pol, numa_node_id()), pol);
-	else
-		page = __alloc_pages(gfp, order,
-				policy_node(gfp, pol, numa_node_id()),
-				policy_nodemask(gfp, pol));
+	if (!in_interrupt() && !(gfp & __GFP_THISNODE))
+		pol = get_task_policy(current);
 
-	return page;
+	return alloc_pages_mpol(gfp, order,
+				pol, NO_INTERLEAVE_INDEX, numa_node_id());
 }
 EXPORT_SYMBOL(alloc_pages);
 
-struct folio *folio_alloc(gfp_t gfp, unsigned order)
+struct folio *folio_alloc(gfp_t gfp, unsigned int order)
 {
 	return page_rmappable_folio(alloc_pages(gfp | __GFP_COMP, order));
 }
@@ -2315,6 +2247,8 @@ unsigned long alloc_pages_bulk_array_mempolicy(gfp_t gfp,
 		unsigned long nr_pages, struct page **page_array)
 {
 	struct mempolicy *pol = &default_policy;
+	nodemask_t *nodemask;
+	int nid;
 
 	if (!in_interrupt() && !(gfp & __GFP_THISNODE))
 		pol = get_task_policy(current);
@@ -2327,9 +2261,10 @@ unsigned long alloc_pages_bulk_array_mempolicy(gfp_t gfp,
 		return alloc_pages_bulk_array_preferred_many(gfp,
 				numa_node_id(), pol, nr_pages, page_array);
 
-	return __alloc_pages_bulk(gfp, policy_node(gfp, pol, numa_node_id()),
-				  policy_nodemask(gfp, pol), nr_pages, NULL,
-				  page_array);
+	nid = numa_node_id();
+	nodemask = policy_nodemask(gfp, pol, NO_INTERLEAVE_INDEX, &nid);
+	return __alloc_pages_bulk(gfp, nid, nodemask,
+				  nr_pages, NULL, page_array);
 }
 
 int vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst)
@@ -2516,23 +2451,21 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
 		   unsigned long addr)
 {
 	struct mempolicy *pol;
+	pgoff_t ilx;
 	struct zoneref *z;
 	int curnid = folio_nid(folio);
-	unsigned long pgoff;
 	int thiscpu = raw_smp_processor_id();
 	int thisnid = cpu_to_node(thiscpu);
 	int polnid = NUMA_NO_NODE;
 	int ret = NUMA_NO_NODE;
 
-	pol = get_vma_policy(vma, addr);
+	pol = get_vma_policy(vma, addr, folio_order(folio), &ilx);
 	if (!(pol->flags & MPOL_F_MOF))
 		goto out;
 
 	switch (pol->mode) {
 	case MPOL_INTERLEAVE:
-		pgoff = vma->vm_pgoff;
-		pgoff += (addr - vma->vm_start) >> PAGE_SHIFT;
-		polnid = offset_il_node(pol, pgoff);
+		polnid = interleave_nid(pol, ilx);
 		break;
 
 	case MPOL_PREFERRED:
diff --git a/mm/shmem.c b/mm/shmem.c
index a3ec5d2dda9a..6503910b0f54 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1561,38 +1561,20 @@ static inline struct mempolicy *shmem_get_sbmpol(struct shmem_sb_info *sbinfo)
 	return NULL;
 }
 #endif /* CONFIG_NUMA && CONFIG_TMPFS */
-#ifndef CONFIG_NUMA
-#define vm_policy vm_private_data
-#endif
 
-static void shmem_pseudo_vma_init(struct vm_area_struct *vma,
-		struct shmem_inode_info *info, pgoff_t index)
-{
-	/* Create a pseudo vma that just contains the policy */
-	vma_init(vma, NULL);
-	/* Bias interleave by inode number to distribute better across nodes */
-	vma->vm_pgoff = index + info->vfs_inode.i_ino;
-	vma->vm_policy = mpol_shared_policy_lookup(&info->policy, index);
-}
+static struct mempolicy *shmem_get_pgoff_policy(struct shmem_inode_info *info,
+			pgoff_t index, unsigned int order, pgoff_t *ilx);
 
-static void shmem_pseudo_vma_destroy(struct vm_area_struct *vma)
-{
-	/* Drop reference taken by mpol_shared_policy_lookup() */
-	mpol_cond_put(vma->vm_policy);
-}
-
-static struct folio *shmem_swapin(swp_entry_t swap, gfp_t gfp,
+static struct folio *shmem_swapin_cluster(swp_entry_t swap, gfp_t gfp,
 			struct shmem_inode_info *info, pgoff_t index)
 {
-	struct vm_area_struct pvma;
+	struct mempolicy *mpol;
+	pgoff_t ilx;
 	struct page *page;
-	struct vm_fault vmf = {
-		.vma = &pvma,
-	};
 
-	shmem_pseudo_vma_init(&pvma, info, index);
-	page = swap_cluster_readahead(swap, gfp, &vmf);
-	shmem_pseudo_vma_destroy(&pvma);
+	mpol = shmem_get_pgoff_policy(info, index, 0, &ilx);
+	page = swap_cluster_readahead(swap, gfp, mpol, ilx);
+	mpol_cond_put(mpol);
 
 	if (!page)
 		return NULL;
@@ -1626,27 +1608,29 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
 static struct folio *shmem_alloc_hugefolio(gfp_t gfp,
 		struct shmem_inode_info *info, pgoff_t index)
 {
-	struct vm_area_struct pvma;
-	struct folio *folio;
+	struct mempolicy *mpol;
+	pgoff_t ilx;
+	struct page *page;
 
-	shmem_pseudo_vma_init(&pvma, info, index);
-	folio = vma_alloc_folio(gfp, HPAGE_PMD_ORDER, &pvma, 0, true);
-	shmem_pseudo_vma_destroy(&pvma);
+	mpol = shmem_get_pgoff_policy(info, index, HPAGE_PMD_ORDER, &ilx);
+	page = alloc_pages_mpol(gfp, HPAGE_PMD_ORDER, mpol, ilx, numa_node_id());
+	mpol_cond_put(mpol);
 
-	return folio;
+	return page_rmappable_folio(page);
 }
 
 static struct folio *shmem_alloc_folio(gfp_t gfp,
 		struct shmem_inode_info *info, pgoff_t index)
 {
-	struct vm_area_struct pvma;
-	struct folio *folio;
+	struct mempolicy *mpol;
+	pgoff_t ilx;
+	struct page *page;
 
-	shmem_pseudo_vma_init(&pvma, info, index);
-	folio = vma_alloc_folio(gfp, 0, &pvma, 0, false);
-	shmem_pseudo_vma_destroy(&pvma);
+	mpol = shmem_get_pgoff_policy(info, index, 0, &ilx);
+	page = alloc_pages_mpol(gfp, 0, mpol, ilx, numa_node_id());
+	mpol_cond_put(mpol);
 
-	return folio;
+	return (struct folio *)page;
 }
 
 static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
@@ -1900,7 +1884,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			count_memcg_event_mm(fault_mm, PGMAJFAULT);
 		}
 		/* Here we actually start the io */
-		folio = shmem_swapin(swap, gfp, info, index);
+		folio = shmem_swapin_cluster(swap, gfp, info, index);
 		if (!folio) {
 			error = -ENOMEM;
 			goto failed;
@@ -2351,15 +2335,41 @@ static int shmem_set_policy(struct vm_area_struct *vma, struct mempolicy *mpol)
 }
 
 static struct mempolicy *shmem_get_policy(struct vm_area_struct *vma,
-					  unsigned long addr)
+					  unsigned long addr, pgoff_t *ilx)
 {
 	struct inode *inode = file_inode(vma->vm_file);
 	pgoff_t index;
 
+	/*
+	 * Bias interleave by inode number to distribute better across nodes;
+	 * but this interface is independent of which page order is used, so
+	 * supplies only that bias, letting caller apply the offset (adjusted
+	 * by page order, as in shmem_get_pgoff_policy() and get_vma_policy()).
+	 */
+	*ilx = inode->i_ino;
 	index = ((addr - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
 	return mpol_shared_policy_lookup(&SHMEM_I(inode)->policy, index);
 }
-#endif
+
+static struct mempolicy *shmem_get_pgoff_policy(struct shmem_inode_info *info,
+			pgoff_t index, unsigned int order, pgoff_t *ilx)
+{
+	struct mempolicy *mpol;
+
+	/* Bias interleave by inode number to distribute better across nodes */
+	*ilx = info->vfs_inode.i_ino + (index >> order);
+
+	mpol = mpol_shared_policy_lookup(&info->policy, index);
+	return mpol ? mpol : get_task_policy(current);
+}
+#else
+static struct mempolicy *shmem_get_pgoff_policy(struct shmem_inode_info *info,
+			pgoff_t index, unsigned int order, pgoff_t *ilx)
+{
+	*ilx = 0;
+	return NULL;
+}
+#endif /* CONFIG_NUMA */
 
 int shmem_lock(struct file *file, int lock, struct ucounts *ucounts)
 {
diff --git a/mm/swap.h b/mm/swap.h
index 8a3c7a0ace4f..73c332ee4d91 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -2,6 +2,8 @@
 #ifndef _MM_SWAP_H
 #define _MM_SWAP_H
 
+struct mempolicy;
+
 #ifdef CONFIG_SWAP
 #include <linux/blk_types.h> /* for bio_end_io_t */
 
@@ -48,11 +50,10 @@ struct page *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 				   unsigned long addr,
 				   struct swap_iocb **plug);
 struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
-				     struct vm_area_struct *vma,
-				     unsigned long addr,
+				     struct mempolicy *mpol, pgoff_t ilx,
 				     bool *new_page_allocated);
 struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
-				    struct vm_fault *vmf);
+				    struct mempolicy *mpol, pgoff_t ilx);
 struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
 			      struct vm_fault *vmf);
 
@@ -80,7 +81,7 @@ static inline void show_swap_cache_info(void)
 }
 
 static inline struct page *swap_cluster_readahead(swp_entry_t entry,
-				gfp_t gfp_mask, struct vm_fault *vmf)
+			gfp_t gfp_mask, struct mempolicy *mpol, pgoff_t ilx)
 {
 	return NULL;
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 788e36a06c34..4afa4ed464d2 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -10,6 +10,7 @@
 #include <linux/mm.h>
 #include <linux/gfp.h>
 #include <linux/kernel_stat.h>
+#include <linux/mempolicy.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/init.h>
@@ -411,8 +412,8 @@ struct folio *filemap_get_incore_folio(struct address_space *mapping,
 }
 
 struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
-			struct vm_area_struct *vma, unsigned long addr,
-			bool *new_page_allocated)
+				     struct mempolicy *mpol, pgoff_t ilx,
+				     bool *new_page_allocated)
 {
 	struct swap_info_struct *si;
 	struct folio *folio;
@@ -455,7 +456,8 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		 * before marking swap_map SWAP_HAS_CACHE, when -EEXIST will
 		 * cause any racers to loop around until we add it to cache.
 		 */
-		folio = vma_alloc_folio(gfp_mask, 0, vma, addr, false);
+		folio = (struct folio *)alloc_pages_mpol(gfp_mask, 0,
+						mpol, ilx, numa_node_id());
 		if (!folio)
                         goto fail_put_swap;
 
@@ -547,14 +549,19 @@ struct page *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 				   struct vm_area_struct *vma,
 				   unsigned long addr, struct swap_iocb **plug)
 {
-	bool page_was_allocated;
-	struct page *retpage = __read_swap_cache_async(entry, gfp_mask,
-			vma, addr, &page_was_allocated);
+	bool page_allocated;
+	struct mempolicy *mpol;
+	pgoff_t ilx;
+	struct page *page;
 
-	if (page_was_allocated)
-		swap_readpage(retpage, false, plug);
+	mpol = get_vma_policy(vma, addr, 0, &ilx);
+	page = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
+					&page_allocated);
+	mpol_cond_put(mpol);
 
-	return retpage;
+	if (page_allocated)
+		swap_readpage(page, false, plug);
+	return page;
 }
 
 static unsigned int __swapin_nr_pages(unsigned long prev_offset,
@@ -638,7 +645,8 @@ static void inc_nr_protected(struct page *page)
  * swap_cluster_readahead - swap in pages in hope we need them soon
  * @entry: swap entry of this memory
  * @gfp_mask: memory allocation flags
- * @vmf: fault information
+ * @mpol: NUMA memory allocation policy to be applied
+ * @ilx: NUMA interleave index, for use only when MPOL_INTERLEAVE
  *
  * Returns the struct page for entry and addr, after queueing swapin.
  *
@@ -647,13 +655,12 @@ static void inc_nr_protected(struct page *page)
  * because it doesn't cost us any seek time.  We also make sure to queue
  * the 'original' request together with the readahead ones...
  *
- * This has been extended to use the NUMA policies from the mm triggering
- * the readahead.
- *
- * Caller must hold read mmap_lock if vmf->vma is not NULL.
+ * Note: it is intentional that the same NUMA policy and interleave index
+ * are used for every page of the readahead: neighbouring pages on swap
+ * are fairly likely to have been swapped out from the same node.
  */
 struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
-				struct vm_fault *vmf)
+				    struct mempolicy *mpol, pgoff_t ilx)
 {
 	struct page *page;
 	unsigned long entry_offset = swp_offset(entry);
@@ -664,8 +671,6 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	struct blk_plug plug;
 	struct swap_iocb *splug = NULL;
 	bool page_allocated;
-	struct vm_area_struct *vma = vmf->vma;
-	unsigned long addr = vmf->address;
 
 	mask = swapin_nr_pages(offset) - 1;
 	if (!mask)
@@ -683,8 +688,8 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	for (offset = start_offset; offset <= end_offset ; offset++) {
 		/* Ok, do the async read-ahead now */
 		page = __read_swap_cache_async(
-			swp_entry(swp_type(entry), offset),
-			gfp_mask, vma, addr, &page_allocated);
+				swp_entry(swp_type(entry), offset),
+				gfp_mask, mpol, ilx, &page_allocated);
 		if (!page)
 			continue;
 		if (page_allocated) {
@@ -698,11 +703,13 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	}
 	blk_finish_plug(&plug);
 	swap_read_unplug(splug);
-
 	lru_add_drain();	/* Push any new pages onto the LRU now */
 skip:
 	/* The page was likely read above, so no need for plugging here */
-	page = read_swap_cache_async(entry, gfp_mask, vma, addr, NULL);
+	page = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
+					&page_allocated);
+	if (unlikely(page_allocated))
+		swap_readpage(page, false, NULL);
 #ifdef CONFIG_ZSWAP
 	if (page)
 		inc_nr_protected(page);
@@ -805,8 +812,10 @@ static void swap_ra_info(struct vm_fault *vmf,
 
 /**
  * swap_vma_readahead - swap in pages in hope we need them soon
- * @fentry: swap entry of this memory
+ * @targ_entry: swap entry of the targeted memory
  * @gfp_mask: memory allocation flags
+ * @mpol: NUMA memory allocation policy to be applied
+ * @targ_ilx: NUMA interleave index, for use only when MPOL_INTERLEAVE
  * @vmf: fault information
  *
  * Returns the struct page for entry and addr, after queueing swapin.
@@ -817,16 +826,17 @@ static void swap_ra_info(struct vm_fault *vmf,
  * Caller must hold read mmap_lock if vmf->vma is not NULL.
  *
  */
-static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
+static struct page *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
+				       struct mempolicy *mpol, pgoff_t targ_ilx,
 				       struct vm_fault *vmf)
 {
 	struct blk_plug plug;
 	struct swap_iocb *splug = NULL;
-	struct vm_area_struct *vma = vmf->vma;
 	struct page *page;
 	pte_t *pte = NULL, pentry;
 	unsigned long addr;
 	swp_entry_t entry;
+	pgoff_t ilx;
 	unsigned int i;
 	bool page_allocated;
 	struct vma_swap_readahead ra_info = {
@@ -838,9 +848,10 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 		goto skip;
 
 	addr = vmf->address - (ra_info.offset * PAGE_SIZE);
+	ilx = targ_ilx - ra_info.offset;
 
 	blk_start_plug(&plug);
-	for (i = 0; i < ra_info.nr_pte; i++, addr += PAGE_SIZE) {
+	for (i = 0; i < ra_info.nr_pte; i++, ilx++, addr += PAGE_SIZE) {
 		if (!pte++) {
 			pte = pte_offset_map(vmf->pmd, addr);
 			if (!pte)
@@ -854,8 +865,8 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 			continue;
 		pte_unmap(pte);
 		pte = NULL;
-		page = __read_swap_cache_async(entry, gfp_mask, vma,
-					       addr, &page_allocated);
+		page = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
+						&page_allocated);
 		if (!page)
 			continue;
 		if (page_allocated) {
@@ -874,7 +885,10 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 	lru_add_drain();
 skip:
 	/* The page was likely read above, so no need for plugging here */
-	page = read_swap_cache_async(fentry, gfp_mask, vma, vmf->address, NULL);
+	page = __read_swap_cache_async(targ_entry, gfp_mask, mpol, targ_ilx,
+					&page_allocated);
+	if (unlikely(page_allocated))
+		swap_readpage(page, false, NULL);
 #ifdef CONFIG_ZSWAP
 	if (page)
 		inc_nr_protected(page);
@@ -897,9 +911,16 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
 				struct vm_fault *vmf)
 {
-	return swap_use_vma_readahead() ?
-			swap_vma_readahead(entry, gfp_mask, vmf) :
-			swap_cluster_readahead(entry, gfp_mask, vmf);
+	struct mempolicy *mpol;
+	pgoff_t ilx;
+	struct page *page;
+
+	mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
+	page = swap_use_vma_readahead() ?
+		swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf) :
+		swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
+	mpol_cond_put(mpol);
+	return page;
 }
 
 #ifdef CONFIG_SYSFS
-- 
2.35.3

