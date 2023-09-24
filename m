Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744597ACB61
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 20:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjIXSdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 14:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXSdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 14:33:47 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99461E3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 11:33:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-401187f8071so34998845e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 11:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695580420; x=1696185220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7nT8sXRV37KYa74CvXJWM9/EJEehx06DaI5NqBrPJk=;
        b=OcG4ZenAqOGr2Hq1p5RAAC3mWNVt5sg7/uwqwWph3yEbQ7i6WaQlciIShnGDHioDpM
         0og16Gdp0kZkkn/831NKo7AdD6H4FApE8n5KiFlqIGpzZwGsQ5Qhm32NrOiLuFSIGKjV
         4csKrsQZ3LDwilVotJNTqke+GZisq00PM7KsxEbDoXwEMAYn4EeHbrQ9OWjZ7C2tAEb4
         J813RJySD3sUYHW9+ZVcBB/fBU0xJzxezvb0DOtHZn0uWjFAHMp1fXbZO54kjWwy6A1R
         pR0AVdnqPOrZgYLX9Ez5qHz0T+ZHpw1DvIm9w53fd5sHJemzsl5cKL6DVRY85Lg8NkPY
         LA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695580420; x=1696185220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7nT8sXRV37KYa74CvXJWM9/EJEehx06DaI5NqBrPJk=;
        b=QcIJd764s+XTalFPPA5uLFFnrA0ekZwlTk2CiM0V4aW1QPRHABzxLitI0sk2ke9hdX
         KoCve3U1DqcEomr6dBvw8sOkcCUtcamkW8q+dmmvBmHBk4HxJPfGz4y9mVFFqIWbRkFq
         jylTxzA6PLtNv7SXfyiBvipuItscpjwUxsK4Qr8Cq6SSCELGQvQbmm+E5IFn/xbSv0KY
         vXHuU48YO5ZzYHxCGvv2Bfqb1cBxCiYm6l0LIffhuRUUf1HK2FR4QYesZ0WeA+s+1O0k
         UbKJtXc93JCy9QS9TOK6QqSVfjryBZCTp2wcAGU8DSmzsKX09n4SRIM6YefkNGxBLNva
         meqQ==
X-Gm-Message-State: AOJu0YwqkvH+jpbrEXbeo7tOLkXgKPWMYtY5OUwDJwrn5zFnRNhM1JQ9
        KjwgS5Ua8DsIQpzaymFXmT0eHw==
X-Google-Smtp-Source: AGHT+IFVu5jnVcxO0oSHPDf57Cb+b10+I2/Y0w/bUNFsBygBYmaKYVh+Zt9KhvQVmtch/s8NePkFIQ==
X-Received: by 2002:a05:600c:1d18:b0:405:36f0:fa88 with SMTP id l24-20020a05600c1d1800b0040536f0fa88mr5757204wms.13.1695580420040;
        Sun, 24 Sep 2023 11:33:40 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id k10-20020adfd22a000000b0032320a9b010sm1972148wrh.28.2023.09.24.11.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 11:33:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH 1/2] ARM: dts: qcom: apq8064: drop label property from DSI
Date:   Sun, 24 Sep 2023 20:33:34 +0200
Message-Id: <20230924183335.49961-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

DSI node does not accept nor use "label" property:

  qcom-apq8064-asus-nexus7-flo.dtb: dsi@4700000: Unevaluated properties are not allowed ('label' was unexpected)

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 9e033dc6e391..7fd3f164e7d4 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -1270,7 +1270,6 @@ mmss_sfpb: syscon@5700000 {
 		dsi0: dsi@4700000 {
 			compatible = "qcom,apq8064-dsi-ctrl",
 				     "qcom,mdss-dsi-ctrl";
-			label = "MDSS DSI CTRL->0";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1

