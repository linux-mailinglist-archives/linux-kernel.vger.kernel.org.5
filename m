Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4727B6549
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239573AbjJCJR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjJCJRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:17:53 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F060AC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 02:17:47 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-59c215f2f4aso8636887b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 02:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696324666; x=1696929466; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zn2NsWuFnhQFrO/gKSp+dM0OPa5MQSJrmStGl/lqBlA=;
        b=cpvyBZsGl9QtgHrKHHxS4JL+/8dvOxbU7kwuFXrWYbhlUO9Xuc11CoTrGlLU5D5KSy
         JYDCRfJcN/09MQeoEHqWZfX/m9lqju1B3aD+526SkT+ns683+shvVPq1wq1JlUn0fFba
         NU9WvMRBVtFqZCr36fyvFiiB8M0TNipacxiXPePmJZcCYCHvDt3MVO8VImX19b29HxxO
         fd0iunpqBZ0YOP/KGCh/z2oQIDG/CAqCOgwFTTktqSbAFUF5rowRyzXtKbmB78Up0cMq
         L7XiO/hgNrGWHt9/rOTKsucpqFQ31ycUalVS+ewqSTJ1+X8I0lFwM3DCwjAos8CfI+fL
         6/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696324666; x=1696929466;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zn2NsWuFnhQFrO/gKSp+dM0OPa5MQSJrmStGl/lqBlA=;
        b=roWsimSU0i+fknDWHi5fzAOqpNPjcBdps7SFTB+6RUAxZ1Vz6kPAAtoxmTaS++wB/8
         KM9E5BcklGdNmlxs9EpJYUdae1xmoGgp//1i3vgFUJwwd6uYJR6g/M4u+q50093Mt+IK
         Zdk4CCVZA6MyfCWjTcVAfhHraCU+UvR603RpHqTV+KUGDcj0F20KEkX9NLHkv3eK/kyW
         5BHLKHlYpi31xuVEm+rXvgI7srMMzUC0SLTNtAtX5+tNcctH7Bcw2T2nRG+tjp4nocs/
         xqHY0iJzUK1mfAuE6JiXaYmGVDysWLeYn59HXVL2mMu9eac/OlX4vJyl48xrVaGq8+7u
         bJsw==
X-Gm-Message-State: AOJu0YyKVU6pCV0fXUwjz4Zz0ggdaW3PWHRLVpY1Lk73vGoA4x9Lx9MK
        G75rBHMKMNkRHeTVXd1Sr5VzLg==
X-Google-Smtp-Source: AGHT+IE3Svm4U0UI94crkF3Xvc7SgRRIcjGyQQz387KOabSZ66gJRpb7rp90OkiPibu4jPkgupThZg==
X-Received: by 2002:a25:b10f:0:b0:d7e:dd21:9b16 with SMTP id g15-20020a25b10f000000b00d7edd219b16mr12705693ybj.8.1696324666069;
        Tue, 03 Oct 2023 02:17:46 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a9-20020a259389000000b00d8128f9a46bsm279851ybm.37.2023.10.03.02.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 02:17:45 -0700 (PDT)
Date:   Tue, 3 Oct 2023 02:17:43 -0700 (PDT)
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
Subject: [PATCH v2 03/12] mempolicy: fix migrate_pages(2) syscall return
 nr_failed
In-Reply-To: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
Message-ID: <9a6b0b9-3bb-dbef-8adf-efab4397b8d@google.com>
References: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"man 2 migrate_pages" says "On success migrate_pages() returns the number
of pages that could not be moved".  Although 5.3 and 5.4 commits fixed
mbind(MPOL_MF_STRICT|MPOL_MF_MOVE*) to fail with EIO when not all pages
could be moved (because some could not be isolated for migration),
migrate_pages(2) was left still reporting only those pages failing at the
migration stage, forgetting those failing at the earlier isolation stage.

