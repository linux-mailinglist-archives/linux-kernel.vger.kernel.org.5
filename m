Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4544755A89
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 06:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjGQEJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 00:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjGQEJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 00:09:00 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Jul 2023 21:08:59 PDT
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4043A1B3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 21:08:59 -0700 (PDT)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230717040755c75821e66bdc3502f3
        for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 06:07:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=huaqian.li@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=l4ktlrcu4GUa4V9vRJv+/UGGmR9aCehF0jFIKJuers8=;
 b=I533ubOHe26F2Ci7FuX4+gwX/WdGYvl3rl0bv2dowZFJqtbKcfAqOdvjOtmp9bngE5TyN3
 UcBAlRBLJTLNOuy2KCMb690jbOAaBDWqPfrk092AONLvi9q6i0NalzKTRulzCF1vcsytz7u1
 Oggl198eRUu+q/psu1hVSVxAIhRns=;
From:   huaqian.li@siemens.com
To:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     huaqianlee@gmail.com, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jan.kiszka@siemens.com,
        baocheng.su@siemens.com, Li Hua Qian <huaqian.li@siemens.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [DONOTMERGE PATCH v4 2/3] arm64: dts: ti: Add reserved memory for watchdog
Date:   Mon, 17 Jul 2023 12:07:22 +0800
Message-Id: <20230717040723.1306374-3-huaqian.li@siemens.com>
In-Reply-To: <20230717040723.1306374-1-huaqian.li@siemens.com>
References: <20230717040723.1306374-1-huaqian.li@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-959203:519-21489:flowmailer
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Hua Qian <huaqian.li@siemens.com>

This patch adds a reserved memory for the TI AM65X platform watchdog to
reserve the specific info, triggering the watchdog reset in last boot,
to know if the board reboot is due to a watchdog reset.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
---
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index e26bd988e522..4bb20d493651 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -63,6 +63,12 @@ rtos_ipc_memory_region: ipc-memories@a2000000 {
 			alignment = <0x1000>;
 			no-map;
 		};
+
+		/* To reserve the power-on(PON) reason for watchdog reset */
+		wdt_reset_memory_region: wdt-memory@a2200000 {
+			reg = <0x00 0xa2200000 0x00 0x1000>;
+			no-map;
+		};
 	};
 
 	leds {
@@ -718,3 +724,7 @@ &mcu_r5fss0_core1 {
 			<&mcu_r5fss0_core1_memory_region>;
 	mboxes = <&mailbox0_cluster1>, <&mbox_mcu_r5fss0_core1>;
 };
+
+&mcu_rti1 {
+	memory-region = <&wdt_reset_memory_region>;
+};
-- 
2.34.1

