Return-Path: <linux-kernel+bounces-163388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC80A8B6A2E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4931F224E2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A3C1C280;
	Tue, 30 Apr 2024 06:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PeTHaWtH"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F871B96B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 06:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714457194; cv=none; b=kKxmgym+dC40xeItspBPDIUH5lRsBsUC6oGCzyhcQBESBUOnWfnZRgGOv9pWmOKZsALSe3AC725BFdFDo73r6xvS/bSj07R50LiJjHFUPOOiQyhmOVO16rV28R4+JB4VdICae5IvmyBX/RBztoy8uvS3MV/A47I+IFX5Aja9KUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714457194; c=relaxed/simple;
	bh=OCjUhL8u0ustWTtr862Hux6+rr/q4YzkONnKLU21Nk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDjfyemwqCF4PS3px04aFyJoQe8NS+GPh0uG3vbYtMJTfxpLtQbDoLK8rtoYX9Q5iQd/0A+NnaMs3x0CxNupv145BsosRkfbqFe2dCX5+TxehZ2fQfNTvsTW/kCoHgEnD5VyMTRu2iI3oHAPQ/YzE1pE/IfV3sIEtPt1AsKoEBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PeTHaWtH; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714457190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5r5hMtfswp5qoj9glT20FCqOKYLmIdRrP0lNWsirtps=;
	b=PeTHaWtHFNHgJkCXWCF/Ai07h2OyJw4wbWxj/hRwj0ynslSaUgA9yIq+xHiiRg6Is0gE5T
	dBPacjZehCXpuz9tiwffhX/AyogEmjHQ/UiWLdnv0irunhDrAvkdSSYKPHm5ydKRd5y1H8
	xYbZIifAU4bef22QTLtYPQfKgrHJZPI=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>,
	"T . J . Mercier" <tjmercier@google.com>
Cc: kernel-team@meta.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/8] mm: memcg: account memory used for memcg vmstats and lruvec stats
Date: Mon, 29 Apr 2024 23:06:07 -0700
Message-ID: <20240430060612.2171650-4-shakeel.butt@linux.dev>
In-Reply-To: <20240430060612.2171650-1-shakeel.butt@linux.dev>
References: <20240430060612.2171650-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Roman Gushchin <roman.gushchin@linux.dev>

The percpu memory used by memcg's memory statistics is already accounted.
For consistency, let's enable accounting for vmstats and lruvec stats
as well.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7126459ec56a..434cff91b65e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5545,8 +5545,8 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	if (!pn)
 		return 1;
 
-	pn->lruvec_stats = kzalloc_node(sizeof(struct lruvec_stats), GFP_KERNEL,
-					node);
+	pn->lruvec_stats = kzalloc_node(sizeof(struct lruvec_stats),
+					GFP_KERNEL_ACCOUNT, node);
 	if (!pn->lruvec_stats)
 		goto fail;
 
@@ -5617,7 +5617,8 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 		goto fail;
 	}
 
-	memcg->vmstats = kzalloc(sizeof(struct memcg_vmstats), GFP_KERNEL);
+	memcg->vmstats = kzalloc(sizeof(struct memcg_vmstats),
+				 GFP_KERNEL_ACCOUNT);
 	if (!memcg->vmstats)
 		goto fail;
 
-- 
2.43.0


