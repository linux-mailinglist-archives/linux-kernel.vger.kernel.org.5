Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99DD8086FF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379061AbjLGLqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjLGLqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:46:05 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EE4137;
        Thu,  7 Dec 2023 03:46:10 -0800 (PST)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SmCBc4MnszYsp3;
        Thu,  7 Dec 2023 19:45:28 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 19:46:08 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v2 for-next 2/5] RDMA/hns: Response dmac to userspace
Date:   Thu, 7 Dec 2023 19:42:28 +0800
Message-ID: <20231207114231.2872104-3-huangjunxian6@hisilicon.com>
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

While creating AH, dmac is already resolved in kernel. Response dmac
to userspace so that userspace doesn't need to resolve dmac repeatedly.

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_ah.c | 7 +++++++
 include/uapi/rdma/hns-abi.h             | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index fbf046982374..b4209b6aed8d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -57,6 +57,7 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	struct rdma_ah_attr *ah_attr = init_attr->ah_attr;
 	const struct ib_global_route *grh = rdma_ah_read_grh(ah_attr);
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibah->device);
+	struct hns_roce_ib_create_ah_resp resp = {};
 	struct hns_roce_ah *ah = to_hr_ah(ibah);
 	int ret = 0;
 	u32 max_sl;
@@ -97,6 +98,12 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 		ah->av.vlan_en = ah->av.vlan_id < VLAN_N_VID;
 	}
 
+	if (udata) {
+		memcpy(resp.dmac, ah_attr->roce.dmac, ETH_ALEN);
+		ret = ib_copy_to_udata(udata, &resp,
+				       min(udata->outlen, sizeof(resp)));
+	}
+
 err_out:
 	if (ret)
 		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_AH_CREATE_ERR_CNT]);
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index ce0f37f83416..c996e151081e 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -125,4 +125,9 @@ struct hns_roce_ib_alloc_pd_resp {
 	__u32 pdn;
 };
 
+struct hns_roce_ib_create_ah_resp {
+	__u8 dmac[6];
+	__u8 reserved[2];
+};
+
 #endif /* HNS_ABI_USER_H */
-- 
2.30.0

