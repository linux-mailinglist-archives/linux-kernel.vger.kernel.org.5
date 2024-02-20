Return-Path: <linux-kernel+bounces-72394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B7E85B2C7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A932834E6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C6F58105;
	Tue, 20 Feb 2024 06:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AZmUa5vy"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C7A42A82;
	Tue, 20 Feb 2024 06:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708409806; cv=none; b=n/B8EE5D2vHrxZCs27NT028QCRbLlv+tNfAqFpzk7HNd4mUZNP5R+KF+AaDk8GbEMMPJN5s+N/c+6qK0GwUW8C873bjrFvTyVa4ftVnJOQYhixrlGQMeOh+FQAjUeH0KleKAIhxNGzAJgERe6/Qq5GJhhnUtSBbWFieKs0yMPHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708409806; c=relaxed/simple;
	bh=LIueseMyntBN5OyyfNrrAAkw3er3Md9N5sglNvCjGjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VTta/CndeTZ1TDCVnZluiLnIix6swuQ6Cp2z2SHr4+DTlg0L7Fh89OTtLtA8Lt2oT5QFmYuJ6zsVkvamp5NhEQ6EcrRv9ED1LywtS7kwLhjSjDIRoMckv3lMr/2ghLjQglNfa2Rese9M1G+L2UK9Kc5QlFFsBQm6X2GWOSLtYyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AZmUa5vy; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708409800; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=e1Tqntxb8WJb9FYr5Qxi5sfx12zCF/ZdGBjlVEejyj0=;
	b=AZmUa5vyhAL3guw+eYMx7HxHk6vIrhUGbhCJhbzMFPmBP6qTJk9KkG2eF0MwEMg+nu/p0Bwt0BBKJR9p0F12sp/wt5dDQaZibba/B0i2+5UmakQTBQhc94OTojaJqIXQ9B0I2Fpir+kAO6VVX20M6DhEqEwUFdPfe4Z3unj+aAo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W0veO0d_1708409798;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W0veO0d_1708409798)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 14:16:39 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: mgorman@techsingularity.net,
	vbabka@suse.cz,
	ziy@nvidia.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] mm: compaction: update the cc->nr_migratepages when allocating or freeing the freepages
Date: Tue, 20 Feb 2024 14:16:31 +0800
Message-Id: <6440493f18da82298152b6305d6b41c2962a3ce6.1708409245.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently we will use 'cc->nr_freepages >= cc->nr_migratepages' comparison
to ensure that enough freepages are isolated in isolate_freepages(), however
it just decreases the cc->nr_freepages without updating cc->nr_migratepages
in compaction_alloc(), which will waste more CPU cycles and cause too many
freepages to be isolated.

So we should also update the cc->nr_migratepages when allocating or freeing
the freepages to avoid isolating excess freepages. And I can see fewer free
pages are scanned and isolated when running thpcompact on my Arm64 server:
                                       k6.7         k6.7_patched
Ops Compaction pages isolated      120692036.00   118160797.00
Ops Compaction migrate scanned     131210329.00   154093268.00
Ops Compaction free scanned       1090587971.00  1080632536.00
Ops Compact scan efficiency               12.03          14.26

Moreover, I did not see an obvious latency improvements, this is likely because
isolating freepages is not the bottleneck in the thpcompact test case.
                              k6.7                  k6.7_patched
Amean     fault-both-1      1089.76 (   0.00%)     1080.16 *   0.88%*
Amean     fault-both-3      1616.48 (   0.00%)     1636.65 *  -1.25%*
Amean     fault-both-5      2266.66 (   0.00%)     2219.20 *   2.09%*
Amean     fault-both-7      2909.84 (   0.00%)     2801.90 *   3.71%*
Amean     fault-both-12     4861.26 (   0.00%)     4733.25 *   2.63%*
Amean     fault-both-18     7351.11 (   0.00%)     6950.51 *   5.45%*
Amean     fault-both-24     9059.30 (   0.00%)     9159.99 *  -1.11%*
Amean     fault-both-30    10685.68 (   0.00%)    11399.02 *  -6.68%*

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
Hi Andrew, please use this patch to replace below 2 old patches. Thanks.
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-everything-2024-02-20-04-19&id=cb30899d456d64fb83ee3e3d95cd9fbb18735d87
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-everything-2024-02-20-04-19&id=65713d1c4fc498d35dc1f7c1234ef815aa128429

