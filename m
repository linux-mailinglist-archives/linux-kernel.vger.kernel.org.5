Return-Path: <linux-kernel+bounces-114678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CE78890A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F25F1F29023
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BC02B55BB;
	Sun, 24 Mar 2024 23:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9GKCzbk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C250E150986;
	Sun, 24 Mar 2024 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322332; cv=none; b=QKbXoSHOUwVhim49SFfwoztoFE5nSTfkHbYFiDcl0CRZQbSKdZAUVgSEBWvr6waPq2/U+97ziJMR+i2wsnAh76/CvW6DUd+vc1n22sOZF59b4GoiTpp+oEqc2HxxgtR8mP/2Ernh1DUMO7a/tcWD/rn42moXuttXM10TgPKDaoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322332; c=relaxed/simple;
	bh=jw48APu9/AC1L2Kf9urEVuSt8JpHSmRbH3Pc1+RPOgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrNtFqWubv+kpnb45pADjSc+Ja4eiWfFPqwslrkLfFEnbbBE3r0OEuqCB8pK80eywQvz7NWIfsrwSErkHA2Uey66cCC5NItYzJlDFQoFZmuz9W0nkXEJlT20UTtRzFz3OHK0Fsmp6IjU4YmOWGLzNkY+tzgcu/ngfu03+PLWyyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9GKCzbk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6784C43390;
	Sun, 24 Mar 2024 23:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322331;
	bh=jw48APu9/AC1L2Kf9urEVuSt8JpHSmRbH3Pc1+RPOgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C9GKCzbkz0jH93JA10d6P+cWhesC/SPEvmN+B6T2FxcVU3gn2sA/8MDgSoa9QG9yi
	 H40eKKax3o/jf/EgKGnAR5E81sTqvaAF24PZyJonMrsXmq5UCwjaKNua/tZnwCQo3Q
	 q/cMH98DsjtgYfulSxjbmZ3gidQxX06g907Lj86tjC7xInCMEbu5+PpFKw3yX1aTa3
	 TB8lQA9xnZgn7C9BpZEQyiEUpHWnClJiFxiBY2CV8dTKMPuHXJThNLXoRx9+O+8umB
	 PZUI50WcqQvPq6WDqON7FmXiR4ews3M7Oh/AGKf0mbifEK2LwfDlT3k6HnjYwVlNPT
	 bWtlMohP0RwJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Golle <daniel@makrotopia.org>,
	Bc-bocun Chen <bc-bocun.chen@mediatek.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 414/451] net: ethernet: mtk_eth_soc: fix PPE hanging issue
Date: Sun, 24 Mar 2024 19:11:30 -0400
Message-ID: <20240324231207.1351418-415-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index d6eed204574a9..c64211e22ae70 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
@@ -811,7 +811,7 @@ void mtk_ppe_start(struct mtk_ppe *ppe)
 			 MTK_PPE_KEEPALIVE_DISABLE) |
 	      FIELD_PREP(MTK_PPE_TB_CFG_HASH_MODE, 1) |
 	      FIELD_PREP(MTK_PPE_TB_CFG_SCAN_MODE,
-			 MTK_PPE_SCAN_MODE_KEEPALIVE_AGE) |
+			 MTK_PPE_SCAN_MODE_CHECK_AGE) |
 	      FIELD_PREP(MTK_PPE_TB_CFG_ENTRY_NUM,
 			 MTK_PPE_ENTRIES_SHIFT);
 	if (MTK_HAS_CAPS(ppe->eth->soc->caps, MTK_NETSYS_V2))
@@ -895,17 +895,21 @@ int mtk_ppe_stop(struct mtk_ppe *ppe)
 
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


