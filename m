Return-Path: <linux-kernel+bounces-73516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 676B585C3A8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7173A1C21D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E064128813;
	Tue, 20 Feb 2024 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="C/BfFgk3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Udaf3BFo"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C31130E32
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708453973; cv=none; b=mxkn0cIe1fmhBPmQwIkMKb4FMQVaK+ipXetUADXf5587Q3KZUnRtmaectxeieSSdU7JOpsyEepKbwB+BFUkxj32BpuN2HynqRNSoR4Gw5E993TogzfifHdiEFtKBUFwSrDN0YEXMIKX/noDoztJog3hcVKYkxDGK+mBQ7oB+aOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708453973; c=relaxed/simple;
	bh=peQzf9WHqEOx4IpzLUnSKnIIBdZa/+nwsL6Us3kBuKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qomuw/L3jARpDKBYz8QaCjT2LDJyrape440gTp0G7ylGgiyL3W/+dvSAWYcsTXSaHWCWQQCdRYfefm3eyfwpTVQQdK1bAlYtZBIvzvagT/EDCcR8FGnXRhmsyrJcTqCs5Do1IBPtA8ziuwNW4XM6uwrSvFATRlCaxTAZZr6Id4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=C/BfFgk3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Udaf3BFo; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 1454C3200A54;
	Tue, 20 Feb 2024 13:32:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 20 Feb 2024 13:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1708453968; x=1708540368; bh=2I9yVROKB+W15mI+UpYHE5WhFE4737+G/6r
	8N16qHZk=; b=C/BfFgk39mofWJiQq1RU1DWERdAHjGqZ9CYe67lUaTnv4DkXexC
	JUgAvnAb0Geveu0vCR8Yc9SLyPMqyN/tNho4hPNJx4U/8p4TzIyaIc5OktmhEKCr
	br24aOTURhAPSOHXhberlecYH0+s+agkxnTKkHWM7EBjj9LkiJlmyvYIg9lYsb39
	k1MC00poth8h21dF4zg8DknBjbZouWKEK9G0gXzDmEqPy/WYgcb5cbhSnBK3PxEU
	ezq4uAP4EnS/t7OdwAvx1gFmLzKX6+0I4E9AaHC+dQFzsxKKnCmseSrNxt7+pneX
	K8rOQO1BMHCdml1nFSal2TuN6nsalawNrtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1708453968; x=1708540368; bh=2I9yVROKB+W15mI+UpYHE5WhFE4737+G/6r
	8N16qHZk=; b=Udaf3BFoiTXOq1ww31/D3N6rdbCeObxT1gXG2hXa5NBnQUEJ+p1
	FrTz7sVN7TfskcfLfC8lvIg7uWLwAM4gKoGLGq5PDq1H3TzHRCOWn5eABFHaUPWP
	hRcLPmnjhUdWr7YgxaQgBvgIUqBEFq8sUmNuaeI6CvWUaUlfr3eaIw45CIHpesDM
	Na1wRUkDZmVVdMvqma3brYOhrSvHyQgVMba8K8fiGYgkM1qfP2v3zaZpIaOApfNj
	XL6QJvDFvWitaPcbo8lJ/oJtMrlxWiFEHifseopH2PWBynBXM9l0160t+59lzuIK
	WRXy6u9dxKaJeE4fNamBvXRDfWPNYrzk+uA==
X-ME-Sender: <xms:UPDUZZBNCrLDBEYDHYPjYVel0ajp0maeVP7BwWLuaXW-kSt4p1xMkw>
    <xme:UPDUZXiCyLgBauwoGK26V_dA0PkTUBRVZkl-JTlmyY6ANIDyqGZMCXEePodoZzT1y
    1BgJ3nXWyGtHytkug>
X-ME-Received: <xmr:UPDUZUm1lyC92wxMcmTkuX_AfrWozKIfPQ4by3Ry_3ysgEI8iyRY5GDTXqHnoyXE6uGYSMWvIPw34tCZ2cagV1CKZ-BPwg2fV8gHXEaniGNBH-tKHZOjPPma>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrgggtgfesthekredtredtjeenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepje
    ekteekffelleekudfftdefvddtjeejuedtuedtteegjefgvedtfedujeekieevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:UPDUZTwyp99dXWu7z5HrvuUnH_MAGvw44d8KPKwumaIJAJzGNGh_aQ>
    <xmx:UPDUZeQP5gQ3TG8y4K43_VFHcdusmu9pwXqTgWX23lo7aarwx--Ogw>
    <xmx:UPDUZWY4UqfrETW3yIJ8KDJTFTf9sx6ATffuJzWCWPvOtQNifU0chA>
    <xmx:UPDUZfLI59hvO6PjVlDc1yTVN03kxddf8n2Q7kQKpE1m5NrOkAIdaA>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 13:32:47 -0500 (EST)
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
Subject: [PATCH v7 4/4] mm/compaction: optimize >0 order folio compaction with free page split.
Date: Tue, 20 Feb 2024 13:32:20 -0500
Message-ID: <20240220183220.1451315-5-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220183220.1451315-1-zi.yan@sent.com>
References: <20240220183220.1451315-1-zi.yan@sent.com>
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

During migration in a memory compaction, free pages are placed in an array
of page lists based on their order.  But the desired free page order
(i.e., the order of a source page) might not be always present, thus
leading to migration failures and premature compaction termination.  Split
a high order free pages when source migration page has a lower order to
increase migration successful rate.

Note: merging free pages when a migration fails and a lower order free
page is returned via compaction_free() is possible, but there is too much
work.  Since the free pages are not buddy pages, it is hard to identify
these free pages using existing PFN-based page merging algorithm.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Yu Zhao <yuzhao@google.com>
Cc: Adam Manzanares <a.manzanares@samsung.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Huang Ying <ying.huang@intel.com>
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
 mm/compaction.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 112711752321..e70309674262 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1856,15 +1856,40 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
 	struct compact_control *cc = (struct compact_control *)data;
 	struct folio *dst;
 	int order = folio_order(src);
+	bool has_isolated_pages = false;
+	int start_order;
+	struct page *freepage;
+	unsigned long size;
+
+again:
+	for (start_order = order; start_order < NR_PAGE_ORDERS; start_order++)
+		if (!list_empty(&cc->freepages[start_order]))
+			break;
 
-	if (list_empty(&cc->freepages[order])) {
-		isolate_freepages(cc);
-		if (list_empty(&cc->freepages[order]))
+	/* no free pages in the list */
+	if (start_order == NR_PAGE_ORDERS) {
+		if (has_isolated_pages)
 			return NULL;
+		isolate_freepages(cc);
+		has_isolated_pages = true;
+		goto again;
+	}
+
+	freepage = list_first_entry(&cc->freepages[start_order], struct page,
+				lru);
+	size = 1 << start_order;
+
+	list_del(&freepage->lru);
+
+	while (start_order > order) {
+		start_order--;
+		size >>= 1;
+
+		list_add(&freepage[size].lru, &cc->freepages[start_order]);
+		set_page_private(&freepage[size], start_order);
 	}
+	dst = (struct folio *)freepage;
 
-	dst = list_first_entry(&cc->freepages[order], struct folio, lru);
-	list_del(&dst->lru);
 	post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
 	if (order)
 		prep_compound_page(&dst->page, order);
-- 
2.43.0