Fix that by accumulating a long nr_failed count in struct queue_pages,
returned by queue_pages_range() when it's not returning an error, for
adding on to the nr_failed count from migrate_pages() in mm/migrate.c.
A count of pages?  It's more a count of folios, but changing it to pages
would entail more work (also in mm/migrate.c): does not seem justified.

queue_pages_range() itself should only return -EIO in the "strictly
unmovable" case (STRICT without any MOVEs): in that case it's best to
break out as soon as nr_failed gets set; but otherwise it should continue
to isolate pages for MOVing even when nr_failed - as the mbind(2) manpage
promises.

There's a case when nr_failed should be incremented when it was missed:
queue_folios_pte_range() and queue_folios_hugetlb() count the transient
migration entries, like queue_folios_pmd() already did.  And there's a
case when nr_failed should not be incremented when it would have been:
in meeting later PTEs of the same large folio, which can only be isolated
once: fixed by recording the current large folio in struct queue_pages.

Clean up the affected functions, fixing or updating many comments.  Bool
migrate_folio_add(), without -EIO: true if adding, or if skipping shared
(but its arguable folio_estimated_sharers() heuristic left unchanged).
Use MPOL_MF_WRLOCK flag to queue_pages_range(), instead of bool lock_vma.
Use explicit STRICT|MOVE* flags where queue_pages_test_walk() checks for
skipping, instead of hiding them behind MPOL_MF_VALID.

Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/mempolicy.c | 342 ++++++++++++++++++++++++---------------------------
 1 file changed, 161 insertions(+), 181 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 38a47fa33ef4..752d880dcdf8 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -111,7 +111,8 @@
 
 /* Internal flags */
 #define MPOL_MF_DISCONTIG_OK (MPOL_MF_INTERNAL << 0)	/* Skip checks for continuous vmas */
-#define MPOL_MF_INVERT (MPOL_MF_INTERNAL << 1)		/* Invert check for nodemask */
+#define MPOL_MF_INVERT       (MPOL_MF_INTERNAL << 1)	/* Invert check for nodemask */
+#define MPOL_MF_WRLOCK       (MPOL_MF_INTERNAL << 2)	/* Write-lock walked vmas */
 
 static struct kmem_cache *policy_cache;
 static struct kmem_cache *sn_cache;
@@ -416,9 +417,19 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 	},
 };
 
