Return-Path: <linux-kernel+bounces-153049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 851BA8AC859
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AFF2280CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D542913B791;
	Mon, 22 Apr 2024 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="X7XjKlbu"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1EE14198A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776653; cv=none; b=pjBA14ScnPBSanRHbTUnUfgJpKymsyTnb6GD5YDK9uR/USI4CKYpkI2wNSDUmmiExLtD4/gW7s9TvzLnQD2J4f/XuqEpFC0/R7FOQrAGAv9ApfUAknA85pfNp1QkzcFitAMRLYq3w0v9k+1qZYQuCvMADjOo3Gb532lmlUjH0Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776653; c=relaxed/simple;
	bh=bv5VA3YFx3oPBTtJPxB4RuMi+m1aIeKYN6Arjuk14mE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sDtvWOgAdiVh8p6/r4AnW01bicfvVzjiuTuEh2Slk0XdkMxKu4kjxFQKI9gAih2HIha7LqApmG76dx4IuSvZHQ3+JYy1t5d+Cm0EtiqoXjyEGuJaMaldsFzfDSILaf0WI7U0nKcg927vQQQyIp4TEzH+tDy/14o6vZMBMNCoUoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=X7XjKlbu; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2395e037342so1594147fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 02:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1713776636; x=1714381436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1iOsAYiCfutlrPJv8SC2TZcpNGu138N+1rppXMW9XM=;
        b=X7XjKlbu2ovfDmADOdytVdybzy2ICX76oG/N5pY/uJqRwPYkVbOJsXzRxqmDuwtPZv
         1jhiqqshYHaYLN4WlUORW2XMsi1cNj6eUaBDHtX6WRnmtQhml62DlPm69QiCCbF70la3
         g22Fb9zJxGlL+GQ57ScbxbZY+QvQrExQJpjSjUBVygf4vyvRcqHcLm4vzGBQG1OeyJVr
         SGCODVqKuSYt6azuMqHEsPLCHiX5trqZtaoO2d2aUc2TALaT/7g59wYWOJE/JLF18fu6
         gjuspWq2uekBhG+SvLyGeARZqFB457kwkjYw63CtM39BTxQuTI8qzHxUWfQQc5LibyKS
         d2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713776636; x=1714381436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1iOsAYiCfutlrPJv8SC2TZcpNGu138N+1rppXMW9XM=;
        b=dadMbUTSkoHAapCO7gDBOhgmG/9ATkyaymgvLcEMidG+jf8/B+W7QAkzbF/OtaX8zN
         TRUCjayoUo+50iRb+sRmIsd1J8j4j5gpyfHkc3S9PwsMbhBQeERZmPahkMV7RjG6i4TD
         6oHiL3pZMnC0/U8qUsooqXhz3lkVfxvorsighrHegLlGLGn5yofg1+x/vlvdqm3FrzhL
         3T/2C3z6pbjyTOqBBjL50/XoNUL5TcVBEtvv0DtBFDgoMM2yojX33yp8/C9QZjuhnzvp
         XJZ2n9J2I/tW6HG6ezOSFsVvlg41m9MLqx69NHya2N3k+VeoC42JifUfy3lOGtpqiUw2
         iVQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2PZn7saUzTkbhFUbxearjgCAsVLjOSCsniFcrP0W8fCitwTbIAk5LbVTp/LgK63uQsyE3bjC93/6NZQV0DWSqWdSMbGJapORqU2pX
X-Gm-Message-State: AOJu0YxHg0mqKFQEXFyAgIAHGttTlBFfTP/mlIDyip8X9lGYXYwAoAbY
	6zgwlBs4zHUucPros4lHGe+PGyiDatKUDmqeWFlrTxASRFhBcwY5oFf2829XIQE=
X-Google-Smtp-Source: AGHT+IEaiQYP/KCYuI9CEUWUt/o7raG5CR1YU5Wdx2qsjoQUQGLPQpfFGt9Hb4m/Tvf1FuiO3Zy/nw==
X-Received: by 2002:a05:6871:742a:b0:22e:8576:bcd8 with SMTP id nw42-20020a056871742a00b0022e8576bcd8mr11458913oac.42.1713776636107;
        Mon, 22 Apr 2024 02:03:56 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id by42-20020a056a0205aa00b005fdd11c0874sm1919137pgb.64.2024.04.22.02.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 02:03:55 -0700 (PDT)
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
Subject: [PATCH v2 7/7] drm/panel: himax-hx83102: Support for IVO t109nw41 MIPI-DSI panel
Date: Mon, 22 Apr 2024 17:03:10 +0800
Message-Id: <20240422090310.3311429-8-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240422090310.3311429-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240422090310.3311429-1-yangcong5@huaqin.corp-partner.google.com>
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
 drivers/gpu/drm/panel/panel-himax-hx83102.c | 178 ++++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
index 963438a2b245..0aef1cc80dea 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
@@ -26,6 +26,7 @@
 #define HX83102_SETPOWER	0xb1
 #define HX83102_SETDISP		0xb2
 #define HX83102_SETCYC		0xb4
+#define HX83102_UNKNOWN6	0xb6
 #define HX83102_SETEXTC		0xb9
 #define HX83102_SETMIPI		0xba
 #define HX83102_SETVDC		0xbc
