Return-Path: <linux-kernel+bounces-160352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681B38B3C57
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CFAE2876DD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00F615217A;
	Fri, 26 Apr 2024 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="utlDPrwG"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662C5149C64
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147402; cv=none; b=cQWQ9z3WkiJjFaiiovkFon9qTEA57nZmTgv1Dm8PkIbNBJNWeLY/lzVCna8qdoK1ZT6UuWAUEXnvLsLze1txRvpaOQMqS7HQW33068+UfgRCegfIoPHiG8+lOttDgpkLU+zPd5z6a3idhW6sM6dH7SWF+XxRryfSfcBAfIWnTJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147402; c=relaxed/simple;
	bh=UhWU3YDhjhCDZmu7A2apQsuTrQdWtiVU0TH4R8sMQlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcZ/u1YY8GebIFS4Gpeo6u0UOfaS4Zff9tYwEURQw6yOVjBAJFwGXjhDvY9Qod9x5LsgXL3lG3wx3i8i8UkBo8DuS06NgfpJIz9zYAr+h8VYDuCWeC/P3YrAO22fpRNNztrE7mturq0s5YqivrT2EJCeDcCIHlBsk0EBzyXooXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=utlDPrwG; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2db101c11beso25287581fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 09:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714147398; x=1714752198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlYVJCYtRxxPVBcJn9HswhGBQFKRvWfDNGI/lisBMlg=;
        b=utlDPrwGoehqIcAsfph1Y8eWR7W/kNoHH9vXKSlxkxCg173uZASHs+/BoUn2c5tk2p
         xnYJSC53oYxwGM3eciJieoRpmi8I/ro9FUS8gSaBuizOSey4eVKJ6F4JfMHIvDCdiUUs
         zMj/5YpZy12mRxH6vxysuxvT/1pzYUap3EDXxrjwJGwFKYtbOGqXKPbRxM1SSYbhM96f
         nt0i1rEjtNSiVAF1TcTZqmXGMuZ0lHgLka9lRqL17eqKmcTnlfbxApQHGjVKmBqOSGZj
         ITNFnVA4+pNJi9Y2XAEUFbP1NGWY+8gwJS6niw5HZvTTdOc76weu4zDYBnLDUbmK9Yzo
         +Prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714147398; x=1714752198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlYVJCYtRxxPVBcJn9HswhGBQFKRvWfDNGI/lisBMlg=;
        b=hV18L8pIPJfXyCTztqVoMX9lQLPt4W1od9Rbqlkpcck2ebjT9wCiE+DUj2fS2cfcBx
         2PcBV8t6uY8oFQy/6B4+7REmt53BTfkDBLPKAWksj+12exalRihIdIgRMW8E0pqWlkwz
         0+gXY9l7cufb3RIneli3r3rsomxl/lwqooU9MnV4ak9Ylt0XdODArm2Ib4T2Ud3PiluW
         XIV8igf1MydWWkN0naU3EYMT5elgG7DdwFiXTvza72KlmjK8p+82zp+kDyiQcQqq+1lk
         wIfmsOCOzmFuIM2n6o1bC0OFvXY9q3vOqYEq114+KypvJtvoVwcT7G2leKS35/TVt2PM
         iQrw==
X-Forwarded-Encrypted: i=1; AJvYcCV8iuV0OQII2VmqVxIJTeE917VE/t+3MY/3lXw56D5ztElFHgvnhHTT0R4N+gMFoIL1e1CYHtkiiNoWmwsSNlMxNAhNrOs1iny+RFnx
X-Gm-Message-State: AOJu0Yw14lBzxfJCmac5bi1djRj5z6FJSOMqodJqzAPTmzLA26rOyzIe
	RwGKJg5CQSebGeWroE2pp30U3WuIQDkeQqCSFFPoMUtkPquwWQ5pbUauQHQA83s=
X-Google-Smtp-Source: AGHT+IFW14tBfWL7cXos/nSxllpRy5uvA9d7tTy4bPugq4GLaF2Jd9gqDVK0xzBYq2SjTQFT1PuVCA==
X-Received: by 2002:a05:651c:1a26:b0:2df:7009:63e3 with SMTP id by38-20020a05651c1a2600b002df700963e3mr1496141ljb.29.1714147398483;
        Fri, 26 Apr 2024 09:03:18 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:1926:f73e:8b99:1c0a])
        by smtp.googlemail.com with ESMTPSA id p14-20020a05600c1d8e00b0041bab13cd74sm1271408wms.17.2024.04.26.09.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 09:03:18 -0700 (PDT)
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
Subject: [PATCH 1/2] drm/meson: dw-hdmi: power up phy on device init
Date: Fri, 26 Apr 2024 18:02:53 +0200
Message-ID: <20240426160256.3089978-2-jbrunet@baylibre.com>
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

