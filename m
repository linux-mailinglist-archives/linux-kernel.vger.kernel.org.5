Return-Path: <linux-kernel+bounces-7625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA4B81AAF1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C891F2465D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E8C4C3A0;
	Wed, 20 Dec 2023 23:17:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AAD4B5BB;
	Wed, 20 Dec 2023 23:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 247892F4;
	Wed, 20 Dec 2023 15:17:43 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.82.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E90F13F64C;
	Wed, 20 Dec 2023 15:16:56 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Subject: [PATCH v3 3/9] thermal: gov_power_allocator: Refactor checks in divvy_up_power()
Date: Wed, 20 Dec 2023 23:17:47 +0000
Message-Id: <20231220231753.1824364-4-lukasz.luba@arm.com>
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

Simplify the code and remove one extra 'if' block.

No intentional functional impact.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index d9175d9f5e3f..9e35ebd7cb03 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -332,7 +332,8 @@ static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
 			   u32 total_req_power, u32 power_range,
 			   u32 *granted_power, u32 *extra_actor_power)
 {
-	u32 extra_power, capped_extra_power;
+	u32 capped_extra_power = 0;
+	u32 extra_power = 0;
 	int i;
 
 	/*
@@ -341,8 +342,6 @@ static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
 	if (!total_req_power)
 		total_req_power = 1;
 
-	capped_extra_power = 0;
-	extra_power = 0;
 	for (i = 0; i < num_actors; i++) {
 		u64 req_range = (u64)req_power[i] * power_range;
 
@@ -358,7 +357,7 @@ static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
 		capped_extra_power += extra_actor_power[i];
 	}
 
-	if (!extra_power)
+	if (!extra_power || !capped_extra_power)
 		return;
 
 	/*
@@ -366,12 +365,13 @@ static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
 	 * how far they are from the max
 	 */
 	extra_power = min(extra_power, capped_extra_power);
-	if (capped_extra_power > 0)
-		for (i = 0; i < num_actors; i++) {
-			u64 extra_range = (u64)extra_actor_power[i] * extra_power;
-			granted_power[i] += DIV_ROUND_CLOSEST_ULL(extra_range,
-							 capped_extra_power);
-		}
+
+	for (i = 0; i < num_actors; i++) {
+		u64 extra_range = (u64)extra_actor_power[i] * extra_power;
+
+		granted_power[i] += DIV_ROUND_CLOSEST_ULL(extra_range,
+						 capped_extra_power);
+	}
 }
 
 static int allocate_power(struct thermal_zone_device *tz, int control_temp)
-- 
2.25.1


