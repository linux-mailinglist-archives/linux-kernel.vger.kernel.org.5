Return-Path: <linux-kernel+bounces-156147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB418AFE80
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16D1AB25186
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C21355C22;
	Wed, 24 Apr 2024 02:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="n8qQGGW1"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F3B13E8AF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713925871; cv=none; b=swbHwZfkfl4JnJwADmH9D1rowmzLocxH9jw3PRyn0ScXrM5c0htCK+N+ipJNMAKpbmmfUoLbUyaQIlQ4M0/qgcs0/jVMVhs9aP5I8ozb87Mu9dQfP8aLbbSM9bdZ3GjlpM7uMpWy+OoEitD3YomoEdzdqyBECsQal+L1loPC+mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713925871; c=relaxed/simple;
	bh=+OilyqShHeVBcvaGPn8BcjKnXwa036Aa2Mha5egYjEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jPzjd9UU9OYmZLsrinkY2B4TFThPfphXSQHAiL1VqqHVKjK83HoCay0zHSxUkrGEQt1CgZWf4nYloT+KlpGdElFhIrsjDodvgA2BypIvvyF3TPgKp2xkZfs8idonS/xTYu8l3QnVfEkFIjyqDVDAX5BBip6HPij5BMVJcitJ58o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=n8qQGGW1; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bbc649c275so2755908b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 19:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1713925859; x=1714530659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGlfIXei0q5g87t8TDHyHjhG2JVouovJNembL1zbdJM=;
        b=n8qQGGW1bYrMmlQUGlzKGM3Rm4PHsWUz5dYAG6KLytn/MzjEIWt2eqEBhBmrJnIMqP
         FM6FN0sTY+BGHW1wQBC/fi3jHukf4CvrdDpPaZQTH8W2JQtW1XChidaMaqNSmVRprgCR
         QwhrGDq0nqo8NV3CYmXhFiuNX+u2I1xmNBVXDRiRMeWpLkPWzLPUYpzE9Dr9dS8Un0Xt
         1xQP4forcqHTVgP/+HRgZsDXPgJZ5K4LiFF9+yBWeuBQAMVVdSW6S4A/ZWxR1i7CuYb1
         hCE5zA0CEm/JezkXl5SMnt7A27b1Nq4Ugqe4ShvcT6pGnguaiGR4m6UuUcTkWsQ43DUL
         Wyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713925859; x=1714530659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGlfIXei0q5g87t8TDHyHjhG2JVouovJNembL1zbdJM=;
        b=on2eh51js7lNYWZZTRlt0hhuer2ljyPPZwOo86n0YT2Wl4MeQJ7OHSHWN7hlyotayt
         5LdjcT4S25pU/iuipcfAPZSYDwTlsV/FaIZKClpfYLFZQC9vSzAMePXX21zsca+9jO9W
         z1HG/HzUQF36acebSjKAokm181xwSqeKmJa3OMLmYDOIgekoHX8ehGGF3wsIk+AC2VeH
         lyOe51RLhC+vIYsMMqb/G+ZC2tbbdzDAn6c+HnVxZu0tJQu86gKlFbU8ughMnms4p8Aq
         QbFjwiRWO4ipzst+GnXoO+KgVLxxkS0zCbqW/zmKe+HM5PxONOzNnKGhv6+2sC+Q39EC
         GrOw==
X-Forwarded-Encrypted: i=1; AJvYcCU/pkpA7GDZpmh0ps+sOi04Bhv5JkRnJbC/AOXR7rADTFE1C730WwjJnaAx3LYKHXjZeW/ej3fqBgFKr64i2OHDI/GzOsG9nhNd2Jm/
X-Gm-Message-State: AOJu0YzR/fDT6iOWccJfa7jIm1obsK6DeauW1480/3E5h1SEWxIFxYu2
	5tPV6Pu0950nJW325+CTSTOSkRBIb+0H+Xy+5vr/SFmPxEILmIecDziQutmhg9U=
X-Google-Smtp-Source: AGHT+IH13ShZNauuVVcIYxiND28Z8XPM6Izk+d10fAGG2AogDuxMToOZVz94kJMhKf0juB6GPzqEJA==
X-Received: by 2002:a05:6808:2391:b0:3c6:eb0:7471 with SMTP id bp17-20020a056808239100b003c60eb07471mr1208441oib.43.1713925859293;
        Tue, 23 Apr 2024 19:30:59 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id m2-20020a638c02000000b005e857e39b10sm10179385pgd.56.2024.04.23.19.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 19:30:58 -0700 (PDT)
