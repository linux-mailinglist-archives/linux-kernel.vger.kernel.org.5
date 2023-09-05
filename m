Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F293E792BFB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350547AbjIERE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354023AbjIEJPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:15:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CB4C4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 02:15:13 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rg0Dc2kG6z6D8WV;
        Tue,  5 Sep 2023 17:13:52 +0800 (CST)
Received: from mscphis00759.huawei.com (10.123.66.134) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 5 Sep 2023 10:15:11 +0100
From:   Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
To:     <dan.j.williams@intel.com>
CC:     <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>, <peterz@infradead.org>,
        <kjain@linux.ibm.com>, <maddy@in.ibm.com>,
        <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <yusongping@huawei.com>, <artem.kuzin@huawei.com>
Subject: [PATCH] drivers: nvdimm: fix possible memory leak
Date:   Tue, 5 Sep 2023 17:15:07 +0800
Message-ID: <20230905091507.1672987-1-konstantin.meskhidze@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.66.134]
X-ClientProxiedBy: mscpeml100001.china.huawei.com (7.188.26.227) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory pointed by 'nd_pmu->pmu.attr_groups[NVDIMM_PMU_CPUMASK_ATTR]->attrs[0]'
is allocated in function 'nvdimm_pmu_cpu_hotplug_init' via
'create_cpumask_attr_group' call. But not released in function
'nvdimm_pmu_free_hotplug_memory' or anywhere else before memory pointed by
'nd_pmu->pmu.attr_groups[NVDIMM_PMU_CPUMASK_ATTR]->attrs' will be freed.

Fixes: 0fab1ba6ad6b ("drivers/nvdimm: Add perf interface to expose nvdimm performance stats")
Co-developed-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
---
 drivers/nvdimm/nd_perf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/nd_perf.c b/drivers/nvdimm/nd_perf.c
index 2b6dc80d8..ecfa1f635 100644
--- a/drivers/nvdimm/nd_perf.c
+++ b/drivers/nvdimm/nd_perf.c
@@ -264,10 +264,14 @@ static void nvdimm_pmu_free_hotplug_memory(struct nvdimm_pmu *nd_pmu)
 {
 	cpuhp_state_remove_instance_nocalls(nd_pmu->cpuhp_state, &nd_pmu->node);
 	cpuhp_remove_multi_state(nd_pmu->cpuhp_state);
 
-	if (nd_pmu->pmu.attr_groups[NVDIMM_PMU_CPUMASK_ATTR])
+	if (nd_pmu->pmu.attr_groups[NVDIMM_PMU_CPUMASK_ATTR]) {
+		if (nd_pmu->pmu.attr_groups[NVDIMM_PMU_CPUMASK_ATTR]->attrs)
+			kfree(nd_pmu->pmu.attr_groups[NVDIMM_PMU_CPUMASK_ATTR]->attrs[0]);
+
 		kfree(nd_pmu->pmu.attr_groups[NVDIMM_PMU_CPUMASK_ATTR]->attrs);
+	}
 	kfree(nd_pmu->pmu.attr_groups[NVDIMM_PMU_CPUMASK_ATTR]);
 }
 
 int register_nvdimm_pmu(struct nvdimm_pmu *nd_pmu, struct platform_device *pdev)
-- 
2.34.1
