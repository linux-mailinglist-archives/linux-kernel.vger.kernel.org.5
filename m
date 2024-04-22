Return-Path: <linux-kernel+bounces-153047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 751798AC857
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C331280D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09A013BAD0;
	Mon, 22 Apr 2024 09:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="XOhNAGXV"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DE913E039
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776636; cv=none; b=WHpq86AezGJM3qJqXFdap4oMNDMwwJ+VDqrygwAyojPfMVEzCA5mplpsdjgTtnoapCE5qgkuL5OcdxDA9wSIsICjhvm0XhAY2c2xwpc2NM6z4uBi7j9fhO/KBJyHHsm1TPEV4dkFyuI5XyCYNSvLIiZttK9XkTpviJTAcy2Iv0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776636; c=relaxed/simple;
	bh=tBV+wDIErvNPrkOxzoXMbiKYUNv1z+Gqvi0+amAcPyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qFqtFmsPc1mxm4rppIxRWTv/CmjMNmYxFpwhZAXYSiBQlmtFW0K6NQUBH0tngThI9yszmEYaylL1JFKBP2dLiIxyCFFfbCNT5HMZVblGAZgcnrSgOzIh/pm+n0FehE3rREL1chUuuLWZfdNJBfwbQUe7N94xxi5dQbQQwQi5cwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=XOhNAGXV; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f0aeee172dso2032998b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 02:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1713776625; x=1714381425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoBdjuXWDUuJ+jSHXmVgfP2cSXSbnwpnE6WVyHmN2Ck=;
        b=XOhNAGXV+Scj+EDo5B4pRwvuv163A/fgz9dcv/a8yT/vCefDxvMYN0W0DBJmGrp5+s
         iuEIkpFDoDPNd44MOp9GuTz6WyBKQehKucTjhnvfQcbh+FXX6sWgMQXoRevmQfYRYccI
         lFc8+P3o2jl6F8WdLaKUHHu05ehJfd2Pmyr4RwKInI6Tqr/qJA/piwq0ykhM9k852huj
         3zEzYt341MhPrlH5VaZgw5zPCza9+YLYIk/NF+GaMhmq90V5MihUaalFlYdm33QJOr/k
         I8qZ72vPxQCBhiuLX0SRrZACM5pspMQNdTV64npm7WpFklpWLHuriG0B7PRqFt6V+ar5
         vL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713776625; x=1714381425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MoBdjuXWDUuJ+jSHXmVgfP2cSXSbnwpnE6WVyHmN2Ck=;
        b=SsAj1rcW1mXsm5Y0GH4sxI/hpkn8KxUy+CZ0isrJM1HNHyIRTwQeQ1Oj9qBkZpAq9F
         CuQq5xZjWmFfAYZA1xbDMhh5gHnc3Z5yKrucK13Gk/6Blan5SVHJ/z4ZuJuDC2I6mTwW
         xum5UESy+PSyMU0Y28UnoRsomBUw2SKWCrH8LIiMf6Dr0SQwbIly4uNJ2arYgX9l7wV5
         msbzKkMpu32LHXd1p0TMYXVIyOUzJMpoBO383Xh5JtbCbJXCw+29xeDktTNiG4pljhsY
         al/gp3SdUxB/ZNLT4V8sb0qy0SKuywCGV5d+936Qj/53cfWKA5vOAueta/PvyxkncH2j
         a+6g==
X-Forwarded-Encrypted: i=1; AJvYcCWGXBzRxVwIwNiLXxOG8UBeEdBqI+LIo6qVNu+FKe4M52nrGhK5kJ3QI06CxKWU5kl0K4zp4ttgyOdtj2QLkAkV73HRaHUx6fH3aIX0
X-Gm-Message-State: AOJu0Yy4AA0MTfY+6wxdc5F7XKl+3N/ABYsgUTG6JJ/kJsAE0SARnwJc
	CFMLQJMaj51Jd4IXXzf0g43MQLnskkQc3O4qAU+c2QFCvnN4yUAOqB/kElERBos=
X-Google-Smtp-Source: AGHT+IHtXUIw4DQodd3k75YlM9IE/Uk+dPLH3dhn58MwvKF1de+VA6pYiKx6zsGe2E8F6vddldxFQg==
X-Received: by 2002:a05:6a21:168b:b0:1a3:bd97:4cab with SMTP id np11-20020a056a21168b00b001a3bd974cabmr18567528pzb.6.1713776625538;
        Mon, 22 Apr 2024 02:03:45 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id by42-20020a056a0205aa00b005fdd11c0874sm1919137pgb.64.2024.04.22.02.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 02:03:45 -0700 (PDT)
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
Subject: [PATCH v2 5/7] drm/panel: himax-hx83102: Support for BOE nv110wum-l60 MIPI-DSI panel
Date: Mon, 22 Apr 2024 17:03:08 +0800
Message-Id: <20240422090310.3311429-6-yangcong5@huaqin.corp-partner.google.com>
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

