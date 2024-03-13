Return-Path: <linux-kernel+bounces-102618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2F987B49E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFF2E1F23AC7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC8C5CDF2;
	Wed, 13 Mar 2024 22:50:57 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0075A10A;
	Wed, 13 Mar 2024 22:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710370257; cv=none; b=UKV/zAVMFDV/GZsOcjG8ftNenJM4xBZJ9jtWvYPuUTKJiJp9dIqXSinXogjdFmUnWtl+nZ5iYi2aD3Cs/5x0ZEE3uTHMa3B3SeEtv3TFsz5/xMp8PBg8hTRimSd2HRHWLJUw2gy3xrAvrtSo/npaTYzMDPb6ovfiGAkZ1awcZlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710370257; c=relaxed/simple;
	bh=LzUMRu+d7NikfjMCKwk8dTKXUjge8nRIf7hSNqMRLIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nP8d2GEwL23lW9TCCtdsfDgTGlnzVRjo/9n/kIN3R3zn6wkwzR83grxPWuZNxUwO76L9j5gZz9JJtleIqXbrvZDXAu604vSkCTf+IYWceGpxpRd1lHFZR3gbEz0OtjL93uFaMviPYiAalCmjoKU4/2NhvHYiRdzdqZPhnf4cYeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rkXQp-0003yg-2i;
	Wed, 13 Mar 2024 22:50:43 +0000
Date: Wed, 13 Mar 2024 22:50:40 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?iso-8859-1?Q?Ren=E9?= van Dorst <opensource@vdorst.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Chad Monroe <chad.monroe@adtran.com>,
	Steven Liu <steven.liu@mediatek.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net 2/2] net: ethernet: mtk_eth_soc: fix PPE hanging issue
Message-ID: <82fd25be48f869969b22ef439b8ea403f7e188a0.1710367570.git.daniel@makrotopia.org>
References: <7205ca7d3c5433214256df4672f7c1a49815a5a5.1710367570.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7205ca7d3c5433214256df4672f7c1a49815a5a5.1710367570.git.daniel@makrotopia.org>

A patch to resolve an issue was found in MediaTek's GPL-licensed SDK:
In the mtk_ppe_stop() function, the PPE scan mode is not disabled before
disabling the PPE. This can potentially lead to a hang during the process
of disabling the PPE.

Without this patch, the PPE may experience a hang during the reboot test.

Link: https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/b40da332dfe763932a82f9f62a4709457a15dd6c
Fixes: ba37b7caf1ed ("net: ethernet: mtk_eth_soc: add support for initializing the PPE")
Suggested-by: Bc-bocun Chen <bc-bocun.chen@mediatek.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/ethernet/mediatek/mtk_ppe.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.c b/drivers/net/ethernet/mediatek/mtk_ppe.c
index b2a5d9c3733d4..6ce0db3a1a920 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
@@ -994,7 +994,7 @@ void mtk_ppe_start(struct mtk_ppe *ppe)
 			 MTK_PPE_KEEPALIVE_DISABLE) |
 	      FIELD_PREP(MTK_PPE_TB_CFG_HASH_MODE, 1) |
 	      FIELD_PREP(MTK_PPE_TB_CFG_SCAN_MODE,
-			 MTK_PPE_SCAN_MODE_KEEPALIVE_AGE) |
+			 MTK_PPE_SCAN_MODE_CHECK_AGE) |
 	      FIELD_PREP(MTK_PPE_TB_CFG_ENTRY_NUM,
 			 MTK_PPE_ENTRIES_SHIFT);
 	if (mtk_is_netsys_v2_or_greater(ppe->eth))
@@ -1090,17 +1090,21 @@ int mtk_ppe_stop(struct mtk_ppe *ppe)
 
 	mtk_ppe_cache_enable(ppe, false);
 
-	/* disable offload engine */
-	ppe_clear(ppe, MTK_PPE_GLO_CFG, MTK_PPE_GLO_CFG_EN);
-	ppe_w32(ppe, MTK_PPE_FLOW_CFG, 0);
-
 	/* disable aging */
 	val = MTK_PPE_TB_CFG_AGE_NON_L4 |
 	      MTK_PPE_TB_CFG_AGE_UNBIND |
 	      MTK_PPE_TB_CFG_AGE_TCP |
 	      MTK_PPE_TB_CFG_AGE_UDP |
-	      MTK_PPE_TB_CFG_AGE_TCP_FIN;
+	      MTK_PPE_TB_CFG_AGE_TCP_FIN |
+		  MTK_PPE_TB_CFG_SCAN_MODE;
 	ppe_clear(ppe, MTK_PPE_TB_CFG, val);
 
-	return mtk_ppe_wait_busy(ppe);
+	if (mtk_ppe_wait_busy(ppe))
+		return -ETIMEDOUT;
+
+	/* disable offload engine */
+	ppe_clear(ppe, MTK_PPE_GLO_CFG, MTK_PPE_GLO_CFG_EN);
+	ppe_w32(ppe, MTK_PPE_FLOW_CFG, 0);
+
+	return 0;
 }
-- 
2.44.0

