Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7901F77C78A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjHOGMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbjHOGLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:11:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BCE1BDA;
        Mon, 14 Aug 2023 23:11:52 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQ1666zywztRv2;
        Tue, 15 Aug 2023 14:08:14 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 14:11:49 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <shaojijie@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 3/4] net: hns3: Support tlv in regs data for HNS3 VF driver
Date:   Tue, 15 Aug 2023 14:06:40 +0800
Message-ID: <20230815060641.3551665-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230815060641.3551665-1-shaojijie@huawei.com>
References: <20230815060641.3551665-1-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dump register function is being refactored.
The third step in refactoring is to support tlv info in regs data for
HNS3 PF driver.

Currently, if we use "ethtool -d" to dump regs value,
the output is as follows:
  offset1: 00 01 02 03 04 05 ...
  offset2：10 11 12 13 14 15 ...
  ......

We can't get the value of a register directly.

This patch deletes the original separator information and
add tag_len_value information in regs data.
ethtool can parse register data in key-value format by -d command.

a patch will be added to the ethtool to parse regs data
in the following format:
  reg1 : value2
  reg2 : value2
  ......

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../hisilicon/hns3/hns3vf/hclgevf_regs.c      | 85 +++++++++++++------
 1 file changed, 61 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c
index 197ab733306b..65b9dcd38137 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c
@@ -57,23 +57,67 @@ static const u32 tqp_intr_reg_addr_list[] = {HCLGEVF_TQP_INTR_CTRL_REG,
 					     HCLGEVF_TQP_INTR_GL2_REG,
 					     HCLGEVF_TQP_INTR_RL_REG};
 
