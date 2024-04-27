Return-Path: <linux-kernel+bounces-160826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B63F68B434F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA0C1F22E14
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E8F41757;
	Sat, 27 Apr 2024 00:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SncPF2vo"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD9B40847
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 00:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714178287; cv=none; b=uyBpr//ArkeDU5KJled27LKWSpWe84TwowkM2aJiWodQ7gVWmrtleHeMLxA1zqIfH+2udu0PP2Y5Ok2MP+iIUOKAXXSKDyCk5NeC+khca3TBCTBfy10+I8NyBOx+8DbD17Tby6sjZ1/U5uKcd8SbGuvyBoRczUWy5KjdRKFU0rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714178287; c=relaxed/simple;
	bh=dkznO5UFLYRjlvo6rhP3U2XgAo3NdmOtc60UDRFxx54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9Gq1B+nVTq8zhUpLgOW90AAmKctRS+wPwRaLRfdX+y5PuWBli9+4626OaUgzIPyeTLpKUSmVw9upHbF9Hp4r3goqMoL85AEX+B37iqSomj+7VNiy3yWKv5Rip/L3Gs6SgNuyqJq8bGOadYEguMRr14VCvoiRkCtBa+2kNlN2Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SncPF2vo; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714178284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XaVmG+nL1Z/KgIhQvtyGGfErTWQGfN9RM5fOWCMfM60=;
	b=SncPF2vo7Gj5pGR2HtW7z18CEr5iYUMsR9J3GEV4lMaLOx6+PYwok7wMxTGAqdmd/XJczt
	pZgDrZ1qNeEJIRnvjIs1Aeyf4VLQRcEnJYOnsAE/Dy3rzsexN2xS0tWE7DQUd+u6a/yuZU
	qWm6PPDolOHny72+IBIloElPU+qJuFI=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] mm: cleanup WORKINGSET_NODES in workingset
Date: Fri, 26 Apr 2024 17:37:33 -0700
Message-ID: <20240427003733.3898961-8-shakeel.butt@linux.dev>
In-Reply-To: <20240427003733.3898961-1-shakeel.butt@linux.dev>
References: <20240427003733.3898961-1-shakeel.butt@linux.dev>
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
---
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


