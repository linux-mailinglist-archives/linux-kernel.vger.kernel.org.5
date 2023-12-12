Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECC980F1F2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjLLQK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346622AbjLLQKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:10:53 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC237B4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:10:58 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so5446490f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702397457; x=1703002257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHBmMX6EENZuFeYC7EiMpQlpzg5n+8qBXG1EZtCuSuE=;
        b=FfLfva99Lb9V3VOm0RDBLrRdtBLNqKJB1TKKx4xeturs/nS3Yyx/oAyV14kIRd1c35
         bEiGEjW06OXOQAVCb+DKIk4Qfhak2YdYxLBQqTks6oeXk+rJkqmUjzZjmX69oLmKrO1d
         jEP4rNQ8ZUpOx0AKlzW2XpntGanjSByWV3w4mcZthKr8pVTqUoXvqzHu6i2jj620FVHv
         9tt5uAduG2Rd7G2sh6S/OW7agWcmi475AM/U4f61VfS4mFREV525bvsgz2gmN118fFvx
         rrLfNOmx6YH4+FT8ATab1BN0ZA3VlGYS9amPphIVfBwwE0xwpfG0zfBPvOJ/nN1KH0GK
         crhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397457; x=1703002257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHBmMX6EENZuFeYC7EiMpQlpzg5n+8qBXG1EZtCuSuE=;
        b=rpazot6W041hT7f8WaHWD9/HbTAJTfjGMMSdOtblSZ6fsFUgQZ1mXts1Qfe6Np72hk
         EV9ZHrB+YuUw4W9VPYiOFuZ6TFIgr2zbYQrFNXhZiWoFgtn03rXpE0T6c2Tzz+rcpbaI
         +DFbuFfW4uFaDxen2P5+YVaxbDz5BswDulHhFz33xw7asWyMh6essZHLABBtuXFF8pY/
         YAKY2E4haqiNOWAw40iaqOYov/Dpzhkb8eyG0ZJEqOLssskco1QC6nHIKN69Yx0EJmQA
         qwnP4EG+gKjWOAo3JLpQtjHcLD0i7DjUELCO2MzkR2ytLdtGM/dNihMvljoU1lL5gfop
         mSgQ==
X-Gm-Message-State: AOJu0YyjXj3XG2Yxyz4e4yYNHiF+FQc8gbzZOHqSkLfgf9eZKvKDlDIh
        10d6jm4xi981/wqaXuOSgsABMQ==
X-Google-Smtp-Source: AGHT+IFJARiT02VkNm6E08rjzQgZGnxDqQW/SL1VrF+sWBNouiBWYBhYJS+vPSGOopryYMGc3L0ooQ==
X-Received: by 2002:a5d:6208:0:b0:333:2fd2:6f54 with SMTP id y8-20020a5d6208000000b003332fd26f54mr2920776wru.94.1702397457118;
        Tue, 12 Dec 2023 08:10:57 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.gmail.com with ESMTPSA id q9-20020a05600000c900b0033330846e76sm11168789wrx.86.2023.12.12.08.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 08:10:56 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net, lukasz.luba@arm.com
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 2/2] thermal/debugfs: Add thermal debugfs information for mitigation episodes
Date:   Tue, 12 Dec 2023 17:10:47 +0100
Message-Id: <20231212161047.1631077-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212161047.1631077-1-daniel.lezcano@linaro.org>
References: <20231212161047.1631077-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mitigation episodes are recorded. A mitigation episode happens
when the first trip point is crossed the way up and then the way
down. During this episode other trip points can be crossed also and
are accounted for this mitigation episode. The interesting information
is the average temperature at the trip point, the undershot and the
overshot. The standard deviation of the mitigated temperature will be
added later.

The thermal debugfs directory structure tries to stay consistent with
the sysfs one but in a very simplified way:

thermal/
 `-- thermal_zones
     |-- 0
     |   `-- mitigations
     `-- 1
         `-- mitigations

