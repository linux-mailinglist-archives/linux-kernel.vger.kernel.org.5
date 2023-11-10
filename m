Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925767E8212
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbjKJSxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbjKJSwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:52:51 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3017711993
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:11:46 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c5028e5b88so31633471fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699639896; x=1700244696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0xGJeDR4/7u9iQ108F7BA1qd1eSOOfCDWuJ7xoMzkhg=;
        b=dlW9ZXfd63riRAOXP/x4Nb4i5RQ8jOW1D8Mi66KkeNBwduHeF5kgnsinD8gpRcX4+X
         yXCxaixvpoU/y4JBNlDT8V7CDrE1pFiA3iKh4bJ/uC9+5zZb7h3UxAsVVyOt/JUWt02U
         Kt6csVvLfxR7NCthtG+lXirFjuox72CBN0v3HdbBel/0NdiL+fMF069gyfBsaakAV9uQ
         RrjaEbiftJ+XHTUyg6oStyc1kcj11A5Uas7EUy0lS53a78k0YuSoIBzUCXP6jay2CM6/
         XSvNKwk/bigA8ZEZWNh5YOilDSMeiqNjJKOfqZ8eV1sGkIG35tU/uKiN79CzRmozzwX6
         CY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699639896; x=1700244696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xGJeDR4/7u9iQ108F7BA1qd1eSOOfCDWuJ7xoMzkhg=;
        b=rPMiFma97AN2otc71bKKz6HMyHDmrt59s4WFZh0ganqwX9wzlaLQnH2eNgYgyzr+FD
         06f5RVoPEiiCC1kGEYf5/t29V7n76XEvcfO+mTvJOtremOa7Ss8t+gNliPHJVpXcGCI2
         OMyON4YkObeKic4MyRg1P2Y+Cf1z2pRgZY5Kh01cibEGDBSPAk8ucGt0L0JFXwp+0BtB
         7HaBb/ssznudstyDFfdKAmLLQEEnGj4UQkMn9dX6gOlXTwpmDz18eucfUPKb4OGZlycs
         5XwJ2O+6Mhn3BxfZiyCVPMYOwwBK6Eqa+FzvYUj4B/K4kCY59xJonf29pB79e3yjNfRu
         Q0lA==
X-Gm-Message-State: AOJu0YxaYG6Mq4ronnUIwK5iTMRCO9f1CoDpeuwCLw5J+gHdqggkrVZ2
        863fav6/UfpAUxH5+DL1CE2CNQ==
X-Google-Smtp-Source: AGHT+IG2YsNFd6qi/1gV/eLGHxDTyp+/8NgA/LMMaElOn53aQpJqJm2eY8sWErM9XkVy4mEFlXXKWA==
X-Received: by 2002:a2e:a363:0:b0:2c5:999:de64 with SMTP id i3-20020a2ea363000000b002c50999de64mr90904ljn.16.1699639895621;
        Fri, 10 Nov 2023 10:11:35 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.gmail.com with ESMTPSA id w23-20020a05600c2a1700b003fe23b10fdfsm5742268wme.36.2023.11.10.10.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 10:11:35 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc:     lukasz.luba@arm.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [RFC PATCH] thermal/debugfs: Add thermal debugfs information
Date:   Fri, 10 Nov 2023 19:11:23 +0100
Message-Id: <20231110181123.2389186-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal framework does not have any debug information except a
sysfs stat which is a bit controversial. This one allocates big chunks
of memory for every cooling devices with a high number of states and
could represent on some systems in production several megabytes of
memory for just a portion of it. As the syfs is limited to a page
size, the output is not exploitable with large data array and gets
truncated.

The patch provides the same information than sysfs except the
transitions are dynamically allocated, thus they won't show more
events than the ones which actually occured. There is no longer a size
limitation and it opens the field for more debugging information where
the debugfs is designed for, not sysfs.

On the thermal zone temperature side, the mitigation episodes are
recorded. A mitigation episode happens when the first trip point is
crossed the way up and then the way down. During this episode other
trip points can be crossed also and are accounted for this mitigation
episode. The interesting information is the average temperature at the
trip point, the undershot and the overshot. The standard deviation of
the mitigated temperature will be added later.

The thermal debugfs directory structure tries to stay consistent with
the sysfs one but in a very simplified way:

thermal/
|-- cooling_devices
|   |-- 0
|   |   |-- reset
|   |   |-- time_in_state_ms
|   |   |-- total_trans
|   |   `-- trans_table
|   |-- 1
|   |   |-- reset
|   |   |-- time_in_state_ms
|   |   |-- total_trans
|   |   `-- trans_table
|   |-- 2
|   |   |-- reset
|   |   |-- time_in_state_ms
|   |   |-- total_trans
|   |   `-- trans_table
|   |-- 3
|   |   |-- reset
|   |   |-- time_in_state_ms
|   |   |-- total_trans
|   |   `-- trans_table
|   `-- 4
|       |-- reset
|       |-- time_in_state_ms
|       |-- total_trans
|       `-- trans_table
`-- thermal_zones
    |-- 0
    |   `-- mitigations
    `-- 1
        `-- mitigations

