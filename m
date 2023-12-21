Return-Path: <linux-kernel+bounces-8396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE76C81B68F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8211C2489A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170C97D607;
	Thu, 21 Dec 2023 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1mF95Ueg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE52E7C670;
	Thu, 21 Dec 2023 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703162932;
	bh=JvnNtNzLnxBHi+1B1yovKVASCm/Y8JsnlC3wCWBkVHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1mF95Ueg2YUSSDBl1QmdMUylbMga3HSXJmzyGclvWb10VCCfy5kTErmhb41XNRgsx
	 7IM9CnziwKY0iIWy07uhkWGdJdGEx5iWogKMj0nQG4AuDKTHXEPjs6Fs/wPjWl5Xj+
	 Lk/I+BPrj6OiMDbjjL6KizWNo89J1LweQEKABLUdz7VZB0Wp3OTGAsFJE5RQ4PAsiJ
	 Id+VQqJlTkPmyVZzMMKCT2yqHhza0os4qdSRtXQLmFj+fqRM6p8YffIZGGyz6W2f//
	 khaD/ajprR7yOt06Cgv6D8W1NTiicjHHqqVNIIcrsGA0N9LESZ5llYooSxt4MSv5Vp
	 avJV8jmCu8+FA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BFCBB3782025;
	Thu, 21 Dec 2023 12:48:51 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com
Subject: [RFC PATCH 26/26] thermal: Introduce thermal zones names
Date: Thu, 21 Dec 2023 13:48:25 +0100
Message-ID: <20231221124825.149141-27-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221124825.149141-1-angelogioacchino.delregno@collabora.com>
References: <20231221124825.149141-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently thermal zones have a "type" but this is often used, and
referenced, as a name instead in multiple kernel drivers that are
either registering a zone or grabbing a thermal zone handle and
unfortunately this is a kind of abuse/misuse of the thermal zone
concept of "type".

In order to disambiguate name<->type and to actually provide an
accepted way of giving a specific name to a thermal zone for both
platform drivers and devicetree-defined zones, add a new "name"
member in the main thermal_zone_device structure, and also to the
thermal_zone_device_params structure which is used to register a
thermal zone device.

This will enforce the following constraints:
 - Multiple thermal zones may be of the same "type" (no change);
 - A thermal zone may have a *unique* name: trying to register
   a new zone with the same name as an already present one will
   produce a failure;
