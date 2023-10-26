Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C85D7D8528
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345358AbjJZOs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbjJZOso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:48:44 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F151AE
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:48:41 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qw1es-0005Zq-2D; Thu, 26 Oct 2023 16:48:26 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qw1er-004Qq4-JD; Thu, 26 Oct 2023 16:48:25 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1qw1er-00H3Xj-1g;
        Thu, 26 Oct 2023 16:48:25 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v4 2/5] regulator: Introduce handling for system-critical under-voltage events
Date:   Thu, 26 Oct 2023 16:48:21 +0200
Message-Id: <20231026144824.4065145-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231026144824.4065145-1-o.rempel@pengutronix.de>
References: <20231026144824.4065145-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle under-voltage events for crucial regulators to maintain system
stability and avoid issues during power drops.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/regulator/core.c          | 38 +++++++++++++++++++++++++++++++
 drivers/regulator/of_regulator.c  |  2 ++
 include/linux/regulator/machine.h | 10 ++++++++
 3 files changed, 50 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 3137e40fcd3e..a072f721f288 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
+#include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/consumer.h>
@@ -5061,6 +5062,41 @@ void regulator_bulk_free(int num_consumers,
 }
 EXPORT_SYMBOL_GPL(regulator_bulk_free);
 
+/**
+ * regulator_handle_critical - Handle events for system-critical regulators.
+ * @rdev: The regulator device.
+ * @event: The event being handled.
+ *
+ * This function handles critical events such as under-voltage, over-current,
+ * and unknown errors for regulators deemed system-critical. On detecting such
+ * events, it triggers a hardware protection shutdown with a defined timeout.
+ */
+static void regulator_handle_critical(struct regulator_dev *rdev,
+				      unsigned long event)
+{
+	const char *reason = NULL;
+
+	if (!rdev->constraints->system_critical)
+		return;
+
+	switch (event) {
+	case REGULATOR_EVENT_UNDER_VOLTAGE:
+		reason = "System critical regulator: voltage drop detected";
+		break;
+	case REGULATOR_EVENT_OVER_CURRENT:
+		reason = "System critical regulator: over-current detected";
+		break;
+	case REGULATOR_EVENT_FAIL:
+		reason = "System critical regulator: unknown error";
+	}
+
+	if (!reason)
+		return;
+
+	hw_protection_shutdown(reason,
+			       REGULATOR_DEF_UV_LESS_CRITICAL_WINDOW_MS);
+}
+
 /**
  * regulator_notifier_call_chain - call regulator event notifier
  * @rdev: regulator source
@@ -5073,6 +5109,8 @@ EXPORT_SYMBOL_GPL(regulator_bulk_free);
 int regulator_notifier_call_chain(struct regulator_dev *rdev,
 				  unsigned long event, void *data)
 {
+	regulator_handle_critical(rdev, event);
+
 	_notifier_call_chain(rdev, event, data);
 	return NOTIFY_DONE;
 
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 1b65e5e4e40f..3bdd6f1919a4 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -131,6 +131,8 @@ static int of_get_regulation_constraints(struct device *dev,
 		constraints->valid_ops_mask |= REGULATOR_CHANGE_STATUS;
 
 	constraints->pull_down = of_property_read_bool(np, "regulator-pull-down");
+	constraints->system_critical = of_property_read_bool(np,
+						"system-critical-regulator");
 
 	if (of_property_read_bool(np, "regulator-allow-bypass"))
 		constraints->valid_ops_mask |= REGULATOR_CHANGE_BYPASS;
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index 621b7f4a3639..e0ddfb5593c9 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -49,6 +49,13 @@ struct regulator;
 #define DISABLE_IN_SUSPEND	1
 #define ENABLE_IN_SUSPEND	2
 
+/*
+ * Default time window (in milliseconds) following a critical under-voltage
+ * event during which less critical actions can be safely carried out by the
+ * system.
+ */
+#define REGULATOR_DEF_UV_LESS_CRITICAL_WINDOW_MS	10
+
 /* Regulator active discharge flags */
 enum regulator_active_discharge {
 	REGULATOR_ACTIVE_DISCHARGE_DEFAULT,
@@ -127,6 +134,8 @@ struct notification_limit {
  * @ramp_disable: Disable ramp delay when initialising or when setting voltage.
  * @soft_start: Enable soft start so that voltage ramps slowly.
  * @pull_down: Enable pull down when regulator is disabled.
+ * @system_critical: Set if the regulator is critical to system stability or
+ *                   functionality.
  * @over_current_protection: Auto disable on over current event.
  *
  * @over_current_detection: Configure over current limits.
@@ -214,6 +223,7 @@ struct regulation_constraints {
 	unsigned ramp_disable:1; /* disable ramp delay */
 	unsigned soft_start:1;	/* ramp voltage slowly */
 	unsigned pull_down:1;	/* pull down resistor when regulator off */
+	unsigned system_critical:1;	/* critical to system stability */
 	unsigned over_current_protection:1; /* auto disable on over current */
 	unsigned over_current_detection:1; /* notify on over current */
 	unsigned over_voltage_detection:1; /* notify on over voltage */
-- 
2.39.2

