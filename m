Return-Path: <linux-kernel+bounces-39764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD1383D5D9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD522810B6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB8E12B8C;
	Fri, 26 Jan 2024 08:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t38FsnZ1"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA753C07
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706257922; cv=none; b=C+olsVUaX+gLXEQtmVnz0iIUZ4HABfW5JvYsHn1NjyQd1kjQA+X4eFW0T6hEkBC3ECxWOsRLlxdk15+OSLgb2DNgiQ6Ai3QU47++UdMcC8iTrYf1kLuNv4FETKNFzJnzG51zvSpstVtFArqkExVIeC46r7S2TIDUFj2X1XwAou8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706257922; c=relaxed/simple;
	bh=beAV2xZzm1pfX7BpJJ4sLYGMc2yhgnU5EF3GNuNtmDc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QD+HgMw6t5/umHpmdEUKq/g4KZSfX/SCqF6J3Dv8AbCXsV7/++PUiJLgN57pc+T7i7K03Jz8gDVtgNW1fwSHUJXoUEP758Yatwm2mR8APpjHyu39Fxhm0xyHJoFmCyzM4JfLSZC1c/l4H/n4DXLV3IHaPMBOx+eykg3hp9wXNrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t38FsnZ1; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706257917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ul4Yj318/IPfN1mLm2oHYHwsIT4SRkZ2huqI5cSMQ1M=;
	b=t38FsnZ1Muc6VXvBr4BPW2hj/FxunpwClITeZKYaX+yMeSCpB5klMmu1qlnZQ4WYYk6bbD
	1GiLoLKVo/wWom1Stp4eARMN/cROOzoWLXX5GTzdXy3ExsHOa9BKTaRBTPCWWV6Uvk/adX
	uepBwPm12pYL45eeBg0ZxwSF2w5x0dg=
From: chengming.zhou@linux.dev
To: hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 1/2] mm/zswap: don't return LRU_SKIP if we have dropped lru lock
Date: Fri, 26 Jan 2024 08:30:14 +0000
Message-Id: <20240126083015.3557006-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

LRU_SKIP can only be returned if we don't ever dropped lru lock, or
we need to return LRU_RETRY to restart from the head of lru list.

Actually we may need to introduce another LRU_STOP to really terminate
the ongoing shrinking scan process, when we encounter a warm page
already in the swap cache. The current list_lru implementation
doesn't have this function to early break from __list_lru_walk_one.

Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 00e90b9b5417..81cb3790e0dd 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -901,10 +901,8 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 		 * into the warmer region. We should terminate shrinking (if we're in the dynamic
 		 * shrinker context).
 		 */
-		if (writeback_result == -EEXIST && encountered_page_in_swapcache) {
-			ret = LRU_SKIP;
+		if (writeback_result == -EEXIST && encountered_page_in_swapcache)
 			*encountered_page_in_swapcache = true;
-		}
 
 		goto put_unlock;
 	}
-- 
2.40.1


