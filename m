Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CC37CA61A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjJPKzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjJPKzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:55:33 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D0383
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:55:29 -0700 (PDT)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4S8DTq0Bcxz15NS3;
        Mon, 16 Oct 2023 18:52:47 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 16 Oct 2023 18:55:26 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <will@kernel.org>, <jonathan.cameron@huawei.com>,
        <mark.rutland@arm.com>, <yangyicong@hisilicon.com>
CC:     <shaojijie@huawei.com>, <chenhao418@huawei.com>,
        <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V2 drivers/perf: hisi:] drivers/perf: hisi: use cpuhp_state_remove_instance_nocalls() for hns3 pmu uninit process
Date:   Mon, 16 Oct 2023 18:51:39 +0800
Message-ID: <20231016105139.1436425-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hao Chen <chenhao418@huawei.com>

For pmu uninit process, we unregister pmu and then call cpuhp_state_remove_instance()
to call callback function to migrate pmu context. the logic is unreasonable and
may result in NULL pointer call trace.

Found NULL pointer call trace for kernel-5.13 at the first time, log shows as below:
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[27169.471153] Mem abort info:
[27169.478859]   ESR = 0x96000006
[27169.485117]   EC = 0x25: DABT (current EL), IL = 32 bits
[27169.501386]   SET = 0, FnV = 0
[27169.508038]   EA = 0, S1PTW = 0
[27169.559839] Data abort info:
[27169.567296]   ISV = 0, ISS = 0x00000006
[27169.585332]   CM = 0, WnR = 0
[27169.592627] user pgtable: 4k pages, 48-bit VAs, pgdp=00000820ac0c2000
[27169.615618] [0000000000000000] pgd=00000820af2bf003, p4d=00000820af2bf003, pud=00000820af2bd003, pmd=0000000000000000
[27169.641348] Internal error: Oops: 96000006 [#1] PREEMPT SMP
[27169.649879] Modules linked in: hisi_hns3_pmu(-) hns3 hclge hclgevf hnae3 hns3_cae(O) vfio_iommu_type1 vfio_pci vfio_virqfd vfio pv680_mii(O) [last unloaded: hisi_hns3_pmu]
[27169.675150] CPU: 0 PID: 15 Comm: cpuhp/0 Tainted: G        W  O      5.12.0-rc4+ #1
[27169.686538] Hardware name:  , BIOS KpxxxFPGA 1P B600 V143 04/22/2021
[27169.694884] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO BTYPE=--)
[27169.704199] pc : perf_pmu_migrate_context+0x98/0x38c
[27169.713848] lr : perf_pmu_migrate_context+0x94/0x38c
[27169.723069] sp : ffff80001020bc80
[27169.727938] x29: ffff80001020bc80 x28: 0000000000000000
[27169.737236] x27: 0000000000000001 x26: fffffbffeff951d8
[27169.745245] x25: ffffb7ae1ce36fd0 x24: fffffbffeff95178
[27169.753116] x23: ffff0821f6f82668 x22: 0000000000000001
[27169.760949] x21: ffff80001020bd08 x20: fffffbffeffb5188
[27169.768467] x19: fffffbffeffb5178 x18: 0000000000000020
[27169.776699] x17: 0000000000000000 x16: 0000000000000000
[27169.785042] x15: 0000000000000004 x14: ffff08208093d290
[27169.793254] x13: 0000000000000000 x12: 0000497f0149bafe
[27169.801390] x11: 01262d2f8bbfdccc x10: 3dc70ddec1e5f4f9
[27169.808896] x9 : ffffb7ae1a7eb108 x8 : 0000000000000002
[27169.817000] x7 : 0000000000000000 x6 : 000000000000000e
[27169.824726] x5 : 0000000000000001 x4 : 0000000000000000
[27169.832924] x3 : 0000000000000000 x2 : ffff082080a30e80
[27169.841135] x1 : 0000000000000000 x0 : fffffbffeffb5188
[27169.849059] Call trace:
[27169.853177]  perf_pmu_migrate_context+0x98/0x38c
[27169.862256]  hisi_hns3_pmu_offline_cpu+0x104/0x12c [hisi_hns3_pmu]
[27169.873943]  cpuhp_invoke_callback+0x118/0x634
[27169.882775]  cpuhp_thread_fun+0xe8/0x190
[27169.890345]  smpboot_thread_fn+0x25c/0x290
[27169.898241]  kthread+0x168/0x16c
[27169.904178]  ret_from_fork+0x10/0x18
[27169.911943] Code: 944beda1 aa1403e0 944bed9f f8460f5c (f9400394)

And tested some other uncore pmu driver such as hisi pcie pmu and hisi uncore i3c pmu,
hisi pcie pmu driver can reproduce it also, and change hisi uncore i3c pmu hotplug
function from cpuhp_state_remove_instance_nocalls() to cpuhp_state_remove_instance(),
it has the same call trace.

This patch change cpuhp_state_remove_instance() to cpuhp_state_remove_instance_nocalls()
after pmu unregistered to fix the problem.

This problem is fixed by commit bd2756811766 ("perf: Rewrite core context handling")
for kernel-6.2.

Hisi hns3 pmu driver is supported for kernel-5.19, so, use this patch as bugfix for
stable 6.0 and 6.1 tag, and use this patch as cleanup for newest kernel version.

Fixes: 66637ab137b4 ("drivers/perf: hisi: add driver for HNS3 PMU")
Signed-off-by: Hao Chen <chenhao418@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
ChangeLog:
	1. Add more details for NULL pointer call trace suggested by Yicong
	V1: https://lore.kernel.org/all/20231009105038.126040-1-shaojijie@huawei.com/
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

