Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C157178D942
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbjH3Scn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343616AbjH3QRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:17:01 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0CD1A1;
        Wed, 30 Aug 2023 09:16:55 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 09f20c2cacebe463; Wed, 30 Aug 2023 18:16:54 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id A93FA66316E;
        Wed, 30 Aug 2023 18:16:53 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v1 3/4] thermal: Use thermal_tripless_zone_device_register()
Date:   Wed, 30 Aug 2023 18:14:57 +0200
Message-ID: <8272147.T7Z3S40VBb@kreacher>
In-Reply-To: <1870450.tdWV9SEqCh@kreacher>
References: <1870450.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudefkedguddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhht
 vghlrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopegrmhhithhksehkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

All of the remaining callers of thermal_zone_device_register()
can use thermal_tripless_zone_device_register(), so make them
do so in order to allow the former to be dropped.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/power/supply/power_supply_core.c                |    4 ++--
 drivers/thermal/armada_thermal.c                        |    5 +++--
 drivers/thermal/dove_thermal.c                          |    4 ++--
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c |    6 +++---
 drivers/thermal/kirkwood_thermal.c                      |    4 ++--
 drivers/thermal/spear_thermal.c                         |    4 ++--
 6 files changed, 14 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/power/supply/power_supply_core.c
===================================================================
--- linux-pm.orig/drivers/power/supply/power_supply_core.c
+++ linux-pm/drivers/power/supply/power_supply_core.c
@@ -1305,8 +1305,8 @@ static int psy_register_thermal(struct p
 
 	/* Register battery zone device psy reports temperature */
 	if (psy_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
-		psy->tzd = thermal_zone_device_register(psy->desc->name,
-				0, 0, psy, &psy_tzd_ops, NULL, 0, 0);
+		psy->tzd = thermal_tripless_zone_device_register(psy->desc->name,
+				psy, &psy_tzd_ops, NULL);
 		if (IS_ERR(psy->tzd))
 			return PTR_ERR(psy->tzd);
 		ret = thermal_zone_device_enable(psy->tzd);
Index: linux-pm/drivers/thermal/armada_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/armada_thermal.c
+++ linux-pm/drivers/thermal/armada_thermal.c
@@ -876,8 +876,9 @@ static int armada_thermal_probe(struct p
 		/* Wait the sensors to be valid */
 		armada_wait_sensor_validity(priv);
 
-		tz = thermal_zone_device_register(priv->zone_name, 0, 0, priv,
-						  &legacy_ops, NULL, 0, 0);
+		tz = thermal_tripless_zone_device_register(priv->zone_name,
+							   priv, &legacy_ops,
+							   NULL);
 		if (IS_ERR(tz)) {
 			dev_err(&pdev->dev,
 				"Failed to register thermal zone device\n");
Index: linux-pm/drivers/thermal/dove_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/dove_thermal.c
+++ linux-pm/drivers/thermal/dove_thermal.c
@@ -139,8 +139,8 @@ static int dove_thermal_probe(struct pla
 		return ret;
 	}
 
-	thermal = thermal_zone_device_register("dove_thermal", 0, 0,
-					       priv, &ops, NULL, 0, 0);
+	thermal = thermal_tripless_zone_device_register("dove_thermal", priv,
+							&ops, NULL);
 	if (IS_ERR(thermal)) {
 		dev_err(&pdev->dev,
 			"Failed to register thermal zone device\n");
Index: linux-pm/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -609,9 +609,9 @@ static int int3400_thermal_probe(struct
 
 	evaluate_odvp(priv);
 
-	priv->thermal = thermal_zone_device_register("INT3400 Thermal", 0, 0,
-						priv, &int3400_thermal_ops,
-						&int3400_thermal_params, 0, 0);
+	priv->thermal = thermal_tripless_zone_device_register("INT3400 Thermal", priv,
+							      &int3400_thermal_ops,
+							      &int3400_thermal_params);
 	if (IS_ERR(priv->thermal)) {
 		result = PTR_ERR(priv->thermal);
 		goto free_art_trt;
Index: linux-pm/drivers/thermal/kirkwood_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/kirkwood_thermal.c
+++ linux-pm/drivers/thermal/kirkwood_thermal.c
@@ -71,8 +71,8 @@ static int kirkwood_thermal_probe(struct
 	if (IS_ERR(priv->sensor))
 		return PTR_ERR(priv->sensor);
 
-	thermal = thermal_zone_device_register("kirkwood_thermal", 0, 0,
-					       priv, &ops, NULL, 0, 0);
+	thermal = thermal_tripless_zone_device_register("kirkwood_thermal",
+							priv, &ops, NULL);
 	if (IS_ERR(thermal)) {
 		dev_err(&pdev->dev,
 			"Failed to register thermal zone device\n");
Index: linux-pm/drivers/thermal/spear_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/spear_thermal.c
+++ linux-pm/drivers/thermal/spear_thermal.c
@@ -122,8 +122,8 @@ static int spear_thermal_probe(struct pl
 	stdev->flags = val;
 	writel_relaxed(stdev->flags, stdev->thermal_base);
 
-	spear_thermal = thermal_zone_device_register("spear_thermal", 0, 0,
-				stdev, &ops, NULL, 0, 0);
+	spear_thermal = thermal_tripless_zone_device_register("spear_thermal",
+							      stdev, &ops, NULL);
 	if (IS_ERR(spear_thermal)) {
 		dev_err(&pdev->dev, "thermal zone device is NULL\n");
 		ret = PTR_ERR(spear_thermal);



