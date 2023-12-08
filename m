Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C0E80ACCB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjLHTUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjLHTUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:20:39 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B3510F8;
        Fri,  8 Dec 2023 11:20:45 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id f217744729342198; Fri, 8 Dec 2023 20:20:43 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by cloudserver094114.home.pl (Postfix) with ESMTPSA id 5FC206688FC;
        Fri,  8 Dec 2023 20:20:43 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v1 2/3] thermal: Drop redundant and confusing device_is_registered() checks
Date:   Fri, 08 Dec 2023 20:19:03 +0100
Message-ID: <8315317.T7Z3S40VBb@kreacher>
In-Reply-To: <1880915.tdWV9SEqCh@kreacher>
References: <1880915.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudekiedguddvgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgt
 phhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Multiple places in the thermal subsystem (most importantly, sysfs
attribute callback functions) check if the given thermal zone device is
still registered in order to return early in case the device_del() in
thermal_zone_device_unregister() has run already.

However, after thermal_zone_device_unregister() has been made wait for
all of the zone-related activity to complete before returning, it is
not necessary to do that any more, because all of the code holding a
reference to the thermal zone device object will be waited for even if
it does not do anything special to enforce this.

Accordingly, drop all of the device_is_registered() checks that are now
redundant and get rid of the zone locking that is not necessary any more
after dropping them.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c    |    9 -----
 drivers/thermal/thermal_helpers.c |    5 ---
 drivers/thermal/thermal_hwmon.c   |    5 ---
 drivers/thermal/thermal_sysfs.c   |   60 +++-----------------------------------
 4 files changed, 7 insertions(+), 72 deletions(-)

Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -83,24 +83,12 @@ trip_point_type_show(struct device *dev,
 		     char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	enum thermal_trip_type type;
 	int trip_id;
 
 	if (sscanf(attr->attr.name, "trip_point_%d_type", &trip_id) != 1)
 		return -EINVAL;
 
-	mutex_lock(&tz->lock);
-
-	if (!device_is_registered(dev)) {
-		mutex_unlock(&tz->lock);
-		return -ENODEV;
-	}
-
-	type = tz->trips[trip_id].type;
-
-	mutex_unlock(&tz->lock);
-
-	switch (type) {
+	switch (tz->trips[trip_id].type) {
 	case THERMAL_TRIP_CRITICAL:
 		return sprintf(buf, "critical\n");
 	case THERMAL_TRIP_HOT:
@@ -132,11 +120,6 @@ trip_point_temp_store(struct device *dev
 
 	mutex_lock(&tz->lock);
 
-	if (!device_is_registered(dev)) {
-		ret = -ENODEV;
-		goto unlock;
-	}
-
 	trip = &tz->trips[trip_id];
 
 	if (temp != trip->temperature) {
@@ -162,23 +145,12 @@ trip_point_temp_show(struct device *dev,
 		     char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	int trip_id, temp;
+	int trip_id;
 
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
 		return -EINVAL;
 
-	mutex_lock(&tz->lock);
-
-	if (!device_is_registered(dev)) {
-		mutex_unlock(&tz->lock);
-		return -ENODEV;
-	}
-
-	temp = tz->trips[trip_id].temperature;
-
-	mutex_unlock(&tz->lock);
-
-	return sprintf(buf, "%d\n", temp);
+	return sprintf(buf, "%d\n", tz->trips[trip_id].temperature);
 }
 
 static ssize_t
@@ -199,11 +171,6 @@ trip_point_hyst_store(struct device *dev
 
 	mutex_lock(&tz->lock);
 
-	if (!device_is_registered(dev)) {
-		ret = -ENODEV;
-		goto unlock;
-	}
-
 	trip = &tz->trips[trip_id];
 
 	if (hyst != trip->hysteresis) {
@@ -229,23 +196,12 @@ trip_point_hyst_show(struct device *dev,
 		     char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	int trip_id, hyst;
+	int trip_id;
 
 	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) != 1)
 		return -EINVAL;
 
-	mutex_lock(&tz->lock);
-
-	if (!device_is_registered(dev)) {
-		mutex_unlock(&tz->lock);
-		return -ENODEV;
-	}
-
-	hyst = tz->trips[trip_id].hysteresis;
-
-	mutex_unlock(&tz->lock);
-
-	return sprintf(buf, "%d\n", hyst);
+	return sprintf(buf, "%d\n", tz->trips[trip_id].hysteresis);
 }
 
 static ssize_t
@@ -294,11 +250,6 @@ emul_temp_store(struct device *dev, stru
 
 	mutex_lock(&tz->lock);
 
-	if (!device_is_registered(dev)) {
-		ret = -ENODEV;
-		goto unlock;
-	}
-
 	if (!tz->ops->set_emul_temp)
 		tz->emul_temperature = temperature;
 	else
@@ -307,7 +258,6 @@ emul_temp_store(struct device *dev, stru
 	if (!ret)
 		__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
-unlock:
 	mutex_unlock(&tz->lock);
 
 	return ret ? ret : count;
Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -203,9 +203,6 @@ int thermal_zone_device_set_policy(struc
 	mutex_lock(&thermal_governor_lock);
 	mutex_lock(&tz->lock);
 
-	if (!device_is_registered(&tz->device))
-		goto exit;
-
 	gov = __find_governor(strim(policy));
 	if (!gov)
 		goto exit;
@@ -471,12 +468,6 @@ static int thermal_zone_device_set_mode(
 		return ret;
 	}
 
-	if (!device_is_registered(&tz->device)) {
-		mutex_unlock(&tz->lock);
-
-		return -ENODEV;
-	}
-
 	if (tz->ops->change_mode)
 		ret = tz->ops->change_mode(tz, mode);
 
Index: linux-pm/drivers/thermal/thermal_helpers.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_helpers.c
+++ linux-pm/drivers/thermal/thermal_helpers.c
@@ -137,10 +137,7 @@ int thermal_zone_get_temp(struct thermal
 		goto unlock;
 	}
 
-	if (device_is_registered(&tz->device))
-		ret = __thermal_zone_get_temp(tz, temp);
-	else
-		ret = -ENODEV;
+	ret = __thermal_zone_get_temp(tz, temp);
 
 unlock:
 	mutex_unlock(&tz->lock);
Index: linux-pm/drivers/thermal/thermal_hwmon.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_hwmon.c
+++ linux-pm/drivers/thermal/thermal_hwmon.c
@@ -80,10 +80,7 @@ temp_crit_show(struct device *dev, struc
 
 	mutex_lock(&tz->lock);
 
-	if (device_is_registered(&tz->device))
-		ret = tz->ops->get_crit_temp(tz, &temperature);
-	else
-		ret = -ENODEV;
+	ret = tz->ops->get_crit_temp(tz, &temperature);
 
 	mutex_unlock(&tz->lock);
 



