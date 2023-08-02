Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D512976CBEC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbjHBLlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbjHBLlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:41:45 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EAF2695;
        Wed,  2 Aug 2023 04:41:40 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 372BfYPa116792;
        Wed, 2 Aug 2023 06:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690976494;
        bh=iiBbvgZRrd57qOqKAzEj05nOiffuzIZCpWjS9hmJzfw=;
        h=From:To:CC:Subject:Date;
        b=YsUutzJX7aLi1pbm37+3cx8Te2tl1w1Nx5sTCbiOiCYPQDCX0E2QErwdFbajeAAut
         2DQAx5hnlc3N00AmK+uc+epZJ60WEzBAl3vtaMQjXO7Wk/q1h3fIHy6Hefs63OcU0b
         ChLrbzR6ti9pq7iXCvs1d6FLcv585U2FmX6YoV8s=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 372BfY5c009180
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 06:41:34 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 06:41:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 06:41:34 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 372BfUaK015671;
        Wed, 2 Aug 2023 06:41:31 -0500
From:   Udit Kumar <u-kumar1@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <t-konduru@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vaishnav.a@ti.com>
CC:     Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v2] arm64: dts: ti: k3-j784s4-evm: Correct Pin mux offset for ospi
Date:   Wed, 2 Aug 2023 17:11:26 +0530
Message-ID: <20230802114126.162445-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After splitting wkup_pmx pin mux for J784S4 into four regions.
Pin mux offset for OSPI nodes were not updated to align with new
regions, due to this while setting ospi pin muxes out of range
error was seen.

Pin mux offsets for OSPI nodes are corrected in this patch.

Fixes: 14462bd0b247 ("arm64: dts: ti: k3-j784s4: Fix wakeup pinmux range and pinctrl node offsets")
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Logs
https://gist.github.com/uditkumarti/f3b1a5402f7202931a4b905f7d331502

Please apply patch https://lore.kernel.org/all/20230721082654.27036-1-tony@atomide.com/
before this

Change log:

Change in v2
  Changed name of pin mux to align with
  https://lore.kernel.org/all/20230721082654.27036-1-tony@atomide.com/ patch
  

v1: https://lore.kernel.org/all/20230801141920.3317697-1-u-kumar1@ti.com/
 
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 29 +++++++++++++++---------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 7ad152a1b90f..d594d233af87 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -379,21 +379,28 @@ J784S4_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (D34) MCU_OSPI0_D5 */
 			J784S4_WKUP_IOPAD(0x024, PIN_INPUT, 0) /* (E34) MCU_OSPI0_D6 */
 			J784S4_WKUP_IOPAD(0x028, PIN_INPUT, 0) /* (E33) MCU_OSPI0_D7 */
 			J784S4_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (C34) MCU_OSPI0_DQS */
-			J784S4_WKUP_IOPAD(0x03c, PIN_OUTPUT, 6) /* (C32) MCU_OSPI0_CSn3.MCU_OSPI0_ECC_FAIL */
-			J784S4_WKUP_IOPAD(0x038, PIN_OUTPUT, 6) /* (B34) MCU_OSPI0_CSn2.MCU_OSPI0_RESET_OUT0 */
+		>;
+	};
+};
+
+&wkup_pmx1 {
+	mcu_fss0_ospi0_1_pins_default: mcu-fss0-ospi0-1-default-pins {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x004, PIN_OUTPUT, 6) /* (C32) MCU_OSPI0_ECC_FAIL */
+			J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 6) /* (B34) MCU_OSPI0_RESET_OUT0 */
 		>;
 	};
 
 	mcu_fss0_ospi1_pins_default: mcu-fss0-ospi1-default-pins {
 		pinctrl-single,pins = <
-			J784S4_WKUP_IOPAD(0x040, PIN_OUTPUT, 0) /* (F32) MCU_OSPI1_CLK */
-			J784S4_WKUP_IOPAD(0x05c, PIN_OUTPUT, 0) /* (G32) MCU_OSPI1_CSn0 */
-			J784S4_WKUP_IOPAD(0x04c, PIN_INPUT, 0) /* (E35) MCU_OSPI1_D0 */
-			J784S4_WKUP_IOPAD(0x050, PIN_INPUT, 0) /* (D31) MCU_OSPI1_D1 */
-			J784S4_WKUP_IOPAD(0x054, PIN_INPUT, 0) /* (G31) MCU_OSPI1_D2 */
-			J784S4_WKUP_IOPAD(0x058, PIN_INPUT, 0) /* (F33) MCU_OSPI1_D3 */
-			J784S4_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (F31) MCU_OSPI1_DQS */
-			J784S4_WKUP_IOPAD(0x044, PIN_INPUT, 0) /* (C31) MCU_OSPI1_LBCLKO */
+			J784S4_WKUP_IOPAD(0x008, PIN_OUTPUT, 0) /* (F32) MCU_OSPI1_CLK */
+			J784S4_WKUP_IOPAD(0x024, PIN_OUTPUT, 0) /* (G32) MCU_OSPI1_CSn0 */
+			J784S4_WKUP_IOPAD(0x014, PIN_INPUT, 0) /* (E35) MCU_OSPI1_D0 */
+			J784S4_WKUP_IOPAD(0x018, PIN_INPUT, 0) /* (D31) MCU_OSPI1_D1 */
+			J784S4_WKUP_IOPAD(0x01C, PIN_INPUT, 0) /* (G31) MCU_OSPI1_D2 */
+			J784S4_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (F33) MCU_OSPI1_D3 */
+			J784S4_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (F31) MCU_OSPI1_DQS */
+			J784S4_WKUP_IOPAD(0x00C, PIN_INPUT, 0) /* (C31) MCU_OSPI1_LBCLKO */
 		>;
 	};
 };
@@ -437,7 +444,7 @@ &fss {
 &ospi0 {
 	status = "okay";
 	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
+	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>, <&mcu_fss0_ospi0_1_pins_default>;
 
 	flash@0 {
 		compatible = "jedec,spi-nor";
-- 
2.34.1

