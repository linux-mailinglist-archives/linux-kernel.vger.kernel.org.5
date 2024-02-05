Return-Path: <linux-kernel+bounces-52022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3148492EB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32F71F21921
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 04:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26714AD32;
	Mon,  5 Feb 2024 04:26:37 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4BC947A
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 04:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707107196; cv=none; b=cllCWtb1XoASTw6AQFY+7Bb19SQ8BN8YP1xxShizkF06PnTrgqArhHeBLzZMNVY63yGBYJSu1sLLqt8faB+X5osNcly0cm/bsHKWEUHriTsFo3Riux2xD2FePIxTtN1hIAqY7Jla9qbc1U5I/QNQrCTLkoPk/KKAFhczKQlAlqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707107196; c=relaxed/simple;
	bh=VMHUHePjHMCZ5VFH/XZVgzw10KteEKVkHkUZHcLdttc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GguJv3/keq/uZ+ajF34ywI7XQx5DOZuGaBvhSbT9G3eVQw367ja7gemSyXqrzEIRjCsHSmtU6ZDMBPlUYTZyehwg3HMaKrkiLqDYA9OQmu0N0Zoz0QUfBW+hcmXBWqazC1VsKALOR6qpaPBAeHR08OkkEXHpQ52BhwXYuBsY1qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 82df3b9b26264eaa85c4e4ca7d33d3a0-20240205
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:10650bcc-489e-40c1-96ea-1d1d1f4a52e8,IP:15,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:10650bcc-489e-40c1-96ea-1d1d1f4a52e8,IP:15,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:50f283fe-c16b-4159-a099-3b9d0558e447,B
	ulkID:240205102834I1NPY1F5,BulkQuantity:5,Recheck:0,SF:24|17|19|44|66|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:41,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 82df3b9b26264eaa85c4e4ca7d33d3a0-20240205
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
	(envelope-from <gehao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2087221324; Mon, 05 Feb 2024 12:26:22 +0800
From: Hao Ge <gehao@kylinos.cn>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gehao618@163.com,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] mm/vmscan: Make too_many_isolated return bool
Date: Mon,  5 Feb 2024 12:26:18 +0800
Message-Id: <20240205042618.108140-1-gehao@kylinos.cn>
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


