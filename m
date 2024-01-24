Return-Path: <linux-kernel+bounces-36967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1D883A995
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD721C208E1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EE4657A2;
	Wed, 24 Jan 2024 12:22:31 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C5563115
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706098947; cv=none; b=mPa4qi0OZ4CP+9x7k/roe38uYFYYp/LJ2+GA+iIHCFMc4v6jMlWA7PDP3Pxbhm/5GxD2z+MsNyuQ0l2ZriJpraYotFscaV7uGKPZXlU1rFlBgYOYkDS7znZ9nPbHmAFFt85UcWpQpQd3dI1zLa6lzteGaseLz/3ps6LIERjiaok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706098947; c=relaxed/simple;
	bh=aGoYIr6WP6qwdiccu6/EeWFB5o3ysjwmHOnTwOOjDkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nuj45cf7S8gTkReo0J6H0v2X90+t1WEt230ZfBBFe62t0eFTWjGFXQuJIJKI8n8BZ14nbvve6jlD2eviJlXbxx3rkCCDBrpwCHXu9oAmQ7asVVrb5lM+lVDFRECuG9inwIOe8yOjVx/P+4pLdRbrUH60KxaPj6clb8bGME6f3IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rScGd-0007oB-1C; Wed, 24 Jan 2024 13:22:07 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rScGc-0023Zk-2z; Wed, 24 Jan 2024 13:22:06 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rScGc-00341u-00;
	Wed, 24 Jan 2024 13:22:06 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH v2 7/8] regulator: set Power State Change Reason before hw_protection_shutdown()
Date: Wed, 24 Jan 2024 13:22:03 +0100
Message-Id: <20240124122204.730370-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124122204.730370-1-o.rempel@pengutronix.de>
References: <20240124122204.730370-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Store the state change reason to some black box, for later
investigation.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a968dabb48f5..a811a5ff2273 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
+#include <linux/pscrr.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/regulator/of_regulator.h>
@@ -5095,6 +5096,7 @@ EXPORT_SYMBOL_GPL(regulator_bulk_free);
 static void regulator_handle_critical(struct regulator_dev *rdev,
 				      unsigned long event)
 {
+	enum pscr pscr;
 	const char *reason = NULL;
 
 	if (!rdev->constraints->system_critical)
@@ -5103,17 +5105,21 @@ static void regulator_handle_critical(struct regulator_dev *rdev,
 	switch (event) {
 	case REGULATOR_EVENT_UNDER_VOLTAGE:
 		reason = "System critical regulator: voltage drop detected";
+		pscr = PSCR_UNDER_VOLTAGE;
 		break;
 	case REGULATOR_EVENT_OVER_CURRENT:
 		reason = "System critical regulator: over-current detected";
+		pscr = PSCR_OVER_CURRENT;
 		break;
 	case REGULATOR_EVENT_FAIL:
 		reason = "System critical regulator: unknown error";
+		pscr = PSCR_REGULATOR_FAILURE;
 	}
 
 	if (!reason)
 		return;
 
+	set_power_state_change_reason(pscr);
 	hw_protection_shutdown(reason,
 			       rdev->constraints->uv_less_critical_window_ms);
 }
-- 
2.39.2


