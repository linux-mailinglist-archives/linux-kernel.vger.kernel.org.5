Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C75A755A88
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 06:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjGQEJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 00:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjGQEIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 00:08:55 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Jul 2023 21:08:53 PDT
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E9D1AA
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 21:08:53 -0700 (PDT)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230717040750349f0ba14327c31c9c
        for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 06:07:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=huaqian.li@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Nj21lCdl8nb8wOaJjf94cou6OITTnAi/oVfGe4ko348=;
 b=eoZV0bRPzryisQa4vKAPfKQvEID9x2QvXYRc8XBGVtHruXc7Uq7All8KaSBDcNj+cPpUfn
 kMA7oQe4XRThHLUOU742XfDWuLRnQfvqeZNrfqCSR74e9oLnlvsnifXl0nrOzY3kwMGA0gED
 1FhezfXzv8C962zXJlcKyPKTmnc1A=;
From:   huaqian.li@siemens.com
To:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     huaqianlee@gmail.com, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jan.kiszka@siemens.com,
        baocheng.su@siemens.com, Li Hua Qian <huaqian.li@siemens.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: watchdog: ti,rti-wdt: Add support for WDIOF_CARDRESET
Date:   Mon, 17 Jul 2023 12:07:21 +0800
Message-Id: <20230717040723.1306374-2-huaqian.li@siemens.com>
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

TI RTI (Real Time Interrupt) Watchdog doesn't support to record the
watchdog cause. Add a reserved memory to know the last reboot was caused
by the watchdog card. In the reserved memory, some specific info will be
saved to indicate whether the watchdog reset was triggered in last
boot.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Conor Dooley <conor@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
---
 .../bindings/watchdog/ti,rti-wdt.yaml         | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml b/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
index fc553211e42d..4b66c4fcdf35 100644
--- a/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
@@ -34,6 +34,20 @@ properties:
   power-domains:
     maxItems: 1
 
+  memory-region:
+    maxItems: 1
+    description:
+      Contains the watchdog reserved memory. It is optional.
+      In the reserved memory, the specified values, which are
+      PON_REASON_SOF_NUM(0xBBBBCCCC), PON_REASON_MAGIC_NUM(0xDDDDDDDD),
+      and PON_REASON_EOF_NUM(0xCCCCBBBB), are pre-stored at the first
+      3 * 4 bytes to tell that last boot was caused by watchdog reset.
+      Once the PON reason is captured by driver(rti_wdt.c), the driver
+      is supposed to wipe the whole memory region. Surely, if this
+      property is set, at least 12 bytes reserved memory starting from
+      specific memory address(0xa220000) should be set. More please
+      refer to Example 2.
+
 required:
   - compatible
   - reg
@@ -59,3 +73,30 @@ examples:
         assigned-clocks = <&k3_clks 252 1>;
         assigned-clock-parents = <&k3_clks 252 5>;
     };
+
+  - |
+    // Example 2 (Add reserved memory for watchdog reset cause):
+    /*
+     * RTI WDT in main domain on J721e SoC. Assigned clocks are used to
+     * select the source clock for the watchdog, forcing it to tick with
+     * a 32kHz clock in this case. Add a reserved memory to keep the
+     * watchdog reset cause persistent, which was be written in 12 bytes
+     * starting from 0xa2200000 by RTI Watchdog Firmware.
+     *
+     * Reserved memory should be defined as follows:
+     * reserved-memory {
+     *     wdt_reset_memory_region: wdt-memory@a2200000 {
+     *         reg = <0x00 0xa2200000 0x00 0x1000>;
+     *         no-map;
+     *     };
+     * }
+     */
+    watchdog@40610000 {
+        compatible = "ti,j7-rti-wdt";
+        reg = <0x40610000 0x100>;
+        clocks = <&k3_clks 135 1>;
+        power-domains = <&k3_pds 135 TI_SCI_PD_EXCLUSIVE>;
+        assigned-clocks = <&k3_clks 135 0>;
+        assigned-clock-parents = <&k3_clks 135 4>;
+        memory-region = <&wdt_reset_memory_region>;
+    };
-- 
2.34.1

