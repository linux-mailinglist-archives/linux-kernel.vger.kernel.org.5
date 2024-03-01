Return-Path: <linux-kernel+bounces-89212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1317D86EC15
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9697B1F23569
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4085EE8E;
	Fri,  1 Mar 2024 22:59:00 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1595D5EE67;
	Fri,  1 Mar 2024 22:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709333940; cv=none; b=g/N4TZIbC4BmQ/P/4UX4wHIdTyt2WsRUAJIOsr3EMmgZs6qe0EZENwlGNblzSjszaie+vr/QZYGLovIfjX2oVgfxJupIe/e1zs3rqPuF3/KxqKlCyCxbJyWRSgUtMOzXS+hPZLzcyfuN0XJovUVxixPTyJE4mCogaQY2A9crVlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709333940; c=relaxed/simple;
	bh=fcebmwXS1BjQVg9Ypr2SmOyNCdgw+hKrXZuUCmC8840=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aPmkweerocCx4AKFpwW8p4b7wETLa9EJcHlU9b33cZuRlMspXkso4+founWxNL7Jwrs8Sz12su956Z3KNkNAvg91b+YaHUjaTnO3PSSPytRyfpVIfP3i0+xAjyzPCGMp6Lsics/7Qw+jZZcBgod2+pVikSrL8Fq9gVOMwjkbGw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59869C433F1;
	Fri,  1 Mar 2024 22:58:59 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id C72C11060625; Fri,  1 Mar 2024 23:58:56 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 01 Mar 2024 23:58:26 +0100
Subject: [PATCH 1/2] power: supply: core: add
 power_supply_for_each_device()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-psy-class-cleanup-v1-1-aebe8c4b6b08@collabora.com>
References: <20240301-psy-class-cleanup-v1-0-aebe8c4b6b08@collabora.com>
In-Reply-To: <20240301-psy-class-cleanup-v1-0-aebe8c4b6b08@collabora.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9158;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=fcebmwXS1BjQVg9Ypr2SmOyNCdgw+hKrXZuUCmC8840=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBl4l2w5lczmcxqXCvn2iduocsky+U9ck1Gq/IOw
 69GWIYOei+JAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCZeJdsAAKCRDY7tfzyDv6
 mjrqD/0a1uywEYagB3wNXh6a8A55JbrsP5oCnXIU9eqfQJbTMhbgavfw/8LIJs8LQLm5AdH0GOy
 /Nin0Ol1CoXjKYhS74SWmGXsTWIQn7g9FVKIfWOFCmqjgzQrsY/f50c9QDWAQmDrUBwCR8c0nqt
 CoVHfLO+UGdvVEIIbKvnjBdAXy5fx1LnecncViRZTkZ7ZE6PrzutEfH/Nho1FLKCe14+1BXtpPQ
 J1fn5xpyCa4PgZlMAjjFZviOhhUQOfCI7bhCsy9Vh8Ll1W462IXPWWgVMCmsxeFklXbtRLSnYPR
 QK26HrWA7mmCIcKmQ/nreGTeIP6tUTi07NXjOChqAiRFDvUPJH1u7dhrZYGUZfHeVa+0PuYyidN
 gGJ6H9zwF8iSNiflC5NyEPW6R5dfOvuJAUUjb2NQc/XFujvfE3PnYGcafT/MwnoSTu0yUNlxAHF
 ik5ECPqNNTH8fXlRu8+D3royvVymGNMLkmcCn28cgMXimdMWafBuYyxLDXiVXt76s4Lwhu2h2L3
 44J8ikzjUUSmkYlb4c/H/tE/eRiCCiBGKDEdrltTEbhQQDyFMoDpJ1k28NjyvZyIxGO1C/XglnS
 QPXJl2k8r8beFGJPqwvB8i8gegKdqhDjDYATWnbIrtvRB/URIcnRetETIDs4ZZZyhsIBGT7URoF
 VabSTh4IAf63PYA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Introduce power_supply_for_each_device(), which is a wrapper
for class_for_each_device() using the power_supply_class and
going through all devices.

