Return-Path: <linux-kernel+bounces-136390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 612A789D38D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3FD282AF5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8921C7D09D;
	Tue,  9 Apr 2024 07:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OJqb7R2F"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AE876413
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 07:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712648912; cv=none; b=GxdD+svVGsyaHsMid3wRRA95ATfbhWDzH6Yn7JBxEzhIUB6bRJOg1JirUSPFT4gldwFYX1c56mrg3NDfvVmOjaRsbzxjyQbpHJcA9lgCuZafxDQ2fN6D9/i1fgIs5lRG573QX4EBlkW3lF5B4753aXO+BH33UrDBYCuty22KI2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712648912; c=relaxed/simple;
	bh=Ask8kU9PPxiUJLLXti1GtgqHhSacP1h4RFXsZ/tF9ws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oiNCc0/BqdPvebobut8Cfvrz5gBkPpQGvCCEunuYrxzMZDJz9glLw4O/B4dU92KBYs040hY+VUlEpOjVv4qGV0jqWC+Y2Jdnoej3YdK5k6dNkMbVKowZ5LqdpHgxW8LkpQZf5xbIQtS0J2/hM+V88c1MAERV2ek/Kie5boX4i8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OJqb7R2F; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712648902; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=rVa0w4iPrfKIGVgN82R9JMd4RGG8BOD6XDG3/b9ksDA=;
	b=OJqb7R2F2ogosxQJgrGcqZ9BQWUTPKnt49rLw6xW+W3qKPqARN5DhgB0yrFdfHa8WjEpyD1bgmm0D9jv0sXC7gCL4+JJ7d2xdkFoFobPFEqy4z6IHEJlm6yEJO2mQYy4mjiPOtsaJ8npA7zPAAaGv1Vul5n0qxo/utROYkJ5Rto=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W4DkG4Q_1712648900;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W4DkG4Q_1712648900)
          by smtp.aliyun-inc.com;
          Tue, 09 Apr 2024 15:48:21 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: vbabka@suse.cz
Cc: akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com,
	david@redhat.com,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mgorman@techsingularity.net,
	ying.huang@intel.com,
	ziy@nvidia.com
Subject: [PATCH] mm: page_alloc: consolidate free page accounting fix 3
Date: Tue,  9 Apr 2024 15:48:04 +0800
Message-Id: <a2a48baca69f103aa431fd201f8a06e3b95e203d.1712648441.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <1cc1e3d1-4646-436c-92cb-f8584406bf88@suse.cz>
References: <1cc1e3d1-4646-436c-92cb-f8584406bf88@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the released page is captured by compaction, now the free page accounting
is not correspondingly decreased, which can make the watermark checks false
positive and result in depleted reserves etc. And I can see the false positive
watermark checks in thpcompact benchmark, that led to a slight regression:

thpcompact Percentage Faults Huge
                           k6.9-rc2-base        base + patch10 + 2 fixes
Percentage huge-1        78.18 (   0.00%)       71.92 (  -8.01%)
Percentage huge-3        86.70 (   0.00%)       86.07 (  -0.73%)
Percentage huge-5        90.26 (   0.00%)       78.02 ( -13.57%)
Percentage huge-7        92.34 (   0.00%)       78.67 ( -14.81%)
Percentage huge-12       91.18 (   0.00%)       81.04 ( -11.12%)
Percentage huge-18       89.00 (   0.00%)       79.57 ( -10.60%)
Percentage huge-24       90.52 (   0.00%)       80.07 ( -11.54%)
Percentage huge-30       94.44 (   0.00%)       96.28 (   1.95%)
Percentage huge-32       93.09 (   0.00%)       99.39 (   6.77%)

After the fix, the regression is gone.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8330c5c2de6b..2facf844ef84 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -805,8 +805,10 @@ static inline void __free_one_page(struct page *page,
 	while (order < MAX_PAGE_ORDER) {
 		int buddy_mt = migratetype;
 
-		if (compaction_capture(capc, page, order, migratetype))
+		if (compaction_capture(capc, page, order, migratetype)) {
+			account_freepages(zone, -(1 << order), migratetype);
 			return;
+		}
 
 		buddy = find_buddy_page_pfn(page, pfn, order, &buddy_pfn);
 		if (!buddy)
-- 
2.39.3


