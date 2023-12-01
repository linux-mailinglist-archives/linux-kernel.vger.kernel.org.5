Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6F8800231
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 04:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377289AbjLADpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 22:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377225AbjLADpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 22:45:34 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C331210D7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 19:45:39 -0800 (PST)
Received: from kwepemm000004.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ShJkk3SLlzNmP2;
        Fri,  1 Dec 2023 11:41:18 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm000004.china.huawei.com (7.193.23.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Dec 2023 11:45:37 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <xuwei5@hisilicon.com>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Jonathan.Cameron@Huawei.com>, <arnd@arndb.de>, <krzk@kernel.org>,
        <sudeep.holla@arm.com>, <liuyonglong@huawei.com>,
        <lihuisong@huawei.com>
Subject: [PATCH v3 5/5] soc: hisilicon: kunpeng_hccs: Support the platform with PCC type3 and interrupt ack
Date:   Fri, 1 Dec 2023 11:45:34 +0800
Message-ID: <20231201034534.7276-6-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231201034534.7276-1-lihuisong@huawei.com>
References: <20231109054526.27270-1-lihuisong@huawei.com>
 <20231201034534.7276-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000004.china.huawei.com (7.193.23.18)
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

Support the platform with PCC type3 and interrupt ack. And a version
specific structure is introduced to handle the difference between the
device in the code.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/soc/hisilicon/kunpeng_hccs.c | 135 ++++++++++++++++++++++-----
 drivers/soc/hisilicon/kunpeng_hccs.h |  15 +++
 2 files changed, 125 insertions(+), 25 deletions(-)

diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index 15125f1e0f3e..9ff70b38e5e9 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -110,6 +110,14 @@ static void hccs_chan_tx_done(struct mbox_client *cl, void *msg, int ret)
 			 *(u8 *)msg, ret);
 }
 
