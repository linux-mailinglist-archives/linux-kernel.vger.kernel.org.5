Return-Path: <linux-kernel+bounces-44249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEBA841FAD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32EF0B3111E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FFA60DD4;
	Tue, 30 Jan 2024 09:23:29 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7060A60DC7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606608; cv=none; b=uqHGLcBZpzzBgCylEoZ8CA9b4dHuZ7PG68r1DbSTDcGigSTuIciBSwqn3OKOPprZqrKC9VqJl5oEZq+QEn7JwQZA6GIOinvqaAEs5ITVD9rs2K2DRn0Ixg1YcweyZ584Ym19pd5gkXE8RK9C4DQ8ce7XEpD5Qc31yIus3JHc2Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606608; c=relaxed/simple;
	bh=TjCsIPX1bEde3FLQslGPgZXu5fL0mcVt0GKZSwJSPBA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MUHyPFRHSUHTK9Cje9O7fBzCQtcLROhS4316DAhL6FOQln768SPhi7AFWO8geD+PxSSVapQ5RnBN0NjXKiK2urrvKBL9jEAg22qVk71gNJ2GkIbwoeQwlxMgGE9jbXi0ys4bwkgcxZtFBOxiIjEAwajilvyPlzEFjKwQJ/iaW7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1c5e949a4d1043aaa5c407e53585448b-20240130
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:28105e74-5369-4c3c-a842-f5d8ec487464,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.35,REQID:28105e74-5369-4c3c-a842-f5d8ec487464,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:a4e06983-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240130171800U5BLH98G,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 1c5e949a4d1043aaa5c407e53585448b-20240130
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
	(envelope-from <gehao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1414335610; Tue, 30 Jan 2024 17:17:57 +0800
From: Hao Ge <gehao@kylinos.cn>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] mm/vmscan: Change the calculation of the number of can reclaim anon pages in zone_reclaimable_pages
Date: Tue, 30 Jan 2024 17:17:55 +0800
Message-Id: <20240130091755.21363-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The spaces of swap devices that can be set by the user
are unpredictable values, so we take the minimum value between
the anonymous page in the specified zone and the spaces of swap devices.

Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 mm/vmscan.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4f9c854ce6cc..2deae4232b83 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -341,14 +341,21 @@ static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
 unsigned long zone_reclaimable_pages(struct zone *zone)
 {
 	unsigned long nr;
-
+	unsigned long can_reclaim_anon = 0;
 	nr = zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_FILE) +
 		zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_FILE);
-	if (can_reclaim_anon_pages(NULL, zone_to_nid(zone), NULL))
-		nr += zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
+	if (can_reclaim_anon_pages(NULL, zone_to_nid(zone), NULL)) {
+		can_reclaim_anon = zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
 			zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);
-
-	return nr;
+	/*
+	 * The spaces of swap devices that can be set by the user are unpredictable values,
+	 * so we take the minimum value between the anonymous page in the specified zone and
+	 * the spaces of swap devices
+	 */
+		if (!can_demote(zone_to_nid(zone), NULL))
+			can_reclaim_anon = min_t(unsigned long, can_reclaim_anon, get_nr_swap_pages());
+	}
+	return nr + can_reclaim_anon;
 }
 
 /**
-- 
2.25.1


