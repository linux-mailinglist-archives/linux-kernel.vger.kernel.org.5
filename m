Return-Path: <linux-kernel+bounces-80368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A706C866766
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 01:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B93C2816A6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 00:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B35D2FA;
	Mon, 26 Feb 2024 00:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsmE5a/O"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495068BF1
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708909078; cv=none; b=ckcyTBklbMRJItPx/FiUtPWzWXkQqyxHyigB9sE+avssFfCEr56KkDhOHbvPAeXLsflPb5leyCVyhjD9L0Qp26SZK95GnZ8w/pkrxA/ApZtQ1+RVQQwRCQNFDDD/J1QGP0Fd6NsYspcbBbXkcLb3deAvBXLWvxGhAZuebAAPMtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708909078; c=relaxed/simple;
	bh=CtX34RBUciFcsMKMYUdNAjqsFbos8BsafvSXZJzhT38=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WPTirWAdYNuPIotVwuF41/9LiLy/PU2QWTZZbD/YdcIZlbr4HE0FOjQVXnP/SN5miHABXXRJh6wSaz6enoofd2HtaKQ7ifDX/IFSdbaamo1Y1fUZmXsnqvu/PkX7ZKzlEZludikoOfA504201YtVM1pa6P1N/Bl4kGF+CLGNrlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsmE5a/O; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d93edfa76dso21787365ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 16:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708909075; x=1709513875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o+qnvS94w9j3asRgT4N2c6CzHzKjC/brNsXbrYMqqhc=;
        b=RsmE5a/OyeGMlF1veD1yuXCK8zwkwqeRxLGpTLO5UjG8Qa/dTrzjNzkqEEgLhjmG/s
         Z6hL1xmLIib1bLrY4OF9QqYnwbMD6Dvx1eTRAq0Gtt9laW6ZS6QGHKPQo1mmslRBpplp
         +cFbZWbZs3YVBm2ZLxZg3lkTtm0+t3Onpvr9B3pNS9X7Y3gt0UOAhFtzcJ8qYVqixRUj
         b4yYimHjyWscea19CBkPfpcYswmeUi1ko1WsnsmaXZ0CHpOcXL7MkZR58LGLOKrIbtDQ
         65hMLooXvx9SnwEvKVmcC19GxJnembv1pprXrIylCllx69TtRxR/9ZTA9LGWqkUcwvJq
         a1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708909075; x=1709513875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+qnvS94w9j3asRgT4N2c6CzHzKjC/brNsXbrYMqqhc=;
        b=pmnIcLUmfftm1c9lrfNZToBl8biKyJ7K8brIDkEqE0M/mVYld5WmrfbrJo0GZUjUhg
         wjXbyC+u2Piuk94JadpnBoCLlnZj9CCfy1DmJ9yXvodPzd3xKVCUYGcbAWnMMvm+eI+1
         xCauZi9/T/QRqHxZH5ey5cjKruBsz6divbF+VMpwrXkzSpZmu7Z6xNWinZY4P3Kg1Mub
         MGMScLl+AHK/+cV5j4EOomTBykiC/gmaZaedWXyCIDdmY+C076SpG6h31EXVrqX8qo0D
         /NtZ7hdSmojKqqQDFemz1CGpXbQXxcUFXQIv/rQCxo6kvPw9NsylusQbegwc/tHAVObM
         TAXw==
X-Gm-Message-State: AOJu0YwIsi2JNXGqWam6V2jFtEFYFuNxWTI6VcwQRxneDpSBK1X0Malj
	RAF1ILXbMha3y/b7F4zxgE9tXqXRrzjoYKGMjegJaUSm5PwZfNVj
X-Google-Smtp-Source: AGHT+IEEnPIrezItgpQtz9vMVuK973GBAY4uUa4MDgiciRSiYNpMa0fD9CU4OWpdrUxvsNp+guEXdg==
X-Received: by 2002:a17:903:11c9:b0:1dc:7887:7723 with SMTP id q9-20020a17090311c900b001dc78877723mr8144378plh.61.1708909075362;
        Sun, 25 Feb 2024 16:57:55 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:fae4:3bff:fecb:410])
        by smtp.gmail.com with ESMTPSA id mq3-20020a170902fd4300b001d949e663d5sm2741392plb.31.2024.02.25.16.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 16:57:55 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	sj@kernel.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Minchan Kim <minchan@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH v2] mm: madvise: pageout: ignore references rather than clearing young
Date: Mon, 26 Feb 2024 13:57:39 +1300
Message-Id: <20240226005739.24350-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

While doing MADV_PAGEOUT, the current code will clear PTE young
so that vmscan won't read young flags to allow the reclamation
of madvised folios to go ahead.
It seems we can do it by directly ignoring references, thus we
can remove tlb flush in madvise and rmap overhead in vmscan.

