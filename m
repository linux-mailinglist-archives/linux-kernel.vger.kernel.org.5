Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E0A7BD909
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345853AbjJIKyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345877AbjJIKyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:54:20 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E448E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 03:54:19 -0700 (PDT)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4S3wmF0GzYzkXtk;
        Mon,  9 Oct 2023 18:50:21 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 9 Oct 2023 18:54:16 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <will@kernel.org>, <jonathan.cameron@huawei.com>,
        <mark.rutland@arm.com>, <yangyicong@hisilicon.com>,
        <shaojijie@huawei.com>
CC:     <chenhao418@huawei.com>, <shenjian15@huawei.com>,
        <wangjie125@huawei.com>, <liuyonglong@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH drivers/perf: hisi:] drivers/perf: hisi: fix NULL pointer issue when uninstall hns3 pmu driver
Date:   Mon, 9 Oct 2023 18:50:38 +0800
Message-ID: <20231009105038.126040-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hao Chen <chenhao418@huawei.com>

When uninstall hns3 pmu driver, it will call cpuhp_state_remove_instance()
and then callback function hns3_pmu_offline_cpu() is called, it may cause
NULL pointer call trace when other driver is installing or uninstalling
concurrently.

As John Garry's opinion, cpuhp_state_remove_instance() is used for shared
interrupt, and using cpuhp_state_remove_instance_nocalls() is fine for PCIe
or HNS3 pmu.

So, replace cpuhp_state_remove_instance() with
cpuhp_state_remove_instance_nocalls() to fix this problem.

Fixes: 66637ab137b4 ("drivers/perf: hisi: add driver for HNS3 PMU")
Signed-off-by: Hao Chen <chenhao418@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/perf/hisilicon/hns3_pmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/hisilicon/hns3_pmu.c b/drivers/perf/hisilicon/hns3_pmu.c
index e0457d84af6b..16869bf5bf4c 100644
--- a/drivers/perf/hisilicon/hns3_pmu.c
+++ b/drivers/perf/hisilicon/hns3_pmu.c
@@ -1556,8 +1556,8 @@ static int hns3_pmu_init_pmu(struct pci_dev *pdev, struct hns3_pmu *hns3_pmu)
 	ret = perf_pmu_register(&hns3_pmu->pmu, hns3_pmu->pmu.name, -1);
 	if (ret) {
 		pci_err(pdev, "failed to register perf PMU, ret = %d.\n", ret);
-		cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_HNS3_PMU_ONLINE,
-					    &hns3_pmu->node);
+		cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_HNS3_PMU_ONLINE,
+						    &hns3_pmu->node);
 	}
 
 	return ret;
@@ -1568,8 +1568,8 @@ static void hns3_pmu_uninit_pmu(struct pci_dev *pdev)
 	struct hns3_pmu *hns3_pmu = pci_get_drvdata(pdev);
 
 	perf_pmu_unregister(&hns3_pmu->pmu);
-	cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_HNS3_PMU_ONLINE,
-				    &hns3_pmu->node);
+	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_HNS3_PMU_ONLINE,
+					    &hns3_pmu->node);
 }
 
 static int hns3_pmu_init_dev(struct pci_dev *pdev)
-- 
2.30.0

