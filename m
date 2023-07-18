Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CA77571A1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 04:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGRCMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 22:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjGRCML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 22:12:11 -0400
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C166718B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 19:12:10 -0700 (PDT)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230718021208943314f10d940433bd
        for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 04:12:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=huaqian.li@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=vEfG2f2hKFjYPDbtni2Sf1EWNty8c+MQ8mKXu1AGvg4=;
 b=FbaaJlzbyMrzBrhY5dASym6cN28TZwgAH66Fb22taNFT4Sb4nkLkQI+HVfpPLAwRlH0KMw
 NUz4W+21tgSLaeyZcq70UKaATlwVEUPkg7UYg5rHJXu30/ftL28AIRcpQB9ZGf/LYqzxhZc0
 4f9T5WMIqEv3GVHIernqriojWv6lk=;
From:   huaqian.li@siemens.com
To:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     huaqianlee@gmail.com, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jan.kiszka@siemens.com,
        baocheng.su@siemens.com, Li Hua Qian <huaqian.li@siemens.com>
Subject: [PATCH v6 1/3] dt-bindings: watchdog: ti,rti-wdt: Add support for WDIOF_CARDRESET
Date:   Tue, 18 Jul 2023 10:10:05 +0800
Message-Id: <20230718021007.1338761-2-huaqian.li@siemens.com>
In-Reply-To: <20230718021007.1338761-1-huaqian.li@siemens.com>
References: <20230718021007.1338761-1-huaqian.li@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-959203:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
---
 .../bindings/watchdog/ti,rti-wdt.yaml         | 28 ++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml b/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
index fc553211e42d..9d847e4b7278 100644
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
+      refer to example.
+
 required:
   - compatible
   - reg
@@ -47,7 +61,18 @@ examples:
     /*
      * RTI WDT in main domain on J721e SoC. Assigned clocks are used to
      * select the source clock for the watchdog, forcing it to tick with
-     * a 32kHz clock in this case.
+     * a 32kHz clock in this case. Add a reserved memory(optional) to keep
+     * the watchdog reset cause persistent, which was be written in 12 bytes
+     * starting from 0xa2200000 by RTI Watchdog Firmware, then make it
+     * possible to get watchdog reset cause in driver.
+     *
+     * Reserved memory should be defined as follows:
+     * reserved-memory {
+     *     wdt_reset_memory_region: wdt-memory@a2200000 {
+     *         reg = <0x00 0xa2200000 0x00 0x1000>;
+     *         no-map;
+     *     };
+     * }
      */
     #include <dt-bindings/soc/ti,sci_pm_domain.h>
 
@@ -58,4 +83,5 @@ examples:
         power-domains = <&k3_pds 252 TI_SCI_PD_EXCLUSIVE>;
         assigned-clocks = <&k3_clks 252 1>;
         assigned-clock-parents = <&k3_clks 252 5>;
+        memory-region = <&wdt_reset_memory_region>;
     };
-- 
2.34.1