-#define MAX_SEPARATE_NUM	4
-#define SEPARATOR_VALUE		0xFDFCFBFA
-#define REG_NUM_PER_LINE	4
-#define REG_LEN_PER_LINE	(REG_NUM_PER_LINE * sizeof(u32))
+enum hclgevf_reg_tag {
+	HCLGEVF_REG_TAG_CMDQ = 0,
+	HCLGEVF_REG_TAG_COMMON,
+	HCLGEVF_REG_TAG_RING,
+	HCLGEVF_REG_TAG_TQP_INTR,
+};
+
+#pragma pack(4)
+struct hclgevf_reg_tlv {
+	u16 tag;
+	u16 len;
+};
+
+struct hclgevf_reg_header {
+	u64 magic_number;
+	u8 is_vf;
+	u8 rsv[7];
+};
+
+#pragma pack()
+
+#define HCLGEVF_REG_TLV_SIZE		sizeof(struct hclgevf_reg_tlv)
+#define HCLGEVF_REG_HEADER_SIZE		sizeof(struct hclgevf_reg_header)
+#define HCLGEVF_REG_TLV_SPACE		(sizeof(struct hclgevf_reg_tlv) / sizeof(u32))
+#define HCLGEVF_REG_HEADER_SPACE	(sizeof(struct hclgevf_reg_header) / sizeof(u32))
+#define HCLGEVF_REG_MAGIC_NUMBER	0x686e733372656773 /* meaning is hns3regs */
+
+static u32 hclgevf_reg_get_header(void *data)
+{
+	struct hclgevf_reg_header *header = data;
+
+	header->magic_number = HCLGEVF_REG_MAGIC_NUMBER;
+	header->is_vf = 0x1;
+
+	return HCLGEVF_REG_HEADER_SPACE;
+}
+
+static u32 hclgevf_reg_get_tlv(u32 tag, u32 regs_num, void *data)
+{
+	struct hclgevf_reg_tlv *tlv = data;
+
+	tlv->tag = tag;
+	tlv->len = regs_num * sizeof(u32) + HCLGEVF_REG_TLV_SIZE;
+
+	return HCLGEVF_REG_TLV_SPACE;
+}
 
 int hclgevf_get_regs_len(struct hnae3_handle *handle)
 {
-	int cmdq_lines, common_lines, ring_lines, tqp_intr_lines;
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
+	int cmdq_len, common_len, ring_len, tqp_intr_len;
 
-	cmdq_lines = sizeof(cmdq_reg_addr_list) / REG_LEN_PER_LINE + 1;
-	common_lines = sizeof(common_reg_addr_list) / REG_LEN_PER_LINE + 1;
-	ring_lines = sizeof(ring_reg_addr_list) / REG_LEN_PER_LINE + 1;
-	tqp_intr_lines = sizeof(tqp_intr_reg_addr_list) / REG_LEN_PER_LINE + 1;
+	cmdq_len = HCLGEVF_REG_TLV_SIZE + sizeof(cmdq_reg_addr_list);
+	common_len = HCLGEVF_REG_TLV_SIZE + sizeof(common_reg_addr_list);
+	ring_len = HCLGEVF_REG_TLV_SIZE + sizeof(ring_reg_addr_list);
+	tqp_intr_len = HCLGEVF_REG_TLV_SIZE + sizeof(tqp_intr_reg_addr_list);
 
-	return (cmdq_lines + common_lines + ring_lines * hdev->num_tqps +
-		tqp_intr_lines * (hdev->num_msi_used - 1)) * REG_LEN_PER_LINE;
+	/* return the total length of all register values */
+	return HCLGEVF_REG_HEADER_SIZE + cmdq_len + common_len +
+	       tqp_intr_len * (hdev->num_msi_used - 1) +
+	       ring_len * hdev->num_tqps;
 }
 
 void hclgevf_get_regs(struct hnae3_handle *handle, u32 *version,
@@ -83,45 +127,38 @@ void hclgevf_get_regs(struct hnae3_handle *handle, u32 *version,
 #define HCLGEVF_RING_INT_REG_OFFSET	0x4
 
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
-	int i, j, reg_um, separator_num;
+	int i, j, reg_um;
 	u32 *reg = data;
 
 	*version = hdev->fw_version;
+	reg += hclgevf_reg_get_header(reg);
 
 	/* fetching per-VF registers values from VF PCIe register space */
 	reg_um = sizeof(cmdq_reg_addr_list) / sizeof(u32);
-	separator_num = MAX_SEPARATE_NUM - reg_um % REG_NUM_PER_LINE;
+	reg += hclgevf_reg_get_tlv(HCLGEVF_REG_TAG_CMDQ, reg_um, reg);
 	for (i = 0; i < reg_um; i++)
 		*reg++ = hclgevf_read_dev(&hdev->hw, cmdq_reg_addr_list[i]);
-	for (i = 0; i < separator_num; i++)
-		*reg++ = SEPARATOR_VALUE;
 
 	reg_um = sizeof(common_reg_addr_list) / sizeof(u32);
-	separator_num = MAX_SEPARATE_NUM - reg_um % REG_NUM_PER_LINE;
+	reg += hclgevf_reg_get_tlv(HCLGEVF_REG_TAG_COMMON, reg_um, reg);
 	for (i = 0; i < reg_um; i++)
 		*reg++ = hclgevf_read_dev(&hdev->hw, common_reg_addr_list[i]);
-	for (i = 0; i < separator_num; i++)
-		*reg++ = SEPARATOR_VALUE;
 
 	reg_um = sizeof(ring_reg_addr_list) / sizeof(u32);
-	separator_num = MAX_SEPARATE_NUM - reg_um % REG_NUM_PER_LINE;
 	for (j = 0; j < hdev->num_tqps; j++) {
+		reg += hclgevf_reg_get_tlv(HCLGEVF_REG_TAG_RING, reg_um, reg);
 		for (i = 0; i < reg_um; i++)
 			*reg++ = hclgevf_read_dev(&hdev->hw,
 						  ring_reg_addr_list[i] +
 						  HCLGEVF_RING_REG_OFFSET * j);
-		for (i = 0; i < separator_num; i++)
-			*reg++ = SEPARATOR_VALUE;
 	}
 
 	reg_um = sizeof(tqp_intr_reg_addr_list) / sizeof(u32);
-	separator_num = MAX_SEPARATE_NUM - reg_um % REG_NUM_PER_LINE;
 	for (j = 0; j < hdev->num_msi_used - 1; j++) {
+		reg += hclgevf_reg_get_tlv(HCLGEVF_REG_TAG_TQP_INTR, reg_um, reg);
 		for (i = 0; i < reg_um; i++)
 			*reg++ = hclgevf_read_dev(&hdev->hw,
 						  tqp_intr_reg_addr_list[i] +
 						  HCLGEVF_RING_INT_REG_OFFSET * j);
-		for (i = 0; i < separator_num; i++)
-			*reg++ = SEPARATOR_VALUE;
 	}
 }
-- 
2.30.0

