Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBC87FDA31
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbjK2OpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbjK2Oot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:44:49 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F4C19B6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:44:40 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so931858566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701269079; x=1701873879; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ArxmGTuasEnRlnJedexYoaMiR+r6QmCY16PmyIYu1Y=;
        b=MIU7KkJCBxDkLgojpRx7U+uAAmZV5TVrROY8sxjuA4rSMi7J+jab41o15Fz+VvCATn
         ysRXhn97q4Wkg7oTYOU0As/wupzltmekg2I932gPndEIC7Ai29tjXAPly5YPFVSR7VE6
         zhTd4RODCvX81OcVKSVWgqB64AMqeiieP4SfqqZSrnZe+y3t+j+qAlaqyeKlGSOEzx7X
         ryfdwtQrpl08BR2okNjb9M2wtkY34NaTHx3QKXci6VkSl5AYo8VquguAKuh1dbS7O62E
         QPebcIqxWeGw5wecocpfa9TpMscO5AX9LeLI1CaRU2B2UTRE32QzjRT5FHXUHaRK0rs4
         dd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269079; x=1701873879;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ArxmGTuasEnRlnJedexYoaMiR+r6QmCY16PmyIYu1Y=;
        b=xGcRUtgT6Lyi86xqSypKH3/WY0x7fXu5cswsSqHkOgQwZw12jRpLdZuTcczcaoiTIg
         N7N412k6sWmSEE3ldDvFNRcg481iKP2pxkOhog/ToORcnkkitpJ1jTBT4NlXn1qtOJUE
         dNChMLcis0ZHOxm8eXxYsY5X9MYTM5Kd4YOdbfNfQ/GzQ6ADFf7LftD0lipDvCswAjo9
         Vg7rZVE0lD+hrYpL7ziCmKdt7zPlyPP0oH0jZ4O/At0B++c7foFy+FzBylUWfE8dN2Pz
         ZaO6ML5XDu0IZOiU5eEBBuVuGcKKhPRYlRqFQpKOmpyhw3h3Ym3xkh1zVviF5zDJAgo2
         8gWg==
X-Gm-Message-State: AOJu0YwJ4fmz+y2KUWLxtoCMaviRh9V3+F79v+UjOEHFBrh3wrLB/bQS
        h2gac33x9PX1ZvrZTkAZ+PugVg==
X-Google-Smtp-Source: AGHT+IGYsCuMDMdskqT2AuNcN1ljYfV/daW2yay9NQMH8jxFaDdds8TbhGEwNo1x89PRFxAzb/M81w==
X-Received: by 2002:a17:906:5299:b0:a00:8706:c82e with SMTP id c25-20020a170906529900b00a008706c82emr14605737ejm.18.1701269078724;
        Wed, 29 Nov 2023 06:44:38 -0800 (PST)
Received: from [10.167.154.1] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id e27-20020a1709062c1b00b009fda627abd9sm7913738ejh.79.2023.11.29.06.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:44:38 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 29 Nov 2023 15:44:06 +0100
Subject: [PATCH v3 09/12] arm64: dts: qcom: qcm2290: Hook up interconnects
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v3-9-4cbb567743bb@linaro.org>
References: <20231125-topic-rb1_feat-v3-0-4cbb567743bb@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v3-0-4cbb567743bb@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701269042; l=14879;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=dLqoGET9tn1puitB1HEu3fgL7xJQCptLABDspKb19VY=;
 b=41P8HCtj3oJlg8OdWFIQx6YYgnQWLvXjunmGRwQ8XsqoXZrOdUwHgsbyYYpujqGEFlL80uCWc
 PvbxVU2JN+6ABmvN1GhvoFo9KXsEefkgEdv9x+uWpUf6Kmi6pYI3mjp
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interconnect provider nodes and hook up interconnects to consumer
devices, including bwmon.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcm2290.dtsi | 248 ++++++++++++++++++++++++++++++++++
 1 file changed, 248 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index a3edc4667cc5..ce04d0acdede 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -12,6 +12,8 @@
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interconnect/qcom,qcm2290.h>
+#include <dt-bindings/interconnect/qcom,rpm-icc.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 
 / {
@@ -151,6 +153,8 @@ scm: scm {
 			clocks = <&rpmcc RPM_SMD_CE1_CLK>;
 			clock-names = "core";
 			#reset-cells = <1>;
+			interconnects = <&system_noc MASTER_CRYPTO_CORE0 RPM_ALWAYS_TAG
+					 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>;
 		};
 	};
 
@@ -669,6 +673,33 @@ usb_qmpphy: phy@1615000 {
 			status = "disabled";
 		};
 
