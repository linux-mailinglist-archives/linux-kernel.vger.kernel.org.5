Return-Path: <linux-kernel+bounces-139045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C3589FDC8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF34728D20B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEC817F365;
	Wed, 10 Apr 2024 17:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qS1g22zp"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C20317B51C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768918; cv=fail; b=AfvVHxdoKBIHZMIjw0D+jwwCbGT8HJakMGSVSxulkHbqzu+S2GH3mjaFg1L47aqvPFU/bjLMoLONfWmR4GOeY1ntVELuWOyQRKLsWBmBZa9XWDIRGRfSKzAQDqfdYzybVNipsXvE7wSPaSVQbYNsLcEdU9Wurg7hQbaQpuaYiPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768918; c=relaxed/simple;
	bh=YK95JFKVKO5k43j777bVx5SpR5H11+pa8fNZmGZcN4w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5Yva+TxXM25aMNU7qFXpPuTVPvzZwgE8AuiJLQWJpVzK1NTivvQyLInv96Txy/0UsltGLjMMdWFy1R86oVR+1Pxmu5qnknqofkwgrwSvzbZinGO5HXPDdYkFCWpM8qEHmgZPlrtVwJxWPoGT6muPQisAZbNyOK7bMA8BaYbk6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qS1g22zp; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSCFCW+L2ecLlJ5oeAzDMwwgBCEhpnMsrZFQxFuid3kcB4KNymRMAIOGszB0y88P/S9MjMZwqWyhL60nMdj7Cnj5ipvapNXR4Q/b9I6LTDr4CLyZ4u6qvfxArRjIk//q7M1IUunjzreJKFzHO76lkNOOcADfkty7Sbbg65y/csimH8a2yGUGcwPrHKaJeyMDVpW8W+VWvWlGINN4tnhRK9jFH/aoUqtcT83sxeH0WkeKc3aFAi3u/D9eiSNYBGPTFUFL0gTQ2gpJuVSDxwakPRDAI/LT72f7tUjGzkFVkdir71e/s5Ave/yFWlO0PmsUgTcGHRYqtQ26SriOIiRe/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2U9KxhEuOPUx29dgjnUhwx6UpGhQeu4UBiizLPwMITs=;
 b=XQsGkikWEdJrbmub8kWzydea0ffDYKJnGrkIm04RZ9e74YV6q/KGTR5BC3h4nXQimdLeQockWjUnQQyi/GYU3HMfgczkkL8MYR4aJaM0/6bjXn6R6axFNciRIiXVCTrurSPEVfiiJ3COhKv//Qu6XaxMUUM7x2LGQX9/aXu1qa7ajIWv5OpcnxUHY0L/vtaiGxn2kXlfAQ2yRwACNUychavLGmAb7g/5VGZP7HmFWYiHsnyroiEIgkuLdexU1m8S6sACm6h4cm+16vPneSBRU2vz9IjCUuhiTmlzYG4e4Dv6BbkZaAVUiCaL9inzzC/CdJK0Mj2em3lUrdDd08fWAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2U9KxhEuOPUx29dgjnUhwx6UpGhQeu4UBiizLPwMITs=;
 b=qS1g22zp/GHJt+kVDEc38YzfsRg/ocAWg/xiGCKbKDQL+/WmB259yH+J9+jXckx6HGcG7zDEiBwoMkiTYkUqT7nH66P+IWKz9wHyi5AUE5DTYtzu+VDjBMrfX6w8RFdnVrNyPqRB4C47puIuTiQEs5K4Dvheb3BA/ayi7Fddl28=
Received: from MN2PR14CA0013.namprd14.prod.outlook.com (2603:10b6:208:23e::18)
 by DS7PR12MB8275.namprd12.prod.outlook.com (2603:10b6:8:ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 17:08:32 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::f7) by MN2PR14CA0013.outlook.office365.com
 (2603:10b6:208:23e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.34 via Frontend
 Transport; Wed, 10 Apr 2024 17:08:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 17:08:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 12:08:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 12:08:28 -0500
Received: from xsjblevinsk50.xilinx.com (172.19.2.206) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 10 Apr 2024 12:08:28 -0500
From: Ben Levinsky <ben.levinsky@amd.com>
To: <jassisinghbrar@gmail.com>, <michal.simek@amd.com>,
	<shubhrajyoti.datta@amd.com>, <tanmay.shah@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 3/3] mailbox: zynqmp: Enable Bufferless IPI usage on Versal-based SOC's
