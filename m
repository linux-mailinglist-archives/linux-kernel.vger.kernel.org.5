Return-Path: <linux-kernel+bounces-118729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B2A88BE95
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46CD31C32B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20236535CF;
	Tue, 26 Mar 2024 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="beuKLd8l"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BDA487B5;
	Tue, 26 Mar 2024 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447078; cv=fail; b=uo1jMk3CfDF+hbXC6STz4ksTqVr5QdYWK6Dx+yTHA1/bzec5BOmjAISmpn0h+e8pTDMWUlydQ3xOa9HUwBp48i9h8lgOmawZM+GT4m6PBbiJwCsZQlnSOjdnLeVPb+OJPmq+kp4L2/W4IB9fzWENJPVCaMpMvrwSmOylw7Ma3VM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447078; c=relaxed/simple;
	bh=Gfy6IvCbCCfbWi+at9vocLxtopAWbZufFtDzJPaF0MI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XF5OgeuwujYbzByo7B62cTPTK24ZKW7nOHHZCUzBKJccKzuzvvrnLCsnqldsO5StzlvijYTNSv0f+D0D4NsgGJR5m09P/gT1k5IOeduRPcYuPrD7gJTO1BNnXZCPWyY4v0u8vzyV5ICcdtvaBYzYQ9iBXtuTOmVGMQtJ0SxdxRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=beuKLd8l; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgJ9sU+GBHQysqCmDXntMrbNPBa4uj0KxyHdag+6XFL5ipnIBA9IDXulSlMa6bqSyvVjlBsY/mpdzFRS0lJGeDMJLMXAQiJRH3vMCsbZlbsprDhU9GejYMnfiPYieFu6qtU+bXNMnzTrpa8CSA34jppcu40PJ7gnZhbMzb1BubB/Q5xGfFg7Q7OTaKKirDYpNxyQFoQrfFXhyQyDRDaJCIwcWtGKyKUzxus82x85xU0baOjIgyHLvfypd6/ySU1Dsr9POzGIB+7Uln6i2ni0WiOZGabTLXqp32lVKm9Tvfm1twjkr+TNv6/vSt8yi5qEVaAaK4GS7c7inWh7tZa1wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSlmJ2eI754t9pAKtYbBW/DyT8ATkHHxxr/HJIyc178=;
 b=Mf643sIJab7j4KBJRylbKSDa7sh9QMA8I5SQvwJKrBTWmEwz9xqHnKUDsLb7f+n3bQSUByYy7fFuWOfq+AyTOFvJC8B/e1JJB/iuo3g4tu+JFWYIjqkjXxmYWPv2NBIrOvlKamQdYoZ6tNtdM5Dt35fovyeyJwk34mK4moXZDRoFW6gbPESsJr3QiJGTZGZrH9JHJBdN5xuo63GhpuMNGvC6n6NLLBirzi8yYhMkmmbaXwK7QY2w5mZdMUDJ9AqsgaZ5BpPI/MX9o2rEbaeK59IqKKxc3g8Y5JXg6E1zhSv02ZqIqvqF0ZIihEKYBXCOr2pLjkjhZwzmz9dvhXHVYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSlmJ2eI754t9pAKtYbBW/DyT8ATkHHxxr/HJIyc178=;
 b=beuKLd8lzSr7uU2KJ8cxPLmQgdUZ/bMjHHXof8AU7x/QPEg9t7Pkf1sChMf85jJz88w40k/m/azbUNLLm3G3ZtLm4AbKmICb0F0lADZ4am7T9J9GB+6+Xs1LdWdTCxPXydV60tNPtv+HK5iGksKMLK+bYhL1ATaNmDP512Exi9g=
