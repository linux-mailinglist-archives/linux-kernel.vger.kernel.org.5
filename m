Return-Path: <linux-kernel+bounces-163112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BAB8B65E1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4577E1C214F9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1D419069B;
	Mon, 29 Apr 2024 22:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbJ0bdvv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D807BB1A;
	Mon, 29 Apr 2024 22:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714430698; cv=none; b=nkVNEzJjW48mwmO9b5FkSuhMWyh3vBkNuyLgNWJm2BoTy/pWOupUWf7LB7zHSt93R42SaYPVhlx0gLTPxwGnPKeEYW7+yGKNfpt/SDnoLtkFhRVAh+mSSVhndK4itzbSe7nOFQgPimw8lS+Y/O6/qzdsZhYxPC8fUxTA5pJrtbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714430698; c=relaxed/simple;
	bh=rwwV4wTGLuB7cXfIuHMVaw/1/iqBkA9IvJM9bkgx3iA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VP/cW25N8OKlHXgdHlWLzPcLqPe12lNNvwdcjFjcKhREDSDK1M6bJapcinq4os2PnidbLOd5drZWYLuXrxOcM2guYMyaX6wnbcmw8yMLD696R2Pqc58VnzjTH/0rjSgmleHTH6xNC0ADoxtsYyhsmHZJPiLTKkz9EZ2vIR36swc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbJ0bdvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449E6C4AF1A;
	Mon, 29 Apr 2024 22:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714430698;
	bh=rwwV4wTGLuB7cXfIuHMVaw/1/iqBkA9IvJM9bkgx3iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DbJ0bdvvJr2AhyvwGW00oQOrnMQxpSdiFdku3EzCB5Pf8qz+KnEJFsIAVPLJBn7LI
	 fOmyoYPY5MRuwZBCR4WOPYYORsXzorDi6hZCCTY3ru1Roc99UOGEbt5PTsJSlX/pnH
	 2redK7kxVZ2sOhiba6ZfAHri7YUTXSUDxn3qDmziId7BKHORNZ9aiMm8QskuSYduu9
	 MRbV+SnE0GV7XVoDV142dQ3T5d8IXuFLGuaud4T5UEBhwFbJAeAYHQgYOzW23RlSV8
	 qlmXHL6C1cICKky/VRmu1IKaIVZPSOHqyfco/70bB7Psw5rlpb5iCxgzlWwiBiMrfN
	 cRbHEA0E3zluQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] mm/vmscan: remove ignore_references argument of reclaim_pages()
Date: Mon, 29 Apr 2024 15:44:50 -0700
Message-Id: <20240429224451.67081-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240429224451.67081-1-sj@kernel.org>
References: <20240429224451.67081-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All reclaim_pages() callers are setting 'ignore_references' parameter
'true'.  In other words, the parameter is not really being used.  Remove
the argument to make it simple.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 2 +-
 mm/internal.h    | 2 +-
 mm/madvise.c     | 4 ++--
 mm/vmscan.c      | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 974edef1740d..18797c1b419b 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -283,7 +283,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 	}
 	if (install_young_filter)
 		damos_destroy_filter(filter);
-	applied = reclaim_pages(&folio_list, true);
+	applied = reclaim_pages(&folio_list);
 	cond_resched();
 	return applied * PAGE_SIZE;
 }
diff --git a/mm/internal.h b/mm/internal.h
index c5552d35d995..b2c75b12014e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1052,7 +1052,7 @@ extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
         unsigned long, unsigned long);
 
 extern void set_pageblock_order(void);
-unsigned long reclaim_pages(struct list_head *folio_list, bool ignore_references);
+unsigned long reclaim_pages(struct list_head *folio_list);
 unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 					    struct list_head *folio_list);
 /* The ALLOC_WMARK bits are used as an index to zone->watermark */
diff --git a/mm/madvise.c b/mm/madvise.c
index c49fef453491..a77893462b92 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -423,7 +423,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 huge_unlock:
 		spin_unlock(ptl);
 		if (pageout)
-			reclaim_pages(&folio_list, true);
+			reclaim_pages(&folio_list);
 		return 0;
 	}
 
@@ -547,7 +547,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		pte_unmap_unlock(start_pte, ptl);
 	}
 	if (pageout)
-		reclaim_pages(&folio_list, true);
+		reclaim_pages(&folio_list);
 	cond_resched();
 
 	return 0;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 49bd94423961..fc9dd9a24739 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2150,7 +2150,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 	return nr_reclaimed;
 }
 
-unsigned long reclaim_pages(struct list_head *folio_list, bool ignore_references)
+unsigned long reclaim_pages(struct list_head *folio_list)
 {
 	int nid;
 	unsigned int nr_reclaimed = 0;
@@ -2173,11 +2173,11 @@ unsigned long reclaim_pages(struct list_head *folio_list, bool ignore_references
 		}
 
 		nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid),
-						   ignore_references);
+						   true);
 		nid = folio_nid(lru_to_folio(folio_list));
 	} while (!list_empty(folio_list));
 
-	nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid), ignore_references);
+	nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid), true);
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 
-- 
2.39.2


