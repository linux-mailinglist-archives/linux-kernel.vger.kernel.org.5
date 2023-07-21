Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC9675BCFE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 05:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjGUDwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 23:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjGUDwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 23:52:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5296A2D56
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 20:52:11 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qMhBL-0005xp-AC; Fri, 21 Jul 2023 05:51:55 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qMhBJ-000yi9-KE; Fri, 21 Jul 2023 05:51:53 +0200
Received: from localhost ([::1] helo=dude03.red.stw.pengutronix.de)
        by dude03.red.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qMhBI-002zpJ-UD; Fri, 21 Jul 2023 05:51:53 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
Date:   Fri, 21 Jul 2023 05:51:48 +0200
Subject: [PATCH v2] arm64: dts: imx8mp: use correct clock for eqos
 timestamping counter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230719-imx8mp_enet_qos_use_125mhz_clock-v2-1-eed15d74bfd1@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIANMAumQC/5WOSw6CMBRFt0I6toZXlY8j92FIU8qTvggttkBQw
 t6t7MDhOYN77soCesLArsnKPM4UyNkI4pAwbZRtkVMTmYlUnNIcSk79UvSDRIujfLkgp4ASxKU
 3H6k7p58c9DkD0GVe1orFmVoF5LVXVps4ZKeui3Lw+KBl796ryIbC6Px7vzHDz/5RnIEDzwuhS
 6UzBAG3AW07jd5ZWo4Nsmrbti+Rpowu6gAAAA==
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     patchwork-jzi@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johannes Zink <j.zink@pengutronix.de>
X-Mailer: b4 0.12.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8MP Reference Manual rev 1 06/2021, section 11.7.2.5 "Timestamp
Support" indicates the PTP timestamp clock expects a typical frequency
of 125MHz.

As this also improves the precision of the measured timestamps: assign
appropriate 125MHz Clock parent. As no one except the timestamping
counter uses this clock, there are no side-effects of this change in
other peripherals.

Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
---
Changes in v2:
- not only set assigned-clock-parents but alkso assigned-clock-rates for
  IMX8MP_CLK_ENET_QOS_TIMER to 125MHz (found by Fabio's review -
  thanks!)
- Link to v1: https://lore.kernel.org/r/20230719-imx8mp_enet_qos_use_125mhz_clock-v1-1-782c9ac6e121@pengutronix.de
---
Changes:
  v1 -> v2: Worked in Fabio's Feedback - Thank you for your review!
             - not only set assigned clock parent to 125MHz but also
	       set the assigned clock rate of IMX8MP_CLK_ENET_QOS_TIMER
	       to 125MHz
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 6f2f50e1639c..84ecf07affb3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1334,9 +1334,9 @@ eqos: ethernet@30bf0000 {
 						  <&clk IMX8MP_CLK_ENET_QOS_TIMER>,
 						  <&clk IMX8MP_CLK_ENET_QOS>;
 				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_266M>,
-							 <&clk IMX8MP_SYS_PLL2_100M>,
+							 <&clk IMX8MP_SYS_PLL2_125M>,
 							 <&clk IMX8MP_SYS_PLL2_125M>;
-				assigned-clock-rates = <0>, <100000000>, <125000000>;
+				assigned-clock-rates = <0>, <125000000>, <125000000>;
 				nvmem-cells = <&eth_mac2>;
 				nvmem-cell-names = "mac-address";
 				intf_mode = <&gpr 0x4>;

---
base-commit: ba345b77fae7054d0cbd033283c47033e45db6d8
change-id: 20230719-imx8mp_enet_qos_use_125mhz_clock-1c4611c979ba

Best regards,
-- 
Johannes Zink <j.zink@pengutronix.de>

