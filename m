Return-Path: <linux-kernel+bounces-84423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8037786A6A7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B10D28A715
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952E71DFCB;
	Wed, 28 Feb 2024 02:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M6VRNueb"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB411DDD5
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 02:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709087948; cv=none; b=cGsw44TBJqTPU+HuJx27ZHwBnD0uGryHP9N3Pr2KMVObUI4hE9zXrU4ZyQCsPxOZsff4httJfVr8IW0vvbHTewWnAzPinfh1Rz4mgxKVT0KdwWNQ9fcosmgVpOPfyRcw8Fxuw2Nq6zjcJLuLMHp8ngXtj/lCyXIL31nXn7AQrHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709087948; c=relaxed/simple;
	bh=XkYcjE4jYmgMfBuKBCqdEkgX/I6J5sM+poB02RevkEk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hYrXzmDXH9FkmDUfmcihxlduOTuGWrhhn4N8GGx5Gmtj8/CnsdpIIOPsDGKudAFynLjAxPYpuu8fCPd54X3HQXKm5F+56A8yRlM8EGRerKlcVvuqtkKvBGpkx0DIsfuhKOb/PTDgYLe6YZc6oqZ4drjaJetx645j7F4Eieu9hZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M6VRNueb; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709087943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W49AL2L4dBY0pya+pySiI7auyAe7hw/1CeIi/DrQqm0=;
	b=M6VRNuebEnauruoB8iKCfMYtMdMOamdgBCSZW52IQ7GDKnLjDrzulxldCWlGdIx6BMpYP1
	sszPdsCbEcCUPiYDKUc2gtN1+4T2eL0sGHZcEpT33sXI8cfF+gFgxjv8OiBFLsK/UXQK5M
	T60r2pamlUoSwEVstvjnw61ZrIVspjE=
From: Chengming Zhou <chengming.zhou@linux.dev>
To: minchan@kernel.org,
	senozhatsky@chromium.org,
	akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	nphamcs@gmail.com,
	yosryahmed@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	chengming.zhou@linux.dev
Subject: [PATCH v2] mm/zsmalloc: don't need to reserve LSB in handle
Date: Wed, 28 Feb 2024 02:38:54 +0000
Message-Id: <20240228023854.3511239-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We will save allocated tag in the object header to indicate that it's
allocated.

	handle |= OBJ_ALLOCATED_TAG;

So the object header needs to reserve LSB for this tag bit.

But the handle itself doesn't need to reserve LSB to save tag, since
it's only used to find the position of object, by (pfn + obj_idx).
So remove LSB reserve from handle, one more bit can be used as obj_idx.

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
v2:
 - Improve the commit message to make it clearer, per Sergey.
 - Link to v1: https://lore.kernel.org/all/20240227030045.3443702-1-chengming.zhou@linux.dev/
---
 mm/zsmalloc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 63ec385cd670..7d7cb3eaabe0 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -110,7 +110,7 @@
 #define OBJ_TAG_BITS	1
 #define OBJ_TAG_MASK	OBJ_ALLOCATED_TAG
 
-#define OBJ_INDEX_BITS	(BITS_PER_LONG - _PFN_BITS - OBJ_TAG_BITS)
+#define OBJ_INDEX_BITS	(BITS_PER_LONG - _PFN_BITS)
 #define OBJ_INDEX_MASK	((_AC(1, UL) << OBJ_INDEX_BITS) - 1)
 
 #define HUGE_BITS	1
@@ -737,14 +737,12 @@ static struct page *get_next_page(struct page *page)
 static void obj_to_location(unsigned long obj, struct page **page,
 				unsigned int *obj_idx)
 {
-	obj >>= OBJ_TAG_BITS;
 	*page = pfn_to_page(obj >> OBJ_INDEX_BITS);
 	*obj_idx = (obj & OBJ_INDEX_MASK);
 }
 
 static void obj_to_page(unsigned long obj, struct page **page)
 {
-	obj >>= OBJ_TAG_BITS;
 	*page = pfn_to_page(obj >> OBJ_INDEX_BITS);
 }
 
@@ -759,7 +757,6 @@ static unsigned long location_to_obj(struct page *page, unsigned int obj_idx)
 
 	obj = page_to_pfn(page) << OBJ_INDEX_BITS;
 	obj |= obj_idx & OBJ_INDEX_MASK;
-	obj <<= OBJ_TAG_BITS;
 
 	return obj;
 }
-- 
2.40.1