Changes from v2:
 - Add acked tag from Mel.
 - Fix the mm_compaction_migratepages trace event.
Changes from v1:
 - Rebased on the latest mm-unstable branch.
---
 include/trace/events/compaction.h |  6 +++---
 mm/compaction.c                   | 12 ++++++++++--
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/compaction.h b/include/trace/events/compaction.h
index 2b2a975efd20..d05759d18538 100644
--- a/include/trace/events/compaction.h
+++ b/include/trace/events/compaction.h
@@ -78,10 +78,10 @@ DEFINE_EVENT(mm_compaction_isolate_template, mm_compaction_fast_isolate_freepage
 #ifdef CONFIG_COMPACTION
 TRACE_EVENT(mm_compaction_migratepages,
 
-	TP_PROTO(struct compact_control *cc,
+	TP_PROTO(unsigned int nr_migratepages,
 		unsigned int nr_succeeded),
 
-	TP_ARGS(cc, nr_succeeded),
+	TP_ARGS(nr_migratepages, nr_succeeded),
 
 	TP_STRUCT__entry(
 		__field(unsigned long, nr_migrated)
@@ -90,7 +90,7 @@ TRACE_EVENT(mm_compaction_migratepages,
 
 	TP_fast_assign(
 		__entry->nr_migrated = nr_succeeded;
-		__entry->nr_failed = cc->nr_migratepages - nr_succeeded;
+		__entry->nr_failed = nr_migratepages - nr_succeeded;
 	),
 
 	TP_printk("nr_migrated=%lu nr_failed=%lu",
diff --git a/mm/compaction.c b/mm/compaction.c
index 4494b2914386..218089b29f13 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1798,6 +1798,7 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
 	dst = list_entry(cc->freepages.next, struct folio, lru);
 	list_del(&dst->lru);
 	cc->nr_freepages--;
+	cc->nr_migratepages--;
 
 	return dst;
 }
@@ -1813,6 +1814,7 @@ static void compaction_free(struct folio *dst, unsigned long data)
 
 	list_add(&dst->lru, &cc->freepages);
 	cc->nr_freepages++;
+	cc->nr_migratepages++;
 }
 
 /* possible outcome of isolate_migratepages */
@@ -2435,7 +2437,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 	unsigned long last_migrated_pfn;
 	const bool sync = cc->mode != MIGRATE_ASYNC;
 	bool update_cached;
-	unsigned int nr_succeeded = 0;
+	unsigned int nr_succeeded = 0, nr_migratepages;
 
 	/*
 	 * These counters track activities during zone compaction.  Initialize
@@ -2553,11 +2555,17 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 				pageblock_start_pfn(cc->migrate_pfn - 1));
 		}
 
+		/*
+		 * Record the number of pages to migrate since the
+		 * compaction_alloc/free() will update cc->nr_migratepages
+		 * properly.
+		 */
+		nr_migratepages = cc->nr_migratepages;
 		err = migrate_pages(&cc->migratepages, compaction_alloc,
 				compaction_free, (unsigned long)cc, cc->mode,
 				MR_COMPACTION, &nr_succeeded);
 
-		trace_mm_compaction_migratepages(cc, nr_succeeded);
+		trace_mm_compaction_migratepages(nr_migratepages, nr_succeeded);
 
 		/* All pages were either migrated or will be released */
 		cc->nr_migratepages = 0;
-- 
2.39.3


