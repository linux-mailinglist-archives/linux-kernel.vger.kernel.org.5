Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AB87BC455
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 05:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343502AbjJGDPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 23:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbjJGDPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 23:15:40 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E9ABF;
        Fri,  6 Oct 2023 20:15:37 -0700 (PDT)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S2VjZ6WltzrT7b;
        Sat,  7 Oct 2023 11:13:06 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 7 Oct 2023 11:15:35 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <shaojijie@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 net-next 1/2] net: hns3: add hns3 vf fault detect cap bit support
Date:   Sat, 7 Oct 2023 11:12:14 +0800
Message-ID: <20231007031215.1067758-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231007031215.1067758-1-shaojijie@huawei.com>
References: <20231007031215.1067758-1-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

From: Jie Wang <wangjie125@huawei.com>

Currently hns3 driver is designed to support VF fault detect feature in
new hardwares. For code compatibility, vf fault detect cap bit is added to
the driver.

Signed-off-by: Jie Wang <wangjie125@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h                   | 4 ++++
 .../net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c  | 1 +
 .../net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h  | 1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c            | 3 +++
 4 files changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index aaf1f42624a7..46062106fc6a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -103,6 +103,7 @@ enum HNAE3_DEV_CAP_BITS {
 	HNAE3_DEV_SUPPORT_LANE_NUM_B,
 	HNAE3_DEV_SUPPORT_WOL_B,
 	HNAE3_DEV_SUPPORT_TM_FLUSH_B,
+	HNAE3_DEV_SUPPORT_VF_FAULT_B,
 };
 
 #define hnae3_ae_dev_fd_supported(ae_dev) \
@@ -177,6 +178,9 @@ enum HNAE3_DEV_CAP_BITS {
 #define hnae3_ae_dev_tm_flush_supported(hdev) \
 	test_bit(HNAE3_DEV_SUPPORT_TM_FLUSH_B, (hdev)->ae_dev->caps)
 
+#define hnae3_ae_dev_vf_fault_supported(ae_dev) \
+	test_bit(HNAE3_DEV_SUPPORT_VF_FAULT_B, (ae_dev)->caps)
+
 enum HNAE3_PF_CAP_BITS {
 	HNAE3_PF_SUPPORT_VLAN_FLTR_MDF_B = 0,
 };
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
index dcecb23daac6..d92ad6082d8e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
@@ -157,6 +157,7 @@ static const struct hclge_comm_caps_bit_map hclge_pf_cmd_caps[] = {
 	{HCLGE_COMM_CAP_LANE_NUM_B, HNAE3_DEV_SUPPORT_LANE_NUM_B},
 	{HCLGE_COMM_CAP_WOL_B, HNAE3_DEV_SUPPORT_WOL_B},
 	{HCLGE_COMM_CAP_TM_FLUSH_B, HNAE3_DEV_SUPPORT_TM_FLUSH_B},
+	{HCLGE_COMM_CAP_VF_FAULT_B, HNAE3_DEV_SUPPORT_VF_FAULT_B},
 };
 
 static const struct hclge_comm_caps_bit_map hclge_vf_cmd_caps[] = {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h
index 2b7197ce0ae8..92e73d44f0e5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h
@@ -348,6 +348,7 @@ enum HCLGE_COMM_CAP_BITS {
 	HCLGE_COMM_CAP_GRO_B = 20,
 	HCLGE_COMM_CAP_FD_B = 21,
 	HCLGE_COMM_CAP_FEC_STATS_B = 25,
+	HCLGE_COMM_CAP_VF_FAULT_B = 26,
 	HCLGE_COMM_CAP_LANE_NUM_B = 27,
 	HCLGE_COMM_CAP_WOL_B = 28,
 	HCLGE_COMM_CAP_TM_FLUSH_B = 31,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index b8508533878b..0b138635bafa 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -414,6 +414,9 @@ static struct hns3_dbg_cap_info hns3_dbg_cap[] = {
 	}, {
 		.name = "support tm flush",
 		.cap_bit = HNAE3_DEV_SUPPORT_TM_FLUSH_B,
+	}, {
+		.name = "support vf fault detect",
+		.cap_bit = HNAE3_DEV_SUPPORT_VF_FAULT_B,
 	}
 };
 
-- 
2.30.0

