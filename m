Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F907F0019
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 15:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjKROS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 09:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjKRNz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 08:55:59 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC1ED7D;
        Sat, 18 Nov 2023 05:55:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jC2JytJwCJUoN6b8UaS0nJE/sHBzI+ovKNmaLicUYnA7EXAZChRR6yRUYHyqVXUKla9OMyrRucMDqFpC81JemiDoEDpRBV3PMkdcTxzxA2obSJHCK1XbIFiooeG81EVte2d4t+vShdqP7Tx5BO9yYHAHnh9vXoTO5hjbpG4T1GgvQXbsZlvO/JMdHes0rM2/gv6tIwPfNeiHudLLxhwttNX1lPKYneqBYDAAag+sUaHjUwLgiJqZryJGD31k7SCafaENb0FPYuHUj+rJh10GOAQdmLhI/QVgOlpBtDh/uyY6HdClgLQZtVqO8bbe/PzCa6fLC21JwZTcG3aJDB8JqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uctAgBsWbg4zjYa/iQFFs5zeaRx7Y3UIWC12hEqotVg=;
 b=JrwV4U3WQ8piXXbJQXZPYPe2tps1HRKgxYcfxtkngWUDwgATsBw8Wb4j2Cpja4ZO9YKb48fxK6DMo4cXlyU6o7vXJ3O4BmxZBSmiAjjuOS+ulj8D98cG+U8qrwg3jhd6pbIj4y/1MyzqkM2WMTiJza6wzk9T6gpzhG/qZO/bz7FIhDL/WQwN/5GrvAiZiL+U2aR0zzCWOf+uQL3XMSWSCkhIm7RDkG/i7e/fANZb2SzGm7kOBlRyqiQdc0kfW7qxU5K+x/CvkmjsFRlKsa3915s5o6CydOkUt456zpNzks+cBGC05TYOh7QKVRimjS38QiFg53yY0fWOKpOcdGjhSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uctAgBsWbg4zjYa/iQFFs5zeaRx7Y3UIWC12hEqotVg=;
 b=zb6edlEvkPDD9+1/j9A3SneWtQ5bti3EtZ9DzvdrQ7iqbEHvgvio62UH4vv8qegyJk8vB+i9N2hK9PVIR5CR+lx+WLk6Zc7k3NG2U4XlYM014jGz/7eZc8hlFGOLC2C2xjCxFZQjg1deRNDs6BL8tVL0i+q2xjnsVlMEZXX8YOY=
Received: from MW4PR03CA0294.namprd03.prod.outlook.com (2603:10b6:303:b5::29)
 by PH7PR12MB6586.namprd12.prod.outlook.com (2603:10b6:510:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Sat, 18 Nov
 2023 13:55:34 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:b5:cafe::dc) by MW4PR03CA0294.outlook.office365.com
 (2603:10b6:303:b5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25 via Frontend
 Transport; Sat, 18 Nov 2023 13:55:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.13 via Frontend Transport; Sat, 18 Nov 2023 13:55:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 18 Nov
 2023 07:55:32 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 18 Nov
 2023 07:55:31 -0600
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Sat, 18 Nov 2023 07:55:27 -0600
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <broonie@kernel.org>, <tudor.ambarus@linaro.org>,
        <pratyush@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <sbinding@opensource.cirrus.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@tuxon.dev>, <michal.simek@amd.com>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <amitrkcian2002@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH v10 8/8] spi: spi-zynqmp-gqspi: Add parallel memories support in GQSPI driver
Date:   Sat, 18 Nov 2023 19:24:46 +0530
Message-ID: <20231118135446.52783-9-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231118135446.52783-1-amit.kumar-mahapatra@amd.com>
References: <20231118135446.52783-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|PH7PR12MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: 150d683b-7826-4b09-0f61-08dbe83e0871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +FR5/gMrvn2IrCeYCa4W9hTwKTkCWwhXugei2aVa9P7gN79DunOoZ7DTagvaWtFYGkONnOn0A0B+gbF9/AKrQkIDjuvo5wrcXiCXpUH98AaoAEXOhTVgCpfq3iFDh9bSikEK4dNTfJgxij6uA1O+3RobUajjIxGdIdE1NY6YkjrilRf+bFojX4Wn0dgaBq7zVh86sEU7PyesWV857G4E5aMhDgnX+1h7L8inUEXppVlIdZ1yYywdjLJDewhJNGBhu9bJ3edxMGKnG+zJFkVdSYtcF5aFr2utW0AJawoqKCQKy99f8B6Ogw+COYSM4TS3GWtMb2pnDgZIWSrWFbstL10SNaBEo2oYFd1oRCGrO+FPHJbTTbL47RSWInFIt4moH7yS694gmq3oDLp2PuDDv3yB4SQ79X59NL9+VxwN/oQ4JUZjGeAzIHSZXbMr6ODD9aClMaMiXvlZ7Mp2e6TccCH3a/bOh/tDfwkbtHAKBwSJlaz7MVd+isIAxa/B7RLP/TxgRbYljvalQHkE9NnSWWb/zXvUpMTYEqqQYI+hQEXy/DC36XOiaxcFjqYqNczGHgcYBB3QhxCsNvjMGZBk1RgsuIuqv2ZTzD03n+t3jANHsf8ylJWQdxfFt1QQ4icpD0AgqP7zEBStZQR12DkvuF3v117HryNOdwyoJMba7wP/soMVJitYpEGc1vrevYY8wmYC8ILeh7f09Qh9Km+0D9B/My/2yc6DY5TLc7RP9AJA8dySEu6viDb7dVQWVl90VqgO/Zwdsz+MJmYNZn/HHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(70586007)(70206006)(110136005)(54906003)(316002)(36756003)(6666004)(426003)(336012)(2616005)(26005)(1076003)(478600001)(82740400003)(81166007)(356005)(83380400001)(36860700001)(86362001)(47076005)(40480700001)(2906002)(5660300002)(7416002)(4326008)(8676002)(8936002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 13:55:32.8738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 150d683b-7826-4b09-0f61-08dbe83e0871
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6586
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