The phy is not in a useful state right after init. It will become useful,
including for auxiliary function such as CEC or ARC, after the first mode
is set. This is a problem on systems where the display is using another
interface like DSI or CVBS.

This change refactor the init and mode change callback to power up the PHY
on init and leave only what is necessary for mode changes in the related
function. This is enough to fix CEC operation when HDMI display is not
enabled.

Fixes: 3f68be7d8e96 ("drm/meson: Add support for HDMI encoder and DW-HDMI bridge + PHY")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 51 +++++++++------------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 5a9538bc0e26..a83d93078537 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -384,26 +384,6 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
 	    dw_hdmi_bus_fmt_is_420(hdmi))
 		mode_is_420 = true;
 
-	/* Enable clocks */
-	regmap_update_bits(priv->hhi, HHI_HDMI_CLK_CNTL, 0xffff, 0x100);
-
-	/* Bring HDMITX MEM output of power down */
-	regmap_update_bits(priv->hhi, HHI_MEM_PD_REG0, 0xff << 8, 0);
-
-	/* Bring out of reset */
-	dw_hdmi->data->top_write(dw_hdmi, HDMITX_TOP_SW_RESET,  0);
-
-	/* Enable internal pixclk, tmds_clk, spdif_clk, i2s_clk, cecclk */
-	dw_hdmi_top_write_bits(dw_hdmi, HDMITX_TOP_CLK_CNTL,
-			       0x3, 0x3);
-
-	/* Enable cec_clk and hdcp22_tmdsclk_en */
-	dw_hdmi_top_write_bits(dw_hdmi, HDMITX_TOP_CLK_CNTL,
-			       0x3 << 4, 0x3 << 4);
-
-	/* Enable normal output to PHY */
-	dw_hdmi->data->top_write(dw_hdmi, HDMITX_TOP_BIST_CNTL, BIT(12));
-
 	/* TMDS pattern setup */
 	if (mode->clock > 340000 && !mode_is_420) {
 		dw_hdmi->data->top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_01,
@@ -425,20 +405,6 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
 	/* Setup PHY parameters */
 	meson_hdmi_phy_setup_mode(dw_hdmi, mode, mode_is_420);
 
-	/* Setup PHY */
-	regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1,
-			   0xffff << 16, 0x0390 << 16);
-
-	/* BIT_INVERT */
-	if (dw_hdmi_is_compatible(dw_hdmi, "amlogic,meson-gxl-dw-hdmi") ||
-	    dw_hdmi_is_compatible(dw_hdmi, "amlogic,meson-gxm-dw-hdmi") ||
-	    dw_hdmi_is_compatible(dw_hdmi, "amlogic,meson-g12a-dw-hdmi"))
-		regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1,
-				   BIT(17), 0);
-	else
-		regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1,
-				   BIT(17), BIT(17));
-
 	/* Disable clock, fifo, fifo_wr */
 	regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1, 0xf, 0);
 
@@ -656,6 +622,23 @@ static void meson_dw_hdmi_init(struct meson_dw_hdmi *meson_dw_hdmi)
 	meson_dw_hdmi->data->top_write(meson_dw_hdmi,
 				       HDMITX_TOP_CLK_CNTL, 0xff);
 
+	/* Enable normal output to PHY */
+	meson_dw_hdmi->data->top_write(meson_dw_hdmi, HDMITX_TOP_BIST_CNTL, BIT(12));
+
+	/* Setup PHY */
+	regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1,
+			   0xffff << 16, 0x0390 << 16);
+
+	/* BIT_INVERT */
+	if (dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-gxl-dw-hdmi") ||
+	    dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-gxm-dw-hdmi") ||
+	    dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-g12a-dw-hdmi"))
+		regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1,
+				   BIT(17), 0);
+	else
+		regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1,
+				   BIT(17), BIT(17));
+
 	/* Enable HDMI-TX Interrupt */
 	meson_dw_hdmi->data->top_write(meson_dw_hdmi, HDMITX_TOP_INTR_STAT_CLR,
 				       HDMITX_TOP_INTR_CORE);
-- 
2.43.0