This allows making the power_supply_class itself a local
variable, so that drivers cannot mess with it and simplifies
the code slightly.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/ab8500_btemp.c      |  3 +--
 drivers/power/supply/ab8500_chargalg.c   |  3 +--
 drivers/power/supply/ab8500_charger.c    |  3 +--
 drivers/power/supply/ab8500_fg.c         |  3 +--
 drivers/power/supply/apm_power.c         |  3 +--
 drivers/power/supply/power_supply_core.c | 34 +++++++++++++++-----------------
 include/linux/power_supply.h             |  3 +--
 7 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 41dba40fffdf..56f136b2d071 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -617,8 +617,7 @@ static int ab8500_btemp_get_ext_psy_data(struct device *dev, void *data)
  */
 static void ab8500_btemp_external_power_changed(struct power_supply *psy)
 {
-	class_for_each_device(&power_supply_class, NULL, psy,
-			      ab8500_btemp_get_ext_psy_data);
+	power_supply_for_each_device(psy, ab8500_btemp_get_ext_psy_data);
 }
 
 /* ab8500 btemp driver interrupts and their respective isr */
diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index 329ae784a72d..55ab7a28056e 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -1231,8 +1231,7 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 	int ret;
 
 	/* Collect data from all power_supply class devices */
-	class_for_each_device(&power_supply_class, NULL,
-		di->chargalg_psy, ab8500_chargalg_get_ext_psy_data);
+	power_supply_for_each_device(di->chargalg_psy, ab8500_chargalg_get_ext_psy_data);
 
 	ab8500_chargalg_end_of_charge(di);
 	ab8500_chargalg_check_temp(di);
diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 1c2b69bbed17..9b34d1a60f66 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -1949,8 +1949,7 @@ static void ab8500_charger_check_vbat_work(struct work_struct *work)
 	struct ab8500_charger *di = container_of(work,
 		struct ab8500_charger, check_vbat_work.work);
 
