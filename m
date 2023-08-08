Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7640773B0F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 17:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjHHPkp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 8 Aug 2023 11:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjHHPkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:40:36 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7544106;
        Tue,  8 Aug 2023 08:36:28 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 3F9E524E287;
        Tue,  8 Aug 2023 14:12:03 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 8 Aug
 2023 14:12:03 +0800
Received: from ubuntu.localdomain (202.188.176.82) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 8 Aug
 2023 14:11:58 +0800
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] riscv: dts: starfive - Add crypto and DMA node for JH7110
Date:   Tue, 8 Aug 2023 14:11:49 +0800
Message-ID: <20230808061150.81491-2-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808061150.81491-1-jiajie.ho@starfivetech.com>
References: <20230808061150.81491-1-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hardware crypto module and dedicated dma controller node to StarFive
JH7110 SoC.

Co-developed-by: Huan Feng <huan.feng@starfivetech.com>
Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/boot/dts/starfive/jh7110.dtsi | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index a608433200e8..47cd12ccc988 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -821,6 +821,34 @@ watchdog@13070000 {
 				 <&syscrg JH7110_SYSRST_WDT_CORE>;
 		};
 
+		crypto: crypto@16000000 {
+			compatible = "starfive,jh7110-crypto";
+			reg = <0x0 0x16000000 0x0 0x4000>;
+			clocks = <&stgcrg JH7110_STGCLK_SEC_AHB>,
+				 <&stgcrg JH7110_STGCLK_SEC_MISC_AHB>;
+			clock-names = "hclk", "ahb";
+			interrupts = <28>;
+			resets = <&stgcrg JH7110_STGRST_SEC_AHB>;
+			dmas = <&sdma 1 2>, <&sdma 0 2>;
+			dma-names = "tx", "rx";
+		};
+
+		sdma: dma@16008000 {
+			compatible = "arm,pl080", "arm,primecell";
+			arm,primecell-periphid = <0x00041080>;
+			reg = <0x0 0x16008000 0x0 0x4000>;
+			interrupts = <29>;
+			clocks = <&stgcrg JH7110_STGCLK_SEC_AHB>,
+				 <&stgcrg JH7110_STGCLK_SEC_MISC_AHB>;
+			clock-names = "hclk", "apb_pclk";
+			resets = <&stgcrg JH7110_STGRST_SEC_AHB>;
+			lli-bus-interface-ahb1;
+			mem-bus-interface-ahb1;
+			memcpy-burst-size = <256>;
+			memcpy-bus-width = <32>;
+			#dma-cells = <2>;
+		};
+
 		gmac0: ethernet@16030000 {
 			compatible = "starfive,jh7110-dwmac", "snps,dwmac-5.20";
 			reg = <0x0 0x16030000 0x0 0x10000>;
-- 
2.34.1