---
 drivers/thermal/thermal_core.c  | 34 ++++++++++++++++++++++++++++++---
 drivers/thermal/thermal_of.c    |  1 +
 drivers/thermal/thermal_sysfs.c |  9 +++++++++
 drivers/thermal/thermal_trace.h | 17 +++++++++++------
 include/linux/thermal.h         |  4 ++++
 5 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9eb0200a85ff..adf2ac8113e1 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1238,8 +1238,8 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
 struct thermal_zone_device *thermal_zone_device_register(struct thermal_zone_device_params *tzdp)
 {
 	struct thermal_zone_device *tz;
-	int id;
-	int result;
+	int id, tz_name_len;
+	int result = 0;
 	struct thermal_governor *governor;
 
 	if (!tzdp->type || strlen(tzdp->type) == 0) {
@@ -1248,11 +1248,36 @@ struct thermal_zone_device *thermal_zone_device_register(struct thermal_zone_dev
 	}
 
 	if (strlen(tzdp->type) >= THERMAL_NAME_LENGTH) {
-		pr_err("Thermal zone name (%s) too long, should be under %d chars\n",
+		pr_err("Thermal zone type (%s) too long, should be under %d chars\n",
 		       tzdp->type, THERMAL_NAME_LENGTH);
 		return ERR_PTR(-EINVAL);
 	}
 
+	tz_name_len = tzdp->name ? strlen(tzdp->name) : 0;
+	if (tz_name_len) {
+		struct thermal_zone_device *pos;
+
+		if (tz_name_len >= THERMAL_NAME_LENGTH) {
+			pr_err("Thermal zone name (%s) too long, should be under %d chars\n",
+			       tzdp->name, THERMAL_NAME_LENGTH);
+			return ERR_PTR(-EINVAL);
+		}
+
+		mutex_lock(&thermal_list_lock);
+		list_for_each_entry(pos, &thermal_tz_list, node)
+			if (!strncasecmp(tzdp->name, pos->name, THERMAL_NAME_LENGTH)) {
+				result = -EEXIST;
+				break;
+			}
+		mutex_unlock(&thermal_list_lock);
+
+		if (result) {
+			pr_err("Thermal zone name (%s) already exists and must be unique\n",
+			       tzdp->name);
+			return ERR_PTR(result);
+		}
+	}
+
 	/*
 	 * Max trip count can't exceed 31 as the "mask >> num_trips" condition.
 	 * For example, shifting by 32 will result in compiler warning:
@@ -1307,6 +1332,9 @@ struct thermal_zone_device *thermal_zone_device_register(struct thermal_zone_dev
 	tz->id = id;
 	strscpy(tz->type, tzdp->type, sizeof(tz->type));
 
+	if (tz_name_len)
+		strscpy(tz->name, tzdp->name, sizeof(tzdp->name));
+
 	if (!tzdp->ops->critical)
 		tzdp->ops->critical = thermal_zone_device_critical;
 
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 62a903ad649f..eaacc140abeb 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -486,6 +486,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 		ret = PTR_ERR(np);
 		goto out_kfree_of_ops;
 	}
+	tzdp.name = np->name;
 	tzdp.type = np->name;
 
 	tzdp.trips = thermal_of_trips_init(np, &tzdp.num_trips);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index f52af8a3b4b5..f4002fa6caa2 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -23,6 +23,14 @@
 
 /* sys I/F for thermal zone */
 
+static ssize_t
+name_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
+
+	return sprintf(buf, "%s\n", tz->name);
+}
+
 static ssize_t
 type_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -341,6 +349,7 @@ create_s32_tzp_attr(offset);
  * All the attributes created for tzp (create_s32_tzp_attr) also are always
  * present on the sysfs interface.
  */
+static DEVICE_ATTR_RO(name);
 static DEVICE_ATTR_RO(type);
 static DEVICE_ATTR_RO(temp);
 static DEVICE_ATTR_RW(policy);
diff --git a/drivers/thermal/thermal_trace.h b/drivers/thermal/thermal_trace.h
index 459c8ce6cf3b..c9dbae1e3b9e 100644
--- a/drivers/thermal/thermal_trace.h
+++ b/drivers/thermal/thermal_trace.h
@@ -28,6 +28,7 @@ TRACE_EVENT(thermal_temperature,
 	TP_ARGS(tz),
 
 	TP_STRUCT__entry(
+		__string(thermal_zone_name, tz->name)
 		__string(thermal_zone, tz->type)
 		__field(int, id)
 		__field(int, temp_prev)
@@ -35,15 +36,16 @@ TRACE_EVENT(thermal_temperature,
 	),
 
 	TP_fast_assign(
+		__assign_str(thermal_zone_name, tz->name);
 		__assign_str(thermal_zone, tz->type);
 		__entry->id = tz->id;
 		__entry->temp_prev = tz->last_temperature;
 		__entry->temp = tz->temperature;
 	),
 
-	TP_printk("thermal_zone=%s id=%d temp_prev=%d temp=%d",
-		__get_str(thermal_zone), __entry->id, __entry->temp_prev,
-		__entry->temp)
+	TP_printk("thermal_zone=%s name=%s id=%d temp_prev=%d temp=%d",
+		  __get_str(thermal_zone), __get_str(thermal_zone_name),
+		  __entry->id, __entry->temp_prev, __entry->temp)
 );
 
 TRACE_EVENT(cdev_update,
@@ -73,6 +75,7 @@ TRACE_EVENT(thermal_zone_trip,
 	TP_ARGS(tz, trip, trip_type),
 
 	TP_STRUCT__entry(
+		__string(thermal_zone_name, tz->name)
 		__string(thermal_zone, tz->type)
 		__field(int, id)
 		__field(int, trip)
@@ -80,15 +83,17 @@ TRACE_EVENT(thermal_zone_trip,
 	),
 
 	TP_fast_assign(
+		__assign_str(thermal_zone_name, tz->name);
 		__assign_str(thermal_zone, tz->type);
 		__entry->id = tz->id;
 		__entry->trip = trip;
 		__entry->trip_type = trip_type;
 	),
 
-	TP_printk("thermal_zone=%s id=%d trip=%d trip_type=%s",
-		__get_str(thermal_zone), __entry->id, __entry->trip,
-		show_tzt_type(__entry->trip_type))
+	TP_printk("thermal_zone=%s name=%s id=%d trip=%d trip_type=%s",
+		  __get_str(thermal_zone), __get_str(thermal_zone_name),
+		  __entry->id, __entry->trip,
+		  show_tzt_type(__entry->trip_type))
 );
 
 #ifdef CONFIG_CPU_THERMAL
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 84b62575d93a..a06521eda162 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -115,6 +115,7 @@ struct thermal_cooling_device {
 /**
  * struct thermal_zone_device - structure for a thermal zone
  * @id:		unique id number for each thermal zone
+ * @name:       name of the thermal zone device
  * @type:	the thermal zone device type
  * @device:	&struct device for this thermal zone
  * @removal:	removal completion
@@ -155,6 +156,7 @@ struct thermal_cooling_device {
  */
 struct thermal_zone_device {
 	int id;
+	char name[THERMAL_NAME_LENGTH];
 	char type[THERMAL_NAME_LENGTH];
 	struct device device;
 	struct completion removal;
@@ -260,6 +262,7 @@ struct thermal_zone_params {
 
 /**
  * struct thermal_zone_device_params - parameters for a thermal zone device
+ * @name:		name of the thermal zone device
  * @type:		the thermal zone device type
  * @tzp:		thermal zone platform parameters
  * @ops:		standard thermal zone device callbacks
@@ -274,6 +277,7 @@ struct thermal_zone_params {
  *			driven systems)
  */
 struct thermal_zone_device_params {
+	const char *name;
 	const char *type;
 	struct thermal_zone_params tzp;
 	struct thermal_zone_device_ops *ops;
-- 
2.43.0


