Return-Path: <linux-kernel+bounces-72434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF0D85B329
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355DC2823F0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4401B36102;
	Tue, 20 Feb 2024 06:53:16 +0000 (UTC)
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8841EB3A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708411995; cv=none; b=ShvKMKkxwpiLq/cNbP62KTNsA/MXU5Gq/40aWCw1bpgsliybjkvhMfmgO9pbzzjL7ZjOSFPlIlTsTDj0ZMqNSKzA3zNTQ6C/i+uu9vkz6McsN5EK2BNo3V/ryybasarBaF91mlKH9sGQCTRogIDl2OwczBDGiBSrrf7GWvsQNAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708411995; c=relaxed/simple;
	bh=cqkPrPVAWUs+Ao8dP81X35doam5/5XwHmrqtbfkzja8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p5e9wjx0c+W+Q45jh8l6JG15Xs+0O50Jwx/y0UFp5nUgaCspis0wQTMIiM7tVSJndLcFMtD/IDU+Lq5b07315qch1TGQz2G2Wg7a5zIc94eZolo3Nc33ivoEEgZ2gzZ9rU+F9x+j921TJXhZUVOSJL1Nv1MZFqvZ7b2wFU+dzEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Tue, 20 Feb 2024 06:53:00 +0000
Subject: [PATCH 1/3] mm/zsmalloc: remove set_zspage_mapping()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240220-b4-zsmalloc-cleanup-v1-1-5c5ee4ccdd87@bytedance.com>
References: <20240220-b4-zsmalloc-cleanup-v1-0-5c5ee4ccdd87@bytedance.com>
In-Reply-To: <20240220-b4-zsmalloc-cleanup-v1-0-5c5ee4ccdd87@bytedance.com>
To: nphamcs@gmail.com, Andrew Morton <akpm@linux-foundation.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 hannes@cmpxchg.org, yosryahmed@google.com, Minchan Kim <minchan@kernel.org>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708411986; l=2317;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=cqkPrPVAWUs+Ao8dP81X35doam5/5XwHmrqtbfkzja8=;
 b=b6RxioH3nI4BzApNzDWLkeJUM2KNNI2jIWfPF0wnvNdHFanI0ZxZ8jRdFwHgIq3V0GN2CzKie
 q3prV92J9KxB5aPLZFDeZyXd2Qc3kEs2h5qb8Cu+K3t4Kjat+DJ1Zyp
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

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

