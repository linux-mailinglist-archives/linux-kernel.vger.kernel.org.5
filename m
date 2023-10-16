Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B797CB10B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbjJPQ5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 12:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbjJPQ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 12:56:40 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF2D1B9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 09:54:05 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40535597f01so46839505e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 09:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697475243; x=1698080043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLZfAioiQyP2GbHH4z94Kghh0UWm5WmSuFGJ712+5P8=;
        b=RxRgZE4sYeb4tEM3rATm0bRYUOboqRumrEcw4trJcYFi3YrOR3oQqnaVa0OxB0ijsx
         0tKalTxlUAJwmw7+fWn6CqaZgnqtNfrpzyvmBiUqoMJ0zwvWcYw6g/Eng40gFTeRlEkp
         k3UNixOoWJVVjn/VkT3uz/4is9q4kBPbH+YksrTlCmjSh2em9ILiNRhmDiZ7QaNGjM9c
         iN9dlp39s3sji4zgMHnsLdSTTuvd/Yb0YUeDaMaQosJ+cBmnteq80XnabYt9uHiEwyFx
         qC5ISusovdfMfs9pAfUSJBpPcT68Rz8Zg3MZRNIRl5aR5RsQiRM3pCBzn9iWlb9kwwpz
         Ghsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697475243; x=1698080043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLZfAioiQyP2GbHH4z94Kghh0UWm5WmSuFGJ712+5P8=;
        b=sJxLeidItU+92BezJVar3IYpVMMIAq22mPH5PYkufsdmi8vln6TIXNyLELJWdNtTs8
         24rXdChca5M3ug2h8t44WeiaeUe8sAhSNJqkZOjmZMj9D0YPg7O/AXeTucAzHW2rhfHv
         KquibUEQlYaK2ExVHlk3it+yqmrM9Yy22TM6GENWcBuS5g0noGbcUU62SxFx0wIic3dp
         4SJVXpWpHV98JrAxAabG4f2BM+wMuCWNjlzVUBIvU82J7+TXx+Ayt/NI6TxhwAtimEhG
         IcP9DdH3UzCcYS8wEobstmPGZoUw2GCUySv4wX2MscOIeW5ZzWANWmdC1e2astDlBZUR
         nPRQ==
X-Gm-Message-State: AOJu0YxyKAdBKCK6nkS/jMv5CI5uq1e2Nb4OGP4Qjiy9bExrA6eLrNlk
        MSBhtLttNN4eNU+rcVGlq//FGg==
X-Google-Smtp-Source: AGHT+IEBvJ0AZHZOH5C1QXJLEQY2GElyolulqaAir+SIzHoMEpjQbAyxb+WOdlGZX6IRMJmT8vnGLw==
X-Received: by 2002:a05:600c:2242:b0:401:be70:53b6 with SMTP id a2-20020a05600c224200b00401be7053b6mr30210769wmm.15.1697475243658;
        Mon, 16 Oct 2023 09:54:03 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([45.84.211.189])
        by smtp.gmail.com with ESMTPSA id s19-20020a05600c45d300b0040648217f4fsm7638996wmo.39.2023.10.16.09.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:54:03 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Marek Vasut <marex@denx.de>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org
Subject: [RFC PATCH 03/10] drm/mipi-dsi: add API for manual control over the DSI link power state
Date:   Mon, 16 Oct 2023 19:53:48 +0300
Message-ID: <20231016165355.1327217-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016165355.1327217-1-dmitry.baryshkov@linaro.org>
References: <20231016165355.1327217-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DSI links do not fully fall into the DRM callbacks model. The
drm_bridge_funcs abstraction. Instead of having just two states (off and
on) the DSI hosts have separate LP-11 state. In this state the host is
on, but the video stream is not yet enabled.

Introduce API that allows DSI bridges / panels to control the DSI host
power up state.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 31 +++++++++++++++++++++++++++++++
 include/drm/drm_mipi_dsi.h     | 29 +++++++++++++++++++++++++----
 2 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 14201f73aab1..c467162cb7d8 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -428,6 +428,37 @@ int devm_mipi_dsi_attach(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_mipi_dsi_attach);
 
