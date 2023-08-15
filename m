Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC18C77C78B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbjHOGMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbjHOGLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:11:55 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41481BE7;
        Mon, 14 Aug 2023 23:11:52 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RQ18m20NXz1GDXD;
        Tue, 15 Aug 2023 14:10:32 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 14:11:50 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <shaojijie@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 4/4] net: hns3: fix wrong rpu tln reg issue
Date:   Tue, 15 Aug 2023 14:06:41 +0800
Message-ID: <20230815060641.3551665-5-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230815060641.3551665-1-shaojijie@huawei.com>
References: <20230815060641.3551665-1-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the original RPU query command, the status register values of
multiple RPU tunnels are accumulated by default, which is unreasonable.
This patch Fix it by querying the specified tunnel ID.
The tunnel number of the device can be obtained from firmware
during initialization.

Fixes: ddb54554fa51 ("net: hns3: add DFX registers information for ethtool -d")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  1 +
 .../hisilicon/hns3/hns3pf/hclge_cmd.h         |  4 +-
 .../hisilicon/hns3/hns3pf/hclge_main.c        |  2 +
 .../hisilicon/hns3/hns3pf/hclge_regs.c        | 66 ++++++++++++++++++-
 4 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 514a20bce4f4..a4b43bcd2f0c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -382,6 +382,7 @@ struct hnae3_dev_specs {
 	u16 umv_size;
 	u16 mc_mac_size;
 	u32 mac_stats_num;
+	u8 tnl_num;
 };
 
 struct hnae3_client_ops {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 0bd858620f27..4d15eb73b972 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -826,7 +826,9 @@ struct hclge_dev_specs_1_cmd {
 	u8 rsv0[2];
 	__le16 umv_size;
 	__le16 mc_mac_size;
-	u8 rsv1[12];
+	u8 rsv1[6];
+	u8 tnl_num;
+	u8 rsv2[5];
 };
 
 /* mac speed type defined in firmware command */
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 36e8daf49811..0f50dba6cc47 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1326,6 +1326,7 @@ static void hclge_set_default_dev_specs(struct hclge_dev *hdev)
 	ae_dev->dev_specs.max_frm_size = HCLGE_MAC_MAX_FRAME;
 	ae_dev->dev_specs.max_qset_num = HCLGE_MAX_QSET_NUM;
 	ae_dev->dev_specs.umv_size = HCLGE_DEFAULT_UMV_SPACE_PER_PF;
+	ae_dev->dev_specs.tnl_num = 0;
 }
 
 static void hclge_parse_dev_specs(struct hclge_dev *hdev,
@@ -1349,6 +1350,7 @@ static void hclge_parse_dev_specs(struct hclge_dev *hdev,
 	ae_dev->dev_specs.max_frm_size = le16_to_cpu(req1->max_frm_size);
 	ae_dev->dev_specs.umv_size = le16_to_cpu(req1->umv_size);
 	ae_dev->dev_specs.mc_mac_size = le16_to_cpu(req1->mc_mac_size);
+	ae_dev->dev_specs.tnl_num = req1->tnl_num;
 }
 
 static void hclge_check_dev_specs(struct hclge_dev *hdev)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c
index 734e5f757b9c..43c1c18fa81f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c
@@ -125,6 +125,7 @@ enum hclge_reg_tag {
 	HCLGE_REG_TAG_DFX_RCB,
 	HCLGE_REG_TAG_DFX_TQP,
 	HCLGE_REG_TAG_DFX_SSU_2,
+	HCLGE_REG_TAG_RPU_TNL,
 };
 
 #pragma pack(4)
@@ -147,6 +148,8 @@ struct hclge_reg_header {
 #define HCLGE_REG_HEADER_SPACE	(sizeof(struct hclge_reg_header) / sizeof(u32))
 #define HCLGE_REG_MAGIC_NUMBER	0x686e733372656773 /* meaning is hns3regs */
 
+#define HCLGE_REG_RPU_TNL_ID_0	1
+
 static u32 hclge_reg_get_header(void *data)
 {
 	struct hclge_reg_header *header = data;
@@ -342,6 +345,28 @@ static int hclge_dfx_reg_cmd_send(struct hclge_dev *hdev,
 	return ret;
 }
 
+/* tnl_id = 0 means get sum of all tnl reg's value */
+static int hclge_dfx_reg_rpu_tnl_cmd_send(struct hclge_dev *hdev, u32 tnl_id,
+					  struct hclge_desc *desc, int bd_num)
+{
+	int i, ret;
+
+	for (i = 0; i < bd_num; i++) {
+		hclge_cmd_setup_basic_desc(&desc[i], HCLGE_OPC_DFX_RPU_REG_0,
+					   true);
+		if (i != bd_num - 1)
+			desc[i].flag |= cpu_to_le16(HCLGE_COMM_CMD_FLAG_NEXT);
+	}
+
+	desc[0].data[0] = cpu_to_le32(tnl_id);
+	ret = hclge_cmd_send(&hdev->hw, desc, bd_num);
+	if (ret)
+		dev_err(&hdev->pdev->dev,
+			"failed to query dfx rpu tnl reg, ret = %d\n",
+			ret);
+	return ret;
+}
+
 static int hclge_dfx_reg_fetch_data(struct hclge_desc *desc_src, int bd_num,
 				    void *data)
 {
@@ -363,6 +388,7 @@ static int hclge_dfx_reg_fetch_data(struct hclge_desc *desc_src, int bd_num,
 static int hclge_get_dfx_reg_len(struct hclge_dev *hdev, int *len)
 {
 	u32 dfx_reg_type_num = ARRAY_SIZE(hclge_dfx_bd_offset_list);
+	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(hdev->pdev);
 	int data_len_per_desc;
 	int *bd_num_list;
 	int ret;
@@ -384,11 +410,41 @@ static int hclge_get_dfx_reg_len(struct hclge_dev *hdev, int *len)
 	for (i = 0; i < dfx_reg_type_num; i++)
 		*len += bd_num_list[i] * data_len_per_desc + HCLGE_REG_TLV_SIZE;
 
+	/**
+	 * the num of dfx_rpu_0 is reused by each dfx_rpu_tnl
+	 * HCLGE_DFX_BD_OFFSET is starting at 1, but the array subscript is
+	 * starting at 0, so offset need '- 1'.
+	 */
+	*len += (bd_num_list[HCLGE_DFX_RPU_0_BD_OFFSET - 1] * data_len_per_desc +
+		 HCLGE_REG_TLV_SIZE) * ae_dev->dev_specs.tnl_num;
+
 out:
 	kfree(bd_num_list);
 	return ret;
 }
 
+static int hclge_get_dfx_rpu_tnl_reg(struct hclge_dev *hdev, u32 *reg,
+				     struct hclge_desc *desc_src,
+				     int bd_num)
+{
+	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(hdev->pdev);
+	int ret = 0;
+	u8 i;
+
+	for (i = HCLGE_REG_RPU_TNL_ID_0; i <= ae_dev->dev_specs.tnl_num; i++) {
+		ret = hclge_dfx_reg_rpu_tnl_cmd_send(hdev, i, desc_src, bd_num);
+		if (ret)
+			break;
+
+		reg += hclge_reg_get_tlv(HCLGE_REG_TAG_RPU_TNL,
+					 ARRAY_SIZE(desc_src->data) * bd_num,
+					 reg);
+		reg += hclge_dfx_reg_fetch_data(desc_src, bd_num, reg);
+	}
+
+	return ret;
+}
+
 static int hclge_get_dfx_reg(struct hclge_dev *hdev, void *data)
 {
 	u32 dfx_reg_type_num = ARRAY_SIZE(hclge_dfx_bd_offset_list);
@@ -428,7 +484,7 @@ static int hclge_get_dfx_reg(struct hclge_dev *hdev, void *data)
 		if (ret) {
 			dev_err(&hdev->pdev->dev,
 				"Get dfx reg fail, status is %d.\n", ret);
-			break;
+			goto free;
 		}
 
 		reg += hclge_reg_get_tlv(HCLGE_REG_TAG_DFX_BIOS_COMMON + i,
@@ -437,6 +493,14 @@ static int hclge_get_dfx_reg(struct hclge_dev *hdev, void *data)
 		reg += hclge_dfx_reg_fetch_data(desc_src, bd_num, reg);
 	}
 
+	/**
+	 * HCLGE_DFX_BD_OFFSET is starting at 1, but the array subscript is
+	 * starting at 0, so offset need '- 1'.
+	 */
+	bd_num = bd_num_list[HCLGE_DFX_RPU_0_BD_OFFSET - 1];
+	ret = hclge_get_dfx_rpu_tnl_reg(hdev, reg, desc_src, bd_num);
+
+free:
 	kfree(desc_src);
 out:
 	kfree(bd_num_list);
-- 
2.30.0

