Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FF180AF0D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbjLHVzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574800AbjLHVzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:55:38 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFBD1985
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 13:55:44 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c29f7b068so23132535e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 13:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702072542; x=1702677342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tf5qCRqNW7wSqrSaZ/MpVTnmBC6rjggpOIt26/5/rF4=;
        b=s6AH6aeHfAx5R2zteupW/ZMaTjJ4/vA7uuIVFDcTrVR6dMMgdX8fKQHXlTYKkp72Ef
         TYGyJzgnMIx1oG137MSVrRhrR50iXJ2j1+WUVGfpMP+d2os2SIQ3gOMP+SuBg1GZ3Io+
         EEfFIFO0477ruX+60jeBNnGQD7WU7Fk4iR0eWKaKA6t9HhaUYx0QgKq6ag2dCdePHpg9
         /i1mWsbiNHOljUWBl+QTJ9eaKeJS9BauQWsMVZMKStMurrqLNZ/eQeA/sVco8TZDAOi7
         exp4aMIeBLi5BXUNuSqFL2jBMW9IqCjx2o7QJQTqX908QgYcJmRoXx36UHpvKs98ee7q
         oxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702072542; x=1702677342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tf5qCRqNW7wSqrSaZ/MpVTnmBC6rjggpOIt26/5/rF4=;
        b=oAhHqbjTFb5Ail+5nGujVtkr2PGjLXDyYupbumYuT7GtKe6Vqqr0d9GC555h9eR66y
         i6c0bXsXu1p/nTjMIYx0/5mUBqheczZD5LRIXw2dKuSW1buyCcpmrbxn+fU/0Yd3Gdtt
         k7iOrPzDyxcZstJDxvI8xX41RTBP3Z2a7iBLv36qaqR1Az9g777WEVfcq7t9W2xZE/JB
         mMt5afWciI9hWhB/7PZ9emCZejSLmJgPmlnqr7YcwNYOhDJuVA9eCDBm3mrg3ybK4/PU
         hJllHCX+L7/3iBsu7bAt/66URgWvlvIGgVIDFJecU544qIeRnxl3bmXkR10BDIED6PFs
         /WMw==
X-Gm-Message-State: AOJu0YzWCJPe8Dji3mH94QfyyMumlCiQaV18QnnmoRGaENajwzOPq/+i
        yfR2tFlgvV6hYyyJr1jL1Vi7Fg==
X-Google-Smtp-Source: AGHT+IFWEhci0fEtEukd3igou6Vy0wS1pII1F1A+9TZmAR2o9jtREYIMfQEVFhfnbBdd+2QYw8I/fg==
X-Received: by 2002:a05:600c:8a4:b0:40b:5e59:b7d3 with SMTP id l36-20020a05600c08a400b0040b5e59b7d3mr309002wmp.176.1702072542434;
        Fri, 08 Dec 2023 13:55:42 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c459400b0040b349c91acsm6321789wmo.16.2023.12.08.13.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 13:55:42 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Iskren Chernev <me@iskren.info>,
        Martin Botka <martin.botka@somainline.org>,
        Danila Tikhonov <danila@jiaxyga.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 02/10] dt-bindings: pinctrl: qcom,qdu1000-tlmm: restrict number of interrupts
Date:   Fri,  8 Dec 2023 22:55:26 +0100
Message-Id: <20231208215534.195854-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208215534.195854-1-krzysztof.kozlowski@linaro.org>
References: <20231208215534.195854-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QDU1000 TLMM pin controller comes with only one interrupt, so narrow
the number of interrupts previously defined in common TLMM bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml        | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
index 237cac4f6ce1..47363c23f4ea 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
@@ -23,7 +23,9 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
-- 
2.34.1

