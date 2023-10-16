Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C367CB0AE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 18:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjJPQ5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 12:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbjJPQ4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 12:56:43 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD203C25
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 09:54:17 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40535597f01so46842915e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 09:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697475256; x=1698080056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2KAQh5biIaDjy3JspEokfbAFpOptd05O572lVX96aY=;
        b=b16gH0mUBocs5VLOa0oKJnzWyP2wr6PBOpMJgT0H0PPo+joXWMArPcZs8zkRWZrjqP
         hlgpRPTum5bT+FO/P77WqYszXeXNIqZ/i2P5JIGakO8r2xsMw+ln7zsl2V/5XpRjtbjB
         xFz5ULF98c/nQOqFxLdUVeRHCvWPVOBO13hSg0mO9Zrmom2DTpnnt8HkCGGLuiqqQwss
         zVdMa8/WiPzc6ajsaNkfUlOY8UA+BfXOFnGVT4eSdtI7jLnshuWsf+3Um4XYQpzbgtyu
         kTY9J8/td9YqwKK5vlUx3Qz7a8RtPg0eeA9VLAzMLCiHLL96cEaVQWqLn62uE1ci4uR0
         q39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697475256; x=1698080056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2KAQh5biIaDjy3JspEokfbAFpOptd05O572lVX96aY=;
        b=vFCmnoRm4FYnsxEiDFFzovTpjtCbmIFmwrNDjxI4QvTUsXz8Iu2gVok9CO6inRiDJz
         Dpyt3sg74HcYIq9PVz06hVk8Bik/Q7jUz4NG/yO4F4WK9H61mROM6LHFciWs+ShgIL9G
         WaeO3dqUP6M5b71NjL3cFpjuFe1QzR0fCb1tqbi8ikMno1k8EFVb98AvMvSxDKuhrsa9
         ZxDQgvAemZrGUD4ixZ3fzGwR/x//dh/WaSUhmq3oZqqiqsSumqqORiKI6CafYA0GZT0o
         NbrwzC29warGagNcwgWIsRWmkweqbNckWOoURB6TQrfl5OjmnDgIpIz/isPEjEYKoiXc
         4RoA==
X-Gm-Message-State: AOJu0Yyf2LUaii/sC2uXe/47KZV3Ujzgl8SdoZdT3R6ehk4SXihq6PFp
        InG8OVvHwqPO3ua8AiZNHb64pw==
X-Google-Smtp-Source: AGHT+IEqmnobiCsIMYAdCDeaCtj3AGb0jtlboDlqcQ+Atx1a8i0m4PfESVkAoxvu6F9wIJAh3Bb39A==
X-Received: by 2002:a1c:7711:0:b0:405:959e:dc7c with SMTP id t17-20020a1c7711000000b00405959edc7cmr29757671wmi.30.1697475256293;
        Mon, 16 Oct 2023 09:54:16 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([45.84.211.189])
        by smtp.gmail.com with ESMTPSA id s19-20020a05600c45d300b0040648217f4fsm7638996wmo.39.2023.10.16.09.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:54:15 -0700 (PDT)
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
Subject: [RFC PATCH 10/10] drm/msm/dsi: drop (again) the ps8640 workaround
Date:   Mon, 16 Oct 2023 19:53:55 +0300
Message-ID: <20231016165355.1327217-11-dmitry.baryshkov@linaro.org>
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

Now as the Parade PS8640 driver sets the MIPI_DSI_MANUAL_POWERUP flag,
drop the workaround enforcing the late DSI link powerup in the case the
next bridge is ps8640.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi_manager.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index 2d7040d21239..b6b8171cf382 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -198,29 +198,12 @@ static int dsi_mgr_bridge_get_id(struct drm_bridge *bridge)
 	return dsi_bridge->id;
 }
 
-/*
- * If the next bridge in the chain is the Parade ps8640 bridge chip then don't
- * power on early since it seems to violate the expectations of the firmware
- * that the bridge chip is running.
- */
-static bool dsi_mgr_next_is_ps8640(struct drm_bridge *bridge)
-{
-	struct drm_bridge *next_bridge = drm_bridge_get_next_bridge(bridge);
-
-	return next_bridge &&
-		next_bridge->of_node &&
-		of_device_is_compatible(next_bridge->of_node, "parade,ps8640");
-}
-
 static bool dsi_mgr_auto_powerup(struct drm_bridge *bridge)
 {
 	int id = dsi_mgr_bridge_get_id(bridge);
 	struct msm_dsi *msm_dsi = dsi_mgr_get_dsi(id);
 	struct mipi_dsi_host *host = msm_dsi->host;
 
-	if (dsi_mgr_next_is_ps8640(bridge))
-		return true;
-
 	return msm_dsi_host_auto_powerup(host);
 }
 
@@ -230,9 +213,6 @@ static bool dsi_mgr_early_powerup(struct drm_bridge *bridge)
 	struct msm_dsi *msm_dsi = dsi_mgr_get_dsi(id);
 	struct mipi_dsi_host *host = msm_dsi->host;
 
-	if (dsi_mgr_next_is_ps8640(bridge))
-		return false;
-
 	return msm_dsi_host_early_powerup(host);
 }
 
-- 
2.42.0

