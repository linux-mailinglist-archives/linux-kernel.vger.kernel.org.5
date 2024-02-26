Return-Path: <linux-kernel+bounces-80448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A49BB866881
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C0B1F212CB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191D21BDCD;
	Mon, 26 Feb 2024 03:06:40 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D06A18EB8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708916799; cv=none; b=mAzUIgiQOX0SFZlJRjJVkTHhVmsifZHMRHt3pun21dZb/Tnigctgp3zk/Jr3Fw6T/+vZFmDirnTLfMhP1xgRzc6vih3J5t1jCsy7gQqcbIeqbgA1FhFLXot2n89nkfz+vYJMl7ANrrNnVozJ7akMNmJheS8QxdGvvs8G2fiQ1b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708916799; c=relaxed/simple;
	bh=bOo6ompPxEjsShhZOqBiAWkLgDaqfCbo8j/HY5Q8F4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EEcp6dQFElWJi9sNdGExMq6RExfKcG1k1IpHoSxpdURpfv2/a+bqnBT9jM3k+IFFhrDQ93ALbdGiX/1XmWcrfaIq5emU1vuE6OtE4PJFejN5EekttKsA71BLf2le7ID7SRfMMSkPE3E/i42pPapRi0NImSEGBlYx6geI9xjfqRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-3c-65dc002ffdf6
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
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
Subject: [RESEND PATCH v8 5/8] mm: Separate move/undo doing on folio list from migrate_pages_batch()
Date: Mon, 26 Feb 2024 12:06:10 +0900
Message-Id: <20240226030613.22366-6-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240226030613.22366-1-byungchul@sk.com>
References: <20240226030613.22366-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXC9ZZnoa4Bw51UgytbWSzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	jfd32Qv6dSoWzXnI3sC4UrmLkZNDQsBEYkF3ByOM3dt7hg3EZhNQl7hx4ycziC0iYCZxsPUP
	O4jNLHCXSeJAP1iNsECKxN3J38FsFgFViYP37oHV8AqYSsxe8ZYFYqa8xOoNB4DmcHBwAs15
	/98QJCwEVPK39yrQWi6gkvdsElc6trBC1EtKHFxxg2UCI+8CRoZVjEKZeWW5iZk5JnoZlXmZ
	FXrJ+bmbGIGBv6z2T/QOxk8Xgg8xCnAwKvHwLvhwO1WINbGsuDL3EKMEB7OSCG+4zM1UId6U
	xMqq1KL8+KLSnNTiQ4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxSDYxTrXaYzOrinGnB
	+X7XlfuLHN81fbstrP787pK/m45/Eet+c2XzvCshq7vO5H7O+m9Vs1fYqW7vos7J3lqrWjtl
	H+px1wY2GF2+98WyuXvaZ6V1+ovasvLDwqaGv5pb++xnzoqE3ckCH1qtjtS6O5wU5RZcUbzo
	4R21jdvLfVLfi64+ONsnWfSTEktxRqKhFnNRcSIAlFm963gCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrKvPcCfV4OQlM4s569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZdx4f5e9oF+nYtGch+wNjCuVuxg5OSQETCR6e8+wgdhsAuoSN278ZAaxRQTM
	JA62/mEHsZkF7jJJHOgHqxEWSJG4O/k7mM0ioCpx8N49sBpeAVOJ2SveskDMlJdYveEA0BwO
	Dk6gOe//G4KEhYBK/vZeZZzAyLWAkWEVo0hmXlluYmaOqV5xdkZlXmaFXnJ+7iZGYBgvq/0z
	cQfjl8vuhxgFOBiVeHgXfLidKsSaWFZcmXuIUYKDWUmEN1zmZqoQb0piZVVqUX58UWlOavEh
	RmkOFiVxXq/w1AQhgfTEktTs1NSC1CKYLBMHp1QD4xnnJfa9v8VUskR+vYviY+g12GM8qy2y
	qkFCPttR5o+kxdn4ogsvDaW/7btgmLZz7mrO7YHbuNkmCiiFmAQWqFy2X2F01DXWdu1rk6bf
	L5SrT6xdrzzVL+zI8rUb3BcW2TAlzK/cIrBT+ku186IHK1iStiz28BSrvlkRc/ajwKErieLr
	vZknK7EUZyQaajEXFScCAI1XUVNfAgAA
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


