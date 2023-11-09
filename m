Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362767E62FF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 05:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjKIE7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 23:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjKIE7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 23:59:25 -0500
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A48826A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 20:59:22 -0800 (PST)
X-AuditID: a67dfc5b-d6dff70000001748-08-654c67260dbd
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     kernel_team@skhynix.com, akpm@linux-foundation.org,
        ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        david@redhat.com, peterz@infradead.org, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Subject: [v4 3/3] mm: Pause migrc mechanism at high memory pressure
Date:   Thu,  9 Nov 2023 13:59:08 +0900
Message-Id: <20231109045908.54996-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231109045908.54996-1-byungchul@sk.com>
References: <20231109045908.54996-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXC9ZZnka5auk+qwelPlhZz1q9hs/i84R+b
        xYsN7YwWX9f/YrZ4+qmPxeLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHF910NGi+O9B5gs
        Nm+aymzx+wdQ3ZwpVhYnZ01mcRDw+N7ax+KxYFOpx+YVWh6L97xk8ti0qpPNY9OnSewe786d
        Y/c4MeM3i8fOh5Ye804Gerzfd5XNY+svO4/Pm+Q83s1/yxbAF8Vlk5Kak1mWWqRvl8CV0dZ5
        hbngkkbFhmmTmRsY9yp0MXJySAiYSJx4/Jsdxj6y+QsriM0moC5x48ZPZhBbRMBM4mDrH6Aa
        Lg5mgQdMEnPfrmAESQgLOEtcWbYUrIFFQFXi0ddLYA28AqYSp5bvZ4MYKi+xesMBsDgn0KA/
        U7eD2UJANVM/72cEGSoh8J5N4lrPJhaIBkmJgytusExg5F3AyLCKUSgzryw3MTPHRC+jMi+z
        Qi85P3cTIzDwl9X+id7B+OlC8CFGAQ5GJR7eG3+9U4VYE8uKK3MPMUpwMCuJ8F4w8UkV4k1J
        rKxKLcqPLyrNSS0+xCjNwaIkzmv0rTxFSCA9sSQ1OzW1ILUIJsvEwSnVwGhpcOxog7Usc6nS
        3ZPG2gc+lHz/ESA8N0roMu+TXyyvLu1e4hAnekVFJrnt2ulUb+bNd9cG6eYv/vOj4GLvpnrr
        t9/ifvfpsj+vSf3hta7NxO6e6voVOg9C31bduJcfdib927m7qzyu6jsE7hXL/qv0OSBg8u7/
        d37b3Hp/bEJKr76K+1vxc8uVWIozEg21mIuKEwGeu2x4eAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrKuW7pNq8Hm/psWc9WvYLD5v+Mdm
        8WJDO6PF1/W/mC2efupjsTg89ySrxeVdc9gs7q35z2pxftdaVosdS/cxWVw6sIDJ4vquh4wW
        x3sPMFls3jSV2eL3D6C6OVOsLE7OmsziIOjxvbWPxWPBplKPzSu0PBbvecnksWlVJ5vHpk+T
        2D3enTvH7nFixm8Wj50PLT3mnQz0eL/vKpvH4hcfmDy2/rLz+LxJzuPd/LdsAfxRXDYpqTmZ
        ZalF+nYJXBltnVeYCy5pVGyYNpm5gXGvQhcjJ4eEgInEkc1fWEFsNgF1iRs3fjKD2CICZhIH
        W/+wdzFycTALPGCSmPt2BSNIQljAWeLKsqVgDSwCqhKPvl4Ca+AVMJU4tXw/G8RQeYnVGw6A
        xTmBBv2Zuh3MFgKqmfp5P+MERq4FjAyrGEUy88pyEzNzTPWKszMq8zIr9JLzczcxAsN4We2f
        iTsYv1x2P8QowMGoxMObMMU7VYg1say4MvcQowQHs5II7wUTn1Qh3pTEyqrUovz4otKc1OJD
        jNIcLErivF7hqQlCAumJJanZqakFqUUwWSYOTqkGRoumyRe5bvQu2mp/qXhmFv/C3ycP91or
        7ah/v/pgyuy8yI6gN8cLeF8mBvlcE2Yu+3HnqP+xsOvTG0X1fZbslFjx5YOO7hSOky0FvqYf
        P81xC140Y1ZYhAfXmnr1hPYFsc6czwslvvfG9BdNfCASuGfVjHN/2/kmmocLv895sD80KfC2
        KcOjCUosxRmJhlrMRcWJAJtDSMRfAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regression was observed when the system is in high memory pressure with
swap on, where migrc keeps expanding its pending queue and the page
allocator keeps flushing the queue and freeing folios at the same time,
which is meaningless. So temporarily prevented migrc from expanding its
pending queue on that condition.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 mm/internal.h   | 17 ++++++++++++++++
 mm/migrate.c    | 53 ++++++++++++++++++++++++++++++++++++++++++++++++-
 mm/page_alloc.c | 13 ++++++++++++
 3 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/mm/internal.h b/mm/internal.h
index a2b6f0321729..971f2dded4a6 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1159,6 +1159,8 @@ struct vma_prepare {
 	struct vm_area_struct *remove2;
 };
 
