Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43017FD32E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjK2JsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjK2JsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:48:05 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4811819B6;
        Wed, 29 Nov 2023 01:48:10 -0800 (PST)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SgDyJ70R0zvR9X;
        Wed, 29 Nov 2023 17:47:36 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 29 Nov 2023 17:48:08 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-rc 3/6] RDMA/hns: Add a max length of gid table
Date:   Wed, 29 Nov 2023 17:44:31 +0800
Message-ID: <20231129094434.134528-4-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231129094434.134528-1-huangjunxian6@hisilicon.com>
References: <20231129094434.134528-1-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IB-core and rdma-core restrict the sgid_index specified by users,
which is uint8_t/u8 data type, to only be within the range of 0-255,
so it's meaningless to support excessively large gid_table_len.

On the other hand, ib-core creates as many sysfs gid files as
gid_table_len, most of which are not only useless because of the
reason above, but also greatly increase the traversal time of
the sysfs gid files for applications.

This patch limits the maximum length of gid table to 256.

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 1ceeedfa225f..8126922b4e21 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2055,6 +2055,7 @@ static void set_hem_page_size(struct hns_roce_dev *hr_dev)
 /* Apply all loaded caps before setting to hardware */
 static void apply_func_caps(struct hns_roce_dev *hr_dev)
 {
+#define MAX_GID_TBL_LEN 256
 	struct hns_roce_caps *caps = &hr_dev->caps;
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 
@@ -2090,8 +2091,14 @@ static void apply_func_caps(struct hns_roce_dev *hr_dev)
 		caps->gmv_entry_sz = HNS_ROCE_V3_GMV_ENTRY_SZ;
 
 		caps->gmv_hop_num = HNS_ROCE_HOP_NUM_0;
-		caps->gid_table_len[0] = caps->gmv_bt_num *
-					(HNS_HW_PAGE_SIZE / caps->gmv_entry_sz);
+
+		/* It's meaningless to support excessively large gid_table_len,
+		 * as the type of sgid_index in kernel struct ib_global_route
+		 * and userspace struct ibv_global_route are u8/uint8_t (0-255).
+		 */
+		caps->gid_table_len[0] = min_t(u32, MAX_GID_TBL_LEN,
+					 caps->gmv_bt_num *
+					 (HNS_HW_PAGE_SIZE / caps->gmv_entry_sz));
 
 		caps->gmv_entry_num = caps->gmv_bt_num * (PAGE_SIZE /
 							  caps->gmv_entry_sz);
-- 
2.30.0

