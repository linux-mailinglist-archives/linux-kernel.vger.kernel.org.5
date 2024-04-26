Return-Path: <linux-kernel+bounces-160353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1069A8B3C58
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ADB4B280BF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4E015219E;
	Fri, 26 Apr 2024 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GwNo1iYB"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11783148FE6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147403; cv=none; b=Y6EyIf3Gxppc62POojRxyn+8XzX6JRWXbuBQPwlMXAZh+96W2JPEDtpFnZQKaBRwlv+u6z6sgE712LwR3t54kCauxh1JC/tNX6YFlQ792iD2faz8MRPoLzwrh15EAPfbfpvHfmycCQf85AZ1mIZ2AEPL+8+3i5ZOWW0wycSD08w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147403; c=relaxed/simple;
	bh=ez7lHK6kpD0AqMQJPIXCWWLHVxu2yzYTOG3RIR1auJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUd3mwXbrZ61au3yiM2YconJVdnXVnD/lWdfUuUvaUneRtP6vdbdk0CdujYDhrt+73+cew5ZarQk5e5P8t2N6XGPZQP7L7Kv4uBTy9tctTo0ZPia6qhfxAqULigL3IbNGZhd88GIplwFawFKX4fsqakprxcBr7gPudgEPGUZfBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GwNo1iYB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41b79451153so7667995e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 09:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714147399; x=1714752199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwWBLD0qVTKGOAoQ6eE14pnlmcdWHx3m3KgGPqRsyL0=;
        b=GwNo1iYBQ0+Xmvuy1jdD0mu2h3NE+V/9W6pOoXdXT2J5kAS2Fp0NBCEoySI1vQq4nm
         NJK96m7BebHsyFa1Uv9u8s6+8PwfKrlT0YXZuwAoGYe255VAq5DKfMqT1P+cLUa305Hv
         LNL0R4dpvPZuIOgLx28O2qcLjJv+i+8yPpeVP9RQWinpT10UtsIENA8meWIKAOh3r5ta
         OME2OcRdNsvDVg6hfu2X9t/0LrKUPXZfPoRXcUqKW1JcvMqGSwbLb0b8THcRpthscKQ5
         KhZTsPwwRmlRXWCRjsokgRkj3VI6bx8G0tImS0xM22ZrigTdixAVvuz7LlyH5QGjmXvn
         Zpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714147399; x=1714752199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwWBLD0qVTKGOAoQ6eE14pnlmcdWHx3m3KgGPqRsyL0=;
        b=ivwVszJVLedTT1qbVhSXAlJXlO8Xk916ZZefuttHxkoIbjLfoOZsAnv5BdlGinl/mP
         5XiAuEc7ojvBz22yNl0IEnXQMu69sYxNR1QJpnepFs4lL4BQzl9zmuNSpYiEIr9P9eSI
         IUElFclPB3fQcgfOEtrNlGp9/F9npMtkaH8v8CjG+fpj+7LDkvAx2BuluShrQo85EVoe
         KUkwEkeIK+6SkYK+zaGMBHDvbjpW3gAlUpvUNeA44pAV95EF4IeCTIxE4VdW4mR5OeCs
         XwR+TAtMkudPHg7vYjWTSw05RUaw6IQMt2WERwrdrYED9n5+fh9kL1C1sN3HIP2yBICj
         LYZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoEp+SdPTQIYfJXqcifjHK8dLmdgSaRiflWKM35JqlKFypK8bdFb0OtSsAEY5iCrB0Pc95oxOgP9Xgwmojuo77Y+vtUfYm32K7zeK0
X-Gm-Message-State: AOJu0Yx1ONWzqATnOlwWdWZiw6iSRLik7MFCyXUIPtklDG2+JYt48+42
	nSQmFA3xFoj6GOIVvUhhcKQTMtdBkYM6/pZoXGkfQSYb/Ps63lHIO5YovANffxY=
X-Google-Smtp-Source: AGHT+IHkz1L3NwwxZXGlD2vu7++NI5Hhk5UYu+PbPcgI+aC0ZN9bQl9YHJFAVv+F4MLdLuQUjRV3jw==
X-Received: by 2002:a05:600c:1913:b0:41b:ab72:3f4d with SMTP id j19-20020a05600c191300b0041bab723f4dmr749759wmq.1.1714147399382;
        Fri, 26 Apr 2024 09:03:19 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:1926:f73e:8b99:1c0a])
        by smtp.googlemail.com with ESMTPSA id p14-20020a05600c1d8e00b0041bab13cd74sm1271408wms.17.2024.04.26.09.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 09:03:19 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	dri-devel@lists.freedesktop.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/meson: dw-hdmi: add bandgap setting for g12
Date: Fri, 26 Apr 2024 18:02:54 +0200
Message-ID: <20240426160256.3089978-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240426160256.3089978-1-jbrunet@baylibre.com>
References: <20240426160256.3089978-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

When no mode is set, the utility pin appears to be grounded. No signal
is getting through.

This is problematic because ARC and eARC use this line and may do so even
if no display mode is set.

This change enable the bandgap setting on g12 chip, which fix the problem
with the utility pin. This is done by restoring init values on PHY init and
disable.