Regarding the side effect, in the original code, if a parallel
thread runs side by side to access the madvised memory with the
thread doing madvise, folios will get a chance to be re-activated
by vmscan (though the time gap is actually quite small since
checking PTEs is done immediately after clearing PTEs young). But
with this patch, they will still be reclaimed. But this behaviour
doing PAGEOUT and doing access at the same time is quite silly
like DoS. So probably, we don't need to care. Or ignoring the
new access during the quite small time gap is even better.

For DAMON's DAMOS_PAGEOUT based on physical address region, we
still keep its behaviour as is since a physical address might
be mapped by multiple processes. MADV_PAGEOUT based on virtual
address is actually much more aggressive on reclamation. To
untouch paddr's DAMOS_PAGEOUT, we simply pass ignore_references
as false in reclaim_pages().

A microbench as below has shown 6% decrement on the latency of
MADV_PAGEOUT,

 #define PGSIZE 4096
 main()
 {
 	int i;
 #define SIZE 512*1024*1024
 	volatile long *p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
 			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

 	for (i = 0; i < SIZE/sizeof(long); i += PGSIZE / sizeof(long))
 		p[i] =  0x11;

 	madvise(p, SIZE, MADV_PAGEOUT);
 }

w/o patch                    w/ patch
root@10:~# time ./a.out      root@10:~# time ./a.out
real	0m49.634s            real   0m46.334s
user	0m0.637s             user   0m0.648s
sys	0m47.434s            sys    0m44.265s

Cc: SeongJae Park <sj@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 -v2:
 Add description about paddr's pageout of DAMON in commit message (Thanks
 for SeongJae's help on clarifying lots of things about DAMON)

 mm/damon/paddr.c |  2 +-
 mm/internal.h    |  2 +-
 mm/madvise.c     |  8 ++++----
 mm/vmscan.c      | 12 +++++++-----
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 081e2a325778..5e6dc312072c 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -249,7 +249,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 put_folio:
 		folio_put(folio);
 	}
-	applied = reclaim_pages(&folio_list);
+	applied = reclaim_pages(&folio_list, false);
 	cond_resched();
 	return applied * PAGE_SIZE;
 }
diff --git a/mm/internal.h b/mm/internal.h
index 93e229112045..36c11ea41f47 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -868,7 +868,7 @@ extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
         unsigned long, unsigned long);
 
 extern void set_pageblock_order(void);
-unsigned long reclaim_pages(struct list_head *folio_list);
+unsigned long reclaim_pages(struct list_head *folio_list, bool ignore_references);
 unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 					    struct list_head *folio_list);
 /* The ALLOC_WMARK bits are used as an index to zone->watermark */
diff --git a/mm/madvise.c b/mm/madvise.c
index abde3edb04f0..44a498c94158 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -386,7 +386,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			return 0;
 		}
 
-		if (pmd_young(orig_pmd)) {
+		if (!pageout && pmd_young(orig_pmd)) {
 			pmdp_invalidate(vma, addr, pmd);
 			orig_pmd = pmd_mkold(orig_pmd);
 
@@ -410,7 +410,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 huge_unlock:
 		spin_unlock(ptl);
 		if (pageout)
-			reclaim_pages(&folio_list);
+			reclaim_pages(&folio_list, true);
 		return 0;
 	}
 
@@ -490,7 +490,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 
 		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
 
-		if (pte_young(ptent)) {
+		if (!pageout && pte_young(ptent)) {
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
 			ptent = pte_mkold(ptent);
@@ -524,7 +524,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		pte_unmap_unlock(start_pte, ptl);
 	}
 	if (pageout)
-		reclaim_pages(&folio_list);
+		reclaim_pages(&folio_list, true);
 	cond_resched();
 
 	return 0;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 402c290fbf5a..ba2f37f46a73 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2102,7 +2102,8 @@ static void shrink_active_list(unsigned long nr_to_scan,
 }
 
 static unsigned int reclaim_folio_list(struct list_head *folio_list,
-				      struct pglist_data *pgdat)
+				      struct pglist_data *pgdat,
+				      bool ignore_references)
 {
 	struct reclaim_stat dummy_stat;
 	unsigned int nr_reclaimed;
@@ -2115,7 +2116,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 		.no_demotion = 1,
 	};
 
-	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &dummy_stat, false);
+	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &dummy_stat, ignore_references);
 	while (!list_empty(folio_list)) {
 		folio = lru_to_folio(folio_list);
 		list_del(&folio->lru);
@@ -2125,7 +2126,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 	return nr_reclaimed;
 }
 
-unsigned long reclaim_pages(struct list_head *folio_list)
+unsigned long reclaim_pages(struct list_head *folio_list, bool ignore_references)
 {
 	int nid;
 	unsigned int nr_reclaimed = 0;
@@ -2147,11 +2148,12 @@ unsigned long reclaim_pages(struct list_head *folio_list)
 			continue;
 		}
 
-		nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));
+		nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid),
+						   ignore_references);
 		nid = folio_nid(lru_to_folio(folio_list));
 	} while (!list_empty(folio_list));
 
-	nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));
+	nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid), ignore_references);
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 
-- 
2.34.1


