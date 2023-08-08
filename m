Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0272F7747C3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbjHHTS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235971AbjHHTSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:18:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F2FF15B9E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:41:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDA3B14BF;
        Tue,  8 Aug 2023 01:24:00 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.40.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E78953F64C;
        Tue,  8 Aug 2023 01:23:13 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     yangyicong@huawei.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Sami Mujawar <sami.mujawar@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 4/4] coresight: trbe: Enable ACPI based TRBE devices
Date:   Tue,  8 Aug 2023 13:52:47 +0530
Message-Id: <20230808082247.383405-5-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230808082247.383405-1-anshuman.khandual@arm.com>
References: <20230808082247.383405-1-anshuman.khandual@arm.com>
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

This detects and enables ACPI based TRBE devices via the dummy platform
device created earlier for this purpose.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 9 +++++++++
 drivers/hwtracing/coresight/coresight-trbe.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 9455d62ca620..9c59e2652b20 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1548,7 +1548,16 @@ static const struct of_device_id arm_trbe_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, arm_trbe_of_match);
 
+#ifdef CONFIG_ACPI
+static const struct platform_device_id arm_trbe_acpi_match[] = {
+	{ ARMV8_TRBE_PDEV_NAME, 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, arm_trbe_acpi_match);
+#endif
+
 static struct platform_driver arm_trbe_driver = {
+	.id_table = ACPI_PTR(arm_trbe_acpi_match),
 	.driver	= {
 		.name = DRVNAME,
 		.of_match_table = of_match_ptr(arm_trbe_of_match),
diff --git a/drivers/hwtracing/coresight/coresight-trbe.h b/drivers/hwtracing/coresight/coresight-trbe.h
index 77cbb5c63878..fce1735d5c58 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.h
+++ b/drivers/hwtracing/coresight/coresight-trbe.h
@@ -7,11 +7,13 @@
  *
  * Author: Anshuman Khandual <anshuman.khandual@arm.com>
  */
+#include <linux/acpi.h>
 #include <linux/coresight.h>
 #include <linux/device.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
+#include <linux/perf/arm_pmu.h>
 #include <linux/platform_device.h>
 #include <linux/smp.h>
 
-- 
2.25.1

