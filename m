Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9503789DDF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 14:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjH0M3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 08:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjH0M2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 08:28:48 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A7E13D
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 05:28:45 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso160953066b.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 05:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693139324; x=1693744124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BIQMZSplS2rE5HA4WckOVzu7Ot+7UVATUf/Pm8921WU=;
        b=yZF6sOQpHQDVi+FDWxMHhoUHRNfXzeOwnMTvx+WroZJFJQCITvayI9bwsLfXFiOtLR
         PqzPwRlBKPnjUN9cT8z+gCLxbfKHX0tQaYscTXY/DtwjMHBWDyoTfkqGDy9yx3q1hfki
         ddY9XwSmdsuGbv8i5KfbDxACrhUdL/cSp4BJ3B3aSHd4tIpDSTYDscAaZmNHyA3ZNoco
         tp2GcbXZcg3dvkMpHUqbR2ing1V9feI07Sg3PQaCwNcIz+gY2HwCL0qL7uhQ7MJFRto1
         z3peGpQoq1p65LGvVf1h7RMxE9jvBHd6EHV/JG2suRjbGN88EhsWEIBi/Nlue9kd771I
         bDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693139324; x=1693744124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIQMZSplS2rE5HA4WckOVzu7Ot+7UVATUf/Pm8921WU=;
        b=IWcOP1HS7WBus/38X1aa5GbrUaF+DPful2jhvKO5MAk4pY8iVJN1id3GvDbAVJBccc
         xcQomd+gQxKDyMjf5Te3eUSOYDvXB/Mku425i1f25297V2kuIMYj1Ul/0G1Tdiz2590k
         NsJgWGb8d6ho7swew96OxLXl+KfbsZPnIXip2G+I7JjLHx9MRRbC1rxFp74sWD6iA1sr
         Ne4TlZy45Kjio/DJbD0UXsh3X0PWUyk9N2B+BcbXyVX/ytLj1Ju8QbVpU24uy+3qULRx
         x+7Mgz7xudYMSQwo5WK9aQVmjbDjzz0AoyIouYz6Ovt3aq54Ju9UgrhlPnfusX1DYHft
         VxzQ==
X-Gm-Message-State: AOJu0YxPxK/ZljqQLRJ88C5WHinc0JIjnufJ/MxB4qWSdKvhhe2raLDa
        3567yEQQuvN46cxTP6IKq+tSgg==
X-Google-Smtp-Source: AGHT+IF+so4Fk2URicgubG6xO1HCg+IhCafYbleB6GezafBokdUts2/y7TkO16ff8XY0B5bTecgBhg==
X-Received: by 2002:a17:906:3156:b0:9a1:f81f:d0df with SMTP id e22-20020a170906315600b009a1f81fd0dfmr8070915eje.69.1693139324343;
        Sun, 27 Aug 2023 05:28:44 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id rp25-20020a170906d97900b00993150e5325sm3384826ejb.60.2023.08.27.05.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 05:28:43 -0700 (PDT)
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
Subject: [PATCH 1/3] ARM: dts: qcom: drop incorrect cell-index from SPMI
Date:   Sun, 27 Aug 2023 14:28:40 +0200
Message-Id: <20230827122842.63741-1-krzysztof.kozlowski@linaro.org>
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

The SPMI controller (PMIC Arbiter) does not use nor allow 'cell-index'
property:

  qcom-sdx55-mtp.dtb: spmi@c440000: Unevaluated properties are not allowed ('cell-index' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 1 -
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
index 9c02d88e8eae..03da1ac9e43d 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
@@ -641,7 +641,6 @@ spmi_bus: spmi@c440000 {
 			#size-cells = <0>;
 			interrupt-controller;
 			#interrupt-cells = <4>;
-			cell-index = <0>;
 		};
 
 		tlmm: pinctrl@f100000 {
diff --git a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
index ff596215ae3c..49c16ee2e169 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
@@ -551,7 +551,6 @@ spmi_bus: spmi@c440000 {
 			#interrupt-cells = <4>;
 			#address-cells = <2>;
 			#size-cells = <0>;
-			cell-index = <0>;
 			qcom,channel = <0>;
 			qcom,ee = <0>;
 		};
-- 
2.34.1

