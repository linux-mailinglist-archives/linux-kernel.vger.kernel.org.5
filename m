Return-Path: <linux-kernel+bounces-96011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AD8875606
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC751C22A63
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9189D134CC7;
	Thu,  7 Mar 2024 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="ibb/EWQQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e5s/BHxf"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0439E1332B3
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709835633; cv=none; b=kUYFXdU2gYsOiVAntBVTKGsnv9BjLKsZAG9vvVxa4cU+tuIJDXkSTiW5wnMzweBs7jnu0mX5AtmSQtX/d+oxXz7uns6wIwG6g9+vWwOPnTmZBlewOIClO0EHGkqD1Pp6HVq1+mN7fC547fKJFwRkmiEWWVODQfRk53MjAdi9v+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709835633; c=relaxed/simple;
	bh=NON2ceGg1hFi6ieg3vTLXF6y+q6yJWEQ1tvfazwCr+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CL6sI48IABf9uYucOw6DM81sNxyumbKiJB7VUQs5GQB980dJpEEyTo7cINN9a8bvZXEidyizxFyijR0dme3NVr543FO++NhWWWLluz/V6xEq507hA4dwFOuLNyCA6dOzy0jVu5nAmjxJL3dL7xRwbHMi8+PQeFHwCVyXodee69k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=ibb/EWQQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e5s/BHxf; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 1C5743200319;
	Thu,  7 Mar 2024 13:20:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 07 Mar 2024 13:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1709835628; x=1709922028; bh=Bzn2/HzPoneEzIl1irDBBJLijK1Oy0SB9DI
	4n9G42+Y=; b=ibb/EWQQhLxTZOSpDi4pGqyLnOsBGSO6hMrqx9bkeyTLNT+mIe4
	hMm7msjhD5zh3dkM1dzTsiUuiBNw01j+0CntWimywpNLGE9TvaEI6KWmZQU6PctD
	6F1ypPcUp6bUsTCYeNFIjdhNGleUwlwbGHTZNagBVHqhPYun0d5yI/R6pmrNgzTb
	f/SioJNNGNg4So5tZffWJCFAH8vJy2VIrxIdejVe2LxspFC9Kv3lzEBljTjxyGOi
	1BTnX+ABz1OlleBN+uNfhiQrwWCNf1oykj5QYWKvJHJBtKYWXSd1sobvhkX/GkfS
	nhckEHMjOaNzNYZFw+7XBj/DSXVE1+LjyCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1709835628; x=1709922028; bh=Bzn2/HzPoneEzIl1irDBBJLijK1Oy0SB9DI
	4n9G42+Y=; b=e5s/BHxf7qUOEHEosBWBlYKgqSQWZDXP8+wtrwv81GGqXmPB3hA
	EIHYZp/HxRbpNHAUlVONkGj6IIuX8/MSp8dv7aKb/SR3xR7zY+tUA8NZnhlSLcI2
	mUwqsmxzd9Vc9w+ehKwBZnX2Arj9uApvebvjZnDcaxDR+Y0ul/9V2CxjTM94yUqc
	Zwmi2vd9mT6VR+J/5Ug26K0LfqMZo/G9WLDBhztsrr7KZ+oPEvuXJGxGD8I+Ou1S
	CMOQQX3qDl+FdV63rVNqzmwC1WBhiO9t+L4xc8XoK9coEmaiXdXdsfHMM5VNfida
	EsbPrOSGgqklOtGcBUG++Vwt3XB/Z35VkFQ==
X-ME-Sender: <xms:bAXqZbhgMabQ5rzQgu_zgmac4mXr2BSNYnOxwRs4esIlpmpQhYYGCg>
    <xme:bAXqZYCagSFyk8O5XL6VuAQthG_82mwZecrUUiVHDjO0jCEDzt06j3-Hk6ERI0qsh
    LNBQelMHhS22n5jcQ>
X-ME-Received: <xmr:bAXqZbEgXhqDOZ_nOVesBka3qh3HxBsm_alejmS-eDItB3PzXYIHcNF2rqc6V0xnUnXIks-WADC938qX3aMlNk56PxJ3G4QGjrkupLpwFIGLnFnTvMbHo1V2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrgggtgfesthekredtredtjeenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepte
    dtkeejffekjedulefhueetkeeijeeiheejfedvfeeihfetveegjeehgeekgffgnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:bAXqZYRdgrFw8uioZpj90jqPFYImqiXFh1sdwI7PxwJ8Pwp7XUhIbA>
    <xmx:bAXqZYwtep5fwUZZ7haowYNczZ9DsHHrhJRfpGm17e7N32lnyfF8kg>
    <xmx:bAXqZe7I5yQcZouzLs0Tm9qsUwepUO4q-bbOH9Bn5nekgO2RwCXyPA>
    <xmx:bAXqZS7z2bhDxOgoZKFZ6QuKJfs2NzNrYb4cOS1Z1LkI2wfHosW1CQ>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Mar 2024 13:20:27 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: Zi Yan <ziy@nvidia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <shy828301@gmail.com>,
	Yu Zhao <yuzhao@google.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm/huge_memory: skip invalid debugfs new_order input for folio split
Date: Thu,  7 Mar 2024 13:18:54 -0500
Message-ID: <20240307181854.138928-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240307181854.138928-1-zi.yan@sent.com>
References: <20240307181854.138928-1-zi.yan@sent.com>
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

User can put arbitrary new_order via debugfs for folio split test. Although
new_order check is added to split_huge_page_to_list_order() in the prior
commit, these two additional checks can avoid unnecessary folio locking
and split_folio_to_order() calls.

Link: https://lore.kernel.org/linux-mm/7dda9283-b437-4cf8-ab0d-83c330deb9c0@moroto.mountain/
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 57fca7bffd20..9859aa4f7553 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3486,6 +3486,9 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		if (!is_transparent_hugepage(folio))
 			goto next;
 
+		if (new_order >= folio_order(folio))
+			goto next;
+
 		total++;
 		/*
 		 * For folios with private, split_huge_page_to_list_to_order()
@@ -3553,6 +3556,9 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 		total++;
 		nr_pages = folio_nr_pages(folio);
 
+		if (new_order >= folio_order(folio))
+			goto next;
+
 		if (!folio_trylock(folio))
 			goto next;
 
-- 
2.43.0


