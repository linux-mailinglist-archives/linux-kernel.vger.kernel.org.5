Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717F77CB09F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 18:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjJPQ4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 12:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPQ4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 12:56:36 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DEA1105
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 09:54:01 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40535597f01so46838355e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 09:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697475240; x=1698080040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXcBslb1MNvlJH1zjcV0wxGhoCZ7RiOAEccFN8ak0qg=;
        b=YFovLDEXyDoGaIgb31uRr3rCTzXY2JY2mK4M62oxV7NpWWcaBO3vfyDgv6Gfgsh4Uh
         D4Tehyq6kFV+cvNVASguvPIeRMSxmzB3cmbkaF+HWY29gwhW5cyz8ZnApFIkViCWzEGr
         x9lXv47nNFzC6c4AH+F+2vuYl1yoD/cCAMihMYhrwSn2gmew5jUYy3UTYre99LQ+tXEn
         EbW1aA26dm35qeTilpp/K19Ze4g2wxIcj3w2/lpfx1KBphiIAR/QNk2dvwjDprM3eAxX
         LqxuRFQR2X0e0MlxyjYCXJWy66dt1aa3o0Cu34IG36xymVqwXEYA3zPehMzCo2OZxCmh
         x4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697475240; x=1698080040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXcBslb1MNvlJH1zjcV0wxGhoCZ7RiOAEccFN8ak0qg=;
        b=X8jVprkXxh1xFJSQSf3lGF1sBR3RdQ1+9tshU5GyfJOwBZcfsqUXXq3HCalfjyU55H
         W5C2HfQYETjthyK7uE0Bum5vvnUpFqIH9UscFhmk6/Qu2BJY5OvDZW1jSR/tJ8LOtOds
         JIPl6B22D9Jf1W0Ikx21YC49CsBbEJjwHPoQPWvx+3Xd3K9Op53ARBKxR3e0LQfDtVK2
         KZXdOA0Lx4leN29o+juiqCkECYxJWqNKX2xWl+BG+2KN36asrWaX05fmnyuSMfsC3SOK
         kIsBNw2qs48I3QdHEjMQwkDjmOr/lYGBnPWuihLbjr4hRUv0GrvUuAo7yc2QcSQWD/wT
         f+uQ==
X-Gm-Message-State: AOJu0YzdOq46pMvqV72l+K0cVUXJSbYBmf2OPDlZUPj21ZSWdVBq0M3P
        TvGJkw4nN8mCfCCWOL2pGT1HJ1g6u1XvB7AkHJReWK3E
X-Google-Smtp-Source: AGHT+IHoONg9qNPiKGeTIHddHvmhDg1GDHSsCUAu6Z2s65378ibuLRfTX/M31ed4RtOSacgQiyUf0g==
X-Received: by 2002:a1c:4b11:0:b0:405:3455:e1a3 with SMTP id y17-20020a1c4b11000000b004053455e1a3mr30359791wma.17.1697475240062;
        Mon, 16 Oct 2023 09:54:00 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([45.84.211.189])
        by smtp.gmail.com with ESMTPSA id s19-20020a05600c45d300b0040648217f4fsm7638996wmo.39.2023.10.16.09.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:53:59 -0700 (PDT)
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
Subject: [RFC PATCH 01/10] Revert "drm/bridge: tc358762: Split register programming from pre-enable to enable"
Date:   Mon, 16 Oct 2023 19:53:46 +0300
Message-ID: <20231016165355.1327217-2-dmitry.baryshkov@linaro.org>
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

It has been pointed out (e.g. in [1]) that enable is not the best place
for sending the DSI commands. There are hosts (sunxi) that can not
support sending DSI commands once video stream has enabled.

Also most panel drivers send DSI commands in the prepare() callback
(which maps to drm_bridg_funcs::pre_enable()). Thus the DSIM host should
be fixed to be able to send DSI commands from pre_enable() state.

[1] https://lore.kernel.org/dri-devel/CAPY8ntBrhYAmsraDqJGuTrSL6VjGXBAMVoN7xweV7E4qZv+v3Q@mail.gmail.com/
[2] https://github.com/torvalds/lincux/blob/master/include/drm/drm_mipi_dsi.h#L84-L87

Cc: Marek Vasut <marex@denx.de>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/bridge/tc358762.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 46198af9eebb..7b9f05f95fd1 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -185,17 +185,11 @@ static void tc358762_pre_enable(struct drm_bridge *bridge, struct drm_bridge_sta
 		usleep_range(5000, 10000);
 	}
 
-	ctx->pre_enabled = true;
-}
-
-static void tc358762_enable(struct drm_bridge *bridge, struct drm_bridge_state *state)
-{
-	struct tc358762 *ctx = bridge_to_tc358762(bridge);
-	int ret;
-
 	ret = tc358762_init(ctx);
 	if (ret < 0)
 		dev_err(ctx->dev, "error initializing bridge (%d)\n", ret);
+
+	ctx->pre_enabled = true;
 }
 
 static int tc358762_attach(struct drm_bridge *bridge,
@@ -219,7 +213,6 @@ static void tc358762_bridge_mode_set(struct drm_bridge *bridge,
 static const struct drm_bridge_funcs tc358762_bridge_funcs = {
 	.atomic_post_disable = tc358762_post_disable,
 	.atomic_pre_enable = tc358762_pre_enable,
-	.atomic_enable = tc358762_enable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_reset = drm_atomic_helper_bridge_reset,
-- 
2.42.0