Date: Wed, 10 Apr 2024 10:08:25 -0700
Message-ID: <20240410170825.1132324-4-ben.levinsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410170825.1132324-1-ben.levinsky@amd.com>
References: <20240410170825.1132324-1-ben.levinsky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ben.levinsky@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|DS7PR12MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: 424fefad-df0b-435c-3f87-08dc5980d9be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZcxS2boPYhC+Qs4ZivdJMiMiukwOX9FL7mJ9ufIBPatbmBiKQwjwqCsZ94/Qp/9M7Cjjm/9IHRmoHsWqzK6Vn7vYiOibVUtzCsqh7TjOdrk54P7SzQMX91DDllsFWOX8elYHaJYL04T8p3Q5e/ax8CNbmYeEJO2TMt+V14yMESRey5hPP7Y4BpWpTXtw/iloIUXwwdjJc7GCr7EgLE71m13FsekaVpzANGsM2bFSKlBgEmxIr0cEZoTA3OaYx1VkhQFuGMf3rHMtCS09dtAbkC/KakeE0vffB6w2PYGxzSALMf+m6Zye4ZGsB2TGIHwYEV8GxlZs/ajqVPiJP18/j/F/2YON75E2YMr5JiQkvDSCD/96MXhveM5sKAhopQINVgsmbO3oJcDzzeRocmMmvmMitREho+D5Vv8I3hVZON78k7otuavXMVmNYS3qvcYp1fayW0LFwUzukBT3HJfTrzihS9Nvty1skSb4Z6BiUGD9dZ7dco/NtLE8Pud+sGOqDvOoVaRrVCCrznARgNDipoiuowOZEiCaNtVQ9yac8zTE/jFv1bKoqn6mGBnaKfCqeT4TkUu3lqeJEhDAKpW++pfdkkIlsf+91S3rMALiEi63iu9QxvQkeGUN2hvjhxbr82wQv3Hz1WesKvGVlZp11pmWMYj6YPy4b8LU4JhRKkLLk404RxrHrdXcDiDZsYaoqJgusL9S+5wmmeQBiIBULdB4gUp5BYSUxhFVW49xXGysuR3dOkg5XYSoeX4ubzkh
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 17:08:32.1390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 424fefad-df0b-435c-3f87-08dc5980d9be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8275

On Xilinx-AMD Versal and Versal-NET, there exist both
inter-processor-interrupts with corresponding message buffers and without
such buffers.

Add a routine that, if the corresponding DT compatible
string "xlnx,versal-ipi-mailbox" is used then a Versal-based SOC
can use a mailbox Device Tree entry where both host and remote
can use either of the buffered or bufferless interrupts.

