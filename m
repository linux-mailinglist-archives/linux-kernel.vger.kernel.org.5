Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1AB7AD379
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjIYIfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjIYIfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:35:15 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B299D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:35:07 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d86574d9bcaso4056726276.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695630907; x=1696235707; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ezzNrLDnqV/k6jp9dH7Pe4D9g9Anl40AHbeIOwXqGUY=;
        b=SaBXJB1aKffZAvXpoDnGUErfY3LnH8PquRQ/9iH/krsoaxMMyvBhBhwWQogbksXKkm
         8TH2P98NSQv1LhnfKsD82hvOaRf4ynwQJPOMZAgbZyvs+JqaPd6m3U/zL+TYOYjnxhF3
         ii7SrPG/1AMeTCgroBMTbYUhu3v+1ewJD/3cFnLUUJNMAHEhL4/mvpijsDNe5CPseBI4
         nDAiE/0ZmPlrV8HYwPVLHGgETExfYGjskV2OxZWJYOgOO6Z5sc2SwswZ14FNPgfPdg9a
         2ymjRWqounhxyUyayp64lUKxvxzc9+IWEf/d+QrLo4Q2DU9BeMKjd4WcPbUEBk7AKECZ
         RWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695630907; x=1696235707;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ezzNrLDnqV/k6jp9dH7Pe4D9g9Anl40AHbeIOwXqGUY=;
        b=Qn0t21wpRh5QEIbKgVVAJAnVez3chxI5OkKTjvLRgb6EMya2UsXMwxPvWpU6ko4898
         kcfE3bXGl16TSWR/MThw69qUxVL58A5A8L0+UWPCNW4uTXB8Kb4/3fxsDhSShvHUKMA2
         K8QgasJ8NIUQHM115HLXCbisHO3NgdNN5pcSucgmLgUsHLtAmgG1wcPc7d2qFN7Xf1v/
         lPn3kd5FhVCmU9TEVCNDXIsIbWXV2jBcJWfxaqhYgxs46CQIqe5gvCu6uph2+2Kx82e0
         y8Kxi87x7Xi1CylNhEVInI4/W+9+sey+XmyWZ3zK51Y3apJrr3WMlIIYI5N6yvelzWbf
         XsqQ==
X-Gm-Message-State: AOJu0YwPXrO50MTjCGvbm+NnJAQOiLDAsXoKnsRVeBpOpmxzDvi2doYS
        SN9jrntUTAlj4D4omOLwg3q5Qg==
X-Google-Smtp-Source: AGHT+IFp0uZwCYh9f6Ww0ZKvnQPx4qXewNgiqFJbqCBgiDfI2aX3U5liWK+g0EmK6zec2o4LhHt/pg==
X-Received: by 2002:a05:690c:d93:b0:59f:8026:4260 with SMTP id da19-20020a05690c0d9300b0059f80264260mr2238947ywb.24.1695630906593;
        Mon, 25 Sep 2023 01:35:06 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c188-20020a0df3c5000000b0059293c8d70csm2293994ywf.132.2023.09.25.01.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 01:35:05 -0700 (PDT)
Date:   Mon, 25 Sep 2023 01:35:03 -0700 (PDT)
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
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 11/12] mempolicy: mmap_lock is not needed while migrating
 folios
In-Reply-To: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com>
Message-ID: <73183de1-6529-b146-f2cc-fcd5b812166@google.com>
References: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com>
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

mbind(2) holds down_write of current task's mmap_lock throughout
(exclusive because it needs to set the new mempolicy on the vmas);
migrate_pages(2) holds down_read of pid's mmap_lock throughout.

They both hold mmap_lock across the internal migrate_pages(), under which
all new page allocations (huge or small) are made.  I'm nervous about it;
and migrate_pages() certainly does not need mmap_lock itself.  It's done
this way for mbind(2), because its page allocator is vma_alloc_folio() or
alloc_hugetlb_folio_vma(), both of which depend on vma and address.

Now that we have alloc_pages_mpol(), depending on (refcounted) memory
policy and interleave index, mbind(2) can be modified to use that or
alloc_hugetlb_folio_nodemask(), and then not need mmap_lock across the
internal migrate_pages() at all: add alloc_migration_target_by_mpol()
to replace mbind's new_page().

