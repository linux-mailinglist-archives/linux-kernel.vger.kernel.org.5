Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1494B78895A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245382AbjHYN5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245407AbjHYN4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:56:45 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07C8213C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:56:17 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-986d8332f50so123284466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692971776; x=1693576576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w4S/486KI99IgVxS//09Pi+67Km5MqzlPqKe04mHux0=;
        b=XOxSgHq31YEIdOEVbj395OFOh1xbnCh+JyPnXTYGIdlJQBSwit5JOXfZOsDRwDwtqI
         NDknvI7rG4dhfLArSdSXGFNv6ZZjiFSHc7gOMM8odUh3S8XUQDP2PO4Fb1k472AGUh09
         rFDr9+1oh1YbysWtBRUZOYdBobp0sKQPTANEN7rXwifH/78ttQbj+kjGBqJgnyTOqpmi
         LZcN2T7eqbZslJgfllvCuuxZf04gDbSYtxLRtik4FmhEc9HiRSkH7jFfsf165lTiO2rT
         TZrPq0cVyVnfd34h2RkcMBatZBNPyj8DF228JG+pU9lEKU6TEzSD7+PW8piLSDIvvpMC
         JbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692971776; x=1693576576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w4S/486KI99IgVxS//09Pi+67Km5MqzlPqKe04mHux0=;
        b=FIgA5MKOPWX5ed++dUIHMk40vP8S3BqEauDFCBcvK8l5q571M5nNVp2KhD1g2VTv/V
         faAOyN6/gs9LDleuRqKngYmpkpxG8sC1mWPZxhLg448PRKWZbXFVfEZvGXd7yYvEV06V
         7zwMi5ujlo/4lUAi5u9lMY4BqEPi15j61mo2kHhQj7Q3Gxo/PtE8YZOiBDqS4QpGGcmT
         OHOqSy7mvt1sQJwSPiXTqyR2YDvWmEO5oT32A/Re/kpsm6FxFA++LGfCWpwp6Uyon421
         QGVDJ3OqEfI5+PBlc4BzIZ7fnv8e3F6NTq1nTorNpJBSjBFU0JqEn3H6M8BcJAxWqYsx
         OrhQ==
X-Gm-Message-State: AOJu0YyMOm2x4npNATWAMxo8IUn23GHjCpmbqcG3uIGXR93uyNk6XZOh
        Cx69I7TwUVJoBsPBcZJ/JbZ7Gw==
X-Google-Smtp-Source: AGHT+IFQY18OP1q3DvcBtXlhiDCwGFDqdukR7qlw0f7QEue2hW4Y7Ixg2Fj2tMcXGFUydqgcfY0b2Q==
X-Received: by 2002:a17:906:1dd:b0:9a1:b967:aca9 with SMTP id 29-20020a17090601dd00b009a1b967aca9mr8021299ejj.63.1692971776014;
        Fri, 25 Aug 2023 06:56:16 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id mh2-20020a170906eb8200b0099b76c3041csm991608ejb.7.2023.08.25.06.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 06:56:15 -0700 (PDT)
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
Subject: [PATCH 1/2] ARM: dts: qcom: apq8064: drop label property from DSI
Date:   Fri, 25 Aug 2023 15:56:12 +0200
Message-Id: <20230825135613.282505-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSI node does not accept nor use "label" property:

  qcom-apq8064-asus-nexus7-flo.dtb: dsi@4700000: Unevaluated properties are not allowed ('label' was unexpected)

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

