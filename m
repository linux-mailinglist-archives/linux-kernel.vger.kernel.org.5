Return-Path: <linux-kernel+bounces-16839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5524F8244BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B581F1F218D6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786B9241E8;
	Thu,  4 Jan 2024 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="afvRIdzV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71B52377B;
	Thu,  4 Jan 2024 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0f7zl1OeYuI4HCgjI2DPhX3da6BzYX6LMJOVXti1Fbl+jlAl7RGwdFKFpD8+ru4Z67uhz0naHe6pxQWwIwQTNRVVS4C8jVTwd9+DvrBVH2oopJcqeHeiL4csMRlWAZqyVtLuHq+/SoMP7mSpomKhbL0NWPxQUr6UxdNC0m7h7JG0yemTmrglbaQl6ypL9QwzN5nRTwTLGg2mc+07KKwRaaP1/XkrFj7JSYHZBSWSirxAJ28InDjd3gTwSuiu1uwNs4bFvp3dJOPp4Po5wPWKJYMwqeVW/hZtR3T54GObesdCSDi+GgnlMjxOU0mtB4q5r9ylajO5gf4USOvkUrUpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8zaYeaWCrMECtZ7WVVH+kKm9nxRtI5sL2A7MmpJ54M=;
 b=l/AiGeNbWWySx8pIloDoirONUS9wiXjq3KbZ3yUXMpMCL/vjbJXrUmu7aD8YkRvt/E6wj1ZZsGCEAnwoWmCmh5nX0MO9F/8e0AtbWCTuvgopRFBTVgYmjlC+TlXlhEKCsQ0hxa0I+8rvEXvLzO5UFuDCUtQbvtBA3kskyG+8ByvqZCVERROuLcVX1dZSAw6WskWsmkr3NLUcxJe1jniajmCpgqfSF49nbeA4g0Z7CQzLZ3P5t36uKNZv0iE2FVjk2ICbNiDQTEPWZiKLK3qE6Iqa1dYLZ19sv52dx/1Moox4GDWEKMEjtf67fhqUwR6TZvk16SkdoJr5Dvp3d83V4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8zaYeaWCrMECtZ7WVVH+kKm9nxRtI5sL2A7MmpJ54M=;
 b=afvRIdzVWTZBdqZFBBA66ScTPWSEAmTXBCrZBPEyUeSRitUlmHqUdaOVLi53K0t9K9zgH1b+RNrHaDL7Oo7MuLfzOwzUsah86DRaCqUUMOXXlnIR3gUOE6+C4y519pcVMv5888RfD7yJeuWr2O0Z06z9vaKeNXxVtc1zYqaAf6XYspl1cZDXMt0abZ0CYXWqKln44z0tQ1/AiOWKGbkff2J7nbP3puIIlcvYgkil0ZryyHbX+k6vFmPWeEUx8xlFrhBhrfNMHUQ+LXAF4Ym0rHQa5R1uE1dLTe2AMmzNCMfaFQ/ywLTHG9KJyJ+QxpE5U9RdK1GE5nBfE6dAj9GS/w==
