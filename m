Return-Path: <linux-kernel+bounces-114447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EF4888A85
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117BD281BEA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B8A179664;
	Sun, 24 Mar 2024 23:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OV1HsOmZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3243F21EB7B;
	Sun, 24 Mar 2024 23:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321868; cv=none; b=HGO97NpJLJVP2/iQZV+rorApFd1T/OSG8amW40ZmchQl1uWmh/71R2k4r26LhOBlMQNsCm5YCBAWuH7P2VDbsgjlluAYUKvS0n9OEpgJGR0dtRO5kVvcOv4EeRu1YxtcR0K4Hwq2YfL5F1vMQXkMRXwcwiweAuefDv4aGhWFsng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321868; c=relaxed/simple;
	bh=qNB+mBV+fzYv8G7bHrupcUyK6w/KGMS6fq4L8iktE0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElWgvkK51VoUD0aLvljbU6p4vuTBlOSsZSd7ezhIp6Z5Jg1UVm8VzgKysVVph7d4GhnBTvGW5uy422OlRnntjTeFCoeNzdPxMh0fk+HlY0TM3Vqc6ARdB1WAdCXCnOkCyMjT8Q5LG3o1wwHmSpTgvTuSMOnX/GkT7FKkTHHTtYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OV1HsOmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EE6C433C7;
	Sun, 24 Mar 2024 23:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321867;
	bh=qNB+mBV+fzYv8G7bHrupcUyK6w/KGMS6fq4L8iktE0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OV1HsOmZV5tmQLK9S8TrnBIYRuegLilIlgqKyS4ytZXdwSRVcte6JYww+lL4U78n3
	 1epETpwrh0RTrevSN0+c/oxDZwC91M+f7t0H2QCyFuG264jT4vNacR1nGQl+Ek2vMd
	 is4niT6MzWNgGO4bugAAAyxaOcE0ZclTqYnyn/vpODjE3Rpnl8RVnPnC4ycv8PozMq
	 LtCWoWCXAQoNg4BiB3gvaN2pJXEAAAlRYg00XMZg4mFhXdgeuz4dgXdGRw0o5Px0B/
	 093o1QezACb42udvXFrNMT0jlyGzWk7G3zTnjyLDHHfmkyyZCpY5FzVPQgeql+dtCF
	 rOjPZIdwwvwew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Golle <daniel@makrotopia.org>,
	Bc-bocun Chen <bc-bocun.chen@mediatek.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 595/638] net: ethernet: mtk_eth_soc: fix PPE hanging issue
Date: Sun, 24 Mar 2024 19:00:32 -0400
Message-ID: <20240324230116.1348576-596-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 86f32f4860437..6e222a000bf7e 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
@@ -992,7 +992,7 @@ void mtk_ppe_start(struct mtk_ppe *ppe)
 			 MTK_PPE_KEEPALIVE_DISABLE) |
 	      FIELD_PREP(MTK_PPE_TB_CFG_HASH_MODE, 1) |
 	      FIELD_PREP(MTK_PPE_TB_CFG_SCAN_MODE,
-			 MTK_PPE_SCAN_MODE_KEEPALIVE_AGE) |
+			 MTK_PPE_SCAN_MODE_CHECK_AGE) |
 	      FIELD_PREP(MTK_PPE_TB_CFG_ENTRY_NUM,
 			 MTK_PPE_ENTRIES_SHIFT);
 	if (mtk_is_netsys_v2_or_greater(ppe->eth))
@@ -1088,17 +1088,21 @@ int mtk_ppe_stop(struct mtk_ppe *ppe)
 
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


