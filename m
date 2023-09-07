Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4EF797B82
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238822AbjIGSTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjIGSTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:19:15 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707EA1705;
        Thu,  7 Sep 2023 11:18:59 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 567bb54194be6a4c; Thu, 7 Sep 2023 20:18:57 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id D03936636D6;
        Thu,  7 Sep 2023 20:18:56 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-omap@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>, Keerthy <j-keerthy@ti.com>
Subject: [PATCH v1] thermal: Constify the trip argument of the .get_trend() zone callback
Date:   Thu, 07 Sep 2023 20:18:56 +0200
Message-ID: <5709115.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudehhedguddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeelpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphht
 thhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=9 Fuz1=9 Fuz2=9
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add 'const' to the definition of the 'trip' argument of the
.get_trend() thermal zone callback to indicate that the trip point
passed to it should not be modified by it and adjust the
callback functions implementing it, thermal_get_trend() in the
ACPI thermal driver and __ti_thermal_get_trend(), accordingly.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c                             |    2 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |    3 ++-
 include/linux/thermal.h                            |    4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
===================================================================
--- linux-pm.orig/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ linux-pm/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -110,7 +110,8 @@ static inline int __ti_thermal_get_temp(
 }
 
 static int __ti_thermal_get_trend(struct thermal_zone_device *tz,
-				  struct thermal_trip *trip, enum thermal_trend *trend)
+				  const struct thermal_trip *trip,
+				  enum thermal_trend *trend)
 {
 	struct ti_thermal_data *data = thermal_zone_device_priv(tz);
 	struct ti_bandgap *bgp;
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -80,8 +80,8 @@ struct thermal_zone_device_ops {
 	int (*set_trip_hyst) (struct thermal_zone_device *, int, int);
 	int (*get_crit_temp) (struct thermal_zone_device *, int *);
 	int (*set_emul_temp) (struct thermal_zone_device *, int);
-	int (*get_trend) (struct thermal_zone_device *, struct thermal_trip *,
-			  enum thermal_trend *);
+	int (*get_trend) (struct thermal_zone_device *,
+			  const struct thermal_trip *, enum thermal_trend *);
 	void (*hot)(struct thermal_zone_device *);
 	void (*critical)(struct thermal_zone_device *);
 };
Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -531,7 +531,7 @@ static int thermal_get_temp(struct therm
 }
 
 static int thermal_get_trend(struct thermal_zone_device *thermal,
-			     struct thermal_trip *trip,
+			     const struct thermal_trip *trip,
 			     enum thermal_trend *trend)
 {
 	struct acpi_thermal *tz = thermal_zone_device_priv(thermal);



