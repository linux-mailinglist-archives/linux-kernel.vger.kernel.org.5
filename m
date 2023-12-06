Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F396D80715B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378722AbjLFN4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378755AbjLFNzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:55:52 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988EE12B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:55:58 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6ce831cbba6so495163b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 05:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701870958; x=1702475758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/GG08EU0jxNkkKUCidTdbhniPCzW7PlAscumj7h9J4=;
        b=rcGjNgMhn4E9Lr1j2wB5mI0hnxTwNdnxQj3v1AcKksdt2uQ38fRwFiOpMDlAXLYPlG
         B8xsSQLSKtEJ3UJt8qOU2ZUe61t6n0wfTsL1vICNpXHfbzp180n02Qm8tToZb2awCQDq
         WcjgF4M9Fa9DaoQJIeYdAscXua93mWMcU83ag0GIAMOoNGWlkfHgYihN63ZLlJEmyq8l
         +1zd/fHudFJUDsLAk8tSAzRRKk/BRSJ7IntTlAjnpXke7iVPV+XOO1b0mTSqDIVGoO/x
         ePUFbO3dPy81sHmf6fOM3weayM+xqf5v0KxTBy8pahpoXIyEs+qcrjfaMz8pLvFewhY9
         LMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701870958; x=1702475758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/GG08EU0jxNkkKUCidTdbhniPCzW7PlAscumj7h9J4=;
        b=PoZnWPKCnjPrcU5qTDdci+CYjTcLM6bkO+6Q60SJowd7HEvL0naSjWu2KrJMCM2Yb/
         72WrKij97gSohVygyZsLe6GpFKyPtsdlvyFwF5PVd3kx2oiEI/TcvMT+FiAfztsmtFVY
         zlVSwhxuaBIZyoy10r24rbES7IEiDwS9n8pZwXiPA8Pu1VD8/XQoRBk68h6JucwYxANI
         GaCnMlfOxIQvrFQ1eEaDulDHG68gs+/qEAM8bVhS+qgyplWk+m1YGBEdZAMMg2nlayhD
         0SezY2fW1K3bwCDzwiOS7GgFNg1Jz4BsbaH6RB2DT5dEQ+i50sY0DbyVLgJ25gkPRbmO
         7LRA==
X-Gm-Message-State: AOJu0YwbOp5/YzrJ5TYrz/l3u2no7CibEcNt/+Gw2wS4/dINrTfk7+dh
        zkYC3FEem+e1kdmxr/CL1ql5
X-Google-Smtp-Source: AGHT+IEYj6PxW5OwqK1BCLicNLKZlz98ScmeI30pYPwjQqRCo1HKvD012fhsCDVxxUfV58CUVy2xYg==
X-Received: by 2002:a05:6a00:2da1:b0:6ce:6cf3:38b4 with SMTP id fb33-20020a056a002da100b006ce6cf338b4mr779742pfb.1.1701870957926;
        Wed, 06 Dec 2023 05:55:57 -0800 (PST)
Received: from localhost.localdomain ([117.202.188.104])
        by smtp.gmail.com with ESMTPSA id n38-20020a056a000d6600b006ce91cdb1c4sm1366056pfv.188.2023.12.06.05.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 05:55:57 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/3] ARM: dts: qcom: Use "pcie" as the node name instead of "pci"
Date:   Wed,  6 Dec 2023 19:25:38 +0530
Message-Id: <20231206135540.17068-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206135540.17068-1-manivannan.sadhasivam@linaro.org>
References: <20231206135540.17068-1-manivannan.sadhasivam@linaro.org>
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

Qcom SoCs doesn't support the legacy PCI, but only PCIe. So use the correct
node name for the controller instances.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi           | 2 +-
 arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk04.1.dtsi | 2 +-
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi           | 2 +-
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi           | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 59fd86b9fb47..fa3a0f72a18e 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -1472,7 +1472,7 @@ gfx3d1: iommu@7d00000 {
 			qcom,ncb = <3>;
 		};
 
-		pcie: pci@1b500000 {
+		pcie: pcie@1b500000 {
 			compatible = "qcom,pcie-apq8064";
 			reg = <0x1b500000 0x1000>,
 			      <0x1b502000 0x80>,
diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk04.1.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk04.1.dtsi
index 468ebc40d2ad..374af6dd360a 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk04.1.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk04.1.dtsi
@@ -98,7 +98,7 @@ flash@0 {
 			};
 		};
 
-		pci@40000000 {
+		pcie@40000000 {
 			status = "okay";
 			perst-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
index 9844e0b7cff9..6cbbccda5cf5 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
@@ -417,7 +417,7 @@ restart@4ab000 {
 			reg = <0x4ab000 0x4>;
 		};
 
-		pcie0: pci@40000000 {
+		pcie0: pcie@40000000 {
 			compatible = "qcom,pcie-ipq4019";
 			reg = <0x40000000 0xf1d>,
 			      <0x40000f20 0xa8>,
diff --git a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
index 6198f42f6a9c..7c233b00a2dd 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
@@ -1076,7 +1076,7 @@ sata_phy: sata-phy@1b400000 {
 			status = "disabled";
 		};
 
-		pcie0: pci@1b500000 {
+		pcie0: pcie@1b500000 {
 			compatible = "qcom,pcie-ipq8064";
 			reg = <0x1b500000 0x1000
 			       0x1b502000 0x80
@@ -1127,7 +1127,7 @@ pcie0: pci@1b500000 {
 			perst-gpios = <&qcom_pinmux 3 GPIO_ACTIVE_LOW>;
 		};
 
-		pcie1: pci@1b700000 {
+		pcie1: pcie@1b700000 {
 			compatible = "qcom,pcie-ipq8064";
 			reg = <0x1b700000 0x1000
 			       0x1b702000 0x80
@@ -1178,7 +1178,7 @@ pcie1: pci@1b700000 {
 			perst-gpios = <&qcom_pinmux 48 GPIO_ACTIVE_LOW>;
 		};
 
-		pcie2: pci@1b900000 {
+		pcie2: pcie@1b900000 {
 			compatible = "qcom,pcie-ipq8064";
 			reg = <0x1b900000 0x1000
 			       0x1b902000 0x80
-- 
2.25.1

