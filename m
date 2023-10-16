Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49037CB0B7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 18:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbjJPQ5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 12:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbjJPQ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 12:56:40 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174A22133
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 09:54:07 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40684f53bfcso44071365e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 09:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697475245; x=1698080045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gh1i1qC5dBtLH8fnR85p04AUelnLL/86pQbMA34ZucQ=;
        b=vzHcoHsLhS7Ac6lXY9AEuKugvuwVMLa/702wfzhO2OHGHKi92a1lWVDvVcE39Et4xE
         mmxy3c9tqYzuAj9FO6qTYdUUMNY6Mz6aAFrHYYZhEfWyqBQTZ7VOO/QRd393HiTkdW78
         zFw8SkPNo8Vclboj6FXPIsWrKiKrvZ0wlRfSRm1/Q58jamBoexjbMh01OeUHxPcluZZP
         UadpRGfKMDdFd1pL4X5BobrqU5q8sbC7FE8D2lsKPfG/y8mTOONjQMpapdahirOAcuRZ
         CkTJk5PbL5UMu/woAY7hXO/Gw4mdT/7TXELSW5Mo5o/j0XS0gL2JIwTeeHgEd9zu6jzu
         EHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697475245; x=1698080045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gh1i1qC5dBtLH8fnR85p04AUelnLL/86pQbMA34ZucQ=;
        b=PBW1OXcskAKvP905b21DXDnvRV7Xep6TUBvQ/v+DO/U/aCp/uhOqd50mqB4tvd0Qpo
         3QrKIsmxpaBNFOz/IqIX8Y7JfPCL8YSjqJR2l3Sinw+DfGFkQhmGPe3B2kctxr70A1w7
         XDE8AQUSMgZ7C1aef1BhjTsYqF+lboXh9Dw3tWGrQ2ieWxeop9DoUa0hpTMhiBpQzIz6
         zlfhMc+Isk6QArMDnbyizF//+bZkoocjwtfCzq9rr94TRFq02n6Sg4H3ivdWYkUQNHW4
         uIPOX+5hveoxe5xzx3fYu6TGqAbFuMNAbK6KcRtmQIx7SqeuZmgsU/EL/YQf9iULaW2f
         pXRg==
X-Gm-Message-State: AOJu0YwhNd9wWkIhWYFKQdXG4GFp5+e5LCLIZPx1aQhMTs6qUCw7Dy5y
        iKeltqNDQC4xEvRGCSQYayNc+g==
X-Google-Smtp-Source: AGHT+IE0ZfNIwOf9qoBMcCLzP2Zitib4HQoRxmYe1CQIkuDQPdAYbM6sYWt+8StvzHVCWDqd+MMgNA==
X-Received: by 2002:a7b:c419:0:b0:3fe:d630:f568 with SMTP id k25-20020a7bc419000000b003fed630f568mr29322698wmi.39.1697475245495;
        Mon, 16 Oct 2023 09:54:05 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([45.84.211.189])
        by smtp.gmail.com with ESMTPSA id s19-20020a05600c45d300b0040648217f4fsm7638996wmo.39.2023.10.16.09.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:54:05 -0700 (PDT)
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
Subject: [RFC PATCH 04/10] drm/msm/dsi: use dsi_mgr_bridge_power_off in dsi_mgr_bridge_post_disable
Date:   Mon, 16 Oct 2023 19:53:49 +0300
Message-ID: <20231016165355.1327217-5-dmitry.baryshkov@linaro.org>
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

Simplify dsi_mgr_bridge_post_disable() by using
dsi_mgr_bridge_power_off() instead of hand-coding the same call
sequence.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi_manager.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index 896f369fdd53..9fa1f29ec11a 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -372,8 +372,10 @@ static void dsi_mgr_bridge_post_disable(struct drm_bridge *bridge)
 	 * It is safe to call dsi_mgr_phy_disable() here because a single PHY
 	 * won't be diabled until both PHYs request disable.
 	 */
-	if (is_bonded_dsi && !IS_MASTER_DSI_LINK(id))
-		goto disable_phy;
+	if (is_bonded_dsi && !IS_MASTER_DSI_LINK(id)) {
+		dsi_mgr_phy_disable(id);
+		return;
+	}
 
 	ret = msm_dsi_host_disable(host);
 	if (ret)
@@ -385,26 +387,10 @@ static void dsi_mgr_bridge_post_disable(struct drm_bridge *bridge)
 			pr_err("%s: host1 disable failed, %d\n", __func__, ret);
 	}
 
-	msm_dsi_host_disable_irq(host);
-	if (is_bonded_dsi && msm_dsi1)
-		msm_dsi_host_disable_irq(msm_dsi1->host);
-
 	/* Save PHY status if it is a clock source */
 	msm_dsi_phy_pll_save_state(msm_dsi->phy);
 
-	ret = msm_dsi_host_power_off(host);
-	if (ret)
-		pr_err("%s: host %d power off failed,%d\n", __func__, id, ret);
-
-	if (is_bonded_dsi && msm_dsi1) {
-		ret = msm_dsi_host_power_off(msm_dsi1->host);
-		if (ret)
-			pr_err("%s: host1 power off failed, %d\n",
-								__func__, ret);
-	}
-
-disable_phy:
-	dsi_mgr_phy_disable(id);
+	dsi_mgr_bridge_power_off(bridge);
 }
 
 static void dsi_mgr_bridge_mode_set(struct drm_bridge *bridge,
-- 
2.42.0