-static int migrate_folio_add(struct folio *folio, struct list_head *foliolist,
+static bool migrate_folio_add(struct folio *folio, struct list_head *foliolist,
 				unsigned long flags);
 
+static bool strictly_unmovable(unsigned long flags)
+{
+	/*
+	 * STRICT without MOVE flags lets do_mbind() fail immediately with -EIO
+	 * if any misplaced page is found.
+	 */
+	return (flags & (MPOL_MF_STRICT | MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ==
+			 MPOL_MF_STRICT;
+}
+
 struct queue_pages {
 	struct list_head *pagelist;
 	unsigned long flags;
@@ -426,7 +437,8 @@ struct queue_pages {
 	unsigned long start;
 	unsigned long end;
 	struct vm_area_struct *first;
-	bool has_unmovable;
+	struct folio *large;		/* note last large folio encountered */
+	long nr_failed;			/* could not be isolated at this time */
 };
 
 /*
@@ -444,61 +456,37 @@ static inline bool queue_folio_required(struct folio *folio,
 	return node_isset(nid, *qp->nmask) == !(flags & MPOL_MF_INVERT);
 }
 
-/*
- * queue_folios_pmd() has three possible return values:
- * 0 - folios are placed on the right node or queued successfully, or
- *     special page is met, i.e. zero page, or unmovable page is found
- *     but continue walking (indicated by queue_pages.has_unmovable).
- * -EIO - is migration entry or only MPOL_MF_STRICT was specified and an
- *        existing folio was already on a node that does not follow the
- *        policy.
- */
-static int queue_folios_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
-				unsigned long end, struct mm_walk *walk)
-	__releases(ptl)
+static void queue_folios_pmd(pmd_t *pmd, struct mm_walk *walk)
 {
-	int ret = 0;
 	struct folio *folio;
 	struct queue_pages *qp = walk->private;
-	unsigned long flags;
 
 	if (unlikely(is_pmd_migration_entry(*pmd))) {
-		ret = -EIO;
-		goto unlock;
+		qp->nr_failed++;
+		return;
 	}
 	folio = pfn_folio(pmd_pfn(*pmd));
 	if (is_huge_zero_page(&folio->page)) {
 		walk->action = ACTION_CONTINUE;
-		goto unlock;
+		return;
 	}
 	if (!queue_folio_required(folio, qp))
-		goto unlock;
-
-	flags = qp->flags;
-	/* go to folio migration */
-	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
-		if (!vma_migratable(walk->vma) ||
-		    migrate_folio_add(folio, qp->pagelist, flags)) {
-			qp->has_unmovable = true;
-			goto unlock;
-		}
-	} else
-		ret = -EIO;
-unlock:
-	spin_unlock(ptl);
-	return ret;
+		return;
+	if (!(qp->flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ||
+	    !vma_migratable(walk->vma) ||
+	    !migrate_folio_add(folio, qp->pagelist, qp->flags))
+		qp->nr_failed++;
 }
 
 /*
- * Scan through pages checking if pages follow certain conditions,
- * and move them to the pagelist if they do.
+ * Scan through folios, checking if they satisfy the required conditions,
+ * moving them from LRU to local pagelist for migration if they do (or not).
  *
- * queue_folios_pte_range() has three possible return values:
- * 0 - folios are placed on the right node or queued successfully, or
- *     special page is met, i.e. zero page, or unmovable page is found
- *     but continue walking (indicated by queue_pages.has_unmovable).
- * -EIO - only MPOL_MF_STRICT was specified and an existing folio was already
- *        on a node that does not follow the policy.
+ * queue_folios_pte_range() has two possible return values:
+ * 0 - continue walking to scan for more, even if an existing folio on the
+ *     wrong node could not be isolated and queued for migration.
+ * -EIO - only MPOL_MF_STRICT was specified, without MPOL_MF_MOVE or ..._ALL,
+ *        and an existing folio was on a node that does not follow the policy.
  */
 static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 			unsigned long end, struct mm_walk *walk)
@@ -512,8 +500,11 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 	spinlock_t *ptl;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
-	if (ptl)
-		return queue_folios_pmd(pmd, ptl, addr, end, walk);
+	if (ptl) {
+		queue_folios_pmd(pmd, walk);
+		spin_unlock(ptl);
+		goto out;
+	}
 
 	mapped_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
 	if (!pte) {
@@ -522,8 +513,13 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 	}
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
 		ptent = ptep_get(pte);
-		if (!pte_present(ptent))
+		if (pte_none(ptent))
 			continue;
+		if (!pte_present(ptent)) {
+			if (is_migration_entry(pte_to_swp_entry(ptent)))
+				qp->nr_failed++;
+			continue;
+		}
 		folio = vm_normal_folio(vma, addr, ptent);
 		if (!folio || folio_is_zone_device(folio))
 			continue;
@@ -535,95 +531,87 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 			continue;
 		if (!queue_folio_required(folio, qp))
 			continue;
-		if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
+		if (folio_test_large(folio)) {
 			/*
-			 * MPOL_MF_STRICT must be specified if we get here.
-			 * Continue walking vmas due to MPOL_MF_MOVE* flags.
+			 * A large folio can only be isolated from LRU once,
+			 * but may be mapped by many PTEs (and Copy-On-Write may
+			 * intersperse PTEs of other, order 0, folios).  This is
+			 * a common case, so don't mistake it for failure (but
+			 * there can be other cases of multi-mapped pages which
+			 * this quick check does not help to filter out - and a
+			 * search of the pagelist might grow to be prohibitive).
+			 *
+			 * migrate_pages(&pagelist) returns nr_failed folios, so
+			 * check "large" now so that queue_pages_range() returns
+			 * a comparable nr_failed folios.  This does imply that
+			 * if folio could not be isolated for some racy reason
+			 * at its first PTE, later PTEs will not give it another
+			 * chance of isolation; but keeps the accounting simple.
 			 */
-			if (!vma_migratable(vma))
-				qp->has_unmovable = true;
-
-			/*
-			 * Do not abort immediately since there may be
-			 * temporary off LRU pages in the range.  Still
-			 * need migrate other LRU pages.
-			 */
-			if (migrate_folio_add(folio, qp->pagelist, flags))
-				qp->has_unmovable = true;
-		} else
-			break;
+			if (folio == qp->large)
+				continue;
+			qp->large = folio;
+		}
+		if (!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ||
+		    !vma_migratable(vma) ||
+		    !migrate_folio_add(folio, qp->pagelist, flags)) {
+			qp->nr_failed++;
+			if (strictly_unmovable(flags))
+				break;
+		}
 	}
 	pte_unmap_unlock(mapped_pte, ptl);
 	cond_resched();
