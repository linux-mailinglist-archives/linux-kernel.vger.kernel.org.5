Return-Path: <linux-kernel+bounces-70751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AF8859BD4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0FD5B21F24
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7686520B04;
	Mon, 19 Feb 2024 06:04:34 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3340208C0
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708322673; cv=none; b=GlnwXyx4qFmFoT50gcDnaX6z4aDthd6C/ALEq7j4VnYPUVQo6Oyu75yuElqUbxBTPibzX5gIrxn9bNKjDCCZAgIErN1DvreWWWPFYojeSQxy4p18Dt/EPFgXA9ElLDYQSc9FCFx2KsqKinuv0a35453u/BZoALA9UkoLsfhVOcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708322673; c=relaxed/simple;
	bh=bOo6ompPxEjsShhZOqBiAWkLgDaqfCbo8j/HY5Q8F4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=sWRy4QfmGgcf4tjL6F1SRF1tBEIGlS9vB04pDbh+GJs8rTN0igVJ6NnKxPKCT+/nXX8/wgkNrWaG57k6B7RUB4uqavmg2AHPMTORdpSWiqaCin3kC8g/CBeSRrBKlnbM5al+NjTrVV3vbW6w9OnDG/ZBiZnZoj5rY0mEtaXJVNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-d1-65d2ef61c8ab
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	namit@vmware.com,
	vernhao@tencent.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: [PATCH v8 5/8] mm: Separate move/undo doing on folio list from migrate_pages_batch()
Date: Mon, 19 Feb 2024 15:04:04 +0900
Message-Id: <20240219060407.25254-6-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240219060407.25254-1-byungchul@sk.com>
References: <20240219060407.25254-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsXC9ZZnkW7i+0upBneumFnMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8X1XQ8ZLY73HmCy
	mH/vM5vF5k1TmS2OT5nKaPH7B1DHyVmTWRwEPb639rF47Jx1l91jwaZSj80rtDwW73nJ5LFp
	VSebx6ZPk9g93p07x+5xYsZvFo95JwM93u+7yuax9ZedR+PUa2wenzfJebyb/5YtgD+KyyYl
	NSezLLVI3y6BK+PG+7vsBf06FYvmPGRvYFyp3MXIwSEhYCIxb5tEFyMnmLn7bBcLiM0moC5x
	48ZPZhBbRMBM4mDrH/YuRi4OZoGPTBKrv3eAFQkLxEpc71zACmKzCKhKnHq3ixHE5hUwlTh9
	awMzxFB5idUbDjCD7OIEGrT7oBBIWAio5MTVyUwgMyUEmtklNr/qY4eol5Q4uOIGywRG3gWM
	DKsYhTLzynITM3NM9DIq8zIr9JLzczcxAqNhWe2f6B2Mny4EH2IU4GBU4uHNELmUKsSaWFZc
	mXuIUYKDWUmE173pQqoQb0piZVVqUX58UWlOavEhRmkOFiVxXqNv5SlCAumJJanZqakFqUUw
	WSYOTqkGxnk8+/yOLvv+8I/xwn2Na/5d+PX8Rcjy+a2pRzo45Ga+ia0Vq9t8aFFxUXfPT+1w
	wVKRyS5nrvxxMlh53evaglbeyEAJ3XcP5tlrLL1rvFbwhs+95P3ieaYvu6PbXON8Tn4Ufjb3
	d3tpyYSj4mvPnlbMfhmqGmO7pK9sk/fCgknPOXPYzmdffKbEUpyRaKjFXFScCADdv3sSggIA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsXC5WfdrJv4/lKqwYtv2hZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+u7HjJa
	HO89wGQx/95nNovNm6YyWxyfMpXR4vcPoI6TsyazOAh5fG/tY/HYOesuu8eCTaUem1doeSze
	85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHvNOBnq833eVzWPxiw9MHlt/2Xk0Tr3G5vF5k5zH
	u/lv2QIEorhsUlJzMstSi/TtErgybry/y17Qr1OxaM5D9gbGlcpdjJwcEgImErvPdrGA2GwC
	6hI3bvxkBrFFBMwkDrb+Ye9i5OJgFvjIJLH6ewdYkbBArMT1zgWsIDaLgKrEqXe7GEFsXgFT
	idO3NjBDDJWXWL3hAJDNwcEJNGj3QSGQsBBQyYmrk5kmMHItYGRYxSiSmVeWm5iZY6pXnJ1R
	mZdZoZecn7uJERjcy2r/TNzB+OWy+yFGAQ5GJR7eDJFLqUKsiWXFlbmHGCU4mJVEeN2bLqQK
	8aYkVlalFuXHF5XmpBYfYpTmYFES5/UKT00QEkhPLEnNTk0tSC2CyTJxcEo1MKrtOJxvwGzp
	yX+xZLWE7D9HLoHUZLnZwks4zqZtzJT+8UBxU4+oQrrF+RWplt9f8eW8r5UpDf+y8uVNb9lY
	EWveK0qnFjWvst9o//e0/bpYszl/Mjv5met8+++vvx4y5/rCZO7Onklmrexhd95NC1U16bi4
	/ldHSb1d8fud7bMPvyxK9VgXqMRSnJFoqMVcVJwIAEbpRQJqAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Functionally, no change. This is a preparation for migrc mechanism that
