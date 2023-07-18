Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604537571A6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 04:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjGRCMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 22:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjGRCMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 22:12:22 -0400
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B4810F1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 19:12:19 -0700 (PDT)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2023071802121993074d7e6a82316320
        for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 04:12:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=huaqian.li@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=P+e4mgQf7YcgATPvUbBvEm5Pd72/FjOAYEsp6bDRqIE=;
 b=nm92q4mscd4W1AyCnXiVJxwBNnOnefvJdnm4dUNuN6aE2WOJfFs/Q1YaFxQi1LYNe+Pehe
 C5p3DPvwNrd++0fn0+jdZj7EktIhuvqG5GIPmS+XCfJ/o5ebvrMYqzvTeJwDMUVQuFIc6H26
 kD6vPVYTfqeJ6Orkj4A+8yHBeMX4Y=;
From:   huaqian.li@siemens.com
To:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     huaqianlee@gmail.com, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jan.kiszka@siemens.com,
        baocheng.su@siemens.com, Li Hua Qian <huaqian.li@siemens.com>
Subject: [PATCH v6 3/3] watchdog:rit_wdt: Add support for WDIOF_CARDRESET
Date:   Tue, 18 Jul 2023 10:10:07 +0800
Message-Id: <20230718021007.1338761-4-huaqian.li@siemens.com>
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

This patch adds the WDIOF_CARDRESET support for the platform watchdog
whose hardware does not support this feature, to know if the board
reboot is due to a watchdog reset.

This is done via reserved memory(RAM), which indicates if specific
info saved, triggering the watchdog reset in last boot.

Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
---
 drivers/watchdog/rti_wdt.c | 48 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
index ce8f18e93aa9..901109d979f0 100644
--- a/drivers/watchdog/rti_wdt.c
+++ b/drivers/watchdog/rti_wdt.c
@@ -14,6 +14,8 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/types.h>
@@ -52,6 +54,11 @@
 
 #define DWDST			BIT(1)
 
+#define PON_REASON_SOF_NUM	0xBBBBCCCC
+#define PON_REASON_MAGIC_NUM	0xDDDDDDDD
+#define PON_REASON_EOF_NUM	0xCCCCBBBB
+#define RESERVED_MEM_MIN_SIZE	12
+
 static int heartbeat = DEFAULT_HEARTBEAT;
 
 /*
@@ -198,6 +205,11 @@ static int rti_wdt_probe(struct platform_device *pdev)
 	struct rti_wdt_device *wdt;
 	struct clk *clk;
 	u32 last_ping = 0;
+	struct device_node *node;
+	u32 reserved_mem_size;
+	struct resource res;
+	u32 *vaddr;
+	u64 paddr;
 
 	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt)
@@ -284,6 +296,42 @@ static int rti_wdt_probe(struct platform_device *pdev)
 		}
 	}
 
+	node = of_parse_phandle(pdev->dev.of_node, "memory-region", 0);
+	if (node) {
+		ret = of_address_to_resource(node, 0, &res);
+		if (ret) {
+			dev_err(dev, "No memory address assigned to the region.\n");
+			goto err_iomap;
+		}
+
+		/*
+		 * If reserved memory is defined for watchdog reset cause.
+		 * Readout the Power-on(PON) reason and pass to bootstatus.
+		 */
+		paddr = res.start;
+		reserved_mem_size = resource_size(&res);
+		if (reserved_mem_size < RESERVED_MEM_MIN_SIZE) {
+			dev_err(dev, "The size of reserved memory is too small.\n");
+			ret = -EINVAL;
+			goto err_iomap;
+		}
+
+		vaddr = memremap(paddr, reserved_mem_size, MEMREMAP_WB);
+		if (vaddr == NULL) {
+			dev_err(dev, "Failed to map memory-region.\n");
+			ret = -ENOMEM;
+			goto err_iomap;
+		}
+
+		if (vaddr[0] == PON_REASON_SOF_NUM &&
+		    vaddr[1] == PON_REASON_MAGIC_NUM &&
+		    vaddr[2] == PON_REASON_EOF_NUM) {
+			wdd->bootstatus |= WDIOF_CARDRESET;
+		}
+		memset(vaddr, 0, reserved_mem_size);
+		memunmap(vaddr);
+	}
+
 	watchdog_init_timeout(wdd, heartbeat, dev);
 
 	ret = watchdog_register_device(wdd);
-- 
2.34.1