-
-	return addr != end ? -EIO : 0;
+out:
+	if (qp->nr_failed && strictly_unmovable(flags))
+		return -EIO;
+	return 0;
 }
 
 static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
 			       unsigned long addr, unsigned long end,
 			       struct mm_walk *walk)
 {
-	int ret = 0;
 #ifdef CONFIG_HUGETLB_PAGE
 	struct queue_pages *qp = walk->private;
-	unsigned long flags = (qp->flags & MPOL_MF_VALID);
+	unsigned long flags = qp->flags;
 	struct folio *folio;
 	spinlock_t *ptl;
 	pte_t entry;
 
 	ptl = huge_pte_lock(hstate_vma(walk->vma), walk->mm, pte);
 	entry = huge_ptep_get(pte);
-	if (!pte_present(entry))
+	if (!pte_present(entry)) {
+		if (unlikely(is_hugetlb_entry_migration(entry)))
+			qp->nr_failed++;
 		goto unlock;
+	}
 	folio = pfn_folio(pte_pfn(entry));
 	if (!queue_folio_required(folio, qp))
 		goto unlock;
-
-	if (flags == MPOL_MF_STRICT) {
-		/*
-		 * STRICT alone means only detecting misplaced folio and no
-		 * need to further check other vma.
-		 */
-		ret = -EIO;
+	if (!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ||
+	    !vma_migratable(walk->vma)) {
+		qp->nr_failed++;
 		goto unlock;
 	}
-
-	if (!vma_migratable(walk->vma)) {
-		/*
-		 * Must be STRICT with MOVE*, otherwise .test_walk() have
-		 * stopped walking current vma.
-		 * Detecting misplaced folio but allow migrating folios which
-		 * have been queued.
-		 */
-		qp->has_unmovable = true;
-		goto unlock;
-	}
-
 	/*
-	 * With MPOL_MF_MOVE, we try to migrate only unshared folios. If it
-	 * is shared it is likely not worth migrating.
+	 * Unless MPOL_MF_MOVE_ALL, we try to avoid migrating a shared folio.
+	 * Choosing not to migrate a shared folio is not counted as a failure.
 	 *
 	 * To check if the folio is shared, ideally we want to make sure
 	 * every page is mapped to the same process. Doing that is very
-	 * expensive, so check the estimated mapcount of the folio instead.
+	 * expensive, so check the estimated sharers of the folio instead.
 	 */
-	if (flags & (MPOL_MF_MOVE_ALL) ||
-	    (flags & MPOL_MF_MOVE && folio_estimated_sharers(folio) == 1 &&
-	     !hugetlb_pmd_shared(pte))) {
-		if (!isolate_hugetlb(folio, qp->pagelist) &&
-			(flags & MPOL_MF_STRICT))
-			/*
-			 * Failed to isolate folio but allow migrating pages
-			 * which have been queued.
-			 */
-			qp->has_unmovable = true;
-	}
+	if ((flags & MPOL_MF_MOVE_ALL) ||
+	    (folio_estimated_sharers(folio) == 1 && !hugetlb_pmd_shared(pte)))
+		if (!isolate_hugetlb(folio, qp->pagelist))
+			qp->nr_failed++;
 unlock:
 	spin_unlock(ptl);
-#else
-	BUG();
+	if (qp->nr_failed && strictly_unmovable(flags))
+		return -EIO;
 #endif
-	return ret;
+	return 0;
 }
 
 #ifdef CONFIG_NUMA_BALANCING
@@ -704,8 +692,11 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
 		return 1;
 	}
 
