Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DFA7BB88B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjJFNE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjJFNE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:04:57 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EB8EA;
        Fri,  6 Oct 2023 06:04:53 -0700 (PDT)
Received: from francesco-nb.corp.toradex.com (unknown [201.82.41.210])
        by mail11.truemail.it (Postfix) with ESMTPA id 74766212BC;
        Fri,  6 Oct 2023 15:04:50 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 4/4] power: reset: gpio-poweroff: make sys handler priority configurable
Date:   Fri,  6 Oct 2023 10:04:28 -0300
Message-Id: <20231006130428.11259-5-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231006130428.11259-1-francesco@dolcini.it>
References: <20231006130428.11259-1-francesco@dolcini.it>
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

