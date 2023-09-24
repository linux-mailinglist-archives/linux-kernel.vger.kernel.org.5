Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995DE7ACB6A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 20:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjIXSj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 14:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjIXSj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 14:39:26 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD29FE3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 11:39:19 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40566f89f6eso20542755e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 11:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695580758; x=1696185558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o734mewGMtz+2kpo5WoDnDG7d6uU4MuaMiFRPG38+aw=;
        b=uOYTGBRhk284gNIbRFyO6MjIm9QNPAiC7zHwfGgAZt/lPcU3W6/gAy5aOAwY+3r/AJ
         2wsTZc2Y55xCKqlC2FKnbjARCPM5jqGBO0dAdQ4C6bPSe8rfOChmGaqmukf5WOxUgm2D
         QxNu7e67saaWvLD8L6BDQVM4mwAMK+TBXBebuGeclKABgmwjtdpO1+CXn9j1wKKbIISr
         C+Q46ISBsnPe02rpthkvfTgeHjilR2zs0HHSqYYqxseA/0OKv2jL8E6TsSwxldCRvbCd
         Fisb+jSS0h74ata5f5RndrnX64wfYDh83B2UkpE7iq00SN/UPTSbCbWoEWQj+0S12mNM
         fA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695580758; x=1696185558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o734mewGMtz+2kpo5WoDnDG7d6uU4MuaMiFRPG38+aw=;
        b=R1P21SvV1VuB2cogaWhLA5OwLlhaYdsiQWlvLm4SQERZscKx2J6qFMqrMlXDLuzB3T
         685p2RIRO6PLTC3uk1zXXRoa7G42b2qHRNsnS0DQ6JfcHriYDGUaGAWfCnRgJTfylV4M
         yMmPCFjhdHuTUSpG1p0W0UGj/OAo1XZCJqPQN59AJBqFn2vFtiqGGM9cD+NRzqBP1zff
         1H1A18gNEf9lj7De7C1mSVsD/RI7YB9u+hXMikNMgDoHfr7Xnli/MaJMM9z2iVnPb0a7
         O+Hcszpd4VSgXCWaM+uREqtOLVbGCYnzlWLTOkV73ZgpU1X+iOBREq37GHyJ9/1KibTR
         +vvg==
X-Gm-Message-State: AOJu0Yzq7y2awDuRaqD7+loEezq1bbMn4toxu3DB+z4x4//1DFXnE2tW
        hIUjpcQpDUSY6maYHpDSTh/J2Q==
X-Google-Smtp-Source: AGHT+IG5UN9LXXSN96zid3SP8/ewFjj9oimFPhHYXF5OhA2nxG1Fa7TRXs8140wgRl9trJfDlcO3LQ==
X-Received: by 2002:a05:600c:22c9:b0:405:36a0:108f with SMTP id 9-20020a05600c22c900b0040536a0108fmr4263049wmg.41.1695580758059;
        Sun, 24 Sep 2023 11:39:18 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id v20-20020a05600c215400b00401b242e2e6sm7570446wml.47.2023.09.24.11.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 11:39:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH 1/4] ARM: dts: qcom: apq8064: drop incorrect regulator-type
Date:   Sun, 24 Sep 2023 20:39:11 +0200
Message-Id: <20230924183914.51414-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

regulator-fixed does not have a "regulator-type" property:

  qcom-apq8064-ifc6410.dtb: regulator-ext-3p3v: Unevaluated properties are not allowed ('regulator-type' was unexpected)

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts | 1 -
 arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts         | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts
index c57c27cd8a20..c0dd6399f597 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts
@@ -36,7 +36,6 @@ ext_3p3v: regulator-ext-3p3v {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		regulator-name = "ext_3p3v";
-		regulator-type = "voltage";
 		startup-delay-us = <0>;
 		gpio = <&tlmm_pinmux 77 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
index 96307550523a..b0c5e7bd5e74 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
@@ -58,7 +58,6 @@ ext_3p3v: regulator-ext-3p3v {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		regulator-name = "ext_3p3v";
-		regulator-type = "voltage";
 		startup-delay-us = <0>;
 		gpio = <&tlmm_pinmux 77 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
-- 
2.34.1

