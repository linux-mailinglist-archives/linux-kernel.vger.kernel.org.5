Return-Path: <linux-kernel+bounces-149562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF0C8A92E1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F792821D6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A787C0A9;
	Thu, 18 Apr 2024 06:15:57 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8AC7172F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420956; cv=none; b=DQ9yQjq9VKoyS9zmEsjSNp4Ry7wuVa9leVW7oxbaA3EBQA2iJKexlJ54C8ViCFEz/LHdFyWucgoPdVkfMQz3tF+oJRW09tOYci7HOzW3uh71J39v3S4cxtDpNJWGLpoTUpswkJLUvoCfpfQl0fx5y+LihPjhgHSmywA+MMZD5sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420956; c=relaxed/simple;
	bh=5vr7eA15l7aC3iKALPqXV/+DvmE0/SlA4rrgE0RMbig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UIVYz/hlSR+kbKWuj21qcE/a6qxuR/7K/PKUG2eaNpdcdKu/pq1ax3qztRqILLeCUwzjKfl3lAtB328NBxy5oB4G7RU0vQnOJ+ANTO53eWYTVgLZNkHMK+nnj067RkJZ72hvFTHNFQv7o3Tv4QQMqyW/FbEVmI9sLdw9z6ZZODo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-11-6620ba936039
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
Subject: [PATCH v9 rebase on mm-unstable 5/8] mm: separate move/undo parts from migrate_pages_batch()
Date: Thu, 18 Apr 2024 15:15:33 +0900
Message-Id: <20240418061536.11645-6-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240418061536.11645-1-byungchul@sk.com>
References: <20240418061536.11645-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXC9ZZnoe7kXQppBu1tPBZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP4CKT86azOIg4PG9tY/FY+esu+weCzaVemxeoeWxeM9LJo9NqzrZPDZ9
	msTu8e7cOXaPEzN+s3jMOxno8X7fVTaPrb/sPBqnXmPz+LxJLoAvissmJTUnsyy1SN8ugStj
	75yjTAXftSs+397J1MA4XbmLkZNDQsBE4sTf6eww9plTvWwgNpuAusSNGz+ZQWwRATOJg61/
	wGqYBe4ySRzoB6sRFkiVaJ78A8xmEVCVaNo0nwXE5hUwldh7ooEJYqa8xOoNB8DmcALN6X9/
	iLGLkYNDCKjmwt+QLkYuoJL3bBJP999jhqiXlDi44gbLBEbeBYwMqxiFMvPKchMzc0z0Mirz
	Miv0kvNzNzECA39Z7Z/oHYyfLgQfYhTgYFTi4T15QD5NiDWxrLgy9xCjBAezkghvi7BsmhBv
	SmJlVWpRfnxRaU5q8SFGaQ4WJXFeo2/lKUIC6YklqdmpqQWpRTBZJg5OqQZGdX7XsynZE0+E
	Z/vu+VjVmMx/y/vtjfzZO0yXC9i+6N/mfKhhsvvUcyv4JPhq56RtEeAUC/hRdPdWwYn+yBjh
	jvW3L19gL+d5ZmL6wkGqpO/S3nitrA39X9ovF9udNGnaY9VddmMH+2e37lCWJU3KGzkcM0uV
	ezQmb5s0cdHTT2/Z17HpG+gpsRRnJBpqMRcVJwIAKYYWW3gCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC5WfdrDt5l0KawYdiiznr17BZfN7wj83i
	xYZ2Rouv638xWzz91MdicXjuSVaLy7vmsFncW/Of1eL8rrWsFjuW7mOyuHRgAZPF8d4DTBbz
	731ms9i8aSqzxfEpUxktfv8AKj45azKLg6DH99Y+Fo+ds+6yeyzYVOqxeYWWx+I9L5k8Nq3q
	ZPPY9GkSu8e7c+fYPU7M+M3iMe9koMf7fVfZPBa/+MDksfWXnUfj1GtsHp83yQXwR3HZpKTm
	ZJalFunbJXBl7J1zlKngu3bF59s7mRoYpyt3MXJySAiYSJw51csGYrMJqEvcuPGTGcQWETCT
	ONj6hx3EZha4yyRxoB+sRlggVaJ58g8wm0VAVaJp03wWEJtXwFRi74kGJoiZ8hKrNxwAm8MJ
	NKf//SHGLkYODiGgmgt/QyYwci1gZFjFKJKZV5abmJljqlecnVGZl1mhl5yfu4kRGMTLav9M
	3MH45bL7IUYBDkYlHt4TB+TThFgTy4orcw8xSnAwK4nwtgjLpgnxpiRWVqUW5ccXleakFh9i
	lOZgURLn9QpPTRASSE8sSc1OTS1ILYLJMnFwSjUw7jqRr3HKa6OsD7fHqjuLFfZEbDptccVF
	4N7hLGFJ8RX609df+7ruYJFkyNU5kotTlT6/qcqZqBDO8n9r3Oc5+Vwvr5UEXrQqYcyvnt1c
	sm7Gi23HLT7re6ofyF7IysQ47Q/LTa3s+f80nJ5FZ2nUmbo9FBGKu2rokNl3IkNEyd32dsba
	2e2rlFiKMxINtZiLihMB6iLaqV4CAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Functionally, no change.  This is a preparation for migrc mechanism that
requires to use separated folio lists for its own handling during
migration.  Refactored migrate_pages_batch() and separated move/undo
parts from migrate_pages_batch().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 mm/migrate.c | 134 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 83 insertions(+), 51 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c7692f303fa7..f9ed7a2b8720 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1609,6 +1609,81 @@ static int migrate_hugetlbs(struct list_head *from, new_folio_t get_new_folio,
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
@@ -1631,7 +1706,7 @@ static int migrate_pages_batch(struct list_head *from,
 	int pass = 0;
 	bool is_thp = false;
 	bool is_large = false;
-	struct folio *folio, *folio2, *dst = NULL, *dst2;
+	struct folio *folio, *folio2, *dst = NULL;
 	int rc, rc_saved = 0, nr_pages;
 	LIST_HEAD(unmap_folios);
 	LIST_HEAD(dst_folios);
@@ -1790,42 +1865,11 @@ static int migrate_pages_batch(struct list_head *from,
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
@@ -1834,20 +1878,8 @@ static int migrate_pages_batch(struct list_head *from,
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


