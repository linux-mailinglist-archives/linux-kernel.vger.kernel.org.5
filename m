Return-Path: <linux-kernel+bounces-50118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5712C84747C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60EFE1C26BAF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC141474D3;
	Fri,  2 Feb 2024 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="w9AwuLYZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jITQjR9f"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC4B14198F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890579; cv=none; b=TTa9twik41BK5bT6TtsJZsP7UN59yqUkOCMR0jak0vNPckXwYBaFytda6dRKo5xZ//F6tcT/pLrvvEMa1AwLiFtP2P5pq4cMPEjSQtGLglTMKYoS+ad0XhWfs1o9PkhrMo14Z8OffyM52DOURI2pI7nYgJCA+M+000VBsPvOC/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890579; c=relaxed/simple;
	bh=CHBuBJuhamNrP6U0fj4Mt2MwBKcPu0swmlgl3BSB8TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcIG0Gr5CjCPh4r/9O/Yg2uPKRrouwyeOZJfefEWTQ9vmUEJrW9yhiMGHHo9b1ERP8qLl6/nqVKbSz+wNWFTRDBZFno0MSsQJPnF3JjClUTYrN6vGC7iSoQUVUErKk1ZrAgpej9nEFMoUR3FbbN5OvDpdUfL1Bu68wEilaEPD6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=w9AwuLYZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jITQjR9f; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id BE2FD5C0080;
	Fri,  2 Feb 2024 11:16:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 02 Feb 2024 11:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1706890576; x=1706976976; bh=b0LGZXB2atC7cRDxeVKB29tfMJXHfhbupvu
	qzgL5H0w=; b=w9AwuLYZjR/BP+cqnv3LMOCFQHBsCSwi895LQemcBc+Vo5ZToOt
	HCHtnMIu+rwnyKxCfClEPDT0/5F+CkwVbcGInCTjWeCWmRjStV7xls7XKOArtfsI
	w5V3vmmkw+KiHx2VdkyMZ0QacA6O+hqiEA/i4E9XOJ9z+Q/x3xQMDQ8arvA/lk0g
	BqHpu1wNeN9kn2L6C96cJ1thlhPyVv97m93rRRo8gewh7pXpNJHfVbnhc94d+/OT
	8eny1dAyhp8oVMCHXdhdF/yxvyNKMP/6aOC8MZKzfU4jhN/6nuOWJw7hUSqswAT0
	if8thmyelZ6EE/eBsHrgVEmiLME2G476qSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1706890576; x=1706976976; bh=b0LGZXB2atC7cRDxeVKB29tfMJXHfhbupvu
	qzgL5H0w=; b=jITQjR9fZ4vUH7jpIKUSGUf69CmGaNlTyKWC7zCok4dJZu5NM+M
	tfqbsksM2p0nTWynjXbTfU3uIPh+tzf0SEH3sdEbK6yLqYCUcsSri81slnPWg0Vl
	+tv7SmGQ6GXwLg/uEogMGAdWcRQ2uUpLFNRY5TeNJYaKuyqHrI9LDFZyoAHDTJrv
	laJlFvAREQb49Osr7ozT8+HHU7Do0nEFj3n2Ks80KnGAxDm5blkXMdpNaQpb5tkl
	znMVFC71CcxwrGQpSwLwE8Et4YppV1zGIp7VMnNW8+rHy1e+kLti4NGDKwzC/JLD
	oTrbPSupWq5z6Db9SfEWk+3EevvpLfpHAYw==
X-ME-Sender: <xms:UBW9ZazlDycr4MFLl50ja0ITLIpUdhU4G0v3mGYvnyEIbX96U4VoJw>
    <xme:UBW9ZWRuoxQoSIpG-G8voG-QBLLYP5diyy94UtrpPgXuUw1NXP5GW8Npr6MWMZlta
    -KnadSJgoMM5kK7-Q>
X-ME-Received: <xmr:UBW9ZcUwVBLkPVMYu4-WBAFp8Ib8lj5Mq9z17h0uxapV1Y3aU3SNGb4ThwqGFJgZDmVpwIkKINAcKaSJwO67m4WHcHeddHtsoVDidujGhNACtRLl_ami9jiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedugedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrgggtgfesthekredtredtjeenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepje
    ekteekffelleekudfftdefvddtjeejuedtuedtteegjefgvedtfedujeekieevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:UBW9ZQguKYLro88YJXYyfpcU7gbhtrx1itTHsshc0CT5t0x7SmSjbg>
    <xmx:UBW9ZcCNhwbq_F2UkcE9VXSB2bg3RiPwHxTifLhuFBn4eHb8ydit4w>
    <xmx:UBW9ZRJ3-D5zl4Beh-VCQe7V5sH5F6QzY7b7SFA21LIHX0mslwJJKw>
    <xmx:UBW9ZU61UoIpbNPoIrFOiXEVfHwkYb6xcTCImFdlGVWaFDcMlACBZg>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 11:16:15 -0500 (EST)
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
Subject: [PATCH v3 1/3] mm/compaction: enable compacting >0 order folios.
Date: Fri,  2 Feb 2024 11:15:52 -0500
Message-ID: <20240202161554.565023-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202161554.565023-1-zi.yan@sent.com>
References: <20240202161554.565023-1-zi.yan@sent.com>
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
index 4add68d40e8d..e43e898d2c77 100644
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
@@ -1010,7 +1025,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		/*
 		 * Regardless of being on LRU, compound pages such as THP and
 		 * hugetlbfs are not to be compacted unless we are attempting
-		 * an allocation much larger than the huge page size (eg CMA).
+		 * an allocation larger than the compound page size.
 		 * We can potentially save a lot of iterations if we skip them
 		 * at once. The check is racy, but we can consider only valid
 		 * values and the only danger is skipping too much.
@@ -1018,11 +1033,18 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
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
@@ -1165,10 +1187,11 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
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
@@ -1786,6 +1809,10 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
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


