Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FC67E635F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 06:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjKIFqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 00:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjKIFp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 00:45:57 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CC62718
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 21:45:49 -0800 (PST)
Received: from kwepemm000004.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SQrSq1Qmtz1P88y;
        Thu,  9 Nov 2023 13:42:35 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm000004.china.huawei.com (7.193.23.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 9 Nov 2023 13:45:11 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <xuwei5@hisilicon.com>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <arnd@arndb.de>,
        <krzk@kernel.org>, <sudeep.holla@arm.com>,
        <liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 3/3] soc: hisilicon: kunpeng_hccs: Support the platform with PCC type3 and interrupt ack
Date:   Thu, 9 Nov 2023 13:45:26 +0800
Message-ID: <20231109054526.27270-4-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231109054526.27270-1-lihuisong@huawei.com>
References: <20231109054526.27270-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000004.china.huawei.com (7.193.23.18)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support the platform with PCC type3 and interrupt ack.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/soc/hisilicon/kunpeng_hccs.c | 137 +++++++++++++++++++++------
 drivers/soc/hisilicon/kunpeng_hccs.h |   2 +
 2 files changed, 110 insertions(+), 29 deletions(-)

diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index fd3ca0eb8175..96cdac7be244 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -38,6 +38,11 @@
 #define HCCS_PCC_CMD_WAIT_RETRIES_NUM		500ULL
 #define HCCS_POLL_STATUS_TIME_INTERVAL_US	3
 
+enum hccs_hw_device_version {
+	HCCS_HW_DEVICE_V1 = 0,
+	HCCS_HW_DEVICE_V2 = 1,
+};
+
 static struct hccs_port_info *kobj_to_port_info(struct kobject *k)
 {
 	return container_of(k, struct hccs_port_info, kobj);
@@ -100,6 +105,21 @@ static int hccs_get_pcc_chan_id(struct hccs_dev *hdev)
 	return 0;
 }
 
+static int hccs_get_device_version(struct hccs_dev *hdev)
+{
+	const struct acpi_device_id *acpi_id;
+
+	acpi_id = acpi_match_device(hdev->dev->driver->acpi_match_table,
+				    hdev->dev);
+	if (!acpi_id) {
+		dev_err(hdev->dev, "get device version failed.");
+		return -EINVAL;
+	}
+
+	hdev->dev_ver = (u8)acpi_id->driver_data;
+	return 0;
+}
+
 static void hccs_chan_tx_done(struct mbox_client *cl, void *msg, int ret)
 {
 	if (ret < 0)
@@ -110,6 +130,14 @@ static void hccs_chan_tx_done(struct mbox_client *cl, void *msg, int ret)
 			 *(u8 *)msg, ret);
 }
 
+static void hccs_pcc_rx_callback(struct mbox_client *cl, void *m)
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
@@ -131,6 +159,11 @@ static int hccs_register_pcc_channel(struct hccs_dev *hdev)
 	cl->tx_block = false;
 	cl->knows_txdone = true;
 	cl->tx_done = hccs_chan_tx_done;