Signed-off-by: Ben Levinsky <ben.levinsky@amd.com>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 129 +++++++++++++++++++++++++--
 1 file changed, 122 insertions(+), 7 deletions(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 56ba7135db54..1cb553cced90 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -52,6 +52,13 @@
 #define IPI_MB_CHNL_TX	0 /* IPI mailbox TX channel */
 #define IPI_MB_CHNL_RX	1 /* IPI mailbox RX channel */
 
+/* IPI Message Buffer Information */
+#define RESP_OFFSET	0x20U
+#define DEST_OFFSET	0x40U
+#define IPI_BUF_SIZE	0x20U
+#define DST_BIT_POS	9U
+#define SRC_BITMASK	GENMASK(11, 8)
+
 /**
  * struct zynqmp_ipi_mchan - Description of a Xilinx ZynqMP IPI mailbox channel
  * @is_opened: indicate if the IPI channel is opened
@@ -169,9 +176,11 @@ static irqreturn_t zynqmp_ipi_interrupt(int irq, void *data)
 		if (ret > 0 && ret & IPI_MB_STATUS_RECV_PENDING) {
 			if (mchan->is_opened) {
 				msg = mchan->rx_buf;
-				msg->len = mchan->req_buf_size;
-				memcpy_fromio(msg->data, mchan->req_buf,
-					      msg->len);
+				if (msg) {
+					msg->len = mchan->req_buf_size;
+					memcpy_fromio(msg->data, mchan->req_buf,
+						      msg->len);
+				}
 				mbox_chan_received_data(chan, (void *)msg);
 				status = IRQ_HANDLED;
 			}
@@ -281,26 +290,26 @@ static int zynqmp_ipi_send_data(struct mbox_chan *chan, void *data)
 
 	if (mchan->chan_type == IPI_MB_CHNL_TX) {
 		/* Send request message */
-		if (msg && msg->len > mchan->req_buf_size) {
+		if (msg && msg->len > mchan->req_buf_size && mchan->req_buf) {
 			dev_err(dev, "channel %d message length %u > max %lu\n",
 				mchan->chan_type, (unsigned int)msg->len,
 				mchan->req_buf_size);
 			return -EINVAL;
 		}
-		if (msg && msg->len)
+		if (msg && msg->len && mchan->req_buf)
 			memcpy_toio(mchan->req_buf, msg->data, msg->len);
 		/* Kick IPI mailbox to send message */
 		arg0 = SMC_IPI_MAILBOX_NOTIFY;
 		zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, &res);
 	} else {
 		/* Send response message */
-		if (msg && msg->len > mchan->resp_buf_size) {
+		if (msg && msg->len > mchan->resp_buf_size && mchan->resp_buf) {
 			dev_err(dev, "channel %d message length %u > max %lu\n",
 				mchan->chan_type, (unsigned int)msg->len,
 				mchan->resp_buf_size);
 			return -EINVAL;
 		}
-		if (msg && msg->len)
+		if (msg && msg->len && mchan->resp_buf)
 			memcpy_toio(mchan->resp_buf, msg->data, msg->len);
 		arg0 = SMC_IPI_MAILBOX_ACK;
 		zynqmp_ipi_fw_call(ipi_mbox, arg0, IPI_SMC_ACK_EIRQ_MASK,
@@ -636,6 +645,109 @@ static int zynqmp_ipi_setup(struct zynqmp_ipi_mbox *ipi_mbox,
 	return 0;
 }
 
+/**
+ * versal_ipi_setup - Set up IPIs to support mixed usage of
+ *				 Buffered and Bufferless IPIs.
+ *
+ * @ipi_mbox: pointer to IPI mailbox private data structure
+ * @node: IPI mailbox device node
+ *
+ * Return: 0 for success, negative value for failure
+ */
+static int versal_ipi_setup(struct zynqmp_ipi_mbox *ipi_mbox,
+			    struct device_node *node)
+{
+	struct zynqmp_ipi_mchan *tx_mchan, *rx_mchan;
+	struct resource host_res, remote_res;
+	struct device_node *parent_node;
+	int host_idx, remote_idx;
+	struct device *mdev;
+
+	tx_mchan = &ipi_mbox->mchans[IPI_MB_CHNL_TX];
+	rx_mchan = &ipi_mbox->mchans[IPI_MB_CHNL_RX];
+	parent_node = of_get_parent(node);
+	mdev = &ipi_mbox->dev;
+
+	host_idx = zynqmp_ipi_mbox_get_buf_res(parent_node, "msg", &host_res);
+	remote_idx = zynqmp_ipi_mbox_get_buf_res(node, "msg", &remote_res);
+
+	/*
+	 * Only set up buffers if both sides claim to have msg buffers.
+	 * This is because each buffered IPI's corresponding msg buffers
+	 * are reserved for use by other buffered IPI's.
+	 */
+	if (!host_idx && !remote_idx) {
+		u32 host_src, host_dst, remote_src, remote_dst;
+		u32 buff_sz;
+
+		buff_sz = resource_size(&host_res);
+
+		host_src = host_res.start & SRC_BITMASK;
+		remote_src = remote_res.start & SRC_BITMASK;
+
+		host_dst = (host_src >> DST_BIT_POS) * DEST_OFFSET;
+		remote_dst = (remote_src >> DST_BIT_POS) * DEST_OFFSET;
+
+		/* Validate that IPI IDs is within IPI Message buffer space. */
+		if (host_dst >= buff_sz || remote_dst >= buff_sz) {
+			dev_err(mdev,
+				"Invalid IPI Message buffer values: %x %x\n",
+				host_dst, remote_dst);
+			return -EINVAL;
+		}
+
+		tx_mchan->req_buf = devm_ioremap(mdev,
+						 host_res.start | remote_dst,
+						 IPI_BUF_SIZE);
+		if (!tx_mchan->req_buf) {
+			dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
+			return -ENOMEM;
+		}
+
+		tx_mchan->resp_buf = devm_ioremap(mdev,
+						  (remote_res.start | host_dst) +
+						  RESP_OFFSET, IPI_BUF_SIZE);
+		if (!tx_mchan->resp_buf) {
+			dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
+			return -ENOMEM;
+		}
+
+		rx_mchan->req_buf = devm_ioremap(mdev,
+						 remote_res.start | host_dst,
+						 IPI_BUF_SIZE);
+		if (!rx_mchan->req_buf) {
+			dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
+			return -ENOMEM;
+		}
+
+		rx_mchan->resp_buf = devm_ioremap(mdev,
+						  (host_res.start | remote_dst) +
+						  RESP_OFFSET, IPI_BUF_SIZE);
+		if (!rx_mchan->resp_buf) {
+			dev_err(mdev, "Unable to map IPI buffer I/O memory\n");
+			return -ENOMEM;
+		}
+
+		tx_mchan->resp_buf_size = IPI_BUF_SIZE;
+		tx_mchan->req_buf_size = IPI_BUF_SIZE;
+		tx_mchan->rx_buf = devm_kzalloc(mdev, IPI_BUF_SIZE +
+						sizeof(struct zynqmp_ipi_message),
+						GFP_KERNEL);
+		if (!tx_mchan->rx_buf)
+			return -ENOMEM;
+
+		rx_mchan->resp_buf_size = IPI_BUF_SIZE;
+		rx_mchan->req_buf_size = IPI_BUF_SIZE;
+		rx_mchan->rx_buf = devm_kzalloc(mdev, IPI_BUF_SIZE +
+						sizeof(struct zynqmp_ipi_message),
+						GFP_KERNEL);
+		if (!rx_mchan->rx_buf)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
 /**
  * zynqmp_ipi_free_mboxes - Free IPI mailboxes devices
  *
@@ -743,6 +855,9 @@ static const struct of_device_id zynqmp_ipi_of_match[] = {
 	{ .compatible = "xlnx,zynqmp-ipi-mailbox",
 	  .data = &zynqmp_ipi_setup,
 	},
+	{ .compatible = "xlnx,versal-ipi-mailbox",
+	  .data = &versal_ipi_setup,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, zynqmp_ipi_of_match);
-- 
2.25.1


