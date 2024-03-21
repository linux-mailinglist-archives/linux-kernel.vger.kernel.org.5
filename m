Return-Path: <linux-kernel+bounces-109616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEA7881B6A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68331C214DE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6ED79C2;
	Thu, 21 Mar 2024 03:12:27 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26A44C99
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 03:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710990747; cv=none; b=ejVFYmD62JvzViEYKOqqITQTzd8S21CfBhF9Zbfdl1MovAGIn7COZwZ3wVKjinFwWT5/4yZ9ANMMHubqDeN/2zy+UF6a/Ta7A1zUSC2LjalHniD+zkapu7fGM7/FdPDDSZdHUKJKZI9dblAdkSxXxOgYBllBDYaI3dxSUTfq7h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710990747; c=relaxed/simple;
	bh=yMT/79lg6G+71wcFLn+iQt1l1wb0t5wf1tbMlAzqFZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XJkMV1lGfWCPHdGvRejC3CxYTgZJ5qVusgK9ljPnWtXGLOHEZU3htRohxt9Rj97kVCCAZt55Xx0SJEvY0zuchZnf/jfluinnNWUXZ6lP5JcCLX6PtgWGO1CBYeLhh9tSiAGlqcEaTvVIyxUso2y82eyC8P2NojtmAfWsKQa1w64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6735a93c7a3b430e91ec6b75937a2094-20240321
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:41596560-c536-4576-ad85-a3b42e612145,IP:15,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:20
X-CID-INFO: VERSION:1.1.37,REQID:41596560-c536-4576-ad85-a3b42e612145,IP:15,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:20
X-CID-META: VersionHash:6f543d0,CLOUDID:5857bf81-4f93-4875-95e7-8c66ea833d57,B
	ulkID:2403211107176CND0Q3R,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,
	TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 6735a93c7a3b430e91ec6b75937a2094-20240321
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
	(envelope-from <gehao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1092030556; Thu, 21 Mar 2024 11:07:14 +0800
From: Hao Ge <gehao@kylinos.cn>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	gehao618@163.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH v2] mm/page-flags: make PageMappingFlags return bool
Date: Thu, 21 Mar 2024 11:07:12 +0800
Message-Id: <20240321030712.80618-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240307131304.169859-1-gehao@kylinos.cn>
References: <20240307131304.169859-1-gehao@kylinos.cn>
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
v2: Send this patch on the latest version
---
 include/linux/page-flags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 652d77805e99..5ee2d0ab62c6 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -668,7 +668,7 @@ static __always_inline bool folio_mapping_flags(const struct folio *folio)
 	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) != 0;
 }
 
-static __always_inline int PageMappingFlags(const struct page *page)
+static __always_inline bool PageMappingFlags(const struct page *page)
 {
 	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) != 0;
 }
-- 
2.25.1


