Return-Path: <linux-kernel+bounces-138056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5E789EBA1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADCB51F21978
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9C813C9A7;
	Wed, 10 Apr 2024 07:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="17/sIH1G"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C3413CFAC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733309; cv=none; b=AnZJfcoGrxApkcdAX96DAc15AxOQtjg7ujuA9f0GyJImxkHSwXHBA3hlsrC5bCmi04bnrl2Y7eLxJVup98bmFmOCJyONFeaMOcFBEtgnv94vnnMSJVA3ue0XY6XuLLoPEYhKLhtHErenmLIVyV6JIjtgAt8F9abIH2/7OAYkgoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733309; c=relaxed/simple;
	bh=DfkEYtXHhaw3GIqyi3PIEriETJIvuX5lOG9mukCVMP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cfuuI+B8+cE7P7NhLo4QcbeDajQZHB1ZGxlWsWUYiA54WrblQfl5L1283tXG1za9r6bos7KoiI2DPNETT1DHQxdl4dueiiyi1c74w7ZxRpcYH2BQ8F2lPL0TIWVpZU/3v3ley7QMXgDykTKe2rod4kR8g3DlSwj4EoTEUeF8gho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=17/sIH1G; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ed2dc03df6so2632305b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 00:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1712733306; x=1713338106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/qhQNT2tXYhwGBicasrgC1HElvs9R7zx3ATOMLBXWY=;
        b=17/sIH1Gd/NhYX00N7tOP7jyDTAAMmA6oCJRio9aee29vG2HFUxl0GCalr6z/5YtM2
         yROxE03etNxizCx0TOntgm1XT7+6Osjplgojj0uXBEcW3fSw3SyBOWE+pj5Qjmhka61c
         4t15PShzpttYm4pE4GJZWH/Z3Xowc1yVF79zDYGd24FOYP6qulgIIbCqwH7imk2bFlkE
         +sMMdDNskegOp4s3vJYLG2PehBHhjlWTKRphfrPJbCJLJtGu5taozKsOXGb7Ewz++2BU
         epcyX27lQ1PXh2pFzs5k5PFxMquxwb+rMAVbeb9JPleeuVFY3k/Q2kIrDivsPyUwYPpI
         JpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712733306; x=1713338106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/qhQNT2tXYhwGBicasrgC1HElvs9R7zx3ATOMLBXWY=;
        b=WQk80cc+0QRxa6JDOCUFF5baVV18TnX1Pgg5T2MkpeIGeYNm/wUrQlz02EyVFqcSWE
         cTJlCqbvMRTMcWLOYUTsNba9Dkzrrn/w0IY3xrthnyMhhZqsW/EJmm0Dj6aiQBKoHaB2
         GHY5HPr+MSiLXZcVjhizqWVg4xGrMc+0aKFYzj8rlLYvg3mGK+XClo4dBm7xJLLBZwtF
         ufQvhEYyzvhp6ZRwcRe4JVb+YGYdtv8VrkCwBlJ/B6LHoQkxl4lgwloRBN21r8bU2Lvo
         Vj0ymPlByDEO0HIV0CbGQNwU9Z/Jrvm+eRrJdNM4VIvTvqWL3rQGpoDSZWZuWL1Xqyot
         otkg==
X-Forwarded-Encrypted: i=1; AJvYcCVxjsxYmn27fC0sYzeNztGorjrOPirEpAAlOfjO0OcFL6Q7V7Stgt2jRZfxFfW8CjPPIOscuRx7d9rqhiWQLy8xj5GDCWz+vBV2TNmM
X-Gm-Message-State: AOJu0YwCWNeQbmGLV9jsosujOlFmoq2jMvE/wlKZtNMWyogVxBfVv3qz
	ENsL360wuQ46uAt0mOhGOYaxYIpyis58g79kvyl0U4AjMW2753yIRix8rIzt/2Q=
