Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D397D6598
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbjJYIqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjJYIq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:46:27 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEA6130
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:46:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qvZWq-0002CG-9l; Wed, 25 Oct 2023 10:46:16 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qvZWp-0048Wk-Ec; Wed, 25 Oct 2023 10:46:15 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1qvZWp-00CyTR-1C;
        Wed, 25 Oct 2023 10:46:15 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 7/7] regulator: Implement uv_survival_time for handling under-voltage events
Date:   Wed, 25 Oct 2023 10:46:14 +0200
Message-Id: <20231025084614.3092295-8-o.rempel@pengutronix.de>
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

Add 'uv_survival_time' field to regulation_constraints for specifying
survival time post critical under-voltage event. Update the regulator
notifier call chain and Device Tree property parsing to use this new
field, allowing a configurable timeout before emergency shutdown.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/regulator/core.c          | 2 +-
 drivers/regulator/of_regulator.c  | 6 ++++++
 include/linux/regulator/machine.h | 6 ++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 903c384f25e3..bb864969fc79 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5077,7 +5077,7 @@ int regulator_notifier_call_chain(struct regulator_dev *rdev,
 	if (rdev->constraints->system_critical &&
 	    event == REGULATOR_EVENT_UNDER_VOLTAGE)
 		hw_protection_shutdown("System critical voltage drop detected",
-				       REGULATOR_DEF_EMERG_SHUTDWN_TMO);
+				       rdev->constraints->uv_survival_time);
 
 	_notifier_call_chain(rdev, event, data);
 	return NOTIFY_DONE;
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 3bdd6f1919a4..6463b455ebc5 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -175,6 +175,12 @@ static int of_get_regulation_constraints(struct device *dev,
 	if (!ret)
 		constraints->enable_time = pval;
 
+	ret = of_property_read_u32(np, "regulator-uv-survival-time-ms", &pval);
+	if (!ret)
+		constraints->uv_survival_time = pval;
+	else
+		constraints->uv_survival_time = REGULATOR_DEF_EMERG_SHUTDWN_TMO;
+
 	constraints->soft_start = of_property_read_bool(np,
 					"regulator-soft-start");
 	ret = of_property_read_u32(np, "regulator-active-discharge", &pval);
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index 7332ee36e9d6..daddec83d887 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -158,6 +158,11 @@ struct notification_limit {
  *		      regulator_active_discharge values are used for
  *		      initialisation.
  * @enable_time: Turn-on time of the rails (unit: microseconds)
+ * @uv_survival_time: Survival time post a critical under-voltage event. Time
+ *                    the system can operate before the on-board capacitors
+ *                    fail, providing a window for necessary actions or
+ *                    preparations to be taken before power loss.
+ *                    (unit: microseconds)
  */
 struct regulation_constraints {
 
@@ -209,6 +214,7 @@ struct regulation_constraints {
 	unsigned int settling_time_up;
 	unsigned int settling_time_down;
 	unsigned int enable_time;
+	unsigned int uv_survival_time;
 
 	unsigned int active_discharge;
 
-- 
2.39.2

