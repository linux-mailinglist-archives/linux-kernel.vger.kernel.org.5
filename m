Return-Path: <linux-kernel+bounces-161356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CAB8B4B17
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95E571C20A88
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AAE56462;
	Sun, 28 Apr 2024 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svEjzXYQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8C64A02
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 10:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714298583; cv=none; b=G115KVZd2DdBR/e20QEIHqGAQ6ljocovqcjMAdzfOweS2zGIf9eAPYSx0+GmCzkrilsOsl2d2jGgsG8KSoCZu0iYuRiAfl+XQM0RcZAD5oc6DA2pwieMHoVu4xw/E+bQFQTGDkLue4yNiZa4lNP2rE/TVE9sL6mZEUSDCMh+M+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714298583; c=relaxed/simple;
	bh=HHMumcOA0H9IUBHkmzzjX+ZWQGYMXSboQb1ob6VnGX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r3clmwv1iaPHVqlM5pNO9tvlCD+JcXMbcyvR8R9XNpjUr27P1yjEik7IqY51XDLfQc2MqkXOXIM1cAJ8HDo7ysEydRgNzU9wYevpLpgaLIrxyqjPAqbyUOGDbLd9IgqvVpQJJxIgH6dURcyS298uejWbms5t9cW76bkyaKEE7f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svEjzXYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D9AC113CC;
	Sun, 28 Apr 2024 10:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714298583;
	bh=HHMumcOA0H9IUBHkmzzjX+ZWQGYMXSboQb1ob6VnGX0=;
	h=From:To:Cc:Subject:Date:From;
	b=svEjzXYQEbgXg3LvM1M3DpRi706lXfPWsUc9ig1+xRxOLV/8FiH50xiTLPkEjm/zQ
	 sOrixVduy/1RS3bGAkpgM+rL/3H9zErUBN4f4ndGalpE/VoHe+EACMAKWf6I5q7BZT
	 HQEUg4vEiSZaUxgQn5052xdW3M6qvFmfQywYvFeDaWBf9jIRz+52oi85sN5FiHzSJv
	 XMy8wKI008t/us8P1Om08taBdd7ts4IjF83eA8mPmEqdJlG5CGoZHQi/L+Gapqgcjf
	 Xecu3YuZ/Cbnd+/n5h3AL7XfM9Bph9z7fiFugJDiJm3kDjoD91/IisPbXOODrr53ox
	 aXGkgid45qLPA==
From: alexs@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	izik.eidus@ravellosystems.com
Cc: "Alex Shi (tencent)" <alexs@kernel.org>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH 1/4] mm/ksm: rename mm_slot members to ksm_slot for better readability.
Date: Sun, 28 Apr 2024 18:06:15 +0800
Message-ID: <20240428100619.3332036-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

mm_slot is a struct of mm, and ksm_mm_slot is named the same again in
ksm_scan struct. Furthermore, the ksm_mm_slot pointer is named as
mm_slot again in functions, beside with 'struct mm_slot' variable.
That makes code readability pretty worse.

struct ksm_mm_slot {
        struct mm_slot slot;
	...
};

struct ksm_scan {
        struct ksm_mm_slot *mm_slot;
	...
};

