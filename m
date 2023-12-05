Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEAB805422
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345265AbjLEM1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345274AbjLEM13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:27:29 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF1B11F;
        Tue,  5 Dec 2023 04:27:16 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 18e4870ed7d4aca5; Tue, 5 Dec 2023 13:27:14 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by cloudserver094114.home.pl (Postfix) with ESMTPSA id 746B96687D0;
        Tue,  5 Dec 2023 13:27:14 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v4 1/2] thermal: sysfs: Rework the handling of trip point updates
Date:   Tue, 05 Dec 2023 13:24:08 +0100
Message-ID: <4882089.31r3eYUQgx@kreacher>
In-Reply-To: <12337662.O9o76ZdvQC@kreacher>
References: <12337662.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudejkedgfeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhi
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

Both trip_point_temp_store() and trip_point_hyst_store() use
thermal_zone_set_trip() to update a given trip point, but none of them
actually needs to change more than one field in struct thermal_trip
representing it.  However, each of them effectively calls
__thermal_zone_get_trip() twice in a row for the same trip index value,
once directly and once via thermal_zone_set_trip(), which is not
particularly efficient, and the way in which thermal_zone_set_trip()
carries out the update is not particularly straightforward.

Moreover, input processing need not be done under the thermal zone lock
in any of these functions.

Rework trip_point_temp_store() and trip_point_hyst_store() to address
the above, move the part of thermal_zone_set_trip() that is still
useful to a new function called thermal_zone_trip_updated() and drop
the rest of it.

While at it, make trip_point_hyst_store() reject negative hysteresis
values.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v3 -> v4: Don't check trip_id against boundaries in trip_point_temp_store() and
          trip_point_hyst_store() (Daniel).

v2 -> v3: No changes

v1 -> v2: Still check device_is_registered() under the zone lock

---
 drivers/thermal/thermal_core.h  |    2 +
 drivers/thermal/thermal_sysfs.c |   52 +++++++++++++++++++++++++++-------------
 drivers/thermal/thermal_trip.c  |   45 ++++++----------------------------
 include/linux/thermal.h         |    4 ---
 4 files changed, 47 insertions(+), 56 deletions(-)

Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -120,8 +120,13 @@ trip_point_temp_store(struct device *dev
 		      const char *buf, size_t count)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	struct thermal_trip trip;
+	struct thermal_trip *trip;
 	int trip_id, ret;
+	int temp;
+
+	ret = kstrtoint(buf, 10, &temp);
+	if (ret)
+		return -EINVAL;
 
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
 		return -EINVAL;
@@ -133,15 +138,20 @@ trip_point_temp_store(struct device *dev
 		goto unlock;
 	}
 
-	ret = __thermal_zone_get_trip(tz, trip_id, &trip);
-	if (ret)
-		goto unlock;
+	trip = &tz->trips[trip_id];
 
-	ret = kstrtoint(buf, 10, &trip.temperature);
-	if (ret)
-		goto unlock;
+	if (temp != trip->temperature) {
+		if (tz->ops->set_trip_temp) {
+			ret = tz->ops->set_trip_temp(tz, trip_id, temp);
+			if (ret)
+				goto unlock;
+		}
+
+		trip->temperature = temp;
+
+		thermal_zone_trip_updated(tz, trip);
+	}
 
-	ret = thermal_zone_set_trip(tz, trip_id, &trip);
 unlock:
 	mutex_unlock(&tz->lock);
 	
@@ -179,8 +189,13 @@ trip_point_hyst_store(struct device *dev
 		      const char *buf, size_t count)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	struct thermal_trip trip;
+	struct thermal_trip *trip;
 	int trip_id, ret;
+	int hyst;
+
+	ret = kstrtoint(buf, 10, &hyst);
+	if (ret || hyst < 0)
+		return -EINVAL;
 
 	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) != 1)
 		return -EINVAL;
@@ -192,15 +207,20 @@ trip_point_hyst_store(struct device *dev
 		goto unlock;
 	}
 
-	ret = __thermal_zone_get_trip(tz, trip_id, &trip);
-	if (ret)
-		goto unlock;
+	trip = &tz->trips[trip_id];
 
-	ret = kstrtoint(buf, 10, &trip.hysteresis);
-	if (ret)
-		goto unlock;
+	if (hyst != trip->hysteresis) {
+		if (tz->ops->set_trip_hyst) {
+			ret = tz->ops->set_trip_hyst(tz, trip_id, hyst);
+			if (ret)
+				goto unlock;
+		}
+
+		trip->hysteresis = hyst;
+
+		thermal_zone_trip_updated(tz, trip);
+	}
 
-	ret = thermal_zone_set_trip(tz, trip_id, &trip);
 unlock:
 	mutex_unlock(&tz->lock);
 
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -124,6 +124,8 @@ int __thermal_zone_get_trip(struct therm
 			    struct thermal_trip *trip);
 int thermal_zone_trip_id(struct thermal_zone_device *tz,
 			 const struct thermal_trip *trip);
+void thermal_zone_trip_updated(struct thermal_zone_device *tz,
+			       const struct thermal_trip *trip);
 int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 
 /* sysfs I/F */
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -147,42 +147,6 @@ int thermal_zone_get_trip(struct thermal
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_trip);
 
-int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
-			  const struct thermal_trip *trip)
-{
-	struct thermal_trip t;
-	int ret;
-
-	ret = __thermal_zone_get_trip(tz, trip_id, &t);
-	if (ret)
-		return ret;
-
-	if (t.type != trip->type)
-		return -EINVAL;
-
-	if (t.temperature != trip->temperature && tz->ops->set_trip_temp) {
-		ret = tz->ops->set_trip_temp(tz, trip_id, trip->temperature);
-		if (ret)
-			return ret;
-	}
-
-	if (t.hysteresis != trip->hysteresis && tz->ops->set_trip_hyst) {
-		ret = tz->ops->set_trip_hyst(tz, trip_id, trip->hysteresis);
-		if (ret)
-			return ret;
-	}
-
-	if (tz->trips && (t.temperature != trip->temperature || t.hysteresis != trip->hysteresis))
-		tz->trips[trip_id] = *trip;
-
-	thermal_notify_tz_trip_change(tz->id, trip_id, trip->type,
-				      trip->temperature, trip->hysteresis);
-
-	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
-
-	return 0;
-}
-
 int thermal_zone_trip_id(struct thermal_zone_device *tz,
 			 const struct thermal_trip *trip)
 {
@@ -192,3 +156,12 @@ int thermal_zone_trip_id(struct thermal_
 	 */
 	return trip - tz->trips;
 }
+
+void thermal_zone_trip_updated(struct thermal_zone_device *tz,
+			       const struct thermal_trip *trip)
+{
+	thermal_notify_tz_trip_change(tz->id, thermal_zone_trip_id(tz, trip),
+				      trip->type, trip->temperature,
+				      trip->hysteresis);
+	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
+}
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -282,10 +282,6 @@ int __thermal_zone_get_trip(struct therm
 			    struct thermal_trip *trip);
 int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 			  struct thermal_trip *trip);
-
-int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
-			  const struct thermal_trip *trip);
-
 int for_each_thermal_trip(struct thermal_zone_device *tz,
 			  int (*cb)(struct thermal_trip *, void *),
 			  void *data);



