Return-Path: <linux-kernel+bounces-33063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9968363E1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8164C1C27012
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C443CF60;
	Mon, 22 Jan 2024 13:02:10 +0000 (UTC)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C033CF54
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705928530; cv=none; b=sFDS1+SgzDhNYNf2+IuoGE3PVcXPj17Thucjr6sGW23E0e0GMs5ycS3tYryLqZXByNdgzMvYA8e2FJpaBAtvwBx96e4yRxQMke2tRzcxK6eUOTCvDbuas1GqrW5PsPCkxndZ94qbH7fo64O6MH0cFqb+Z6gaBLHZhMTt9zIB7kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705928530; c=relaxed/simple;
	bh=Vn4PVyIT4D0ggBEBiZMoEVPYf37DU55xxBmCF2O+1lk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cWVy2WfbNw9elX97skL67y1lrwmH34IZ/flodb/dzVT4Xp2Sy1IU+IISXiYJy+9mdQ77oyrOisICtD5pSwY3QLY640gi7sYLjFWoOOh8YG+u2ATfytWTHeSvzt/gkFriNANXzZU4d1KtsZBi4EDcmcQwTbB6hVRufaxUQroFm8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.9DBn2_1705928520;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W.9DBn2_1705928520)
          by smtp.aliyun-inc.com;
          Mon, 22 Jan 2024 21:02:01 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: mgorman@techsingularity.net,
	vbabka@suse.cz,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm: compaction: limit the suitable target page order to be less than cc->order
Date: Mon, 22 Jan 2024 21:01:53 +0800
Message-Id: <afcd9377351c259df7a25a388a4a0d5862b986f4.1705928395.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It can not improve the fragmentation if we isolate the target free pages
exceeding cc->order, especially when the cc->order is less than pageblock_order.
For example, suppose the pageblock_order is MAX_ORDER (size is 4M) and cc->order
is 2M THP size, we should not isolate other 2M free pages to be the migration
target, which can not improve the fragmentation.

Moreover this is also applicable for large folio compaction.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/compaction.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 27ada42924d5..066b72b3471a 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1346,12 +1346,14 @@ static bool suitable_migration_target(struct compact_control *cc,
 {
 	/* If the page is a large free page, then disallow migration */
 	if (PageBuddy(page)) {
+		int order = cc->order > 0 ? cc->order : pageblock_order;
+
 		/*
 		 * We are checking page_order without zone->lock taken. But
 		 * the only small danger is that we skip a potentially suitable
 		 * pageblock, so it's not worth to check order for valid range.
 		 */
-		if (buddy_order_unsafe(page) >= pageblock_order)
+		if (buddy_order_unsafe(page) >= order)
 			return false;
 	}
 
-- 
2.39.3