(After that change, alloc_hugetlb_folio_vma() is used by nothing but a
userfaultfd function: move it out of hugetlb.h and into the #ifdef.)

migrate_pages(2) has chosen its target node before migrating, so can
continue to use the standard alloc_migration_target(); but let it take
and drop mmap_lock just around migrate_to_node()'s queue_pages_range():
neither the node-to-node calculations nor the page migrations need it.

It seems unlikely, but it is conceivable that some userspace depends on
the kernel's mmap_lock exclusion here, instead of doing its own locking:
more likely in a testsuite than in real life.  It is also possible, of
course, that some pages on the list will be munmapped by another thread
before they are migrated, or a newer memory policy applied to the range
by that time: but such races could happen before, as soon as mmap_lock
was dropped, so it does not appear to be a concern.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/hugetlb.h |  9 -----
 mm/hugetlb.c            | 38 +++++++++---------
 mm/mempolicy.c          | 85 +++++++++++++++++++++--------------------
 3 files changed, 64 insertions(+), 68 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 6522eb3cd007..9c4265c73f76 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -714,8 +714,6 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
 struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask, gfp_t gfp_mask);
-struct folio *alloc_hugetlb_folio_vma(struct hstate *h, struct vm_area_struct *vma,
-				unsigned long address);
 int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
 			pgoff_t idx);
 void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
@@ -1024,13 +1022,6 @@ alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 	return NULL;
 }
 
-static inline struct folio *alloc_hugetlb_folio_vma(struct hstate *h,
-					       struct vm_area_struct *vma,
-					       unsigned long address)
-{
-	return NULL;
-}
-
 static inline int __alloc_bootmem_huge_page(struct hstate *h)
 {
 	return 0;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ba6d39b71cb1..1af54dbbd7cc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2479,24 +2479,6 @@ struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 	return alloc_migrate_hugetlb_folio(h, gfp_mask, preferred_nid, nmask);
 }
 
-/* mempolicy aware migration callback */
-struct folio *alloc_hugetlb_folio_vma(struct hstate *h, struct vm_area_struct *vma,
-		unsigned long address)
-{
-	struct mempolicy *mpol;
-	nodemask_t *nodemask;
-	struct folio *folio;
-	gfp_t gfp_mask;
-	int node;
-
-	gfp_mask = htlb_alloc_mask(h);
-	node = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
-	folio = alloc_hugetlb_folio_nodemask(h, node, nodemask, gfp_mask);
-	mpol_cond_put(mpol);
-
-	return folio;
-}
-
 /*
  * Increase the hugetlb pool such that it can accommodate a reservation
  * of size 'delta'.
@@ -6225,6 +6207,26 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 }
 
 #ifdef CONFIG_USERFAULTFD
+/*
+ * Can probably be eliminated, but still used by hugetlb_mfill_atomic_pte().
+ */
+static struct folio *alloc_hugetlb_folio_vma(struct hstate *h,
+		struct vm_area_struct *vma, unsigned long address)
+{
+	struct mempolicy *mpol;
+	nodemask_t *nodemask;
+	struct folio *folio;
+	gfp_t gfp_mask;
+	int node;
+
+	gfp_mask = htlb_alloc_mask(h);
+	node = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
+	folio = alloc_hugetlb_folio_nodemask(h, node, nodemask, gfp_mask);
+	mpol_cond_put(mpol);
+
+	return folio;
+}
+
 /*
  * Used by userfaultfd UFFDIO_* ioctls. Based on userfaultfd's mfill_atomic_pte
  * with modifications for hugetlb pages.
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d74df1e1b14a..74b1894d29c1 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -417,6 +417,8 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 
 static bool migrate_folio_add(struct folio *folio, struct list_head *foliolist,
 				unsigned long flags);
+static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
+				pgoff_t ilx, int *nid);
 
 static bool strictly_unmovable(unsigned long flags)
 {
@@ -1040,6 +1042,8 @@ static long migrate_to_node(struct mm_struct *mm, int source, int dest,
 	node_set(source, nmask);
 
 	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)));
+
+	mmap_read_lock(mm);
 	vma = find_vma(mm, 0);
 
 	/*
@@ -1050,6 +1054,7 @@ static long migrate_to_node(struct mm_struct *mm, int source, int dest,
 	 */
 	nr_failed = queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
 				      flags | MPOL_MF_DISCONTIG_OK, &pagelist);
