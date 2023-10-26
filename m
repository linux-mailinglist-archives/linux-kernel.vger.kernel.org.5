Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03C47D852D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345360AbjJZOsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbjJZOsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:48:43 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D911AB
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:48:41 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qw1es-0005Zt-2b; Thu, 26 Oct 2023 16:48:26 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qw1er-004Qq9-Ke; Thu, 26 Oct 2023 16:48:25 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1qw1er-00H3YE-1s;
        Thu, 26 Oct 2023 16:48:25 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v4 5/5] regulator: Implement uv_survival_time for handling under-voltage events
Date:   Thu, 26 Oct 2023 16:48:24 +0200
Message-Id: <20231026144824.4065145-6-o.rempel@pengutronix.de>
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

Add 'uv_survival_time' field to regulation_constraints for specifying
survival time post critical under-voltage event. Update the regulator
notifier call chain and Device Tree property parsing to use this new
field, allowing a configurable timeout before emergency shutdown.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/regulator/core.c          | 2 +-
 drivers/regulator/of_regulator.c  | 7 +++++++
 include/linux/regulator/machine.h | 8 ++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a072f721f288..a6cb84af989e 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5094,7 +5094,7 @@ static void regulator_handle_critical(struct regulator_dev *rdev,
 		return;
 
 	hw_protection_shutdown(reason,
-			       REGULATOR_DEF_UV_LESS_CRITICAL_WINDOW_MS);
+			       rdev->constraints->uv_less_critical_window_ms);
 }
 
 /**
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 3bdd6f1919a4..03afc160fc72 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -175,6 +175,13 @@ static int of_get_regulation_constraints(struct device *dev,
 	if (!ret)
 		constraints->enable_time = pval;
 
+	ret = of_property_read_u32(np, "regulator-uv-survival-time-ms", &pval);
+	if (!ret)
+		constraints->uv_less_critical_window_ms = pval;
+	else
+		constraints->uv_less_critical_window_ms =
+				REGULATOR_DEF_UV_LESS_CRITICAL_WINDOW_MS;
+
 	constraints->soft_start = of_property_read_bool(np,
 					"regulator-soft-start");
 	ret = of_property_read_u32(np, "regulator-active-discharge", &pval);
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index e0ddfb5593c9..0cd76d264727 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -162,6 +162,13 @@ struct notification_limit {
  *		      regulator_active_discharge values are used for
  *		      initialisation.
  * @enable_time: Turn-on time of the rails (unit: microseconds)
+ * @uv_less_critical_window_ms: Specifies the time window (in milliseconds)
+ *                              following a critical under-voltage (UV) event
+ *                              during which less critical actions can be
+ *                              safely carried out by the system (for example
+ *                              logging). After this time window more critical
+ *                              actions should be done (for example prevent
+ *                              HW damage).
  */
 struct regulation_constraints {
 
@@ -213,6 +220,7 @@ struct regulation_constraints {
 	unsigned int settling_time_up;
 	unsigned int settling_time_down;
 	unsigned int enable_time;
+	unsigned int uv_less_critical_window_ms;
 
 	unsigned int active_discharge;
 
-- 
2.39.2

