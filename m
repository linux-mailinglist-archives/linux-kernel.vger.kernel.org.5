Return-Path: <linux-kernel+bounces-95597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F66C874FF6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30FB1F22317
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D9412C7F2;
	Thu,  7 Mar 2024 13:29:23 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8F312C553
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818162; cv=none; b=YYmhjijROslfR7ntoZlBYJn7kb0NguVEfLzYFTChqnCd2EoReBjzPlW+3OD4YVAYWjivitIxPuQamhkMTZtAEzCLCXOi06pc5aPFfdt2nWvUe7vcL3e5D/zhmcR2VFM6kR01KXUcMNMf0fsnpjS1TO3Y5U5vV69a5qxZwkDN72o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818162; c=relaxed/simple;
	bh=peklLxCuiXHdnynVZdvgYClUpnAJia2OtvjGb1xzcio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ofk9dyu+3xSpMa/tUdhIZBlLgUIvUV5DF5nffzWX96tR8Cv4EXvu3aczi8x+PNo/OJifz2+zrmy5OVwxUriR8v1ky7YFpqcpGcQGGdFImfCsHg5e+r9tZdOnDJ1uoyVWoXnuiVaN5UgunqBO4xrZ9UM/nsAqGECb1bx67xD0eac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 45660e5c08634823a9ab539550fd7332-20240307
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:2b022556-8bd6-41eb-be0b-0e707cd2676f,IP:25,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:10
X-CID-INFO: VERSION:1.1.37,REQID:2b022556-8bd6-41eb-be0b-0e707cd2676f,IP:25,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-META: VersionHash:6f543d0,CLOUDID:37d5bb84-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240307212910QOGRGHZV,BulkQuantity:0,Recheck:0,SF:17|19|44|66|24|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:ni
	l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 45660e5c08634823a9ab539550fd7332-20240307
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
	(envelope-from <gehao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2099076489; Thu, 07 Mar 2024 21:29:08 +0800
From: Hao Ge <gehao@kylinos.cn>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	gehao618@613.com,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] mm/page-flags: make __PageMovable return bool
Date: Thu,  7 Mar 2024 21:28:59 +0800
Message-Id: <20240307132859.171048-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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
 include/linux/page-flags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 735cddc13d20..3f2cf3d3b86b 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -663,7 +663,7 @@ static __always_inline bool __folio_test_movable(const struct folio *folio)
 			PAGE_MAPPING_MOVABLE;
 }
 
-static __always_inline int __PageMovable(struct page *page)
+static __always_inline bool __PageMovable(struct page *page)
 {
 	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) ==
 				PAGE_MAPPING_MOVABLE;
-- 
2.25.1