Received: from CY5P221CA0078.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::13) by
 DM4PR12MB8523.namprd12.prod.outlook.com (2603:10b6:8:18e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.33; Tue, 26 Mar 2024 09:57:54 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:930:9:cafe::40) by CY5P221CA0078.outlook.office365.com
 (2603:10b6:930:9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 09:57:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 09:57:53 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 26 Mar
 2024 04:57:50 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <sanju.mehta@amd.com>, <linux-kernel@vger.kernel.org>, Raju Rangoju
	<Raju.Rangoju@amd.com>, Sudheesh Mavila <sudheesh.mavila@amd.com>,
	Krishnamoorthi M <krishnamoorthi.m@amd.com>, Akshata MukundShetty
	<akshata.mukundshetty@amd.com>
Subject: [PATCH RESEND] spi: spi_amd: Add support for SPI MEM framework
Date: Tue, 26 Mar 2024 15:27:07 +0530
Message-ID: <20240326095707.507601-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|DM4PR12MB8523:EE_
X-MS-Office365-Filtering-Correlation-Id: e15f2915-a576-450c-72f9-08dc4d7b34a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8JxSFuEuLD9XrkJ6dqaklQfp+biFpKABR2J29n5VUSI/aip8m1AKo+pAaQrvlfA/N9YJBHRLRubNt3H2EmbLtAI0F+mtmDaZdA0QKjS1//2r00BFbq7wz/zgC0AtpGHPkmk4UkM8MLSUjn2p1kTSw5E04Fjs0DRFOmIuAcqWlJSMvr/SX//GI+Hk+1cUj1HkHr4xTys2DBsI8gz/P3V5LR6pYLOQidD73Gl1hWn/bfyDltP5+kYAzbV32qU+v+RzJkWOH5vwpOkmsATQB0DMKCWunaErBej02+4x78jZxDSb9k6E4KIbrlBk/d8eniwKwX2Qmu5Tyj99hIxhjP6hAuhkvpTvxOKlyN6+gUFdtnLLnyGz81rt4vzYIiyMz67129oQJ4FIOb0YxXcQZeztVQ/mHW19yyDVqEpYKbY4DF67nOwRmB39fkbSTNoMXtVt6JrbQrlLUkfbOsP8q/pERdiDZvVtbSBh+x9ZKwdSSJvsAIyNDEQyPB/g9G5xhTEedtDuN8iJs0tKR354NsB7JIrqzpz29vWgeSw0GEparwE6xTe/aJt2eqqV2BFNa0EuhblJq1lDdbVR5KA8sMN0syps+QZ1lC6B72wpXVvbv1KewvVdKPfJNLR/uteeBfj0AUqPIhjyo1FpdaoL/jA+OqIB0Swc/IeSCAnSNNY4Fn2JnYVZ3WJbMyIv91E75vOoRrjaFTTaQPxfJ2UHe74qlg/SQ7tVb2bv//dvf9bZWq8LaKypA2KarrAX/qpv+yQQ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 09:57:53.8273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e15f2915-a576-450c-72f9-08dc4d7b34a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8523

Add support to the SPI controller driver to use SPI MEM framework.
SPI subsystem utilizing the SPI memory operations allows to re-use
SPI controller drivers for both SPI NOR devices, regular SPI devices
as well as SPI NAND devices.

Add below functions of spi_mem_ops to support SPI MEM framework
- exec-op(): to execute the memory operations.
- supports_op(): to check if the memory operation is supported.
- adjust_op_size(): to split data transfers so that they don’t exceed the
  max transfer size supported by the controller.

Suggested-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/spi-amd.c | 112 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 5d9b246b6963..2245ad54b03a 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
 #include <linux/iopoll.h>
+#include <linux/spi/spi-mem.h>
 
 #define AMD_SPI_CTRL0_REG	0x00
 #define AMD_SPI_EXEC_CMD	BIT(16)
@@ -35,6 +36,7 @@
 
 #define AMD_SPI_FIFO_SIZE	70
 #define AMD_SPI_MEM_SIZE	200
+#define AMD_SPI_MAX_DATA	64
 
 #define AMD_SPI_ENA_REG		0x20
 #define AMD_SPI_ALT_SPD_SHIFT	20
@@ -358,6 +360,115 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 	return message->status;
 }
 