-	class_for_each_device(&power_supply_class, NULL,
-			      &di->usb_chg, ab8500_charger_get_ext_psy_data);
+	power_supply_for_each_device(&di->usb_chg, ab8500_charger_get_ext_psy_data);
 
 	/* First run old_vbat is 0. */
 	if (di->old_vbat == 0)
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index e49e704023e1..2ccaf6116c09 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2407,8 +2407,7 @@ static int ab8500_fg_init_hw_registers(struct ab8500_fg *di)
  */
 static void ab8500_fg_external_power_changed(struct power_supply *psy)
 {
-	class_for_each_device(&power_supply_class, NULL, psy,
-			      ab8500_fg_get_ext_psy_data);
+	power_supply_for_each_device(psy, ab8500_fg_get_ext_psy_data);
 }
 
 /**
diff --git a/drivers/power/supply/apm_power.c b/drivers/power/supply/apm_power.c
index 034f28699977..8ef1b6f1f787 100644
--- a/drivers/power/supply/apm_power.c
+++ b/drivers/power/supply/apm_power.c
@@ -79,8 +79,7 @@ static void find_main_battery(void)
 	main_battery = NULL;
 	bp.main = main_battery;
 
-	error = class_for_each_device(&power_supply_class, NULL, &bp,
-				      __find_main_battery);
+	error = power_supply_for_each_device(&bp, __find_main_battery);
 	if (error) {
 		main_battery = bp.main;
 		return;
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 4f27f17f8741..0eb8a57dda70 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -25,12 +25,10 @@
 #include "power_supply.h"
 #include "samsung-sdi-battery.h"
 
-/* exported for the APM Power driver, APM emulation */
-const struct class power_supply_class = {
+static const struct class power_supply_class = {
 	.name = "power_supply",
 	.dev_uevent = power_supply_uevent,
 };
-EXPORT_SYMBOL_GPL(power_supply_class);
 
 static BLOCKING_NOTIFIER_HEAD(power_supply_notifier);
 
@@ -100,8 +98,7 @@ static void power_supply_changed_work(struct work_struct *work)
 	if (likely(psy->changed)) {
 		psy->changed = false;
 		spin_unlock_irqrestore(&psy->changed_lock, flags);
-		class_for_each_device(&power_supply_class, NULL, psy,
-				      __power_supply_changed_work);
+		power_supply_for_each_device(psy, __power_supply_changed_work);
 		power_supply_update_leds(psy);
 		blocking_notifier_call_chain(&power_supply_notifier,
 				PSY_EVENT_PROP_CHANGED, psy);
@@ -119,6 +116,12 @@ static void power_supply_changed_work(struct work_struct *work)
 	spin_unlock_irqrestore(&psy->changed_lock, flags);
 }
 
+int power_supply_for_each_device(void *data, int (*fn)(struct device *dev, void *data))
+{
+	return class_for_each_device(&power_supply_class, NULL, data, fn);
+}
+EXPORT_SYMBOL_GPL(power_supply_for_each_device);
+
 void power_supply_changed(struct power_supply *psy)
 {
 	unsigned long flags;
@@ -194,8 +197,7 @@ static int power_supply_populate_supplied_from(struct power_supply *psy)
 {
 	int error;
 
-	error = class_for_each_device(&power_supply_class, NULL, psy,
-				      __power_supply_populate_supplied_from);
+	error = power_supply_for_each_device(psy, __power_supply_populate_supplied_from);
 
 	dev_dbg(&psy->dev, "%s %d\n", __func__, error);
 
@@ -208,7 +210,7 @@ static int  __power_supply_find_supply_from_node(struct device *dev,
 	struct device_node *np = data;
 	struct power_supply *epsy = dev_get_drvdata(dev);
 
-	/* returning non-zero breaks out of class_for_each_device loop */
+	/* returning non-zero breaks out of power_supply_for_each_device loop */
 	if (epsy->of_node == np)
 		return 1;
 
@@ -220,17 +222,16 @@ static int power_supply_find_supply_from_node(struct device_node *supply_node)
 	int error;
 
 	/*
-	 * class_for_each_device() either returns its own errors or values
+	 * power_supply_for_each_device() either returns its own errors or values
 	 * returned by __power_supply_find_supply_from_node().
 	 *
 	 * __power_supply_find_supply_from_node() will return 0 (no match)
 	 * or 1 (match).
 	 *
-	 * We return 0 if class_for_each_device() returned 1, -EPROBE_DEFER if
+	 * We return 0 if power_supply_for_each_device() returned 1, -EPROBE_DEFER if
 	 * it returned 0, or error as returned by it.
 	 */
-	error = class_for_each_device(&power_supply_class, NULL, supply_node,
-				      __power_supply_find_supply_from_node);
+	error = power_supply_for_each_device(supply_node, __power_supply_find_supply_from_node);
 
 	return error ? (error == 1 ? 0 : error) : -EPROBE_DEFER;
 }
@@ -336,8 +337,7 @@ int power_supply_am_i_supplied(struct power_supply *psy)
 	struct psy_am_i_supplied_data data = { psy, 0 };
 	int error;
 
-	error = class_for_each_device(&power_supply_class, NULL, &data,
-				      __power_supply_am_i_supplied);
+	error = power_supply_for_each_device(&data, __power_supply_am_i_supplied);
 
 	dev_dbg(&psy->dev, "%s count %u err %d\n", __func__, data.count, error);
 
@@ -372,8 +372,7 @@ int power_supply_is_system_supplied(void)
 	int error;
 	unsigned int count = 0;
 
-	error = class_for_each_device(&power_supply_class, NULL, &count,
-				      __power_supply_is_system_supplied);
+	error = power_supply_for_each_device(&count, __power_supply_is_system_supplied);
 
 	/*
 	 * If no system scope power class device was found at all, most probably we
@@ -419,8 +418,7 @@ int power_supply_get_property_from_supplier(struct power_supply *psy,
 	 * This function is not intended for use with a supply with multiple
 	 * suppliers, we simply pick the first supply to report the psp.
 	 */
-	ret = class_for_each_device(&power_supply_class, NULL, &data,
-				    __power_supply_get_supplier_property);
+	ret = power_supply_for_each_device(&data, __power_supply_get_supplier_property);
 	if (ret < 0)
 		return ret;
 	if (ret == 0)
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 514f652de64d..92dd205774ec 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -894,8 +894,7 @@ extern int power_supply_powers(struct power_supply *psy, struct device *dev);
 #define to_power_supply(device) container_of(device, struct power_supply, dev)
 
 extern void *power_supply_get_drvdata(struct power_supply *psy);
-/* For APM emulation, think legacy userspace. */
-extern const struct class power_supply_class;
+extern int power_supply_for_each_device(void *data, int (*fn)(struct device *dev, void *data));
 
 static inline bool power_supply_is_amp_property(enum power_supply_property psp)
 {

-- 
2.43.0


