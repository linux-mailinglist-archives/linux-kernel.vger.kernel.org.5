Return-Path: <linux-kernel+bounces-75421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474BB85E87B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F236F280F1D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4BA8662E;
	Wed, 21 Feb 2024 19:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIVP95jy"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB586629
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544838; cv=none; b=lMEDSb2eFhQQ68e2BqLcK8fvZlIhfPgu46MEovtPWrxLL04A1U42dx8spwHfbNCa6yseLtKPfgpFsuqulOLl1avg9HTdXfSSstY/wdw9TuVv9Hy7u6LIxdQITSQOP47BzgRlInikfZ9zlUhmS5ID+/OAYt3QhVA4T2tLWvedJoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544838; c=relaxed/simple;
	bh=9Vexo8XlUPZEpsbMOMkrK7fU2EUlDEzv3S/jPMMvnik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jtbP4Y2GdNhmKe3hpdzg0KGvTsqsdHGMEgBSMZ+wmGw0Lwq7rDfsV6ZdS7c2vSraKqvJr3iYGDX4sVWtxtICzyEfEBduzSPrnNyAxvYBF/FiLBViiN3vbzsScPy7OkrRTGd2W5vb+J428jJdgbOaHqjx9Cv/vwsH0FP/8/goqkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIVP95jy; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d7b8f563eso907200f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708544835; x=1709149635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jScVkplTKNS9JH25i83p7JrWSobqpPIxlhtse73Qt2A=;
        b=KIVP95jyaWfn+/nN6dxKbbPxolskpIee/5fbmXWJbFguW852AqXD48JQQLvEhY9sem
         tF1BQItsnWT3+ur+SurEBaSje86E+giLd4B8QisqTQRgaDxnHZG1cQqvTPGK/DlI67xF
         pVxHox+TrWLIsmPPa6gh2TSU+wOsiryS6bxQw1QJ9Lqx/R43dMgxwh+PoPbgtm+WTBzG
         GK72H03ywa6DewJmuOHbQZ7HqWW72Pl2ANF3IIT5bZc09y07Ab3OKq471E1tcABPGESs
         31K75bN9s19YGMAS8noQ7fTMFKTIZ/HMQ7Vy2SKAVLqXTgD5CdjBtACtmMdxVl1O07Gf
         lDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544835; x=1709149635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jScVkplTKNS9JH25i83p7JrWSobqpPIxlhtse73Qt2A=;
        b=fQfa1BQ8RxA17M77ae8Tnl8GKuCd77Qy/ZonlR0xbLj4YKec9hV3sYnDIOumDBYBCm
         hprJ4TeDp709ZLDKEBwCPbpCNy/ta8+9c72I/BdNhKV5VqSDpL9BEXbuajbTobWBCHhV
         ACe2tNlcADWpdhPLSLIm+Hc6En1qyu14z3PkgIpiD5qxlmO3+D5pXZ/lzWiP5cljNvg9
         SE7LokCGIvFhT9bmQw1uys47m3Oly2L0dnRp03nGVa65+Z7BwF5A8M1npN2pg3So8/43
         LslyzlW6MhRzNPa2Xo9ZklPjnrSvE2Yzsnb3TTh0g9KQOFwB9Okuc+js14gqaDSRXzn9
         cFdg==
X-Forwarded-Encrypted: i=1; AJvYcCWT3ttD+xRbR1l2uuh6WKYPWt8t6EfLFlStzYitc5pMk65BP+uMBddPgf7CZh0fbd4qblm4YoM3sM4/r7tIiGXaSzFWsb3fPLp6HVQ2
X-Gm-Message-State: AOJu0Ywhq+j6LEhB7SD+Cq9mcHLTV1i05TJ0RhwLXyrarzDJET8A6Amd
	1nrxI8xbDnP/zaYOzbPTnGkyBgVeLC0uNuthVrMzaFQeAZ2Qy+6P
X-Google-Smtp-Source: AGHT+IHeZsxxNcTW0LamAIrF+0mGyVTttqxxs5bsfEAXjIMM+NNA47NJeEDwrbdb84T8bV2PZNvgeA==
X-Received: by 2002:a5d:5487:0:b0:33d:3ee3:cc04 with SMTP id h7-20020a5d5487000000b0033d3ee3cc04mr7567602wrv.0.1708544834534;
        Wed, 21 Feb 2024 11:47:14 -0800 (PST)
Received: from localhost.localdomain ([90.255.110.157])
        by smtp.googlemail.com with ESMTPSA id f14-20020a056000128e00b0033d87da9ab3sm585169wrx.110.2024.02.21.11.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 11:47:14 -0800 (PST)
