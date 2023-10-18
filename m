Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81867CEA17
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbjJRVeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344766AbjJRVe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:34:28 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA6D139;
        Wed, 18 Oct 2023 14:34:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYBd0bXsLAUh6/00o1PaNB2jnAtcfoFi+NM/nZnB0UgX78u+LiJnNvbOKxW1Av3MQtQjaEZf1dEb0SS1j/jAucZTSXR/XFPgy1l6lbdmpaGBdYOPjASwc5Mv/nlnlime8z8Kh+ifvy07u8VWrruvPJ2C0d/2J9ywFE1mGbIoZthzG5iLYCuuFzdKD9ACcrp+YT2Ztn2lZL2iRf9KgYHxkZIkhBOg2qLcauJR1ibL/XRZU6Gyr/3amobM6GaA58tsQ97sYeyGZRviQytb+izfflbc03GqvMUNjILn8Lq8jlX3zViR7mjLJMSFL6eJJkFRElujcX+a7xZ3g34zPMJajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uctAgBsWbg4zjYa/iQFFs5zeaRx7Y3UIWC12hEqotVg=;
 b=MbPUlpegn2pGKMKxJ94TBgu7V2W+LAbrYxWnvH3C19zB9Fc41pMm9CcFtx9nRWZKCm4m9Lu/Vvt2PK6jt2c387FTith2IZkSGLIxWJu8EMTpmXSTX5yLVg7Td5z7ICIyVfcB1NjkNhe5/Byyj08FuAcAYoDpaDFcDnSr1PGb41wI+fBKli/sULFn0Ynf8NqiVX4qXCaQVHOVUxgwytW/HpFzidQ8ovROQKzb3805+oVvQduzgalG3V2rwo1rfOqdPcVZUqJQvwEYExZOBU67atw9Sw1+dMRR3BO55WodC0B5m6Gq0MfWgFRv5AfiNF/jKJIGqz8cDX0hUTRmX0DXfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uctAgBsWbg4zjYa/iQFFs5zeaRx7Y3UIWC12hEqotVg=;
 b=xBncc1rNMmFIVmjy+HGZLMRdpFQ8dO86/9vn3ieQ4Quz+k0PdeejiZahVo2gkzqkpzB26LlXGSOK+ZtNsKaEn+Zz0KK2Os4jWlUcZgBi8ze2xYxtgJadC1E+wvMFmAAfWpx8kyaVNnfM6QzmlZgVNTcLohrlOekvQbHww804XPc=
Received: from BLAPR03CA0176.namprd03.prod.outlook.com (2603:10b6:208:32f::26)
 by LV8PR12MB9357.namprd12.prod.outlook.com (2603:10b6:408:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 21:34:19 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::eb) by BLAPR03CA0176.outlook.office365.com
 (2603:10b6:208:32f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 21:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 21:34:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 16:34:18 -0500
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Wed, 18 Oct 2023 16:34:13 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <broonie@kernel.org>, <tudor.ambarus@linaro.org>,
        <pratyush@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@tuxon.dev>, <michal.simek@amd.com>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <amitrkcian2002@gmail.com>, <akumarma@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH v9 8/8] spi: spi-zynqmp-gqspi: Add parallel memories support in GQSPI driver
Date:   Thu, 19 Oct 2023 03:03:28 +0530
Message-ID: <20231018213328.40131-9-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231018213328.40131-1-amit.kumar-mahapatra@amd.com>
References: <20231018213328.40131-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|LV8PR12MB9357:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c7efdd-1b94-4586-2c21-08dbd021fc92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UmW/UqYMuwWXs6RIQ7gcJL7PKqM+WHl2uwNHZvXXL4cC/sLX3a5yzzTINL3hLIawYuzT7B1Yf/PMenLOnhWITE7HI6pUXWaL9vjBhWCywZq//ZSN+7a8/K4t8b+/aBCI+xIt8l+trOuYwipuXOTsJI8AcFbfATSp66NYehrMK87gDvzF/r1uYyKG/synIpU4zRvYyLYE8fD4m7lDir24n6pAdZ+FZoSZQCvWniJqNxeGXiFsnbRdJpM84Ba7zFNbpEw1+BpYlPT7rp7fG1p3+QFp+Rw3+jupGfc6zH0bZSvhJy1fT51T4YN2f7rEKCRCJaDaGWf07ZixS/TmU7C80kraAyOAWq812E84g0CjI/J9PY7uPhU8D5/gtiSyUB/wXE04ZIuBiizvCZk/MJ17kq0OtIEyiKk5q0xPscE7kPLYUrd3Q8Pps4/gVyq7Y8hDCW5RZQz/Pn4k95g3eZX4Cp9FqDBSfXO9fegHoxumJJ4neSzMSQsbvhJPi3oqUr5FCez9HMDL2LTkNAoZFW+Gx5aLZV4XGJzrL8KgYWH/08k6QdZalIt7ofLp1cOEUy2RZ2bXKnpT2yb24GWkA06/se8cdcqcFqW7bUljJGVqD8rZt5vHLN6OMEBv2ffhO+eW7bCFT53E6ahoSZsCiH7g8mUQZoMwMQwHWoa/SIbzlfnIVm6y/sRm8UjxZynLAJIZPvdi+kHkJlacfyGwH7Hj+49hHIgF8WQQM28fbCNiLwBVesbJNUcwhAPhFbgo8+/biXElpV9omRJ/dnPn8tP3EA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(82310400011)(64100799003)(1800799009)(186009)(451199024)(40470700004)(36840700001)(46966006)(7416002)(40480700001)(86362001)(2906002)(4326008)(54906003)(110136005)(8676002)(70586007)(8936002)(70206006)(41300700001)(40460700003)(5660300002)(36756003)(316002)(26005)(356005)(1076003)(2616005)(81166007)(83380400001)(82740400003)(426003)(336012)(6666004)(36860700001)(47076005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 21:34:19.2368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c7efdd-1b94-4586-2c21-08dbd021fc92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9357
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During probe GQSPI driver sets SPI_CONTROLLER_MULTI_CS bit in ctlr->flags
for notifying SPI core about multi CS capability of the controller.
In parallel mode the controller can either split the data between both the
flash or can send the same data to both the flashes, this is determined by
the STRIPE bit. While sending commands to the flashes the GQSPI driver
send the same command to both the flashes by resetting the STRIPE bit, but
while writing/reading data to & from the flash the GQSPI driver splits the
data evenly between both the flashes by setting the STRIPE bit.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 39 +++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index c5d12ddd4ab3..61e91d59014b 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -21,6 +21,7 @@
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 #include <linux/spi/spi-mem.h>
+#include <linux/mtd/spi-nor.h>
 
 /* Generic QSPI register offsets */
 #define GQSPI_CONFIG_OFST		0x00000100
