Return-Path: <linux-kernel+bounces-165648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C86A8B8F06
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FE97B21B22
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83441304BD;
	Wed,  1 May 2024 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YllzTqli"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D49F12F379
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714584408; cv=none; b=O1owgCbkoLSEGjG3s5Xd51rYJiLp749PQEa0JhYAE8/+oBU/x8BFBtwOfBbVgL09Grd4dbuwudTOYMwvNDWrMjiVHV1DHrFl+/fmArP90ojebGakKSsHbZk90GtaVTZZq2zGWM1HXlv9ObsK/X+SlEncb/Mcw6QOaHWjOMc+wuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714584408; c=relaxed/simple;
	bh=arC6n41tJkWrwWejZ1VKD8GPi7GOBBb6+HRk5RjjI/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fbf5DW6suLBIyU+KhojloQAIaz/PUBH9q8Tx5OUgomAhQSBLZRtzRtwXaYKOC5e5umwVDJAqTte7UrjY33KODmGEgbtM7sbi40cJvEstZAySd5hM1EFGLTJo8iLc8eRSknSJ9G94mRkkZ93/v9Uk0A9t0a0YISg8KOjRsZ0d/s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YllzTqli; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714584405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9l4h9rie3ivYcnawsodk45GJOrF/TCVwGQRSWBbU5Y=;
	b=YllzTqliiBcI+Aeoe8N7nlIwm57TMV4GBbDUW7Gs09N6g0ncTSgttX6g5AuD2XQq1L1kKx
	wwfv4dy2Hbq8pAeX2MHK9w6Z6P0ndH05+Ncdg1vb5QCnTHF9BevviekazDKX8/0cJw5QhC
	b+SnksRmtYa+1xk4xF+paE+q/1cuoI8=
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
Subject: [PATCH v4 6/8] mm: cleanup WORKINGSET_NODES in workingset
Date: Wed,  1 May 2024 10:26:15 -0700
Message-ID: <20240501172617.678560-7-shakeel.butt@linux.dev>
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

WORKINGSET_NODES is not exposed in the memcg stats and thus there is no
need to use the memcg specific stat update functions for it. In future
if we decide to expose WORKINGSET_NODES in the memcg stats, we can
revert this patch.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: T.J. Mercier <tjmercier@google.com>
---
Changes since v3:
- N/A

 mm/workingset.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index f2a0ecaf708d..c22adb93622a 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -618,6 +618,7 @@ struct list_lru shadow_nodes;
 void workingset_update_node(struct xa_node *node)
 {
 	struct address_space *mapping;
+	struct page *page = virt_to_page(node);
 
 	/*
 	 * Track non-empty nodes that contain only shadow entries;
@@ -633,12 +634,12 @@ void workingset_update_node(struct xa_node *node)
 	if (node->count && node->count == node->nr_values) {
 		if (list_empty(&node->private_list)) {
 			list_lru_add_obj(&shadow_nodes, &node->private_list);
-			__inc_lruvec_kmem_state(node, WORKINGSET_NODES);
+			__inc_node_page_state(page, WORKINGSET_NODES);
 		}
 	} else {
 		if (!list_empty(&node->private_list)) {
 			list_lru_del_obj(&shadow_nodes, &node->private_list);
-			__dec_lruvec_kmem_state(node, WORKINGSET_NODES);
+			__dec_node_page_state(page, WORKINGSET_NODES);
 		}
 	}
 }
@@ -742,7 +743,7 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 	}
 
 	list_lru_isolate(lru, item);
-	__dec_lruvec_kmem_state(node, WORKINGSET_NODES);
+	__dec_node_page_state(virt_to_page(node), WORKINGSET_NODES);
 
 	spin_unlock(lru_lock);
 
-- 
2.43.0


