Return-Path: <linux-kernel+bounces-74236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7F485D16D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9081C238F7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC73F3A8F8;
	Wed, 21 Feb 2024 07:32:57 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9894D23C9
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500777; cv=none; b=boXYGYWQ0sC+KMkURBtqA4Jf3QnyO2XZymWUHn8IxyNpfK2ndGgf8ugZk4pJRyzPWgsVcesTUpY1jnpJeCh2gfZ/Li4kUOI0tC6WIdA2PK0lClaYQpuEsiAi5aioMk1xCZc8mwIjqAc9pFj/s8h64LNtnUKNuLJlYkDNlpT+Wu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500777; c=relaxed/simple;
	bh=REW/fYWx85UIvzqCYzNoB3qDZ35SMMTWUV4q5E5yhcg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O19KkUSg+IT6Iwr133L8ZDUzYW0ii6QyJENdw+uv/GhLGenuCoNAL8QVcUvIL41/j+ZFW1HJh7CTBVl5ADwNX+7SI28iNt6RQ/17IEeHkygq6hKSXhEiNVstBr0EyQ4JAnOr6w9566X4+G96vXSuZAZyR74PbSLq7qhsaAu323A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fa1fcfec39d84df9adddea1453a1edf1-20240221
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:c70d5b67-8290-48a2-8ac6-a4ec37ff4448,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:25
X-CID-INFO: VERSION:1.1.35,REQID:c70d5b67-8290-48a2-8ac6-a4ec37ff4448,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:25
X-CID-META: VersionHash:5d391d7,CLOUDID:85592384-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:2402211532412DMUI1TU,BulkQuantity:0,Recheck:0,SF:17|19|44|66|24|102,
	TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: fa1fcfec39d84df9adddea1453a1edf1-20240221
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
	(envelope-from <gehao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1025183778; Wed, 21 Feb 2024 15:32:40 +0800
From: Hao Ge <gehao@kylinos.cn>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gehao618@163.com,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] mm/page_alloc: Make bad_range return bool
Date: Wed, 21 Feb 2024 15:32:27 +0800
Message-Id: <20240221073227.276234-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bad_range can return bool,so let us to change it.

Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 mm/page_alloc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 150d4f23b010..8b5c31cb50c2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -464,19 +464,19 @@ static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
 /*
  * Temporary debugging check for pages not lying within a given zone.
  */
-static int __maybe_unused bad_range(struct zone *zone, struct page *page)
+static bool __maybe_unused bad_range(struct zone *zone, struct page *page)
 {
 	if (page_outside_zone_boundaries(zone, page))
-		return 1;
+		return true;
 	if (zone != page_zone(page))
-		return 1;
+		return true;
 
-	return 0;
+	return false;
 }
 #else
-static inline int __maybe_unused bad_range(struct zone *zone, struct page *page)
+static inline bool __maybe_unused bad_range(struct zone *zone, struct page *page)
 {
-	return 0;
+	return false;
 }
 #endif
 
-- 
2.25.1