The content of the mitigations file has the following format:

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
Changelog:
  - v1 (from RFC):
    - Replaced exported function name s/debugfs/debug/
    - Used "struct thermal_trip" parameter instead of "trip_id"
    - Renamed handle_way_[up|down] by tz_trip_[up|down]
    - Replaced thermal_debug_tz_[unregister|register] by [add|remove]
---
 drivers/thermal/thermal_core.c    |   7 +
 drivers/thermal/thermal_debugfs.c | 330 +++++++++++++++++++++++++++++-
 drivers/thermal/thermal_debugfs.h |  10 +
 3 files changed, 346 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 33332d401b13..a0cbe8d7b945 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -367,6 +367,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
 			thermal_notify_tz_trip_up(tz->id,
 						  thermal_zone_trip_id(tz, trip),
 						  tz->temperature);
+			thermal_debug_tz_trip_up(tz, trip);
 			trip->threshold = trip->temperature - trip->hysteresis;
 		} else {
 			trip->threshold = trip->temperature;
@@ -386,6 +387,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
 			thermal_notify_tz_trip_down(tz->id,
 						    thermal_zone_trip_id(tz, trip),
 						    tz->temperature);
+			thermal_debug_tz_trip_down(tz, trip);
 			trip->threshold = trip->temperature;
 		} else {
 			trip->threshold = trip->temperature - trip->hysteresis;
@@ -417,6 +419,7 @@ static void update_temperature(struct thermal_zone_device *tz)
 	trace_thermal_temperature(tz);
 
 	thermal_genl_sampling_temp(tz->id, temp);
+	thermal_debug_update_temp(tz);
 }
 
 static void thermal_zone_device_init(struct thermal_zone_device *tz)
@@ -1396,6 +1399,8 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 
 	thermal_notify_tz_create(tz->id, tz->type);
 
+	thermal_debug_tz_add(tz);
+
 	return tz;
 
 unregister:
@@ -1461,6 +1466,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	if (!tz)
 		return;
 
+	thermal_debug_tz_remove(tz);
+
 	tz_id = tz->id;
 
 	mutex_lock(&thermal_list_lock);
diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_debugfs.c
index 295f7a2a7d0d..372664d0e1ae 100644
--- a/drivers/thermal/thermal_debugfs.c
+++ b/drivers/thermal/thermal_debugfs.c
@@ -13,8 +13,11 @@
 #include <linux/mutex.h>
 #include <linux/thermal.h>
 
+#include "thermal_core.h"
+
 static struct dentry *d_root;
 static struct dentry *d_cdev;
