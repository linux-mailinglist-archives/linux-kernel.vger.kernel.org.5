Return-Path: <linux-kernel+bounces-102256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 204F987AFDC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CACC41F28884
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F598175F;
	Wed, 13 Mar 2024 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J3Jw97vT"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F5480C14;
	Wed, 13 Mar 2024 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350437; cv=none; b=jZxSMVo0KFkvikH+Dg6sGY5jgbIgV8dzCQhdk02cA1RGDhqZxFvOuDwc6OZep/ARsaF7vd56uFwZHpqc+6IKcxRykfoFvI0X8JOH83r+0lcY0iSzDAIWWzuLKXM8jiJDYkNTJMruHi1A0/VI/OxbuBSJCEwMGcByOocH3G7h0kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350437; c=relaxed/simple;
	bh=NxjvQGRkUbfO3iz0bYj5pREEVHoSAk8BUB+aqZUAEs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e6EvJbuJgRro+L6/38VDJtU9ku5AZv6iDnxI2QQA0xCHIIEGTuB8Ou5OE9Egso4QMGcbmNCAGE4UpOQDaQqmeVMCBFjuD8V/02+sC9/CA3JgVn6WvGKUZumVOtOP83dVKt4f4un5RfxzTnuyuaFZ/jtX2RDnN9++6c6xmFo6Ivs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=J3Jw97vT; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0BF236000D;
	Wed, 13 Mar 2024 17:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710350426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cxt4rRwQDdEywKuxvwOOReRQvAjrL6urT5nnO/pBm6M=;
	b=J3Jw97vT+ILqpl1j49Q8O86WY7SE33uGUsifwrp8kTNxnRxv/oO/lK84KBukynQbTcNgHN
	b/cJxZq+GEPr0r5Ey3M8ABgJ4yoMmZ8bFz4ZrYwqBmCkpaaDnayofBF5GhRpKB6MEEpXa+
	MFaVLLIh6t68ZK78OeOku7yJw5n+MpMDOtefahec6cnPtJec3OJWrDXT38jkEKfjZ4tLnV
	SdcDMeSniUGFZACgQ6CP5nBvi2IX14pAmZCh2gIA4dk4S7zbwCqLlC6pA6yWrQWUXbmH5P
	/G2Hy0akFD38PNLrAoevu7LulneLA/Oux1dLkr9zPRlXCDzO+icACHI0wzINUA==
From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Yen-Mei Goh <yen-mei.goh@keysight.com>,
	=?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
Subject: [PATCH v3 3/3] drm/panel: simple: add CMT430B19N00 LCD panel support
Date: Wed, 13 Mar 2024 18:20:16 +0100
Message-Id: <20240313172016.387277-4-jeremie.dautheribes@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313172016.387277-1-jeremie.dautheribes@bootlin.com>
References: <20240313172016.387277-1-jeremie.dautheribes@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeremie.dautheribes@bootlin.com

Add support for Crystal Clear Technology CMT430B19N00 4.3" 480x272
TFT-LCD panel.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 20e3df1c59d4..d13c42d0f57b 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1457,6 +1457,32 @@ static const struct panel_desc boe_hv070wsa = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct display_timing cct_cmt430b19n00_timing = {
+	.pixelclock = { 8000000, 9000000, 12000000 },
+	.hactive = { 480, 480, 480 },
+	.hfront_porch = { 2, 8, 75 },
+	.hback_porch = { 3, 43, 43 },
+	.hsync_len = { 2, 4, 75 },
+	.vactive = { 272, 272, 272 },
+	.vfront_porch = { 2, 8, 37 },
+	.vback_porch = { 2, 12, 12 },
+	.vsync_len = { 2, 4, 37 },
+	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW
+};
+
+static const struct panel_desc cct_cmt430b19n00 = {
+	.timings = &cct_cmt430b19n00_timing,
+	.num_timings = 1,
+	.bpc = 8,
+	.size = {
+		.width = 95,
+		.height = 53,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
+};
+
 static const struct drm_display_mode cdtech_s043wq26h_ct7_mode = {
 	.clock = 9000,
 	.hdisplay = 480,
@@ -4402,6 +4428,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "boe,hv070wsa-100",
 		.data = &boe_hv070wsa
+	}, {
+		.compatible = "cct,cmt430b19n00",
+		.data = &cct_cmt430b19n00,
 	}, {
 		.compatible = "cdtech,s043wq26h-ct7",
 		.data = &cdtech_s043wq26h_ct7,
-- 
2.34.1


