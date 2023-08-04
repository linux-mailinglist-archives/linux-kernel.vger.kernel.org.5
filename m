Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD375770B98
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 00:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjHDWBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 18:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjHDWBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 18:01:50 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8B5E4D;
        Fri,  4 Aug 2023 15:01:48 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 374M1cR7083782;
        Fri, 4 Aug 2023 17:01:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691186498;
        bh=xh4QWflwFh1VrWsPfERiHsrWdrU5pmhbYrYKpe1LEqw=;
        h=From:To:CC:Subject:Date;
        b=g4KAwgDyCbkFsFvbJexA1wQFOV6+lyTvM5mUr3s0iz4sFRi08a1lNfKPbyKbX+IJA
         mUjPB6TBmQ5fH0Tn5IA14vAeZIiYyNGjgCU5vdjuL6Ir2wTV8dkaYLze5D595dsBCZ
         WHb9kCO3Mi5bXb+VWK7jy6ZzLo+4s00tmQ0Vy3Dk=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 374M1ciK121296
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Aug 2023 17:01:38 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Aug 2023 17:01:37 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Aug 2023 17:01:37 -0500
Received: from uda0498204.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 374M1bM8014195;
        Fri, 4 Aug 2023 17:01:37 -0500
From:   Judith Mendez <jm@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2]  arm64: dts: ti: k3-am62a7: Add MCU MCAN nodes
Date:   Fri, 4 Aug 2023 17:01:37 -0500
Message-ID: <20230804220137.425442-1-jm@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On AM62ax there are no hardware interrupts routed to A53 GIC
interrupt controller for MCU MCAN IPs, so MCU MCAN nodes were
omitted from MCU dtsi.

Timer polling was introduced in commits [1][2] enabling 3x MCAN
on AM62ax, so now add MCU MCAN nodes to the mcu dtsi for the Cortex A53.

[1] commit b382380c0d2d ("can: m_can: Add hrtimer to generate software interrupt")
[2] commit bb410c03b999 ("dt-bindings: net: can: Remove interrupt properties for MCAN")

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v1:
- fixed CAN node name can@4e0000 to can@4e08000
---
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
index 04599762c2b7..a6d16a94088c 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
@@ -143,4 +143,28 @@ mcu_rti0: watchdog@4880000 {
 		/* Tightly coupled to M4F */
 		status = "reserved";
 	};
+
+	mcu_mcan0: can@4e08000 {
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
+	mcu_mcan1: can@4e18000 {
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
2.34.1

