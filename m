Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2827B7A42B1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240381AbjIRHeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240512AbjIRHdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:33:53 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6949E18D;
        Mon, 18 Sep 2023 00:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1695022410;
  x=1726558410;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=QflApy0N9+QbEHoLZD5bS8AiR4oAhAhgkpeFIrAJc8c=;
  b=pJ2SQFQZJgaPqdplYHc6J6kGl4w4Uzfsh9UoPYb60M4qXNdrEyXGbQCK
   OfTua/LB2WCAUd0cNU+GYz5e10dCnSMM3tyTNoL4QODNrzQ/7G+1PUlzP
   zpH6hae8a0KJ9mTV7vVQnj5jpf8RZnouxlMwMSgE2ZEAwpSS778xTnXGm
   s6RQSbmLvPoUyTVE4ZWiuMCMHHfCKq3wknexeQBba3qfxS86NRML8wqgq
   Vvd2e3czE29mtbL4+6SbtGQ3NgCewYVFkS224+NVxRO+Nb91QNcPsfwNS
   vaFU17SghAbGh/8D8VkdPv6TJd7b7hXDTAh15d7L/2KpazCywNtt7pBl1
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Mon, 18 Sep 2023 09:33:26 +0200
Subject: [PATCH] power: supply: Fix info use-after-free
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230918-power-uaf-v1-1-73c397178c42@axis.com>
X-B4-Tracking: v=1; b=H4sIAEX9B2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDS0ML3YL88tQi3dLENF2zNPM0wyRTC9PUZFMloPqCotS0zAqwWdGxtbU
 AunBTA1sAAAA=
To:     Sebastian Reichel <sre@kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

