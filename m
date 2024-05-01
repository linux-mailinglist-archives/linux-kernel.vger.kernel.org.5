Return-Path: <linux-kernel+bounces-165645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A38008B8F02
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592FE2839D1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE731B810;
	Wed,  1 May 2024 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="If080VrU"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61911CD37
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714584400; cv=none; b=mCxUzdriDewQZGxQOYwt0ain/mKiGRImrvrpWJQwtnYyTyXzbUze0v8geWCTXYHZKnolisON3rM803US5/6FYfbE3KPKtYlvJRaMqTAm9QfuJGCkWP8UF9goq5VstHy/ULoRCSHaNUBMa6vnhK1xOW2Nguv/2NBC1rbU9jN7FFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714584400; c=relaxed/simple;
	bh=SGpb1457OsTElJRTOe797yw4gXpVrtIvEhr3MxZFSo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1ZiM+kBp2vfS4VJfnqB0f4hma7jVrsk3gltp/mwhGA2ltrdOqB8PjnB1HzBUPJeVYFn0StwjrsbSaAVdWpGshUHqGtOYpTETHD6Vo6J5w2+57l2t5clzXniw46qWNCcV+xw+690w/by9U7W2479gI5iSyZFiEDeWR8ansMOZT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=If080VrU; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714584397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JuviNSLTVsDm2/Um5Hfjfi5K4HkGkzN+hyrTetNNaTI=;
	b=If080VrUZeaO5mlZ3lObU0HLh9SFBUBimkTYvPuIkRA/tpnOeALwyjhGWuu/NaO77tLhLx
	mmezzwbTym0qQ927euj7Kk9h1CWx4JQ0J96wFEZT3cAJNQPrqkIkEpHJ7L8GlkhL/RHPiy
	KbmHTH6I7hXFRF+V0wq38poukU67Sr0=
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
Subject: [PATCH v4 3/8] mm: memcg: account memory used for memcg vmstats and lruvec stats
Date: Wed,  1 May 2024 10:26:12 -0700
Message-ID: <20240501172617.678560-4-shakeel.butt@linux.dev>
In-Reply-To: <20240501172617.678560-1-shakeel.butt@linux.dev>
References: <20240501172617.678560-1-shakeel.butt@linux.dev>
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
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: T.J. Mercier <tjmercier@google.com>
---
Changes since v3:
- N/A

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


