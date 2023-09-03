Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4B4790E70
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 23:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349179AbjICVmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 17:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349015AbjICVmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 17:42:04 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8291210A
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 14:41:57 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-500c37d479aso1285077e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 14:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693777315; x=1694382115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQcAPcnsh/PX6lyiVXrbFZsnqyLcpAkILp56uQTeTQw=;
        b=UjTEXxmFUGnIujn1SJgYcThCVEVbqbKDQ9fn5cOi3aS41aGLUt/77MYmqIvuDVPy9I
         eg6aEROrqc61eZttTIdT8Duii6Ft9LiS0027egPMOibMVg8FbUkU6yG4ZDAXj/NgIji+
         Hrta5vkPm711oqUtlMm+zPSuP7MwLY1kTZflViuLGduARZRS/94ulKaC5/VHbZUtxro1
         Itx3HNTB+9IwuvFO9sVY/MhO07CEnrXax8l51OxudEfjvNdcq4/in6LpVBN+aavs39xj
         E2rPwzk2bOi5/iYDeVCkaYOd1kmRW9xIgkPDA7OcOHAzYGmYO7ERRkJYo8oTrSxhX2LX
         Ib1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693777315; x=1694382115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQcAPcnsh/PX6lyiVXrbFZsnqyLcpAkILp56uQTeTQw=;
        b=DrxB/gOUg7Z6XaM5NaKf0vg3FGuFXXUeyz8cAB+dr/Kb7tamdk4ZHigmwi4QAIgtAE
         sJoNAoa2ma3NgrKUx9ulo9cDw1rAWAT4YMi8ZfT/OmgHzrOp9yOrlaP/34/73F/tq1Ej
         KSPOXApO/WkYP3uLDEKiZCoMXfCbMmGcT4p4yWZ2HeU9gNDdg9hj34gSsRCcCo18254T
         7sJFZZE51teDwEp+fSCTN7u41DfwDgeeL8UCJBPHPxIS9TeI9/jPPM9VCoee5O+J3d/p
         /1qIf1DwBxvU8JHaOmlug3VLDH9tx9NkOThvTT+bztCIgSwzXdRsjsjxFfbnIPVj4YSC
         0BKA==
X-Gm-Message-State: AOJu0Yy1Nt0BwvaphCQvYnQJlb6I8Xwwg4VFKHgkuDwg7l+rEXpdiXeI
        uwcs5gDAu1CAWOV1Z2R9TV1EOw==
X-Google-Smtp-Source: AGHT+IFpEl+oUE18/qsarFYaU8IntNTWUpC/nioDioEjFcJUMzzHif7+zO1awGEwu6H7kQPHIzxz/g==
X-Received: by 2002:a05:6512:2814:b0:4f8:62a6:8b2 with SMTP id cf20-20020a056512281400b004f862a608b2mr6629124lfb.46.1693777315799;
        Sun, 03 Sep 2023 14:41:55 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id x17-20020ac25dd1000000b004f8555f7aa1sm1422506lfq.52.2023.09.03.14.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 14:41:55 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Janne Grunau <j@jannau.net>, Simon Ser <contact@emersion.fr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org
Subject: [RFC PATCH v1 06/12] soc: qcom: pmic_glink_altmode: fix DRM connector type
Date:   Mon,  4 Sep 2023 00:41:44 +0300
Message-Id: <20230903214150.2877023-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
References: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
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

During discussions regarding USB-C vs native DisplayPort it was pointed
out that other implementations (i915, AMD) are using
DRM_MODE_CONNECTOR_DisplayPort for both native and USB-C-wrapped DP
output. Follow this example and make the pmic_glink_altmode driver also
report DipslayPort connector rather than the USB one.

Cc: Simon Ser <contact@emersion.fr
Fixes: 080b4e24852b ("soc: qcom: pmic_glink: Introduce altmode support")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/soc/qcom/pmic_glink_altmode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index d05e0d6edf49..974c14d1e0bf 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -465,7 +465,7 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 		alt_port->bridge.funcs = &pmic_glink_altmode_bridge_funcs;
 		alt_port->bridge.of_node = to_of_node(fwnode);
 		alt_port->bridge.ops = DRM_BRIDGE_OP_HPD;
-		alt_port->bridge.type = DRM_MODE_CONNECTOR_USB;
+		alt_port->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
 
 		ret = devm_drm_bridge_add(dev, &alt_port->bridge);
 		if (ret)
-- 
2.39.2

