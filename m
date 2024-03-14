Return-Path: <linux-kernel+bounces-103241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ED287BCD1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BE2F28456B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801DD5B03A;
	Thu, 14 Mar 2024 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hess4h/P"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220895811C;
	Thu, 14 Mar 2024 12:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710419424; cv=fail; b=BGUDX3teTWbj53GoiGbFr1JTjaCrtG1VGfvu6qj5YYbsvMA79GjzJEQfofMH6XauHm3q6871bdpr8kQwOUGK4oSPUpO/oU6Xwe+ouvXTI1IEFgypWqGZwMaASsciDHU3GsiGFyZyIOrR+iMc72Sq+H0oXcnvVITqJxdcLqB/ruo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710419424; c=relaxed/simple;
	bh=9ezhpjSLokBafLtgwQqdFILJFqGTTkFuxSU9L/18f44=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Mej/epQyM0QR0cINPQ4ifA6TtJcZlii7X+fFvtKgI32Pd4YAE97oXLId0VIVt/D12R1mCFyW3Cqh7sBuStiLxFjwae4u/1C3M0eTNAwziyLYDF0djzLI3kSw20jCimEBGny03u1IgfNF4LgeBfxari48+UGhQ7QtVcNbruoGWTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hess4h/P; arc=fail smtp.client-ip=40.107.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2aA4E2QVC1UvHvCJ4j2F5RrW5dzKDfo13lt2/gqr7PSQwR1QymwPcgeo6Z/nASggP9RPBUCOwaF3zSVqj2vGFV0hQ1yKT1kZA431WSPMVwZEj8PcYU0LwHjtPQxNVRqhhAPEK+ijd0JCopZUO2yq2AgJXjUS0LeNoJOTNVxcM/rvBD4fECAOiMGxTDOq4lqwpri7PyolKXqva+OqoklM7KBCDnMi7Blu2aIs1alkfsaT0s/h+ygzEBo/Sim8Qovn2ZI69fQwnn6fQ5aLViqewk1pq6nG4r4rrKk0R97Yq6wWjD24mxS4T1R2wKVNkMefbxH7u+2iSv8RDhoOssNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eX5vJWfbv2JrNR0gmb3ZZOYhCTXn2kqXbyBEVfNUkFw=;
 b=NXTCwuCTBk8IvCrQJ+IWphtkkcEoxxcNshOzMWRtlgrzKRkZ4Fz/Th3aRJARGCl0P9wdIav1f4M8CsJxDHhoscGDK61ZQCpv16yhsn2e2cDFtWd5TayHfLIR04w8qXSjK0mcalaq33Olsib12cNsuOjdDQMzav4CEt3oMS6HZwRg+cyj4qFpGqxBVOsJIhR+tYiRE404XH0CPuC4JNnEe0Zxsx0ciAjzeFuU4uNqtZgZryubVwh5nmm7QpALq2oRh85pVPUE174tyEQhea7REMGBHqRBuvvEel3Om6i+dTr7oThkPQ7CXaBW51SceWyZKhLAIcBdtNwqtAmpqNu4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eX5vJWfbv2JrNR0gmb3ZZOYhCTXn2kqXbyBEVfNUkFw=;
 b=hess4h/PX1OPRiclNRYyVhv53C0paYlFhX/gNw1PPL9r0eni9jGPGloCsk+7eB8SMycuUtVg8t52MkcrajGVRahCmvQRQ/LiqCcoE0luAo9atuQ2+/vBZzrEwSMFYSJz5Hld/xoGbWi5eU8s7BPrpVxi/yCB/gp83Kx1+wgo4Uo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DBBPR04MB7708.eurprd04.prod.outlook.com (2603:10a6:10:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 12:30:18 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::467c:e0d8:4d23:b87c]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::467c:e0d8:4d23:b87c%6]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 12:30:18 +0000
From: Neeraj Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: amitkumar.karwar@nxp.com,
	rohit.fule@nxp.com,
	sherry.sun@nxp.com,
	LnxRevLi@nxp.com,
	neeraj.sanjaykale@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 1/1] Bluetooth: btnxpuart: Add handling for boot-signature timeout errors