+		system_noc: interconnect@1880000 {
+			compatible = "qcom,qcm2290-snoc";
+			reg = <0x0 0x01880000 0x0 0x60200>;
+			#interconnect-cells = <2>;
+
+			qup_virt: interconnect-qup {
+				compatible = "qcom,qcm2290-qup-virt";
+				#interconnect-cells = <2>;
+			};
+
+			mmnrt_virt: interconnect-mmnrt {
+				compatible = "qcom,qcm2290-mmnrt-virt";
+				#interconnect-cells = <2>;
+			};
+
+			mmrt_virt: interconnect-mmrt {
+				compatible = "qcom,qcm2290-mmrt-virt";
+				#interconnect-cells = <2>;
+			};
+		};
+
+		config_noc: interconnect@1900000 {
+			compatible = "qcom,qcm2290-cnoc";
+			reg = <0x0 0x01900000 0x0 0x8200>;
+			#interconnect-cells = <2>;
+		};
+
 		qfprom@1b44000 {
 			compatible = "qcom,qcm2290-qfprom", "qcom,qfprom";
 			reg = <0x0 0x01b44000 0x0 0x3000>;
@@ -681,6 +712,60 @@ qusb2_hstx_trim: hstx-trim@25b {
 			};
 		};
 
+		pmu@1b8e300 {
+			compatible = "qcom,qcm2290-cpu-bwmon", "qcom,sdm845-bwmon";
+			reg = <0x0 0x01b8e300 0x0 0x600>;
+			interrupts = <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>;
+
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+			interconnects = <&bimc MASTER_APPSS_PROC RPM_ACTIVE_TAG
+					 &bimc SLAVE_EBI1 RPM_ACTIVE_TAG>;
+
+			cpu_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <(200 * 4 * 1000)>;
+				};
+
+				opp-1 {
+					opp-peak-kBps = <(300 * 4 * 1000)>;
+				};
+
+				opp-2 {
+					opp-peak-kBps = <(451 * 4 * 1000)>;
+				};
+
+				opp-3 {
+					opp-peak-kBps = <(547 * 4 * 1000)>;
+				};
+
+				opp-4 {
+					opp-peak-kBps = <(681 * 4 * 1000)>;
+				};
+
+				opp-5 {
+					opp-peak-kBps = <(768 * 4 * 1000)>;
+				};
+
+				opp-6 {
+					opp-peak-kBps = <(1017 * 4 * 1000)>;
+				};
+
+				opp-7 {
+					opp-peak-kBps = <(1353 * 4 * 1000)>;
+				};
+
+				opp-8 {
+					opp-peak-kBps = <(1555 * 4 * 1000)>;
+				};
+
+				opp-9 {
+					opp-peak-kBps = <(1804 * 4 * 1000)>;
+				};
+			};
+		};
+
 		spmi_bus: spmi@1c40000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0x0 0x01c40000 0x0 0x1100>,
@@ -721,6 +806,12 @@ rng: rng@4453000 {
 			clock-names = "core";
 		};
 
