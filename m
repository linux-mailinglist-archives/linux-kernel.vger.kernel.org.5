Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8A07723D2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjHGMYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjHGMYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:24:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D63E41
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:24:47 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKFpw280wzfbnT;
        Mon,  7 Aug 2023 20:23:36 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:24:45 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
        <yangyicong@hisilicon.com>
Subject: [PATCH] perf/smmuv3: Add platform id table for module auto loading
Date:   Mon, 7 Aug 2023 20:22:33 +0800
Message-ID: <20230807122233.28563-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

On ACPI based system the device is probed by the name directly. If the
driver is configured as module it can only be loaded manually. Add the
platform id table as well as the module alias then the driver will be
loaded automatically by the udev or others once the device added.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/perf/arm_smmuv3_pmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 25a269d431e4..f27c5f585524 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -946,7 +946,14 @@ static const struct of_device_id smmu_pmu_of_match[] = {
 MODULE_DEVICE_TABLE(of, smmu_pmu_of_match);
 #endif
 
+static const struct platform_device_id smmu_pmu_platform_match[] = {
+	{ "arm-smmu-v3-pmcg", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, smmu_pmu_platform_match);
+
 static struct platform_driver smmu_pmu_driver = {
+	.id_table = smmu_pmu_platform_match,
 	.driver = {
 		.name = "arm-smmu-v3-pmcg",
 		.of_match_table = of_match_ptr(smmu_pmu_of_match),
-- 
2.24.0

