Return-Path: <linux-kernel+bounces-69016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8C585836E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ED851C21296
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA99130E2F;
	Fri, 16 Feb 2024 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="Qh+SFOC2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hrjQmkGw"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0253B13249C
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103096; cv=none; b=A2Gkp262CKdU4rZIIKPb8RTuSUKSfF6Hp54Wd3ysxXIgrVt7VuOyoI3DbaiA5MuVNxsFHDFHYOsRNJ+7oxCmGBD19ImYBsuYvXyG1NPyL0Rr2Atu4cubKHeF0f2VSuXJG4YKCxDLPRA60O0slc/UuOggT7vfrBLStDzzdi/tClg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103096; c=relaxed/simple;
	bh=82Y1OAgcDxB2eyqtTi+XVPaxghLqy53X5y/mvWFu9A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nAEuXN0pT0Pp4jRUlMu/1RzTMVYe11gPuvojR+lrSsS0EXvDyXkCk4DY+WEawymr4eKj4b8hTNFP3cPCtbD2/NG22qZmkzuATld35uZz5lSCKDwpX11JZrTr8HJ6hBwcbGpOho6p21YIMn3NqWokLccnBLy5CDF0VQWmo9B7YqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=Qh+SFOC2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hrjQmkGw; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 4C4285C00A3;
	Fri, 16 Feb 2024 12:04:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 16 Feb 2024 12:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1708103094; x=1708189494; bh=bTCMfMRgj0TAxiQeyNSNVpFoxlWh0Oj72NH
	6xXdaFx0=; b=Qh+SFOC2uzfXFBf2MQSyLCdE/iSEti9OEl50htzixNEhyH3p6uD
	ttorsdTatpDLJct9xYK/4M3p/v7LE26pEawkhX7e/2gw/IgIzs+ZnS0OlP6lk+GM
	ky8YC+gWiiRpMIiUyVUI440RtoKFFQL6F3XF/7jnQTCtljg5jUe8YyQDVCwSs2X0
	EiaOz0v44hVK/fl2b4G4CGshkV4t5MDCSjUGswZ2+MZXyZCka1nlMw/+KtnzqqMb
	bRnU1jjZCdIibwvZ3ewjRHaciWMNXBOY5T5oWefeQM53QEmyjbNvjT09kiFL+KHE
	MK3s+71oUT9iXOSHIQqrV9Pigpngwe7lufQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1708103094; x=1708189494; bh=bTCMfMRgj0TAxiQeyNSNVpFoxlWh0Oj72NH
	6xXdaFx0=; b=hrjQmkGwrw/QsZ5Oscv5eFQex/wKIva4wZWzZZTaY8WxwPrCbpL
	/ZEs1k6WWt/DCUHTPsxn+xV/sxbFuyc/GeRxj0F+KqJKqsHAdfouZeJPYmbY3Llc
	qFDPmgp0dlEjvCp0JEAVVMc7CTuB4tudRrtgDKZQNbEDGajyQl7TZbpmBYzOK2AN
	+R8PjACg5jv+jcaXiSiRoegIQsH6NxUP8XFWTtzFS6HWHrSqvz589A1OuKpQ5i50
	n3BqTWs+bOWlfzAO30MSVhbfDDlzGhM5UXXuob7GZAgXH9cPTf8pucGiIF2vUIRf
	sMR7aFPAF37x1XJ6C+uErmm2LAwmQQ172bg==
X-ME-Sender: <xms:tZXPZa3D2j_MERrBKctuJUQNjK5uR2hJTyslpKPYR23L5gKxGzibHA>
    <xme:tZXPZdHaZG2kEdmvsBNoTDuYE9bVeHFtCdzXEVF_29FPwnGAoIvluhJMpZZLMsdWZ
    F9W5e4nfSdkcm4jWQ>
X-ME-Received: <xmr:tZXPZS5JlR7YrDAt-o8_LoIFUY6YwyuWpHzRSmmFWt8ti4cYhaqDcYy-p2UXXpzo7QvWlL3IJDi-8_9HNOPCvrIZo3IikmpTU1-HUs_nlxA4KeiLoakH0esN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfrhggtgfgsehtkeertdertdejnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeejke
    etkeffleelkeduffdtfedvtdejjeeutdeutdetgeejgfevtdefudejkeeiveenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:tZXPZb3omsRd4Gh_unjytLInkPSPx28ZhZffPl90MhlMDMW6Q_cd4w>
    <xmx:tZXPZdGqjpNfHgN_SFnr80W6ejNms-JT3lRMbcItvw-W5wMjBsrrxA>
    <xmx:tZXPZU8dyTj8X2r66a1dkUmSmsACKYhgtT93LZqZHivRkobfhzGwtg>
    <xmx:tpXPZb_x42GGfPrEd_tI5M6TW2RNv2Jh4cF3zA4zg9NaaVxskZDEAg>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Feb 2024 12:04:52 -0500 (EST)
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
Subject: [PATCH v6 4/4] mm/compaction: optimize >0 order folio compaction with free page split.
Date: Fri, 16 Feb 2024 12:04:32 -0500
Message-ID: <20240216170432.1268753-5-zi.yan@sent.com>
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
index f21836ca243a..b2a570e00a8e 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1832,15 +1832,40 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
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


