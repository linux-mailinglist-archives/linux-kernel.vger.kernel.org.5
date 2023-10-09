Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082FD7BD274
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 05:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345038AbjJID4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 23:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344883AbjJID4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 23:56:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12DB0A3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 20:56:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B43831FB;
        Sun,  8 Oct 2023 20:57:29 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 779503F7A6;
        Sun,  8 Oct 2023 20:56:47 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] driver: perf: arm_pmu: Drop some unused arguments from armv8_pmu_init()
Date:   Mon,  9 Oct 2023 09:26:38 +0530
Message-Id: <20231009035638.165270-1-anshuman.khandual@arm.com>
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
NULL pointers for all custom 'struct attribute_group'. These arguments are
not really getting used and hence can just be dropped off, thus simplifying
the code further.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.6-rc5.

 drivers/perf/arm_pmuv3.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 8fcaa26f0f8a..fe4db1831662 100644
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
@@ -1212,13 +1209,9 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 
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
@@ -1226,7 +1219,7 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 static int armv8_pmu_init_nogroups(struct arm_pmu *cpu_pmu, char *name,
 				   int (*map_event)(struct perf_event *event))
 {
-	return armv8_pmu_init(cpu_pmu, name, map_event, NULL, NULL, NULL);
+	return armv8_pmu_init(cpu_pmu, name, map_event);
 }
 
 #define PMUV3_INIT_SIMPLE(name)						\
-- 
2.25.1

