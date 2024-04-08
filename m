Return-Path: <linux-kernel+bounces-134909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C35589B88E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41BE2B221E2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7691C2E400;
	Mon,  8 Apr 2024 07:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S82CzPIr"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61D52D638
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712561812; cv=none; b=uHkJVSQq/cIrAWL3KXHISUr7WJMDOFdrulj7MlhWvyBR33R4JTY69usntYqPiB1LfrKvQYOe7BOqNjDY/9SSLNk5ht+1T7fHpJLDSzA93Yt1L0nSZPWk3qPwqubXelWmqB+Yr5efIBXfANeHGuonMQj6F+bXaoeseHb2YFQJMt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712561812; c=relaxed/simple;
	bh=kuAOc7HqwllSLTyuUaK6+2j+svofrPf40qNVzjcbHyA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NNqOOR8MBdZltAsiMQWxFdCvgqJkCYdYRdOun1JfALSZ1c4eO0yiDH4zGU0OcmeDvhAMYO9GPmaAM4CPYfEAN4lKuz0JUqQ7NRVqIokWYL6AUn/6kGEyMepVYAzuuNluBZ102Evusdlf9ZV1ICqtfs+wrUVfL1uFZ28AMsFNCC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=S82CzPIr; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4387aO9O032786;
	Mon, 8 Apr 2024 02:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712561785;
	bh=0yWCV/qLNvQL+G4pU9IjA89QK71YdgPC3LJfQ1pJlnY=;
	h=From:To:CC:Subject:Date;
	b=S82CzPIrSLVWUQJKgTuvQJ9AJNUopXwON/2Y6hPxQcce0WIHlByYEu826uT5LtUm8
	 VqcqQ+5RhAGdHbb3uJjPd4mst3jNuDIntef6kmXrJrJUzrsqYBkIW6bn47CrApkR7q
	 payT+fSYivezqy5QEbi+EQ7HhtUSeQIGBQP8TVCQ=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4387aOIY047432
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Apr 2024 02:36:24 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Apr 2024 02:36:24 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Apr 2024 02:36:24 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.252])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4387aNE0083399;
	Mon, 8 Apr 2024 02:36:24 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <dianders@chromium.org>, <andrzej.hajda@intel.com>,
        <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <mripard@kernel.org>,
        <j-choudhary@ti.com>
CC: <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
        <airlied@gmail.com>, <daniel@ffwll.ch>, <andersson@kernel.org>,
        <robdclark@gmail.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/bridge: ti-sn65dsi86: Fix ti_sn_bridge_set_dsi_rate function
Date: Mon, 8 Apr 2024 13:06:23 +0530
Message-ID: <20240408073623.186489-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Due to integer calculations, the rounding off can cause errors in the final
value propagated in the registers.
Considering the example of 1080p (very common resolution), the mode->clock
is 148500, dsi->lanes = 4, and bpp = 24, with the previous logic, the DSI
clock frequency would come as 444 when we are expecting the value 445.5
which would reflect in SN_DSIA_CLK_FREQ_REG.
So move the division to be the last operation where rounding off will not
impact the register value.

Also according to the SN65DSI86 datasheet[0], the minimum value for that
reg is 0x08 (inclusive) and the maximum value is 0x97 (exclusive). So add
check for that.

[0]: <https://www.ti.com/lit/gpn/sn65dsi86>

Fixes: ca1b885cbe9e ("drm/bridge: ti-sn65dsi86: Split the setting of the dp and dsi rates")
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 48 +++++++++++++++++++++------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 84698a0b27a8..f9cf6b14d85e 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -111,7 +111,14 @@
 #define  AUX_IRQ_STATUS_AUX_SHORT		BIT(5)
 #define  AUX_IRQ_STATUS_NAT_I2C_FAIL		BIT(6)
 
-#define MIN_DSI_CLK_FREQ_MHZ	40
+/*
+ * NOTE: DSI clock frequency range: [40MHz,755MHz)
+ * DSI clock frequency range is in 5-MHz increments
+ * So minimum frequency 40MHz translates to 0x08
+ * And maximum frequency 755MHz translates to 0x97
+ */
+#define MIN_DSI_CLK_RANGE	0x8
+#define MAX_DSI_CLK_RANGE	0x97
 
 /* fudge factor required to account for 8b/10b encoding */
 #define DP_CLK_FUDGE_NUM	10
@@ -820,22 +827,37 @@ static void ti_sn_bridge_atomic_disable(struct drm_bridge *bridge,
 	regmap_update_bits(pdata->regmap, SN_ENH_FRAME_REG, VSTREAM_ENABLE, 0);
 }
 
-static void ti_sn_bridge_set_dsi_rate(struct ti_sn65dsi86 *pdata)
+static int ti_sn_bridge_set_dsi_rate(struct ti_sn65dsi86 *pdata)
 {
-	unsigned int bit_rate_mhz, clk_freq_mhz;
+	unsigned int bit_rate_khz;
 	unsigned int val;
 	struct drm_display_mode *mode =
 		&pdata->bridge.encoder->crtc->state->adjusted_mode;
 
-	/* set DSIA clk frequency */
-	bit_rate_mhz = (mode->clock / 1000) *
-			mipi_dsi_pixel_format_to_bpp(pdata->dsi->format);
-	clk_freq_mhz = bit_rate_mhz / (pdata->dsi->lanes * 2);
+	/*
+	 * Set DSIA clk frequency
+	 * Maximum supported value of bit_rate_khz turns out to be
+	 * 6040000 which can be put in 32-bit variable so no overflow
+	 * possible in this calculation.
+	 */
+	bit_rate_khz = mode->clock *
+		       mipi_dsi_pixel_format_to_bpp(pdata->dsi->format);
+
+	/*
+	 * For each increment in val, frequency increases by 5MHz
+	 * and the factor of 1000 comes from kHz to MHz conversion
+	 */
+	val = (bit_rate_khz / (pdata->dsi->lanes * 2 * 1000 * 5)) & 0xFF;
+
+	if (val >= MAX_DSI_CLK_RANGE || val < MIN_DSI_CLK_RANGE) {
+		drm_err(pdata->bridge.dev,
+			"DSI clock frequency not in the supported range\n");
+		return -EINVAL;
+	}
 
-	/* for each increment in val, frequency increases by 5MHz */
-	val = (MIN_DSI_CLK_FREQ_MHZ / 5) +
-		(((clk_freq_mhz - MIN_DSI_CLK_FREQ_MHZ) / 5) & 0xFF);
 	regmap_write(pdata->regmap, SN_DSIA_CLK_FREQ_REG, val);
+
+	return 0;
 }
 
 static unsigned int ti_sn_bridge_get_bpp(struct drm_connector *connector)
@@ -1104,7 +1126,11 @@ static void ti_sn_bridge_atomic_enable(struct drm_bridge *bridge,
 			   pdata->ln_polrs << LN_POLRS_OFFSET);
 
 	/* set dsi clk frequency value */
-	ti_sn_bridge_set_dsi_rate(pdata);
+	ret = ti_sn_bridge_set_dsi_rate(pdata);
+	if (ret) {
+		DRM_DEV_ERROR(pdata->dev, "Failed to set dsi rate :%d\n", ret);
+		return;
+	}
 
 	/*
 	 * The SN65DSI86 only supports ASSR Display Authentication method and
-- 
2.25.1


