Return-Path: <linux-kernel+bounces-69014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D3D85836C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299831F2386E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67DF132487;
	Fri, 16 Feb 2024 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="ko4K3rk2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qgfQCRP5"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D7C130E59
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103093; cv=none; b=l5k6Tb9Xi2KZyid4r/06rfLFTUQc4AIEAKrupxj7kHrSdZ6NAq6jxYMNEI3IZPeGnh4Po1PKEq9MVwzGFCzjYvNs98NOC+tDpvRsxj41URSWEBfNrzFRak3OQvrE61fcnL3axwvMijv366GGpiGwBaDVDGqSOh/+Oe7duPk2B7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103093; c=relaxed/simple;
	bh=pHij3X8JOVWOkfWCWqtjgbkOy9WQpzuTbSOzombxQTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2fL4i8k4LWSqp++ijJnoSXFPZIPWGQzmUFkYDoSwkvj2gjFrreGla26lcNA/l5XEP8PBjPNko3FlSL2+sFIjPI4sgUIVf1v5Ow1TOA0d8lXY/eKsPdHF3U71cRC1s1LAmFgTbyYSiUDAc1VwkcQAZtM7WuZBh02IBPds+zhSn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=ko4K3rk2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qgfQCRP5; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id A355E5C009C;
	Fri, 16 Feb 2024 12:04:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 16 Feb 2024 12:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1708103090; x=1708189490; bh=+doHrWMX2AVjOxCrYcWaACj3dxXZqOZangV
	ROH6gYto=; b=ko4K3rk2g+mrEQbTGfvy/IoeGbtndA10HCmGrX6ZBtcKPPtBtmT
	9LaRVxlDcb81bTq/B6JKEfTj0gCUyY/09qsnrLNmSWu0fJfzBKl+r+N7hGehbV2D
	7joQdvSWDxEWjTYywpwgts3JDLO1Bnxgs4q7zjVkES4oSRsGHAO0evn2ipnoUiWT
	CTwaQqhvmPadH8fnZ5lZNN+TTjPTka0U7WHOirLr97H9oJHc74BbEb8hFUT1i/S1
	gNau3uupUOetpVvyVlkyGiGoQC5dCqDAnfQMdDvkpl7LjzKLvqHyVKdnUvJhOTwI
	LJ/ofpw/r5sFrWKmzvfDXYaZMDGoqyJUFmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1708103090; x=1708189490; bh=+doHrWMX2AVjOxCrYcWaACj3dxXZqOZangV
	ROH6gYto=; b=qgfQCRP5yc+VoPEksHSAB8Efae6JHt8FyDzmpfmb6aE6OVR6fsu
	o58jzMAEDbkzYZWozsaSClSp7LCI2wa0UkI/tXVALveXxZMu7PlLvcMoD3ZFAuhI
	x+tK9PYeHp0r6IZJ9kOf6w85wl/wUXQqSCy24i4jrrEiyFQWhKT9w+ZXeOr9J7wa
	HobdQOTKH6m77luNHiVbfb11c7ETZCjpMV48bpe5gxJAD794fI4itPyVDw6/FnOj
	0jYPhx++z0pZe5cvQFcxm2ZVhKJm99zbJHuQxIz7MdYqVzPe3TZ2Fr6CW1zM7kqf
	Kl7OHb4N/oW3SF9IzhZ0BWfYSwN7Qrge5Ew==
X-ME-Sender: <xms:sJXPZaNma2Jk__oETLG9xOH_X-vgb0PbyvT6E-pdJ3o0fo50gJSqbg>
    <xme:sJXPZY9BK6bM4CKLa774weOsqbOWbr0KbfbuAXNkvtEKvPIcoESxFT59F-E09HQkW
    5UC-lcgUTESVJrqQw>
X-ME-Received: <xmr:sJXPZRS8hQYSALXJ4I30kPay3yv9VQBa4k-aQ9mEH_K0Yv3a3YCvPaUBYc-90Flj3sG9CNkxtgW3r7mXgQyTJIpHVgAQkGxkM3hxagvE9XfBrkPceupn7U9r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfrhggtgfgsehtkeertdertdejnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeejke
    etkeffleelkeduffdtfedvtdejjeeutdeutdetgeejgfevtdefudejkeeiveenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:sJXPZat4Pu1_IgA_8tgwlrpISU0nIxKGoc2Sfxdls9m8XniMI_54ig>
    <xmx:sJXPZSfH6ueDbOt8GEQkBGXoBGl8LWuJWGgKgAGvcn40Q7zN7cwqUQ>
    <xmx:sJXPZe1xvpgTtNA6M2o87J2Dfcex9SUZxGvRCUzpCjXlSdxhidFGgA>
    <xmx:spXPZVV0qb_iRo7HJuGLfxqCWC7urdNDJX7fNgS4LDYMxf3OaKmAhw>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Feb 2024 12:04:47 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Yin, Fengwei" <fengwei.yin@intel.com>,
	Yu Zhao <yuzhao@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Rohan Puri <rohan.puri15@gmail.com>,
	Mcgrof Chamberlain <mcgrof@kernel.org>,
	Adam Manzanares <a.manzanares@samsung.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v6 2/4] mm/compaction: enable compacting >0 order folios.
