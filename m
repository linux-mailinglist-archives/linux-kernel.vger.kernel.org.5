Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB3F7C5D34
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376321AbjJKS4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345779AbjJKSzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:55:54 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C8794
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:55:52 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-405361bb94eso2996405e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697050550; x=1697655350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nweWobJWJBf+E3jMJor/bM09luKRlFeXTfeRgH/BAFs=;
        b=k9EF5CFaYuvgCm/9gG2zY4OXlqlMaDpCbTGRzANwxmMlWOAt4MzTW/gQC6zESQfqrb
         cdlnW3cWf/FBJmocM1+PZ2/8UtFdOB9l9+pAH7qsAGH5oEiXAEm8pxxMslg9ZnQc/c4g
         RFIhl8dQtIgrh27SMohFOge46UBccTjHPgjiCmVWdbOZdteUDG7wYrcpIS8HqhJuDSGP
         MTJ4XGS95R7aC+Cpp0QcXP5EL0rnXilfzCW0ZxNEX6kPb6V3KFp8sp6OneGdtRSR2DZZ
         P/5OYg8rxsepcj17i+OUa9DYt93C1oVzb2uZAgdRao/GG9GHbDqPhtXpLg4sxbm6EOZJ
         UjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697050550; x=1697655350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nweWobJWJBf+E3jMJor/bM09luKRlFeXTfeRgH/BAFs=;
        b=FsUhDPXXyXH56cVp0OgU543OipXbbCHRiNcN7+yjE4zKcpcBB9eXqa8Vwx893FZQue
         56H8QEp95mc5FqN64k/GfRF9enHgovtIkmsDGpBnHF8MMKZrGjl/00LsywDlhTnpAlo5
         EfRXGwHl1Loar0jYZt+P1MrcKAl9l8i3OI6XCWvyyezJSwKrUl0NcFooIml/ssuIf8Il
         E9q3YH9NlTBMQhyTtzGUxo24DJ7Ey4gAaQypFLkVaLx5Z+4o1gwmu3Aji4W8Bn4IU1SU
         S8ADmX41lD0IQcYoiYWRcFwzi9LAOHrMVUf9JfJsrfRfJ8qIWXs9Gx9jDa2mQwwv3lfg
         uTvw==
X-Gm-Message-State: AOJu0YxiKO98d7nwEMxU71Jfk5+YHiFUf7Ir+dd19LDPOKKvQElBx1L8
        oMvDD2nxVIEVXVkwxjfujB9m9Q==
X-Google-Smtp-Source: AGHT+IGfHfH/T8MhiI9Ttz/dhNl45IakVprsMIJoQxF3tsmX8wkQ9iJ+WswjOGxHMIe7xA+tb7TlGA==
X-Received: by 2002:a7b:cd11:0:b0:405:40ec:415d with SMTP id f17-20020a7bcd11000000b0040540ec415dmr19302522wmj.39.1697050550452;
        Wed, 11 Oct 2023 11:55:50 -0700 (PDT)
Received: from x13s-linux.nxsw.local ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bcbd6000000b004060f0a0fdbsm19928294wmi.41.2023.10.11.11.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 11:55:49 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        dmitry.baryshkov@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jonathan@marek.ca, quic_tdas@quicinc.com,
        vladimir.zapolskiy@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH v3 4/4] arm64: dts: qcom: sc8280xp: camss: Add CAMSS block definition
Date:   Wed, 11 Oct 2023 19:55:40 +0100
Message-Id: <20231011185540.2282975-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231011185540.2282975-1-bryan.odonoghue@linaro.org>
References: <20231011185540.2282975-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CAMSS block definition for sc8280xp.

This drop contains definitions for the following components on sc8280xp:

VFE * 4
VFE Lite * 4
CSID * 4
CSIPHY * 4

This dtsi definition has been developed and validated on a Lenovo X13s
laptop.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 285 +++++++++++++++++++++++++
 1 file changed, 285 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 22e9671af0e9..c1fac3e872f4 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -3615,6 +3615,291 @@ cci3_i2c1: i2c-bus@1 {
 			};
 		};
 
