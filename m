Return-Path: <linux-kernel+bounces-54859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A7384B48D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88EEA283A78
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA12A12F399;
	Tue,  6 Feb 2024 12:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="uTXrWNub"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4C112EBEB
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 12:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221277; cv=none; b=NXkbQ3s/d/dtJIzTYUaVByVvsJkCFUxQ6RShWtbZSW9pMf+qjK32BfYXVtNcB3YPJRJxpVCyG8dv/UaGyw8Wpg8mUeYVOpamOpSrVGDO773L8JSNbaqfcsPLAMgl6H48VGvJaaL+kKCFwCL7QAWkI6g+Kz7/NuDuV096gvpbhH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221277; c=relaxed/simple;
	bh=T7wyLM2XaOr0LZopSINK1iR5VVf323V2jZ2xWU3QUPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CG9lK1s8lU/3xIc4stxCSHQPo/Ys+A5Rgm9pLpdjQelcWSTREalwvy96CtFz1fFnxjlfl0mXfiAJQbcGpMgtBg2vNuO8RkQ0qysPE4LPYAVm/neNkdEEKbh3gqWu1SsMY7PPMmQRdXazyg8LsoodJaP/ucJQ3RDde8QnFZhhQxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=uTXrWNub; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707221273;
	bh=T7wyLM2XaOr0LZopSINK1iR5VVf323V2jZ2xWU3QUPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uTXrWNubyLzCiIBjGuyeLuaLctOfWgzRYqR/gLqFmdyFPgJ8ldFddvCijIJamxOj1
	 wUq/gY1IEpZd1luuilgZ0H9HTjG5U+B6NmO5iKp9jyw2QskNV0KyZZidUklVG8mNvm
	 QTyJwIvJumibZNQlsUbdWCVfnn7+wwZg7F7zU59hlTYycy1q62/X7Km6gySBvgn/uZ
	 sLoUjvYLpYu2eKm16CJhbp3C1ZQSpywxap+kn58vVXXKP9Kt3WEbQ1taWXdMq38G9k
	 039OFf4YkxBqshTegzFxcNZyrM35vK64L2eaG6H6hnJG+VkWbO6e3jlBwPYitzYsam
	 hTsYEOYCIMcYg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CE8583782072;
	Tue,  6 Feb 2024 12:07:52 +0000 (UTC)
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
	kernel@collabora.com
Subject: [PATCH v4 1/9] drm/mediatek: dsi: Use GENMASK() for register mask definitions
Date: Tue,  6 Feb 2024 13:07:40 +0100
Message-ID: <20240206120748.136610-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206120748.136610-1-angelogioacchino.delregno@collabora.com>
References: <20240206120748.136610-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change magic numerical masks with usage of the GENMASK() macro
to improve readability.

While at it, also fix the DSI_PS_SEL mask to include all bits instead
of just a subset of them.

This commit brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 45 +++++++++++++++---------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index a2fdfc8ddb15..3b7392c03b4d 100644
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
+#define DSI_PS_WC			GENMASK(14, 0)
+#define DSI_PS_SEL			GENMASK(19, 16)
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


