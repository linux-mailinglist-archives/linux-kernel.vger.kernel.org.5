Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9157F9C96
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbjK0J1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjK0J1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:27:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 892EC1A5;
        Mon, 27 Nov 2023 01:27:50 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC9AE2F4;
        Mon, 27 Nov 2023 01:28:37 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.4.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0A7E63F6C4;
        Mon, 27 Nov 2023 01:27:48 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org
Cc:     lukasz.luba@arm.com, rafael@kernel.org, stable@vger.kernel.org
Subject: [PATCH] powercap: DTPM: Fix unneeded conversion to micro-Watts
Date:   Mon, 27 Nov 2023 09:28:19 +0000
Message-Id: <20231127092819.2019744-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Power values coming from the Energy Model are already in uW.
The PowerCap and DTPM framework operate on uW, thus all places should
just use the values from EM. Fix the code which left and still does
the unneeded conversion.

Fixes: ae6ccaa65038 (PM: EM: convert power field to micro-Watts precision and align drivers)
Cc: <stable@vger.kernel.org> # v5.19+
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
Hi Daniel,

I have found an issue due to the uW in the EM. My apologies for that.
I have check those with the Rockpi dev board with your DTPM module there.
BTW, if you like to check the DTPM_devfreq there, you can apply that
patch. It should create EM for your GPU there and setup DTPM GPU:
https://lore.kernel.org/all/20231127081511.1911706-1-lukasz.luba@arm.com/

Regards,
Lukasz


 drivers/powercap/dtpm_cpu.c     |  6 +-----
 drivers/powercap/dtpm_devfreq.c | 11 +++--------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 2ff7717530bf..8a2f18fa3faf 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -24,7 +24,6 @@
 #include <linux/of.h>
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
-#include <linux/units.h>
 
 struct dtpm_cpu {
 	struct dtpm dtpm;
@@ -104,8 +103,7 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
 		if (pd->table[i].frequency < freq)
 			continue;
 
-		return scale_pd_power_uw(pd_mask, pd->table[i].power *
-					 MICROWATT_PER_MILLIWATT);
+		return scale_pd_power_uw(pd_mask, pd->table[i].power);
 	}
 
 	return 0;
@@ -122,11 +120,9 @@ static int update_pd_power_uw(struct dtpm *dtpm)
 	nr_cpus = cpumask_weight(&cpus);
 
 	dtpm->power_min = em->table[0].power;
-	dtpm->power_min *= MICROWATT_PER_MILLIWATT;
 	dtpm->power_min *= nr_cpus;
 
 	dtpm->power_max = em->table[em->nr_perf_states - 1].power;
-	dtpm->power_max *= MICROWATT_PER_MILLIWATT;
 	dtpm->power_max *= nr_cpus;
 
 	return 0;
diff --git a/drivers/powercap/dtpm_devfreq.c b/drivers/powercap/dtpm_devfreq.c
index 91276761a31d..612c3b59dd5b 100644
--- a/drivers/powercap/dtpm_devfreq.c
+++ b/drivers/powercap/dtpm_devfreq.c
@@ -39,10 +39,8 @@ static int update_pd_power_uw(struct dtpm *dtpm)
 	struct em_perf_domain *pd = em_pd_get(dev);
 
 	dtpm->power_min = pd->table[0].power;
-	dtpm->power_min *= MICROWATT_PER_MILLIWATT;
 
 	dtpm->power_max = pd->table[pd->nr_perf_states - 1].power;
-	dtpm->power_max *= MICROWATT_PER_MILLIWATT;
 
 	return 0;
 }
@@ -54,13 +52,10 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 	struct device *dev = devfreq->dev.parent;
 	struct em_perf_domain *pd = em_pd_get(dev);
 	unsigned long freq;
-	u64 power;
 	int i;
 
 	for (i = 0; i < pd->nr_perf_states; i++) {
-
-		power = pd->table[i].power * MICROWATT_PER_MILLIWATT;
-		if (power > power_limit)
+		if (pd->table[i].power > power_limit)
 			break;
 	}
 
@@ -68,7 +63,7 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 
 	dev_pm_qos_update_request(&dtpm_devfreq->qos_req, freq);
 
-	power_limit = pd->table[i - 1].power * MICROWATT_PER_MILLIWATT;
+	power_limit = pd->table[i - 1].power;
 
 	return power_limit;
 }
@@ -110,7 +105,7 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
 		if (pd->table[i].frequency < freq)
 			continue;
 
-		power = pd->table[i].power * MICROWATT_PER_MILLIWATT;
+		power = pd->table[i].power;
 		power *= status.busy_time;
 		power >>= 10;
 
-- 
2.25.1