requires to use separate folio lists for its own handling at migration.

Refactored migrate_pages_batch() and separated move and undo parts
operating on folio list, from migrate_pages_batch().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 mm/migrate.c | 134 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 83 insertions(+), 51 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 397f2a6e34cb..bbe1ecef4956 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1611,6 +1611,81 @@ static int migrate_hugetlbs(struct list_head *from, new_folio_t get_new_folio,
 	return nr_failed;
 }
 
+static void migrate_folios_move(struct list_head *src_folios,
+		struct list_head *dst_folios,
+		free_folio_t put_new_folio, unsigned long private,
+		enum migrate_mode mode, int reason,
+		struct list_head *ret_folios,
+		struct migrate_pages_stats *stats,
+		int *retry, int *thp_retry, int *nr_failed,
+		int *nr_retry_pages)
+{
+	struct folio *folio, *folio2, *dst, *dst2;
+	bool is_thp;
+	int nr_pages;
+	int rc;
+
+	dst = list_first_entry(dst_folios, struct folio, lru);
+	dst2 = list_next_entry(dst, lru);
+	list_for_each_entry_safe(folio, folio2, src_folios, lru) {
+		is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
+		nr_pages = folio_nr_pages(folio);
+
+		cond_resched();
+
+		rc = migrate_folio_move(put_new_folio, private,
+				folio, dst, mode,
+				reason, ret_folios);
+		/*
+		 * The rules are:
+		 *	Success: folio will be freed
+		 *	-EAGAIN: stay on the unmap_folios list
+		 *	Other errno: put on ret_folios list
+		 */
+		switch(rc) {
+		case -EAGAIN:
+			*retry += 1;
+			*thp_retry += is_thp;
+			*nr_retry_pages += nr_pages;
+			break;
+		case MIGRATEPAGE_SUCCESS:
+			stats->nr_succeeded += nr_pages;
+			stats->nr_thp_succeeded += is_thp;
+			break;
+		default:
+			*nr_failed += 1;
+			stats->nr_thp_failed += is_thp;
+			stats->nr_failed_pages += nr_pages;
+			break;
+		}
+		dst = dst2;
+		dst2 = list_next_entry(dst, lru);
+	}
+}
+
+static void migrate_folios_undo(struct list_head *src_folios,
+		struct list_head *dst_folios,
+		free_folio_t put_new_folio, unsigned long private,
+		struct list_head *ret_folios)
+{
+	struct folio *folio, *folio2, *dst, *dst2;
+
+	dst = list_first_entry(dst_folios, struct folio, lru);
+	dst2 = list_next_entry(dst, lru);
+	list_for_each_entry_safe(folio, folio2, src_folios, lru) {
+		int old_page_state = 0;
+		struct anon_vma *anon_vma = NULL;
+
+		__migrate_folio_extract(dst, &old_page_state, &anon_vma);
+		migrate_folio_undo_src(folio, old_page_state & PAGE_WAS_MAPPED,
+				anon_vma, true, ret_folios);
+		list_del(&dst->lru);
+		migrate_folio_undo_dst(dst, true, put_new_folio, private);
+		dst = dst2;
+		dst2 = list_next_entry(dst, lru);
+	}
+}
+
 /*
  * migrate_pages_batch() first unmaps folios in the from list as many as
  * possible, then move the unmapped folios.
@@ -1633,7 +1708,7 @@ static int migrate_pages_batch(struct list_head *from,
 	int pass = 0;
 	bool is_thp = false;
 	bool is_large = false;
-	struct folio *folio, *folio2, *dst = NULL, *dst2;
+	struct folio *folio, *folio2, *dst = NULL;
 	int rc, rc_saved = 0, nr_pages;
 	LIST_HEAD(unmap_folios);
 	LIST_HEAD(dst_folios);
@@ -1769,42 +1844,11 @@ static int migrate_pages_batch(struct list_head *from,
 		thp_retry = 0;
 		nr_retry_pages = 0;
 
-		dst = list_first_entry(&dst_folios, struct folio, lru);
-		dst2 = list_next_entry(dst, lru);
-		list_for_each_entry_safe(folio, folio2, &unmap_folios, lru) {
-			is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
-			nr_pages = folio_nr_pages(folio);
-
-			cond_resched();
-
-			rc = migrate_folio_move(put_new_folio, private,
-						folio, dst, mode,
-						reason, ret_folios);
-			/*
-			 * The rules are:
-			 *	Success: folio will be freed
-			 *	-EAGAIN: stay on the unmap_folios list
-			 *	Other errno: put on ret_folios list
-			 */
-			switch(rc) {
-			case -EAGAIN:
-				retry++;
-				thp_retry += is_thp;
-				nr_retry_pages += nr_pages;
-				break;
-			case MIGRATEPAGE_SUCCESS:
-				stats->nr_succeeded += nr_pages;
-				stats->nr_thp_succeeded += is_thp;
-				break;
-			default:
-				nr_failed++;
-				stats->nr_thp_failed += is_thp;
-				stats->nr_failed_pages += nr_pages;
-				break;
-			}
-			dst = dst2;
-			dst2 = list_next_entry(dst, lru);
-		}
+		/* Move the unmapped folios */
+		migrate_folios_move(&unmap_folios, &dst_folios,
+				put_new_folio, private, mode, reason,
+				ret_folios, stats, &retry, &thp_retry,
+				&nr_failed, &nr_retry_pages);
 	}
 	nr_failed += retry;
 	stats->nr_thp_failed += thp_retry;
@@ -1813,20 +1857,8 @@ static int migrate_pages_batch(struct list_head *from,
 	rc = rc_saved ? : nr_failed;
 out:
 	/* Cleanup remaining folios */
-	dst = list_first_entry(&dst_folios, struct folio, lru);
-	dst2 = list_next_entry(dst, lru);
-	list_for_each_entry_safe(folio, folio2, &unmap_folios, lru) {
-		int old_page_state = 0;
-		struct anon_vma *anon_vma = NULL;
-
-		__migrate_folio_extract(dst, &old_page_state, &anon_vma);
-		migrate_folio_undo_src(folio, old_page_state & PAGE_WAS_MAPPED,
-				       anon_vma, true, ret_folios);
-		list_del(&dst->lru);
-		migrate_folio_undo_dst(dst, true, put_new_folio, private);
-		dst = dst2;
-		dst2 = list_next_entry(dst, lru);
-	}
+	migrate_folios_undo(&unmap_folios, &dst_folios,
+			put_new_folio, private, ret_folios);
 
 	return rc;
 }
-- 
2.17.1


