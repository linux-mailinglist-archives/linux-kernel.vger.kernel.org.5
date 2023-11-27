Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEA07F9E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjK0LOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbjK0LOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:14:40 -0500
Received: from mail.fris.de (unknown [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB5F135;
        Mon, 27 Nov 2023 03:14:45 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8BE47BFC84;
        Mon, 27 Nov 2023 12:14:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1701083683; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=TtObVw8YUfhzjUng8rafUVONqr/7XfXzj8lQVXj7nE0=;
        b=jxYmtFaHcFe41GJCnvC8Svwbkg37mJSpLm4qO1gWbAUTUnCKPGDd/hmADPdkZVlCPbj9Yz
        XfaExWSgaDJjsOMoiegizQh/Uq5LR/kbSQJWPviolY4cGf8iOIv2z3CMlFimdib+JcBSae
        92Qh/DjGEMidH1hik5T5vXjgzoj0DcYUx5cuyMTXdVgWj1LVoHjenRz+owFiPqQNOGM7Mz
        tOX1PQwTmbwmuol9ZbavI5zEzgGM0OwTGbGqB4UWs8H1SgODkYkXrnP6W5jIjqVK4qyXJJ
        mPTbcD45rm6pBKMsycvoCwe9AtFPrH4SbcGfAgkJYmRcsknwltMCMODqMi+s0g==
From:   Frieder Schrempf <frieder@fris.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Anand Moon <linux.amoon@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/3] usb: misc: onboard_usb_hub: Add support for clock input
Date:   Mon, 27 Nov 2023 12:13:23 +0100
Message-ID: <20231127111332.107640-2-frieder@fris.de>
In-Reply-To: <20231127111332.107640-1-frieder@fris.de>
References: <20231127111332.107640-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Most onboard USB hubs have a dedicated crystal oscillator but on some
boards the clock signal for the hub is provided by the SoC.

In order to support this, we add the possibility of specifying a
clock in the devicetree that gets enabled/disabled when the hub
is powered up/down.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes in v2:
* use %pe to print symbolic error name
---
 drivers/usb/misc/onboard_usb_hub.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index 077824beffa01..0d84b16deab50 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2022, Google LLC
  */
 
+#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/err.h>
@@ -61,12 +62,19 @@ struct onboard_hub {
 	bool going_away;
 	struct list_head udev_list;
 	struct mutex lock;
+	struct clk *clk;
 };
 
 static int onboard_hub_power_on(struct onboard_hub *hub)
 {
 	int err;
 
+	err = clk_prepare_enable(hub->clk);
+	if (err) {
+		dev_err(hub->dev, "failed to enable clock: %pe\n", ERR_PTR(err));
+		return err;
+	}
+
 	err = regulator_bulk_enable(hub->pdata->num_supplies, hub->supplies);
 	if (err) {
 		dev_err(hub->dev, "failed to enable supplies: %pe\n", ERR_PTR(err));
@@ -93,6 +101,8 @@ static int onboard_hub_power_off(struct onboard_hub *hub)
 		return err;
 	}
 
+	clk_disable_unprepare(hub->clk);
+
 	hub->is_powered_on = false;
 
 	return 0;
@@ -267,6 +277,10 @@ static int onboard_hub_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	hub->clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(hub->clk))
+		return dev_err_probe(dev, PTR_ERR(hub->clk), "failed to get clock\n");
+
 	hub->reset_gpio = devm_gpiod_get_optional(dev, "reset",
 						  GPIOD_OUT_HIGH);
 	if (IS_ERR(hub->reset_gpio))
-- 
2.42.1

