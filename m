Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3FE7D65A4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbjJYIqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjJYIq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:46:29 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEBCB0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:46:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qvZWq-0002CB-9m; Wed, 25 Oct 2023 10:46:16 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qvZWp-0048Wa-As; Wed, 25 Oct 2023 10:46:15 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1qvZWp-00CySa-0u;
        Wed, 25 Oct 2023 10:46:15 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 2/7] regulator: Handle system-critical under-voltage events
Date:   Wed, 25 Oct 2023 10:46:09 +0200
Message-Id: <20231025084614.3092295-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025084614.3092295-1-o.rempel@pengutronix.de>
References: <20231025084614.3092295-1-o.rempel@pengutronix.de>
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

Introduce handling for system-critical regulators during under-voltage
events.
A new field 'system_critical' in regulation_constraints is added to mark
regulators critical to system stability or functionality. During an
under-voltage event, if the regulator is marked as system-critical, an
emergency hardware protection shutdown is triggered to prevent potential
system damage or malfunction.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/regulator/core.c          | 6 ++++++
 drivers/regulator/of_regulator.c  | 2 ++
 include/linux/regulator/machine.h | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d8e1caaf207e..903c384f25e3 100644
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
@@ -5073,6 +5074,11 @@ EXPORT_SYMBOL_GPL(regulator_bulk_free);
 int regulator_notifier_call_chain(struct regulator_dev *rdev,
 				  unsigned long event, void *data)
 {
+	if (rdev->constraints->system_critical &&
+	    event == REGULATOR_EVENT_UNDER_VOLTAGE)
+		hw_protection_shutdown("System critical voltage drop detected",
+				       REGULATOR_DEF_EMERG_SHUTDWN_TMO);
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
index 621b7f4a3639..7332ee36e9d6 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -49,6 +49,9 @@ struct regulator;
 #define DISABLE_IN_SUSPEND	1
 #define ENABLE_IN_SUSPEND	2
 
+/* Default time in millisecond to wait for emergency shutdown */
+#define REGULATOR_DEF_EMERG_SHUTDWN_TMO	10
+
 /* Regulator active discharge flags */
 enum regulator_active_discharge {
 	REGULATOR_ACTIVE_DISCHARGE_DEFAULT,
@@ -127,6 +130,8 @@ struct notification_limit {
  * @ramp_disable: Disable ramp delay when initialising or when setting voltage.
  * @soft_start: Enable soft start so that voltage ramps slowly.
  * @pull_down: Enable pull down when regulator is disabled.
+ * @system_critical: Set if the regulator is critical to system stability or
+ *                   functionality.
  * @over_current_protection: Auto disable on over current event.
  *
  * @over_current_detection: Configure over current limits.
@@ -214,6 +219,7 @@ struct regulation_constraints {
 	unsigned ramp_disable:1; /* disable ramp delay */
 	unsigned soft_start:1;	/* ramp voltage slowly */
 	unsigned pull_down:1;	/* pull down resistor when regulator off */
+	unsigned system_critical:1;	/* critical to system stability */
 	unsigned over_current_protection:1; /* auto disable on over current */
 	unsigned over_current_detection:1; /* notify on over current */
 	unsigned over_voltage_detection:1; /* notify on over voltage */
-- 
2.39.2

