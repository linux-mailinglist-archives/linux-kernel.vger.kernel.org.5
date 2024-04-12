Return-Path: <linux-kernel+bounces-141869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3295B8A246A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6324D1C2103B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE1118633;
	Fri, 12 Apr 2024 03:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XGElWPrJ"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECFC182A0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712892447; cv=none; b=ORe3fdjFxo4jLbotNQhhn4H+DVt2RKu71sJ155i9jq+aL2vjfMmjK8edO/8Iqi+JrUevQniLS3NijbuuMdAtl6SSH6VwqSetz7mwkK2LmhIPZwn6Mi9IFfX6BXAfKh1f+nbCoaNRf92DfczaSPtE8bG2XRXQ/bzCjtWteukrFJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712892447; c=relaxed/simple;
	bh=GWOD0bD2dppJxnqtOWFxf0FDtRoj+5Os0vJNDbYJHQM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N/UQyF8TyNZy2r+TB3TkITvvP5/fClr01UbIuxUcT720r1+Z912oXsELUg/cDCqVD9GVAUDLyD6uym7LkCYqauUpAf9GU4wNcP6Ru76xLQe1x1vnpBiQSO5vlO3BUW8rkzIlnSvfzqbdn+A+FM858RGe19LB2P6fYlK0rwvoYbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XGElWPrJ; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712892437; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=2fkGS+MFyueb1gRjvWZU73/oYEQkBz+kgZl5y/+I3Ww=;
	b=XGElWPrJ8MeiROWQkTeP6Ey0U4Oeyjsfa+3FLQqJRvUqMpAvhXHZcvU+pdQybxLHR+E8GnXbQlwNJ5evKPcYQmojd04kw1lCwLUCezbpMo5RAVBw2ZYUnUciFRPk6FYDgSKsfEO9uojqaVxjW6HsdHSGUX1MrNG5uyvLPajgZw8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W4Mumqi_1712892435;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W4Mumqi_1712892435)
          by smtp.aliyun-inc.com;
          Fri, 12 Apr 2024 11:27:16 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	mgorman@techsingularity.net,
	vbabka@suse.cz,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: page_alloc: allowing mTHP compaction to capture the freed page directly
Date: Fri, 12 Apr 2024 11:27:04 +0800
Message-Id: <8118a5d66a034736a48433beddaca60ed78577c4.1712892329.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, compaction_capture() does not allow lower-order allocations to
directly capture the movable free pages, even though lower-order allocations
might also be requesting movable pages, that can lead to more compaction
scanning. And, with the enablement of mTHP, such situations will become more
common.

Thus allowing lower-order (mTHP) allocations of movable page types directly
capture the movable free pages can avoid unnecessary compaction scanning,
meanwhile that won't pollute the movable pageblock. With testing 1M mTHP
compaction, it can be seen that compaction scanning is significantly reduced.

                                   mm-unstable       patched
Ops Compaction pages isolated      116598741.00   120946702.00
Ops Compaction migrate scanned    1764870054.00  1488621550.00
Ops Compaction free scanned       7707879039.00  4986299318.00
Ops Compact scan efficiency               22.90          29.85
Ops Compaction cost                    73797.69       72933.48

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/page_alloc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b51becf03d1e..33d4a1be927b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -595,12 +595,14 @@ compaction_capture(struct capture_control *capc, struct page *page,
 		return false;
 
 	/*
-	 * Do not let lower order allocations pollute a movable pageblock.
+	 * Do not let lower order allocations pollute a movable pageblock
+	 * unless compaction is also requesting movable pages.
 	 * This might let an unmovable request use a reclaimable pageblock
 	 * and vice-versa but no more than normal fallback logic which can
 	 * have trouble finding a high-order free page.
 	 */
-	if (order < pageblock_order && migratetype == MIGRATE_MOVABLE)
+	if (order < pageblock_order && migratetype == MIGRATE_MOVABLE &&
+	    capc->cc->migratetype != MIGRATE_MOVABLE)
 		return false;
 
 	capc->page = page;
-- 
2.39.3


