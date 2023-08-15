Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA9777CD04
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237281AbjHOM4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237150AbjHOMzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:55:31 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21669C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 05:55:27 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RQB4Y0Q1tzFqdL;
        Tue, 15 Aug 2023 20:52:29 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 20:55:25 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <xuwei5@hisilicon.com>, <arnd@arndb.de>, <arnd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <liuyonglong@huawei.com>,
        <lihuisong@huawei.com>
Subject: [PATCH] soc: kunpeng_hccs: fix some sparse warnings about incorrect type
Date:   Tue, 15 Aug 2023 20:52:33 +0800
Message-ID: <20230815125233.65469-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some sparse warnings about incorrect type.
The address about PCC communication space should use '__iomem' tag.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308151142.dH5Muhva-lkp@intel.com/
Fixes: 886bdf9c883b ("soc: hisilicon: Support HCCS driver on Kunpeng SoC")
Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/soc/hisilicon/kunpeng_hccs.c | 13 +++++++------
 drivers/soc/hisilicon/kunpeng_hccs.h |  2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index 0d6f6bacd3f6..4e94753ab0f7 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -156,8 +156,8 @@ static int hccs_register_pcc_channel(struct hccs_dev *hdev)
 	}
 
 	if (pcc_chan->shmem_base_addr) {
-		cl_info->pcc_comm_addr = (void __force *)ioremap(
-			pcc_chan->shmem_base_addr, pcc_chan->shmem_size);
+		cl_info->pcc_comm_addr = ioremap(pcc_chan->shmem_base_addr,
+						 pcc_chan->shmem_size);
 		if (!cl_info->pcc_comm_addr) {
 			dev_err(dev, "Failed to ioremap PCC communication region for channel-%d.\n",
 				hdev->chan_id);
@@ -177,7 +177,8 @@ static int hccs_register_pcc_channel(struct hccs_dev *hdev)
 static int hccs_check_chan_cmd_complete(struct hccs_dev *hdev)
 {
 	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
-	struct acpi_pcct_shared_memory *comm_base = cl_info->pcc_comm_addr;
+	struct acpi_pcct_shared_memory __iomem *comm_base =
+							cl_info->pcc_comm_addr;
 	u16 status;
 	int ret;
 
@@ -199,8 +200,8 @@ static int hccs_pcc_cmd_send(struct hccs_dev *hdev, u8 cmd,
 			     struct hccs_desc *desc)
 {
 	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
-	struct acpi_pcct_shared_memory *comm_base = cl_info->pcc_comm_addr;
-	void *comm_space = (void *)(comm_base + 1);
+	void __iomem *comm_space = (u8 *)cl_info->pcc_comm_addr +
+					sizeof(struct acpi_pcct_shared_memory);
 	struct hccs_fw_inner_head *fw_inner_head;
 	struct acpi_pcct_shared_memory tmp = {0};
 	u16 comm_space_size;
@@ -212,7 +213,7 @@ static int hccs_pcc_cmd_send(struct hccs_dev *hdev, u8 cmd,
 	tmp.command = cmd;
 	/* Clear cmd complete bit */
 	tmp.status = 0;
-	memcpy_toio(comm_base, (void *)&tmp,
+	memcpy_toio(cl_info->pcc_comm_addr, (void *)&tmp,
 			sizeof(struct acpi_pcct_shared_memory));
 
 	/* Copy the message to the PCC comm space */
diff --git a/drivers/soc/hisilicon/kunpeng_hccs.h b/drivers/soc/hisilicon/kunpeng_hccs.h
index 9d71fb78443f..6012d2776028 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.h
+++ b/drivers/soc/hisilicon/kunpeng_hccs.h
@@ -50,7 +50,7 @@ struct hccs_mbox_client_info {
 	struct mbox_chan *mbox_chan;
 	struct pcc_mbox_chan *pcc_chan;
 	u64 deadline_us;
-	void *pcc_comm_addr;
+	void __iomem *pcc_comm_addr;
 };
 
 struct hccs_dev {
-- 
2.33.0

