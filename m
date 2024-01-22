Return-Path: <linux-kernel+bounces-33065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD068363E5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350E1287183
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A363D0B3;
	Mon, 22 Jan 2024 13:02:14 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC383CF71
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705928533; cv=none; b=NmDw/ivEKT7l+xL/BFDKgRTSmZxRMKnGXPLEog0M48hWoASCftc0DEwn1TCOhoUHW/zf7ibxs4MnBGGFeNgmUjR6QAQZoT+Z4MLK/LhsnbvvfqFuWVG2PGOrgMJVPrcj8kXPZxd0CwQeIhfGpKS2R5F1EG43uFh3NwmtUv2N3nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705928533; c=relaxed/simple;
	bh=LNMEtRYYUEvztr0JZHEpSPlZZtxTJHJcYCyjncWD5/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kqIdqUADog/2OJvHeyIlA6wZG0QGz6Y9mCXFX4xR36jYTfRIpHKCoLx+bMyhD19HdbH4dkcnl6jHihtBey5EZqm8K2vtAnE8X6FPkr8K+1+tHpN34h1UHjXbhXzLU7dFhS/lvzhxUZ9SdJ1qliqUfStXoQYeeCG6lOF9wtOCh+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.9DBpR_1705928524;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W.9DBpR_1705928524)
          by smtp.aliyun-inc.com;
          Mon, 22 Jan 2024 21:02:05 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: mgorman@techsingularity.net,
	vbabka@suse.cz,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm: compaction: update the cc->nr_migratepages when allocating or freeing the freepages
Date: Mon, 22 Jan 2024 21:01:54 +0800
Message-Id: <0773058df022fa701b78f9a6dfe3c501a1a77351.1705928395.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <afcd9377351c259df7a25a388a4a0d5862b986f4.1705928395.git.baolin.wang@linux.alibaba.com>
References: <afcd9377351c259df7a25a388a4a0d5862b986f4.1705928395.git.baolin.wang@linux.alibaba.com>
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
 mm/compaction.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index 066b72b3471a..6c84e3a5b32b 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1779,6 +1779,7 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
 	dst = list_entry(cc->freepages.next, struct folio, lru);
 	list_del(&dst->lru);
 	cc->nr_freepages--;
+	cc->nr_migratepages--;
 
 	return dst;
 }
@@ -1794,6 +1795,7 @@ static void compaction_free(struct folio *dst, unsigned long data)
 
 	list_add(&dst->lru, &cc->freepages);
 	cc->nr_freepages++;
+	cc->nr_migratepages++;
 }
 
 /* possible outcome of isolate_migratepages */
-- 
2.39.3


