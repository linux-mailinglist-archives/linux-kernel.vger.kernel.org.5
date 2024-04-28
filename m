Return-Path: <linux-kernel+bounces-161359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5928B4B1B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C471CB2123B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D719B5A4FF;
	Sun, 28 Apr 2024 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KO5K1UOv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AC85A0F7
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 10:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714298589; cv=none; b=VNw0caGNrhBpfI9i15DZG1Sse/oGCG7obwwKZ0wQfb8mmv0Sl/6f17EbWzUGu9FJe6Tdt/8h+UV27M778fwsQ1ua3jSE7mIq5VQIqsAPg0rfA4oAvTLl7bWVcw7LamkDjYAm6oUBWAOzCC4ckp5BS6FKArdy3HfjayRjtLwbgTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714298589; c=relaxed/simple;
	bh=Uzl73+0oYcqvZx1LI81e5vJnRXOSv47I6sL1y4jODW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVQDjIKovIO4kGj7CQZPrvHjMTYb/0dus1m0rGKMOrsG6JK7nO3k6pOXjFDHS9oUWLACSHuwTIxOZT6cgvh1x2a8+rukhtCnNcS4s0kfFw6RIH8zZ1vdR5ET6n0z34kLsDAEdbxnDwLEXT/v5tO1vQt83WjaD3BF9+6k2zT1kaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KO5K1UOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6276BC113CC;
	Sun, 28 Apr 2024 10:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714298588;
	bh=Uzl73+0oYcqvZx1LI81e5vJnRXOSv47I6sL1y4jODW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KO5K1UOv2oq/q3c2ouC7bsIp40DeLYo95z/jC2RvcvRtkLvS32NMSVxDRoIH3yH9O
	 Ah9ULQOgyIMFL0Lg7O2uKT7+bUkojFyvyVqS5myzchwzmGedUOQxXhVk2Lo0e4q7YV
	 3DNhU5ldZhc9OZcfcgcnHJrQZ/LH3dE6fZ2YX6IoF8uPahFswX6BdI+DS3vIk0pnys
	 R65yImyWxmwwxH6kOOw7I9g+tKMB9hJoBJPRYMiX73kJLxz3WdRHLHrejMYJfHwS/u
	 Y7DZOxGAF8OuDNeAw9u0duoiUV4hc8uiKohzWRiYk8s+tnOncrcwyox/MHBnr6voD3
	 023S30vVPlv4g==
From: alexs@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	izik.eidus@ravellosystems.com
Cc: "Alex Shi (tencent)" <alexs@kernel.org>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH 4/4] mm/ksm: rename mm_slot for get_next_rmap_item
Date: Sun, 28 Apr 2024 18:06:18 +0800
Message-ID: <20240428100619.3332036-4-alexs@kernel.org>
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
rename parameter "struct ksm_mm_slot *mm_slot", as "struct ksm_mm_slot
*ksm_slot".  No function change.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 22d2132f83a4..2d10f1aef123 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2465,7 +2465,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 	}
 }
 
-static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
+static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *ksm_slot,
 					    struct ksm_rmap_item **rmap_list,
 					    unsigned long addr)
 {
@@ -2485,7 +2485,7 @@ static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
 	rmap_item = alloc_rmap_item();
 	if (rmap_item) {
 		/* It has already been zeroed */
-		rmap_item->mm = mm_slot->slot.mm;
+		rmap_item->mm = ksm_slot->slot.mm;
 		rmap_item->mm->ksm_rmap_items++;
 		rmap_item->address = addr;
 		rmap_item->rmap_list = *rmap_list;
-- 
2.43.0