+	if (hdev->dev_ver == HCCS_HW_DEVICE_V2) {
+		cl->rx_callback = hccs_pcc_rx_callback;
+		init_completion(&cl_info->done);
+	}
+
 	pcc_chan = pcc_mbox_request_channel(cl, hdev->chan_id);
 	if (IS_ERR(pcc_chan)) {
 		dev_err(dev, "PPC channel request failed.\n");
@@ -147,10 +180,16 @@ static int hccs_register_pcc_channel(struct hccs_dev *hdev)
 	 */
 	cl_info->deadline_us =
 			HCCS_PCC_CMD_WAIT_RETRIES_NUM * pcc_chan->latency;
-	if (cl_info->mbox_chan->mbox->txdone_irq) {
+	if (hdev->dev_ver == HCCS_HW_DEVICE_V1 &&
+	    cl_info->mbox_chan->mbox->txdone_irq) {
 		dev_err(dev, "PCC IRQ in PCCT is enabled.\n");
 		rc = -EINVAL;
 		goto err_mbx_channel_free;
+	} else if (hdev->dev_ver == HCCS_HW_DEVICE_V2 &&
+		   !cl_info->mbox_chan->mbox->txdone_irq) {
+		dev_err(dev, "PCC IRQ in PCCT isn't supported.\n");
+		rc = -EINVAL;
+		goto err_mbx_channel_free;
 	}
 
 	if (pcc_chan->shmem_base_addr) {
@@ -175,49 +214,81 @@ static int hccs_register_pcc_channel(struct hccs_dev *hdev)
 static int hccs_check_chan_cmd_complete(struct hccs_dev *hdev)
 {
 	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
-	struct acpi_pcct_shared_memory __iomem *comm_base =
-							cl_info->pcc_comm_addr;
+	struct acpi_pcct_shared_memory __iomem *comm_base;
+	int ret = 0;
 	u16 status;
-	int ret;
 
 	/*
 	 * Poll PCC status register every 3us(delay_us) for maximum of
 	 * deadline_us(timeout_us) until PCC command complete bit is set(cond)
 	 */
-	ret = readw_poll_timeout(&comm_base->status, status,
-				 status & PCC_STATUS_CMD_COMPLETE,
-				 HCCS_POLL_STATUS_TIME_INTERVAL_US,
-				 cl_info->deadline_us);
-	if (unlikely(ret))
-		dev_err(hdev->dev, "poll PCC status failed, ret = %d.\n", ret);
+	if (hdev->dev_ver == HCCS_HW_DEVICE_V1) {
+		comm_base = cl_info->pcc_comm_addr;
+		ret = readw_poll_timeout(&comm_base->status, status,
+					status & PCC_STATUS_CMD_COMPLETE,
+					HCCS_POLL_STATUS_TIME_INTERVAL_US,
+					cl_info->deadline_us);
+		if (unlikely(ret))
+			dev_err(hdev->dev, "poll PCC status failed, ret = %d.\n", ret);
+	} else {
+		if (!wait_for_completion_timeout(&cl_info->done,
+				usecs_to_jiffies(cl_info->deadline_us))) {
+			dev_err(hdev->dev, "PCC command executed timeout!\n");
+			ret = -ETIMEDOUT;
+		}
+	}
 
 	return ret;
 }
 
+static void hccs_fill_pcc_shared_mem_region(struct hccs_dev *hdev, u8 cmd,
+					    struct hccs_desc *desc,
+					    void __iomem *comm_space,
+					    u16 space_size)
+{
+	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
+	struct acpi_pcct_ext_pcc_shared_memory tmp1 = {0};
+	struct acpi_pcct_shared_memory tmp2 = {0};
+
+	if (hdev->dev_ver == HCCS_HW_DEVICE_V1) {
+		tmp2.signature = PCC_SIGNATURE | hdev->chan_id;
+		tmp2.command = cmd;
+		tmp2.status = 0;
+		memcpy_toio(cl_info->pcc_comm_addr, (void *)&tmp2,
+			    sizeof(struct acpi_pcct_shared_memory));
+	} else {
+		tmp1.signature = PCC_SIGNATURE | hdev->chan_id;
+		tmp1.command = cmd;
+		tmp1.flags = PCC_CMD_COMPLETION_NOTIFY;
+		tmp1.length = HCCS_PCC_SHARE_MEM_BYTES;
+		memcpy_toio(cl_info->pcc_comm_addr, (void *)&tmp1,
+			    sizeof(struct acpi_pcct_ext_pcc_shared_memory));
+	}
+
+	/* Copy the message to the PCC comm space */
+	memcpy_toio(comm_space, (void *)desc, space_size);
+}
+
 static int hccs_pcc_cmd_send(struct hccs_dev *hdev, u8 cmd,
 			     struct hccs_desc *desc)
 {
 	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
-	void __iomem *comm_space = cl_info->pcc_comm_addr +
-					sizeof(struct acpi_pcct_shared_memory);
 	struct hccs_fw_inner_head *fw_inner_head;
-	struct acpi_pcct_shared_memory tmp = {0};
-	u16 comm_space_size;
+	void __iomem *comm_space;
+	u16 shared_mem_size;
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
+	shared_mem_size = hdev->dev_ver == HCCS_HW_DEVICE_V1 ?
+			sizeof(struct acpi_pcct_shared_memory) :
+			sizeof(struct acpi_pcct_ext_pcc_shared_memory);
+	comm_space = cl_info->pcc_comm_addr + shared_mem_size;
+	space_size = HCCS_PCC_SHARE_MEM_BYTES - shared_mem_size;
 
-	/* Copy the message to the PCC comm space */
-	comm_space_size = HCCS_PCC_SHARE_MEM_BYTES -
-				sizeof(struct acpi_pcct_shared_memory);
-	memcpy_toio(comm_space, (void *)desc, comm_space_size);
+	hccs_fill_pcc_shared_mem_region(hdev, cmd, desc,
+					comm_space, space_size);
+	if (cl_info->mbox_chan->mbox->txdone_irq)
+		reinit_completion(&cl_info->done);
 
 	/* Ring doorbell */
 	ret = mbox_send_message(cl_info->mbox_chan, &cmd);
@@ -233,7 +304,7 @@ static int hccs_pcc_cmd_send(struct hccs_dev *hdev, u8 cmd,
 		goto end;
 
 	/* Copy response data */
-	memcpy_fromio((void *)desc, comm_space, comm_space_size);
+	memcpy_fromio((void *)desc, comm_space, space_size);
 	fw_inner_head = &desc->rsp.fw_inner_head;
 	if (fw_inner_head->retStatus) {
 		dev_err(hdev->dev, "Execute PCC command failed, error code = %u.\n",
@@ -242,7 +313,10 @@ static int hccs_pcc_cmd_send(struct hccs_dev *hdev, u8 cmd,
 	}
 
 end:
-	mbox_client_txdone(cl_info->mbox_chan, ret);
+	if (cl_info->mbox_chan->mbox->txdone_irq)
+		mbox_chan_txdone(cl_info->mbox_chan, ret);
+	else
+		mbox_client_txdone(cl_info->mbox_chan, ret);
 	return ret;
 }
 
@@ -1214,6 +1288,10 @@ static int hccs_probe(struct platform_device *pdev)
 	hdev->dev = &pdev->dev;
 	platform_set_drvdata(pdev, hdev);
 
+	rc = hccs_get_device_version(hdev);
+	if (rc)
+		return rc;
+
 	mutex_init(&hdev->lock);
 	rc = hccs_get_pcc_chan_id(hdev);
 	if (rc)
@@ -1251,7 +1329,8 @@ static void hccs_remove(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id hccs_acpi_match[] = {
-	{ "HISI04B1"},
+	{ "HISI04B1", HCCS_HW_DEVICE_V1},
+	{ "HISI04B2", HCCS_HW_DEVICE_V2},
 	{ ""},
 };
 MODULE_DEVICE_TABLE(acpi, hccs_acpi_match);
diff --git a/drivers/soc/hisilicon/kunpeng_hccs.h b/drivers/soc/hisilicon/kunpeng_hccs.h
index 6012d2776028..bbb1aada0c6c 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.h
+++ b/drivers/soc/hisilicon/kunpeng_hccs.h
@@ -51,12 +51,14 @@ struct hccs_mbox_client_info {
 	struct pcc_mbox_chan *pcc_chan;
 	u64 deadline_us;
 	void __iomem *pcc_comm_addr;
+	struct completion done;
 };
 
 struct hccs_dev {
 	struct device *dev;
 	struct acpi_device *acpi_dev;
 	u64 caps;
+	u8 dev_ver;
 	u8 chip_num;
 	struct hccs_chip_info *chips;
 	u8 chan_id;
-- 
2.33.0