From: Adam Green <greena88@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: greena88@gmail.com
Subject: [PATCH] drm: panel: st7701: Add Hardkernel ODROID-GO Ultra panel support
Date: Wed, 21 Feb 2024 19:45:27 +0000
Message-Id: <20240221194528.1855714-1-greena88@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Hardkernel ODROID-GO Ultra is a handheld gaming devices, with
a 5 inch 480x854 display. Add support for the display.

Signed-off-by: Adam Green <greena88@gmail.com>
---
 drivers/gpu/drm/panel/panel-sitronix-st7701.c | 158 +++++++++++++++++-
 1 file changed, 157 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
index 421eb4592b61..d08e8f4c39dd 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
@@ -423,6 +423,62 @@ static void kd50t048a_gip_sequence(struct st7701 *st7701)
 		   0xFF, 0xFF, 0xFF, 0xFF, 0x10, 0x45, 0x67, 0x98, 0xBA);
 }
 
+static void odroid_go_ultra_gip_sequence(struct st7701 *st7701)
+{
+	ST7701_DSI(st7701, 0x01);
+	msleep(20);
+	ST7701_DSI(st7701, 0x11);
+	msleep(120);
+
+	ST7701_DSI(st7701, 0xFF, 0x77, 0x01, 0x00, 0x00, 0x10);
+	ST7701_DSI(st7701, 0xC0, 0xE9, 0x03);
+	ST7701_DSI(st7701, 0xC1, 0x11, 0x02);
+	ST7701_DSI(st7701, 0xC2, 0x31, 0x08);
+	ST7701_DSI(st7701, 0xCC, 0x10);
+	ST7701_DSI(st7701, 0xB0, 0x00, 0x0D, 0x14, 0x0D, 0x10, 0x05, 0x02, 0x08,
+		   0x08, 0x1E, 0x05, 0x13, 0x11, 0xA3, 0x29, 0x18);
+	ST7701_DSI(st7701, 0xB1, 0x00, 0x0C, 0x14, 0x0C, 0x10, 0x05, 0x03, 0x08,
+		   0x07, 0x20, 0x05, 0x13, 0x11, 0xA4, 0x29, 0x18);
+	ST7701_DSI(st7701, 0xFF, 0x77, 0x01, 0x00, 0x00, 0x11);
+	ST7701_DSI(st7701, 0xB0, 0x6C);
+	ST7701_DSI(st7701, 0xB1, 0x43);
+	ST7701_DSI(st7701, 0xB2, 0x07);
+	ST7701_DSI(st7701, 0xB3, 0x80);
+	ST7701_DSI(st7701, 0xB5, 0x47);
+	ST7701_DSI(st7701, 0xB7, 0x85);
+	ST7701_DSI(st7701, 0xB8, 0x20);
+	ST7701_DSI(st7701, 0xB9, 0x10);
+	ST7701_DSI(st7701, 0xC1, 0x78);
+	ST7701_DSI(st7701, 0xC3, 0x78);
+	ST7701_DSI(st7701, 0xD0, 0x88);
+	msleep(120);
+
+	ST7701_DSI(st7701, 0xE0, 0x00, 0x00, 0x02);
+	ST7701_DSI(st7701, 0xE1, 0x08, 0x00, 0x0A, 0x00, 0x07, 0x00, 0x09,
+		   0x00, 0x00, 0x33, 0x33);
+	ST7701_DSI(st7701, 0xE2, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+		   0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
+	ST7701_DSI(st7701, 0xE3, 0x00, 0x00, 0x33, 0x33);
+	ST7701_DSI(st7701, 0xE4, 0x44, 0x44);
+	ST7701_DSI(st7701, 0xE5, 0x0E, 0x60, 0xA0, 0xA0, 0x10, 0x60, 0xA0,
+		   0xA0, 0x0A, 0x60, 0xA0, 0xA0, 0x0C, 0x60, 0xA0, 0xA0);
+	ST7701_DSI(st7701, 0xE6, 0x00, 0x00, 0x33, 0x33);
+	ST7701_DSI(st7701, 0xE7, 0x44, 0x44);
+	ST7701_DSI(st7701, 0xE8, 0x0D, 0x60, 0xA0, 0xA0, 0x0F, 0x60, 0xA0,
+		   0xA0, 0x09, 0x60, 0xA0, 0xA0, 0x0B, 0x60, 0xA0, 0xA0);
+	ST7701_DSI(st7701, 0xEB, 0x02, 0x01, 0xE4, 0xE4, 0x44, 0x00, 0x40);
+	ST7701_DSI(st7701, 0xEC, 0x02, 0x01);
+	ST7701_DSI(st7701, 0xED, 0xAB, 0x89, 0x76, 0x54, 0x01, 0xFF, 0xFF,
+		   0xFF, 0xFF, 0xFF, 0xFF, 0x10, 0x45, 0x67, 0x98, 0xBA);
+	ST7701_DSI(st7701, 0xFF, 0x77, 0x01, 0x00, 0x00, 0x00);
+	ST7701_DSI(st7701, 0x3A, 0x70);
+	ST7701_DSI(st7701, 0x53, 0xEC);
+	ST7701_DSI(st7701, 0x55, 0xB3);
+	ST7701_DSI(st7701, 0x5E, 0xFF);
+	ST7701_DSI(st7701, 0x29);
+	msleep(50);
+}
+
 static void rg_arc_gip_sequence(struct st7701 *st7701)
 {
 	st7701_switch_cmd_bkx(st7701, true, 3);
@@ -470,7 +526,7 @@ static int st7701_prepare(struct drm_panel *panel)
 				    st7701->supplies);
 	if (ret < 0)
 		return ret;
-	msleep(20);
+	msleep(120);
 
 	gpiod_set_value(st7701->reset, 1);
 	msleep(150);
@@ -875,6 +931,105 @@ static const struct st7701_panel_desc kd50t048a_desc = {
 	.gip_sequence = kd50t048a_gip_sequence,
 };
 
+static const struct drm_display_mode odroid_go_ultra_mode = {
+	.clock		= 29170,
+
+	.hdisplay	= 480,
+	.hsync_start	= 480 + 12,
+	.hsync_end	= 480 + 12 + 12,
+	.htotal		= 480 + 12 + 12 + 38,
+
+	.vdisplay	= 854,
+	.vsync_start	= 854 + 2,
+	.vsync_end	= 854 + 2 + 19,
+	.vtotal		= 854 + 2 + 19 + 22,
+
+	.width_mm	= 70,
+	.height_mm	= 140,
+
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static const struct st7701_panel_desc odroid_go_ultra_desc = {
+	.mode = &odroid_go_ultra_mode,
+	.lanes = 2,
+	.format = MIPI_DSI_FMT_RGB888,
+	.panel_sleep_delay = 120,
+
+	.pv_gamma = {
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC0_MASK, 0),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC4_MASK, 0xd),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC8_MASK, 0x14),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC16_MASK, 0xd),
+
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC24_MASK, 0x10),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC52_MASK, 0x5),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC80_MASK, 0x2),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC108_MASK, 0x8),
+
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC147_MASK, 0x8),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC175_MASK, 0x1e),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC203_MASK, 0x5),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC231_MASK, 0x13),
+
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC239_MASK, 0x11),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 2) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC247_MASK, 0x23),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC251_MASK, 0x29),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC255_MASK, 0x18)
+	},
+	.nv_gamma = {
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC0_MASK, 0),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC4_MASK, 0xc),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC8_MASK, 0x14),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC16_MASK, 0xc),
+
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC24_MASK, 0x10),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC52_MASK, 0x5),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC80_MASK, 0x3),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC108_MASK, 0x8),
+
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC147_MASK, 0x7),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC175_MASK, 0x20),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC203_MASK, 0x5),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC231_MASK, 0x13),
+
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC239_MASK, 0x11),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 2) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC247_MASK, 0x24),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC251_MASK, 0x29),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC255_MASK, 0x18)
+	},
+	.nlinv = 1,
+	.vop_uv = 4887500,
+	.vcom_uv = 937500,
+	.vgh_mv = 15000,
+	.vgl_mv = -9510,
+	.avdd_mv = 6600,
+	.avcl_mv = -4400,
+	.gamma_op_bias = OP_BIAS_MIDDLE,
+	.input_op_bias = OP_BIAS_MIN,
+	.output_op_bias = OP_BIAS_MIN,
+	.t2d_ns = 1600,
+	.t3d_ns = 10400,
+	.eot_en = true,
+	.gip_sequence = odroid_go_ultra_gip_sequence,
+};
+
 static const struct drm_display_mode rg_arc_mode = {
 	.clock          = 25600,
 
@@ -1055,6 +1210,7 @@ static const struct of_device_id st7701_of_match[] = {
 	{ .compatible = "anbernic,rg-arc-panel", .data = &rg_arc_desc },
 	{ .compatible = "densitron,dmt028vghmcmi-1a", .data = &dmt028vghmcmi_1a_desc },
 	{ .compatible = "elida,kd50t048a", .data = &kd50t048a_desc },
+	{ .compatible = "hardkernel,odroid-go-ultra-panel", .data = &odroid_go_ultra_desc },
 	{ .compatible = "techstar,ts8550b", .data = &ts8550b_desc },
 	{ }
 };
-- 
2.34.1