+		camss: camss@ac5a000 {
+			compatible = "qcom,sc8280xp-camss";
+
+			reg = <0 0x0ac5a000 0 0x2000>,
+			      <0 0x0ac5c000 0 0x2000>,
+			      <0 0x0ac65000 0 0x2000>,
+			      <0 0x0ac67000 0 0x2000>,
+			      <0 0x0acaf000 0 0x4000>,
+			      <0 0x0acb3000 0 0x1000>,
+			      <0 0x0acb6000 0 0x4000>,
+			      <0 0x0acba000 0 0x1000>,
+			      <0 0x0acbd000 0 0x4000>,
+			      <0 0x0acc1000 0 0x1000>,
+			      <0 0x0acc4000 0 0x4000>,
+			      <0 0x0acc8000 0 0x1000>,
+			      <0 0x0accb000 0 0x4000>,
+			      <0 0x0accf000 0 0x1000>,
+			      <0 0x0acd2000 0 0x4000>,
+			      <0 0x0acd6000 0 0x1000>,
+			      <0 0x0acd9000 0 0x4000>,
+			      <0 0x0acdd000 0 0x1000>,
+			      <0 0x0ace0000 0 0x4000>,
+			      <0 0x0ace4000 0 0x1000>;
+
+			reg-names = "csiphy2",
+				    "csiphy3",
+				    "csiphy0",
+				    "csiphy1",
+				    "vfe0",
+				    "csid0",
+				    "vfe1",
+				    "csid1",
+				    "vfe2",
+				    "csid2",
+				    "vfe_lite0",
+				    "csid0_lite",
+				    "vfe_lite1",
+				    "csid1_lite",
+				    "vfe_lite2",
+				    "csid2_lite",
+				    "vfe_lite3",
+				    "csid3_lite",
+				    "vfe3",
+				    "csid3";
+
+			interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 477 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 478 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 479 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 640 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 758 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 759 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 760 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 761 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 762 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 764 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-names = "csid1_lite",
+					  "vfe_lite1",
+					  "csiphy3",
+					  "csid0",
+					  "vfe0",
+					  "csid1",
+					  "vfe1",
+					  "csid0_lite",
+					  "vfe_lite0",
+					  "csiphy0",
+					  "csiphy1",
+					  "csiphy2",
+					  "csid2",
+					  "vfe2",
+					  "csid3_lite",
+					  "csid2_lite",
+					  "vfe_lite3",
+					  "vfe_lite2",
+					  "csid3",
+					  "vfe3";
+
+			power-domains = <&camcc IFE_0_GDSC>,
+					<&camcc IFE_1_GDSC>,
+					<&camcc IFE_2_GDSC>,
+					<&camcc IFE_3_GDSC>,
+					<&camcc TITAN_TOP_GDSC>;
+
+			power-domain-names = "ife0",
+					     "ife1",
+					     "ife2",
+					     "ife3",
+					     "top";
+
+			clocks = <&camcc CAMCC_CAMNOC_AXI_CLK>,
+				 <&camcc CAMCC_CAMNOC_AXI_CLK_SRC>,
+				 <&camcc CAMCC_CPAS_AHB_CLK>,
+				 <&camcc CAMCC_CPHY_RX_CLK_SRC>,
+				 <&camcc CAMCC_CSIPHY0_CLK>,
+				 <&camcc CAMCC_CSI0PHYTIMER_CLK_SRC>,
+				 <&camcc CAMCC_CSI0PHYTIMER_CLK>,
+				 <&camcc CAMCC_CSIPHY1_CLK>,
+				 <&camcc CAMCC_CSI1PHYTIMER_CLK_SRC>,
+				 <&camcc CAMCC_CSI1PHYTIMER_CLK>,
+				 <&camcc CAMCC_CSIPHY2_CLK>,
+				 <&camcc CAMCC_CSI2PHYTIMER_CLK_SRC>,
+				 <&camcc CAMCC_CSI2PHYTIMER_CLK>,
+				 <&camcc CAMCC_CSIPHY3_CLK>,
+				 <&camcc CAMCC_CSI3PHYTIMER_CLK_SRC>,
+				 <&camcc CAMCC_CSI3PHYTIMER_CLK>,
+				 <&camcc CAMCC_IFE_0_AXI_CLK>,
+				 <&camcc CAMCC_IFE_0_CLK_SRC>,
+				 <&camcc CAMCC_IFE_0_CLK>,
+				 <&camcc CAMCC_IFE_0_CPHY_RX_CLK>,
+				 <&camcc CAMCC_IFE_0_CSID_CLK_SRC>,
+				 <&camcc CAMCC_IFE_0_CSID_CLK>,
+				 <&camcc CAMCC_IFE_1_AXI_CLK>,
+				 <&camcc CAMCC_IFE_1_CLK_SRC>,
+				 <&camcc CAMCC_IFE_1_CLK>,
+				 <&camcc CAMCC_IFE_1_CPHY_RX_CLK>,
+				 <&camcc CAMCC_IFE_1_CSID_CLK_SRC>,
+				 <&camcc CAMCC_IFE_1_CSID_CLK>,
+				 <&camcc CAMCC_IFE_2_AXI_CLK>,
+				 <&camcc CAMCC_IFE_2_CLK_SRC>,
+				 <&camcc CAMCC_IFE_2_CLK>,
+				 <&camcc CAMCC_IFE_2_CPHY_RX_CLK>,
+				 <&camcc CAMCC_IFE_2_CSID_CLK_SRC>,
+				 <&camcc CAMCC_IFE_2_CSID_CLK>,
+				 <&camcc CAMCC_IFE_3_AXI_CLK>,
+				 <&camcc CAMCC_IFE_3_CLK_SRC>,
+				 <&camcc CAMCC_IFE_3_CLK>,
+				 <&camcc CAMCC_IFE_3_CPHY_RX_CLK>,
+				 <&camcc CAMCC_IFE_3_CSID_CLK_SRC>,
+				 <&camcc CAMCC_IFE_3_CSID_CLK>,
+				 <&camcc CAMCC_IFE_LITE_0_CLK_SRC>,
+				 <&camcc CAMCC_IFE_LITE_0_CLK>,
+				 <&camcc CAMCC_IFE_LITE_0_CPHY_RX_CLK>,
+				 <&camcc CAMCC_IFE_LITE_0_CSID_CLK_SRC>,
+				 <&camcc CAMCC_IFE_LITE_0_CSID_CLK>,
+				 <&camcc CAMCC_IFE_LITE_1_CLK_SRC>,
+				 <&camcc CAMCC_IFE_LITE_1_CLK>,
+				 <&camcc CAMCC_IFE_LITE_1_CPHY_RX_CLK>,
+				 <&camcc CAMCC_IFE_LITE_1_CSID_CLK_SRC>,
+				 <&camcc CAMCC_IFE_LITE_1_CSID_CLK>,
+				 <&camcc CAMCC_IFE_LITE_2_CLK_SRC>,
+				 <&camcc CAMCC_IFE_LITE_2_CLK>,
+				 <&camcc CAMCC_IFE_LITE_2_CPHY_RX_CLK>,
+				 <&camcc CAMCC_IFE_LITE_2_CSID_CLK_SRC>,
+				 <&camcc CAMCC_IFE_LITE_2_CSID_CLK>,
+				 <&camcc CAMCC_IFE_LITE_3_CLK_SRC>,
+				 <&camcc CAMCC_IFE_LITE_3_CLK>,
+				 <&camcc CAMCC_IFE_LITE_3_CPHY_RX_CLK>,
+				 <&camcc CAMCC_IFE_LITE_3_CSID_CLK_SRC>,
+				 <&camcc CAMCC_IFE_LITE_3_CSID_CLK>,
+				 <&gcc GCC_CAMERA_HF_AXI_CLK>,
+				 <&gcc GCC_CAMERA_SF_AXI_CLK>,
+				 <&camcc CAMCC_SLOW_AHB_CLK_SRC>;
+
+			clock-names = "camnoc_axi",
+				      "camnoc_axi_src",
+				      "cpas_ahb",
+				      "cphy_rx_src",
+				      "csiphy0",
+				      "csiphy0_timer_src",
+				      "csiphy0_timer",
+				      "csiphy1",
+				      "csiphy1_timer_src",
+				      "csiphy1_timer",
+				      "csiphy2",
+				      "csiphy2_timer_src",
+				      "csiphy2_timer",
+				      "csiphy3",
+				      "csiphy3_timer_src",
+				      "csiphy3_timer",
+				      "vfe0_axi",
+				      "vfe0_src",
+				      "vfe0",
+				      "vfe0_cphy_rx",
+				      "vfe0_csid_src",
+				      "vfe0_csid",
+				      "vfe1_axi",
+				      "vfe1_src",
+				      "vfe1",
+				      "vfe1_cphy_rx",
+				      "vfe1_csid_src",
+				      "vfe1_csid",
+				      "vfe2_axi",
+				      "vfe2_src",
+				      "vfe2",
+				      "vfe2_cphy_rx",
+				      "vfe2_csid_src",
+				      "vfe2_csid",
+				      "vfe3_axi",
+				      "vfe3_src",
+				      "vfe3",
+				      "vfe3_cphy_rx",
+				      "vfe3_csid_src",
+				      "vfe3_csid",
+				      "vfe_lite0_src",
+				      "vfe_lite0",
+				      "vfe_lite0_cphy_rx",
+				      "vfe_lite0_csid_src",
+				      "vfe_lite0_csid",
+				      "vfe_lite1_src",
+				      "vfe_lite1",
+				      "vfe_lite1_cphy_rx",
+				      "vfe_lite1_csid_src",
+				      "vfe_lite1_csid",
+				      "vfe_lite2_src",
+				      "vfe_lite2",
+				      "vfe_lite2_cphy_rx",
+				      "vfe_lite2_csid_src",
+				      "vfe_lite2_csid",
+				      "vfe_lite3_src",
+				      "vfe_lite3",
+				      "vfe_lite3_cphy_rx",
+				      "vfe_lite3_csid_src",
+				      "vfe_lite3_csid",
+				      "gcc_axi_hf",
+				      "gcc_axi_sf",
+				      "slow_ahb_src";
+
+			iommus = <&apps_smmu 0x2000 0x4e0>,
+				 <&apps_smmu 0x2020 0x4e0>,
+				 <&apps_smmu 0x2040 0x4e0>,
+				 <&apps_smmu 0x2060 0x4e0>,
+				 <&apps_smmu 0x2080 0x4e0>,
+				 <&apps_smmu 0x20e0 0x4e0>,
+				 <&apps_smmu 0x20c0 0x4e0>,
+				 <&apps_smmu 0x20a0 0x4e0>,
+				 <&apps_smmu 0x2400 0x4e0>,
+				 <&apps_smmu 0x2420 0x4e0>,
+				 <&apps_smmu 0x2440 0x4e0>,
+				 <&apps_smmu 0x2460 0x4e0>,
+				 <&apps_smmu 0x2480 0x4e0>,
+				 <&apps_smmu 0x24e0 0x4e0>,
+				 <&apps_smmu 0x24c0 0x4e0>,
+				 <&apps_smmu 0x24a0 0x4e0>;
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_CAMERA_CFG 0>,
+					<&mmss_noc MASTER_CAMNOC_HF 0 &mc_virt SLAVE_EBI1 0>,
+					<&mmss_noc MASTER_CAMNOC_SF 0 &mc_virt SLAVE_EBI1 0>,
+					<&mmss_noc MASTER_CAMNOC_ICP 0 &mc_virt SLAVE_EBI1 0>;
+			interconnect-names = "cam_ahb",
+					     "cam_hf_mnoc",
+					     "cam_sf_mnoc",
+					     "cam_sf_icp_mnoc";
+
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				port@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				port@2 {
+					reg = <2>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				port@3 {
+					reg = <3>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+			};
+		};
+
 		camcc: clock-controller@ad00000 {
 			compatible = "qcom,sc8280xp-camcc";
 			reg = <0 0x0ad00000 0 0x20000>;
-- 
2.40.1