The BOE nv110wum-l60 is a 11.0" WUXGA TFT LCD panel, use hx83102 controller
which fits in nicely with the existing panel-himax-hx83102 driver. Hence,
we add a new compatible with panel specific config.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-himax-hx83102.c | 198 ++++++++++++++++++++
 1 file changed, 198 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
index ac8329f89195..963438a2b245 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
@@ -46,6 +46,7 @@
 #define HX83102_UNKNOWN3	0xd6
 #define HX83102_SETGIP3		0xd8
 #define HX83102_UNKNOWN4	0xe0
+#define HX83102_UNKNOWN5	0xe1
 #define HX83102_SETTP1		0xe7
 #define HX83102_SETSPCCMD	0xe9
 
@@ -234,6 +235,172 @@ static int starry_init_cmd(struct hx83102 *ctx)
 	return 0;
 };
 
+static int boe_nv110wum_init_cmd(struct hx83102 *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+
+	msleep(60);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETEXTC, 0x83, 0x10, 0x21, 0x55, 0x00);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETPOWER, 0x2C, 0xAF, 0xAF, 0x2B, 0xEB, 0x42, 0xE1, 0x4D,
+						  0x36, 0x36, 0x36, 0x36, 0x1A, 0x8B, 0x11, 0x65, 0x00, 0x88, 0xFA, 0xFF,
+						  0xFF, 0x8F, 0xFF, 0x08, 0x9A, 0x33);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETDISP, 0x00, 0x47, 0xB0, 0x80, 0x00, 0x12, 0x71, 0x3C,
+						  0xA3, 0x11, 0x00, 0x00, 0x00, 0x88, 0xF5, 0x22, 0x8F);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETCYC, 0x49, 0x49, 0x32, 0x32, 0x14, 0x32, 0x84, 0x6E,
+						  0x84, 0x6E, 0x01, 0x9C);
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
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETPTBA, 0xFC, 0x84);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSTBA, 0x36, 0x36, 0x22, 0x00, 0x00, 0xA0, 0x61, 0x08,
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
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETPWM, 0x00, 0x1E, 0x30, 0xD4, 0x01);
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
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETPCTRL, 0x37, 0x06, 0x00, 0x02, 0x04, 0x0C, 0xFF);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_UNKNOWN2, 0x1F, 0x11, 0x1F, 0x11);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETGIP0, 0x06, 0x00, 0x00, 0x00, 0x00, 0x04, 0x08, 0x04,
+						  0x08, 0x37, 0x37, 0x64, 0x4B, 0x11, 0x11, 0x03, 0x03, 0x32, 0x10, 0x0E,
+						  0x00, 0x0E, 0x32, 0x10, 0x0A, 0x00, 0x0A, 0x32, 0x17, 0x98, 0x07, 0x98,
+						  0x00, 0x00);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETGIP1, 0x18, 0x18, 0x18, 0x18, 0x1E, 0x1E, 0x1E, 0x1E,
+						  0x1F, 0x1F, 0x1F, 0x1F, 0x24, 0x24, 0x24, 0x24, 0x07, 0x06, 0x07, 0x06,
+						  0x05, 0x04, 0x05, 0x04, 0x03, 0x02, 0x03, 0x02, 0x01, 0x00, 0x01, 0x00,
+						  0x21, 0x20, 0x21, 0x20, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETGIP3, 0xAF, 0xAA, 0xAA, 0xAA, 0xAA, 0xA0, 0xAF, 0xAA,
+						  0xAA, 0xAA, 0xAA, 0xA0);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_UNKNOWN4, 0x00, 0x05, 0x0D, 0x14, 0x1B, 0x2C, 0x44, 0x49,
+						  0x51, 0x4C, 0x67, 0x6C, 0x71, 0x80, 0x7D, 0x84, 0x8D, 0xA0, 0xA0, 0x4F,
+						  0x58, 0x64, 0x73, 0x00, 0x05, 0x0D, 0x14, 0x1B, 0x2C, 0x44, 0x49, 0x51,
+						  0x4C, 0x67, 0x6C, 0x71, 0x80, 0x7D, 0x84, 0x8D, 0xA0, 0xA0, 0x4F, 0x58,
+						  0x64, 0x73);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETTP1, 0x07, 0x10, 0x10, 0x1A, 0x26, 0x9E, 0x00, 0x53,
+						  0x9B, 0x14, 0x14);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_UNKNOWN5, 0x11, 0x00, 0x00, 0x89, 0x30, 0x80, 0x07, 0x80,
+						  0x02, 0x58, 0x00, 0x14, 0x02, 0x58, 0x02, 0x58, 0x02, 0x00, 0x02, 0x2C,
+						  0x00, 0x20, 0x02, 0x02, 0x00, 0x08, 0x00, 0x0C, 0x05, 0x0E, 0x04, 0x94,
+						  0x18, 0x00, 0x10, 0xF0, 0x03, 0x0C, 0x20, 0x00, 0x06, 0x0B, 0x0B, 0x33,
+						  0x0E);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETBANK, 0x01);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETGIP3, 0xFF, 0xFF, 0xFF, 0xFF, 0xFA, 0xA0, 0xFF, 0xFF,
+						  0xFF, 0xFF, 0xFA, 0xA0);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETPOWER, 0x01, 0xBF, 0x11);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETCLOCK, 0x86);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_UNKNOWN2, 0x96);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0xC9);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETGIP0, 0x84);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0x3F);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0xD1);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_UNKNOWN5, 0xF6, 0x2B, 0x34, 0x2B, 0x74, 0x3B, 0x74, 0x6B,
+						  0x74);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETSPCCMD, 0x3F);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETTP1, 0x02, 0x00, 0x2B, 0x01, 0x7E, 0x0F, 0x7E, 0x10,
+						  0xA0, 0x00, 0x00);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETBANK, 0x02);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETCYC, 0x02, 0x00, 0xBB, 0x11);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETGIP3, 0xFF, 0xAF, 0xFF, 0xFF, 0xFA, 0xA0, 0xFF, 0xAF,
+						  0xFF, 0xFF, 0xFA, 0xA0);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETTP1, 0xFE, 0x01, 0xFE, 0x01, 0xFE, 0x01, 0x00, 0x00,
+						  0x00, 0x23, 0x00, 0x23, 0x81, 0x02, 0x40, 0x00, 0x20, 0x65, 0x02, 0x01,
+						  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETBANK, 0x03);
+
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETGIP3, 0xAA, 0xAF, 0xAA, 0xAA, 0xA0, 0x00, 0xAA, 0xAF,
+						  0xAA, 0xAA, 0xA0, 0x00, 0xAA, 0xAF, 0xAA, 0xAA, 0xA0, 0x00, 0xAA, 0xAF,
+						  0xAA, 0xAA, 0xA0, 0x00);
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
+	mipi_dsi_dcs_write_seq(dsi, HX83102_SETEXTC, 0x00, 0x00, 0x00);
+
+	msleep(50);
+
+	return 0;
+};
+
 static const struct drm_display_mode starry_mode = {
 	.clock = 162680,
 	.hdisplay = 1200,
@@ -262,6 +429,34 @@ static const struct hx83102_panel_desc starry_desc = {
 	.lp11_before_reset = true,
 };
 
+static const struct drm_display_mode boe_tv110wum_default_mode = {
+	.clock = 166400,
+	.hdisplay = 1200,
+	.hsync_start = 1200 + 65,
+	.hsync_end = 1200 + 65 + 20,
+	.htotal = 1200 + 60 + 20 + 65,
+	.vdisplay = 1920,
+	.vsync_start = 1920 + 115,
+	.vsync_end = 1920 + 115 + 8,
+	.vtotal = 1920 + 115 + 8 + 12,
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static const struct hx83102_panel_desc boe_nv110wum_desc = {
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
+	.lp11_before_reset = true
+};
+
 static int hx83102_enable(struct drm_panel *panel)
 {
 	struct hx83102 *ctx = panel_to_hx83102(panel);
@@ -545,6 +740,9 @@ static void hx83102_remove(struct mipi_dsi_device *dsi)
 }
 
 static const struct of_device_id hx83102_of_match[] = {
+	{ .compatible = "boe,nv110wum-l60",
+	  .data = &boe_nv110wum_desc
+	},
 	{ .compatible = "starry,himax83102-j02",
 	  .data = &starry_desc
 	},
-- 
2.25.1