+static bool amd_spi_supports_op(struct spi_mem *mem,
+				const struct spi_mem_op *op)
+{
+	/* bus width is number of IO lines used to transmit */
+	if (op->cmd.buswidth > 1 || op->addr.buswidth > 1 ||
+	    op->data.buswidth > 1 || op->data.nbytes > AMD_SPI_MAX_DATA)
+		return false;
+
+	return spi_mem_default_supports_op(mem, op);
+}
+
+static int amd_spi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	op->data.nbytes = clamp_val(op->data.nbytes, 0, AMD_SPI_MAX_DATA);
+	return 0;
+}
+
+static void amd_spi_set_addr(struct amd_spi *amd_spi,
+			     const struct spi_mem_op *op)
+{
+	u8 nbytes = op->addr.nbytes;
+	u64 addr_val = op->addr.val;
+	int base_addr, i;
+
+	base_addr = AMD_SPI_FIFO_BASE + nbytes;
+
+	for (i = 0; i < nbytes; i++) {
+		amd_spi_writereg8(amd_spi, base_addr - i - 1, addr_val &
+				  GENMASK(7, 0));
+		addr_val >>= 8;
+	}
+}
+
+static void amd_spi_mem_data_out(struct amd_spi *amd_spi,
+				 const struct spi_mem_op *op)
+{
+	int base_addr = AMD_SPI_FIFO_BASE + op->addr.nbytes;
+	u8 *buf = (u8 *)op->data.buf.out;
+	u32 nbytes = op->data.nbytes;
+	int i;
+
+	amd_spi_set_opcode(amd_spi, op->cmd.opcode);
+	amd_spi_set_addr(amd_spi, op);
+
+	for (i = 0; i < nbytes; i++)
+		amd_spi_writereg8(amd_spi, (base_addr + i), buf[i]);
+
+	amd_spi_set_tx_count(amd_spi, op->addr.nbytes + op->data.nbytes);
+	amd_spi_set_rx_count(amd_spi, 0);
+	amd_spi_clear_fifo_ptr(amd_spi);
+	amd_spi_execute_opcode(amd_spi);
+}
+
+static void amd_spi_mem_data_in(struct amd_spi *amd_spi,
+				const struct spi_mem_op *op)
+{
+	int offset = (op->addr.nbytes == 0) ? 0 : 1;
+	u8 *buf = (u8 *)op->data.buf.in;
+	u32 nbytes = op->data.nbytes;
+	int base_addr, i;
+
+	base_addr = AMD_SPI_FIFO_BASE + op->addr.nbytes + offset;
+
+	amd_spi_set_opcode(amd_spi, op->cmd.opcode);
+	amd_spi_set_addr(amd_spi, op);
+	amd_spi_set_tx_count(amd_spi, op->addr.nbytes);
+	amd_spi_set_rx_count(amd_spi, op->data.nbytes + 1);
+	amd_spi_clear_fifo_ptr(amd_spi);
+	amd_spi_execute_opcode(amd_spi);
+	amd_spi_busy_wait(amd_spi);
+
+	for (i = 0; i < nbytes; i++)
+		buf[i] = amd_spi_readreg8(amd_spi, base_addr + i);
+}
+
+static int amd_spi_exec_mem_op(struct spi_mem *mem,
+			       const struct spi_mem_op *op)
+{
+	struct amd_spi *amd_spi;
+	int ret;
+
+	amd_spi = spi_controller_get_devdata(mem->spi->controller);
+
+	ret = amd_set_spi_freq(amd_spi, mem->spi->max_speed_hz);
+	if (ret)
+		return ret;
+
+	switch (op->data.dir) {
+	case SPI_MEM_DATA_IN:
+		amd_spi_mem_data_in(amd_spi, op);
+		break;
+	case SPI_MEM_DATA_OUT:
+		fallthrough;
+	case SPI_MEM_NO_DATA:
+		amd_spi_mem_data_out(amd_spi, op);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+	}
+
+	return ret;
+}
+
+static const struct spi_controller_mem_ops amd_spi_mem_ops = {
+	.exec_op = amd_spi_exec_mem_op,
+	.adjust_op_size = amd_spi_adjust_op_size,
+	.supports_op = amd_spi_supports_op,
+};
+
 static int amd_spi_host_transfer(struct spi_controller *host,
 				   struct spi_message *msg)
 {
@@ -409,6 +520,7 @@ static int amd_spi_probe(struct platform_device *pdev)
 	host->min_speed_hz = AMD_SPI_MIN_HZ;
 	host->setup = amd_spi_host_setup;
 	host->transfer_one_message = amd_spi_host_transfer;
+	host->mem_ops = &amd_spi_mem_ops;
 	host->max_transfer_size = amd_spi_max_transfer_size;
 	host->max_message_size = amd_spi_max_transfer_size;
 
-- 
2.34.1


