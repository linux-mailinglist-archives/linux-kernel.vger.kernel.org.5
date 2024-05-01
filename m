Return-Path: <linux-kernel+bounces-165506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25408B8D65
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F312D1C20F42
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F68130A65;
	Wed,  1 May 2024 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GO5DabV3"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA841304A8
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714578207; cv=none; b=LALpdTdhtoYR8P8gc/Re5I9HMnNXdq4ERTX0j4Ow3MAoESM8BiILZGaUamnh2/ePCvq/BeCwqVfjGpOjgD/BTseeWgOjkQGqKNNNOiygcaSxmvgKpZfriaDEthw6aajkS8DibM1niOxwVoFPdLifI7Uv8h+Rd8WRecsmlxC4EP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714578207; c=relaxed/simple;
	bh=7CRTI9t4x3fYlISzWcIFCn0I2EcOX20dK9nodJ0TiRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPQek9UDGrMH91N9yUDCOnUeaL46DWPLIXBFrBaJNi/ovnRH1MJIkHAorZPKjy8qXIQRY6zt29htAXEs0mAx++Ei1d4ed/ENLWHFXxeDyt8QF2v1oeoWvhLz074Ook6E+OD0e9nHig9S6yRmbl+Upnbz/FghoQEQgq4ikT5DYUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GO5DabV3; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so6915804b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 08:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714578205; x=1715183005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAD627IJLyAwq2+Pm443W8wYZzFiM9UM6KaJFA24npw=;
        b=GO5DabV3UkjvgrROoO4Fuwl5dscxdAsQPe76VwnBm8bCJJP3fRjvtNMKPVx6L3CjhG
         OsD6qIC3mckmkGAy4rcfgWbeUR3AAXhmCb6PuFI5zLp2xTJclBc/vXtn55gW0jBqhzqp
         41l7afGJCknlpvAHn8TAxjT2k+JnIMUuBm8G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714578205; x=1715183005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAD627IJLyAwq2+Pm443W8wYZzFiM9UM6KaJFA24npw=;
        b=vmOBx2sEVq/xCiv41xE4iGz36YxJy36Aidw9HVVJsuRe/41u9LVRiU6XUu6fNW/wjP
         /fi4cRlc3d62WGehNC58VHBPvm00JiX7hMkm8KMnkdxTterpuqL0meiFVo43UUEEMNs/
         jZqHJhTrquIFRPohvZi+wi64rrKXPUFWFkw5lWuIdCoeXN+NKTw0mSZYrVgnbyjd7/2N
         nTWkWYdgtzztSmV0I5mNUDtOrsXke6a3SbNG7SkB+ZEOKtOzZnM31k3gIsjEBc4TxIek
         uKx3BP/8ltPUGSqukdupOCIZGD4GiLB4ZU+MtM29w7Lp4/Rq2aJXwxE2Dph62OYZmm3x
         wNDg==
X-Forwarded-Encrypted: i=1; AJvYcCVNhTxBozUBKcGfpwvIjbJ1x0yUkEwTBcWWPPb6yc9ve/I9il/H89UBNcW/G82c69mH3FkR2xd96xq4Q+RHZueVZRKIB8nsGWBTze7J
X-Gm-Message-State: AOJu0YyqsO+YoYvdF+0rDWsdwmvbtd4ZPzwFLaGZST7WZDozUpG06wVO
	OD0xRgR3A0AnJ72b9K8gaHaTq/qbNI80Z3Ecj1o0HtvVYcP3EzDySZjvGJKpPw==
X-Google-Smtp-Source: AGHT+IHnQJcwW7iSgBS1Mn2cIHPMUqWwr0A7IK4cUZyXisTKMjjwtDQdihxzWoNTTqOFDzU5XwnMpQ==
X-Received: by 2002:a05:6a00:a02:b0:6ea:86f2:24fb with SMTP id p2-20020a056a000a0200b006ea86f224fbmr3949203pfh.25.1714578204875;
        Wed, 01 May 2024 08:43:24 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:e886:8de:19a2:55b0])
        by smtp.gmail.com with ESMTPSA id fb12-20020a056a002d8c00b006f3ec69bc09sm7717924pfb.75.2024.05.01.08.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:43:24 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	Hsin-Yi Wang <hsinyi@google.com>,
	Brian Norris <briannorris@chromium.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Joel Selvaraj <jo@jsfamily.in>,
	lvzhaoxiong@huaqin.corp-partner.google.com,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/9] drm/mipi-dsi: mipi_dsi_*_write functions don't need to ratelimit prints
Date: Wed,  1 May 2024 08:41:06 -0700
Message-ID: <20240501084109.v3.3.I9982cd5d8014de7a4513f5619f66f88da49ce4ec@changeid>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
In-Reply-To: <20240501154251.3302887-1-dianders@chromium.org>
References: <20240501154251.3302887-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We really don't expect these errors to be printed over and over
again. When a driver hits the error it should bail out. Just use a
normal error print.

This gives a nice space savings for users of these functions:

$ scripts/bloat-o-meter \
  .../before/panel-novatek-nt36672e.ko \
  .../after/panel-novatek-nt36672e.ko
add/remove: 0/1 grow/shrink: 0/1 up/down: 0/-16760 (-16760)
Function                                     old     new   delta
nt36672e_1080x2408_60hz_init               17080   10640   -6440
nt36672e_1080x2408_60hz_init._rs           10320       -  -10320
Total: Before=31815, After=15055, chg -52.68%

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- ("mipi_dsi_*_write functions don't need to ratelimit...") moved earlier.

Changes in v2:
- New

 include/drm/drm_mipi_dsi.h | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index e0f56564bf97..67967be48dbd 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -314,17 +314,16 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
  * @dsi: DSI peripheral device
  * @seq: buffer containing the payload
  */
-#define mipi_dsi_generic_write_seq(dsi, seq...)                                 \
-	do {                                                                    \
-		static const u8 d[] = { seq };                                  \
-		struct device *dev = &dsi->dev;                                 \
-		ssize_t ret;                                                    \
-		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));            \
-		if (ret < 0) {                                                  \
-			dev_err_ratelimited(dev, "transmit data failed: %zd\n", \
-					    ret);                               \
-			return ret;                                             \
-		}                                                               \
+#define mipi_dsi_generic_write_seq(dsi, seq...)                           \
+	do {                                                              \
+		static const u8 d[] = { seq };                            \
+		struct device *dev = &dsi->dev;                           \
+		ssize_t ret;                                              \
+		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));      \
+		if (ret < 0) {                                            \
+			dev_err(dev, "transmit data failed: %zd\n", ret); \
+			return ret;                                       \
+		}                                                         \
 	} while (0)
 
 /**
@@ -340,8 +339,7 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
 		ssize_t ret;                                                \
 		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));     \
 		if (ret < 0) {                                              \
-			dev_err_ratelimited(                                \
-				dev, "sending command %#02x failed: %zd\n", \
+			dev_err(dev, "sending command %#02x failed: %zd\n", \
 				cmd, ret);                                  \
 			return ret;                                         \
 		}                                                           \
-- 
2.45.0.rc0.197.gbae5840b3b-goog


