Return-Path: <linux-kernel+bounces-66445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EDE855D25
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1466EB270E5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B6617551;
	Thu, 15 Feb 2024 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JcN5CCA5"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEBF14013
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987204; cv=none; b=udTS5n050ke5TyupvvZfuCwA2kh9988o2LSBgjjNdrlVqNRkNaIfCvMReaBAnSu5hf+njE0Cnr7ef02+HJZgnnnn87TInJN+638krUmMpSiI4Y1spa/7kP5yrGR/XSHGD4iL1oYkE/38oW0cG4gsSkxCs4rAcTeyUSGAGHlYLP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987204; c=relaxed/simple;
	bh=45Yk3VPr09uA53emzuvZAFq3Vek84k8DhS6fpL96DAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6+JO7EH5/YThaJFcn3/50xAmva3XMyFVa1oGCT8LQ2WAvZcFFvjZ6oTysLyLiB84TXmcJ3IdzNC8tiHLO9rLuBKhWkbmzxbxQdgaKUXYCf2nVFZM40PKb33UWwRSkcWBbORmnpuBCzbrEy0Tpi7VqqUV7aPFM/txh8aHv5830s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JcN5CCA5; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707987201;
	bh=45Yk3VPr09uA53emzuvZAFq3Vek84k8DhS6fpL96DAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JcN5CCA5pfgSEX9kZYnI0flFG/xh5oRoZe238O8rZXEW5oOupq86ob5vaB6a2yA7B
	 RFWxq5yq9oSFoAH87f3th0vq34pD96WxJYbR+y3Hb+G0JwIaGqzydodTjFvYbVCnEx
	 laj0OkGQ3Wt3iBxCusF8CdyZDTLLQx8U9W8YL+UCjwwQr7W/4BgmCXQsv/7Tt7UqDk
	 yAIIyYklwESTtqwA+LWzfGGiZVbRwsDet5/HWmlVlAod2mbkWrQxIJGBavzKd5U13d
	 ibxCmGHCQ/0EnShEUrAB/VpI7cC+/Gd7tVemAqlORloYZSJT0pDgI7HA8feRu3wCz0
	 5xjVqOPqNvP/g==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1756137820AD;
	Thu, 15 Feb 2024 08:53:20 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: fshao@chromium.org,
	p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	Alexandre Mergnat <amergnat@baylibre.com>,
	CK Hu <ck.hu@mediatek.com>
Subject: [PATCH v6 1/9] drm/mediatek: dsi: Use GENMASK() for register mask definitions
Date: Thu, 15 Feb 2024 09:53:08 +0100
Message-ID: <20240215085316.56835-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215085316.56835-1-angelogioacchino.delregno@collabora.com>
References: <20240215085316.56835-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change magic numerical masks with usage of the GENMASK() macro
to improve readability.

This commit brings no functional changes.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 45 +++++++++++++++---------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index a2fdfc8ddb15..c66e18006070 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -58,18 +58,18 @@
 
 #define DSI_TXRX_CTRL		0x18
 #define VC_NUM				BIT(1)
-#define LANE_NUM			(0xf << 2)
+#define LANE_NUM			GENMASK(5, 2)
 #define DIS_EOT				BIT(6)
 #define NULL_EN				BIT(7)
 #define TE_FREERUN			BIT(8)
 #define EXT_TE_EN			BIT(9)
 #define EXT_TE_EDGE			BIT(10)
-#define MAX_RTN_SIZE			(0xf << 12)
+#define MAX_RTN_SIZE			GENMASK(15, 12)
 #define HSTX_CKLP_EN			BIT(16)
 
 #define DSI_PSCTRL		0x1c
-#define DSI_PS_WC			0x3fff
-#define DSI_PS_SEL			(3 << 16)
+#define DSI_PS_WC			GENMASK(13, 0)
+#define DSI_PS_SEL			GENMASK(17, 16)
 #define PACKED_PS_16BIT_RGB565		(0 << 16)
 #define LOOSELY_PS_18BIT_RGB666		(1 << 16)
 #define PACKED_PS_18BIT_RGB666		(2 << 16)
@@ -109,26 +109,26 @@
 #define LD0_WAKEUP_EN			BIT(2)
 
 #define DSI_PHY_TIMECON0	0x110
-#define LPX				(0xff << 0)
-#define HS_PREP				(0xff << 8)
-#define HS_ZERO				(0xff << 16)
-#define HS_TRAIL			(0xff << 24)
+#define LPX				GENMASK(7, 0)
+#define HS_PREP				GENMASK(15, 8)
+#define HS_ZERO				GENMASK(23, 16)
+#define HS_TRAIL			GENMASK(31, 24)
 
 #define DSI_PHY_TIMECON1	0x114
-#define TA_GO				(0xff << 0)
-#define TA_SURE				(0xff << 8)
-#define TA_GET				(0xff << 16)
-#define DA_HS_EXIT			(0xff << 24)
+#define TA_GO				GENMASK(7, 0)
+#define TA_SURE				GENMASK(15, 8)
+#define TA_GET				GENMASK(23, 16)
+#define DA_HS_EXIT			GENMASK(31, 24)
 
 #define DSI_PHY_TIMECON2	0x118
-#define CONT_DET			(0xff << 0)
-#define CLK_ZERO			(0xff << 16)
-#define CLK_TRAIL			(0xff << 24)
+#define CONT_DET			GENMASK(7, 0)
+#define CLK_ZERO			GENMASK(23, 16)
+#define CLK_TRAIL			GENMASK(31, 24)
 
 #define DSI_PHY_TIMECON3	0x11c
-#define CLK_HS_PREP			(0xff << 0)
-#define CLK_HS_POST			(0xff << 8)
-#define CLK_HS_EXIT			(0xff << 16)
+#define CLK_HS_PREP			GENMASK(7, 0)
+#define CLK_HS_POST			GENMASK(15, 8)
+#define CLK_HS_EXIT			GENMASK(23, 16)
 
 #define DSI_VM_CMD_CON		0x130
 #define VM_CMD_EN			BIT(0)
@@ -138,13 +138,14 @@
 #define FORCE_COMMIT			BIT(0)
 #define BYPASS_SHADOW			BIT(1)
 
-#define CONFIG				(0xff << 0)
+/* CMDQ related bits */
+#define CONFIG				GENMASK(7, 0)
 #define SHORT_PACKET			0
 #define LONG_PACKET			2
 #define BTA				BIT(2)
-#define DATA_ID				(0xff << 8)
-#define DATA_0				(0xff << 16)
-#define DATA_1				(0xff << 24)
+#define DATA_ID				GENMASK(15, 8)
+#define DATA_0				GENMASK(23, 16)
+#define DATA_1				GENMASK(31, 24)
 
 #define NS_TO_CYCLE(n, c)    ((n) / (c) + (((n) % (c)) ? 1 : 0))
 
-- 
2.43.0


