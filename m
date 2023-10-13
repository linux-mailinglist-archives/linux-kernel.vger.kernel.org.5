Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283FF7C7C6D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 06:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjJMEDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 00:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMEDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 00:03:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04E57B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 21:03:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5EEB11FB;
        Thu, 12 Oct 2023 21:03:56 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F038D3F762;
        Thu, 12 Oct 2023 21:03:13 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        James Clark <james.clark@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] drivers: perf: arm_pmuv3: Drop some unused arguments from armv8_pmu_init()
Date:   Fri, 13 Oct 2023 09:33:07 +0530
Message-Id: <20231013040307.1296109-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is just a single call site remaining for armv8_pmu_init(), passing on
NULL pointers for all custom 'struct attribute_group's. These arguments are
not really getting used, and hence can be dropped. Afterwards the function
armv8_pmu_init_nogroups() itself becomes redundant, and can also be dropped
as well.

The commit e424b1798526 ("arm64: perf: Refactor PMU init callbacks") wanted
to preserve the notion that non-default sysfs attributes could be used some
time in the future and hence armv8_pmu_init_nogroups() stayed on but now it
can be dropped to remove some redundant indirection, simplifying the code.

CC: James Clark <james.clark@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.6-rc5

Changes in V2:

- Dropped the helper armv8_pmu_init_nogroups()
- Updated the commit message

Changes in V1:

https://lore.kernel.org/all/20231009035638.165270-1-anshuman.khandual@arm.com/

 drivers/perf/arm_pmuv3.c | 44 +++++++++++-----------------------------
 1 file changed, 12 insertions(+), 32 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 8fcaa26f0f8a..c093b6e823f6 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1187,10 +1187,7 @@ static void armv8_pmu_register_sysctl_table(void)
 }
 
 static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
-			  int (*map_event)(struct perf_event *event),
-			  const struct attribute_group *events,
-			  const struct attribute_group *format,
-			  const struct attribute_group *caps)
+			  int (*map_event)(struct perf_event *event))
 {
 	int ret = armv8pmu_probe_pmu(cpu_pmu);
 	if (ret)
@@ -1212,27 +1209,17 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 
 	cpu_pmu->name			= name;
 	cpu_pmu->map_event		= map_event;
-	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = events ?
-			events : &armv8_pmuv3_events_attr_group;
-	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] = format ?
-			format : &armv8_pmuv3_format_attr_group;
-	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_CAPS] = caps ?
-			caps : &armv8_pmuv3_caps_attr_group;
-
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &armv8_pmuv3_events_attr_group;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] = &armv8_pmuv3_format_attr_group;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_CAPS] = &armv8_pmuv3_caps_attr_group;
 	armv8_pmu_register_sysctl_table();
 	return 0;
 }
 
-static int armv8_pmu_init_nogroups(struct arm_pmu *cpu_pmu, char *name,
-				   int (*map_event)(struct perf_event *event))
-{
-	return armv8_pmu_init(cpu_pmu, name, map_event, NULL, NULL, NULL);
-}
-
 #define PMUV3_INIT_SIMPLE(name)						\
 static int name##_pmu_init(struct arm_pmu *cpu_pmu)			\
 {									\
-	return armv8_pmu_init_nogroups(cpu_pmu, #name, armv8_pmuv3_map_event);\
+	return armv8_pmu_init(cpu_pmu, #name, armv8_pmuv3_map_event);	\
 }
 
 PMUV3_INIT_SIMPLE(armv8_pmuv3)
@@ -1263,44 +1250,37 @@ PMUV3_INIT_SIMPLE(armv8_nvidia_denver)
 
 static int armv8_a35_pmu_init(struct arm_pmu *cpu_pmu)
 {
-	return armv8_pmu_init_nogroups(cpu_pmu, "armv8_cortex_a35",
-				       armv8_a53_map_event);
+	return armv8_pmu_init(cpu_pmu, "armv8_cortex_a35", armv8_a53_map_event);
 }
 
 static int armv8_a53_pmu_init(struct arm_pmu *cpu_pmu)
 {
-	return armv8_pmu_init_nogroups(cpu_pmu, "armv8_cortex_a53",
-				       armv8_a53_map_event);
+	return armv8_pmu_init(cpu_pmu, "armv8_cortex_a53", armv8_a53_map_event);
 }
 
 static int armv8_a57_pmu_init(struct arm_pmu *cpu_pmu)
 {
-	return armv8_pmu_init_nogroups(cpu_pmu, "armv8_cortex_a57",
-				       armv8_a57_map_event);
+	return armv8_pmu_init(cpu_pmu, "armv8_cortex_a57", armv8_a57_map_event);
 }
 
 static int armv8_a72_pmu_init(struct arm_pmu *cpu_pmu)
 {
-	return armv8_pmu_init_nogroups(cpu_pmu, "armv8_cortex_a72",
-				       armv8_a57_map_event);
+	return armv8_pmu_init(cpu_pmu, "armv8_cortex_a72", armv8_a57_map_event);
 }
 
 static int armv8_a73_pmu_init(struct arm_pmu *cpu_pmu)
 {
-	return armv8_pmu_init_nogroups(cpu_pmu, "armv8_cortex_a73",
-				       armv8_a73_map_event);
+	return armv8_pmu_init(cpu_pmu, "armv8_cortex_a73", armv8_a73_map_event);
 }
 
 static int armv8_thunder_pmu_init(struct arm_pmu *cpu_pmu)
 {
-	return armv8_pmu_init_nogroups(cpu_pmu, "armv8_cavium_thunder",
-				       armv8_thunder_map_event);
+	return armv8_pmu_init(cpu_pmu, "armv8_cavium_thunder", armv8_thunder_map_event);
 }
 
 static int armv8_vulcan_pmu_init(struct arm_pmu *cpu_pmu)
 {
-	return armv8_pmu_init_nogroups(cpu_pmu, "armv8_brcm_vulcan",
-				       armv8_vulcan_map_event);
+	return armv8_pmu_init(cpu_pmu, "armv8_brcm_vulcan", armv8_vulcan_map_event);
 }
 
 static const struct of_device_id armv8_pmu_of_device_ids[] = {
-- 
2.25.1