int __ksm_enter(struct mm_struct *mm)
{
        struct ksm_mm_slot *mm_slot;
        struct mm_slot *slot;
	...

So let's rename the mm_slot member to ksm_slot in ksm_scan, and ksm_slot
for ksm_mm_slot* type variables in functions to reduce this confusing.

 struct ksm_scan {
-       struct ksm_mm_slot *mm_slot;
+       struct ksm_mm_slot *ksm_slot;

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 84 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 486c9974f8e2..d2c4eb98816d 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -131,7 +131,7 @@ struct ksm_mm_slot {
 
 /**
  * struct ksm_scan - cursor for scanning
- * @mm_slot: the current mm_slot we are scanning
+ * @ksm_slot: the current ksm_slot we are scanning
  * @address: the next address inside that to be scanned
  * @rmap_list: link to the next rmap to be scanned in the rmap_list
  * @seqnr: count of completed full scans (needed when removing unstable node)
@@ -139,7 +139,7 @@ struct ksm_mm_slot {
  * There is only the one ksm_scan instance of this cursor structure.
  */
 struct ksm_scan {
-	struct ksm_mm_slot *mm_slot;
+	struct ksm_mm_slot *ksm_slot;
 	unsigned long address;
 	struct ksm_rmap_item **rmap_list;
 	unsigned long seqnr;
@@ -187,7 +187,7 @@ struct ksm_stable_node {
 
 /**
  * struct ksm_rmap_item - reverse mapping item for virtual addresses
- * @rmap_list: next rmap_item in mm_slot's singly-linked rmap_list
+ * @rmap_list: next rmap_item in ksm_slot's singly-linked rmap_list
  * @anon_vma: pointer to anon_vma for this mm,address, when in stable tree
  * @nid: NUMA node id of unstable tree in which linked (may not match page)
  * @mm: the memory structure this rmap_item is pointing into
@@ -242,7 +242,7 @@ static struct ksm_mm_slot ksm_mm_head = {
 	.slot.mm_node = LIST_HEAD_INIT(ksm_mm_head.slot.mm_node),
 };
 static struct ksm_scan ksm_scan = {
-	.mm_slot = &ksm_mm_head,
+	.ksm_slot = &ksm_mm_head,
 };
 
 static struct kmem_cache *rmap_item_cache;
@@ -1205,11 +1205,11 @@ static int unmerge_and_remove_all_rmap_items(void)
 	spin_lock(&ksm_mmlist_lock);
 	slot = list_entry(ksm_mm_head.slot.mm_node.next,
 			  struct mm_slot, mm_node);
-	ksm_scan.mm_slot = mm_slot_entry(slot, struct ksm_mm_slot, slot);
+	ksm_scan.ksm_slot = mm_slot_entry(slot, struct ksm_mm_slot, slot);
 	spin_unlock(&ksm_mmlist_lock);
 
-	for (mm_slot = ksm_scan.mm_slot; mm_slot != &ksm_mm_head;
-	     mm_slot = ksm_scan.mm_slot) {
+	for (mm_slot = ksm_scan.ksm_slot; mm_slot != &ksm_mm_head;
+	     mm_slot = ksm_scan.ksm_slot) {
 		VMA_ITERATOR(vmi, mm_slot->slot.mm, 0);
 
 		mm = mm_slot->slot.mm;
@@ -1238,7 +1238,7 @@ static int unmerge_and_remove_all_rmap_items(void)
 		spin_lock(&ksm_mmlist_lock);
 		slot = list_entry(mm_slot->slot.mm_node.next,
 				  struct mm_slot, mm_node);
-		ksm_scan.mm_slot = mm_slot_entry(slot, struct ksm_mm_slot, slot);
+		ksm_scan.ksm_slot = mm_slot_entry(slot, struct ksm_mm_slot, slot);
 		if (ksm_test_exit(mm)) {
 			hash_del(&mm_slot->slot.hash);
 			list_del(&mm_slot->slot.mm_node);
@@ -1260,7 +1260,7 @@ static int unmerge_and_remove_all_rmap_items(void)
 error:
 	mmap_read_unlock(mm);
 	spin_lock(&ksm_mmlist_lock);
-	ksm_scan.mm_slot = &ksm_mm_head;
+	ksm_scan.ksm_slot = &ksm_mm_head;
 	spin_unlock(&ksm_mmlist_lock);
 	return err;
 }
@@ -2565,7 +2565,7 @@ static bool should_skip_rmap_item(struct page *page,
 static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 {
 	struct mm_struct *mm;
-	struct ksm_mm_slot *mm_slot;
+	struct ksm_mm_slot *ksm_slot;
 	struct mm_slot *slot;
 	struct vm_area_struct *vma;
 	struct ksm_rmap_item *rmap_item;
@@ -2575,8 +2575,8 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 	if (list_empty(&ksm_mm_head.slot.mm_node))
 		return NULL;
 
-	mm_slot = ksm_scan.mm_slot;
-	if (mm_slot == &ksm_mm_head) {
+	ksm_slot = ksm_scan.ksm_slot;
+	if (ksm_slot == &ksm_mm_head) {
 		advisor_start_scan();
 		trace_ksm_start_scan(ksm_scan.seqnr, ksm_rmap_items);
 
@@ -2616,23 +2616,23 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 			root_unstable_tree[nid] = RB_ROOT;
 
 		spin_lock(&ksm_mmlist_lock);
-		slot = list_entry(mm_slot->slot.mm_node.next,
+		slot = list_entry(ksm_slot->slot.mm_node.next,
 				  struct mm_slot, mm_node);
-		mm_slot = mm_slot_entry(slot, struct ksm_mm_slot, slot);
-		ksm_scan.mm_slot = mm_slot;
+		ksm_slot = mm_slot_entry(slot, struct ksm_mm_slot, slot);
+		ksm_scan.ksm_slot = ksm_slot;
 		spin_unlock(&ksm_mmlist_lock);
 		/*
 		 * Although we tested list_empty() above, a racing __ksm_exit
 		 * of the last mm on the list may have removed it since then.
 		 */
-		if (mm_slot == &ksm_mm_head)
+		if (ksm_slot == &ksm_mm_head)
 			return NULL;
 next_mm:
 		ksm_scan.address = 0;
-		ksm_scan.rmap_list = &mm_slot->rmap_list;
+		ksm_scan.rmap_list = &ksm_slot->rmap_list;
 	}
 
-	slot = &mm_slot->slot;
+	slot = &ksm_slot->slot;
 	mm = slot->mm;
 	vma_iter_init(&vmi, mm, ksm_scan.address);
 
@@ -2662,7 +2662,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 			if (PageAnon(*page)) {
 				flush_anon_page(vma, *page, ksm_scan.address);
 				flush_dcache_page(*page);
-				rmap_item = get_next_rmap_item(mm_slot,
+				rmap_item = get_next_rmap_item(ksm_slot,
 					ksm_scan.rmap_list, ksm_scan.address);
 				if (rmap_item) {
 					ksm_scan.rmap_list =
@@ -2687,7 +2687,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 	if (ksm_test_exit(mm)) {
 no_vmas:
 		ksm_scan.address = 0;
-		ksm_scan.rmap_list = &mm_slot->rmap_list;
+		ksm_scan.rmap_list = &ksm_slot->rmap_list;
 	}
 	/*
 	 * Nuke all the rmap_items that are above this current rmap:
@@ -2696,9 +2696,9 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 	remove_trailing_rmap_items(ksm_scan.rmap_list);
 
 	spin_lock(&ksm_mmlist_lock);
-	slot = list_entry(mm_slot->slot.mm_node.next,
+	slot = list_entry(ksm_slot->slot.mm_node.next,
 			  struct mm_slot, mm_node);
-	ksm_scan.mm_slot = mm_slot_entry(slot, struct ksm_mm_slot, slot);
+	ksm_scan.ksm_slot = mm_slot_entry(slot, struct ksm_mm_slot, slot);
 	if (ksm_scan.address == 0) {
 		/*
 		 * We've completed a full scan of all vmas, holding mmap_lock
@@ -2709,11 +2709,11 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 		 * or when all VM_MERGEABLE areas have been unmapped (and
 		 * mmap_lock then protects against race with MADV_MERGEABLE).
 		 */
-		hash_del(&mm_slot->slot.hash);
-		list_del(&mm_slot->slot.mm_node);
+		hash_del(&ksm_slot->slot.hash);
+		list_del(&ksm_slot->slot.mm_node);
 		spin_unlock(&ksm_mmlist_lock);
 
-		mm_slot_free(mm_slot_cache, mm_slot);
+		mm_slot_free(mm_slot_cache, ksm_slot);
 		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
 		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
 		mmap_read_unlock(mm);
@@ -2725,14 +2725,14 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 		 * spin_unlock(&ksm_mmlist_lock) run, the "mm" may
 		 * already have been freed under us by __ksm_exit()
 		 * because the "mm_slot" is still hashed and
-		 * ksm_scan.mm_slot doesn't point to it anymore.
+		 * ksm_scan.ksm_slot doesn't point to it anymore.
 		 */
 		spin_unlock(&ksm_mmlist_lock);
 	}
 
 	/* Repeat until we've completed scanning the whole list */
-	mm_slot = ksm_scan.mm_slot;
-	if (mm_slot != &ksm_mm_head)
+	ksm_slot = ksm_scan.ksm_slot;
+	if (ksm_slot != &ksm_mm_head)
 		goto next_mm;
 
 	advisor_stop_scan();
@@ -2968,15 +2968,15 @@ EXPORT_SYMBOL_GPL(ksm_madvise);
 
 int __ksm_enter(struct mm_struct *mm)
 {
-	struct ksm_mm_slot *mm_slot;
+	struct ksm_mm_slot *ksm_slot;
 	struct mm_slot *slot;
 	int needs_wakeup;
 
-	mm_slot = mm_slot_alloc(mm_slot_cache);
-	if (!mm_slot)
+	ksm_slot = mm_slot_alloc(mm_slot_cache);
+	if (!ksm_slot)
 		return -ENOMEM;
 
-	slot = &mm_slot->slot;
+	slot = &ksm_slot->slot;
 
 	/* Check ksm_run too?  Would need tighter locking */
 	needs_wakeup = list_empty(&ksm_mm_head.slot.mm_node);
@@ -2996,7 +2996,7 @@ int __ksm_enter(struct mm_struct *mm)
 	if (ksm_run & KSM_RUN_UNMERGE)
 		list_add_tail(&slot->mm_node, &ksm_mm_head.slot.mm_node);
 	else
-		list_add_tail(&slot->mm_node, &ksm_scan.mm_slot->slot.mm_node);
+		list_add_tail(&slot->mm_node, &ksm_scan.ksm_slot->slot.mm_node);
 	spin_unlock(&ksm_mmlist_lock);
 
 	set_bit(MMF_VM_MERGEABLE, &mm->flags);
@@ -3011,40 +3011,40 @@ int __ksm_enter(struct mm_struct *mm)
 
 void __ksm_exit(struct mm_struct *mm)
 {
-	struct ksm_mm_slot *mm_slot;
+	struct ksm_mm_slot *ksm_slot;
 	struct mm_slot *slot;
 	int easy_to_free = 0;
 
 	/*
 	 * This process is exiting: if it's straightforward (as is the
-	 * case when ksmd was never running), free mm_slot immediately.
+	 * case when ksmd was never running), free ksm_slot immediately.
 	 * But if it's at the cursor or has rmap_items linked to it, use
 	 * mmap_lock to synchronize with any break_cows before pagetables
-	 * are freed, and leave the mm_slot on the list for ksmd to free.
+	 * are freed, and leave the ksm_slot on the list for ksmd to free.
 	 * Beware: ksm may already have noticed it exiting and freed the slot.
 	 */
 
 	spin_lock(&ksm_mmlist_lock);
 	slot = mm_slot_lookup(mm_slots_hash, mm);
-	mm_slot = mm_slot_entry(slot, struct ksm_mm_slot, slot);
-	if (mm_slot && ksm_scan.mm_slot != mm_slot) {
-		if (!mm_slot->rmap_list) {
+	ksm_slot = mm_slot_entry(slot, struct ksm_mm_slot, slot);
+	if (ksm_slot && ksm_scan.ksm_slot != ksm_slot) {
+		if (!ksm_slot->rmap_list) {
 			hash_del(&slot->hash);
 			list_del(&slot->mm_node);
 			easy_to_free = 1;
 		} else {
 			list_move(&slot->mm_node,
-				  &ksm_scan.mm_slot->slot.mm_node);
+				  &ksm_scan.ksm_slot->slot.mm_node);
 		}
 	}
 	spin_unlock(&ksm_mmlist_lock);
 
 	if (easy_to_free) {
-		mm_slot_free(mm_slot_cache, mm_slot);
+		mm_slot_free(mm_slot_cache, ksm_slot);
 		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
 		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
 		mmdrop(mm);
-	} else if (mm_slot) {
+	} else if (ksm_slot) {
 		mmap_write_lock(mm);
 		mmap_write_unlock(mm);
 	}
-- 
2.43.0