@@ -190,6 +191,7 @@ struct qspi_platform_data {
  * @op_lock:		Operational lock
  * @speed_hz:          Current SPI bus clock speed in hz
  * @has_tapdelay:	Used for tapdelay register available in qspi
+ * @is_parallel:		Used for multi CS support
  */
 struct zynqmp_qspi {
 	struct spi_controller *ctlr;
@@ -212,8 +214,33 @@ struct zynqmp_qspi {
 	struct mutex op_lock;
 	u32 speed_hz;
 	bool has_tapdelay;
+	bool is_parallel;
 };
 
+/**
+ * zynqmp_gqspi_update_stripe - For GQSPI controller data stripe capabilities
+ * @op:	Pointer to mem ops
+ * Return:      Status of the data stripe
+ *
+ * Returns true if data stripe need to be enabled, else returns false
+ */
+bool zynqmp_gqspi_update_stripe(const struct spi_mem_op *op)
+{
+	if (op->cmd.opcode ==  SPINOR_OP_BE_4K ||
+	    op->cmd.opcode ==  SPINOR_OP_BE_32K ||
+	    op->cmd.opcode ==  SPINOR_OP_CHIP_ERASE ||
+	    op->cmd.opcode ==  SPINOR_OP_SE ||
+	    op->cmd.opcode ==  SPINOR_OP_BE_32K_4B ||
+	    op->cmd.opcode ==  SPINOR_OP_SE_4B ||
+	    op->cmd.opcode == SPINOR_OP_BE_4K_4B ||
+	    op->cmd.opcode ==  SPINOR_OP_WRSR ||
+	    op->cmd.opcode ==  SPINOR_OP_BRWR ||
+	    (op->cmd.opcode ==  SPINOR_OP_WRSR2 && !op->addr.nbytes))
+		return false;
+
+	return true;
+}
+
 /**
  * zynqmp_gqspi_read - For GQSPI controller read operation
  * @xqspi:	Pointer to the zynqmp_qspi structure
@@ -468,7 +495,14 @@ static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
 
 	genfifoentry |= GQSPI_GENFIFO_MODE_SPI;
 
-	if (qspi->cs_index_mask & GQSPI_SELECT_UPPER_CS) {
+	if ((qspi->cs_index_mask & GQSPI_SELECT_LOWER_CS) &&
+	    (qspi->cs_index_mask & GQSPI_SELECT_UPPER_CS)) {
+		zynqmp_gqspi_selectslave(xqspi,
+					 GQSPI_SELECT_FLASH_CS_BOTH,
+					 GQSPI_SELECT_FLASH_BUS_BOTH);
+		if (!xqspi->is_parallel)
+			xqspi->is_parallel = true;
+	} else if (qspi->cs_index_mask & GQSPI_SELECT_UPPER_CS) {
 		zynqmp_gqspi_selectslave(xqspi,
 					 GQSPI_SELECT_FLASH_CS_UPPER,
 					 GQSPI_SELECT_FLASH_BUS_LOWER);
@@ -1137,6 +1171,8 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 	}
 
 	if (op->data.nbytes) {
+		if (xqspi->is_parallel && zynqmp_gqspi_update_stripe(op))
+			genfifoentry |= GQSPI_GENFIFO_STRIPE;
 		reinit_completion(&xqspi->data_completion);
 		if (op->data.dir == SPI_MEM_DATA_OUT) {
 			xqspi->txbuf = (u8 *)op->data.buf.out;
@@ -1332,6 +1368,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctlr->dev.of_node = np;
 	ctlr->auto_runtime_pm = true;
+	ctlr->flags |= SPI_CONTROLLER_MULTI_CS;
 
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret) {
-- 
2.17.1