+		bimc: interconnect@4480000 {
+			compatible = "qcom,qcm2290-bimc";
+			reg = <0x0 0x04480000 0x0 0x80000>;
+			#interconnect-cells = <2>;
+		};
+
 		rpm_msg_ram: sram@45f0000 {
 			compatible = "qcom,rpm-msg-ram";
 			reg = <0x0 0x045f0000 0x0 0x7000>;
@@ -756,13 +847,45 @@ sdhc_1: mmc@4744000 {
 			resets = <&gcc GCC_SDCC1_BCR>;
 
 			power-domains = <&rpmpd QCM2290_VDDCX>;
+			operating-points-v2 = <&sdhc1_opp_table>;
 			iommus = <&apps_smmu 0xc0 0x0>;
+			interconnects = <&system_noc MASTER_SDCC_1 RPM_ALWAYS_TAG
+					 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>,
+					<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+					 &config_noc SLAVE_SDCC_1 RPM_ALWAYS_TAG>;
+			interconnect-names = "sdhc-ddr",
+					     "cpu-sdhc";
 
 			qcom,dll-config = <0x000f642c>;
 			qcom,ddr-config = <0x80040868>;
 			bus-width = <8>;
 
 			status = "disabled";
+
+			sdhc1_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmpd_opp_low_svs>;
+					opp-peak-kBps = <250000 133320>;
+					opp-avg-kBps = <102400 65000>;
+				};
+
+				opp-192000000 {
+					opp-hz = /bits/ 64 <192000000>;
+					required-opps = <&rpmpd_opp_low_svs>;
+					opp-peak-kBps = <800000 300000>;
+					opp-avg-kBps = <204800 200000>;
+				};
+
+				opp-384000000 {
+					opp-hz = /bits/ 64 <384000000>;
+					required-opps = <&rpmpd_opp_svs_plus>;
+					opp-peak-kBps = <800000 300000>;
+					opp-avg-kBps = <204800 200000>;
+				};
+			};
 		};
 
 		sdhc_2: mmc@4784000 {
@@ -786,6 +909,12 @@ sdhc_2: mmc@4784000 {
 			power-domains = <&rpmpd QCM2290_VDDCX>;
 			operating-points-v2 = <&sdhc2_opp_table>;
 			iommus = <&apps_smmu 0xa0 0x0>;
+			interconnects = <&system_noc MASTER_SDCC_2 RPM_ALWAYS_TAG
+					 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>,
+					<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+					 &config_noc SLAVE_SDCC_2 RPM_ALWAYS_TAG>;
+			interconnect-names = "sdhc-ddr",
+					     "cpu-sdhc";
 
 			qcom,dll-config = <0x0007642c>;
 			qcom,ddr-config = <0x80040868>;
@@ -799,11 +928,15 @@ sdhc2_opp_table: opp-table {
 				opp-100000000 {
 					opp-hz = /bits/ 64 <100000000>;
 					required-opps = <&rpmpd_opp_low_svs>;
+					opp-peak-kBps = <250000 133320>;
+					opp-avg-kBps = <261438 150000>;
 				};
 
 				opp-202000000 {
 					opp-hz = /bits/ 64 <202000000>;
 					required-opps = <&rpmpd_opp_svs_plus>;
+					opp-peak-kBps = <800000 300000>;
+					opp-avg-kBps = <261438 300000>;
 				};
 			};
 		};
@@ -851,6 +984,15 @@ i2c0: i2c@4a80000 {
 				dmas = <&gpi_dma0 0 0 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 0 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -867,6 +1009,12 @@ spi0: spi@4a80000 {
 				dmas = <&gpi_dma0 0 0 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 0 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -880,6 +1028,12 @@ uart0: serial@4a80000 {
 				clock-names = "se";
 				pinctrl-0 = <&qup_uart0_default>;
 				pinctrl-names = "default";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
 				status = "disabled";
 			};
 
@@ -894,6 +1048,15 @@ i2c1: i2c@4a84000 {
 				dmas = <&gpi_dma0 0 1 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 1 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -910,6 +1073,12 @@ spi1: spi@4a84000 {
 				dmas = <&gpi_dma0 0 1 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 1 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -926,6 +1095,15 @@ i2c2: i2c@4a88000 {
 				dmas = <&gpi_dma0 0 2 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 2 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -942,6 +1120,12 @@ spi2: spi@4a88000 {
 				dmas = <&gpi_dma0 0 2 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 2 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -958,6 +1142,15 @@ i2c3: i2c@4a8c000 {
 				dmas = <&gpi_dma0 0 3 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 3 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -974,6 +1167,12 @@ spi3: spi@4a8c000 {
 				dmas = <&gpi_dma0 0 3 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 3 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -990,6 +1189,15 @@ i2c4: i2c@4a90000 {
 				dmas = <&gpi_dma0 0 4 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 4 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -1006,6 +1214,12 @@ spi4: spi@4a90000 {
 				dmas = <&gpi_dma0 0 4 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 4 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -1019,6 +1233,12 @@ uart4: serial@4a90000 {
 				clock-names = "se";
 				pinctrl-0 = <&qup_uart4_default>;
 				pinctrl-names = "default";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
 				status = "disabled";
 			};
 
@@ -1033,6 +1253,15 @@ i2c5: i2c@4a94000 {
 				dmas = <&gpi_dma0 0 5 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 5 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -1049,6 +1278,12 @@ spi5: spi@4a94000 {
 				dmas = <&gpi_dma0 0 5 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 5 QCOM_GPI_SPI>;
 				dma-names = "tx", "rx";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -1081,6 +1316,13 @@ usb: usb@4ef8800 {
 
 			resets = <&gcc GCC_USB30_PRIM_BCR>;
 			power-domains = <&gcc GCC_USB30_PRIM_GDSC>;
+			/* TODO: USB<->IPA path */
+			interconnects = <&system_noc MASTER_USB3_0 RPM_ALWAYS_TAG
+					 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>,
+					<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+					 &config_noc SLAVE_USB3 RPM_ALWAYS_TAG>;
+			interconnect-names = "usb-ddr",
+					     "apps-usb";
 			wakeup-source;
 
 			#address-cells = <2>;
@@ -1127,6 +1369,12 @@ mdss: display-subsystem@5e00000 {
 
 			iommus = <&apps_smmu 0x420 0x2>,
 				 <&apps_smmu 0x421 0x0>;
+			interconnects = <&mmrt_virt MASTER_MDP0 RPM_ALWAYS_TAG
+					 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>,
+					<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+					 &config_noc SLAVE_DISPLAY_CFG RPM_ALWAYS_TAG>;
+			interconnect-names = "mdp0-mem",
+					     "cpu-cfg";
 
 			#address-cells = <2>;
 			#size-cells = <2>;

-- 
2.43.0