+extern atomic_t migrc_pause_cnt;
+
 /*
  * Initialize the page when allocated from buddy allocator.
  */
@@ -1202,6 +1204,21 @@ static inline bool can_migrc_test(void)
 	return current->can_migrc && current->tlb_ubc_ro.flush_required;
 }
 
+static inline void migrc_pause(void)
+{
+	atomic_inc(&migrc_pause_cnt);
+}
+
+static inline void migrc_resume(void)
+{
+	atomic_dec(&migrc_pause_cnt);
+}
+
+static inline bool migrc_paused(void)
+{
+	return !!atomic_read(&migrc_pause_cnt);
+}
+
 /*
  * Return the number of folios pending TLB flush that have yet to get
  * freed in the zone.
diff --git a/mm/migrate.c b/mm/migrate.c
index 9ab7794b0390..bde4f49d0144 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -100,6 +100,16 @@ static void migrc_undo_folios(struct folio *fsrc, struct folio *fdst)
 static void migrc_expand_req(struct folio *fsrc, struct folio *fdst,
 			     struct migrc_req *req)
 {
+	/*
+	 * If migrc has been paused in the middle of unmap because of
+	 * high memory pressure, then the folios that have already been
+	 * marked as pending should get back.
+	 */
+	if (!req) {
+		migrc_undo_folios(fsrc, fdst);
+		return;
+	}
+
 	if (req->nid == -1)
 		req->nid = folio_nid(fsrc);
 
@@ -147,6 +157,12 @@ static void migrc_req_end(struct migrc_req *req)
 	llist_add(&req->llnode, &NODE_DATA(req->nid)->migrc_reqs);
 }
 
+/*
+ * Increase on entry of handling high memory pressure e.g. direct
+ * reclaim, decrease on the exit. See __alloc_pages_slowpath().
+ */
+atomic_t migrc_pause_cnt = ATOMIC_INIT(0);
+
 /*
  * Gather folios and architecture specific data to handle.
  */
@@ -213,6 +229,31 @@ static void fold_ubc_ro_to_migrc(struct migrc_req *req)
 	tlb_ubc_ro->flush_required = false;
 }
 
+static void fold_migrc_to_ubc(struct migrc_req *req)
+{
+	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+
+	if (!req)
+		return;
+
+	/*
+	 * Fold the req's data to tlb_ubc.
+	 */
+	arch_tlbbatch_fold(&tlb_ubc->arch, &req->arch);
+
+	/*
+	 * Reset the req's data.
+	 */
+	arch_tlbbatch_clear(&req->arch);
+
+	/*
+	 * req->arch might be empty. However, conservatively set
+	 * ->flush_required to true so that try_to_unmap_flush() can
+	 * check it anyway.
+	 */
+	tlb_ubc->flush_required = true;
+}
+
 bool isolate_movable_page(struct page *page, isolate_mode_t mode)
 {
 	struct folio *folio = folio_get_nontail_page(page);
@@ -1791,7 +1832,7 @@ static int migrate_pages_batch(struct list_head *from,
 	/*
 	 * Apply migrc only to numa migration for now.
 	 */
-	if (reason == MR_DEMOTION || reason == MR_NUMA_MISPLACED)
+	if (!migrc_paused() && (reason == MR_DEMOTION || reason == MR_NUMA_MISPLACED))
 		mreq = migrc_req_start();
 
 	for (pass = 0; pass < nr_pass && retry; pass++) {
@@ -1829,6 +1870,16 @@ static int migrate_pages_batch(struct list_head *from,
 				continue;
 			}
 
+			/*
+			 * In case that the system is in high memory
+			 * pressure, give up migrc mechanism this turn.
+			 */
+			if (unlikely(mreq && migrc_paused())) {
+				fold_migrc_to_ubc(mreq);
+				migrc_req_end(mreq);
+				mreq = NULL;
+			}
+
 			can_migrc_init();
 			rc = migrate_folio_unmap(get_new_folio, put_new_folio,
 					private, folio, &dst, mode, reason,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 914e93ab598e..c920ad48f741 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3926,6 +3926,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	unsigned int cpuset_mems_cookie;
 	unsigned int zonelist_iter_cookie;
 	int reserve_flags;
+	bool migrc_paused = false;
 
 restart:
 	compaction_retries = 0;
@@ -4057,6 +4058,16 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	if (page)
 		goto got_pg;
 
+	/*
+	 * The system is in very high memory pressure. Pause migrc from
+	 * expanding its pending queue temporarily.
+	 */
+	if (!migrc_paused) {
+		migrc_pause();
+		migrc_paused = true;
+		migrc_flush_free_folios(NULL);
+	}
+
 	/* Caller is not willing to reclaim, we can't balance anything */
 	if (!can_direct_reclaim)
 		goto nopage;
@@ -4184,6 +4195,8 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	warn_alloc(gfp_mask, ac->nodemask,
 			"page allocation failure: order:%u", order);
 got_pg:
+	if (migrc_paused)
+		migrc_resume();
 	return page;
 }
 
-- 
2.17.1

