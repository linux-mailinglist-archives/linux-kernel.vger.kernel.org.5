Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFB2767A71
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 03:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbjG2BCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 21:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbjG2BCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 21:02:12 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9878146A0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:01:43 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so28493635e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690592477; x=1691197277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4eWv/RBKDrUWJz/NgxgnDtpmPraqNg6YmnPUdo6m2g=;
        b=tZXrNe4kyHtOvMEtLQCwLLbJg9HJMiZbGb4FthsmckYksh3vu9QnA3k8F6HufFJiGL
         LhUMFMlg/oFQlQiNwFluSE5/Ofw/bEyMXqbXYmghKzp0qDMpah0dcGL+sfxn4QqQeSCk
         29be46tHx1/NfnsdlBuGG3Gfydzc9xCbx4GQ4sfa86CSl1TdxzVggNEdb/MUmiZS8ZNz
         Om+7WfaWp3gQr07WrA4BY3WoGlVsU521B/xg1P68eG3i9QnQg5d4gDrqogOBNAKtf33h
         acy/1/lIo++diRXtQ+VA5Ei/89yxknDlG9TNEkg4v20dfjuDhx8o6pu0kxIBlavp57/l
         s+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690592477; x=1691197277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4eWv/RBKDrUWJz/NgxgnDtpmPraqNg6YmnPUdo6m2g=;
        b=l16H0aex73AZ26Vtgpr/sRkP7mD/ZmbObJleThjROY9J39Cs/4PD2aGFHndPOoFC/s
         OVSyIvaNGCTJaNdJGnDb2Y5RGmoRjZxn7SSoMK0VSmsqq8O7QAN0ataA7xCz3rXTM54O
         UD5JMeNuwV9JB12fpC1oLsbxgLqXPRrPnSyuP1f+20L1554jg/WxEmrOFKhWd9iyCxyA
         HEZjpiWmR55C0yQ9sloWaUv7xkvvNG4QlDQRcJa+Ei83+5lHqciHZ/FlMzhxK6Z/+BoW
         FjHOtojr0BFQbTaUoJXfRnaLT4VArTSyjdATD878sxj3ETlz7eYwrYC6aWG5R52mk/Zx
         voJQ==
X-Gm-Message-State: ABy/qLaNSUK6T5bwIbYpUsTJjl/rbuFM1pVnXXsZRJkjL2XhJ8KwxCIE
        WzB6wq1FkFqWn+W1ZNMXfL2zFwE6+KPb5pVFmf4=
X-Google-Smtp-Source: APBJJlH3hanHEvBgr++jOJubmsB65dIQxl3i8dLk9WO0Yl8D2xONZbjmFiJz42HIJIcei2b4Pyrowg==
X-Received: by 2002:a19:ca15:0:b0:4fe:ee7:a32a with SMTP id a21-20020a19ca15000000b004fe0ee7a32amr2516420lfg.16.1690591757890;
        Fri, 28 Jul 2023 17:49:17 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a24-20020a19f818000000b004fe20d1b288sm500702lff.159.2023.07.28.17.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:49:17 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Simon Ser <contact@emersion.fr>, Janne Grunau <j@jannau.net>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] soc: qcom: pmic_glink: properly describe the DP connector
Date:   Sat, 29 Jul 2023 03:49:13 +0300
Message-Id: <20230729004913.215872-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230729004913.215872-1-dmitry.baryshkov@linaro.org>
References: <20230729004913.215872-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the discussion of the DP connectors, it was suggested that USB-C
DisplayPort connectors should have DRM_MODE_CONNECTOR_DisplayPort
connector type. This follows the example provided by other drivers
(AMDGPU, Intel). To distinguish them from native DP ports, they should
have the freshly defined USB as a subconnector type.

Suggested-by: Simon Ser <contact@emersion.fr>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/soc/qcom/pmic_glink_altmode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index 1dedacc52aea..9094944c6cc0 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -417,7 +417,8 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 		alt_port->bridge.funcs = &pmic_glink_altmode_bridge_funcs;
 		alt_port->bridge.of_node = to_of_node(fwnode);
 		alt_port->bridge.ops = DRM_BRIDGE_OP_HPD;
-		alt_port->bridge.type = DRM_MODE_CONNECTOR_USB;
+		alt_port->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
+		alt_port->bridge.subtype = DRM_MODE_SUBCONNECTOR_USB;
 
 		ret = devm_drm_bridge_add(dev, &alt_port->bridge);
 		if (ret)
-- 
2.39.2

