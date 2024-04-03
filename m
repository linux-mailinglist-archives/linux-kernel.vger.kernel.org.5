Return-Path: <linux-kernel+bounces-129874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD7B89717D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFBF91F266CB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CF01487E3;
	Wed,  3 Apr 2024 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HOIRJEMh"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686D626AC8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152059; cv=none; b=tlUitX0KQCZRX+hhgkm8GocynLFDlVJvLRgXntWg+K3kZzSdXHcAVFZqOhuFIVH+uoFnOoFohatxMiCCVlOWvnOy9dFZ0Qdn9felsCTsYL1ZSUuQ+zVSAW7Gxkju8XziUADahX+gj04/5M3uZzPo3n72J61Ag7Ne3Rrrt0zb7QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152059; c=relaxed/simple;
	bh=bZ2h0yKjSqpqqWycUoT396LO/mtiCTMyM98TZBpAJzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D5u202YcRZ3VvK5n2A3NqWx1fhqy1gGzvunWLuBCcVMhxc0gwCKR7fl91lVikGq4P7HubCAC39HhrDMEQmvPqV9Fl2KXMvgceTedHtIHbKJcX2P7EXbQLXCPYhP0NcSdTL3Y5lNQX3+Ip7eDJeocia4d7wME1PXj+JR9MEJlErs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HOIRJEMh; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712152047; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=X9pWo0FjPI342T+clcPjmo12buEGVLbb75wO5yLR45U=;
	b=HOIRJEMhAhg9xzd/Y2Ic+cPMNBCHKK+UVZvajsHQAyG1cpdv1oILQExfci+8+6P8TPKRtnglrbeSa/E4y9twWw4T/+Mn4L7zZYcZbkiJf6+PaDVDDNhPl/TgqcipqX41pN9MxzzineoLxhTUih81uMnniY89k4Soz/0+lXAu/eo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W3rs253_1712152046;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W3rs253_1712152046)
          by smtp.aliyun-inc.com;
          Wed, 03 Apr 2024 21:47:27 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: mgorman@techsingularity.net,
	vbabka@suse.cz,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: page_alloc: use the correct THP order for THP PCP
Date: Wed,  3 Apr 2024 21:47:21 +0800
Message-Id: <a25c9e14cd03907d5978b60546a69e6aa3fc2a7d.1712151833.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 44042b449872 ("mm/page_alloc: allow high-order pages to be stored
on the per-cpu lists") extends the PCP allocator to store THP pages, and
it determines whether to cache THP pags in PCP by comparing with pageblock_order.
But the pageblock_order is not always equal to THP order, it might also
be MAX_PAGE_ORDER, which could prevent PCP from caching THP pages.

Therefore, using HPAGE_PMD_ORDER instead to determine the need for caching
THP for PCP can fix this issue

Fixes: 44042b449872 ("mm/page_alloc: allow high-order pages to be stored on the per-cpu lists")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/page_alloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1beb56f75319..915f4ef070da 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -506,7 +506,7 @@ static inline unsigned int order_to_pindex(int migratetype, int order)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (order > PAGE_ALLOC_COSTLY_ORDER) {
-		VM_BUG_ON(order != pageblock_order);
+		VM_BUG_ON(order != HPAGE_PMD_ORDER);
 		return NR_LOWORDER_PCP_LISTS;
 	}
 #else
@@ -522,7 +522,7 @@ static inline int pindex_to_order(unsigned int pindex)
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (pindex == NR_LOWORDER_PCP_LISTS)
-		order = pageblock_order;
+		order = HPAGE_PMD_ORDER;
 #else
 	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
 #endif
@@ -535,7 +535,7 @@ static inline bool pcp_allowed_order(unsigned int order)
 	if (order <= PAGE_ALLOC_COSTLY_ORDER)
 		return true;
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (order == pageblock_order)
+	if (order == HPAGE_PMD_ORDER)
 		return true;
 #endif
 	return false;
-- 
2.39.3


