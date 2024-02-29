Return-Path: <linux-kernel+bounces-86773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88D686CA91
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D9D5B20AFC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B99128389;
	Thu, 29 Feb 2024 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FNB59AF3"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988A17E56F;
	Thu, 29 Feb 2024 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709214386; cv=fail; b=FZcLGtLVDiuOnndwGv3omWOEMJ6Ar96uZZ2C5yy7RYw/ou/DedmPzErJHXooon8WQ+deePW5r4j8o7CmM2cs1k5qKpnxL7YH2VgzjZPmKLBe8oV/yuVdcptoc3Z3XIqPqnBv7eJar9RX9aQz1u1V4jhRARy1dJUml+p7pk94hnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709214386; c=relaxed/simple;
	bh=Gfy6IvCbCCfbWi+at9vocLxtopAWbZufFtDzJPaF0MI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b91WrBEQt9Fpvi5KCPch/jcAQUuNF5wG7YzzUAK6P4hL65nXrCTRq89mqzBtLsu0qxQvc4GsiyNHvKQOnN1p6BJcUP1MNQhGW/aQBYNPNqdl2yWbei/xa7Qd0Q9ybFlaw21PT2jNY/9k66MJ6VHGemUQWYDbswEAlpwS1uh1DKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FNB59AF3; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Roz+KAz0JK+v2uID6re3EK/prVSFbObOKQenAzxnKqMyn1n0TFtS0qwwmbwQ5o5VJR2Q7ZErtFBc7+kuTxM7W+P/+d9XdgsWMfQ4SmG1+ddZ5gwV2iEiamKjGRIy7NMHMzyoiLdCI6jsUIXIpp7E8MX856ch3pM33DKkW02y4Us1+2ofoVQlEVHRP7jKAH8ax6u6tptDa9HT0KPCX0UvVnf1AWJsxmNdWixxVrRbk3XTg7uVrA8zurDjQdzSWTo5Hs33k6XUu2IC7YyPY3H5ftTdHLdymE0lKvyREzhkXWWWW39tORscWYMzer5ymU/ovcLhGyQWAZRdCJuTe+JQ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSlmJ2eI754t9pAKtYbBW/DyT8ATkHHxxr/HJIyc178=;
 b=UvTQCag8oLl96z8ng7qhhbR3O01wgunBJ3pNmNezB+g2l77xFAs5/ybFHMmxOnQGcwku1vFypkz4cDhxkK8nHzAf2iLsS1nVjCG1/VkyjpkYRSKeJ/2FqmXVjLx6MUolgThR9mYcHFQQ5KF633i+FiC1DiptZRTnHKjD1s3vOJmieispFuPQbjnzvZOdh+/U2Fgu6pgsXlF7tPQCyEO7dT0nRNy4w4puw0U7o56Oyqvi8Z6f2eVc8jjl4R7sbqi9dV6Ps5caaiU1LcSxxo+EjRll9u5BKjKOT22PnR3DMx5C4rYCbCI+fbdoRiyfiZ2lXFikKtdVL0atHgEXl+n/0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSlmJ2eI754t9pAKtYbBW/DyT8ATkHHxxr/HJIyc178=;
 b=FNB59AF3/Szt5KuJn5QUvmg+t6u5+q7f4t6QyonfH5j9dz5EwLG0D1XtoSG1MEnRUlpjk3CMfOxFNI+2iAXsODDH5THOYcQZ4Uq2flKotIsNKlqJg7VcMfFgwAgeRgv+muWrJB+086KmqCvBjAh7RclB4ANWFe/oZBi2GpYqtPs=
Received: from BY5PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:1e0::20)
 by DS7PR12MB8273.namprd12.prod.outlook.com (2603:10b6:8:ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 13:46:22 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::cc) by BY5PR03CA0010.outlook.office365.com
 (2603:10b6:a03:1e0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Thu, 29 Feb 2024 13:46:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 13:46:21 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 29 Feb
 2024 07:46:18 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <linux-spi@vger.kernel.org>
CC: <sanju.mehta@amd.com>, <broonie@kernel.org>,
	<linux-kernel@vger.kernel.org>, Raju Rangoju <Raju.Rangoju@amd.com>,
	"Sudheesh Mavila" <sudheesh.mavila@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, Akshata MukundShetty
	<akshata.mukundshetty@amd.com>
Subject: [PATCH] spi: spi_amd: Add support for SPI MEM framework
Date: Thu, 29 Feb 2024 19:15:44 +0530
Message-ID: <20240229134544.3461757-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|DS7PR12MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: f2d9a9be-2eb2-49aa-c2a7-08dc392cd095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bCNMIv5iqk9kLJJAGekkoYp+PHwRmHPeTPcrtHdHUdjlracQmRgVPnzIwKRmpCHK3j8qbcitdirnynluYm82fpbHfVH7GEiJYgOAkfbeYqwpGKuw+225ex6Q1gX37bzNDf1/XVPDM4iy4Odka0NpBzt4x+hvf6gayV54uDM/czc/usxV218TTvAm/43t1B+4imqqhDGw7i8XUcbiRsR2N2lorjH577cyIPwBkvL3BcFlc+63T9yWsG5b9/wuqpm28hM59msmDdza+Si2lpCq6PdjA0Pz+U9wegFPPreLQ7QfiphWKeoQf+c3EUQ8/X5LqMYUOzM3YpieYBI+/aEAm/GypaU1GPlCVovsznXjrHRQ5qbtf7YCPUj8L/oLzf4FLnXVjizl4iWb4D9H7qeryOFKLn/aDAf3lI4x2QQepHFnDhhyIA+8vifW8TmwpOXPUUkzGmGxPuElYyu3zcp1jQt3WMbU4MmC6oBhICCeh8Sl8Fkgoiur88Mo5Bix5F6cqYUSY+Suum3KnPPNelAPjk7SKS8MduCcqMQlQtFUfN8iVX5fwwtoNpwIKoKbLspa9+F0AOxhFCSXnWXY80gG9FnDp71naq7ya5+2Z7tCOuameNscEHBb+8IuoIz2rdyyT2x+R2NPAwzMbpTzQ4rt+k45WrCn4squKthJZnMD7//bH2oARsDaE4x561Y9lgJIfaDrPutMGHNxomgJcZMOIDFldT6F8gUVF7N2ZK7Ad8GXcpdm6VwjtKSm+Ko9s9wh
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 13:46:21.9493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d9a9be-2eb2-49aa-c2a7-08dc392cd095
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8273

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


