Return-Path: <linux-kernel+bounces-33409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CDD836958
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393A91C23B09
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9D44D117;
	Mon, 22 Jan 2024 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxJ2MWY2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1494D111;
	Mon, 22 Jan 2024 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936213; cv=none; b=Su9wmRW2j/ErKw3KWeeZQJUz9qioT7z7QDjcSBOGgU24BdNmJcDvHEKhpbyoiVBHBltYHnY6nYrljryl9Jpg7UJsPqZgZZj7gaAyB6F+xfpQHEP9WGQCX5quszy5dMMzGN5uxcTwWoIvkp4Qz5An11nwa6AvmNHL0QhCWyRnCjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936213; c=relaxed/simple;
	bh=EsD0a3DN3X9sxYSJHnpU2Ppg4A5jlQZ0frMjZg5jmhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WODcX/5JJNuAgRJdjvJe0OL/8iXrDpMCeq9z9MyTnO8RouwWRlFe70p1dx/lFHBwcopbq2ZsJv+EYFZ/Vg+3Vp8IAH8JoljMx8f+C/3Ej+dHcEymQcGeNq6VfXp/CJEd8IutzfSMmoLEmd2gOQnP1fh8u0TCPDFDmxzhFQd8WZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxJ2MWY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE13C43390;
	Mon, 22 Jan 2024 15:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936213;
	bh=EsD0a3DN3X9sxYSJHnpU2Ppg4A5jlQZ0frMjZg5jmhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kxJ2MWY2chIK6WpLmxz/agTABj93lFEfMBNxjpWx/iBIpwlf8zeQ42Exoh042VJ2X
	 Df58riqVyNsycafWP08NWvwmQfiIWucP+YKKP5nkVukKPtFYLX0Y3GMQhCkNCzI1Fy
	 vTu+CiVLpyWdFf4aw6wjsot96NC86sbyutwIcDxBqULEj03tI1coUCI9QADDhExaNh
	 v1hMNA/qCrZprVChmOv+b80iAId6SSwoMu2WztA/9sD/ayMv8H+cMHGwerjkKI5TnY
	 P8AgM/diEb06/avNKi/N0/U8AZEb0NrOl9/arLTNHBeHyscXt2a7Dh8h/ahrubM8Gd
	 QKOMwLFMI9O7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xin Ji <xji@analogixsemi.com>,
	Robert Foss <rfoss@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	wenst@chromium.org,
	nfraprado@collabora.com,
	dianders@chromium.org,
	treapking@chromium.org,
	u.kleine-koenig@pengutronix.de,
	andriy.shevchenko@linux.intel.com,
	angelogioacchino.delregno@collabora.com,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 09/53] drm/bridge: anx7625: Fix Set HPD irq detect window to 2ms
Date: Mon, 22 Jan 2024 10:08:10 -0500
Message-ID: <20240122150949.994249-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
Content-Transfer-Encoding: 8bit

From: Xin Ji <xji@analogixsemi.com>

[ Upstream commit e3af7053de3f685c96158373bc234b2feca1f160 ]

Polling firmware HPD GPIO status, set HPD irq detect window to 2ms
after firmware HPD GPIO initial done

Signed-off-by: Xin Ji <xji@analogixsemi.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20231120091038.284825-2-xji@analogixsemi.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 51 ++++++++++++++++-------
 drivers/gpu/drm/bridge/analogix/anx7625.h |  4 ++
 2 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index cf86cc05b7fc..6b79ad38f3ab 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1300,10 +1300,32 @@ static void anx7625_config(struct anx7625_data *ctx)
 			  XTAL_FRQ_SEL, XTAL_FRQ_27M);
 }
 
+static int anx7625_hpd_timer_config(struct anx7625_data *ctx)
+{
+	int ret;
+
+	/* Set irq detect window to 2ms */
+	ret = anx7625_reg_write(ctx, ctx->i2c.tx_p2_client,
+				HPD_DET_TIMER_BIT0_7, HPD_TIME & 0xFF);
+	ret |= anx7625_reg_write(ctx, ctx->i2c.tx_p2_client,
+				 HPD_DET_TIMER_BIT8_15,
+				 (HPD_TIME >> 8) & 0xFF);
+	ret |= anx7625_reg_write(ctx, ctx->i2c.tx_p2_client,
+				 HPD_DET_TIMER_BIT16_23,
+				 (HPD_TIME >> 16) & 0xFF);
+
+	return ret;
+}
+
+static int anx7625_read_hpd_gpio_config_status(struct anx7625_data *ctx)
+{
+	return anx7625_reg_read(ctx, ctx->i2c.rx_p0_client, GPIO_CTRL_2);
+}
+
 static void anx7625_disable_pd_protocol(struct anx7625_data *ctx)
 {
 	struct device *dev = &ctx->client->dev;
-	int ret;
+	int ret, val;
 
 	/* Reset main ocm */
 	ret = anx7625_reg_write(ctx, ctx->i2c.rx_p0_client, 0x88, 0x40);
@@ -1317,6 +1339,19 @@ static void anx7625_disable_pd_protocol(struct anx7625_data *ctx)
 		DRM_DEV_DEBUG_DRIVER(dev, "disable PD feature fail.\n");
 	else
 		DRM_DEV_DEBUG_DRIVER(dev, "disable PD feature succeeded.\n");
+
+	/*
+	 * Make sure the HPD GPIO already be configured after OCM release before
+	 * setting HPD detect window register. Here we poll the status register
+	 * at maximum 40ms, then config HPD irq detect window register
+	 */
+	readx_poll_timeout(anx7625_read_hpd_gpio_config_status,
+			   ctx, val,
+			   ((val & HPD_SOURCE) || (val < 0)),
+			   2000, 2000 * 20);
+
+	/* Set HPD irq detect window to 2ms */
+	anx7625_hpd_timer_config(ctx);
 }
 
 static int anx7625_ocm_loading_check(struct anx7625_data *ctx)
@@ -1440,20 +1475,6 @@ static void anx7625_start_dp_work(struct anx7625_data *ctx)
 
 static int anx7625_read_hpd_status_p0(struct anx7625_data *ctx)
 {
-	int ret;
-
-	/* Set irq detect window to 2ms */
-	ret = anx7625_reg_write(ctx, ctx->i2c.tx_p2_client,
-				HPD_DET_TIMER_BIT0_7, HPD_TIME & 0xFF);
-	ret |= anx7625_reg_write(ctx, ctx->i2c.tx_p2_client,
-				 HPD_DET_TIMER_BIT8_15,
-				 (HPD_TIME >> 8) & 0xFF);
-	ret |= anx7625_reg_write(ctx, ctx->i2c.tx_p2_client,
-				 HPD_DET_TIMER_BIT16_23,
-				 (HPD_TIME >> 16) & 0xFF);
-	if (ret < 0)
-		return ret;
-
 	return anx7625_reg_read(ctx, ctx->i2c.rx_p0_client, SYSTEM_STSTUS);
 }
 
diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/drm/bridge/analogix/anx7625.h
index 14f33d6be289..498d06cad250 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.h
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
@@ -259,6 +259,10 @@
 #define AP_MIPI_RX_EN BIT(5) /* 1: MIPI RX input in  0: no RX in */
 #define AP_DISABLE_PD BIT(6)
 #define AP_DISABLE_DISPLAY BIT(7)
+
+#define GPIO_CTRL_2   0x49
+#define HPD_SOURCE    BIT(6)
+
 /***************************************************************/
 /* Register definition of device address 0x84 */
 #define  MIPI_PHY_CONTROL_3            0x03
-- 
2.43.0