Date: Thu, 14 Mar 2024 17:59:52 +0530
Message-Id: <20240314122952.1867-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.33.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::9) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|DBBPR04MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ed5aae-b8bf-44f3-7f2b-08dc44228228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QuX6SJVxDRPk1Z7GQkDWlATWg+pcqpAVSIWncrvcBGWbBR69nilC/Ko4ta6Wses0ofPGuoj/0Qm5wgSn7SsxJOVV5T+CW5g8astEVSiMbSvz7Lmw0XEN2Xs6QBQzB1LiyYBlBI335jxAwdq6UPJhn3NFyLrHf1MGJKk0NKpLf36d3GuvGXFCttH3/w8hfrrfmyaJL+aa9ZKoa8/YO24vsF6gv9Fuw3fPXooN9tS7Gk/d1DafobWx4NcelvtkYzoVlfiR6/TQSx07oyhWUXWFRGe0DtQQPWIKHUmZA0WOh+/l6Laf1w9GxfORzM6v/VJaCELLZFcxaJm/KcR8kkIjK5jg+Ix5iiOi3Xdf3IGGlIxQTKmmN4cCMQchnO6J86uLY4tirb7GX+4/dLJvaTswqDg2d9KrdQDBpzbqEy/qxzm9aLCdrba1nvd6y/XLIQkWhwTOnEmoV6ix+j9o6Yy/yx/PD51NV/tyzjNnnzN5MRREkDEQBYuCu5IXDecytYcn/Z/vsgq5LxPldvNFFHDZBdgzf3Oe7QJ1A2tze5JvE6Bs19scxa1WN58YiYgynC1GmUPbcHreobglkjgedOodBG7V/J54J624F265gwXxoXd5euFt66S5LiJQsPdyAREMREJeMnHkUNUpUNMRmvAjWAiCNVGewInhX6VYlISpNcUB4AG9ULr9Wj1A/gaEWtsfGkF0AM0ATRfrqVAy2vyVNQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rv3KfY4FMZ7KeB9XTY942T12CsR0KJGiXWKqJEtiFn2XvY+3pp009Ka8JRL6?=
 =?us-ascii?Q?eYcO0v2fzQQyILJR4vtAhWa9jyOPk0zJIp0bhMD5Zq1OEEzOnTs+XJIVIxP1?=
 =?us-ascii?Q?Nff4irBnDGIHG3CP7rYf292rmRJkfouQB99r/gTjhzMo/GZx06JP22BZkyfv?=
 =?us-ascii?Q?rNZmHcyLsvRqKfROA9sovScltVuncu/NOzrETF201ddVqfWBjSGDeVIeZHdp?=
 =?us-ascii?Q?islHQYBO9B7bWhn2huVR1Xaso3uxrqMxiS02mCkjFjSFCh5ENZu0NQM27CvA?=
 =?us-ascii?Q?cPRSZBJs7NSxipM5ySKKGfdDZu/xaRXqq7FrBY1ZuIs1CEEk59OqkTtp4B+e?=
 =?us-ascii?Q?2vl23Sh2nQ+pUh13JFXWc6cLVhzXuKiCX9V7agT0CegFNJrcjVjy9z9B0Lvp?=
 =?us-ascii?Q?NjxJ8HKs618+lFlNGwYzhvSj0dLundfKCx5V2uYP8ZswgT7cHRq7tbcQRYuY?=
 =?us-ascii?Q?N2poysMVwkUXrhtrDyBTxFv1DJiBIL4A5PSt39LZVnTo1TTY6CJUHeTeY6Ip?=
 =?us-ascii?Q?EZC5o0diyRg3LQ7l8/LZjP98+0LpL/+E7pagXRRv0mdxMk00FaXn4VTamkWm?=
 =?us-ascii?Q?Trha+cz8FLe9vAqpTc+vX4vxDhuAYvBZ/eqd8TpD/DUjUR/sBQMuCEaYoKY1?=
 =?us-ascii?Q?4pAGexQsYDkW/fxNP9793UqlXx+O2J0sQmbG0hP13t6P6yEjqfaDv0PgKvWA?=
 =?us-ascii?Q?ETHrBKVaLMivMb8JDo+ZT9EavEDmYFo3ldkMiStor+CCTaBJsepO4bgCpaU5?=
 =?us-ascii?Q?VmmiI66wWq+0f8W33neINUoheg7M7OxibNucaG2/zDNFUJZft+gl+Qw87Kag?=
 =?us-ascii?Q?r6koj1Z9pkMYfP/sjbO2tEcZF/623+a7QDWvFjmjIiB8Ph6ylNKEXHhl721T?=
 =?us-ascii?Q?IKRD/+5GDWqkSUyP4eVOtQfelJYFj7vipUkdwvXn1tra4qpvvcuAYEvSfY3P?=
 =?us-ascii?Q?/B6aF2FXt90y7J7FZm46pk8O2hcVpWHuyDEuv8gxBrmXpOmpbKwYeO4Ut12U?=
 =?us-ascii?Q?0V3vo6Q/+D4WnctstQgGwHLByuEfxWNx1ewGNSnrrrU2ECDDECbCUdCELW6f?=
 =?us-ascii?Q?S46dtcWzL3q6/YEnRbe8dDuR9Mt+yanQ29LVMzQln3Qhsggahm3iEtB/bvz0?=
 =?us-ascii?Q?hW4eHT9TCL/NxFf106g0kMe7t6l4f6ys/TQQsXRnFJqCLKG8/hiT9x7z/4R8?=
 =?us-ascii?Q?F+AWkUuc0TBaX7SmDM1BifpyOs/IDdLn0w8QlUtp7R26Ez0ik9+U8eKIHSO0?=
 =?us-ascii?Q?ovoaM+2H9l+qRidGFteVDIdv09Z9ZeIOdlT09ClIVGzNHVjpZGDlSvsbWbdX?=
 =?us-ascii?Q?ej50m5q8CN0eVtCvZFeco3UWxN7iFRGWEhvMIZRV3EuSPen/mKZl3N8YycwO?=
 =?us-ascii?Q?Njzxq7bD2w/oaiJ893FZOD5ALWZDqGfVBhlzbDC0U7Zttdfrta+1y0rNuXXE?=
 =?us-ascii?Q?QNOFWhs+hHTT/3/cA/zI0eZFUsJia3UUGVlfLcvILU/5agFaByVK3nhGbSFn?=
 =?us-ascii?Q?808O/EPYvsqMt3Es/E5oWY/qPc+fgSkVipjwaygLZGs6ca14zV+Nh4mkFeha?=
 =?us-ascii?Q?0tR/4HQk2ahif7UviHTDihdHTyv9D8foMYEIYjixXu35Lk0J2q65H25FAn1r?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ed5aae-b8bf-44f3-7f2b-08dc44228228
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 12:30:18.6388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lruC4fAhFZtk76WJdea551m/ckxXXXKDsVG7WxGKhncstAtw2Y7hqdUGXfNd/FVMt0bCzQ4TckG/hwd6LxlFsiphRcG59zve7EArXpOcjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7708