Fixes: 3b7c1237a72a ("drm/meson: Add G12A support for the DW-HDMI Glue")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 43 ++++++++++++++++-----------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index a83d93078537..5565f7777529 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -106,6 +106,8 @@
 #define HHI_HDMI_CLK_CNTL	0x1cc /* 0x73 */
 #define HHI_HDMI_PHY_CNTL0	0x3a0 /* 0xe8 */
 #define HHI_HDMI_PHY_CNTL1	0x3a4 /* 0xe9 */
+#define  PHY_CNTL1_INIT		0x03900000
+#define  PHY_INVERT		BIT(17)
 #define HHI_HDMI_PHY_CNTL2	0x3a8 /* 0xea */
 #define HHI_HDMI_PHY_CNTL3	0x3ac /* 0xeb */
 #define HHI_HDMI_PHY_CNTL4	0x3b0 /* 0xec */
@@ -130,6 +132,8 @@ struct meson_dw_hdmi_data {
 				    unsigned int addr);
 	void		(*dwc_write)(struct meson_dw_hdmi *dw_hdmi,
 				     unsigned int addr, unsigned int data);
+	u32 cntl0_init;
+	u32 cntl1_init;
 };
 
 struct meson_dw_hdmi {
@@ -458,7 +462,9 @@ static void dw_hdmi_phy_disable(struct dw_hdmi *hdmi,
 
 	DRM_DEBUG_DRIVER("\n");
 
-	regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, 0);
+	/* Fallback to init mode */
+	regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL1, dw_hdmi->data->cntl1_init);
+	regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, dw_hdmi->data->cntl0_init);
 }
 
 static enum drm_connector_status dw_hdmi_read_hpd(struct dw_hdmi *hdmi,
@@ -576,11 +582,22 @@ static const struct regmap_config meson_dw_hdmi_regmap_config = {
 	.fast_io = true,
 };
 
-static const struct meson_dw_hdmi_data meson_dw_hdmi_gx_data = {
+static const struct meson_dw_hdmi_data meson_dw_hdmi_gxbb_data = {
 	.top_read = dw_hdmi_top_read,
 	.top_write = dw_hdmi_top_write,
 	.dwc_read = dw_hdmi_dwc_read,
 	.dwc_write = dw_hdmi_dwc_write,
+	.cntl0_init = 0x0,
+	.cntl1_init = PHY_CNTL1_INIT | PHY_INVERT,
+};
+
+static const struct meson_dw_hdmi_data meson_dw_hdmi_gxl_data = {
+	.top_read = dw_hdmi_top_read,
+	.top_write = dw_hdmi_top_write,
+	.dwc_read = dw_hdmi_dwc_read,
+	.dwc_write = dw_hdmi_dwc_write,
+	.cntl0_init = 0x0,
+	.cntl1_init = PHY_CNTL1_INIT,
 };
 
 static const struct meson_dw_hdmi_data meson_dw_hdmi_g12a_data = {
@@ -588,6 +605,8 @@ static const struct meson_dw_hdmi_data meson_dw_hdmi_g12a_data = {
 	.top_write = dw_hdmi_g12a_top_write,
 	.dwc_read = dw_hdmi_g12a_dwc_read,
 	.dwc_write = dw_hdmi_g12a_dwc_write,
+	.cntl0_init = 0x000b4242, /* Bandgap */
+	.cntl1_init = PHY_CNTL1_INIT,
 };
 
 static void meson_dw_hdmi_init(struct meson_dw_hdmi *meson_dw_hdmi)
@@ -626,18 +645,8 @@ static void meson_dw_hdmi_init(struct meson_dw_hdmi *meson_dw_hdmi)
 	meson_dw_hdmi->data->top_write(meson_dw_hdmi, HDMITX_TOP_BIST_CNTL, BIT(12));
 
 	/* Setup PHY */
-	regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1,
-			   0xffff << 16, 0x0390 << 16);
-
-	/* BIT_INVERT */
-	if (dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-gxl-dw-hdmi") ||
-	    dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-gxm-dw-hdmi") ||
-	    dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-g12a-dw-hdmi"))
-		regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1,
-				   BIT(17), 0);
-	else
-		regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1,
-				   BIT(17), BIT(17));
+	regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL1, meson_dw_hdmi->data->cntl1_init);
+	regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, meson_dw_hdmi->data->cntl0_init);
 
 	/* Enable HDMI-TX Interrupt */
 	meson_dw_hdmi->data->top_write(meson_dw_hdmi, HDMITX_TOP_INTR_STAT_CLR,
@@ -848,11 +857,11 @@ static const struct dev_pm_ops meson_dw_hdmi_pm_ops = {
 
 static const struct of_device_id meson_dw_hdmi_of_table[] = {
 	{ .compatible = "amlogic,meson-gxbb-dw-hdmi",
-	  .data = &meson_dw_hdmi_gx_data },
+	  .data = &meson_dw_hdmi_gxbb_data },
 	{ .compatible = "amlogic,meson-gxl-dw-hdmi",
-	  .data = &meson_dw_hdmi_gx_data },
+	  .data = &meson_dw_hdmi_gxl_data },
 	{ .compatible = "amlogic,meson-gxm-dw-hdmi",
-	  .data = &meson_dw_hdmi_gx_data },
+	  .data = &meson_dw_hdmi_gxl_data },
 	{ .compatible = "amlogic,meson-g12a-dw-hdmi",
 	  .data = &meson_dw_hdmi_g12a_data },
 	{ }
-- 
2.43.0


