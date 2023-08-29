Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54D678C684
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbjH2NzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbjH2Nyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:54:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 333CEB5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:54:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B6F02F4;
        Tue, 29 Aug 2023 06:55:08 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.57.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2323D3F64C;
        Tue, 29 Aug 2023 06:54:23 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Sami Mujawar <sami.mujawar@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 2/2] coresight: trbe: Enable ACPI based TRBE devices
Date:   Tue, 29 Aug 2023 19:24:05 +0530
Message-Id: <20230829135405.1159449-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230829135405.1159449-1-anshuman.khandual@arm.com>
References: <20230829135405.1159449-1-anshuman.khandual@arm.com>
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
index 97b9e72965e6..a3954be7b1f3 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1546,7 +1546,16 @@ static const struct of_device_id arm_trbe_of_match[] = {
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
index e915e749be55..45202c48acce 100644
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