X-Google-Smtp-Source: AGHT+IGFTieB9j8e5Ph0/TcKxZsJK9E1HUQZkMI4NYWUlFOYEWriDHr5SXg1bXvMxbbmLi26LoXZPQ==
X-Received: by 2002:a05:6a20:3ca3:b0:1a7:8b88:96b3 with SMTP id b35-20020a056a203ca300b001a78b8896b3mr2601717pzj.9.1712733306151;
        Wed, 10 Apr 2024 00:15:06 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id z17-20020a170903409100b001e264b50964sm10107975plc.205.2024.04.10.00.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 00:15:05 -0700 (PDT)
From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@chromium.org,
	airlied@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v1 2/4] drm/panel: boe-tv101wum-nl6: Support for BOE nv110wum-l60 MIPI-DSI panel
Date: Wed, 10 Apr 2024 15:14:37 +0800
Message-Id: <20240410071439.2152588-3-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410071439.2152588-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240410071439.2152588-1-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BOE nv110wum-l60 is a 11.0" WUXGA TFT LCD panel, which fits in nicely
with the existing panel-boe-tv101wum-nl6 driver. Hence, we add a new
compatible with panel specific config.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 0ffe8f8c01de..f91827e1548c 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1368,6 +1368,91 @@ static const struct panel_init_cmd starry_himax83102_j02_init_cmd[] = {
 	{},
 };
 
