Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19BF77F574
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350383AbjHQLla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350407AbjHQLlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:41:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C28E4F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 04:41:21 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RRNJp31yhz6J6yC;
        Thu, 17 Aug 2023 19:37:14 +0800 (CST)
Received: from mscphis00759.huawei.com (10.123.66.134) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 12:41:19 +0100
From:   Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
To:     <dan.j.williams@intel.com>
CC:     <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <yusongping@huawei.com>,
        <artem.kuzin@huawei.com>
Subject: [PATCH] drivers: nvdimm: fix dereference after free
Date:   Thu, 17 Aug 2023 19:41:03 +0800
Message-ID: <20230817114103.754977-1-konstantin.meskhidze@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.66.134]
X-ClientProxiedBy: mscpeml500002.china.huawei.com (7.188.26.138) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'nd_pmu->pmu.attr_groups' is dereferenced in function
'nvdimm_pmu_free_hotplug_memory' call after it has been freed. Because in
function 'nvdimm_pmu_free_hotplug_memory' memory pointed by the fields of
'nd_pmu->pmu.attr_groups' is deallocated it is necessary to call 'kfree'
after 'nvdimm_pmu_free_hotplug_memory'.

Co-developed-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
---
 drivers/nvdimm/nd_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/nd_perf.c b/drivers/nvdimm/nd_perf.c
index 14881c4e0..2b6dc80d8 100644
--- a/drivers/nvdimm/nd_perf.c
+++ b/drivers/nvdimm/nd_perf.c
@@ -307,10 +307,10 @@ int register_nvdimm_pmu(struct nvdimm_pmu *nd_pmu, struct platform_device *pdev)
 	}
 
 	rc = perf_pmu_register(&nd_pmu->pmu, nd_pmu->pmu.name, -1);
 	if (rc) {
-		kfree(nd_pmu->pmu.attr_groups);
 		nvdimm_pmu_free_hotplug_memory(nd_pmu);
+		kfree(nd_pmu->pmu.attr_groups);
 		return rc;
 	}
 
 	pr_info("%s NVDIMM performance monitor support registered\n",
-- 
2.34.1