The content of the files in the cooling devices directory is the same
as the sysfs one except for the trans_table which has the following
format:

Transition	Hits
1->0      	246
0->1      	246
2->1      	632
1->2      	632
3->2      	98
2->3      	98

And finally the content of the mitigations file has the following
format:

,-Mitigation at 349988258us, duration=130136ms
| trip |     type | temp(°mC) | hyst(°mC) |  duration  |  avg(°mC) |  min(°mC) |  max(°mC) |
|    0 |  passive |     65000 |      2000 |     130136 |     68227 |     62500 |     75625 |
|    1 |  passive |     75000 |      2000 |     104209 |     74857 |     71666 |     77500 |
,-Mitigation at 272451637us, duration=75000ms
| trip |     type | temp(°mC) | hyst(°mC) |  duration  |  avg(°mC) |  min(°mC) |  max(°mC) |
|    0 |  passive |     65000 |      2000 |      75000 |     68561 |     62500 |     75000 |
|    1 |  passive |     75000 |      2000 |      60714 |     74820 |     70555 |     77500 |
,-Mitigation at 238184119us, duration=27316ms
| trip |     type | temp(°mC) | hyst(°mC) |  duration  |  avg(°mC) |  min(°mC) |  max(°mC) |
|    0 |  passive |     65000 |      2000 |      27316 |     73377 |     62500 |     75000 |
|    1 |  passive |     75000 |      2000 |      19468 |     75284 |     69444 |     77500 |
,-Mitigation at 39863713us, duration=136196ms
| trip |     type | temp(°mC) | hyst(°mC) |  duration  |  avg(°mC) |  min(°mC) |  max(°mC) |
|    0 |  passive |     65000 |      2000 |     136196 |     73922 |     62500 |     75000 |
|    1 |  passive |     75000 |      2000 |      91721 |     74386 |     69444 |     78125 |

More information for a better understanding of the thermal behavior
will be added after. The idea is to give detailed statistics
information about the undershots and overshots, the temperature speed,
etc... As all the information in a single file is too much, the idea
would be to create a directory named with the mitigation timestamp
where all data could be added.

Please note this code is immune against trip ordering.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/Kconfig           |   7 +
 drivers/thermal/Makefile          |   3 +
 drivers/thermal/thermal_core.c    |  23 +-
 drivers/thermal/thermal_core.h    |   1 +
 drivers/thermal/thermal_debugfs.c | 679 ++++++++++++++++++++++++++++++
 drivers/thermal/thermal_debugfs.h |  23 +
 drivers/thermal/thermal_helpers.c |  27 +-
 include/linux/thermal.h           |   7 +
 8 files changed, 758 insertions(+), 12 deletions(-)
 create mode 100644 drivers/thermal/thermal_debugfs.c
 create mode 100644 drivers/thermal/thermal_debugfs.h

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index c81a00fbca7d..b78800e512a8 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -33,6 +33,13 @@ config THERMAL_STATISTICS
 
 	  If in doubt, say N.
 
+config THERMAL_DEBUGFS
+	bool "Thermal debugging file system"
+	depends on DEBUG_FS
+	help
+	  This option provides a debugfs entry giving useful
+	  information about the thermal framework internals.
+
 config THERMAL_EMERGENCY_POWEROFF_DELAY_MS
 	int "Emergency poweroff delay in milli-seconds"
 	default 0
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index c934cab309ae..234f19f7efe3 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -10,6 +10,9 @@ thermal_sys-y			+= thermal_trip.o thermal_helpers.o
 # netlink interface to manage the thermal framework
 thermal_sys-$(CONFIG_THERMAL_NETLINK)		+= thermal_netlink.o
 
+# debugfs interface to investigate the behavior and statistics
+thermal_sys-$(CONFIG_THERMAL_DEBUGFS)	+= thermal_debugfs.o
+
 # interface to/from other layers providing sensors
 thermal_sys-$(CONFIG_THERMAL_HWMON)		+= thermal_hwmon.o
 thermal_sys-$(CONFIG_THERMAL_OF)		+= thermal_of.o
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 3fe9232e355d..635cd08882c8 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -355,17 +355,17 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
 		if (tz->temperature >= trip->temperature)
 			trip->threshold -= trip->hysteresis;
 	} else {
+		int trip_id = thermal_zone_trip_id(tz, trip);
+		
 		if (tz->last_temperature < trip->threshold &&
 		    tz->temperature >= trip->threshold) {
-			thermal_notify_tz_trip_up(tz->id,
-						  thermal_zone_trip_id(tz, trip),
-						  tz->temperature);
+			thermal_notify_tz_trip_up(tz->id, trip_id, tz->temperature);
+			thermal_debugfs_handle_way_up(tz, trip_id, tz->temperature);
 			trip->threshold = trip->temperature - trip->hysteresis;
 		} else if (tz->last_temperature >= trip->threshold &&
 			   tz->temperature < trip->threshold) {
-			thermal_notify_tz_trip_down(tz->id,
-						    thermal_zone_trip_id(tz, trip),
-						    tz->temperature);
+			thermal_notify_tz_trip_down(tz->id, trip_id, tz->temperature);
+			thermal_debugfs_handle_way_down(tz, trip_id, tz->temperature);
 			trip->threshold = trip->temperature;
 		}
 	}