power_supply_uevent() which is called to emit a udev event on device
deletion attempts to use the info structure which is device-managed and
has been freed before this point.  The use-after-free is triggered since
commit 699fb50d99039 ("drivers: base: Free devm resources when
unregistering a device").

Fix this by associating the devm resource with the parent device
instead, similar to recent fixes done in the input subsystem, such as
commit dd613a4e45f8 ("HID: uclogic: Correct devm device reference for
hidinput input_dev").

Note that the power supply subsystem allows drivers to register a device
without a parent (with a warning), in this case there is still a risk of
use-after-free since we have no other device to attach the devm to.

 ==================================================================
 BUG: KASAN: slab-use-after-free in power_supply_battery_info_has_prop (power_supply_core.c:872)
 Read of size 4 at addr 0000000062e59028 by task python3/27

 Call Trace:
  power_supply_battery_info_has_prop (power_supply_core.c:872)
  power_supply_uevent (power_supply_sysfs.c:504)
  dev_uevent (drivers/base/core.c:2590)
  kobject_uevent_env (lib/kobject_uevent.c:558)
  kobject_uevent (lib/kobject_uevent.c:643)
  device_del (drivers/base/core.c:3266 drivers/base/core.c:3831)
  device_unregister (drivers/base/core.c:3730 drivers/base/core.c:3854)
  power_supply_unregister (power_supply_core.c:1608)
  devm_power_supply_release (power_supply_core.c:1515)
  release_nodes (drivers/base/devres.c:506)
  devres_release_group (drivers/base/devres.c:669)
  i2c_device_remove (drivers/i2c/i2c-core-base.c:629)
  device_remove (drivers/base/dd.c:570)
  device_release_driver_internal (drivers/base/dd.c:1274 drivers/base/dd.c:1295)
  device_driver_detach (drivers/base/dd.c:1332)
  unbind_store (drivers/base/bus.c:247)
  ...

 Allocated by task 27:
  devm_kmalloc (drivers/base/devres.c:119 drivers/base/devres.c:829)
  power_supply_get_battery_info (include/linux/device.h:316 power_supply_core.c:626)
  __power_supply_register (power_supply_core.c:1408)
  devm_power_supply_register (power_supply_core.c:1544)
  bq256xx_probe (bq256xx_charger.c:1539 bq256xx_charger.c:1727) bq256xx_charger
  i2c_device_probe (drivers/i2c/i2c-core-base.c:584)
  really_probe (drivers/base/dd.c:579 drivers/base/dd.c:658)
  __driver_probe_device (drivers/base/dd.c:800)
  device_driver_attach (drivers/base/dd.c:1128)
  bind_store (drivers/base/bus.c:273)
  ...

 Freed by task 27:
  kfree (mm/slab_common.c:1073)
  release_nodes (drivers/base/devres.c:503)
  devres_release_all (drivers/base/devres.c:536)
  device_del (drivers/base/core.c:3829)
  device_unregister (drivers/base/core.c:3730 drivers/base/core.c:3854)
  power_supply_unregister (power_supply_core.c:1608)
  devm_power_supply_release (power_supply_core.c:1515)
  release_nodes (drivers/base/devres.c:506)
  devres_release_group (drivers/base/devres.c:669)
  i2c_device_remove (drivers/i2c/i2c-core-base.c:629)
  device_remove (drivers/base/dd.c:570)
  device_release_driver_internal (drivers/base/dd.c:1274 drivers/base/dd.c:1295)
  device_driver_detach (drivers/base/dd.c:1332)
  unbind_store (drivers/base/bus.c:247)
  ...
 ==================================================================

Fixes: 27a2195efa8d ("power: supply: core: auto-exposure of simple-battery data")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/power/supply/power_supply_core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 0b69fb7bafd8..2863b0a4dfc7 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -573,6 +573,7 @@ EXPORT_SYMBOL_GPL(devm_power_supply_get_by_phandle);
 int power_supply_get_battery_info(struct power_supply *psy,
 				  struct power_supply_battery_info **info_out)
 {
+	struct device *allocdev = psy->dev.parent ?: &psy->dev;
 	struct power_supply_resistance_temp_table *resist_table;
 	struct power_supply_battery_info *info;
 	struct device_node *battery_np = NULL;
@@ -623,7 +624,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		goto out_put_node;
 	}
 
-	info = devm_kzalloc(&psy->dev, sizeof(*info), GFP_KERNEL);
+	info = devm_kzalloc(allocdev, sizeof(*info), GFP_KERNEL);
 	if (!info) {
 		err = -ENOMEM;
 		goto out_put_node;
@@ -776,7 +777,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		info->ocv_table_size[index] = tab_len;
 
 		table = info->ocv_table[index] =
-			devm_kcalloc(&psy->dev, tab_len, sizeof(*table), GFP_KERNEL);
+			devm_kcalloc(allocdev, tab_len, sizeof(*table), GFP_KERNEL);
 		if (!info->ocv_table[index]) {
 			power_supply_put_battery_info(psy, info);
 			err = -ENOMEM;
@@ -796,7 +797,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		goto out_ret_pointer;
 
 	info->resist_table_size = len / (2 * sizeof(__be32));
-	resist_table = info->resist_table = devm_kcalloc(&psy->dev,
+	resist_table = info->resist_table = devm_kcalloc(allocdev,
 							 info->resist_table_size,
 							 sizeof(*resist_table),
 							 GFP_KERNEL);
@@ -825,17 +826,18 @@ EXPORT_SYMBOL_GPL(power_supply_get_battery_info);
 void power_supply_put_battery_info(struct power_supply *psy,
 				   struct power_supply_battery_info *info)
 {
+	struct device *allocdev = psy->dev.parent ?: &psy->dev;
 	int i;
 
 	for (i = 0; i < POWER_SUPPLY_OCV_TEMP_MAX; i++) {
 		if (info->ocv_table[i])
-			devm_kfree(&psy->dev, info->ocv_table[i]);
+			devm_kfree(allocdev, info->ocv_table[i]);
 	}
 
 	if (info->resist_table)
-		devm_kfree(&psy->dev, info->resist_table);
+		devm_kfree(allocdev, info->resist_table);
 
-	devm_kfree(&psy->dev, info);
+	devm_kfree(allocdev, info);
 }
 EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
 

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230918-power-uaf-6f7f1b585ec5

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