+static const struct panel_init_cmd boe_nv110wum_init_cmd[] = {
+	_INIT_DELAY_CMD(60),
+	_INIT_DCS_CMD(0xB9, 0x83, 0x10, 0x21, 0x55, 0x00),
+	_INIT_DCS_CMD(0xB1, 0x2C, 0xAF, 0xAF, 0x2B, 0xEB, 0x42, 0xE1, 0x4D, 0x36, 0x36, 0x36, 0x36, 0x1A, 0x8B, 0x11, 0x65, 0x00, 0x88, 0xFA, 0xFF, 0xFF, 0x8F, 0xFF, 0x08, 0x9A, 0x33),
+	_INIT_DCS_CMD(0xB2, 0x00, 0x47, 0xB0, 0x80, 0x00, 0x12, 0x71, 0x3C, 0xA3, 0x11, 0x00, 0x00, 0x00, 0x88, 0xF5, 0x22, 0x8F),
+	_INIT_DCS_CMD(0xB4, 0x49, 0x49, 0x32, 0x32, 0x14, 0x32, 0x84, 0x6E, 0x84, 0x6E, 0x01, 0x9C),
+	_INIT_DCS_CMD(0xE9, 0xCD),
+	_INIT_DCS_CMD(0xBA, 0x84),
+	_INIT_DCS_CMD(0xE9, 0x3F),
+
+	_INIT_DCS_CMD(0xBC, 0x1B, 0x04),
+	_INIT_DCS_CMD(0xBE, 0x20),
+	_INIT_DCS_CMD(0xBF, 0xFC, 0x84),
+
+	_INIT_DCS_CMD(0xC0, 0x36, 0x36, 0x22, 0x00, 0x00, 0xA0, 0x61, 0x08, 0xF5, 0x03),
+	_INIT_DCS_CMD(0xE9, 0xCC),
+	_INIT_DCS_CMD(0xC7, 0x80),
+	_INIT_DCS_CMD(0xE9, 0x3F),
+	_INIT_DCS_CMD(0xE9, 0xC6),
+	_INIT_DCS_CMD(0xC8, 0x97),
+	_INIT_DCS_CMD(0xE9, 0x3F),
+
+	_INIT_DCS_CMD(0xC9, 0x00, 0x1E, 0x30, 0xD4, 0x01),
+	_INIT_DCS_CMD(0xCB, 0x08, 0x13, 0x07, 0x00, 0x0F, 0x34),
+	_INIT_DCS_CMD(0xCC, 0x02, 0x03, 0x44),
+	_INIT_DCS_CMD(0xE9, 0xC4),
+	_INIT_DCS_CMD(0xD0, 0x03),
+	_INIT_DCS_CMD(0xE9, 0x3F),
+	_INIT_DCS_CMD(0xD1, 0x37, 0x06, 0x00, 0x02, 0x04, 0x0C, 0xFF),
+	_INIT_DCS_CMD(0xD2, 0x1F, 0x11, 0x1F, 0x11),
+
+	_INIT_DCS_CMD(0xD3, 0x06, 0x00, 0x00, 0x00, 0x00, 0x04, 0x08, 0x04, 0x08, 0x37, 0x37, 0x64, 0x4B, 0x11, 0x11, 0x03, 0x03, 0x32, 0x10, 0x0E, 0x00, 0x0E, 0x32, 0x10, 0x0A, 0x00, 0x0A, 0x32,
+			0x17, 0x98, 0x07, 0x98, 0x00, 0x00),
+	_INIT_DCS_CMD(0xD5, 0x18, 0x18, 0x18, 0x18, 0x1E, 0x1E, 0x1E, 0x1E, 0x1F, 0x1F, 0x1F, 0x1F, 0x24, 0x24, 0x24, 0x24, 0x07, 0x06, 0x07, 0x06, 0x05, 0x04, 0x05, 0x04, 0x03, 0x02, 0x03, 0x02, 0x01, 0x00, 0x01, 0x00, 0x21, 0x20, 0x21, 0x20, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18),
+	_INIT_DCS_CMD(0xD8, 0xAF, 0xAA, 0xAA, 0xAA, 0xAA, 0xA0, 0xAF, 0xAA, 0xAA, 0xAA, 0xAA, 0xA0),
+
+	_INIT_DCS_CMD(0xE0, 0x00, 0x05, 0x0D, 0x14, 0x1B, 0x2C, 0x44, 0x49, 0x51, 0x4C, 0x67, 0x6C, 0x71, 0x80, 0x7D, 0x84, 0x8D, 0xA0, 0xA0, 0x4F, 0x58, 0x64, 0x73, 0x00, 0x05, 0x0D, 0x14, 0x1B, 0x2C, 0x44, 0x49, 0x51, 0x4C, 0x67, 0x6C, 0x71, 0x80, 0x7D, 0x84, 0x8D, 0xA0, 0xA0, 0x4F, 0x58, 0x64, 0x73),
+	_INIT_DCS_CMD(0xE7, 0x07, 0x10, 0x10, 0x1A, 0x26, 0x9E, 0x00, 0x53, 0x9B, 0x14, 0x14),
+	_INIT_DCS_CMD(0xE1, 0x11, 0x00, 0x00, 0x89, 0x30, 0x80, 0x07, 0x80, 0x02, 0x58, 0x00, 0x14, 0x02, 0x58, 0x02, 0x58, 0x02, 0x00, 0x02, 0x2C, 0x00, 0x20, 0x02, 0x02, 0x00, 0x08, 0x00, 0x0C,
+			0x05, 0x0E, 0x04, 0x94, 0x18, 0x00, 0x10, 0xF0, 0x03, 0x0C, 0x20, 0x00, 0x06, 0x0B, 0x0B, 0x33, 0x0E),
+	_INIT_DCS_CMD(0xBD, 0x01),
+	_INIT_DCS_CMD(0xD8, 0xFF, 0xFF, 0xFF, 0xFF, 0xFA, 0xA0, 0xFF, 0xFF, 0xFF, 0xFF, 0xFA, 0xA0),
+	_INIT_DCS_CMD(0xB1, 0x01, 0xBF, 0x11),
+	_INIT_DCS_CMD(0xCB, 0x86),
+	_INIT_DCS_CMD(0xD2, 0x96),
+	_INIT_DCS_CMD(0xE9, 0xC9),
+	_INIT_DCS_CMD(0xD3, 0x84),
+	_INIT_DCS_CMD(0xE9, 0x3F),
+	_INIT_DCS_CMD(0xE9, 0xD1),
+	_INIT_DCS_CMD(0xE1, 0xF6, 0x2B, 0x34, 0x2B, 0x74, 0x3B, 0x74, 0x6B, 0x74),
+	_INIT_DCS_CMD(0xE9, 0x3F),
+
+	_INIT_DCS_CMD(0xE7, 0x02, 0x00, 0x2B, 0x01, 0x7E, 0x0F, 0x7E, 0x10, 0xA0, 0x00, 0x00),
+	_INIT_DCS_CMD(0xBD, 0x02),
+	_INIT_DCS_CMD(0xB4, 0x02, 0x00, 0xBB, 0x11),
+	_INIT_DCS_CMD(0xD8, 0xFF, 0xAF, 0xFF, 0xFF, 0xFA, 0xA0, 0xFF, 0xAF, 0xFF, 0xFF, 0xFA, 0xA0),
+	_INIT_DCS_CMD(0xE7, 0xFE, 0x01, 0xFE, 0x01, 0xFE, 0x01, 0x00, 0x00, 0x00, 0x23, 0x00, 0x23, 0x81, 0x02, 0x40, 0x00, 0x20, 0x65, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00),
+
+	_INIT_DCS_CMD(0xBD, 0x03),
+	_INIT_DCS_CMD(0xD8, 0xAA, 0xAF, 0xAA, 0xAA, 0xA0, 0x00, 0xAA, 0xAF, 0xAA, 0xAA, 0xA0, 0x00, 0xAA, 0xAF, 0xAA, 0xAA, 0xA0, 0x00, 0xAA, 0xAF, 0xAA, 0xAA, 0xA0, 0x00),
+	_INIT_DCS_CMD(0xE9, 0xC6),
+	_INIT_DCS_CMD(0xB4, 0x03, 0xFF, 0xF8),
+	_INIT_DCS_CMD(0xE9, 0x3F),
+	_INIT_DCS_CMD(0xE1, 0x00),
+
+	_INIT_DCS_CMD(0xBD, 0x00),
+	_INIT_DCS_CMD(0xE9, 0xC4),
+	_INIT_DCS_CMD(0xBA, 0x96),
+	_INIT_DCS_CMD(0xE9, 0x3F),
+
+	_INIT_DCS_CMD(0xBD, 0x01),
+	_INIT_DCS_CMD(0xE9, 0xC5),
+	_INIT_DCS_CMD(0xBA, 0x4F),
+	_INIT_DCS_CMD(0xE9, 0x3F),
+
+	_INIT_DCS_CMD(0xBD, 0x00),
+
+	_INIT_DCS_CMD(0xB9, 0x00, 0x00, 0x00),
+	_INIT_DELAY_CMD(50),
+	_INIT_DCS_CMD(0x11),
+	_INIT_DELAY_CMD(110),
+	_INIT_DCS_CMD(0x29),
+	_INIT_DELAY_CMD(25),
+	{},
+};
 static inline struct boe_panel *to_boe_panel(struct drm_panel *panel)
 {
 	return container_of(panel, struct boe_panel, base);
@@ -1795,6 +1880,33 @@ static const struct panel_desc starry_himax83102_j02_desc = {
 	.lp11_before_reset = true,
 };
 
+static const struct drm_display_mode boe_tv110wum_default_mode = {
+	.clock = 166400,
+	.hdisplay = 1200,
+	.hsync_start = 1200 + 65,
+	.hsync_end = 1200 + 65 + 20,
+	.htotal = 1200 + 65 + 20 + 65,
+	.vdisplay = 1920,
+	.vsync_start = 1920 + 115,
+	.vsync_end = 1920 + 115 + 8,
+	.vtotal = 1920 + 115 + 8 + 12,
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static const struct panel_desc boe_nv110wum_desc = {
+	.modes = &boe_tv110wum_default_mode,
+	.bpc = 8,
+	.size = {
+		.width_mm = 147,
+		.height_mm = 235,
+	},
+	.lanes = 4,
+	.format = MIPI_DSI_FMT_RGB888,
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+		      MIPI_DSI_MODE_LPM,
+	.init_cmds = boe_nv110wum_init_cmd,
+	.lp11_before_reset = true,
+};
 static int boe_panel_get_modes(struct drm_panel *panel,
 			       struct drm_connector *connector)
 {
@@ -1973,6 +2085,9 @@ static const struct of_device_id boe_of_match[] = {
 	{ .compatible = "starry,himax83102-j02",
 	  .data = &starry_himax83102_j02_desc
 	},
+	{ .compatible = "boe,nv110wum-l60",
+	  .data = &boe_nv110wum_desc
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, boe_of_match);
-- 
2.25.1