@@ -395,6 +395,7 @@ static void update_temperature(struct thermal_zone_device *tz)
 	trace_thermal_temperature(tz);
 
 	thermal_genl_sampling_temp(tz->id, temp);
+	thermal_debugfs_update_temp(tz);
 }
 
 static void thermal_zone_device_init(struct thermal_zone_device *tz)
@@ -923,6 +924,8 @@ __thermal_cooling_device_register(struct device_node *np,
 
 	mutex_unlock(&thermal_list_lock);
 
+	thermal_debugfs_cdev_register(cdev);
+	
 	return cdev;
 
 out_cooling_dev:
@@ -1129,6 +1132,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 	if (!cdev)
 		return;
 
+	thermal_debugfs_cdev_unregister(cdev);
+
 	mutex_lock(&thermal_list_lock);
 
 	if (!thermal_cooling_device_present(cdev)) {
@@ -1370,6 +1375,8 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 
 	thermal_notify_tz_create(tz->id, tz->type);
 
+	thermal_debugfs_tz_register(tz);
+
 	return tz;
 
 unregister:
@@ -1435,6 +1442,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	if (!tz)
 		return;
 
+	thermal_debugfs_tz_unregister(tz);
+
 	tz_id = tz->id;
 
 	mutex_lock(&thermal_list_lock);
@@ -1548,6 +1557,8 @@ static int __init thermal_init(void)
 {
 	int result;
 
+	thermal_debugfs_init();
+
 	result = thermal_netlink_init();
 	if (result)
 		goto error;
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 0a3b3ec5120b..809d37d0aa28 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -13,6 +13,7 @@
 #include <linux/thermal.h>
 
 #include "thermal_netlink.h"
+#include "thermal_debugfs.h"
 
 /* Default Thermal Governor */
 #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_debugfs.c
new file mode 100644
index 000000000000..4053fd2fe16f
--- /dev/null
+++ b/drivers/thermal/thermal_debugfs.c
@@ -0,0 +1,679 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 Linaro Limited
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ * Debug filesystem for the thermal framework
+ */
+#include <linux/debugfs.h>
+#include <linux/ktime.h>
+#include <linux/list.h>
+#include <linux/minmax.h>
+#include <linux/mutex.h>
+#include <linux/thermal.h>
+
+static struct dentry *d_root;
+static struct dentry *d_cdev;
+static struct dentry *d_tz;
+
+/*
+ * Length of the string containing the thermal zone id, including the
+ * ending null character. We can reasonably assume there won't be more
+ * than 256 thermal zones as the maximum observed today is around 32.
+ */
+#define IDSLENGTH 4
+
+/*
+ * The cooling device transition list is stored in a hash table where
+ * the size is CDEVSTATS_HASH_SIZE. The majority of cooling devices
+ * have dozen of states but some can have much more, so a hash table
+ * is more adequate in this case because browsing the entire list when
+ * storing the transitions could have a non neglictible cost
+ */
+#define CDEVSTATS_HASH_SIZE 16
+
+struct cdev_value {
+	struct list_head list;
+	int id;
+	u64 value;
+};
+
+/*
+ * A cooling device can have a high number of states. Showing the
+ * transitions on a matrix based representation can be overkill given
+ * most of the transitions won't happen and we end up with a matrix
+ * filled with zero. Instead, we show the transitions which actually
+ * happened.
+ */
+struct cdev_debugfs {
+	u32 total;
+	int current_state;
+	ktime_t timestamp;
+	struct list_head trans_list[CDEVSTATS_HASH_SIZE];
+	struct list_head duration_list[CDEVSTATS_HASH_SIZE];
+};
+
+/*
+ * The trip_stats structure has the relevant information to show the
+ * statistics related to a trip point violation during a mitigation
+ * episode.
+ */
+struct trip_stats {
+	ktime_t timestamp;
+	ktime_t duration;
+	int count;
+	int max;
+	int min;
+	int avg;
+};
+
+/*
+ * The tz_events structure describes a mitigation episode. A
+ * mitigation episode is when the mitigation begins and ends. During
+ * this episode we can have multiple trip points crossed the way up
+ * and down if there are multiple trip describes in the firmware.
+ */
+struct tz_events {
+	struct list_head list;
+	struct trip_stats *trip_stats;
+	ktime_t timestamp;
+	ktime_t duration;
+};
+
+/*
+ * The tz_debugfs structure contains the list of the mitigation
+ * episodes and has to track which trip point has been crossed in
+ * order to handle correctly nested trip point mitigation episodes.
+ */
+struct tz_debugfs {
+	struct list_head tz_events;
+	int *trips_crossed;
+	int trip_index;
+};
+
+/*
+ * The thermal_debugfs structure is the common structure used by the
+ * cooling device to compute the statistics and the thermal to measure
+ * the temperature at mitigation time.
+ */
+struct thermal_debugfs {
+	struct dentry *d_top;
+	struct mutex lock;
+	union {
+		struct cdev_debugfs cdev;
+		struct tz_debugfs tz;
+	};
+};
+
+void thermal_debugfs_init(void)
+{
+	d_root = debugfs_create_dir("thermal", NULL);
+	if (!d_root)
+		return;
+
+	d_cdev = debugfs_create_dir("cooling_devices", d_root);
+	if (!d_cdev)
+		return;
+
+	d_tz = debugfs_create_dir("thermal_zones", d_root);
+}
+
+static struct thermal_debugfs *thermal_debugfs_add_id(struct dentry *d, int id)
+{
+	struct thermal_debugfs *dfs;
+	char ids[IDSLENGTH];
+
+	dfs = kzalloc(sizeof(*dfs), GFP_KERNEL);
+	if (!dfs)
+		return NULL;
+
+	mutex_init(&dfs->lock);
+	
+	snprintf(ids, IDSLENGTH, "%d", id);
+
+	dfs->d_top = debugfs_create_dir(ids, d);
+	if (!dfs->d_top) {
+		kfree(dfs);
+		return NULL;
+	}
+
+	return dfs;
+}
+
+static void thermal_debugfs_remove_id(struct thermal_debugfs *dfs)
+{
+	if (!dfs)
+		return;
+
+	debugfs_remove(dfs->d_top);
+
+	kfree(dfs);
+}
+
+static struct cdev_value *thermal_debugfs_cdev_value_alloc(int id)
+{
+	struct cdev_value *cdev_value;
+
+	cdev_value = kzalloc(sizeof(*cdev_value), GFP_KERNEL);
+	if (cdev_value) {
+		cdev_value->id = id;
+		INIT_LIST_HEAD(&cdev_value->list);
+	}
+
+	return cdev_value;
+}
+
+static struct cdev_value *thermal_debugfs_cdev_value_find(struct thermal_debugfs *dfs,
+							  struct list_head *list, int id)
+{
+	struct cdev_value *pos;
+
+	list_for_each_entry(pos, &list[id % CDEVSTATS_HASH_SIZE], list)
+		if (pos->id == id)
+			return pos;
+
+	return NULL;
+}
+
+static void thermal_debugfs_cdev_value_insert(struct thermal_debugfs *dfs,
+					      struct list_head *list,
+					      struct cdev_value *cdev_value)
+{
+	list_add_tail(&cdev_value->list, &list[cdev_value->id % CDEVSTATS_HASH_SIZE]);
+}
+
+struct cdev_value *thermal_debugfs_cdev_value_get(struct thermal_debugfs *dfs,
+						  struct list_head *list, int id)
+{
+	struct cdev_value *cdev_value;
+
+	cdev_value = thermal_debugfs_cdev_value_find(dfs, list, id);
+	if (cdev_value)
+		return cdev_value;
+
+	cdev_value = thermal_debugfs_cdev_value_alloc(id);
+	if (cdev_value)
+		thermal_debugfs_cdev_value_insert(dfs, list, cdev_value);
+
+	return cdev_value;
+}
+
+static void thermal_debugfs_cdev_reset(struct cdev_debugfs *cfs)
+{
+	int i;
+	struct cdev_value *pos, *tmp;
+
+	for (i = 0; i < CDEVSTATS_HASH_SIZE; i++) {
+
+		list_for_each_entry_safe(pos, tmp, &cfs->trans_list[i], list) {
+			list_del(&pos->list);
+			kfree(pos);
+		}
+
+		list_for_each_entry_safe(pos, tmp, &cfs->duration_list[i], list) {
+			list_del(&pos->list);
+			kfree(pos);
+		}
+	}
+
+	cfs->total = 0;
+}
+
+void thermal_debugfs_cdev_transition(struct thermal_cooling_device *cdev, int to)
+{
+	struct thermal_debugfs *dfs = cdev->debugfs;
+	struct cdev_debugfs *cfs;
+	struct cdev_value *cdev_value;
+	ktime_t now = ktime_get();
+	int transition, from;
+
+	if (!dfs || (dfs->cdev.current_state == to))
+		return;
+
+	mutex_lock(&dfs->lock);
+
+	cfs = &dfs->cdev;
+
+	from = cfs->current_state;
+	cfs->current_state = to;
+	transition = (from << 16) | to;
+
+	cdev_value = thermal_debugfs_cdev_value_get(dfs, cfs->duration_list, from);
+	if (cdev_value) {
+		cdev_value->value += ktime_ms_delta(now, cfs->timestamp);
+		cfs->timestamp = now;
+	}
+
+	cdev_value = thermal_debugfs_cdev_value_get(dfs, cfs->trans_list, transition);
+	if (cdev_value)
+		cdev_value->value++;
+
+	cfs->total++;
+
+	mutex_unlock(&dfs->lock);
+}
+
+static void *cdev_seq_start(struct seq_file *s, loff_t *pos)
+{
+	struct thermal_debugfs *dfs = s->private;
+
+	mutex_lock(&dfs->lock);
+
+	return (*pos < CDEVSTATS_HASH_SIZE) ? pos : NULL;
+}
+
+static void *cdev_seq_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	(*pos)++;
+
+	return (*pos < CDEVSTATS_HASH_SIZE) ? pos : NULL;
+}
+
+static void cdev_seq_stop(struct seq_file *s, void *v)
+{
+	struct thermal_debugfs *dfs = s->private;
+
+	mutex_unlock(&dfs->lock);
+}
+
+static int cdev_tt_seq_show(struct seq_file *s, void *v)
+{
+	struct thermal_debugfs *dfs = s->private;	
+	struct cdev_debugfs *cfs = &dfs->cdev;
+	struct list_head *trans_list = cfs->trans_list;
+	struct cdev_value *pos;
+	char buffer[11];
+	int i = *(loff_t *)v;
+
+	if (!i)
+		seq_puts(s, "Transition\tHits\n");
+
+	list_for_each_entry(pos, &trans_list[i], list) {
+
+		snprintf(buffer, ARRAY_SIZE(buffer), "%d->%d",
+			 pos->id >> 16, pos->id & 0xFFFF);
+
+		seq_printf(s, "%-10s\t%-10llu\n", buffer, pos->value);
+	}
+
+	return 0;
+}
+
+static const struct seq_operations tt_sops = {
+	.start = cdev_seq_start,
+	.next = cdev_seq_next,
+	.stop = cdev_seq_stop,
+	.show = cdev_tt_seq_show,
+};
+
+DEFINE_SEQ_ATTRIBUTE(tt);
+
+static int cdev_dt_seq_show(struct seq_file *s, void *v)
+{
+	struct cdev_debugfs *cfs = s->private;
+	struct list_head *duration_list = cfs->duration_list;
+	struct cdev_value *pos;
+	int i = *(loff_t *)v;
+
+	if (!i)
+		seq_puts(s, "State\tTime\n");
+
+	list_for_each_entry(pos, &duration_list[i], list) {
+		s64 duration = pos->value;
+
+		if (pos->id == cfs->current_state)
+			duration += ktime_ms_delta(ktime_get(), cfs->timestamp);
+
+		seq_printf(s, "%-5d\t%-10llu\n", pos->id, duration);
+	}
+
+	return 0;
+}
+
+static const struct seq_operations dt_sops = {
+	.start = cdev_seq_start,
+	.next = cdev_seq_next,
+	.stop = cdev_seq_stop,
+	.show = cdev_dt_seq_show,
+};
+
+DEFINE_SEQ_ATTRIBUTE(dt);
+
+static int cdev_reset_set(void *data, u64 val)
+{
+	struct thermal_debugfs *dfs = data;
+
+	if (!val)
+		return -EINVAL;
+
+	thermal_debugfs_cdev_reset(&dfs->cdev);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(cdev_reset_fops, NULL, cdev_reset_set, "%llu\n");
+
+void thermal_debugfs_cdev_register(struct thermal_cooling_device *cdev)
+{
+	struct thermal_debugfs *dfs;
+	struct cdev_debugfs *cfs;
+	int i;
+
+	dfs = thermal_debugfs_add_id(d_cdev, cdev->id);
+	if (!dfs)
+		return;
+
+	cfs = &dfs->cdev;
+
+	for (i = 0; i < CDEVSTATS_HASH_SIZE; i++) {
+		INIT_LIST_HEAD(&cfs->trans_list[i]);
+		INIT_LIST_HEAD(&cfs->duration_list[i]);
+	}
+
+	cfs->current_state = 0;
+	cfs->timestamp = ktime_get();
+
+	debugfs_create_file("trans_table", 0400, dfs->d_top, dfs, &tt_fops);
+
+	debugfs_create_file("time_in_state_ms", 0400, dfs->d_top, dfs, &dt_fops);
+
+	debugfs_create_file("reset", 0200, dfs->d_top, dfs, &cdev_reset_fops);
+
+	debugfs_create_u32("total_trans", 0400, dfs->d_top, &cfs->total);
+
+	cdev->debugfs = dfs;
+}
+
+void thermal_debugfs_cdev_unregister(struct thermal_cooling_device *cdev)
+{
+	struct thermal_debugfs *dfs = cdev->debugfs;
+
+	if (!dfs)
+		return;
+
+	debugfs_remove(dfs->d_top);
+	thermal_debugfs_cdev_reset(&dfs->cdev);
+	cdev->debugfs = NULL;
+	kfree(dfs);
+}
+
+static struct tz_events *thermal_debugfs_tz_event_alloc(struct thermal_zone_device *tz,
+							ktime_t now)
+{
+	struct tz_events *tze;
+	struct trip_stats *trip_stats;
+	int i;
+
+	tze = kzalloc(sizeof(*tze), GFP_KERNEL);
+	if (!tze)
+		return NULL;
+
+	INIT_LIST_HEAD(&tze->list);
+	tze->timestamp = now;
+
+	trip_stats = kzalloc(sizeof(struct trip_stats) * tz->num_trips, GFP_KERNEL);
+	if (!trip_stats) {
+		kfree(tze);
+		return NULL;
+	}
+
+	for (i = 0; i < tz->num_trips; i++) {
+		trip_stats[i].min = INT_MAX;
+		trip_stats[i].max = INT_MIN;
+	}
+	
+	tze->trip_stats = trip_stats;
+
+	return tze;
+}
+
+void thermal_debugfs_handle_way_up(struct thermal_zone_device *tz,
+				   int trip, int temperature)
+{
+	struct thermal_debugfs *dfs = tz->debugfs;
+	struct tz_events *tze;
+	ktime_t now = ktime_get();
+
+	if (!dfs)
+		return;
+
+	mutex_lock(&dfs->lock);
+
+	/*
+	 * The mitigation is starting. A mitigation can contain
+	 * several episodes where each of them is related to a
+	 * temperature crossing a trip point. The episodes are
+	 * nested. That means when the temperature is crossing the
+	 * first trip point, the duration begins to be measured. If
+	 * the temperature continues to increase and reaches the
+	 * second trip point, the duration of the first trip must be
+	 * also accumulated.
+	 *
+	 * eg.
+	 *
+	 * temp
+	 *   ^
+	 *   |             --------
+	 * trip 2         /        \         ------
+	 *   |           /|        |\      /|      |\
+	 * trip 1       / |        | `----  |      | \
+	 *   |         /| |        |        |      | |\
+	 * trip 0     / | |        |        |      | | \
+	 *   |       /| | |        |        |      | | |\
+	 *   |      / | | |        |        |      | | | `--
+	 *   |     /  | | |        |        |      | | |     
+	 *   |-----   | | |        |        |      | | |      
+	 *   |        | | |        |        |      | | |
+	 *    --------|-|-|--------|--------|------|-|-|------------------> time
+	 *            | | |<--t2-->|        |<-t2'>| | |
+	 *            | |                            | |
+	 *            | |<------------t1------------>| |
+	 *            |                                |
+	 *            |<-------------t0--------------->|
+	 *
+	 */
+	if (dfs->tz.trip_index < 0) {
+		tze = thermal_debugfs_tz_event_alloc(tz, now);
+		if (!tze)
+			return;
+
+		list_add(&tze->list, &dfs->tz.tz_events);
+	}
+
+	dfs->tz.trip_index++;
+	dfs->tz.trips_crossed[dfs->tz.trip_index] = trip;
+
+	tze = list_first_entry(&dfs->tz.tz_events, struct tz_events, list);
+	tze->trip_stats[trip].timestamp = now;
+        tze->trip_stats[trip].max = max(tze->trip_stats[trip].max, temperature);
+	tze->trip_stats[trip].min = min(tze->trip_stats[trip].min, temperature);
+	tze->trip_stats[trip].avg = tze->trip_stats[trip].avg +
+		(temperature - tze->trip_stats[trip].avg) / tze->trip_stats[trip].count;
+
+	mutex_unlock(&dfs->lock);
+}
+
+void thermal_debugfs_handle_way_down(struct thermal_zone_device *tz,
+				     int trip, int temperature)
+{
+	struct thermal_debugfs *dfs = tz->debugfs;
+	struct tz_events *tze;
+	ktime_t delta, now = ktime_get();
+
+	if (!dfs)
+		return;
+
+	/*
+	 * The temperature crosses the way down but there was not
+	 * mitigation detected before. That may happen when the
+	 * temperature is greater than a trip point when registering a
+	 * thermal zone, which is a common use case as the kernel has
+	 * no mitigation mechanism yet at boot time.
+	 */
+	if (dfs->tz.trip_index < 0)
+		return;
+	
+	mutex_lock(&dfs->lock);
+	
+	tze = list_first_entry(&dfs->tz.tz_events, struct tz_events, list);
+
+	delta = ktime_sub(now, tze->trip_stats[trip].timestamp);
+	tze->trip_stats[trip].duration = ktime_add(delta, tze->trip_stats[trip].duration);
+
+	dfs->tz.trip_index--;
+
+	/*
+	 * This event closes the mitigation as we are crossing the
+	 * last trip point the way down.
+	 */
+	if (dfs->tz.trip_index < 0)
+		tze->duration = ktime_sub(now, tze->timestamp);
+
+	mutex_unlock(&dfs->lock);
+}
+
+void thermal_debugfs_update_temp(struct thermal_zone_device *tz)
+{
+	struct thermal_debugfs *dfs = tz->debugfs;
+	struct tz_events *tze;
+	int trip;
+
+	if (!dfs)
+		return;
+
+	mutex_lock(&dfs->lock);
+
+	if (dfs->tz.trip_index >= 0) {
+		trip = dfs->tz.trip_index;
+		tze = list_first_entry(&dfs->tz.tz_events, struct tz_events, list);
+		tze->trip_stats[trip].count++;
+		tze->trip_stats[trip].max = max(tze->trip_stats[trip].max, tz->temperature);
+		tze->trip_stats[trip].min = min(tze->trip_stats[trip].min, tz->temperature);
+		tze->trip_stats[trip].avg = tze->trip_stats[trip].avg +
+			(tz->temperature - tze->trip_stats[trip].avg) / tze->trip_stats[trip].count;
+	}
+
+	mutex_unlock(&dfs->lock);
+}
+
+static void *tze_seq_start(struct seq_file *s, loff_t *pos)
+{
+	struct thermal_zone_device *tz = s->private;
+	struct thermal_debugfs *dfs = tz->debugfs;
+	struct tz_debugfs *tzd = &dfs->tz;
+
+	mutex_lock(&dfs->lock);
+
+	return seq_list_start(&tzd->tz_events, *pos);
+}
+
+static void *tze_seq_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	struct thermal_zone_device *tz = s->private;
+	struct thermal_debugfs *dfs = tz->debugfs;
+        struct tz_debugfs *tzd = &dfs->tz;
+
+	return seq_list_next(v, &tzd->tz_events, pos);
+}
+
+static void tze_seq_stop(struct seq_file *s, void *v)
+{
+	struct thermal_zone_device *tz = s->private;
+	struct thermal_debugfs *dfs = tz->debugfs;
+
+	mutex_unlock(&dfs->lock);
+}
+
+static int tze_seq_show(struct seq_file *s, void *v)
+{
+	struct thermal_zone_device *tz = s->private;
+	struct tz_events *tze;
+	int i;
+
+	tze = list_entry((struct list_head *)v, struct tz_events, list);
+
+	seq_printf(s, ",-Mitigation at %lluus, duration=%llums\n", ktime_to_us(tze->timestamp),
+		   ktime_to_ms(tze->duration));
+
+	seq_printf(s, "| trip |     type | temp(°mC) | hyst(°mC) |  duration  |  avg(°mC) |  min(°mC) |  max(°mC) |\n");
+	
+	for (i = 0; i < tz->num_trips; i++) {
+
+		struct thermal_trip trip;
+		const char *type;
+		
+		if (__thermal_zone_get_trip(tz, i, &trip))
+			continue;
+
+		/*
+		 * There is no possible mitigation happening at the
+		 * critical trip point, so the stats will be always
+		 * zero, skip this trip point
+		 */
+		if (trip.type == THERMAL_TRIP_CRITICAL)
+			continue;
+
+		if (trip.type == THERMAL_TRIP_PASSIVE)
+			type = "passive";
+		else if (trip.type == THERMAL_TRIP_ACTIVE)
+			type = "active";
+		else
+			type = "hot";
+
+		seq_printf(s, "| %*d | %*s | %*d | %*d | %*lld | %*d | %*d | %*d |\n",
+			   4 , i,
+			   8, type,
+			   9, trip.temperature,
+			   9, trip.hysteresis,
+			   10, ktime_to_ms(tze->trip_stats[i].duration),
+			   9, tze->trip_stats[i].avg,
+			   9, tze->trip_stats[i].min,
+			   9, tze->trip_stats[i].max);
+	}
+
+	return 0;
+}
+
+static const struct seq_operations tze_sops = {
+	.start = tze_seq_start,
+	.next = tze_seq_next,
+	.stop = tze_seq_stop,
+        .show = tze_seq_show,
+};
+
+DEFINE_SEQ_ATTRIBUTE(tze);
+
+void thermal_debugfs_tz_register(struct thermal_zone_device *tz)
+{
+	struct thermal_debugfs *dfs;
+	struct tz_debugfs *tzd;
+
+	dfs = thermal_debugfs_add_id(d_tz, tz->id);
+	if (!dfs)
+		return;
+
+	tzd = &dfs->tz;
+
+	tzd->trips_crossed = kzalloc(sizeof(int) * tz->num_trips, GFP_KERNEL);
+	if (!tzd->trips_crossed) {
+		thermal_debugfs_remove_id(dfs);
+		return;
+	}
+
+	/*
+	 * Trip index '-1' means no mitigation
+	 */
+	tzd->trip_index = -1;
+	INIT_LIST_HEAD(&tzd->tz_events);
+
+	debugfs_create_file("mitigations", 0400, dfs->d_top, tz, &tze_fops);
+	
+	tz->debugfs = dfs;
+}
+
+void thermal_debugfs_tz_unregister(struct thermal_zone_device *tz)
+{
+	thermal_debugfs_remove_id(tz->debugfs);
+	tz->debugfs = NULL;
+}
diff --git a/drivers/thermal/thermal_debugfs.h b/drivers/thermal/thermal_debugfs.h
new file mode 100644
index 000000000000..9962910a54ba
--- /dev/null
+++ b/drivers/thermal/thermal_debugfs.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CONFIG_THERMAL_DEBUGFS
+void thermal_debugfs_init(void);
+void thermal_debugfs_cdev_register(struct thermal_cooling_device *cdev);
+void thermal_debugfs_cdev_unregister(struct thermal_cooling_device *cdev);
+void thermal_debugfs_tz_register(struct thermal_zone_device *tz);
+void thermal_debugfs_tz_unregister(struct thermal_zone_device *tz);
+void thermal_debugfs_cdev_transition(struct thermal_cooling_device *cdev, int state);
+void thermal_debugfs_handle_way_up(struct thermal_zone_device *tz, int trip_id, int temp);
+void thermal_debugfs_handle_way_down(struct thermal_zone_device *tz, int trip_id, int temp);
+void thermal_debugfs_update_temp(struct thermal_zone_device *tz);
+#else
+static inline void thermal_debugfs_init(void) {}
+static inline void thermal_debugfs_cdev_register(struct thermal_cooling_device *) {}
+static inline void thermal_debugfs_cdev_unregister(struct thermal_cooling_device *) {}
+static inline void thermal_debugfs_tz_register(struct thermal_zone_device *) {}
+static inline void thermal_debugfs_tz_unregister(struct thermal_zone_device *) {}
+static inline void thermal_debugfs_cdev_transition(struct thermal_cooling_device *, int) {}
+static inline void thermal_debugfs_handle_way_up(struct thermal_zone_device *, int, int) {};
+static inline void thermal_debugfs_handle_way_down(struct thermal_zone_device *, int, int) {}
+static inline void thermal_debugfs_update_temp(struct thermal_zone_device *) {}
+#endif /* CONFIG_THERMAL_DEBUGFS */
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 69e8ea4aa908..a336486d0c40 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -151,14 +151,29 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
 
-static void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev,
-				       int target)
+void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms)
 {
-	if (cdev->ops->set_cur_state(cdev, target))
-		return;
+	*delay_jiffies = msecs_to_jiffies(delay_ms);
+	if (delay_ms > 1000)
+		*delay_jiffies = round_jiffies(*delay_jiffies);
+}
+
+static int thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev, int state)
+{
+	int ret;
 
-	thermal_notify_cdev_state_update(cdev->id, target);
-	thermal_cooling_device_stats_update(cdev, target);
+	/*
+	 * No check is needed for the ops->set_cur_state as the
+	 * registering function checked the ops are correctly set
+	 */
+	ret = cdev->ops->set_cur_state(cdev, state);
+	if (!ret) {
+		thermal_notify_cdev_state_update(cdev->id, state);
+		thermal_cooling_device_stats_update(cdev, state);
+		thermal_debugfs_cdev_transition(cdev, state);
+	}
+
+	return ret;
 }
 
 void __thermal_cdev_update(struct thermal_cooling_device *cdev)
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 1f9ee869f9f9..f1937f8741e1 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -32,6 +32,7 @@
 struct thermal_zone_device;
 struct thermal_cooling_device;
 struct thermal_instance;
+struct thermal_debugfs;
 struct thermal_attr;
 
 enum thermal_trend {
@@ -110,6 +111,9 @@ struct thermal_cooling_device {
 	struct mutex lock; /* protect thermal_instances list */
 	struct list_head thermal_instances;
 	struct list_head node;
+#ifdef CONFIG_THERMAL_DEBUGFS
+	struct thermal_debugfs *debugfs;
+#endif
 };
 
 /**
@@ -183,6 +187,9 @@ struct thermal_zone_device {
 	struct list_head node;
 	struct delayed_work poll_queue;
 	enum thermal_notify_event notify_event;
+#ifdef CONFIG_THERMAL_DEBUGFS
+	struct thermal_debugfs *debugfs;
+#endif
 };
 
 /**
-- 
2.34.1

