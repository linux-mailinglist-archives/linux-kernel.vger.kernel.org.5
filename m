Return-Path: <linux-kernel+bounces-113555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8E6888543
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA361F21A68
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48151C4B0E;
	Sun, 24 Mar 2024 22:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2DFMlnC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2841C4AF3;
	Sun, 24 Mar 2024 22:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320358; cv=none; b=f2fv7oiKCAKg5VQkRX02cOE7S8DAunvf9UzWXWZ0SlMc3SiW0/9qWvPtaizIY6NKI6J4AyQSmwiME0fzYVJzjJFRhIF0N96V2YndtasmxyURj0xs3KPmmsEsyB17YGMHmEMo0IYCStJs8vPqnyiJKI6qHu/pTCn+zyqP9vSiOq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320358; c=relaxed/simple;
	bh=pw65f5Q9+o8i87PqoOxrSEIV2LHqb+mEj085S/f9BX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZvXt55zrMcwgEOh1iESHHgn8ampUvPO9AUkNTAVSGkRoeIxTn1QZSO3ZkJFiW5Uqges0C6fS0Q+V2JdBqM7fr19j3FPRGfkK0iETmdfFWNmOSj6tOV3E4RAHmCLsumrwV+oApGM6Vcxudo5kXiHr0ZZXRUyc3SotdHYZ9zb+J8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2DFMlnC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0530FC433C7;
	Sun, 24 Mar 2024 22:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320357;
	bh=pw65f5Q9+o8i87PqoOxrSEIV2LHqb+mEj085S/f9BX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L2DFMlnCozf33WxgELAlE+QpiZtDsxzDqFbsR7jBTLzEulv2y8KbFX9eN22h6euAi
	 kX1CZtHuBp/d76v7Y0b6Oo8gAygYDVRg6j1toTU9+eVS/RS1HVNlOBBWAwdk3aAgvk
	 mIs+bj22PhDLVUc8PaKPBLGN+gGeKm0oux9o1W4t18xs7yMJ9dtMze1IFShS4wYas9
	 IWBzhwlR/LNksUm44fAx5CUSobOcGyNwpzfghGQ7ElUnI1ghqvfzMn1hVT9p67vIRO
	 ycu2KavvdheMVj3TxRwmOhNaFapjUgrSnJsLv9ot9DvTOFrWygwCiAj9D1+gG9vWGk
	 VRePb9G4CPfFA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Golle <daniel@makrotopia.org>,
	Bc-bocun Chen <bc-bocun.chen@mediatek.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 664/715] net: ethernet: mtk_eth_soc: fix PPE hanging issue
Date: Sun, 24 Mar 2024 18:34:03 -0400
Message-ID: <20240324223455.1342824-665-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Daniel Golle <daniel@makrotopia.org>

[ Upstream commit ea80e3ed09ab2c2b75724faf5484721753e92c31 ]

A patch to resolve an issue was found in MediaTek's GPL-licensed SDK:
In the mtk_ppe_stop() function, the PPE scan mode is not disabled before
disabling the PPE. This can potentially lead to a hang during the process
of disabling the PPE.

Without this patch, the PPE may experience a hang during the reboot test.

Link: https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/b40da332dfe763932a82f9f62a4709457a15dd6c
Fixes: ba37b7caf1ed ("net: ethernet: mtk_eth_soc: add support for initializing the PPE")
Suggested-by: Bc-bocun Chen <bc-bocun.chen@mediatek.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.43.0


