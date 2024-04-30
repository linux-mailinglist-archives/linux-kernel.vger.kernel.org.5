Return-Path: <linux-kernel+bounces-163391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7490E8B6A31
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E1C2822C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30D118C1A;
	Tue, 30 Apr 2024 06:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zvjx05Vg"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BCF3771E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 06:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714457203; cv=none; b=PioiwAAVFPy+bxF/58EgvMSyHbaq93p/bI6G06uERbujAFgG1vPTEdJmJ96VA3Yfw27zmCW5xUtYu5BRdVV9zbUdcYVHtRSkW5Gsli30eUlB6U+egp1FXU9CVERZK9QiZ4FPh2RcxAjZ4piNsO6lv6PkNORkznKqC//yVJgtr60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714457203; c=relaxed/simple;
	bh=Yt6taaOV50WQ9OI6QYKbIN8dZVODj5+9ojwQp16L3iM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoBeYxgX0XpzhIEvmK0nRsBG0w7bvWfeIO0qJ3Dp01YwkJxhWmdnPVRokZGPP1oClD/0wlXPTZZjO0zKqk5JFuTVEUsk4VU5EhkwZKxzasurx7itxyE9F8XDWaFstYKtujnOEFQp4ocd8GEOO6IQccKYmJFhU6+ijOYNz3lnaeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zvjx05Vg; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714457199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3q1W7D1q9MXTrJoQi5E1RFDlpl05owU67WZ+nEUBEsw=;
	b=Zvjx05VgmEQtihTxz/c69px6v2O5rBQ6CAXVV5XJDCN9QIGwtVdWfgW0aW1WLezr8zeDVJ
	zKAt36dlwhmlOfD/FK11SMqB6MnAnnB0oRd07xODCZ2IYBioYy8jixmJkk1+4QTpOQfCkT
	WFnehtYOPj0Jpa6WCliKDbOMN+qGLUo=
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
Subject: [PATCH v3 6/8] mm: cleanup WORKINGSET_NODES in workingset
Date: Mon, 29 Apr 2024 23:06:10 -0700
Message-ID: <20240430060612.2171650-7-shakeel.butt@linux.dev>
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

WORKINGSET_NODES is not exposed in the memcg stats and thus there is no
need to use the memcg specific stat update functions for it. In future
if we decide to expose WORKINGSET_NODES in the memcg stats, we can
revert this patch.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
---

Changes since v2:
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