-	/* queue pages from current vma */
-	if (flags & MPOL_MF_VALID)
+	/*
+	 * Check page nodes, and queue pages to move, in the current vma.
+	 * But if no moving, and no strict checking, the scan can be skipped.
+	 */
+	if (flags & (MPOL_MF_STRICT | MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
 		return 0;
 	return 1;
 }
@@ -727,22 +718,21 @@ static const struct mm_walk_ops queue_pages_lock_vma_walk_ops = {
 /*
  * Walk through page tables and collect pages to be migrated.
  *
- * If pages found in a given range are on a set of nodes (determined by
- * @nodes and @flags,) it's isolated and queued to the pagelist which is
- * passed via @private.
+ * If pages found in a given range are not on the required set of @nodes,
+ * and migration is allowed, they are isolated and queued to @pagelist.
  *
- * queue_pages_range() has three possible return values:
- * 1 - there is unmovable page, but MPOL_MF_MOVE* & MPOL_MF_STRICT were
- *     specified.
- * 0 - queue pages successfully or no misplaced page.
- * errno - i.e. misplaced pages with MPOL_MF_STRICT specified (-EIO) or
- *         memory range specified by nodemask and maxnode points outside
- *         your accessible address space (-EFAULT)
+ * queue_pages_range() may return:
+ * 0 - all pages already on the right node, or successfully queued for moving
+ *     (or neither strict checking nor moving requested: only range checking).
+ * >0 - this number of misplaced folios could not be queued for moving
+ *      (a hugetlbfs page or a transparent huge page being counted as 1).
+ * -EIO - a misplaced page found, when MPOL_MF_STRICT specified without MOVEs.
+ * -EFAULT - a hole in the memory range, when MPOL_MF_DISCONTIG_OK unspecified.
  */
-static int
+static long
 queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
 		nodemask_t *nodes, unsigned long flags,
-		struct list_head *pagelist, bool lock_vma)
+		struct list_head *pagelist)
 {
 	int err;
 	struct queue_pages qp = {
@@ -752,20 +742,17 @@ queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
 		.start = start,
 		.end = end,
 		.first = NULL,
-		.has_unmovable = false,
 	};
-	const struct mm_walk_ops *ops = lock_vma ?
+	const struct mm_walk_ops *ops = (flags & MPOL_MF_WRLOCK) ?
 			&queue_pages_lock_vma_walk_ops : &queue_pages_walk_ops;
 
 	err = walk_page_range(mm, start, end, ops, &qp);
 
-	if (qp.has_unmovable)
-		err = 1;
 	if (!qp.first)
 		/* whole range in hole */
 		err = -EFAULT;
 
-	return err;
+	return err ? : qp.nr_failed;
 }
 
 /*
@@ -1028,16 +1015,16 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 }
 
 #ifdef CONFIG_MIGRATION
-static int migrate_folio_add(struct folio *folio, struct list_head *foliolist,
+static bool migrate_folio_add(struct folio *folio, struct list_head *foliolist,
 				unsigned long flags)
 {
 	/*
-	 * We try to migrate only unshared folios. If it is shared it
-	 * is likely not worth migrating.
+	 * Unless MPOL_MF_MOVE_ALL, we try to avoid migrating a shared folio.
+	 * Choosing not to migrate a shared folio is not counted as a failure.
 	 *
 	 * To check if the folio is shared, ideally we want to make sure
 	 * every page is mapped to the same process. Doing that is very
-	 * expensive, so check the estimated mapcount of the folio instead.
+	 * expensive, so check the estimated sharers of the folio instead.
 	 */
 	if ((flags & MPOL_MF_MOVE_ALL) || folio_estimated_sharers(folio) == 1) {
 		if (folio_isolate_lru(folio)) {
@@ -1045,32 +1032,31 @@ static int migrate_folio_add(struct folio *folio, struct list_head *foliolist,
 			node_stat_mod_folio(folio,
 				NR_ISOLATED_ANON + folio_is_file_lru(folio),
 				folio_nr_pages(folio));
-		} else if (flags & MPOL_MF_STRICT) {
+		} else {
 			/*
 			 * Non-movable folio may reach here.  And, there may be
 			 * temporary off LRU folios or non-LRU movable folios.
 			 * Treat them as unmovable folios since they can't be
-			 * isolated, so they can't be moved at the moment.  It
-			 * should return -EIO for this case too.
+			 * isolated, so they can't be moved at the moment.
 			 */
-			return -EIO;
+			return false;
 		}
 	}
-
-	return 0;
+	return true;
 }
 
 /*
  * Migrate pages from one node to a target node.
  * Returns error or the number of pages not migrated.
  */