+	mmap_read_unlock(mm);
 
 	if (!list_empty(&pagelist)) {
 		err = migrate_pages(&pagelist, alloc_migration_target, NULL,
@@ -1078,8 +1083,6 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 
 	lru_cache_disable();
 
-	mmap_read_lock(mm);
-
 	/*
 	 * Find a 'source' bit set in 'tmp' whose corresponding 'dest'
 	 * bit in 'to' is not also set in 'tmp'.  Clear the found 'source'
@@ -1159,7 +1162,6 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 		if (err < 0)
 			break;
 	}
-	mmap_read_unlock(mm);
 
 	lru_cache_enable();
 	if (err < 0)
@@ -1168,44 +1170,38 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 }
 
 /*
- * Allocate a new page for page migration based on vma policy.
- * Start by assuming the page is mapped by the same vma as contains @start.
- * Search forward from there, if not.  N.B., this assumes that the
- * list of pages handed to migrate_pages()--which is how we get here--
- * is in virtual address order.
+ * Allocate a new folio for page migration, according to NUMA mempolicy.
  */
-static struct folio *new_folio(struct folio *src, unsigned long start)
+static struct folio *alloc_migration_target_by_mpol(struct folio *src,
+						    unsigned long private)
 {
-	struct vm_area_struct *vma;
-	unsigned long address;
-	VMA_ITERATOR(vmi, current->mm, start);
-	gfp_t gfp = GFP_HIGHUSER_MOVABLE | __GFP_RETRY_MAYFAIL;
-
-	for_each_vma(vmi, vma) {
-		address = page_address_in_vma(&src->page, vma);
-		if (address != -EFAULT)
-			break;
-	}
-
-	/*
-	 * __get_vma_policy() now expects a genuine non-NULL vma. Return NULL
-	 * when the page can no longer be located in a vma: that is not ideal
-	 * (migrate_pages() will give up early, presuming ENOMEM), but good
-	 * enough to avoid a crash by syzkaller or concurrent holepunch.
-	 */
-	if (!vma)
-		return NULL;
+	struct mempolicy *pol = (struct mempolicy *)private;
+	pgoff_t ilx = 0;	/* improve on this later */
+	struct page *page;
+	unsigned int order;
+	int nid = numa_node_id();
+	gfp_t gfp;
 
 	if (folio_test_hugetlb(src)) {
-		return alloc_hugetlb_folio_vma(folio_hstate(src),
-				vma, address);
+		nodemask_t *nodemask;
+		struct hstate *h;
+
+		ilx += src->index;	/* HugeTLBfs indexes in hpage_size */
+		h = folio_hstate(src);
+		gfp = htlb_alloc_mask(h);
+		nodemask = policy_nodemask(gfp, pol, ilx, &nid);
+		return alloc_hugetlb_folio_nodemask(h, nid, nodemask, gfp);
 	}
 
 	if (folio_test_large(src))
 		gfp = GFP_TRANSHUGE;
+	else
+		gfp = GFP_HIGHUSER_MOVABLE | __GFP_RETRY_MAYFAIL | __GFP_COMP;
 
-	return vma_alloc_folio(gfp, folio_order(src), vma, address,
-			folio_test_large(src));
+	order = folio_order(src);
+	ilx += src->index >> order;
+	page = alloc_pages_mpol(gfp, order, pol, ilx, nid);
+	return page_rmappable_folio(page);
 }
 #else
 
@@ -1221,7 +1217,8 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 	return -ENOSYS;
 }
 
-static struct folio *new_folio(struct folio *src, unsigned long start)
+static struct folio *alloc_migration_target_by_mpol(struct folio *src,
+						    unsigned long private)
 {
 	return NULL;
 }
@@ -1295,6 +1292,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 
 	if (nr_failed < 0) {
 		err = nr_failed;
+		nr_failed = 0;
 	} else {
 		vma_iter_init(&vmi, mm, start);
 		prev = vma_prev(&vmi);
@@ -1305,19 +1303,24 @@ static long do_mbind(unsigned long start, unsigned long len,
 		}
 	}
 
-	if (!err) {
-		if (!list_empty(&pagelist)) {
-			nr_failed |= migrate_pages(&pagelist, new_folio, NULL,
-				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND, NULL);
+	mmap_write_unlock(mm);
+
+	if (!err && !list_empty(&pagelist)) {
+		/* Convert MPOL_DEFAULT's NULL to task or default policy */
+		if (!new) {
+			new = get_task_policy(current);
+			mpol_get(new);
 		}
-		if (nr_failed && (flags & MPOL_MF_STRICT))
-			err = -EIO;
+		nr_failed |= migrate_pages(&pagelist,
+				alloc_migration_target_by_mpol, NULL,
+				(unsigned long)new, MIGRATE_SYNC,
+				MR_MEMPOLICY_MBIND, NULL);
 	}
 
+	if (nr_failed && (flags & MPOL_MF_STRICT))
+		err = -EIO;
 	if (!list_empty(&pagelist))
 		putback_movable_pages(&pagelist);
-
-	mmap_write_unlock(mm);
 mpol_out:
 	mpol_put(new);
 	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
-- 
2.35.3

