Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555CE80A188
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573666AbjLHKwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573453AbjLHKwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:52:03 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D748171C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:52:09 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a1da1017a09so233856966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 02:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702032727; x=1702637527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yFkfEp12aI+6U4wU/tq2gheT7TJS/3Q4MuYssvsV5A=;
        b=M0Rz45jhRNrG+xtYKkVM6CRyO6pyceWKHaE6n+QuV0gBqAjk9meLRq4zCCqMcfSjkS
         6hB5SvwddqVNQ6NSVVkSSlj2l4UIXHkYvQmjMNNauDhLDq5wYee1Jvwa2YzHDsKcUOyd
         r9MWgzAuTQyIGyN0fBYwTYd9xGJYYNuvRYi3S4dZGJDOuW9O2UUM9eoDp3WxYl0S/UgJ
         qZlLdh4YJY4rpWzftbmyRB76lDmLL8RvGMIfwrY+hoZxakVHNjrE1HSHsIxBQ0Ux9LfG
         HVXbMiVAAa/vQfHwNFNFPtfVeIvku6gI0tW9MLkkedR+Z4/ZxPxkfKNW13U0A5SeDaj8
         cZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702032727; x=1702637527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yFkfEp12aI+6U4wU/tq2gheT7TJS/3Q4MuYssvsV5A=;
        b=IWjLiQahItZH15vcvy0Wwcir1C3ylEOWhaKnl8TdkLCtcCL1qBxBBMA93nU5jwASTL
         EoH6Jl9Yi4MvqwJGZlGoGzq5199C7vUJ3QbD6Z7tJNuzVNITSJ8rx3EyuVbwSL2iMeOC
         aXyVcet4uUpqq7E47MxGiHj8FGo5irGmsmc98ENto52zCOUg+jkTBOA1UVWeB8yX2Uh9
         k7lPrgoMTLm8K1h+uO61J5KQ7+59MU15N71GFvFfAJ9l2UmCRg6XA+LqVxnJVXLqV1B9
         HLyYLvL2iA/UURBQPtu4lXc2jaT/13sAhB5YKhPBwFpKmbL5fL5NmE3rzW2mXPVy0h0Y
         pQBA==
X-Gm-Message-State: AOJu0YwkgKNtMHB14fFxbkY200uElV+51WIDl7hV4gTMnrUp8gpXqqnZ
        NVcb54XzdiR7EJjyoKS/71ed2w==
X-Google-Smtp-Source: AGHT+IFVGSGWzV2Nk5abJTsBLjnttS05N2wFp85PjCkHQOAwQbKVVnCvVck7KrGQlppIg477ctFxeg==
X-Received: by 2002:a17:906:a856:b0:9e0:4910:166a with SMTP id dx22-20020a170906a85600b009e04910166amr2681680ejb.32.1702032727601;
        Fri, 08 Dec 2023 02:52:07 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id tx17-20020a1709078e9100b00a1b75e0e061sm849976ejc.130.2023.12.08.02.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 02:52:07 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 4/4] arm64: dts: qcom: sm8150: add necessary ref clock to PCIe
Date:   Fri,  8 Dec 2023 11:51:55 +0100
Message-Id: <20231208105155.36097-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208105155.36097-1-krzysztof.kozlowski@linaro.org>
References: <20231208105155.36097-1-krzysztof.kozlowski@linaro.org>
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

The PCIe nodes should get the ref clock, according to information from
Qualcomm.

Link: https://lore.kernel.org/all/20231121065440.GB3315@thinkpad/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Patch should go via Qcom tree, if the bindings get accepted.

Changes in v3:
1. New patch
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 5edc557ba04a..22ee3cd5549d 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1858,14 +1858,16 @@ pcie0: pci@1c00000 {
 				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
 				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
 				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
-				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "pipe",
 				      "aux",
 				      "cfg",
 				      "bus_master",
 				      "bus_slave",
 				      "slave_q2a",
-				      "tbu";
+				      "tbu",
+				      "ref";
 
 			iommu-map = <0x0   &apps_smmu 0x1d80 0x1>,
 				    <0x100 &apps_smmu 0x1d81 0x1>;
@@ -1949,14 +1951,16 @@ pcie1: pci@1c08000 {
 				 <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
 				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
 				 <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>,
-				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "pipe",
 				      "aux",
 				      "cfg",
 				      "bus_master",
 				      "bus_slave",
 				      "slave_q2a",
-				      "tbu";
+				      "tbu",
+				      "ref";
 
 			assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
 			assigned-clock-rates = <19200000>;
-- 
2.34.1

