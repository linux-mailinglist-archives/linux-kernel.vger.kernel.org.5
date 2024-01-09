Return-Path: <linux-kernel+bounces-20773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C369828504
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FDC91C20BD4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1EA37145;
	Tue,  9 Jan 2024 11:27:58 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3732125A7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 409BRfDM002970;
	Tue, 9 Jan 2024 19:27:41 +0800 (+08)
	(envelope-from Di.Shen@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4T8T4v4h3Jz2RS3WG;
	Tue,  9 Jan 2024 19:20:47 +0800 (CST)
Received: from bj10906pcu1.spreadtrum.com (10.0.73.72) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 9 Jan 2024 19:27:40 +0800
From: Di Shen <di.shen@unisoc.com>
To: <lukasz.luba@arm.com>, <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wvw@google.com>, <tkjos@google.com>, <xuewen.yan@unisoc.com>,
        <zhanglyra@gmail.com>, <orsonzhai@gmail.com>
Subject: [PATCH V6] thermal/core/power_allocator: avoid thermal cdev can not be reset
Date: Tue, 9 Jan 2024 19:27:36 +0800
Message-ID: <20240109112736.32566-1-di.shen@unisoc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 409BRfDM002970

Commit 0952177f2a1f ("thermal/core/power_allocator: Update once
cooling devices when temp is low") adds an update flag to avoid
the thermal event is triggered when there is no need, and
thermal cdev would be updated once when temperature is low.

But when the trips are writable, and switch_on_temp is set
to be a higher value, the cooling device state may not be
reset to 0, because last_temperature is smaller than the
switch_on_temp.

For example:
First:
switch_on_temp=70 control_temp=85;
Then userspace change the trip_temp:
switch_on_temp=45 control_temp=55 cur_temp=54

Then userspace reset the trip_temp:
switch_on_temp=70 control_temp=85 cur_temp=57 last_temp=54

At this time, the cooling device state should be reset to 0.
However, because cur_temp(57) < switch_on_temp(70)
last_temp(54) < switch_on_temp(70)  ---->  update = false,
update is false, the cooling device state can not be reset.

Considering tz->passive can also be represented the temperature
status, this patch modifies the update flag with tz->passive.

When the first time the temperature drops below switch_on, the
states of cooling devices can be reset once(because tz->passive = 1),
and the tz->passive is updated to 0. In the next round, because
tz->passive is 0, the cdev->state would not be updated.

By using the tz->passive as the "update" flag, the issue above
can be solved, and the cooling devices can be update only once
when the temperature is low.

Fixes: <0952177f2a1f> (thermal/core/power_allocator: Update once cooling devices when temp is low)
Signed-off-by: Di Shen <di.shen@unisoc.com>

---
V6:
Compared to the previous version:
- Not change the thermal core.
- Not add new variables and function.
- Use tz->passive as "update" flag to indicates whether the cooling
  device should be reset.

V5: [5]
- Simplify the reset ops, make it no return value and no specific
  trip ID as argument.
- Extend the commit message.

V4: [4]
- Compared to V3, handle it in thermal core instead of in governor.
- Add an ops to the governor structure, and call it when a trip
  point is changed.
- Define reset ops for power allocator.

V3: [3]
- Add fix tag.

V2: [2]
- Compared to v1, do not revert.
- Add a variable(last_switch_on_temp) in power_allocator_params
  to record the last switch_on_temp value.
- Adds a function to renew the update flag and update the
  last_switch_on_temp when thermal trips are writable.

V1: [1]
- Revert commit 0952177f2a1f.

[1] https://lore.kernel.org/all/20230309135515.1232-1-di.shen@unisoc.com/
[2] https://lore.kernel.org/all/20230315093008.17489-1-di.shen@unisoc.com/
[3] https://lore.kernel.org/all/20230320095620.7480-1-di.shen@unisoc.com/
[4] https://lore.kernel.org/all/20230619063534.12831-1-di.shen@unisoc.com/
[5] https://lore.kernel.org/all/20230710033234.28641-1-di.shen@unisoc.com/
---
---
 drivers/thermal/gov_power_allocator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 83d4f451b1a9..931cd88425e4 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -693,7 +693,7 @@ static int power_allocator_throttle(struct thermal_zone_device *tz,
 
 	trip = params->trip_switch_on;
 	if (trip && tz->temperature < trip->temperature) {
-		update = tz->last_temperature >= trip->temperature;
+		update = tz->passive;
 		tz->passive = 0;
 		reset_pid_controller(params);
 		allow_maximum_power(tz, update);
-- 
2.17.1


