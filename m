Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA91B7B1CA2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 14:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjI1Mhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 08:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjI1Mhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:37:37 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52FF198;
        Thu, 28 Sep 2023 05:37:35 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id D55D921245;
        Thu, 28 Sep 2023 14:37:33 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 4/4] power: reset: gpio-poweroff: make sys handler priority configurable
Date:   Thu, 28 Sep 2023 14:37:28 +0200
Message-Id: <20230928123728.21901-4-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230928123728.21901-1-francesco@dolcini.it>
References: <20230928123204.20345-1-francesco@dolcini.it>
 <20230928123728.21901-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Add a priority property equal to gpio-restart to allow increasing the
priority of the gpio-poweroff handler.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/power/reset/gpio-poweroff.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gpio-poweroff.c
index 0deb293eb2d6..52cfeee2cb28 100644
--- a/drivers/power/reset/gpio-poweroff.c
+++ b/drivers/power/reset/gpio-poweroff.c
@@ -54,6 +54,7 @@ static int gpio_poweroff_probe(struct platform_device *pdev)
 	struct gpio_poweroff *gpio_poweroff;
 	bool input = false;
 	enum gpiod_flags flags;
+	int priority = SYS_OFF_PRIO_DEFAULT;
 	int ret;
 
 	gpio_poweroff = devm_kzalloc(&pdev->dev, sizeof(*gpio_poweroff), GFP_KERNEL);
@@ -75,14 +76,18 @@ static int gpio_poweroff_probe(struct platform_device *pdev)
 	device_property_read_u32(&pdev->dev, "inactive-delay-ms",
 				 &gpio_poweroff->inactive_delay_ms);
 	device_property_read_u32(&pdev->dev, "timeout-ms", &gpio_poweroff->timeout_ms);
+	device_property_read_u32(&pdev->dev, "priority", &priority);
+	if (priority > 255) {
+		dev_err(&pdev->dev, "Invalid priority property: %u\n", priority);
+		return -EINVAL;
+	}
 
 	gpio_poweroff->reset_gpio = devm_gpiod_get(&pdev->dev, NULL, flags);
 	if (IS_ERR(gpio_poweroff->reset_gpio))
 		return PTR_ERR(gpio_poweroff->reset_gpio);
 
 	ret = devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_POWER_OFF,
-					    SYS_OFF_PRIO_DEFAULT, gpio_poweroff_do_poweroff,
-					    gpio_poweroff);
+					    priority, gpio_poweroff_do_poweroff, gpio_poweroff);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "Cannot register poweroff handler\n");
 
-- 
2.25.1

