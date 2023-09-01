Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A1178FCD7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349330AbjIAMBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349323AbjIAMBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:01:09 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1900C10E9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:01:03 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-986d8332f50so230862266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 05:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693569661; x=1694174461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Q8dcqWIi8qfe4rFjMBwnA3MXBS8IlDgEZlXPHxdDbc=;
        b=f8Cn8PhEmbugxXX8cp1rtapLm/lwjUWOyM87Jft36Svsf+RM3R1a8pYFAziRaNv9nO
         FtKbTm2RDVtBwUSc28HRCgn+DMOntkl2uJnIFb/FPDhgfqGgrwfFz8kgivSxuSr9cQRF
         VrQEY4skRoTTtcstIHaAo6ynysdYbCljdgou9VR5CJbvgKEgnkuyhG4qhH3Y3JH6UR2y
         4eGI2tOytw8bfwMQoKxfswDn+C8u49g7in/PakdtoNXsfbSMpGI/QStuXDrsGJeByL99
         APCQDZ9s7zvhWrYUqLwJX337AXRaBTmwdvjDufLYMdj+yRdkwIB5UmlM/X8+ZnJhpPwS
         KTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693569661; x=1694174461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Q8dcqWIi8qfe4rFjMBwnA3MXBS8IlDgEZlXPHxdDbc=;
        b=Zi54AK/eP/S6y3WZl1B/DZCTA1pgDCKSxq7YWukbF4qt7qrY28PA3TDVXh+lE+m2os
         G8FpTdOPBcS3wTqeUraaOsaYB/WgQhOF0F7ug18PD3LxXy+3C/Mpm3wnpUw4QCfc9x/b
         8kefLsudIQdSXhZW/axh0dP4squ3WLYgmxYLWzVmAjNXrI+DLgFXebvAJ7sIp/nEb9oa
         IplQOVxUK4rRLPqlk6i7BapAzvbmoydbsT93e24UWSG1CG+TjKqXYWd5Vy3NLpu8ZGj6
         p9MqeiABWo0JArnmLnuRfa/YIgXEIB16BFab0E5VZmBJ9wgdFW4iswQ7Dqasjyxytn0Y
         HvLg==
X-Gm-Message-State: AOJu0YzS219t7yP4XyF05oaoeSo8s9oJGqYWVJxc2+7Vh9P48Ei7lyol
        d6Z2HlnMr+FwJiZZhy52bsHrSw==
X-Google-Smtp-Source: AGHT+IFO69PhfApiWoJ10ALX5LCVOgGWPETEhTDqrXyG9F36Yfc1fiNItFAnBKhYo0wBJNtMIHfaag==
X-Received: by 2002:a17:907:7608:b0:99c:c50f:7fb4 with SMTP id jx8-20020a170907760800b0099cc50f7fb4mr1581342ejc.1.1693569661575;
        Fri, 01 Sep 2023 05:01:01 -0700 (PDT)
Received: from krzk-bin.. (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id kg12-20020a17090776ec00b00993928e4d1bsm1877343ejc.24.2023.09.01.05.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 05:01:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] power: reset: syscon-poweroff: simplify pdev->dev usage
Date:   Fri,  1 Sep 2023 14:00:56 +0200
Message-Id: <20230901120057.47018-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901120057.47018-1-krzysztof.kozlowski@linaro.org>
References: <20230901120057.47018-1-krzysztof.kozlowski@linaro.org>
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

Make the probe() code a bit simpler and shorter by storing all the
'&pdev->dev' as 'dev'.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/power/reset/syscon-poweroff.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/power/reset/syscon-poweroff.c b/drivers/power/reset/syscon-poweroff.c
index 430d440d55c6..11b955983279 100644
--- a/drivers/power/reset/syscon-poweroff.c
+++ b/drivers/power/reset/syscon-poweroff.c
@@ -32,23 +32,24 @@ static void syscon_poweroff(void)
 
 static int syscon_poweroff_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	int mask_err, value_err;
 
-	map = syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "regmap");
+	map = syscon_regmap_lookup_by_phandle(dev->of_node, "regmap");
 	if (IS_ERR(map)) {
-		dev_err(&pdev->dev, "unable to get syscon");
+		dev_err(dev, "unable to get syscon");
 		return PTR_ERR(map);
 	}
 
-	if (of_property_read_u32(pdev->dev.of_node, "offset", &offset)) {
-		dev_err(&pdev->dev, "unable to read 'offset'");
+	if (of_property_read_u32(dev->of_node, "offset", &offset)) {
+		dev_err(dev, "unable to read 'offset'");
 		return -EINVAL;
 	}
 
-	value_err = of_property_read_u32(pdev->dev.of_node, "value", &value);
-	mask_err = of_property_read_u32(pdev->dev.of_node, "mask", &mask);
+	value_err = of_property_read_u32(dev->of_node, "value", &value);
+	mask_err = of_property_read_u32(dev->of_node, "mask", &mask);
 	if (value_err && mask_err) {
-		dev_err(&pdev->dev, "unable to read 'value' and 'mask'");
+		dev_err(dev, "unable to read 'value' and 'mask'");
 		return -EINVAL;
 	}
 
@@ -62,7 +63,7 @@ static int syscon_poweroff_probe(struct platform_device *pdev)
 	}
 
 	if (pm_power_off) {
-		dev_err(&pdev->dev, "pm_power_off already claimed for %ps",
+		dev_err(dev, "pm_power_off already claimed for %ps",
 			pm_power_off);
 		return -EBUSY;
 	}
-- 
2.34.1

