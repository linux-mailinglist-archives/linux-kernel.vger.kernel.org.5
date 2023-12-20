Return-Path: <linux-kernel+bounces-7626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603AD81AAF3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19086286692
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102164BABD;
	Wed, 20 Dec 2023 23:17:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185834BA98;
	Wed, 20 Dec 2023 23:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A399152B;
	Wed, 20 Dec 2023 15:17:44 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.82.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6AC803F64C;
	Wed, 20 Dec 2023 15:16:58 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Subject: [PATCH v3 4/9] thermal: gov_power_allocator: Change trace functions
Date: Wed, 20 Dec 2023 23:17:48 +0000
Message-Id: <20231220231753.1824364-5-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231220231753.1824364-1-lukasz.luba@arm.com>
References: <20231220231753.1824364-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change trace event trace_thermal_power_allocator() to not use dynamic
array for requested power and granted power for all power actors.
Instead, simplify the trace event and print other simple values.

Add new trace event to print power actor information of requested power
and granted power. That trace event would be called in a loop for each
power actor. The trace data would be easier to parse comparing to the
dynamic array implementation.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c |  5 +--
 drivers/thermal/thermal_trace_ipa.h   | 50 ++++++++++++++++-----------
 2 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 9e35ebd7cb03..53283fd8a944 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -469,11 +469,12 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 				      granted_power[i]);
 		total_granted_power += granted_power[i];
 
+		trace_thermal_power_actor(tz, i, req_power[i],
+					  granted_power[i]);
 		i++;
 	}
 
-	trace_thermal_power_allocator(tz, req_power, total_req_power,
-				      granted_power, total_granted_power,
+	trace_thermal_power_allocator(tz, total_req_power, total_granted_power,
 				      num_actors, power_range,
 				      max_allocatable_power, tz->temperature,
 				      control_temp - tz->temperature);
diff --git a/drivers/thermal/thermal_trace_ipa.h b/drivers/thermal/thermal_trace_ipa.h
index 84568db5421b..b16b5dd863d9 100644
--- a/drivers/thermal/thermal_trace_ipa.h
+++ b/drivers/thermal/thermal_trace_ipa.h
@@ -8,19 +8,14 @@
 #include <linux/tracepoint.h>
 
 TRACE_EVENT(thermal_power_allocator,
-	TP_PROTO(struct thermal_zone_device *tz, u32 *req_power,
-		 u32 total_req_power, u32 *granted_power,
-		 u32 total_granted_power, size_t num_actors,
-		 u32 power_range, u32 max_allocatable_power,
-		 int current_temp, s32 delta_temp),
-	TP_ARGS(tz, req_power, total_req_power, granted_power,
-		total_granted_power, num_actors, power_range,
-		max_allocatable_power, current_temp, delta_temp),
+	TP_PROTO(struct thermal_zone_device *tz, u32 total_req_power,
+		 u32 total_granted_power, int num_actors, u32 power_range,
+		 u32 max_allocatable_power, int current_temp, s32 delta_temp),
+	TP_ARGS(tz, total_req_power, total_granted_power, num_actors,
+		power_range, max_allocatable_power, current_temp, delta_temp),
 	TP_STRUCT__entry(
 		__field(int,           tz_id          )
-		__dynamic_array(u32,   req_power, num_actors    )
 		__field(u32,           total_req_power          )
-		__dynamic_array(u32,   granted_power, num_actors)
 		__field(u32,           total_granted_power      )
 		__field(size_t,        num_actors               )
 		__field(u32,           power_range              )
@@ -30,11 +25,7 @@ TRACE_EVENT(thermal_power_allocator,
 	),
 	TP_fast_assign(
 		__entry->tz_id = tz->id;
-		memcpy(__get_dynamic_array(req_power), req_power,
-			num_actors * sizeof(*req_power));
 		__entry->total_req_power = total_req_power;
-		memcpy(__get_dynamic_array(granted_power), granted_power,
-			num_actors * sizeof(*granted_power));
 		__entry->total_granted_power = total_granted_power;
 		__entry->num_actors = num_actors;
 		__entry->power_range = power_range;
@@ -43,18 +34,35 @@ TRACE_EVENT(thermal_power_allocator,
 		__entry->delta_temp = delta_temp;
 	),
 
-	TP_printk("thermal_zone_id=%d req_power={%s} total_req_power=%u granted_power={%s} total_granted_power=%u power_range=%u max_allocatable_power=%u current_temperature=%d delta_temperature=%d",
-		__entry->tz_id,
-		__print_array(__get_dynamic_array(req_power),
-                              __entry->num_actors, 4),
-		__entry->total_req_power,
-		__print_array(__get_dynamic_array(granted_power),
-                              __entry->num_actors, 4),
+	TP_printk("thermal_zone_id=%d total_req_power=%u total_granted_power=%u power_range=%u max_allocatable_power=%u current_temperature=%d delta_temperature=%d",
+		__entry->tz_id,	__entry->total_req_power,
 		__entry->total_granted_power, __entry->power_range,
 		__entry->max_allocatable_power, __entry->current_temp,
 		__entry->delta_temp)
 );
 
+TRACE_EVENT(thermal_power_actor,
+	TP_PROTO(struct thermal_zone_device *tz, int actor_id, u32 req_power,
+		 u32 granted_power),
+	TP_ARGS(tz, actor_id, req_power, granted_power),
+	TP_STRUCT__entry(
+		__field(int, tz_id)
+		__field(int, actor_id)
+		__field(u32, req_power)
+		__field(u32, granted_power)
+	),
+	TP_fast_assign(
+		__entry->tz_id = tz->id;
+		__entry->actor_id = actor_id;
+		__entry->req_power = req_power;
+		__entry->granted_power = granted_power;
+	),
+
+	TP_printk("thermal_zone_id=%d actor_id=%d req_power=%u granted_power=%u",
+		__entry->tz_id,	__entry->actor_id, __entry->req_power,
+		__entry->granted_power)
+);
+
 TRACE_EVENT(thermal_power_allocator_pid,
 	TP_PROTO(struct thermal_zone_device *tz, s32 err, s32 err_integral,
 		 s64 p, s64 i, s64 d, s32 output),
-- 
2.25.1


