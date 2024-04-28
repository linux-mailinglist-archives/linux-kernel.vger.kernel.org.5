Return-Path: <linux-kernel+bounces-161357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7415C8B4B18
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1503D1F2156E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A41356B7E;
	Sun, 28 Apr 2024 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLSf53Bh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709B15675F
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714298585; cv=none; b=lKcYwdvsrwxrMKjna4FtWIz1UfJGb2KeegTq/kMdh543vd6vZFqAYR9uUfvW4dQnMDFgc+yU9dxStRqjn8+bhj2NBW9+6YfoU7nrKL6//09CHyN9OVp9rP6roxQcj0GvU/ATRxdANQY9VUA4fg+/eRiC5qXYF5Wl9annU64kCZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714298585; c=relaxed/simple;
	bh=v4+B+wAdJjjC79dafL8cg9PLjD5MqzOi4QWIoVMKNQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fw5EkeLf96OEx9WSAN9+KEjSZTEcgHhWCJWP5pKdb08/R/VNy5NRVh8HqGUiB8iDYyFEGn2jLn1y4QU8Cznba1YIUVM8jpeCAnmFUFmCmafo4FCM9zc0g4KKGbc2utdo+HejhU8O0Pd77y+h80v6sw6QEbSLmcg7aTzr60XRWzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLSf53Bh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7426C4AF17;
	Sun, 28 Apr 2024 10:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714298585;
	bh=v4+B+wAdJjjC79dafL8cg9PLjD5MqzOi4QWIoVMKNQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MLSf53Bhof91jifuFJSJQ6+7g1PdgK+heeu185/hZxBRUagYjsIHNpgdcPM7rl8Gk
	 4C82ZOkNyq8ixRzlIGypuAkbyNMJrDlPI2zbe9QkEiVQGzOpebN9IBy1OsP8ojhB5R
	 lp3zdHFUoVan4xgllEIsHSHtzU0+R1iAk4KooRPvAeZ+dkoWSIsMwOCNfQe7ZTNhWd
	 JWe5s2HzDziC3lEQ8oCl8qbft/gkdaNBwat7F0naOj8I2n7mkIjjHksMvQiC9mdWzJ
	 P0ZVljS2gxytnk/WdHsOqgCLdyVc87zG+Q5DHpFouev6aJa+YF7TPZI1fTyqDyVSQN
	 qWxmnQsep/wOA==
From: alexs@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	izik.eidus@ravellosystems.com
Cc: "Alex Shi (tencent)" <alexs@kernel.org>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH 2/4] mm/ksm: rename variable mm_slot to ksm_slot in unmerge_and_remove_all_rmap_items
Date: Sun, 28 Apr 2024 18:06:16 +0800
Message-ID: <20240428100619.3332036-2-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240428100619.3332036-1-alexs@kernel.org>
References: <20240428100619.3332036-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

To distinguish ksm_mm_slot and mm_slot for better code readability,
rename ksm_mm_slot variable as ksm_slot in function
unmerge_and_remove_all_rmap_items. No function changes.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index d2c4eb98816d..6efa33c48381 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1196,7 +1196,7 @@ static int remove_all_stable_nodes(void)
 
 static int unmerge_and_remove_all_rmap_items(void)
 {
-	struct ksm_mm_slot *mm_slot;
+	struct ksm_mm_slot *ksm_slot;
 	struct mm_slot *slot;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
@@ -1208,11 +1208,11 @@ static int unmerge_and_remove_all_rmap_items(void)
 	ksm_scan.ksm_slot = mm_slot_entry(slot, struct ksm_mm_slot, slot);
 	spin_unlock(&ksm_mmlist_lock);
 
-	for (mm_slot = ksm_scan.ksm_slot; mm_slot != &ksm_mm_head;
-	     mm_slot = ksm_scan.ksm_slot) {
-		VMA_ITERATOR(vmi, mm_slot->slot.mm, 0);
+	for (ksm_slot = ksm_scan.ksm_slot; ksm_slot != &ksm_mm_head;
+	     ksm_slot = ksm_scan.ksm_slot) {
+		VMA_ITERATOR(vmi, ksm_slot->slot.mm, 0);
 
-		mm = mm_slot->slot.mm;
+		mm = ksm_slot->slot.mm;
 		mmap_read_lock(mm);
 
 		/*
@@ -1232,19 +1232,19 @@ static int unmerge_and_remove_all_rmap_items(void)
 		}
 
 mm_exiting:
-		remove_trailing_rmap_items(&mm_slot->rmap_list);
+		remove_trailing_rmap_items(&ksm_slot->rmap_list);
 		mmap_read_unlock(mm);
 
 		spin_lock(&ksm_mmlist_lock);
-		slot = list_entry(mm_slot->slot.mm_node.next,
+		slot = list_entry(ksm_slot->slot.mm_node.next,
 				  struct mm_slot, mm_node);
 		ksm_scan.ksm_slot = mm_slot_entry(slot, struct ksm_mm_slot, slot);
 		if (ksm_test_exit(mm)) {
-			hash_del(&mm_slot->slot.hash);
-			list_del(&mm_slot->slot.mm_node);
+			hash_del(&ksm_slot->slot.hash);
+			list_del(&ksm_slot->slot.mm_node);
 			spin_unlock(&ksm_mmlist_lock);
 
-			mm_slot_free(mm_slot_cache, mm_slot);
+			mm_slot_free(mm_slot_cache, ksm_slot);
 			clear_bit(MMF_VM_MERGEABLE, &mm->flags);
 			clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
 			mmdrop(mm);
-- 
2.43.0


