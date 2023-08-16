Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334E377E34D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245704AbjHPOK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343573AbjHPOK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:10:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAAEF26B5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:10:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2F2E1063;
        Wed, 16 Aug 2023 07:11:05 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 999E93F762;
        Wed, 16 Aug 2023 07:10:22 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     hejunhao3@huawei.com
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jonathan.cameron@huawei.com,
        leo.yan@linaro.org, mike.leach@linaro.org, james.clark@arm.com,
        linuxarm@huawei.com, yangyicong@huawei.com,
        prime.zeng@hisilicon.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH 2/2] coresight: trbe: Allocate platform data per device
Date:   Wed, 16 Aug 2023 15:10:08 +0100
Message-Id: <20230816141008.535450-2-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816141008.535450-1-suzuki.poulose@arm.com>
References: <20230814093813.19152-1-hejunhao3@huawei.com>
 <20230816141008.535450-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coresight TRBE driver shares a single platform data (which is empty btw).
However, with the commit 4e8fe7e5c3a5
("coresight: Store pointers to connections rather than an array of them")
the coresight core would free up the pdata, resulting in multiple attempts
to free the same pdata for TRBE instances. Fix this by allocating a pdata per
coresight_device.

Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
Link: https://lore.kernel.org/r/20230814093813.19152-3-hejunhao3@huawei.com
Reported-by: Junhao He <hejunhao3@huawei.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 025f70adee47..d3d34a833f01 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1255,10 +1255,13 @@ static void arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cp
 	if (!desc.name)
 		goto cpu_clear;
 
+	desc.pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(desc.pdata))
+		goto cpu_clear;
+
 	desc.type = CORESIGHT_DEV_TYPE_SINK;
 	desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM;
 	desc.ops = &arm_trbe_cs_ops;
-	desc.pdata = dev_get_platdata(dev);
 	desc.groups = arm_trbe_groups;
 	desc.dev = dev;
 	trbe_csdev = coresight_register(&desc);
@@ -1482,7 +1485,6 @@ static void arm_trbe_remove_irq(struct trbe_drvdata *drvdata)
 
 static int arm_trbe_device_probe(struct platform_device *pdev)
 {
-	struct coresight_platform_data *pdata;
 	struct trbe_drvdata *drvdata;
 	struct device *dev = &pdev->dev;
 	int ret;
@@ -1497,12 +1499,7 @@ static int arm_trbe_device_probe(struct platform_device *pdev)
 	if (!drvdata)
 		return -ENOMEM;
 
-	pdata = coresight_get_platform_data(dev);
-	if (IS_ERR(pdata))
-		return PTR_ERR(pdata);
-
 	dev_set_drvdata(dev, drvdata);
-	dev->platform_data = pdata;
 	drvdata->pdev = pdev;
 	ret = arm_trbe_probe_irq(pdev, drvdata);
 	if (ret)
-- 
2.34.1

