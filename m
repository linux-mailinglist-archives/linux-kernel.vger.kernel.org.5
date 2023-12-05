Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80489805423
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345281AbjLEM1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345324AbjLEM1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:27:31 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DCE113;
        Tue,  5 Dec 2023 04:27:16 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 3b11caba51df5267; Tue, 5 Dec 2023 13:27:14 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by cloudserver094114.home.pl (Postfix) with ESMTPSA id C195E6687D0;
        Tue,  5 Dec 2023 13:27:13 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v4 2/2] thermal: sysfs: Rework the reading of trip point attributes
Date:   Tue, 05 Dec 2023 13:26:59 +0100
Message-ID: <4854305.GXAFRqVoOG@kreacher>
In-Reply-To: <12337662.O9o76ZdvQC@kreacher>
References: <12337662.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudejkedggedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhi
 nhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rework the _show() callback functions for the trip point temperature,
hysteresis and type attributes to avoid copying the values of struct
thermal_trip fields that they do not use and make them carry out the
same validation checks as the corresponding _store() callback functions.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v3 -> v4: Don't check trip_id against boundaries in the _show routines
          for trip type, temperature and hysteresis (Daniel).

v2 -> v3: Drop a redundant 'ret' check at the end of trip_point_hyst_show.

v1 -> v2: Do not drop thermal zone locking from the _store() callback functions.

---
 drivers/thermal/thermal_sysfs.c |   52 +++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -83,25 +83,24 @@ trip_point_type_show(struct device *dev,
 		     char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	struct thermal_trip trip;
-	int trip_id, result;
+	enum thermal_trip_type type;
+	int trip_id;
 
 	if (sscanf(attr->attr.name, "trip_point_%d_type", &trip_id) != 1)
 		return -EINVAL;
 
 	mutex_lock(&tz->lock);
 
-	if (device_is_registered(dev))
-		result = __thermal_zone_get_trip(tz, trip_id, &trip);
-	else
-		result = -ENODEV;
+	if (!device_is_registered(dev)) {
+		mutex_unlock(&tz->lock);
+		return -ENODEV;
+	}
 
-	mutex_unlock(&tz->lock);
+	type = tz->trips[trip_id].type;
 
-	if (result)
-		return result;
+	mutex_unlock(&tz->lock);
 
-	switch (trip.type) {
+	switch (type) {
 	case THERMAL_TRIP_CRITICAL:
 		return sprintf(buf, "critical\n");
 	case THERMAL_TRIP_HOT:
@@ -163,25 +162,23 @@ trip_point_temp_show(struct device *dev,
 		     char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	struct thermal_trip trip;
-	int trip_id, ret;
+	int trip_id, temp;
 
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
 		return -EINVAL;
 
 	mutex_lock(&tz->lock);
 
-	if (device_is_registered(dev))
-		ret = __thermal_zone_get_trip(tz, trip_id, &trip);
-	else
-		ret = -ENODEV;
+	if (!device_is_registered(dev)) {
+		mutex_unlock(&tz->lock);
+		return -ENODEV;
+	}
 
-	mutex_unlock(&tz->lock);
+	temp = tz->trips[trip_id].temperature;
 
-	if (ret)
-		return ret;
+	mutex_unlock(&tz->lock);
 
-	return sprintf(buf, "%d\n", trip.temperature);
+	return sprintf(buf, "%d\n", temp);
 }
 
 static ssize_t
@@ -232,22 +229,23 @@ trip_point_hyst_show(struct device *dev,
 		     char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	struct thermal_trip trip;
-	int trip_id, ret;
+	int trip_id, hyst;
 
 	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) != 1)
 		return -EINVAL;
 
 	mutex_lock(&tz->lock);
 
-	if (device_is_registered(dev))
-		ret = __thermal_zone_get_trip(tz, trip_id, &trip);
-	else
-		ret = -ENODEV;
+	if (!device_is_registered(dev)) {
+		mutex_unlock(&tz->lock);
+		return -ENODEV;
+	}
+
+	hyst = tz->trips[trip_id].hysteresis;
 
 	mutex_unlock(&tz->lock);
 
-	return ret ? ret : sprintf(buf, "%d\n", trip.hysteresis);
+	return sprintf(buf, "%d\n", hyst);
 }
 
 static ssize_t