From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@chromium.org,
	linus.walleij@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuxinxiong@huaqin.corp-partner.google.com,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v3 7/7] drm/panel: himax-hx83102: Support for IVO t109nw41 MIPI-DSI panel
Date: Wed, 24 Apr 2024 10:30:10 +0800
Message-Id: <20240424023010.2099949-8-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240424023010.2099949-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240424023010.2099949-1-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IVO t109nw41 is a 11.0" WUXGA TFT LCD panel, use hx83102 controller
which fits in nicely with the existing panel-himax-hx83102 driver. Hence,
we add a new compatible with panel specific config.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
Chage since V3:

- inital cmds use lowercasehex.

V2: https://lore.kernel.org/all/20240422090310.3311429-8-yangcong5@huaqin.corp-partner.google.com

---
 drivers/gpu/drm/panel/panel-himax-hx83102.c | 172 ++++++++++++++++++++
 1 file changed, 172 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
index ea433d0c86f9..96c637c7ae2c 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
@@ -24,6 +24,7 @@
 #define HX83102_SETPOWER	0xb1
 #define HX83102_SETDISP		0xb2
 #define HX83102_SETCYC		0xb4
+#define HX83102_UNKNOWN6	0xb6
 #define HX83102_SETEXTC		0xb9
 #define HX83102_SETMIPI		0xba
 #define HX83102_SETVDC		0xbc
@@ -392,6 +393,152 @@ static int boe_nv110wum_init_cmd(struct hx83102 *ctx)
 	return 0;
 };
 
