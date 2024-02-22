Return-Path: <linux-kernel+bounces-76203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5232885F422
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7FC3B264A2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8233E376F9;
	Thu, 22 Feb 2024 09:20:04 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C210374FC
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708593604; cv=none; b=AURlbk1DMJE+xqMzJhCdLe1CQE7DrLf3G4yCafDl8XSsGU64vwElWqGFKqLAXDE46s70mV+/vLFx39UyzTVLFRnV/WJMJ72CX4+ed7oZ3Ce6PXYLkxjfZvOqnh/bETIX7RwTGHKmaRN/fylncXfrkfCNo1fAyv6ja6UL+lh0Zik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708593604; c=relaxed/simple;
	bh=ANkNqwXsmtPuOzbLx+H6ZXxfhGnqPbfCnaTERUYV3WA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hj7m9GoF6l5TiiIO6gmqqQiD2a1XbM+/lJCAqZOurQ8wJjBTeHCrwgc/PWKznFvBco4UndY6z3OCfz40JLIT7F+P9FzHr7FFDOyqaD9ieVYjH1oHf1ZNbFfQSVHLiF3a52vqHjorcNa48haHvBMSoRuOuImSK+o5VoGbzwowUCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7c6705b100a440f8867d2993efaf481b-20240222
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:96dc2a91-b9c3-43bb-80a7-42cdec47de1a,IP:25,
	URL:0,TC:0,Content:0,EDM:-25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-15
X-CID-INFO: VERSION:1.1.35,REQID:96dc2a91-b9c3-43bb-80a7-42cdec47de1a,IP:25,UR
	L:0,TC:0,Content:0,EDM:-25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-META: VersionHash:5d391d7,CLOUDID:7fe9968f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:2402221719539PY4MH4A,BulkQuantity:0,Recheck:0,SF:24|17|19|44|66|102,
	TC:nil,Content:0,EDM:1,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 7c6705b100a440f8867d2993efaf481b-20240222
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
	(envelope-from <gehao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2074393446; Thu, 22 Feb 2024 17:19:50 +0800
From: Hao Ge <gehao@kylinos.cn>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gehao618@163.com,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] mm/page_alloc: Make check_new_page return bool
Date: Thu, 22 Feb 2024 17:19:32 +0800
Message-Id: <20240222091932.54799-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make check_new_page return bool like check_new_pages

Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 mm/page_alloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 150d4f23b010..c7a0bc546d2c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1422,14 +1422,14 @@ static void check_new_page_bad(struct page *page)
 /*
  * This page is about to be returned from the page allocator
  */
-static int check_new_page(struct page *page)
+static bool check_new_page(struct page *page)
 {
 	if (likely(page_expected_state(page,
 				PAGE_FLAGS_CHECK_AT_PREP|__PG_HWPOISON)))
-		return 0;
+		return false;
 
 	check_new_page_bad(page);
-	return 1;
+	return true;
 }
 
 static inline bool check_new_pages(struct page *page, unsigned int order)
-- 
2.25.1


