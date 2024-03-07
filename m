Return-Path: <linux-kernel+bounces-95578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B6D874FB5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86B21F23617
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E676E129A98;
	Thu,  7 Mar 2024 13:13:29 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505943233
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 13:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709817209; cv=none; b=HQ5bdxG2mo6nSKZyaM+VX3XdJ4YeyYbouhx3MiPLsxHa6YzlX2nOLyogMoa5FcNjsCZFOjvJEl+OQGEe/x8W0500oQ3U4GVCiqD6oGs+IktkhRXuvKGMQFDWBfTFZJGCW5v3eHveX6QYIIyblWcdlYKDuxEwE2zVTs2XbWCD2u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709817209; c=relaxed/simple;
	bh=xrAHyxhBVNZyegD3Y3xng5QLg6iSzIQ41xzs5c1Z93E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dKaKdVRiRqfmJxjfoJI05gx6y0QlbebxAAhhV8qkVYkSS7FpKQzIXfMNvtzwm0bWcLaDYjLYPGaekecORxrIe3uShjUiDvFubC00dgOWgVoUXgCVsN07W9A5jN6oCnmXKS6vAfAvRc0Xthl5LrXwQSN/YaNf+HupJOUCgV1K0SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 08dc2675490e4bbc92606375eac1b6fb-20240307
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:e712c678-b423-4227-9a7a-709d12c7680c,IP:25,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:10
X-CID-INFO: VERSION:1.1.37,REQID:e712c678-b423-4227-9a7a-709d12c7680c,IP:25,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-META: VersionHash:6f543d0,CLOUDID:ae793b81-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240307211317NCOVBWQY,BulkQuantity:0,Recheck:0,SF:44|66|24|17|19|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:ni
	l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 08dc2675490e4bbc92606375eac1b6fb-20240307
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
	(envelope-from <gehao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1133455212; Thu, 07 Mar 2024 21:13:13 +0800
From: Hao Ge <gehao@kylinos.cn>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	gehao618@613.com,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] mm/page-flags: make PageMappingFlags return bool
Date: Thu,  7 Mar 2024 21:13:04 +0800
Message-Id: <20240307131304.169859-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

make PageMappingFlags return bool like folio_mapping_flags

Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 include/linux/page-flags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 735cddc13d20..30740304059f 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -642,7 +642,7 @@ static __always_inline bool folio_mapping_flags(struct folio *folio)
 	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) != 0;
 }
 
-static __always_inline int PageMappingFlags(struct page *page)
+static __always_inline bool PageMappingFlags(struct page *page)
 {
 	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) != 0;
 }
-- 
2.25.1


