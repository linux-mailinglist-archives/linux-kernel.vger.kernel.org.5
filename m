Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28608086FE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjLGLqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjLGLqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:46:05 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27BBD5C;
        Thu,  7 Dec 2023 03:46:11 -0800 (PST)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SmCBK6bYGzWjKL;
        Thu,  7 Dec 2023 19:45:13 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 19:46:09 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v2 for-next 5/5] RDMA/hns: Fix memory leak in free_mr_init()
Date:   Thu, 7 Dec 2023 19:42:31 +0800
Message-ID: <20231207114231.2872104-6-huangjunxian6@hisilicon.com>
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

When a reserved QP fails to be created, the memory of the remaining
created reserved QPs is leaked.

Fixes: 70f92521584f ("RDMA/hns: Use the reserved loopback QPs to free MR before destroying MPT")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 93a71db527d8..b8dde04bd573 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2710,6 +2710,10 @@ static int free_mr_alloc_res(struct hns_roce_dev *hr_dev)
 	return 0;
 
 create_failed_qp:
+	for (i--; i >= 0; i--) {
+		hns_roce_v2_destroy_qp(&free_mr->rsv_qp[i]->ibqp, NULL);
+		kfree(free_mr->rsv_qp[i]);
+	}
 	hns_roce_destroy_cq(cq, NULL);
 	kfree(cq);
 
-- 
2.30.0

