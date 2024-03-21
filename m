Return-Path: <linux-kernel+bounces-109620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D29881B72
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 842EAB21FD0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD5C79C2;
	Thu, 21 Mar 2024 03:23:08 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97BA7494
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 03:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710991388; cv=none; b=scF6KQnjUVTtStIkQ2qit4U4iXSyB0T/omdTTIETFTGJ9oApGHQp9xqIOvECJlbTxEgJ7XvtAk2iuA/lijJRdujBpBIczd1G7Bp2L0MP+IB6nSg+bC70GdzW9F8a0ghG6iWUrZHFki3kMKCqNxD9Xm3deW/zXe/a+Wpth1vGDxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710991388; c=relaxed/simple;
	bh=ZMWlRcuAb2eO+8ORkLGAORRt/P4RK7aKgzPMgTJVL5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hDOYpIsclz0+YTvc1qdU0PhGBJ5J3x/mbgt7EDxdgG+X5FMbdUG3/tH9P76k63kTRPrfRagjw+IdYSI5We6IWIhiymAxoaQNbtqS0AZ0n/EBhDSmDtYGAXepzjhKZ/gcsKOsixsEodoYS9oHzLZSoQCxIV0wKz77cwQBg3ri28Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a1d4b8dd8c3041ecb7c1e1fda858d425-20240321
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:f027e407-92e3-4cdb-ae1a-c95a27265afd,IP:15,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:30
X-CID-INFO: VERSION:1.1.37,REQID:f027e407-92e3-4cdb-ae1a-c95a27265afd,IP:15,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:30
X-CID-META: VersionHash:6f543d0,CLOUDID:9df73f85-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:2403211122590VMIGIM0,BulkQuantity:0,Recheck:0,SF:66|38|24|19|74|100|
	17|42|101|102,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,
	QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: a1d4b8dd8c3041ecb7c1e1fda858d425-20240321
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
	(envelope-from <gehao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 581281279; Thu, 21 Mar 2024 11:22:57 +0800
From: Hao Ge <gehao@kylinos.cn>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: gehao@kylinos.cn,
	gehao618@163.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH V2] mm/page-flags: make __PageMovable return bool
Date: Thu, 21 Mar 2024 11:22:56 +0800
Message-Id: <20240321032256.82063-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240307132859.171048-1-gehao@kylinos.cn>
References: <20240307132859.171048-1-gehao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

make __PageMovable return bool like __folio_test_movable

Signed-off-by: Hao Ge <gehao@kylinos.cn>

---
v2: Send this patch on the latest version
---
 include/linux/page-flags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 5ee2d0ab62c6..2647c7a35c5a 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -689,7 +689,7 @@ static __always_inline bool __folio_test_movable(const struct folio *folio)
 			PAGE_MAPPING_MOVABLE;
 }
 
-static __always_inline int __PageMovable(const struct page *page)
+static __always_inline bool __PageMovable(const struct page *page)
 {
 	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) ==
 				PAGE_MAPPING_MOVABLE;
-- 
2.25.1