Received: from SJ0PR03CA0178.namprd03.prod.outlook.com (2603:10b6:a03:338::33)
 by PH0PR12MB8173.namprd12.prod.outlook.com (2603:10b6:510:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 15:14:30 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::b2) by SJ0PR03CA0178.outlook.office365.com
 (2603:10b6:a03:338::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14 via Frontend
 Transport; Thu, 4 Jan 2024 15:14:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 15:14:29 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Jan 2024
 07:14:17 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 4 Jan 2024 07:14:16 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Thu, 4 Jan 2024 07:14:15 -0800
From: Liming Sun <limings@nvidia.com>
To: Vadim Pasternak <vadimp@nvidia.com>, David Thompson
	<davthompson@nvidia.com>, Hans de Goede <hdegoede@redhat.com>, Mark Gross
	<markgross@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
CC: Liming Sun <limings@nvidia.com>, <platform-driver-x86@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/1] Drop Tx network packet when Tx TmFIFO is full
Date: Thu, 4 Jan 2024 10:14:12 -0500
Message-ID: <02fd0faaa555d1914b6ff4bd4b0b294e16989cef.1704381197.git.limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <f250079635da4ba75c3a3a1d7c3820f48cfc3f06.1704380474.git.limings@nvidia.com>
References: <f250079635da4ba75c3a3a1d7c3820f48cfc3f06.1704380474.git.limings@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|PH0PR12MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b24d62-81e0-4639-5725-08dc0d37d95b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KKbFV7tkcMqAGGDAq9jzr5fzSjxH5Z1F8OOVcNeH+NcMwf3RYwrEjTwOdlR7FRANMN+9eelWERtgQqdsvIb3kU3DdB+GRLRZ/J5hbeT8TqWPiMtQaEgvrOYKxjRWhC1oF7SXA/AeV8C1S9Mc9wNtSJknh/JDcuy3RmuMSgHyh2lgldxEEzRngIKpRmYMWwoRA4+QmibnTlCEZXN5fBC+F0kloU6Vnu+pf+8bE+HjdwUapzlY1fnM24Vv7A4yljwbGiLCvxGTigt4wgSrCzN9lkE900IMYvV8UJapY6yFooixNDvoHMNF6IlvrEyvTZtEPgt+veiprmKiHailyNFqZofsb733uRt+tF4/LP87stCThqsDv75c+Na4UM8IsIfa7nQFp4QBivGWkv1cGQ8ZQOPcW8WdXELht007XVSmgoZIbTKmPJQSANq1NcVlHfvxcDexO47x7wHq63JCicKq5xBa5qHiqBizYG3Uu+wBBdyoscXKtJH0FGpUTr3QnhNPRbBBve9pq3/q6kMAHfqDSO5x4uDAjdIVDtYzmzlpsBjfVQ91L+Td36+4cX8+e/0eiomdX/nzbtZmzi98QOrlAdLSuNwDKGvot3oWIBiLuFfb/69QKKPhWxpafumTsmxbkmU/MDTyjEMfA1ld23TSzMZGyxN4gBDAEkTSBwqOKESfiOX3psYWH5iqUJC/YhO3wAvJgsSlv+zMFZFVtDkoYGW4hzU0QNE2DrIC4PpSCnuPWlnuClqicISpULSXarvf51B8MNc0Ok+ytgxvu2qQDrLvMA3Yv4vhm5gCf4dc73+b6aYui3WeHrJ3we50Ct/7
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(230173577357003)(230273577357003)(82310400011)(186009)(64100799003)(1800799012)(451199024)(46966006)(40470700004)(36840700001)(5660300002)(2906002)(8936002)(4326008)(316002)(8676002)(70586007)(70206006)(110136005)(54906003)(426003)(2616005)(336012)(26005)(83380400001)(40480700001)(40460700003)(41300700001)(47076005)(36860700001)(82740400003)(7636003)(356005)(86362001)(36756003)(7696005)(478600001)(6666004)(21314003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 15:14:29.9990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b24d62-81e0-4639-5725-08dc0d37d95b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8173

Starting from Linux 5.16 kernel, Tx timeout mechanism was added
into the virtio_net driver which prints the "Tx timeout" message
when a packet is stuck in Tx queue for too long which could happen
when external host driver is stuck or stopped and failed to read
the FIFO.

Below is an example of the reported message:

"[494105.316739] virtio_net virtio1 tmfifo_net0: TX timeout on
queue: 0, sq: output.0, vq: 0×1, name: output.0, usecs since
last trans: 3079892256".

To avoid such "Tx timeout" messages, this commit adds a timeout
mechanism to drop and release the pending Tx packet if not able to
transmit for two seconds due to Tx FIFO full.

This commit also handles the special case that the packet is half-
transmitted into the Tx FIFO. In such case, the packet is discarded
with remaining length stored in vring->rem_padding. So paddings with
zeros can be sent out when Tx space is available to maintain the
integrity of the packet format. The padded packet will be dropped on
the receiving side.

Signed-off-by: Liming Sun <limings@nvidia.com>
---
 drivers/platform/mellanox/mlxbf-tmfifo.c | 67 ++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 5c683b4eaf10..f39b7b9d2bfe 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -47,6 +47,9 @@
 /* Message with data needs at least two words (for header & data). */
 #define MLXBF_TMFIFO_DATA_MIN_WORDS		2
 
+/* Tx timeout in milliseconds. */
+#define TMFIFO_TX_TIMEOUT			2000
+
 /* ACPI UID for BlueField-3. */
 #define TMFIFO_BF3_UID				1
 
@@ -62,12 +65,14 @@ struct mlxbf_tmfifo;
  * @drop_desc: dummy desc for packet dropping
  * @cur_len: processed length of the current descriptor
  * @rem_len: remaining length of the pending packet
+ * @rem_padding: remaining bytes to send as paddings
  * @pkt_len: total length of the pending packet
  * @next_avail: next avail descriptor id
  * @num: vring size (number of descriptors)
  * @align: vring alignment size
  * @index: vring index
  * @vdev_id: vring virtio id (VIRTIO_ID_xxx)
+ * @tx_timeout: expire time of last tx packet
  * @fifo: pointer to the tmfifo structure
  */
 struct mlxbf_tmfifo_vring {
@@ -79,12 +84,14 @@ struct mlxbf_tmfifo_vring {
 	struct vring_desc drop_desc;
 	int cur_len;
 	int rem_len;
+	int rem_padding;
 	u32 pkt_len;
 	u16 next_avail;
 	int num;
 	int align;
 	int index;
 	int vdev_id;
+	unsigned long tx_timeout;
 	struct mlxbf_tmfifo *fifo;
 };
 
@@ -819,6 +826,50 @@ static bool mlxbf_tmfifo_rxtx_one_desc(struct mlxbf_tmfifo_vring *vring,
 	return true;
 }
 
+static void mlxbf_tmfifo_check_tx_timeout(struct mlxbf_tmfifo_vring *vring)
+{
+	unsigned long flags;
+
+	/* Only handle Tx timeout for network vdev. */
+	if (vring->vdev_id != VIRTIO_ID_NET)
+		return;
+
+	/* Initialize the timeout or return if not expired. */
+	if (!vring->tx_timeout) {
+		/* Initialize the timeout. */
+		vring->tx_timeout = jiffies +
+			msecs_to_jiffies(TMFIFO_TX_TIMEOUT);
+		return;
+	} else if (time_before(jiffies, vring->tx_timeout)) {
+		/* Return if not timeout yet. */
+		return;
+	}
+
+	/*
+	 * Drop the packet after timeout. The outstanding packet is
+	 * released and the remaining bytes will be sent with padding byte 0x00
+	 * as a recovery. On the peer(host) side, the padding bytes 0x00 will be
+	 * either dropped directly, or appended into existing outstanding packet
+	 * thus dropped as corrupted network packet.
+	 */
+	vring->rem_padding = round_up(vring->rem_len, sizeof(u64));
+	mlxbf_tmfifo_release_pkt(vring);
+	vring->cur_len = 0;
+	vring->rem_len = 0;
+	vring->fifo->vring[0] = NULL;
+
+	/*
+	 * Make sure the load/store are in order before
+	 * returning back to virtio.
+	 */
+	virtio_mb(false);
+
+	/* Notify upper layer. */
+	spin_lock_irqsave(&vring->fifo->spin_lock[0], flags);
+	vring_interrupt(0, vring->vq);
+	spin_unlock_irqrestore(&vring->fifo->spin_lock[0], flags);
+}
+
 /* Rx & Tx processing of a queue. */
 static void mlxbf_tmfifo_rxtx(struct mlxbf_tmfifo_vring *vring, bool is_rx)
 {
@@ -841,6 +892,7 @@ static void mlxbf_tmfifo_rxtx(struct mlxbf_tmfifo_vring *vring, bool is_rx)
 		return;
 
 	do {
+retry:
 		/* Get available FIFO space. */
 		if (avail == 0) {
 			if (is_rx)
@@ -851,6 +903,17 @@ static void mlxbf_tmfifo_rxtx(struct mlxbf_tmfifo_vring *vring, bool is_rx)
 				break;
 		}
 
+		/* Insert paddings for discarded Tx packet. */
+		if (!is_rx) {
+			vring->tx_timeout = 0;
+			while (vring->rem_padding >= sizeof(u64)) {
+				writeq(0, vring->fifo->tx.data);
+				vring->rem_padding -= sizeof(u64);
+				if (--avail == 0)
+					goto retry;
+			}
+		}
+
 		/* Console output always comes from the Tx buffer. */
 		if (!is_rx && devid == VIRTIO_ID_CONSOLE) {
 			mlxbf_tmfifo_console_tx(fifo, avail);
@@ -860,6 +923,10 @@ static void mlxbf_tmfifo_rxtx(struct mlxbf_tmfifo_vring *vring, bool is_rx)
 		/* Handle one descriptor. */
 		more = mlxbf_tmfifo_rxtx_one_desc(vring, is_rx, &avail);
 	} while (more);
+
+	/* Check Tx timeout. */
+	if (avail <= 0 && !is_rx)
+		mlxbf_tmfifo_check_tx_timeout(vring);
 }
 
 /* Handle Rx or Tx queues. */
-- 
2.30.1


