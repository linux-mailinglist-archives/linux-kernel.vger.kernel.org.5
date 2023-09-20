Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFD17A7CFD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbjITMFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbjITMFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:05:49 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F7FC2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:05:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qivxT-0004MG-T3; Wed, 20 Sep 2023 14:05:31 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qivxR-007g38-VX; Wed, 20 Sep 2023 14:05:29 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qivxR-00BmIp-Ma; Wed, 20 Sep 2023 14:05:29 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>, stable@vger.kernel.org
Subject: [PATCH] ARM: dts: stm32: Fix ethernet pins used on phyCORE-STM32MP15
Date:   Wed, 20 Sep 2023 14:05:20 +0200
Message-Id: <20230920120520.2807275-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the phyCORE-STM32MP15 the 125MHz clock for the ethernet phy must
be provided on the ETH_RGMII_GTX_CLK. ETH_RGMII_CLK125 is unused though,
so remove the latter pin and add the former.

ethernet0_rgmii_pins_d and ethernet0_rgmii_sleep_pins_d are used by the
phyCORE-STM32MP15 board only, so we can do this change in the generic
pinctrl file without breaking other boards.

Fixes: 303f3fe1d88f ("ARM: dts: stm32: Add alternate pinmux for ethernet for stm32mp15")
Cc: stable@vger.kernel.org
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
index 098153ee99a3a..5d85bcc8b3a8c 100644
--- a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
@@ -354,7 +354,7 @@ pins1 {
 
 	ethernet0_rgmii_pins_d: rgmii-3 {
 		pins1 {
-			pinmux = <STM32_PINMUX('G', 5, AF11)>, /* ETH_RGMII_CLK125 */
+			pinmux = <STM32_PINMUX('G', 4, AF11)>, /* ETH_RGMII_GTX_CLK */
 				 <STM32_PINMUX('G', 13, AF11)>,	/* ETH_RGMII_TXD0 */
 				 <STM32_PINMUX('G', 14, AF11)>,	/* ETH_RGMII_TXD1 */
 				 <STM32_PINMUX('C', 2, AF11)>, /* ETH_RGMII_TXD2 */
@@ -384,8 +384,7 @@ pins3 {
 
 	ethernet0_rgmii_sleep_pins_d: rgmii-sleep-3 {
 		pins1 {
-			pinmux = <STM32_PINMUX('G', 5, ANALOG)>, /* ETH_RGMII_CLK125 */
-				 <STM32_PINMUX('G', 4, ANALOG)>, /* ETH_RGMII_GTX_CLK */
+			pinmux = <STM32_PINMUX('G', 4, ANALOG)>, /* ETH_RGMII_GTX_CLK */
 				 <STM32_PINMUX('G', 13, ANALOG)>, /* ETH_RGMII_TXD0 */
 				 <STM32_PINMUX('G', 14, ANALOG)>, /* ETH_RGMII_TXD1 */
 				 <STM32_PINMUX('C', 2, ANALOG)>, /* ETH_RGMII_TXD2 */
-- 
2.39.2

