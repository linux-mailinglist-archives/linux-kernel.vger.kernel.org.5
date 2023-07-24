Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA1175F8AA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjGXNjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjGXNjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:39:33 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A6D449A;
        Mon, 24 Jul 2023 06:37:31 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 31577209B1;
        Mon, 24 Jul 2023 15:36:36 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Judith Mendez <jm@ti.com>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 1/2] arm64: dts: ti: k3-am62: Add MCU MCAN nodes
Date:   Mon, 24 Jul 2023 15:36:11 +0200
Message-Id: <20230724133612.37366-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230724133612.37366-1-francesco@dolcini.it>
References: <20230724133612.37366-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Judith Mendez <jm@ti.com>

On AM62x there are no hardware interrupts routed to A53 GIC
interrupt controller for MCU MCAN IPs, so MCU MCAN nodes were
omitted from MCU dtsi.

Timer polling was introduced in commits [1][2] so now add MCU MCAN nodes
to the MCU dtsi for the Cortex A53.

[1] b382380c0d2d ("can: m_can: Add hrtimer to generate software interrupt")
[2] bb410c03b999 ("dt-bindings: net: can: Remove interrupt properties for MCAN")

Signed-off-by: Judith Mendez <jm@ti.com>
[fd: fixed labels to match datasheet numbering, revised commit message,
     fixed reg/reg-names order]
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
index 19fc38157d94..fed50666d95b 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
@@ -147,4 +147,28 @@ mcu_rti0: watchdog@4880000 {
 		/* Tightly coupled to M4F */
 		status = "reserved";
 	};
+
+	mcu_mcan0: can@4e00000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x4e08000 0x00 0x200>,
+		      <0x00 0x4e00000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 188 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 188 6>, <&k3_clks 188 1>;
+		clock-names = "hclk", "cclk";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	mcu_mcan1: can@4e10000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x4e18000 0x00 0x200>,
+		      <0x00 0x4e10000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 189 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 189 6>, <&k3_clks 189 1>;
+		clock-names = "hclk", "cclk";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
 };
-- 
2.25.1

