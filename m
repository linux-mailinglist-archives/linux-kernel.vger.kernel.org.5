Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D6B7CB0AF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 18:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjJPQ5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 12:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjJPQ4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 12:56:42 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A0F3873
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 09:54:13 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4065dea9a33so45537755e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 09:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697475252; x=1698080052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7atWdHX87tg37dPcf4FsazD++qIF8t5k5lbbaEv6EjQ=;
        b=Uprv4Hn2IPCDeTaUEae+9zl2q9+xhk5RCmPvOG5bmHC0AIy3gLI8pjNUrs30Y6R4+r
         J64hKtTrOd6IgvFDXfG9JIIduVzcHoP3gbHUSNI6TuYCeO24AzPANLqeRpJEa9TYGAyM
         IocR6XGReWRJ09TOl47SokkVCj9ZUX1cGG8dJMJ04huJjkR6UmsIPBMh1/vBjB+NKHl0
         5hyzkHbcGBcNSXwAfb5WzFw7LKdub1NxlE/DHXhwc1umcZRHntdDUaZn2Umg4w1aBruE
         cnY+I8kAkYuEbbahdrQR8BJdRZwYDm9NvxRsEKd1lOd3/EdPBvMt1zPCHZ5Rbxz41Nhw
         pIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697475252; x=1698080052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7atWdHX87tg37dPcf4FsazD++qIF8t5k5lbbaEv6EjQ=;
        b=IUUWwoSKfSfhtt/t+GO6zY+ZKH4pC3I81gm9VyPo3tbDuvi4b124Ni84CMLyNkm1Au
         m+TR/5oTTzu//88hmpiKlBxxu0wid4ZnBT2U7gTPbFJjvfTA2U+kv2PRurMWI+5SA5BT
         yUJaMhro4E/R+fqMOs5oZC8hUkAMyaOckv62Fsn9F6FCXpDvElcVnVrOQcW4N6TkkrhW
         2M0MYAkn1F70ywnGKkxKkkI3lCEGaIC8EQmGm+BEs7a6hcb99fpOfihRMILTK0vpL+4R
         ap4/T2jFENx811e7NhWyEw+uP4m6YU+FQAP4cPBe1uvraFmbO6PkVaVDNmCA9JpIFZPy
         4RLA==
X-Gm-Message-State: AOJu0YxND3NF2FzVk8BIgDIvNlEKC3EYNYvJWawFhr+PH1w0X9RfOapF
        u02W1JYTtghFf/Y2xILp0zdDhQ==
X-Google-Smtp-Source: AGHT+IFkELKtKgynuffB+oWpclXHrxccbH7YSTd/rxvV58WereDXS35Dcn2oCjeZlgI0vrzf+kaXkQ==
X-Received: by 2002:a7b:c5c9:0:b0:403:272:4414 with SMTP id n9-20020a7bc5c9000000b0040302724414mr29903330wmk.0.1697475252155;
        Mon, 16 Oct 2023 09:54:12 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([45.84.211.189])
        by smtp.gmail.com with ESMTPSA id s19-20020a05600c45d300b0040648217f4fsm7638996wmo.39.2023.10.16.09.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:54:11 -0700 (PDT)
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
Subject: [RFC PATCH 08/10] drm/bridge: lt9611: mark for automatic DSI power control
Date:   Mon, 16 Oct 2023 19:53:53 +0300
Message-ID: <20231016165355.1327217-9-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016165355.1327217-1-dmitry.baryshkov@linaro.org>
References: <20231016165355.1327217-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lontium LT9611 driver doesn't need to control DSI power
lines manually. Mark it for automatic power control.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index 9663601ce098..10b7093bd5c5 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -774,7 +774,7 @@ static struct mipi_dsi_device *lt9611_attach_dsi(struct lt9611 *lt9611,
 	dsi->lanes = 4;
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
-			  MIPI_DSI_MODE_VIDEO_HSE;
+			  MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_AUTO_POWERUP;
 
 	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
-- 
2.42.0