+static void hccs_pcc_rx_callback(struct mbox_client *cl, void *mssg)
+{
+	struct hccs_mbox_client_info *cl_info =
+			container_of(cl, struct hccs_mbox_client_info, client);
+
+	complete(&cl_info->done);
+}
+
 static void hccs_unregister_pcc_channel(struct hccs_dev *hdev)
 {
 	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
@@ -131,6 +139,9 @@ static int hccs_register_pcc_channel(struct hccs_dev *hdev)
 	cl->tx_block = false;
 	cl->knows_txdone = true;
 	cl->tx_done = hccs_chan_tx_done;
+	cl->rx_callback = hdev->verspec_data->rx_callback;
+	init_completion(&cl_info->done);
+
 	pcc_chan = pcc_mbox_request_channel(cl, hdev->chan_id);
 	if (IS_ERR(pcc_chan)) {
 		dev_err(dev, "PPC channel request failed.\n");
@@ -147,10 +158,16 @@ static int hccs_register_pcc_channel(struct hccs_dev *hdev)
 	 */
 	cl_info->deadline_us =
 			HCCS_PCC_CMD_WAIT_RETRIES_NUM * pcc_chan->latency;
-	if (cl_info->mbox_chan->mbox->txdone_irq) {
+	if (!hdev->verspec_data->has_txdone_irq &&
+	    cl_info->mbox_chan->mbox->txdone_irq) {
 		dev_err(dev, "PCC IRQ in PCCT is enabled.\n");
 		rc = -EINVAL;
 		goto err_mbx_channel_free;
+	} else if (hdev->verspec_data->has_txdone_irq &&
+		   !cl_info->mbox_chan->mbox->txdone_irq) {
+		dev_err(dev, "PCC IRQ in PCCT isn't supported.\n");
+		rc = -EINVAL;
+		goto err_mbx_channel_free;
 	}
 
 	if (pcc_chan->shmem_base_addr) {
@@ -172,7 +189,7 @@ static int hccs_register_pcc_channel(struct hccs_dev *hdev)
 	return rc;
 }
 
-static int hccs_check_chan_cmd_complete(struct hccs_dev *hdev)
+static int hccs_wait_cmd_complete_by_poll(struct hccs_dev *hdev)
 {
 	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
 	struct acpi_pcct_shared_memory __iomem *comm_base =
@@ -194,30 +211,74 @@ static int hccs_check_chan_cmd_complete(struct hccs_dev *hdev)
 	return ret;
 }
 
+static int hccs_wait_cmd_complete_by_irq(struct hccs_dev *hdev)
+{
+	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
+
+	if (!wait_for_completion_timeout(&cl_info->done,
+			usecs_to_jiffies(cl_info->deadline_us))) {
+		dev_err(hdev->dev, "PCC command executed timeout!\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static inline void hccs_fill_pcc_shared_mem_region(struct hccs_dev *hdev,
+						   u8 cmd,
+						   struct hccs_desc *desc,
+						   void __iomem *comm_space,
+						   u16 space_size)
+{
+	struct acpi_pcct_shared_memory tmp = {
+		.signature = PCC_SIGNATURE | hdev->chan_id,
+		.command = cmd,
+		.status = 0,
+	};
+
+	memcpy_toio(hdev->cl_info.pcc_comm_addr, (void *)&tmp,
+		    sizeof(struct acpi_pcct_shared_memory));
+
+	/* Copy the message to the PCC comm space */
+	memcpy_toio(comm_space, (void *)desc, space_size);
+}
+
+static inline void hccs_fill_ext_pcc_shared_mem_region(struct hccs_dev *hdev,
+						       u8 cmd,
+						       struct hccs_desc *desc,
+						       void __iomem *comm_space,
+						       u16 space_size)
+{
+	struct acpi_pcct_ext_pcc_shared_memory tmp = {
+		.signature = PCC_SIGNATURE | hdev->chan_id,
+		.flags = PCC_CMD_COMPLETION_NOTIFY,
+		.length = HCCS_PCC_SHARE_MEM_BYTES,
+		.command = cmd,
+	};
+
+	memcpy_toio(hdev->cl_info.pcc_comm_addr, (void *)&tmp,
+		    sizeof(struct acpi_pcct_ext_pcc_shared_memory));
+
+	/* Copy the message to the PCC comm space */
+	memcpy_toio(comm_space, (void *)desc, space_size);
+}
+
 static int hccs_pcc_cmd_send(struct hccs_dev *hdev, u8 cmd,
 			     struct hccs_desc *desc)
 {
+	const struct hccs_verspecific_data *verspec_data = hdev->verspec_data;
 	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
-	void __iomem *comm_space = cl_info->pcc_comm_addr +
-					sizeof(struct acpi_pcct_shared_memory);
 	struct hccs_fw_inner_head *fw_inner_head;
-	struct acpi_pcct_shared_memory tmp = {0};
-	u16 comm_space_size;
+	void __iomem *comm_space;
+	u16 space_size;
 	int ret;
 
-	/* Write signature for this subspace */
-	tmp.signature = PCC_SIGNATURE | hdev->chan_id;
-	/* Write to the shared command region */
-	tmp.command = cmd;
-	/* Clear cmd complete bit */
-	tmp.status = 0;
-	memcpy_toio(cl_info->pcc_comm_addr, (void *)&tmp,
-			sizeof(struct acpi_pcct_shared_memory));
-
-	/* Copy the message to the PCC comm space */
-	comm_space_size = HCCS_PCC_SHARE_MEM_BYTES -
-				sizeof(struct acpi_pcct_shared_memory);
-	memcpy_toio(comm_space, (void *)desc, comm_space_size);
+	comm_space = cl_info->pcc_comm_addr + verspec_data->shared_mem_size;
+	space_size = HCCS_PCC_SHARE_MEM_BYTES - verspec_data->shared_mem_size;
+	verspec_data->fill_pcc_shared_mem(hdev, cmd, desc,
+					  comm_space, space_size);
+	if (verspec_data->has_txdone_irq)
+		reinit_completion(&cl_info->done);
 
 	/* Ring doorbell */
 	ret = mbox_send_message(cl_info->mbox_chan, &cmd);
@@ -227,13 +288,12 @@ static int hccs_pcc_cmd_send(struct hccs_dev *hdev, u8 cmd,
 		goto end;
 	}
 
-	/* Wait for completion */
-	ret = hccs_check_chan_cmd_complete(hdev);
+	ret = verspec_data->wait_cmd_complete(hdev);
 	if (ret)
 		goto end;
 
 	/* Copy response data */
-	memcpy_fromio((void *)desc, comm_space, comm_space_size);
+	memcpy_fromio((void *)desc, comm_space, space_size);
 	fw_inner_head = &desc->rsp.fw_inner_head;
 	if (fw_inner_head->retStatus) {
 		dev_err(hdev->dev, "Execute PCC command failed, error code = %u.\n",
@@ -242,7 +302,10 @@ static int hccs_pcc_cmd_send(struct hccs_dev *hdev, u8 cmd,
 	}
 
 end:
-	mbox_client_txdone(cl_info->mbox_chan, ret);
+	if (verspec_data->has_txdone_irq)
+		mbox_chan_txdone(cl_info->mbox_chan, ret);
+	else
+		mbox_client_txdone(cl_info->mbox_chan, ret);
 	return ret;
 }
 
@@ -1213,6 +1276,11 @@ static int hccs_probe(struct platform_device *pdev)
 	hdev->dev = &pdev->dev;
 	platform_set_drvdata(pdev, hdev);
 
+	/*
+	 * Here would never be failure as the driver and device has been matched.
+	 */
+	hdev->verspec_data = acpi_device_get_match_data(hdev->dev);
+
 	mutex_init(&hdev->lock);
 	rc = hccs_get_pcc_chan_id(hdev);
 	if (rc)
@@ -1249,9 +1317,26 @@ static void hccs_remove(struct platform_device *pdev)
 	hccs_unregister_pcc_channel(hdev);
 }
 
+static const struct hccs_verspecific_data hisi04b1_verspec_data = {
+	.rx_callback = NULL,
+	.wait_cmd_complete = hccs_wait_cmd_complete_by_poll,
+	.fill_pcc_shared_mem = hccs_fill_pcc_shared_mem_region,
+	.shared_mem_size = sizeof(struct acpi_pcct_shared_memory),
+	.has_txdone_irq = false,
+};
+
+static const struct hccs_verspecific_data hisi04b2_verspec_data = {
+	.rx_callback = hccs_pcc_rx_callback,
+	.wait_cmd_complete = hccs_wait_cmd_complete_by_irq,
+	.fill_pcc_shared_mem = hccs_fill_ext_pcc_shared_mem_region,
+	.shared_mem_size = sizeof(struct acpi_pcct_ext_pcc_shared_memory),
+	.has_txdone_irq = true,
+};
+
 static const struct acpi_device_id hccs_acpi_match[] = {
-	{ "HISI04B1"},
-	{ ""},
+	{ "HISI04B1", (unsigned long)&hisi04b1_verspec_data},
+	{ "HISI04B2", (unsigned long)&hisi04b2_verspec_data},
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, hccs_acpi_match);
 
diff --git a/drivers/soc/hisilicon/kunpeng_hccs.h b/drivers/soc/hisilicon/kunpeng_hccs.h
index 6012d2776028..c3adbc01b471 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.h
+++ b/drivers/soc/hisilicon/kunpeng_hccs.h
@@ -51,11 +51,26 @@ struct hccs_mbox_client_info {
 	struct pcc_mbox_chan *pcc_chan;
 	u64 deadline_us;
 	void __iomem *pcc_comm_addr;
+	struct completion done;
+};
+
+struct hccs_desc;
+
+struct hccs_verspecific_data {
+	void (*rx_callback)(struct mbox_client *cl, void *mssg);
+	int (*wait_cmd_complete)(struct hccs_dev *hdev);
+	void (*fill_pcc_shared_mem)(struct hccs_dev *hdev,
+				    u8 cmd, struct hccs_desc *desc,
+				    void __iomem *comm_space,
+				    u16 space_size);
+	u16 shared_mem_size;
+	bool has_txdone_irq;
 };
 
 struct hccs_dev {
 	struct device *dev;
 	struct acpi_device *acpi_dev;
+	const struct hccs_verspecific_data *verspec_data;
 	u64 caps;
 	u8 chip_num;
 	struct hccs_chip_info *chips;
-- 
2.33.0

