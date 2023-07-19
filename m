Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D3B759185
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjGSJ0Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Jul 2023 05:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjGSJ0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:26:08 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C7A1BFD;
        Wed, 19 Jul 2023 02:25:55 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id C567D80DF;
        Wed, 19 Jul 2023 17:25:48 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Jul
 2023 17:25:48 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX068.cuchost.com (172.16.6.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Wed, 19 Jul 2023 17:25:47 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v5 3/3] riscv: dts: starfive: Add QSPI controller node for StarFive JH7110 SoC
Date:   Wed, 19 Jul 2023 17:25:45 +0800
Message-ID: <20230719092545.1961401-4-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230719092545.1961401-1-william.qiu@starfivetech.com>
References: <20230719092545.1961401-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the quad spi controller node for the StarFive JH7110 SoC.

Co-developed-by: Ziv Xu <ziv.xu@starfivetech.com>
Signed-off-by: Ziv Xu <ziv.xu@starfivetech.com>
Signed-off-by: William Qiu <william.qiu@starfivetech.com>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../jh7110-starfive-visionfive-2.dtsi         | 36 +++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 19 ++++++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index fa0061eb33a7..7f2d41ccc52d 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -143,6 +143,42 @@ &i2c6 {
 	status = "okay";
 };
 
+&qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	nor_flash: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		cdns,read-delay = <5>;
+		spi-max-frequency = <12000000>;
+		cdns,tshsl-ns = <1>;
+		cdns,tsd2d-ns = <1>;
+		cdns,tchsh-ns = <1>;
+		cdns,tslch-ns = <1>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			spl@0 {
+				reg = <0x0 0x80000>;
+			};
+			uboot-env@f0000 {
+				reg = <0xf0000 0x10000>;
+			};
+			uboot@100000 {
+				reg = <0x100000 0x400000>;
+			};
+			reserved-data@600000 {
+				reg = <0x600000 0x1000000>;
+			};
+		};
+	};
+};
+
 &sysgpio {
 	i2c0_pins: i2c0-0 {
 		i2c-pins {
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index ec2e70011a73..9740adc9df4e 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -473,6 +473,25 @@ i2c6: i2c@12060000 {
 			status = "disabled";
 		};
 
+		qspi: spi@13010000 {
+			compatible = "starfive,jh7110-qspi", "cdns,qspi-nor";
+			reg = <0x0 0x13010000 0x0 0x10000>,
+			      <0x0 0x21000000 0x0 0x400000>;
+			interrupts = <25>;
+			clocks = <&syscrg JH7110_SYSCLK_QSPI_REF>,
+				 <&syscrg JH7110_SYSCLK_QSPI_AHB>,
+				 <&syscrg JH7110_SYSCLK_QSPI_APB>;
+			clock-names = "ref", "ahb", "apb";
+			resets = <&syscrg JH7110_SYSRST_QSPI_APB>,
+				 <&syscrg JH7110_SYSRST_QSPI_AHB>,
+				 <&syscrg JH7110_SYSRST_QSPI_REF>;
+			reset-names = "qspi", "qspi-ocp", "rstc_ref";
+			cdns,fifo-depth = <256>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x0>;
+			status = "disabled";
+		};
+
 		syscrg: clock-controller@13020000 {
 			compatible = "starfive,jh7110-syscrg";
 			reg = <0x0 0x13020000 0x0 0x10000>;
-- 
2.34.1