@@ -401,6 +402,152 @@ static int boe_nv110wum_init_cmd(struct hx83102 *ctx)
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
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETPOWER, 0x2C, 0xED, 0xED, 0x27, 0xE7, 0x42, 0xF5, 0x39,
+						  0x36, 0x36, 0x36, 0x36, 0x32, 0x8B, 0x11, 0x65, 0x00, 0x88, 0xFA, 0xFF,
+						  0xFF, 0x8F, 0xFF, 0x08, 0xD6, 0x33);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETDISP, 0x00, 0x47, 0xB0, 0x80, 0x00, 0x12, 0x71, 0x3C,
+						  0xA3, 0x22, 0x20, 0x00, 0x00, 0x88, 0x01);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETCYC, 0x35, 0x35, 0x43, 0x43, 0x35, 0x35, 0x30, 0x7A,
+						  0x30, 0x7A, 0x01, 0x9D);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_UNKNOWN6, 0x34, 0x34, 0x03);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0xCD);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETMIPI, 0x84);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0x3F);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETVDC, 0x1B, 0x04);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_UNKNOWN1, 0x20);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETPTBA, 0xFC, 0xC4);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSTBA, 0x34, 0x34, 0x22, 0x11, 0x22, 0xA0, 0x31, 0x08,
+						  0xF5, 0x03);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0xCC);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETTCON, 0x80);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0x3F);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0xC6);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETRAMDMY, 0x97);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0x3F);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETPWM, 0x00, 0x1E, 0x13, 0x88, 0x01);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETCLOCK, 0x08, 0x13, 0x07, 0x00, 0x0F, 0x34);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETPANEL, 0x02, 0x03, 0x44);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0xC4);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETCASCADE, 0x03);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0x3F);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETPCTRL, 0x07, 0x06, 0x00, 0x02, 0x04, 0x2C, 0xFF);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETGIP0, 0x06, 0x00, 0x00, 0x00, 0x00, 0x08, 0x08, 0x08,
+						  0x08, 0x37, 0x07, 0x64, 0x7C, 0x11, 0x11, 0x03, 0x03, 0x32, 0x10, 0x0E,
+						  0x00, 0x0E, 0x32, 0x17, 0x97, 0x07, 0x97, 0x32, 0x00, 0x02, 0x00, 0x02,
+						  0x00, 0x00);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETGIP1, 0x25, 0x24, 0x25, 0x24, 0x18, 0x18, 0x18, 0x18,
+						  0x07, 0x06, 0x07, 0x06, 0x05, 0x04, 0x05, 0x04, 0x03, 0x02, 0x03, 0x02,
+						  0x01, 0x00, 0x01, 0x00, 0xA8, 0xA8, 0xA8, 0xA8, 0x29, 0x29, 0x29, 0x29,
+						  0x21, 0x20, 0x21, 0x20, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETGIP3, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xA0, 0xAA, 0xAA,
+						  0xAA, 0xAA, 0xAA, 0xA0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+						  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+						  0x00, 0x00, 0x00, 0x00);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETTP1, 0x07, 0x10, 0x10, 0x1A, 0x26, 0x9E, 0x00, 0x4F,
+						  0xA0, 0x14, 0x14, 0x00, 0x00, 0x00, 0x00, 0x12, 0x0A, 0x02, 0x02, 0x00,
+						  0x33, 0x02, 0x04, 0x18, 0x01);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETBANK, 0x01);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETPOWER, 0x01, 0x7F, 0x11, 0xFD);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETCLOCK, 0x86);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETGIP3, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+						  0x00, 0x00, 0x00, 0x00, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xA0, 0xAA, 0xAA,
+						  0xAA, 0xAA, 0xAA, 0xA0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+						  0x00, 0x00, 0x00, 0x00);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETTP1, 0x02, 0x00, 0x2B, 0x01, 0x7E, 0x0F, 0x7E, 0x10,
+						  0xA0, 0x00, 0x00, 0x77, 0x00, 0x00, 0x00);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETBANK, 0x02);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETPTBA, 0xF2);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETCLOCK, 0x03, 0x07, 0x00, 0x10, 0x79);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETGIP3, 0xFF, 0xFF, 0xFF, 0xFF, 0xFA, 0xA0,
+						  0xFF, 0xFF, 0xFF, 0xFF, 0xFA, 0xA0);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETTP1, 0xFE, 0x01, 0xFE, 0x01, 0xFE, 0x01, 0x00, 0x00,
+						  0x00, 0x23, 0x00, 0x23, 0x81, 0x02, 0x40, 0x00, 0x20, 0x6E, 0x02, 0x01,
+						  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETBANK, 0x03);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xA0, 0xAA, 0xAA,
+						  0xAA, 0xAA, 0xAA, 0xA0, 0xFF, 0xFF, 0xFF, 0xFF, 0xFA, 0xA0, 0xFF, 0xFF,
+						  0xFF, 0xFF, 0xFA, 0xA0, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xA0, 0xAA, 0xAA,
+						  0xAA, 0xAA, 0xAA, 0xA0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+						  0x00, 0x00, 0x00, 0x00);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0xC6);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETCYC, 0x03, 0xFF, 0xF8);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0x3F);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_UNKNOWN5, 0x00);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETBANK, 0x00);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0xC4);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETMIPI, 0x96);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0x3F);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETBANK, 0x01);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0xC5);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETMIPI, 0x4F);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0x3F);
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
@@ -457,6 +604,34 @@ static const struct hx83102_panel_desc boe_nv110wum_desc = {
 	.lp11_before_reset = true
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
+	.bpc = 8,
+	.size = {
+		.width_mm = 147,
+		.height_mm = 235,
+	},
+	.lanes = 4,
+	.format = MIPI_DSI_FMT_RGB888,
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+		      MIPI_DSI_MODE_LPM,
+	.init_cmds = ivo_t109nw41_init_cmd,
+	.lp11_before_reset = true
+};
+
 static int hx83102_enable(struct drm_panel *panel)
 {
 	struct hx83102 *ctx = panel_to_hx83102(panel);
@@ -743,6 +918,9 @@ static const struct of_device_id hx83102_of_match[] = {
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