-static int migrate_to_node(struct mm_struct *mm, int source, int dest,
-			   int flags)
+static long migrate_to_node(struct mm_struct *mm, int source, int dest,
+			    int flags)
 {
 	nodemask_t nmask;
 	struct vm_area_struct *vma;
 	LIST_HEAD(pagelist);
-	int err = 0;
+	long nr_failed;
+	long err = 0;
 	struct migration_target_control mtc = {
 		.nid = dest,
 		.gfp_mask = GFP_HIGHUSER_MOVABLE | __GFP_THISNODE,
@@ -1079,23 +1065,27 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 	nodes_clear(nmask);
 	node_set(source, nmask);
 
-	/*
-	 * This does not "check" the range but isolates all pages that
-	 * need migration.  Between passing in the full user address
-	 * space range and MPOL_MF_DISCONTIG_OK, this call can not fail.
-	 */
-	vma = find_vma(mm, 0);
 	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)));
-	queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
-			flags | MPOL_MF_DISCONTIG_OK, &pagelist, false);
+	vma = find_vma(mm, 0);
+
+	/*
+	 * This does not migrate the range, but isolates all pages that
+	 * need migration.  Between passing in the full user address
+	 * space range and MPOL_MF_DISCONTIG_OK, this call cannot fail,
+	 * but passes back the count of pages which could not be isolated.
+	 */
+	nr_failed = queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
+				      flags | MPOL_MF_DISCONTIG_OK, &pagelist);
 
 	if (!list_empty(&pagelist)) {
 		err = migrate_pages(&pagelist, alloc_migration_target, NULL,
-				(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL, NULL);
+			(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL, NULL);
 		if (err)
 			putback_movable_pages(&pagelist);
 	}
 
+	if (err >= 0)
+		err += nr_failed;
 	return err;
 }
 
@@ -1108,8 +1098,8 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 		     const nodemask_t *to, int flags)
 {
-	int busy = 0;
-	int err = 0;
+	long nr_failed = 0;
+	long err = 0;
 	nodemask_t tmp;
 
 	lru_cache_disable();
@@ -1191,7 +1181,7 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 		node_clear(source, tmp);
 		err = migrate_to_node(mm, source, dest, flags);
 		if (err > 0)
-			busy += err;
+			nr_failed += err;
 		if (err < 0)
 			break;
 	}
