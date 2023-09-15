Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526037A1831
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbjIOIMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjIOIMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:12:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E512271C;
        Fri, 15 Sep 2023 01:12:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED4C5C116A6;
        Fri, 15 Sep 2023 08:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694765529;
        bh=PIAVRsubooNT/IoJh/5r833VlR5IHIMSLPb5V8bEVII=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=iykzSGPcCWpaTtiatlxtCM/u/jzYPiSMh4tsav5dtjgrLpgCOeZKjV/BR1oTdwnH/
         2WAGKZDY9VH4vzT9jEQPjQtLxjx7ZSGYinXl6NJOqVm2bMhCUdG+Ss4XlvTA3FGnFu
         axgrRfCWEl41K0egBrLkghwqC44JvuBXsVEl3l7xVYqRY7sTSh0xrvar6FO10j0adw
         yNbZeMYIUKBJVCeQo+3i/SviQEw+iS4muyyb7Ig4dJrex1IYGbTMpELQAi4iMXs/8G
         /91pv7osbK18GIEY0aJr93gZcER0NxiRho8+gZp4tm57K/OsgIUoBww341L374HS5b
         MMFebCl7wHdcA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id DAC7BEE6436;
        Fri, 15 Sep 2023 08:12:08 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Fri, 15 Sep 2023 11:10:56 +0300
Subject: [PATCH v4 14/42] rtc: ep93xx: add DT support for Cirrus EP93xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230915-ep93xx-v4-14-a1d779dcec10@maquefel.me>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
In-Reply-To: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694765525; l=1082;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=p80xCnz+NiYVYSqsKWTadEzof+wILB6tYu5g6z/UQHM=; =?utf-8?q?b=3D5o3Yk09uQHB6?=
 =?utf-8?q?rSVNBOSYUARYgtDmO/npd1JvYZ7zPPxiZeant3v1EDCH+4HoeQBCbNXAMgS6Hz8Q?=
 F4LqkKUrCYmh9RfkZt88PHzOK9mvSjOZO6yKlztjR0F/7RI9tUUM
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add OF ID match table.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/rtc/rtc-ep93xx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/rtc/rtc-ep93xx.c b/drivers/rtc/rtc-ep93xx.c
index acae7f16808f..1fdd20d01560 100644
--- a/drivers/rtc/rtc-ep93xx.c
+++ b/drivers/rtc/rtc-ep93xx.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/rtc.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
@@ -148,9 +149,16 @@ static int ep93xx_rtc_probe(struct platform_device *pdev)
 	return devm_rtc_register_device(ep93xx_rtc->rtc);
 }
 
+static const struct of_device_id ep93xx_rtc_of_ids[] = {
+	{ .compatible = "cirrus,ep9301-rtc" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ep93xx_rtc_of_ids);
+
 static struct platform_driver ep93xx_rtc_driver = {
 	.driver		= {
 		.name	= "ep93xx-rtc",
+		.of_match_table = ep93xx_rtc_of_ids,
 	},
 	.probe		= ep93xx_rtc_probe,
 };

-- 
2.39.2

