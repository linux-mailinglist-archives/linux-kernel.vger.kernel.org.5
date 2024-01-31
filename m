Return-Path: <linux-kernel+bounces-46244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FDD843CEF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9281C27D67
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03486A012;
	Wed, 31 Jan 2024 10:38:35 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA7869DF0
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706697515; cv=none; b=d4PkPaafmoBarPLrJhrFVGPxtU3JliQcwNK33hEVO4HttRU89JAzLz1KFYym6B4BUk0ARuzR7M54TsYJnB6jUSPIJE2S0bEiClpmC6ra9/wQB+7RRt84h36PYvtJEsF8UrZ8ufF7QUufD6gPO5CCVgC2nfdXgNcx8P+hNzmuEwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706697515; c=relaxed/simple;
	bh=C8e1M8gT3q6KVm69a0LzgiD0s9uDpLb2DaneXAidFpc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kh16SepFD9wItxB5xWIZRZc3UVQZAZ0RO3flyvHr2t1V2zKpVQFhy1n0S3RtRj0CO3+lFP7i4dOd+5bMirx3lRxcKNX6Du88q8rb7zNLK/ZPBv+1NDIRvKz6qZprY27W6bBI3ckt87fdNLk68KeBXOMxc08O6+NwYzGRKcBMULM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2a6a44ca43044fe09b533fd14219fef0-20240131
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:068b03ab-c210-451d-b607-1840b42a0c70,IP:25,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:5
X-CID-INFO: VERSION:1.1.35,REQID:068b03ab-c210-451d-b607-1840b42a0c70,IP:25,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-META: VersionHash:5d391d7,CLOUDID:1b145bfe-c16b-4159-a099-3b9d0558e447,B
	ulkID:240131183822BFS38S30,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 2a6a44ca43044fe09b533fd14219fef0-20240131
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
	(envelope-from <gehao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 520497664; Wed, 31 Jan 2024 18:38:20 +0800
From: Hao Ge <gehao@kylinos.cn>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gehao618@163.com,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] mm/vmscan: Change the type of file from int to bool
Date: Wed, 31 Jan 2024 18:38:02 +0800
Message-Id: <20240131103802.122920-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the type of file from int to bool because is_file_lru return bool

Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2deae4232b83..69047bc9f5fe 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2005,7 +2005,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	LIST_HEAD(l_inactive);
 	unsigned nr_deactivate, nr_activate;
 	unsigned nr_rotated = 0;
-	int file = is_file_lru(lru);
+	bool file = is_file_lru(lru);
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
 	lru_add_drain();
@@ -2419,7 +2419,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	denominator = ap + fp;
 out:
 	for_each_evictable_lru(lru) {
-		int file = is_file_lru(lru);
+		bool file = is_file_lru(lru);
 		unsigned long lruvec_size;
 		unsigned long low, min;
 		unsigned long scan;
-- 
2.25.1