+static int ivo_t109nw41_init_cmd(struct hx83102 *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+
+	msleep(60);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETEXTC, 0x83, 0x10, 0x21, 0x55, 0x00);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETPOWER, 0x2c, 0xed, 0xed, 0x27, 0xe7, 0x42, 0xf5, 0x39,
+						  0x36, 0x36, 0x36, 0x36, 0x32, 0x8b, 0x11, 0x65, 0x00, 0x88, 0xfa, 0xff,
+						  0xff, 0x8f, 0xff, 0x08, 0xd6, 0x33);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETDISP, 0x00, 0x47, 0xb0, 0x80, 0x00, 0x12, 0x71, 0x3c,
+						  0xa3, 0x22, 0x20, 0x00, 0x00, 0x88, 0x01);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETCYC, 0x35, 0x35, 0x43, 0x43, 0x35, 0x35, 0x30, 0x7a,
+						  0x30, 0x7a, 0x01, 0x9d);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_UNKNOWN6, 0x34, 0x34, 0x03);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0xcd);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETMIPI, 0x84);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0x3f);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETVDC, 0x1b, 0x04);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_UNKNOWN1, 0x20);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETPTBA, 0xfc, 0xc4);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSTBA, 0x34, 0x34, 0x22, 0x11, 0x22, 0xa0, 0x31, 0x08,
+						  0xf5, 0x03);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0xcc);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETTCON, 0x80);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0x3f);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0xc6);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETRAMDMY, 0x97);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0x3f);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETPWM, 0x00, 0x1e, 0x13, 0x88, 0x01);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETCLOCK, 0x08, 0x13, 0x07, 0x00, 0x0f, 0x34);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETPANEL, 0x02, 0x03, 0x44);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0xc4);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETCASCADE, 0x03);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0x3f);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETPCTRL, 0x07, 0x06, 0x00, 0x02, 0x04, 0x2c, 0xff);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETGIP0, 0x06, 0x00, 0x00, 0x00, 0x00, 0x08, 0x08, 0x08,
+						  0x08, 0x37, 0x07, 0x64, 0x7c, 0x11, 0x11, 0x03, 0x03, 0x32, 0x10, 0x0e,
+						  0x00, 0x0e, 0x32, 0x17, 0x97, 0x07, 0x97, 0x32, 0x00, 0x02, 0x00, 0x02,
+						  0x00, 0x00);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETGIP1, 0x25, 0x24, 0x25, 0x24, 0x18, 0x18, 0x18, 0x18,
+						  0x07, 0x06, 0x07, 0x06, 0x05, 0x04, 0x05, 0x04, 0x03, 0x02, 0x03, 0x02,
+						  0x01, 0x00, 0x01, 0x00, 0xa8, 0xa8, 0xa8, 0xa8, 0x29, 0x29, 0x29, 0x29,
+						  0x21, 0x20, 0x21, 0x20, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETGIP3, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xa0, 0xaa, 0xaa,
+						  0xaa, 0xaa, 0xaa, 0xa0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+						  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+						  0x00, 0x00, 0x00, 0x00);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETTP1, 0x07, 0x10, 0x10, 0x1a, 0x26, 0x9e, 0x00, 0x4f,
+						  0xa0, 0x14, 0x14, 0x00, 0x00, 0x00, 0x00, 0x12, 0x0a, 0x02, 0x02, 0x00,
+						  0x33, 0x02, 0x04, 0x18, 0x01);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETBANK, 0x01);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETPOWER, 0x01, 0x7f, 0x11, 0xfd);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETCLOCK, 0x86);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETGIP3, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+						  0x00, 0x00, 0x00, 0x00, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xa0, 0xaa, 0xaa,
+						  0xaa, 0xaa, 0xaa, 0xa0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+						  0x00, 0x00, 0x00, 0x00);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETTP1, 0x02, 0x00, 0x2b, 0x01, 0x7e, 0x0f, 0x7e, 0x10,
+						  0xa0, 0x00, 0x00, 0x77, 0x00, 0x00, 0x00);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETBANK, 0x02);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETPTBA, 0xf2);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETCLOCK, 0x03, 0x07, 0x00, 0x10, 0x79);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETGIP3, 0xff, 0xff, 0xff, 0xff, 0xfa, 0xa0,
+						  0xff, 0xff, 0xff, 0xff, 0xfa, 0xa0);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETTP1, 0xfe, 0x01, 0xfe, 0x01, 0xfe, 0x01, 0x00, 0x00,
+						  0x00, 0x23, 0x00, 0x23, 0x81, 0x02, 0x40, 0x00, 0x20, 0x6e, 0x02, 0x01,
+						  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETBANK, 0x03);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xa0, 0xaa, 0xaa,
+						  0xaa, 0xaa, 0xaa, 0xa0, 0xff, 0xff, 0xff, 0xff, 0xfa, 0xa0, 0xff, 0xff,
+						  0xff, 0xff, 0xfa, 0xa0, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xa0, 0xaa, 0xaa,
+						  0xaa, 0xaa, 0xaa, 0xa0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+						  0x00, 0x00, 0x00, 0x00);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0xc6);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETCYC, 0x03, 0xff, 0xf8);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0x3f);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_UNKNOWN5, 0x00);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETBANK, 0x00);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0xc4);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETMIPI, 0x96);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0x3f);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETBANK, 0x01);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0xc5);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETMIPI, 0x4f);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0x3f);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETBANK, 0x00);
+
+	msleep(60);
+
+	return 0;
+};
+
 static const struct drm_display_mode starry_mode = {
 	.clock = 162680,
 	.hdisplay = 1200,
@@ -436,6 +583,28 @@ static const struct hx83102_panel_desc boe_nv110wum_desc = {
 	.init_cmds = boe_nv110wum_init_cmd,
 };
 
+static const struct drm_display_mode ivo_t109nw41_default_mode = {
+	.clock = 166400,
+	.hdisplay = 1200,
+	.hsync_start = 1200 + 75,
+	.hsync_end = 1200 + 75 + 20,
+	.htotal = 1200 + 75 + 20 + 55,
+	.vdisplay = 1920,
+	.vsync_start = 1920 + 115,
+	.vsync_end = 1920 + 115 + 8,
+	.vtotal = 1920 + 115 + 8 + 12,
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static const struct hx83102_panel_desc ivo_t109nw41_desc = {
+	.modes = &ivo_t109nw41_default_mode,
+	.size = {
+		.width_mm = 147,
+		.height_mm = 235,
+	},
+	.init_cmds = ivo_t109nw41_init_cmd,
+};
+
 static int hx83102_enable(struct drm_panel *panel)
 {
 	struct hx83102 *ctx = panel_to_hx83102(panel);
@@ -695,6 +864,9 @@ static const struct of_device_id hx83102_of_match[] = {
 	{ .compatible = "boe,nv110wum-l60",
 	  .data = &boe_nv110wum_desc
 	},
+	{ .compatible = "ivo,t109nw41",
+	  .data = &ivo_t109nw41_desc
+	},
 	{ .compatible = "starry,himax83102-j02",
 	  .data = &starry_desc
 	},
-- 
2.25.1


