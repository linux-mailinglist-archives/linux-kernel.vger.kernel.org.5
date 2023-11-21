Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC4F7F2A2E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbjKUKUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbjKUKUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:20:00 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15581726;
        Tue, 21 Nov 2023 02:19:08 -0800 (PST)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SZL0m2ZqFz67H66;
        Tue, 21 Nov 2023 18:17:44 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 21 Nov 2023 10:19:06 +0000
From:   <shiju.jose@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>,
        <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
        <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <dan.j.williams@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
        <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
        <jiaqiyan@google.com>, <tony.luck@intel.com>, <Jon.Grimm@amd.com>,
        <dave.hansen@linux.intel.com>, <rafael@kernel.org>,
        <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
        <james.morse@arm.com>, <jthoughton@google.com>,
        <somasundaram.a@hpe.com>, <erdemaktas@google.com>,
        <pgonda@google.com>, <duenwen@google.com>,
        <mike.malvestuto@intel.com>, <gthelen@google.com>,
        <wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
        <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
        <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 08/10] memory: scrub: Add scrub control attributes for the DDR5 ECS
Date:   Tue, 21 Nov 2023 18:18:41 +0800
Message-ID: <20231121101844.1161-9-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20231121101844.1161-1-shiju.jose@huawei.com>
References: <20231121101844.1161-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

Add scrub control attributes for the DDR5 ECS feature.

The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
Specification (JESD79-5) and allows the DRAM to internally read, correct
single-bit errors, and write back corrected data bits to the DRAM array
while providing transparency to error counts. The ECS control feature
allows the request to configure ECS input configurations during system
boot or at run-time.

The ECS control allows the requester to change the ECS threshold count
provided that the request is within the definition specified in DDR5 mode
registers, change mode between codeword mode and row count mode, and reset
the ECS counter.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/memory/scrub/memory-scrub.c | 13 ++++++++++++-
 include/memory/memory-scrub.h       | 10 ++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/scrub/memory-scrub.c b/drivers/memory/scrub/memory-scrub.c
index e14e7207b1ad..d39fa765fa63 100755
--- a/drivers/memory/scrub/memory-scrub.c
+++ b/drivers/memory/scrub/memory-scrub.c
@@ -211,7 +211,8 @@ static bool is_hex_attr(u32 attr)
 
 static bool is_string_attr(u32 attr)
 {
-	return	attr == scrub_speed_available;
+	return	attr == scrub_speed_available ||
+		attr == scrub_threshold_available;
 }
 
 static struct attribute *scrub_genattr(const void *drvdata,
@@ -272,6 +273,16 @@ static const char * const scrub_common_attrs[] = {
 	[scrub_enable] = "enable",
 	[scrub_speed] = "speed",
 	[scrub_speed_available] = "speed_available",
+	/* scrub attributes - DDR5 ECS/common */
+	[scrub_ecs_log_entry_type] = "ecs_log_entry_type",
+	[scrub_ecs_log_entry_type_per_dram] = "ecs_log_entry_type_per_dram",
+	[scrub_ecs_log_entry_type_per_memory_media] = "ecs_log_entry_type_per_memory_media",
+	[scrub_mode] = "mode",
+	[scrub_mode_counts_rows] = "mode_counts_rows",
+	[scrub_mode_counts_codewords] = "mode_counts_codewords",
+	[scrub_reset_counter] = "reset_counter",
+	[scrub_threshold] = "threshold",
+	[scrub_threshold_available] = "threshold_available",
 };
 
 static struct attribute **
diff --git a/include/memory/memory-scrub.h b/include/memory/memory-scrub.h
index d7cbde4718d0..74ad5addd5b3 100755
--- a/include/memory/memory-scrub.h
+++ b/include/memory/memory-scrub.h
@@ -23,6 +23,16 @@ enum scrub_attributes {
 	scrub_enable,
 	scrub_speed,
 	scrub_speed_available,
+	/* scrub attributes - DDR5 ECS/common */
+	scrub_ecs_log_entry_type,
+	scrub_ecs_log_entry_type_per_dram,
+	scrub_ecs_log_entry_type_per_memory_media,
+	scrub_mode,
+	scrub_mode_counts_rows,
+	scrub_mode_counts_codewords,
+	scrub_reset_counter,
+	scrub_threshold,
+	scrub_threshold_available,
 	max_attrs,
 };
 
-- 
2.34.1

