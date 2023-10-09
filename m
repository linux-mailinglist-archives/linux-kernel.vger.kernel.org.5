Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554A87BE832
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378077AbjJIRcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377985AbjJIRch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:32:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241CBDA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 10:32:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AC6C433C8;
        Mon,  9 Oct 2023 17:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696872751;
        bh=CZdCFg11N/zBqMQWFE5ZUMyNjYxDelPKhHZLSs4IVs4=;
        h=From:To:Cc:Subject:Date:From;
        b=kIFdLJ8yXsE71IACu88BR6lk6dguuyvgahZ9KcbbkAajShZk8c4YYOoHOIbDNxH+K
         tYNk55pqMaxVEjeHTRdn62O1hVNO8gFAfffb7rGJs9MlYXe88AwUpOVW3sDvsYp1jd
         L6LdJZyaikFRsRygzPn7zb55q6MRXrL7dvBx6q8aNelrr84yx0DQ0Q8wcdze5igO6y
         jFAFHozwAYU02C6qOmH0QycVi/xxK+JnHvbwzGILRNrjPToFOIGeeA+gKVQh4by8Bz
         C3o9jPFGYWWNrQoZG1qDqRL5oDUWiy3dkIG+p4DMl7qjY6VovGGX64TRfL+cKX3RPq
         2YHKx9JbRPYLQ==
Received: (nullmailer pid 2527181 invoked by uid 1000);
        Mon, 09 Oct 2023 17:32:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     Khuong Dinh <khuong@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/perf: xgene: Use device_get_match_data()
Date:   Mon,  9 Oct 2023 12:29:09 -0500
Message-ID: <20231009172923.2457844-14-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() and
acpi_match_device() to get the driver match data. With this, adjust the
includes to explicitly include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/perf/xgene_pmu.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 9972bfc11a5c..7ce344248dda 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -16,11 +16,9 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
-#include <linux/of_fdt.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
@@ -1731,6 +1729,12 @@ static const struct xgene_pmu_data xgene_pmu_v2_data = {
 	.id   = PCP_PMU_V2,
 };
 
+#ifdef CONFIG_ACPI
+static const struct xgene_pmu_data xgene_pmu_v3_data = {
+	.id   = PCP_PMU_V3,
+};
+#endif
+
 static const struct xgene_pmu_ops xgene_pmu_ops = {
 	.mask_int = xgene_pmu_mask_int,
 	.unmask_int = xgene_pmu_unmask_int,
@@ -1773,9 +1777,9 @@ static const struct of_device_id xgene_pmu_of_match[] = {
 MODULE_DEVICE_TABLE(of, xgene_pmu_of_match);
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id xgene_pmu_acpi_match[] = {
-	{"APMC0D5B", PCP_PMU_V1},
-	{"APMC0D5C", PCP_PMU_V2},
-	{"APMC0D83", PCP_PMU_V3},
+	{"APMC0D5B", (kernel_ulong_t)&xgene_pmu_data},
+	{"APMC0D5C", (kernel_ulong_t)&xgene_pmu_v2_data},
+	{"APMC0D83", (kernel_ulong_t)&xgene_pmu_v3_data},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, xgene_pmu_acpi_match);
@@ -1831,7 +1835,6 @@ static int xgene_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 static int xgene_pmu_probe(struct platform_device *pdev)
 {
 	const struct xgene_pmu_data *dev_data;
-	const struct of_device_id *of_id;
 	struct xgene_pmu *xgene_pmu;
 	int irq, rc;
 	int version;
@@ -1850,24 +1853,10 @@ static int xgene_pmu_probe(struct platform_device *pdev)
 	xgene_pmu->dev = &pdev->dev;
 	platform_set_drvdata(pdev, xgene_pmu);
 
-	version = -EINVAL;
-	of_id = of_match_device(xgene_pmu_of_match, &pdev->dev);
-	if (of_id) {
-		dev_data = (const struct xgene_pmu_data *) of_id->data;
-		version = dev_data->id;
-	}
-
-#ifdef CONFIG_ACPI
-	if (ACPI_COMPANION(&pdev->dev)) {
-		const struct acpi_device_id *acpi_id;
-
-		acpi_id = acpi_match_device(xgene_pmu_acpi_match, &pdev->dev);
-		if (acpi_id)
-			version = (int) acpi_id->driver_data;
-	}
-#endif
-	if (version < 0)
+	dev_data = device_get_match_data(&pdev->dev);
+	if (!dev_data)
 		return -ENODEV;
+	version = dev_data->id;
 
 	if (version == PCP_PMU_V3)
 		xgene_pmu->ops = &xgene_pmu_v3_ops;
-- 
2.42.0

