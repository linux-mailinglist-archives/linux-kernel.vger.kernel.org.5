Return-Path: <linux-kernel+bounces-51991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216E3849261
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F8F1C20F0D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 02:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8CA8F49;
	Mon,  5 Feb 2024 02:28:51 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F3079D8
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 02:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707100130; cv=none; b=BtkNrS9gtPKAkL3H8h+brYUILZ6goC77nOpiAynJelhQAEXkGzNUzXoLcTSxC7G/fZegQVcN8HeJcD5bkhXYbPVdgA3fFuXuVicfm4xrOv2D+7rBo/OPIGsh4uUhIctqk6Zyq5IAKv+uSiXjDVLmm4vi9O5A2S2J0WaH70KU2vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707100130; c=relaxed/simple;
	bh=VMHUHePjHMCZ5VFH/XZVgzw10KteEKVkHkUZHcLdttc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WzOIGEXt3g3RXvdZJsGc8vT0BTsMBtfNGk314Fz6W3soRyj1TlBDDTghul5KovuOFT9BO9Z1fPcJBwsnZmdPpaHtqaH2SjeOTXoj+CReiu9n+a3gSde1QSUCJ6BrI/8WiODXJVHcE4XOZkH1fP5k4Tw4B/fKbRs4DrIBz74tts4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 464b9e8594404510a3b40c3db017f82c-20240205
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:000fba6a-fb3a-4043-81e2-865ae1246bb1,IP:25,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:5
X-CID-INFO: VERSION:1.1.35,REQID:000fba6a-fb3a-4043-81e2-865ae1246bb1,IP:25,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-META: VersionHash:5d391d7,CLOUDID:2f799d83-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240205102834I1NPY1F5,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 464b9e8594404510a3b40c3db017f82c-20240205
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
	(envelope-from <gehao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 763636656; Mon, 05 Feb 2024 10:28:32 +0800
From: Hao Ge <gehao@kylinos.cn>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gehao618@163.com,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] fs/inode: Make too_many_isolated return bool
Date: Mon,  5 Feb 2024 10:28:25 +0800
Message-Id: <20240205022825.99061-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

too_many_isolated should return bool which with the same name and
similar functions in mm/compaction.c already returned bool

Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 mm/vmscan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4f9c854ce6cc..143e4b8e8821 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1744,17 +1744,17 @@ bool folio_isolate_lru(struct folio *folio)
  * the LRU list will go small and be scanned faster than necessary, leading to
  * unnecessary swapping, thrashing and OOM.
  */
-static int too_many_isolated(struct pglist_data *pgdat, int file,
+static bool too_many_isolated(struct pglist_data *pgdat, int file,
 		struct scan_control *sc)
 {
 	unsigned long inactive, isolated;
 	bool too_many;
 
 	if (current_is_kswapd())
-		return 0;
+		return false;
 
 	if (!writeback_throttling_sane(sc))
-		return 0;
+		return false;
 
 	if (file) {
 		inactive = node_page_state(pgdat, NR_INACTIVE_FILE);
-- 
2.25.1


