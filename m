Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5864D8086FD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378910AbjLGLqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjLGLqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:46:04 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C117DD4A;
        Thu,  7 Dec 2023 03:46:10 -0800 (PST)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SmC6L1hJVzShwn;
        Thu,  7 Dec 2023 19:41:46 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 19:46:08 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v2 for-next 1/5] RDMA/hns: Rename the interrupts
Date:   Thu, 7 Dec 2023 19:42:27 +0800
Message-ID: <20231207114231.2872104-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231207114231.2872104-1-huangjunxian6@hisilicon.com>
References: <20231207114231.2872104-1-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500006.china.huawei.com (7.221.188.68)
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

From: Chengchang Tang <tangchengchang@huawei.com>

Now, different devices may have the same interrupt name, which
makes it difficult for users to distinguish between these
interrupts.

Modify the naming style to be consistent with our network devices.
Before:
"hns-aeq-0"
"hns-ceq-0"
...

Now:
"hns-0000:35:00.0-aeq-0"
"hns-0000:35:00.0-ceq-0"
...

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 5d0a7a1394fc..4258b6daaded 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6473,15 +6473,16 @@ static int __hns_roce_request_irq(struct hns_roce_dev *hr_dev, int irq_num,
 	/* irq contains: abnormal + AEQ + CEQ */
 	for (j = 0; j < other_num; j++)
 		snprintf((char *)hr_dev->irq_names[j], HNS_ROCE_INT_NAME_LEN,
-			 "hns-abn-%d", j);
+			 "hns-%s-abn-%d", pci_name(hr_dev->pci_dev), j);
 
 	for (j = other_num; j < (other_num + aeq_num); j++)
 		snprintf((char *)hr_dev->irq_names[j], HNS_ROCE_INT_NAME_LEN,
-			 "hns-aeq-%d", j - other_num);
+			 "hns-%s-aeq-%d", pci_name(hr_dev->pci_dev), j - other_num);
 
 	for (j = (other_num + aeq_num); j < irq_num; j++)
 		snprintf((char *)hr_dev->irq_names[j], HNS_ROCE_INT_NAME_LEN,
-			 "hns-ceq-%d", j - other_num - aeq_num);
+			 "hns-%s-ceq-%d", pci_name(hr_dev->pci_dev),
+			 j - other_num - aeq_num);
 
 	for (j = 0; j < irq_num; j++) {
 		if (j < other_num)
-- 
2.30.0