@@ -1200,8 +1190,7 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 	lru_cache_enable();
 	if (err < 0)
 		return err;
-	return busy;
-
+	return (nr_failed < INT_MAX) ? nr_failed : INT_MAX;
 }
 
 /*
@@ -1240,10 +1229,10 @@ static struct folio *new_folio(struct folio *src, unsigned long start)
 }
 #else
 
-static int migrate_folio_add(struct folio *folio, struct list_head *foliolist,
+static bool migrate_folio_add(struct folio *folio, struct list_head *foliolist,
 				unsigned long flags)
 {
-	return -EIO;
+	return false;
 }
 
 int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
@@ -1267,8 +1256,8 @@ static long do_mbind(unsigned long start, unsigned long len,
 	struct vma_iterator vmi;
 	struct mempolicy *new;
 	unsigned long end;
-	int err;
-	int ret;
+	long err;
+	long nr_failed;
 	LIST_HEAD(pagelist);
 
 	if (flags & ~(unsigned long)MPOL_MF_VALID)
@@ -1308,10 +1297,8 @@ static long do_mbind(unsigned long start, unsigned long len,
 		 start, start + len, mode, mode_flags,
 		 nmask ? nodes_addr(*nmask)[0] : NUMA_NO_NODE);
 
-	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
-
+	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
 		lru_cache_disable();
-	}
 	{
 		NODEMASK_SCRATCH(scratch);
 		if (scratch) {
@@ -1327,44 +1314,37 @@ static long do_mbind(unsigned long start, unsigned long len,
 		goto mpol_out;
 
 	/*
-	 * Lock the VMAs before scanning for pages to migrate, to ensure we don't
-	 * miss a concurrently inserted page.
+	 * Lock the VMAs before scanning for pages to migrate,
+	 * to ensure we don't miss a concurrently inserted page.
 	 */
-	ret = queue_pages_range(mm, start, end, nmask,
-			  flags | MPOL_MF_INVERT, &pagelist, true);
+	nr_failed = queue_pages_range(mm, start, end, nmask,
+			flags | MPOL_MF_INVERT | MPOL_MF_WRLOCK, &pagelist);
 
-	if (ret < 0) {
-		err = ret;
-		goto up_out;
-	}
-
-	vma_iter_init(&vmi, mm, start);
-	prev = vma_prev(&vmi);
-	for_each_vma_range(vmi, vma, end) {
-		err = mbind_range(&vmi, vma, &prev, start, end, new);
-		if (err)
-			break;
+	if (nr_failed < 0) {
+		err = nr_failed;
+	} else {
+		vma_iter_init(&vmi, mm, start);
+		prev = vma_prev(&vmi);
+		for_each_vma_range(vmi, vma, end) {
+			err = mbind_range(&vmi, vma, &prev, start, end, new);
+			if (err)
+				break;
+		}
 	}
 
 	if (!err) {
-		int nr_failed = 0;
-
 		if (!list_empty(&pagelist)) {
 			WARN_ON_ONCE(flags & MPOL_MF_LAZY);
-			nr_failed = migrate_pages(&pagelist, new_folio, NULL,
+			nr_failed |= migrate_pages(&pagelist, new_folio, NULL,
 				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND, NULL);
-			if (nr_failed)
-				putback_movable_pages(&pagelist);
 		}
-
-		if (((ret > 0) || nr_failed) && (flags & MPOL_MF_STRICT))
+		if (nr_failed && (flags & MPOL_MF_STRICT))
 			err = -EIO;
-	} else {
-up_out:
-		if (!list_empty(&pagelist))
-			putback_movable_pages(&pagelist);
 	}
 
+	if (!list_empty(&pagelist))
+		putback_movable_pages(&pagelist);
+
 	mmap_write_unlock(mm);
 mpol_out:
 	mpol_put(new);
-- 
2.35.3

