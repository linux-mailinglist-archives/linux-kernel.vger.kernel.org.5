Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11A5751DD4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbjGMJxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbjGMJxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:53:10 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Jul 2023 02:53:08 PDT
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D8B26B1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:53:08 -0700 (PDT)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230713095204a6f84ab03d01ec049b
        for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jul 2023 11:52:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=huaqian.li@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=F9BzZKCWKnjicxXTDGFSKA38YJKol5g9fotOvc0nOpA=;
 b=AWRaobJSk0xCUdX00rLqIx9GNr2DyNsgU3FhIyW9kihWLDFwqcoQh1oWXePzXHuJZQWHBD
 S3ExjIP9KrX+jCou/BLIV5YPo8t51DpCeNqVLrA4Ib267GE/zqFdb9w7s0ccKZZO4ODtASxD
 oBRzlySY1+5onyzwXpNx9UMPWU/fo=;
From:   huaqian.li@siemens.com
To:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     huaqianlee@gmail.com, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jan.kiszka@siemens.com,
        baocheng.su@siemens.com, Li Hua Qian <huaqian.li@siemens.com>
Subject: [PATCH v3 3/3] watchdog:rit_wdt: Add support for WDIOF_CARDRESET
Date:   Thu, 13 Jul 2023 17:51:27 +0800
Message-Id: <20230713095127.1230109-4-huaqian.li@siemens.com>
In-Reply-To: <20230713095127.1230109-1-huaqian.li@siemens.com>
References: <20230713095127.1230109-1-huaqian.li@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-959203:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
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

This patch adds the WDIOF_CARDRESET support for the platform watchdog
whose hardware does not support this feature, to know if the board
reboot is due to a watchdog reset.

This is done via reserved memory(RAM), which indicates if specific
info saved, triggering the watchdog reset in last boot.

Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
---
 drivers/watchdog/rti_wdt.c | 51 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
index ce8f18e93aa9..b9435b972cb9 100644
--- a/drivers/watchdog/rti_wdt.c
+++ b/drivers/watchdog/rti_wdt.c
@@ -18,6 +18,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
+#include <linux/of_address.h>
+#include <linux/of.h>
 
 #define DEFAULT_HEARTBEAT 60
 
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
@@ -284,6 +296,45 @@ static int rti_wdt_probe(struct platform_device *pdev)
 		}
 	}
 
+	node = of_parse_phandle(pdev->dev.of_node, "memory-region", 0);
+	if (!node) {
+		dev_dbg(dev, "No memory-region specified.\n");
+	} else {
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
+		reserved_mem_size = res.end - (res.start - 1);
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
+			dev_dbg(dev, "Watchdog reset cause detected.\n");
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

