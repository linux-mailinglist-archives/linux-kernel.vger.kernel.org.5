Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9356A7D0E02
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377178AbjJTK4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377103AbjJTK4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:56:13 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77769119
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:56:10 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so9453531fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697799369; x=1698404169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBaYQeYiD1YuZrxxKEylzAW4K+YG4Ht4dFex9adnBRY=;
        b=temMAmEq3V2ZdHFjHX32kMzOz26wqA2b43xqwQuRZ43ZCpjAtv8Xa91xZt7+74YgrG
         kwJxceX8OIEKYraXHI9gd5ZoKngnF1ucxYxXE81y3ICIHlVgzDIRAeaRB/xfHHkuF4Lm
         B1jamBTQ1fE2/mL9KdsfjIweFA/dUgIFeO8/FmIYXta6sKJ5uuBoayiU96ZXesCuTDHx
         yZIe3L8Lc3f3QbZPHSkv0LiF9TURmWspa8XqqGlEKrLCYV2UubNJkrV04Psw/cA2wK4K
         LTBJTDCnwBFzEIWW6Kq1AHbnrqz3POlcUDtmd2fJYOro/aIb+BdUHL/8flBMvt61zj29
         hA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697799369; x=1698404169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBaYQeYiD1YuZrxxKEylzAW4K+YG4Ht4dFex9adnBRY=;
        b=gciiF4TFf9wr/0KQzC53qa2Z7TotqVOu7EGr4gtJyBhL6xel8gfM3df2onX2gQr7dj
         K2am/9ci3u3G67Y0/svWlItVcVTy/OBrI5L0PSQzgLd9uRcMVNXmDOhldfd2eSXu1MwS
         OI6tfDLL4QWKxSLrRvve+H/XE63qOn8oY5n5jthnYaHAQlM/5RKDQ8a2v2XcE02GxcPP
         fmSmvTpOV4SdMbvaHVh0XNb+9GJc3bHqhe8508KggJ1DzbYyO2LYjV1I59JAYtOqyu8Q
         WCaasEQOujZneS7iR/LfR8ons4aDYZ+r3tfBcuueak6B8T1rTG2TI+3PoDOyO1PSWTwq
         mEeg==
X-Gm-Message-State: AOJu0YyX8ZrazByzcypoqmHbKXUW/CaFiOZjJMTVXyUGq7Qml9C7wp27
        rWl9VMhTmVCCAllqJEAIkj15VqErPMjgJgbbGuQ=
X-Google-Smtp-Source: AGHT+IEhmSf4ky0G4VM0uFuoHHlAPr3EDeavNqoIYbfRHWHHQheL0Iu9+3lsngJmW9SLg23PpQgpQQ==
X-Received: by 2002:a2e:a7d2:0:b0:2c1:5645:a2c0 with SMTP id x18-20020a2ea7d2000000b002c15645a2c0mr1398424ljp.35.1697799368791;
        Fri, 20 Oct 2023 03:56:08 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id x9-20020a05600c420900b004065e235417sm6578937wmh.21.2023.10.20.03.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:56:07 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6/6] nvmem: Use device_get_match_data()
Date:   Fri, 20 Oct 2023 11:55:45 +0100
Message-Id: <20231020105545.216052-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231020105545.216052-1-srinivas.kandagatla@linaro.org>
References: <20231020105545.216052-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/mxs-ocotp.c   | 10 ++++------
 drivers/nvmem/stm32-romem.c |  7 ++++---
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/nvmem/mxs-ocotp.c b/drivers/nvmem/mxs-ocotp.c
index 588ab56d75b7..7b78f18f9545 100644
--- a/drivers/nvmem/mxs-ocotp.c
+++ b/drivers/nvmem/mxs-ocotp.c
@@ -13,8 +13,9 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/stmp_device.h>
 
@@ -140,11 +141,10 @@ static int mxs_ocotp_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const struct mxs_data *data;
 	struct mxs_ocotp *otp;
-	const struct of_device_id *match;
 	int ret;
 
-	match = of_match_device(dev->driver->of_match_table, dev);
-	if (!match || !match->data)
+	data = device_get_match_data(dev);
+	if (!data)
 		return -EINVAL;
 
 	otp = devm_kzalloc(dev, sizeof(*otp), GFP_KERNEL);
@@ -169,8 +169,6 @@ static int mxs_ocotp_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	data = match->data;
-
 	ocotp_config.size = data->size;
 	ocotp_config.priv = otp;
 	ocotp_config.dev = dev;
diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
index 1541c20709d2..8a553b1799a8 100644
--- a/drivers/nvmem/stm32-romem.c
+++ b/drivers/nvmem/stm32-romem.c
@@ -10,7 +10,9 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/tee_drv.h>
 
 #include "stm32-bsec-optee-ta.h"
@@ -211,8 +213,7 @@ static int stm32_romem_probe(struct platform_device *pdev)
 
 	priv->lower = 0;
 
-	cfg = (const struct stm32_romem_cfg *)
-		of_match_device(dev->driver->of_match_table, dev)->data;
+	cfg = device_get_match_data(dev);
 	if (!cfg) {
 		priv->cfg.read_only = true;
 		priv->cfg.size = resource_size(res);
-- 
2.25.1