+bool mipi_dsi_host_power_control_available(struct mipi_dsi_host *host)
+{
+	const struct mipi_dsi_host_ops *ops = host->ops;
+
+	return ops && ops->power_up;
+}
+EXPORT_SYMBOL_GPL(mipi_dsi_host_power_control_available);
+
+int mipi_dsi_host_power_up(struct mipi_dsi_host *host)
+{
+	const struct mipi_dsi_host_ops *ops = host->ops;
+
+	if (!mipi_dsi_host_power_control_available(host))
+		return -EOPNOTSUPP;
+
+	return ops->power_up ? ops->power_up(host) : 0;
+}
+EXPORT_SYMBOL_GPL(mipi_dsi_host_power_up);
+
+void mipi_dsi_host_power_down(struct mipi_dsi_host *host)
+{
+	const struct mipi_dsi_host_ops *ops = host->ops;
+
+	if (!mipi_dsi_host_power_control_available(host))
+		return;
+
+	if (ops->power_down)
+		ops->power_down(host);
+}
+EXPORT_SYMBOL_GPL(mipi_dsi_host_power_down);
+
 static ssize_t mipi_dsi_device_transfer(struct mipi_dsi_device *dsi,
 					struct mipi_dsi_msg *msg)
 {
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 167742e579e3..e503c3e4d057 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -68,6 +68,8 @@ int mipi_dsi_create_packet(struct mipi_dsi_packet *packet,
  * @attach: attach DSI device to DSI host
  * @detach: detach DSI device from DSI host
  * @transfer: transmit a DSI packet
+ * @power_up: enable DSI link and bring it to the LP-11 state
+ * @power_down: fully disable DSI link
  *
  * DSI packets transmitted by .transfer() are passed in as mipi_dsi_msg
  * structures. This structure contains information about the type of packet
@@ -81,10 +83,18 @@ int mipi_dsi_create_packet(struct mipi_dsi_packet *packet,
  * function will seldomly return anything other than the number of bytes
  * contained in the transmit buffer on success.
  *
- * Also note that those callbacks can be called no matter the state the
- * host is in. Drivers that need the underlying device to be powered to
- * perform these operations will first need to make sure it's been
- * properly enabled.
+ * Note: currently there are two modes of DSI power control. Legacy drivers
+ * will call those callbacks no matter the state the host is in. DSI host
+ * drivers that need the underlying device to be powered to perform these
+ * operations will first need to make sure it's been properly enabled.
+ *
+ * Newer drivers will set the @MIPI_DSI_MANUAL_POWERUP flag to indicate that
+ * they will call @mipi_dsi_power_up() and @mipi_dsi_power_down() to control
+ * the link state of the DSI host or they will set @MIPI_DSI_AUTO_POWERUP to
+ * indicate that the driver is fine with the link being powered up in DSI
+ * host's (atomic_)pre_enable() callback and then being disabled in the
+ * (atomic_)post_disable() callback. The transfer callback must only be called
+ * if the DSI host has been powered up and was not brought down.
  *
  * Note: some hosts (sunxi) can not send LP commands between HS video
  * packets. Thus all DSI transfers sent in LP mode should be limited to the
@@ -97,6 +107,8 @@ struct mipi_dsi_host_ops {
 		      struct mipi_dsi_device *dsi);
 	ssize_t (*transfer)(struct mipi_dsi_host *host,
 			    const struct mipi_dsi_msg *msg);
+	int (*power_up)(struct mipi_dsi_host *host);
+	void (*power_down)(struct mipi_dsi_host *host);
 };
 
 /**
@@ -143,6 +155,10 @@ struct mipi_dsi_host *of_find_mipi_dsi_host_by_node(struct device_node *node);
 #define MIPI_DSI_MODE_LPM		BIT(11)
 /* transmit data ending at the same time for all lanes within one hsync */
 #define MIPI_DSI_HS_PKT_END_ALIGNED	BIT(12)
+/* DSI peripheral driver manually controls DSI link powerup */
+#define MIPI_DSI_MANUAL_POWERUP		BIT(13)
+/* DSI peripheral driver is fine with automatic DSI link power control */
+#define MIPI_DSI_AUTO_POWERUP		BIT(14)
 
 enum mipi_dsi_pixel_format {
 	MIPI_DSI_FMT_RGB888,
@@ -235,6 +251,11 @@ void mipi_dsi_device_unregister(struct mipi_dsi_device *dsi);
 struct mipi_dsi_device *
 devm_mipi_dsi_device_register_full(struct device *dev, struct mipi_dsi_host *host,
 				   const struct mipi_dsi_device_info *info);
+
+bool mipi_dsi_host_power_control_available(struct mipi_dsi_host *host);
+int mipi_dsi_host_power_up(struct mipi_dsi_host *host);
+void mipi_dsi_host_power_down(struct mipi_dsi_host *host);
+
 struct mipi_dsi_device *of_find_mipi_dsi_device_by_node(struct device_node *np);
 int mipi_dsi_attach(struct mipi_dsi_device *dsi);
 int mipi_dsi_detach(struct mipi_dsi_device *dsi);
-- 
2.42.0

