Return-Path: <linux-kernel+bounces-46477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F9184404C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AA311F270E7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE9C7BB03;
	Wed, 31 Jan 2024 13:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JZmxo1ii"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2B879938
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706707014; cv=none; b=GRBtkMrwgFh6cP3sY2zTIyWjYrUdqZb/qqhn8L3B4v9O9shSSsTrzzHfYr/sch+lRo0CjGN1eq1d1EPzOdRW0HTag85a99USxUfPFJLGE12B+GazaytAMyeOoWy8kcG4607Rc0oB9lFtX+JVEKaNMsZ6GEi8MNPqDWX+dnaAkp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706707014; c=relaxed/simple;
	bh=U3vvmNEiNsFCDG9xGZjWzjdbxLLxBPphbAH/1T+fgBc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BUpBPU7TVKtGGs4uTj3zXdBq5HSkJ0D6Y4I19a96VhAQ7uTeQCV0WTR+DRhrtmSqX/7pDQj9EZjAj+AjvaHTu2u8pAofVkSwo2OJQqgYHOLv4qA6OyFAXjdigvs2dp58Q4+vTV6uf4FBHvSi8BEizEZ6z86NKzf2CMzKi0WghhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JZmxo1ii; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706707003; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=R4BfaarR7H+2VERwphKn+Lf333CX+5PuQuJGhvUGjOc=;
	b=JZmxo1ii5jxqtCbBIC4cv78oIDn8OzE79ujXrULStacHpRb/+4iVsEi9FQIDulahxlqz8qKHec96myzMbBFDazAtoAf4W7jPQxFzTzOtyQ9AZM2woD/zBBKdTI5ASQ/+PafRhcUBWWn3OYMJbUMoCeVr+2cs+9OceEoOKIuqTfo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.jsM4d_1706707001;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W.jsM4d_1706707001)
          by smtp.aliyun-inc.com;
          Wed, 31 Jan 2024 21:16:42 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: mgorman@techsingularity.net,
	vbabka@suse.cz,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: compaction: update the cc->nr_migratepages when allocating or freeing the freepages
Date: Wed, 31 Jan 2024 21:16:26 +0800
Message-Id: <994af744828efe3c060128445204a56ab41e3ebb.1706706820.git.baolin.wang@linux.alibaba.com>
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
---
Changes from v1:
 - Rebased on the latest mm-unstable branch.
---
 mm/compaction.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index 055687e6bd17..363c3e49fe80 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1882,6 +1882,7 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
 	if (order)
 		prep_compound_page(&dst->page, order);
 	cc->nr_freepages -= 1 << order;
+	cc->nr_migratepages -= 1 << order;
 	return page_rmappable_folio(&dst->page);
 }
 
@@ -1904,6 +1905,7 @@ static void compaction_free(struct folio *dst, unsigned long data)
 	list_add(&dst->lru, &cc->freepages[order].pages);
 	cc->freepages[order].nr_pages++;
 	cc->nr_freepages += 1 << order;
+	cc->nr_migratepages += 1 << order;
 }
 
 /* possible outcome of isolate_migratepages */
-- 
2.39.3