+static struct dentry *d_tz;
 
 /*
  * Length of the string containing the thermal zone id, including the
@@ -53,6 +56,44 @@ struct cdev_debugfs {
 	struct list_head duration_list[CDEVSTATS_HASH_SIZE];
 };
 
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
 /*
  * The thermal_debugfs structure is the common structure used by the
  * cooling device to compute the statistics and the thermal to measure
@@ -63,6 +104,7 @@ struct thermal_debugfs {
 	struct mutex lock;
 	union {
 		struct cdev_debugfs cdev;
+		struct tz_debugfs tz;
 	};
 };
 
@@ -73,6 +115,10 @@ void thermal_debug_init(void)
 		return;
 
 	d_cdev = debugfs_create_dir("cooling_devices", d_root);
+	if (!d_cdev)
+		return;
+
+	d_tz = debugfs_create_dir("thermal_zones", d_root);
 }
 
 static struct thermal_debugfs *thermal_debugfs_add_id(struct dentry *d, int id)
@@ -348,7 +394,289 @@ void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev)
 	if (!dfs)
 		return;
 
+	debugfs_remove(dfs->d_top);
 	thermal_debugfs_cdev_reset(&dfs->cdev);
 	cdev->debugfs = NULL;
-	thermal_debugfs_remove_id(dfs);
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
+void thermal_debug_tz_trip_up(struct thermal_zone_device *tz, struct thermal_trip *trip)
+{
+	struct tz_events *tze;
+	struct thermal_debugfs *dfs = tz->debugfs;
+	int temperature = tz->temperature;
+	int trip_id = thermal_zone_trip_id(tz, trip);
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
+	dfs->tz.trips_crossed[dfs->tz.trip_index] = trip_id;
+
+	tze = list_first_entry(&dfs->tz.tz_events, struct tz_events, list);
+	tze->trip_stats[trip_id].timestamp = now;
+        tze->trip_stats[trip_id].max = max(tze->trip_stats[trip_id].max, temperature);
+	tze->trip_stats[trip_id].min = min(tze->trip_stats[trip_id].min, temperature);
+	tze->trip_stats[trip_id].avg = tze->trip_stats[trip_id].avg +
+		(temperature - tze->trip_stats[trip_id].avg) / tze->trip_stats[trip_id].count;
+
+	mutex_unlock(&dfs->lock);
+}
+
+void thermal_debug_tz_trip_down(struct thermal_zone_device *tz, struct thermal_trip *trip)
+{
+	struct thermal_debugfs *dfs = tz->debugfs;
+	struct tz_events *tze;
+	int trip_id = thermal_zone_trip_id(tz, trip);
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
+	delta = ktime_sub(now, tze->trip_stats[trip_id].timestamp);
+	tze->trip_stats[trip_id].duration = ktime_add(delta, tze->trip_stats[trip_id].duration);
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
+void thermal_debug_update_temp(struct thermal_zone_device *tz)
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
+	.show = tze_seq_show,
+};
+
+DEFINE_SEQ_ATTRIBUTE(tze);
+
+void thermal_debug_tz_add(struct thermal_zone_device *tz)
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
+void thermal_debug_tz_remove(struct thermal_zone_device *tz)
+{
+	thermal_debugfs_remove_id(tz->debugfs);
+	tz->debugfs = NULL;
 }
diff --git a/drivers/thermal/thermal_debugfs.h b/drivers/thermal/thermal_debugfs.h
index 674eec369328..b8b45bf509dd 100644
--- a/drivers/thermal/thermal_debugfs.h
+++ b/drivers/thermal/thermal_debugfs.h
@@ -5,9 +5,19 @@ void thermal_debug_init(void);
 void thermal_debug_cdev_add(struct thermal_cooling_device *cdev);
 void thermal_debug_cdev_remove(struct thermal_cooling_device *cdev);
 void thermal_debug_cdev_transition(struct thermal_cooling_device *cdev, int state);
+void thermal_debug_tz_add(struct thermal_zone_device *tz);
+void thermal_debug_tz_remove(struct thermal_zone_device *tz);
+void thermal_debug_tz_trip_up(struct thermal_zone_device *tz, struct thermal_trip *trip);
+void thermal_debug_tz_trip_down(struct thermal_zone_device *tz, struct thermal_trip *trip);
+void thermal_debug_update_temp(struct thermal_zone_device *tz);
 #else
 static inline void thermal_debug_init(void) {}
 static inline void thermal_debug_cdev_add(struct thermal_cooling_device *) {}
 static inline void thermal_debug_cdev_remove(struct thermal_cooling_device *) {}
 static inline void thermal_debug_cdev_transition(struct thermal_cooling_device *, int) {}
+static inline void thermal_debug_tz_add(struct thermal_zone_device *) {}
+static inline void thermal_debug_tz_remove(struct thermal_zone_device *) {}
+static inline void thermal_debug_tz_trip_up(struct thermal_zone_device *, struct thermal_trip *trip) {};
+static inline void thermal_debug_tz_trip_down(struct thermal_zone_device *, struct thermal_trip *trip) {}
+static inline void thermal_debug_update_temp(struct thermal_zone_device *) {}
 #endif /* CONFIG_THERMAL_DEBUGFS */
-- 
2.34.1

