Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103A87BEC94
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378755AbjJIVPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378744AbjJIVPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:15:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC396122;
        Mon,  9 Oct 2023 14:14:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0E3C433CD;
        Mon,  9 Oct 2023 21:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696886076;
        bh=z/UnX911lj51aORILWacOnidg8CfRyf0fi+7bLxaO0E=;
        h=From:To:Cc:Subject:Date:From;
        b=cmUnYPp2hj3oIs7P7Q0Antpfe/5PAWFHShloQENlBKJtrpElqzlN/KBzByMmunaAc
         bB3WyYbXRaHB/hDxr9XzV+taBoD2Ff0heWdzPRk2CtdcaG82L8TLcb/mnX/6XsbrOa
         2cyhgDmFeC/3InMwussYnnaZAnEHu7GG8Eg7lS3OCHaCto+P3k13dddY2rTeZgti0t
         jdcxiRjWEKrTQEvIYjK/E/DLO6gcPdHonLPAn1M9pI0BvQHOh2aKArE1gWF7cwF4Up
         kqCtopYbiFkylOW7hlMQpgynQf7AS0dBIDrptKz3suBPsCNvSFDEZsZ5o/Yzxt2LcM
         h8G1l8NAOgHLQ==
Received: (nullmailer pid 3246607 invoked by uid 1000);
        Mon, 09 Oct 2023 21:14:16 -0000
From:   Rob Herring <robh@kernel.org>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: st_lpc: Use device_get_match_data()
Date:   Mon,  9 Oct 2023 16:13:48 -0500
Message-ID: <20231009211356.3242037-18-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/watchdog/st_lpc_wdt.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/st_lpc_wdt.c b/drivers/watchdog/st_lpc_wdt.c
index d2aa43c00221..4c5b8d98a4f3 100644
--- a/drivers/watchdog/st_lpc_wdt.c
+++ b/drivers/watchdog/st_lpc_wdt.c
@@ -15,7 +15,6 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/watchdog.h>
@@ -42,7 +41,7 @@ struct st_wdog {
 	void __iomem *base;
 	struct device *dev;
 	struct regmap *regmap;
-	struct st_wdog_syscfg *syscfg;
+	const struct st_wdog_syscfg *syscfg;
 	struct clk *clk;
 	unsigned long clkrate;
 	bool warm_reset;
@@ -150,7 +149,6 @@ static void st_clk_disable_unprepare(void *data)
 static int st_wdog_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *match;
 	struct device_node *np = dev->of_node;
 	struct st_wdog *st_wdog;
 	struct regmap *regmap;
@@ -173,12 +171,7 @@ static int st_wdog_probe(struct platform_device *pdev)
 	if (!st_wdog)
 		return -ENOMEM;
 
-	match = of_match_device(st_wdog_match, dev);
-	if (!match) {
-		dev_err(dev, "Couldn't match device\n");
-		return -ENODEV;
-	}
-	st_wdog->syscfg	= (struct st_wdog_syscfg *)match->data;
+	st_wdog->syscfg	= (struct st_wdog_syscfg *)device_get_match_data(dev);
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
-- 
2.42.0

