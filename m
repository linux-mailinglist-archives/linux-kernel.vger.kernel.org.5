Return-Path: <linux-kernel+bounces-148058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 430D18A7D24
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AE39B20E74
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F547C0AA;
	Wed, 17 Apr 2024 07:34:25 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA9A6F062
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339265; cv=none; b=RS9W4YVo7BVMm6sXXTK2n9DW9/NbrZjL8bPeyzQ9VUDM636xmp2IGRl/I0Ehh/eQFyEM/mQmbo5C4TfJU1YCkwy4xDkaqV+pzzTwsdXqmwzOe0dObnJtgg7K+16Uv1/mTcHYflYzfWgE+GzZv04OZD7W5hIObNDYS2z6Amp8omQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339265; c=relaxed/simple;
	bh=w15d3DQ2DjMA6BbDIKYVP7vubWk99uX3kubuVSEXQFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IhT6jk7kV+Sjt+oXKsFJyYbOL6ZahAYUbSGAph9GyAHxSH6kkLtycbB35uKMKhL5WodskjXlqZBWdXCURvY3dNmlu5E/DngsjC/FXlgHntA/N+uUhjOkEhnrhQcOHypOIv9hK0tmgRbwhwvfbuoxRAt6lI7Pmsh2rn8YXAj+Wus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-a7-661f77e22826
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
Subject: [PATCH v9 5/8] mm: separate move/undo parts from migrate_pages_batch()
Date: Wed, 17 Apr 2024 16:18:44 +0900
Message-Id: <20240417071847.29584-6-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240417071847.29584-1-byungchul@sk.com>
References: <20240417071847.29584-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXC9ZZnoe6jcvk0g9fbFSzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	x1tHmQu+a1c0TjvK2sA4XbmLkZNDQsBE4uDm2Uww9pr9F9lBbDYBdYkbN34yg9giAmYSB1v/
	gMWZBe4ySRzoZ+ti5OAQFvCX+P5bByTMIqAq0Tn7NyuIzStgKtE0aRrUSHmJ1RsOgI3hBBqz
	uXkNG4gtBFTz/cRHIJsLqOY9m0TnmhY2iAZJiYMrbrBMYORdwMiwilEoM68sNzEzx0QvozIv
	s0IvOT93EyMw8JfV/onewfjpQvAhRgEORiUeXoMouTQh1sSy4srcQ4wSHMxKIrwtwrJpQrwp
	iZVVqUX58UWlOanFhxilOViUxHmNvpWnCAmkJ5akZqemFqQWwWSZODilGhh9nrSuKjAyXn3u
	/rKimY53Gt9Hrg1kbck2llLbsCtjetiHncd87hXkWjyOV3r58n6J7Evv2PMGUziPz67onWwv
	+EDm8IesT7GdAS2Tty39ldYfKC38SpiB4d+HqRpdFe2Xtiimx+fPOLepVHZD472AcrkPB7re
	815/tMys4enjz/sL7FYeFtBTYinOSDTUYi4qTgQAo8zHzXgCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrPuoXD7NoHmjmMWc9WvYLD5v+Mdm
	8WJDO6PF1/W/mC2efupjsTg89ySrxeVdc9gs7q35z2pxftdaVosdS/cxWVw6sIDJ4njvASaL
	+fc+s1ls3jSV2eL4lKmMFr9/ABWfnDWZxUHQ43trH4vHzll32T0WbCr12LxCy2PxnpdMHptW
	dbJ5bPo0id3j3blz7B4nZvxm8Zh3MtDj/b6rbB6LX3xg8tj6y86jceo1No/Pm+QC+KO4bFJS
	czLLUov07RK4Mj7eOspc8F27onHaUdYGxunKXYycHBICJhJr9l9kB7HZBNQlbtz4yQxiiwiY
	SRxs/QMWZxa4yyRxoJ+ti5GDQ1jAX+L7bx2QMIuAqkTn7N+sIDavgKlE06RpTBAj5SVWbzgA
	NoYTaMzm5jVsILYQUM33Ex/ZJjByLWBkWMUokplXlpuYmWOqV5ydUZmXWaGXnJ+7iREYxstq
	/0zcwfjlsvshRgEORiUeXoMouTQh1sSy4srcQ4wSHMxKIrwtwrJpQrwpiZVVqUX58UWlOanF
	hxilOViUxHm9wlMThATSE0tSs1NTC1KLYLJMHJxSDYwh1+w64rKdty7ffpGv4Vh9dPKcZ9KS
	xrvjXtn+3Trx895M86ObBRK7tkypvLtDXpXH7x/rRZXtzuWNmcdklduXVp8SCmxy/M4ddm5q
	5vFIZ73y8Ff9vguOyAU4TmQ4L5R46dzezlydah0Hzm0SZYwaOiFPr/itb+nbcqyNP616Hvea
	G9wlIUosxRmJhlrMRcWJAKjdQyJfAgAA
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
index 73a052a382f1..fed3a65e9bbe 100644
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
@@ -1767,42 +1842,11 @@ static int migrate_pages_batch(struct list_head *from,
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
@@ -1811,20 +1855,8 @@ static int migrate_pages_batch(struct list_head *from,
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


