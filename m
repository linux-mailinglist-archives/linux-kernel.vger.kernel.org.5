Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A39F7CB0AC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 18:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbjJPQ5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 12:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbjJPQ4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 12:56:42 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9183210A
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 09:54:15 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3248ac76acbso3918233f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 09:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697475254; x=1698080054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpGIiUMbok8vBwc13/k0XLEAhZoDX5uqz8AGagQ5Hmc=;
        b=rQ8QLDL2UJWSvpTZwfiKnAkE5JK5NclU0ZhgMbI0lPQgGYqrOb5yMq7qpHQbAJg3W5
         tPyAcAqt44cuUfYIshdzRx8wbXK7HUE0oHuYw2LNG2FUeVSsyEetN/BAQIniZgKzu6ra
         fd+K+8LA9WKO47E9jxCVH724El3S/D5V1Ma23p3u9jKjBZCghWNo9wyUgXypWXPjpIxB
         xyMSG+BiSWBqk1fka1/Qop67koEA2wgiVZTMMiUkKJStXxkyyn5FtPMe1mGuG4CsReUg
         +5jZRWE6zbQSujcX+qIm7gA/ZF6oDWUqanKnbx6awvfjWESy7sUPdlXNdgEp4yHxRQ6U
         rQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697475254; x=1698080054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpGIiUMbok8vBwc13/k0XLEAhZoDX5uqz8AGagQ5Hmc=;
        b=Ga8O25oRZN7VyD2DAGqp0nVLiiy864+7MlYNDBETVEiH1Yb4Dzlr+2FWTwJt86pcMm
         cdgZJtDfAh88tai5UdoDh0CYFW6K27G2gQUUvEtMdCvI3Rm+v8nXEGCNet7qmmgLikDu
         ieOOnhDQwFxO5bhdKxVYWl9lsN2MQ3ML2DIv1jlu7OAJoLKlnkgM3Hxo68Ket4InCxTx
         CLrN/Rz5sAyowWmb7T958aiGGGwD7uzktBXOdouzwXhFHCLIplhp2Rv0v06J+OU7RodT
         bGp3HO3wkHhVE/dyUhLm43zC2uHMiRxoS2jao6KFLatvKFHKZRvQmzizJhogJKsmVz2p
         BKuw==
X-Gm-Message-State: AOJu0YzTQy5OUYcrCBdZFjklMZTahDoOmoQf1vSpRKl+5DP28U+NyOBo
        Kmx/Yg4x5bS7OOF4khoF+jLIhA==
X-Google-Smtp-Source: AGHT+IGv6IJmbuk/e/mZEXSBzwHspez+g7aAQkIvi456hEyHQKQI7pI4oTBdD/5E0EVsTbEEtp3zKw==
X-Received: by 2002:a05:6000:80a:b0:32d:857c:d51c with SMTP id bt10-20020a056000080a00b0032d857cd51cmr16399678wrb.43.1697475254257;
        Mon, 16 Oct 2023 09:54:14 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([45.84.211.189])
        by smtp.gmail.com with ESMTPSA id s19-20020a05600c45d300b0040648217f4fsm7638996wmo.39.2023.10.16.09.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:54:13 -0700 (PDT)
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
Subject: [RFC PATCH 09/10] drm/bridge: lt9611uxc: implement automatic DSI power control
Date:   Mon, 16 Oct 2023 19:53:54 +0300
Message-ID: <20231016165355.1327217-10-dmitry.baryshkov@linaro.org>
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

The Lontium LT9611UXC driver doesn't need to control DSI power
lines manually. Mark it for automatic power control.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 7835738a532e..ace7a6ee890b 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -279,7 +279,7 @@ static struct mipi_dsi_device *lt9611uxc_attach_dsi(struct lt9611uxc *lt9611uxc,
 	dsi->lanes = 4;
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
-			  MIPI_DSI_MODE_VIDEO_HSE;
+			  MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_AUTO_POWERUP;
 
 	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
-- 
2.42.0

