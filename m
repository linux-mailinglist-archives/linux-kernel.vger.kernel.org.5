Return-Path: <linux-kernel+bounces-33226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECB98366C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7771F23EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC342495ED;
	Mon, 22 Jan 2024 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbbdnqzE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC049495C0;
	Mon, 22 Jan 2024 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935401; cv=none; b=FrM9VeiCbE6xREVHEAPHfWovWdGghE05a1tpoBbrfcVdXJI2C3zlZfhVgSG3huqh8DFFw4RbHFUZZTtGRNmkVl1pfEKA+FLzgEycIbi15iPcFPMZNWlNyrExPjBdSaWUJzlplsBWQGLNntfMH1JdM9RQTxll+T19/k3eAnoulbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935401; c=relaxed/simple;
	bh=EY1vpXyuLVkX18hTPamwG6S/XNU+3eW/WpH8ZQSqsO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkplimzUYKaj33miEEYbqiCznIfWKnZxHo8MBfRsedXhAntjYPWcsMbdthlvzeHb4g/smTxXeRptVReLmf3mdiTLzGHGpYd2sZ2HPt+c+CGVxTWhYXlkPGF/lXSVSRnvlGT1dehJ0sonH4r47W1yZNHn/avEaFtjAohj/vGt1cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbbdnqzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F85FC116AB;
	Mon, 22 Jan 2024 14:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935400;
	bh=EY1vpXyuLVkX18hTPamwG6S/XNU+3eW/WpH8ZQSqsO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GbbdnqzEG3+0GtWbAUQ8kqolwRFRNRVrM/RtEnf+1quajc17xZgF7a68ZtL16YlUY
	 YzndVjhPo8lX4rAulOM4EWdPSTaXQRl9rXDgiay1EgyYuiE1rrQtH9Jx6vnvn9TQVQ
	 eYnOC3e+GRXlKsXBqGdDniA0R5T7ix7kkhqG65iW0sS1dWyqGXJdJpM5Jrtk3Hqa86
	 7dB0cVij8WG1+0wsMW1t8ObzHNk51SD0gm0dXOTavgYq9iny61gh2QZ9Ioztk7wkJ3
	 JiEIjif2KXjcjee9+16no5cV1UpCZS6dWKmKduypV40qlkPippwGF/v68n1VPxBi86
	 nA8gHnL8nEREg==
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
	dianders@chromium.org,
	nfraprado@collabora.com,
	mairacanal@riseup.net,
	treapking@chromium.org,
	andriy.shevchenko@linux.intel.com,
	angelogioacchino.delregno@collabora.com,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 12/88] drm/bridge: anx7625: Fix Set HPD irq detect window to 2ms
Date: Mon, 22 Jan 2024 09:50:45 -0500
Message-ID: <20240122145608.990137-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
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
index 8f740154707d..7afb7edc8ae3 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1298,10 +1298,32 @@ static void anx7625_config(struct anx7625_data *ctx)
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
 	struct device *dev = ctx->dev;
-	int ret;
+	int ret, val;
 
 	/* Reset main ocm */
 	ret = anx7625_reg_write(ctx, ctx->i2c.rx_p0_client, 0x88, 0x40);
@@ -1315,6 +1337,19 @@ static void anx7625_disable_pd_protocol(struct anx7625_data *ctx)
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
@@ -1437,20 +1472,6 @@ static void anx7625_start_dp_work(struct anx7625_data *ctx)
 
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
index 5af819611ebc..66ebee7f3d83 100644
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


