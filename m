Return-Path: <linux-kernel+bounces-72930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E57185BAD4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F4DDB22B2A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE2467A19;
	Tue, 20 Feb 2024 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cwrTmA0s"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4757666B2D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429484; cv=none; b=ocCK3g2olok1pkz+qX9dSsQ2RSoqaTO+t8urZ8AJ5giV0L/tE+aBpA6E09RLSk8NBTvOScsobOPDFnyZ05p0oeO+QKqAHO9MI7b5KNUNv9afQMeLtsHEx/X1xL31SezTm2wk4wgjuBt9Q/CXA0qh9KftA2z8r062yF5mrKyxmfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429484; c=relaxed/simple;
	bh=kdgQ+vIp+GUEXt8gpLV2Nl0qbyy7LFlK6JMx7o2Phgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pq0uNpqgemdJGgJ+8HHRIIb1inbUYMy6sZtUH3/2yUZ/PgW+Cx4bchEeBQ1OpNoAJ8vQceJQlpbppTav1LFDY3Y3sepxCva1OU6SGLPXzMC64uWFFdFYcr5VeRMTxCtRqQt4+GEMHEA9my7O67yY9ODqpawVGWOwEpOoTH0kngY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cwrTmA0s; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708429480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VdP64AtdS178q4SDQJio0KmQ+nTJNdPzbvzklfYy4hs=;
	b=cwrTmA0sPvnMUtwA1woeElKaxcGZpRmNkxQyoQlraw0/zO68U4jf0+tF/GGDIFjo092brD
	MbMMc1y0eiy8oqd6A3oW0hX1mpmoCKUB5Ic238upKw/66Sq9v557RCnf7Zuci8Fb/6+ktp
	Mi3mbziPE2AVdaVY3GIzj8PWB9dDJpQ=
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Tue, 20 Feb 2024 11:44:29 +0000
Subject: [PATCH RESEND 1/3] mm/zsmalloc: remove set_zspage_mapping()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240220-b4-zsmalloc-cleanup-v1-1-b7e9cbab9541@linux.dev>
References: <20240220-b4-zsmalloc-cleanup-v1-0-b7e9cbab9541@linux.dev>
In-Reply-To: <20240220-b4-zsmalloc-cleanup-v1-0-b7e9cbab9541@linux.dev>
To: hannes@cmpxchg.org, Andrew Morton <akpm@linux-foundation.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 nphamcs@gmail.com, yosryahmed@google.com, Minchan Kim <minchan@kernel.org>
Cc: linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>, linux-kernel@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708429476; l=2317;
 i=chengming.zhou@linux.dev; s=20240220; h=from:subject:message-id;
 bh=cqkPrPVAWUs+Ao8dP81X35doam5/5XwHmrqtbfkzja8=;
 b=fJGX+bZSZ9DmHcZLQStOZiyYVufKsK8+b2cCFX9z5c6zB+JgATrPXCCxaEuuk1J57ChPoEPcs
 Y8dHZRV9xLBDyR4EYl5pMCg/yarVPtVH/ac7GQz0+x5knNUdq0ZOH7g
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=5+68Wfci+T30FoQos5RH+hfToF6SlC+S9LMPSPBFWuw=
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

We only need to update zspage->fullness when insert_zspage(), since
zspage->class is never changed after allocated.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zsmalloc.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index a48f4651d143..a6653915bf17 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -486,14 +486,6 @@ static struct size_class *zspage_class(struct zs_pool *pool,
 	return pool->size_class[zspage->class];
 }
 
-static void set_zspage_mapping(struct zspage *zspage,
-			       unsigned int class_idx,
-			       int fullness)
-{
-	zspage->class = class_idx;
-	zspage->fullness = fullness;
-}
-
 /*
  * zsmalloc divides the pool into various size classes where each
  * class maintains a list of zspages where each zspage is divided
@@ -688,6 +680,7 @@ static void insert_zspage(struct size_class *class,
 {
 	class_stat_inc(class, fullness, 1);
 	list_add(&zspage->list, &class->fullness_list[fullness]);
+	zspage->fullness = fullness;
 }
 
 /*
@@ -725,7 +718,6 @@ static int fix_fullness_group(struct size_class *class, struct zspage *zspage)
 
 	remove_zspage(class, zspage, currfg);
 	insert_zspage(class, zspage, newfg);
-	set_zspage_mapping(zspage, class_idx, newfg);
 out:
 	return newfg;
 }
@@ -1005,6 +997,7 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 	create_page_chain(class, zspage, pages);
 	init_zspage(class, zspage);
 	zspage->pool = pool;
+	zspage->class = class->index;
 
 	return zspage;
 }
@@ -1397,7 +1390,6 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	obj = obj_malloc(pool, zspage, handle);
 	newfg = get_fullness_group(class, zspage);
 	insert_zspage(class, zspage, newfg);
-	set_zspage_mapping(zspage, class->index, newfg);
 	record_obj(handle, obj);
 	atomic_long_add(class->pages_per_zspage, &pool->pages_allocated);
 	class_stat_inc(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
@@ -1655,7 +1647,6 @@ static int putback_zspage(struct size_class *class, struct zspage *zspage)
 
 	fullness = get_fullness_group(class, zspage);
 	insert_zspage(class, zspage, fullness);
-	set_zspage_mapping(zspage, class->index, fullness);
 
 	return fullness;
 }

-- 
b4 0.10.1