From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>

This handles the timeout errors seen in the bootloader signatures during
FW download.

When the bootloader does not receive a response packet from the host
within a specific time, it adds an error code to the bootloader
signature while requesting for the FW chunk from the same offset.

The host is expected to clear this error code with a NAK, and reply to
only those bootloader signatures which have error code 0.

This error handling is valid for data_req bootloader signatures for V3
and future bootloader versions.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 46 ++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 0b93c2ff29e4..2018513fb961 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -187,6 +187,10 @@ struct btnxpuart_dev {
 #define NXP_NAK_V3		0x7b
 #define NXP_CRC_ERROR_V3	0x7c
 
+#define NXP_ACK_RX_TIMEOUT	0x0002
+#define NXP_HDR_RX_TIMEOUT	0x0003
+#define NXP_DATA_RX_TIMEOUT	0x0004
+
 #define HDR_LEN			16
 
 #define NXP_RECV_CHIP_VER_V1 \
@@ -277,6 +281,12 @@ struct nxp_bootloader_cmd {
 	__be32 crc;
 } __packed;
 
+struct nxp_v3_rx_timeout_nak {
+	u8 nak;
+	__le32 offset;
+	u8 crc;
+} __packed;
+
 static u8 crc8_table[CRC8_TABLE_SIZE];
 
 /* Default configurations */
@@ -899,6 +909,32 @@ static int nxp_recv_chip_ver_v3(struct hci_dev *hdev, struct sk_buff *skb)
 	return 0;
 }
 
+static void nxp_handle_fw_dnld_error(struct hci_dev *hdev, struct v3_data_req *req)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	__u32 offset = __le32_to_cpu(req->offset);
+	__u16 err = __le16_to_cpu(req->error);
+	struct nxp_v3_rx_timeout_nak nak_tx_buf;
+
+	switch (err) {
+	case NXP_ACK_RX_TIMEOUT:
+	case NXP_HDR_RX_TIMEOUT:
+	case NXP_DATA_RX_TIMEOUT:
+		nak_tx_buf.nak = NXP_NAK_V3;
+		nak_tx_buf.offset = __cpu_to_le32(offset);
+		nak_tx_buf.crc = crc8(crc8_table, (u8 *)&nak_tx_buf,
+				      sizeof(nak_tx_buf) - 1, 0xff);
+		serdev_device_write_buf(nxpdev->serdev, (u8 *)&nak_tx_buf,
+					sizeof(nak_tx_buf));
+		break;
+	default:
+		bt_dev_dbg(hdev, "Unknown bootloader error: %d", err);
+		break;
+
+	}
+
+}
+
 static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
@@ -913,7 +949,12 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!req || !nxpdev->fw)
 		goto free_skb;
 
-	nxp_send_ack(NXP_ACK_V3, hdev);
+	if (!req->error) {
+		nxp_send_ack(NXP_ACK_V3, hdev);
+	} else {
+		nxp_handle_fw_dnld_error(hdev, req);
+		goto free_skb;
+	}
 
 	len = __le16_to_cpu(req->len);
 
@@ -940,9 +981,6 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 		wake_up_interruptible(&nxpdev->fw_dnld_done_wait_q);
 		goto free_skb;
 	}
-	if (req->error)
-		bt_dev_dbg(hdev, "FW Download received err 0x%02x from chip",
-			   req->error);
 
 	offset = __le32_to_cpu(req->offset);
 	if (offset < nxpdev->fw_v3_offset_correction) {
-- 
2.34.1