Date: Fri, 16 Feb 2024 12:04:30 -0500
Message-ID: <20240216170432.1268753-3-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216170432.1268753-1-zi.yan@sent.com>
References: <20240216170432.1268753-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Zi Yan <ziy@nvidia.com>

migrate_pages() supports >0 order folio migration and during compaction,
even if compaction_alloc() cannot provide >0 order free pages,
migrate_pages() can split the source page and try to migrate the base
pages from the split.  It can be a baseline and start point for adding
support for compacting >0 order folios.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Suggested-by: Huang Ying <ying.huang@intel.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Yu Zhao <yuzhao@google.com>
Cc: Adam Manzanares <a.manzanares@samsung.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Yin Fengwei <fengwei.yin@intel.com>
---
 mm/compaction.c | 66 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 14 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index cc801ce099b4..aa6aad805c4d 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -816,6 +816,21 @@ static bool too_many_isolated(struct compact_control *cc)
 	return too_many;
 }
 
+/*
+ * 1. if the page order is larger than or equal to target_order (i.e.,
+ * cc->order and when it is not -1 for global compaction), skip it since
+ * target_order already indicates no free page with larger than target_order
+ * exists and later migrating it will most likely fail;
+ *
+ * 2. compacting > pageblock_order pages does not improve memory fragmentation,
+ * skip them;
+ */
+static bool skip_isolation_on_order(int order, int target_order)
+{
+	return (target_order != -1 && order >= target_order) ||
+		order >= pageblock_order;
+}
+
 /**
  * isolate_migratepages_block() - isolate all migrate-able pages within
  *				  a single pageblock
@@ -947,7 +962,22 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			valid_page = page;
 		}
 
-		if (PageHuge(page) && cc->alloc_contig) {
+		if (PageHuge(page)) {
+			/*
+			 * skip hugetlbfs if we are not compacting for pages
+			 * bigger than its order. THPs and other compound pages
+			 * are handled below.
+			 */
+			if (!cc->alloc_contig) {
+				const unsigned int order = compound_order(page);
+
+				if (order <= MAX_PAGE_ORDER) {
+					low_pfn += (1UL << order) - 1;
+					nr_scanned += (1UL << order) - 1;
+				}
+				goto isolate_fail;
+			}
+			/* for alloc_contig case */
 			if (locked) {
 				unlock_page_lruvec_irqrestore(locked, flags);
 				locked = NULL;
@@ -1008,21 +1038,24 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		}
 
 		/*
-		 * Regardless of being on LRU, compound pages such as THP and
-		 * hugetlbfs are not to be compacted unless we are attempting
-		 * an allocation much larger than the huge page size (eg CMA).
-		 * We can potentially save a lot of iterations if we skip them
-		 * at once. The check is racy, but we can consider only valid
-		 * values and the only danger is skipping too much.
+		 * Regardless of being on LRU, compound pages such as THP
+		 * (hugetlbfs is handled above) are not to be compacted unless
+		 * we are attempting an allocation larger than the compound
+		 * page size. We can potentially save a lot of iterations if we
+		 * skip them at once. The check is racy, but we can consider
+		 * only valid values and the only danger is skipping too much.
 		 */
 		if (PageCompound(page) && !cc->alloc_contig) {
 			const unsigned int order = compound_order(page);
 
-			if (likely(order <= MAX_PAGE_ORDER)) {
-				low_pfn += (1UL << order) - 1;
-				nr_scanned += (1UL << order) - 1;
+			/* Skip based on page order and compaction target order. */
+			if (skip_isolation_on_order(order, cc->order)) {
+				if (order <= MAX_PAGE_ORDER) {
+					low_pfn += (1UL << order) - 1;
+					nr_scanned += (1UL << order) - 1;
+				}
+				goto isolate_fail;
 			}
-			goto isolate_fail;
 		}
 
 		/*
@@ -1165,10 +1198,11 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			}
 
 			/*
-			 * folio become large since the non-locked check,
-			 * and it's on LRU.
+			 * Check LRU folio order under the lock
 			 */
-			if (unlikely(folio_test_large(folio) && !cc->alloc_contig)) {
+			if (unlikely(skip_isolation_on_order(folio_order(folio),
+							     cc->order) &&
+				     !cc->alloc_contig)) {
 				low_pfn += folio_nr_pages(folio) - 1;
 				nr_scanned += folio_nr_pages(folio) - 1;
 				folio_set_lru(folio);
@@ -1788,6 +1822,10 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
 	struct compact_control *cc = (struct compact_control *)data;
 	struct folio *dst;
 
+	/* this makes migrate_pages() split the source page and retry */
+	if (folio_test_large(src) > 0)
+		return NULL;
+
 	if (list_empty(&cc->freepages)) {
 		isolate_freepages(cc);
 
-- 
2.43.0


