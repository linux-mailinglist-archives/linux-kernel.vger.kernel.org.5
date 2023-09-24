Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246497ACB59
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 20:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjIXSbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 14:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjIXSbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 14:31:17 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAE6FE
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 11:31:09 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bdcade7fbso601630066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 11:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695580268; x=1696185068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B3uSP3o9ardRpaQhkEgd5zKh22mwy8MCGageBq+4jv0=;
        b=xl99iM4XN/rKttbXBDK7NKPRl7tqueh7EpwMXyuNt8rSD2T9rsoKb9USBvyxXEOgPp
         /VInR4z45NuoOSZE7hAMj8qWUv4JXfsqmhb2AnMWn/vlyPQOlCsZZcq6WtuKqtaA8EE3
         9jrGRH9HLvYr3P2uN8YajnpJ2pzj6yC2D0Yb8GuXWrBVT/RKFjots7wRYcu9i4bi8fvt
         Wy/egsUUHaKWlK8IPW9o9JzMIArgg+mw77VMPLVO9xmmMnzZLAlSbI9UkIe9H42/FNGh
         kGBcRnk1VMwP5lQuj1QAovpXTwva9rAkbZr49hTeqcF+0rGvyBU6cRNUt4rZqycraMCG
         DfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695580268; x=1696185068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B3uSP3o9ardRpaQhkEgd5zKh22mwy8MCGageBq+4jv0=;
        b=pC8FATx9gdK3sqZSih2GSMen2eSg1BHBLqQ1R+oI3CVs/S2jPRtX6YhXQNcpm4Ve1T
         K3uisBNWx4yINnqTgCNttUl/TapCsmcdLdmNi/oqZz5pgSBc/yNaPXPOIIObItOWO3v1
         fx7rWbaXo/RgePTw69N5yhlrt8v55tQ2+9q8WeTZTqWpwaX8nH1wbt86r/QMm6NuEDKg
         pY4NQmWpJors8G5GpRTc5oSTQ3K4jvy1I8Kc4DTBX+dmSx18Gl1wNhslOLz771p7/cly
         BfCwCuMmAjSfGs6auqCBAiPb7peNLVIQCBSpnkNCRaoV3xsAP1ews3LL2EFWUHdMlcOF
         ZwDg==
X-Gm-Message-State: AOJu0Yynt3oxhXAarvDMl6ryaWDoxs/eJqSfzlTauBzaZRtR2Q2AlrUd
        Si/COPDgjgIKbbkmEnPMUUAPww==
X-Google-Smtp-Source: AGHT+IF28QSFVA9qjbvA3dya1Mq4QRPwYd9syrOpP+7JW6Xc61j2s4MuLrohjsyKHTizn7yuPtFUnA==
X-Received: by 2002:a17:906:fe0e:b0:9ae:63bd:e4bb with SMTP id wy14-20020a170906fe0e00b009ae63bde4bbmr5028616ejb.41.1695580268355;
        Sun, 24 Sep 2023 11:31:08 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id ty15-20020a170907c70f00b009ae6a6451fdsm4599845ejc.35.2023.09.24.11.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 11:31:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH 1/3] ARM: dts: qcom: sdx65: correct PCIe EP phy-names
Date:   Sun, 24 Sep 2023 20:31:01 +0200
Message-Id: <20230924183103.49487-1-krzysztof.kozlowski@linaro.org>
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

Qualcomm PCIe endpoint bindings expect phy-names to be "pciephy":

  arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dtb: pcie-ep@1c00000: phy-names:0: 'pciephy' was expected

Fixes: 9c0bb38414a4 ("ARM: dts: qcom: sdx65: Add support for PCIe EP")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
index dd711484dfc9..c9790217320b 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
@@ -337,7 +337,7 @@ pcie_ep: pcie-ep@1c00000 {
 			power-domains = <&gcc PCIE_GDSC>;
 
 			phys = <&pcie_phy>;
-			phy-names = "pcie-phy";
+			phy-names = "pciephy";
 
 			max-link-speed = <3>;
 			num-lanes = <2>;
-- 
2.34.1

