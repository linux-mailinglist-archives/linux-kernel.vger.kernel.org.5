Return-Path: <linux-kernel+bounces-34688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E3D838624
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B511F24E99
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA0F187A;
	Tue, 23 Jan 2024 03:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="R8JVod3l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IBydtwlk"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E317315C6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705981631; cv=none; b=Kbgshmf1TGeKdjgAwb3EzB5vJ8TYBPnzRcEhko1yd7cuHyQF3SnKC1B+vBrIXcTu9+7dyk5KlQezCI6J2fC6FxF8H3rUl3gfVK+nXwuEzjiI72AHLysNNqnVw5UFL300u3bLNreb9L782ij7yRK91XJhkazgOLiX3VEoCjPLwrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705981631; c=relaxed/simple;
	bh=oh4apvSWdmMkF18+DQ+QPTbHpZZBWwkxm6XwqLBEwxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQCqCb5iGsHodmNFUZzQINCDok6SMR4MYWJfq/KhxjZzBY0JDMDBEGtiWb4OIeGo2ODgHowx7H4s0SkNvjvQ9fWqkyXvYJg6MsvT2t6FaQNLt7VKSqRROB+WMZuw86b13f/RDSMIFfMQV1gVZreIbbubeBG+kG9wXsvSntMzQjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=R8JVod3l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IBydtwlk; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 39D365C0051;
	Mon, 22 Jan 2024 22:47:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 22 Jan 2024 22:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1705981628; x=1706068028; bh=mC6ae0v7zXTnCM6lhVafmauC3M7j0hzzYKY
	Z+UScLOA=; b=R8JVod3laPmb7g1HLtsYlFfqWul2+VE2dg3TQlgwT3R5cPWzbis
	EcZkF+hmp86rGEd6ibctWpwxhzerM8OsVEvs8/Yr7HA2RWvxe5b/xrq9zwUNS1v0
	M+3wVSTD3eNLrED3w2G/ZM11O/jyeLhf4wpxkT2sj/0sAvg6aV5v/xfC9d/a/GIb
	ZhvssWRXPSwph6Pa+atCSApUSwUwXuDD3A3AHJoU47PAenkdkURR0GUOL3lP1ESt
	KiaVNtVpqEn6hTgDmbV5hR4iRI+EK0UblW3Wmha4wPSd2tFEoITwM1H/4dSAzz03
	zrv6xTwoQ5uE1MVN4SEtipS+r/RHpdCMb+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1705981628; x=1706068028; bh=mC6ae0v7zXTnCM6lhVafmauC3M7j0hzzYKY
	Z+UScLOA=; b=IBydtwlk9+lvDYtAAJ8KD4EgF1URCX6jmKxJV6kJUZZylFudmUa
	t1e68onsyFym0E8LQt6q7fsJmxputLlJh3XVYp+jur7Rgu5X9nJ1Aah2n11OySOn
	sTM/yRuXWY8cxihEUQ/3YKiKxkPIQW34g0OPQfdl5WANkeINHBkhstCX3BhkVqiP
	QadejVULEhjzkZefAcGBCUkuXc7eR3JG1RPFORj3VMvhseq0fKGrlnRh2KbpH5EG
	513h2uRqcBY6KSIuB3oT5mlYXULKr0YMFmL1HLV4St0SVYsPnbkQsJ+vVGEziMlu
	LXUi1kNb69FU+PBU8baYumXkx+AaZd1gq/Q==
X-ME-Sender: <xms:uzavZSlMg_16TVJO9JBBWVNK1-Zo8hURa9Cd2Y4MNaUIsyMrP-V9eQ>
    <xme:uzavZZ1fFvNIDOSxel1q80DvrQZIJcWmGl8CG2bcx9UihWhuBP9FENRCVGZpDaDUq
    pdnyNYNiAYqPQpadA>
X-ME-Received: <xmr:uzavZQocityrnUhsrPX05SDSpwG-s0jxchkNiSUjriCPbi0tEcemKkWv1uRS1Rkl28HND-V8p0Ao9Uynxh4SE-rVEABWOHCEmoa2X-kpDh14YYd4hhcbtT4j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekjedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrgggtgfesthekredtredtjeenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepje
    ekteekffelleekudfftdefvddtjeejuedtuedtteegjefgvedtfedujeekieevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:uzavZWlYGsZDF1Vsc0HnW4xKK05EZCziFoDYku7MD7IhZrWOgoc_PA>
    <xmx:uzavZQ2_tc_40gXR8IJjIABzjnoUDdwzueh4mrLCJjqSUNiWoV7I6Q>
    <xmx:uzavZdui6qDbfhFKTwFLHKSuZ-sakUp3uvxXJ71pWPVAIpRg-rG1TQ>
    <xmx:vDavZXs40tljvTj_XTxJkowRgvUwJCeM8dESfW1mx07yc61YBry5Sw>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 22:47:07 -0500 (EST)
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
Subject: [PATCH v2 1/3] mm/compaction: enable compacting >0 order folios.
Date: Mon, 22 Jan 2024 22:46:33 -0500
Message-ID: <20240123034636.1095672-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123034636.1095672-1-zi.yan@sent.com>
References: <20240123034636.1095672-1-zi.yan@sent.com>
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
migrate_pages() can split the source page and try to migrate the base pages
from the split. It can be a baseline and start point for adding support for
compacting >0 order folios.

Suggested-by: Huang Ying <ying.huang@intel.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/compaction.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 27ada42924d5..61389540e1f1 100644
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
@@ -1009,7 +1024,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		/*
 		 * Regardless of being on LRU, compound pages such as THP and
 		 * hugetlbfs are not to be compacted unless we are attempting
-		 * an allocation much larger than the huge page size (eg CMA).
+		 * an allocation larger than the compound page size.
 		 * We can potentially save a lot of iterations if we skip them
 		 * at once. The check is racy, but we can consider only valid
 		 * values and the only danger is skipping too much.
@@ -1017,11 +1032,18 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		if (PageCompound(page) && !cc->alloc_contig) {
 			const unsigned int order = compound_order(page);
 
-			if (likely(order <= MAX_PAGE_ORDER)) {
-				low_pfn += (1UL << order) - 1;
-				nr_scanned += (1UL << order) - 1;
+			/*
+			 * Skip based on page order and compaction target order
+			 * and skip hugetlbfs pages.
+			 */
+			if (skip_isolation_on_order(order, cc->order) ||
+			    PageHuge(page)) {
+				if (order <= MAX_PAGE_ORDER) {
+					low_pfn += (1UL << order) - 1;
+					nr_scanned += (1UL << order) - 1;
+				}
+				goto isolate_fail;
 			}
-			goto isolate_fail;
 		}
 
 		/*
@@ -1146,10 +1168,11 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
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
@@ -1767,6 +1790,10 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
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


