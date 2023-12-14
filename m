Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F15812D9D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443822AbjLNKxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443778AbjLNKwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:52:53 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DC5181
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:52:56 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c46d6784eso40139525e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702551174; x=1703155974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tz2Xvyg4JP2yoDb158eSoW+wfoMNINh6+jbVwRbhMzg=;
        b=l0hcZotCiUZF3GUAyXnrHKpziDKODeoJ2rFz4MeIFdYQRnOcxag8BJIwPPMn/t5DoS
         G2G1f4MMOHaNPjvHDBmer/O/zCTM1jJ6s5SLMKSV5UceeYSS+N7P7RMLlnF3SEkDK0Oo
         gIKx2JBs+8wh75o5i5MJVrAaSNToyf9h1Q3HfCxfbcAJ5NWBkDTBhcRsTlAdpAWN9YvY
         y4UoMCvdeDXAcBCJR/vshB0QjOYhGnIzP6AViUowsiNpKn5/7Bl+UpfR01VeQHYj/h1R
         u7Avswn4RgkewHE6uIUfaPE1u56gxPNVtCzsUit/K29Vp8nizjaJF4553cI/Q5HV4N7A
         5wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702551174; x=1703155974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tz2Xvyg4JP2yoDb158eSoW+wfoMNINh6+jbVwRbhMzg=;
        b=dsm2ocHPQk3rkfpHJPJroSLRCVGgUiGfr4Yx6Ad205ZGkSVJizdm++5sgQG6GvAqlR
         OnVYf03onSKZVhG1QoLAjcIhI53bASCuwMuqc+Ab6hHKuXyvEAioQFnYaSQBlSL9oVgs
         8u8ObTrqk2mmeNrtJhrgkyVQoa5A8zjldwr31kk0JTGsnibbzl5Sy2qA8q8RJw1ajxlS
         /OYd21mG58Jfly1dVPPUBOZtcJeC2ZaMDfcI07S7j5PWA46GAXz8JDxW9F9NojwcLD0G
         /47iavnb3AIL+SudXw4L73ywOOYYwB1oaxw2zt2REbxfsEcRJogL+eSaOgQe4tZ2m71+
         2xeA==
X-Gm-Message-State: AOJu0YxPnlkq68qaVt/2+cWO+xUaRlA1B1QAO9MbtGmiwn14MTJFXWvx
        crULpVrHPuWypP9FTNpfKBsshw==
X-Google-Smtp-Source: AGHT+IH4J/oPnKQvv4O5ZLerNCsWrBSRNQ4wX2oCYLqm28AWAUlwAelLEDUbwmWNrJTRLX2wmLtGdQ==
X-Received: by 2002:a1c:6a0e:0:b0:40c:2617:69c4 with SMTP id f14-20020a1c6a0e000000b0040c261769c4mr4879922wmc.78.1702551174764;
        Thu, 14 Dec 2023 02:52:54 -0800 (PST)
Received: from ta2.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c468700b0040c420eda48sm17614854wmo.22.2023.12.14.02.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:52:54 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     peter.griffin@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org,
        alim.akhtar@samsung.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        s.nawrocki@samsung.com, tomasz.figa@gmail.com,
        cw00.choi@samsung.com, arnd@arndb.de, semen.protsenko@linaro.org
Cc:     andre.draszik@linaro.org, saravanak@google.com,
        willmcvicker@google.com, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 03/13] dt-bindings: i2c: exynos5: add google,gs101-hsi2c compatible
Date:   Thu, 14 Dec 2023 10:52:33 +0000
Message-ID: <20231214105243.3707730-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add google,gs101-hsi2c dedicated compatible for representing
I2C of Google GS101 SoC.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml b/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml
index df9c57bca2a8..cc8bba5537b9 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml
@@ -33,6 +33,7 @@ properties:
           - const: samsung,exynos7-hsi2c
       - items:
           - enum:
+              - google,gs101-hsi2c
               - samsung,exynos850-hsi2c
           - const: samsung,exynosautov9-hsi2c
       - const: samsung,exynos5-hsi2c    # Exynos5250 and Exynos5420
-- 
2.43.0.472.g3155946c3a-goog

