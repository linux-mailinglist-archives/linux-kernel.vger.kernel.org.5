Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A83C7B8CA4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244993AbjJDTNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245206AbjJDTNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:13:13 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7A5F2;
        Wed,  4 Oct 2023 12:13:08 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5344d996bedso176457a12.3;
        Wed, 04 Oct 2023 12:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696446787; x=1697051587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EAHnzBAVMvUdpdTTBnwVC8jLauXLK+oisY8K0JNNWaU=;
        b=VCaCY4NrmsNVzC3TD9zSnY9q9KAuxrtQD1W/UO/9REAyZ9uLk579fdvJY4WOvfF9Cc
         Ngbcx9OKJtwVeM+Uc/7+hnmO6Ps+i/7nir/mJH9EFOWsQnrZC9OrVhXg+CHmnao+KLfv
         kFoJENvOApfl5rmwl/auqXxeaSM3QofN2GGKrU4uRXILfL1gcT1krqGSbFWnIz39VKfp
         Rsym31H1k4HzJYlPba+M8XrZR85Q4cx9iM0fexolfu4q38NTTQITTiTFGV5l7vepB3Gp
         pwa8bIYigOpnrNdSYsNSKLgji+dWDN6HOcVfDaQ2U1Dhm/c4QV2ibG3J+tP4Bb9cZbYH
         y/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696446787; x=1697051587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAHnzBAVMvUdpdTTBnwVC8jLauXLK+oisY8K0JNNWaU=;
        b=jmYGfBosurxxFHxhol2o9zpfaepi8O4UUFIXTxlL0zqprI6V18uycRkTEFMNGVZJxl
         v1aMlrW0MqZz2I/m/EtjeeiMhJalnRTCZ0/Uqox3CeOxKNytGa8U/+x+M1Ar4dLpFtX/
         rqeRWQsTPaDg7lflLITPiNCD+XcKCZvRYNpKzOzosPNnOPh6b3Y9U6yFuk2/fzy7hjz9
         bVk5MZz0uBUozXVAbYq1mt+CksBFi+5e7VDWuN2fh5+mvZzBsOH2qF38bScMBfxvO7cV
         cC8R7au5jR6aL3ma6sMnOUFF4+ICr6wSGNXLA8WqnZdSIDMLYdY03XJXgw3gJ06G2dhF
         gJvA==
X-Gm-Message-State: AOJu0Yz8jfTXHSjbxNqu0t31/RHS9LL62KvI5Cl6RzCxolNHJrg1iO9V
        DOK5/MkzC4raHG9AUMaP0Pw=
X-Google-Smtp-Source: AGHT+IEJZy+/xQtB0u3r0lP+UkTmKWTM0JEart6uElbPDL+WpRiQXe1pVK+C9Djj4QE5jbLUay8rkA==
X-Received: by 2002:aa7:df86:0:b0:52a:1d54:2531 with SMTP id b6-20020aa7df86000000b0052a1d542531mr2731378edy.30.1696446786996;
        Wed, 04 Oct 2023 12:13:06 -0700 (PDT)
Received: from fedora.. (cpezg-94-253-131-161-cbl.xnet.hr. [94.253.131.161])
        by smtp.googlemail.com with ESMTPSA id p1-20020a056402044100b0053112d6a40esm274220edw.82.2023.10.04.12.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 12:13:06 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH] arm64: dts: qcom: ipq5018: add QUP1 SPI controller
Date:   Wed,  4 Oct 2023 21:12:30 +0200
Message-ID: <20231004191303.331055-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required BAM and QUP nodes for the QUP1 SPI controller on IPQ5018.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 38ffdc3cbdcd..484034e65f4f 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -146,6 +146,16 @@ sdhc_1: mmc@7804000 {
 			status = "disabled";
 		};
 
+		blsp_dma: dma-controller@7884000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x07884000 0x1d000>;
+			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+		};
+
 		blsp1_uart1: serial@78af000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0x078af000 0x200>;
@@ -156,6 +166,20 @@ blsp1_uart1: serial@78af000 {
 			status = "disabled";
 		};
 
+		blsp1_spi1: spi@78b5000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x78b5000 0x600>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp_dma 4>, <&blsp_dma 5>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
 		intc: interrupt-controller@b000000 {
 			compatible = "qcom,msm-qgic2";
 			reg = <0x0b000000 0x1000>,  /* GICD */
-- 
2.41.0

