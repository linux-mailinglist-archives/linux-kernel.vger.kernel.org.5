Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781E47F001B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 15:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjKROSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 09:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjKRNz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 08:55:58 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE60D1729;
        Sat, 18 Nov 2023 05:55:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEANGkOVgeGW/KyaQwW6vn6UAVqSdBYWYyRprUPz3a3hKyl68udnTh4gSpWygEPp9ORgfe/ca8JH5bfQRws/rCd6GA77T3W6oNfJ8CJVZp4wyMFN28zwO/zSLSOtpKixqpKouRNJj+Im4+YWJ08cEoKP0W8g265xUkhX+TldxuFpkic9ytE71N+ZKoKYBC54cC6vjw7/LgMa9PKlD7OZSak0M7gR35k/7xH2aHCxjXl5nFVOmP4BDGtIkz+NKQsNADGxn/q2Xi3+CPvCrCTSjj1q9swRZM+icBrBXf+m46X2V8ihobR0ICqUQW2OtoIazIM0sbL6PPyMyl1xbAoWtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZI+UijIQF1fK/dzawJBpYzXTXAKf31mUwnNKWerEN8=;
 b=ZJaP9Oy3auRoeCf/XSv4VaUhVRnaQKj/AvEMEf6Yyz+X+i69mmsxaJbZF3IwYnnLtsoFYHSkMoUKWFi48fRa7F66MNdQHu0OcGOyIWHzG4RjnXxzSNbM2bBAW35vd/GRFWJeCJiiCgzmUy82+p9ujFrwz9zvTG77UqoWTJJpKL80UB2KwNzRzaqn1vQFwnmaxnbFSAzOMxHCoFvvvqnce6rIgckLKyHCl3HsnGJ1WUvRhVtqzU3NnWMAgCoecfHDCsz97U6RNlCsjnF7mMSM/bL80Pp/1/neBu7vbbbozCBKH4gWYqWWZKu97No9IOduwpHHEx5benRLyQ9gVYjOJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZI+UijIQF1fK/dzawJBpYzXTXAKf31mUwnNKWerEN8=;
 b=TPbnoZgMmTX8kEnzfYV5rdOu+gcM8L0dd+Kh7z79z+HbbaiKRmb8hjsWJ4r8vmjxDyqLoGnZzQ0m7nw6Le4WjWBue6f1GzY3T1NZbiK3XpNDGeT+LOKGhDcTRy72Ov36MGO464f0A4gG7V418TtIc8RWedQebh896DqjbbausDE=
Received: from CH2PR12CA0026.namprd12.prod.outlook.com (2603:10b6:610:57::36)
 by PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Sat, 18 Nov
 2023 13:55:28 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::6e) by CH2PR12CA0026.outlook.office365.com
 (2603:10b6:610:57::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26 via Frontend
 Transport; Sat, 18 Nov 2023 13:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Sat, 18 Nov 2023 13:55:27 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 18 Nov
 2023 07:55:27 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 18 Nov
 2023 07:55:26 -0600
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Sat, 18 Nov 2023 07:55:22 -0600
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
Subject: [PATCH v10 7/8] mtd: spi-nor: Add parallel memories support in spi-nor
Date:   Sat, 18 Nov 2023 19:24:45 +0530
Message-ID: <20231118135446.52783-8-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231118135446.52783-1-amit.kumar-mahapatra@amd.com>
References: <20231118135446.52783-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|PH0PR12MB5417:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e4dfede-9404-4250-ef03-08dbe83e056a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xMPRiRTKef1MGZJeVVbvSNa1ZqOXcIuIcpNKAXhFZPnxUjKhfxKKsaPIZ07VTgTocJ/0ZHjZQu1yIkTu33CTSwKU305taf1AE6sh9LEyimAxmA8qap0+eEmJy58XGyPykoO/X3YFcuMfTZc6SZf4e7XOBF9wVUeIwtuOUVGGt46KRiZJfACX9r+tBtIRQ1wILV8ZpDYQGKli4DErKiZnBggExztjv9yIrrXyjDZYvKoJUshm04cYxlmG1aTy0toFYabNg6PMKPOTbmgsDSTc9DediWRJlfDTh9F4iF7+OKW5qS6IY6neTtBCDk9PrfKylZl/1vLytXIS57/KydNFEidGtIyEuCzRQp+BdD2s5MYgcrZA9BXYZwHE11U366pBdJzi4Y0QtZ7MXVxp9yVd1Prce/w1ndCCA1sPTtlJqz2+ngOoGtyFhXvmKI+YeigCIh0TtMW8CX1Tf1H4JqFMzRqviIpTfwjJfv7KYaqp7eu3I1KwCJNWqqSCenzEqhx7E5aclguukYARWRYFsjuGFAO822LagILk5QfnpxDZt6s74etLI78V9I2uHtJA6C0YakFWxVo0JfCHZ8bZtRNaFodcpifviBzElyMQAbth+wL30kZliI0GKQmUECcEq5qIPv5oXJOKqUlzbQmK1co4GiJlFWckjQACokG8FbelqJO0BRj6RPNlHE2cBsl1/ScPefWCLWIDivHyrzitWd765jSwCh4LAjQIarwIzsbZisRDYXB450Nlg2i0t/fie7MHV5PnUUIRcOYRIAoRwZkiGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(81166007)(356005)(40480700001)(40460700003)(47076005)(4326008)(8676002)(8936002)(316002)(70586007)(54906003)(70206006)(30864003)(7416002)(6666004)(478600001)(110136005)(5660300002)(86362001)(2906002)(2616005)(41300700001)(36860700001)(36756003)(426003)(336012)(82740400003)(26005)(83380400001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 13:55:27.8786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4dfede-9404-4250-ef03-08dbe83e056a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5417
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation assumes that a maximum of two flashes are
connected in parallel mode. The QSPI controller splits the data evenly
between both the flashes so, both the flashes that are connected in
parallel mode should be identical.
During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1 in
nor->spimem->spi->cs_index_mask. The QSPI driver will then assert/de-assert
CS0 & CS1.
Write operation in parallel mode are performed in page size * 2 chunks as
each write operation results in writing both the flashes. For doubling the
address space each operation is performed at addr/2 flash offset, where
addr is the address specified by the user.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 drivers/mtd/spi-nor/core.c      | 409 +++++++++++++++++++++++++-------
 drivers/mtd/spi-nor/core.h      |   4 +
 drivers/mtd/spi-nor/micron-st.c |   5 +
 3 files changed, 333 insertions(+), 85 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index e990be7c7eb6..2e6cc45341ed 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -470,17 +470,29 @@ int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
 			op.data.nbytes = 2;
 		}
 
+		if (nor->flags & SNOR_F_HAS_PARALLEL)
+			op.data.nbytes = 2;
+
 		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = spi_nor_controller_ops_read_reg(nor, SPINOR_OP_RDSR, sr,
-						      1);
+		if (nor->flags & SNOR_F_HAS_PARALLEL)
+			ret = spi_nor_controller_ops_read_reg(nor,
+							      SPINOR_OP_RDSR,
+							      sr, 2);
+		else
+			ret = spi_nor_controller_ops_read_reg(nor,
+							      SPINOR_OP_RDSR,
+							      sr, 1);
 	}
 
 	if (ret)
 		dev_dbg(nor->dev, "error %d reading SR\n", ret);
 
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		sr[0] |= sr[1];
+
 	return ret;
 }
 
@@ -1824,6 +1836,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 	struct spi_nor_flash_parameter *params;
 	u32 addr, len, offset, cur_cs_num = 0;
 	uint32_t rem;
+	u32 n_flash = 1;
 	int ret;
 	u64 sz;
 
@@ -1833,6 +1846,9 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 	params = spi_nor_get_params(nor, 0);
 	sz = params->size;
 
+	if (nor->num_flash)
+		n_flash = nor->num_flash;
+
 	if (spi_nor_has_uniform_erase(nor)) {
 		div_u64_rem(instr->len, mtd->erasesize, &rem);
 		if (rem)
@@ -1854,53 +1870,82 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 		if (ret)
 			goto erase_err;
 
-		while (cur_cs_num < nor->num_flash) {
-			nor->spimem->spi->cs_index_mask = 0x01 << cur_cs_num;
+		if (nor->flags & SNOR_F_HAS_PARALLEL) {
+			nor->spimem->spi->cs_index_mask = SPI_NOR_ENABLE_MULTI_CS;
 			ret = spi_nor_erase_chip(nor);
 			spi_nor_unlock_device(nor);
 			if (ret)
 				goto erase_err;
 
 			/*
-			 * Scale the timeout linearly with the size of the flash, with
-			 * a minimum calibrated to an old 2MB flash. We could try to
-			 * pull these from CFI/SFDP, but these values should be good
-			 * enough for now.
-			 */
+			* Scale the timeout linearly with the size of the flash, with
+			* a minimum calibrated to an old 2MB flash. We could try to
+			* pull these from CFI/SFDP, but these values should be good
+			* enough for now.
+			*/
 			timeout = max(CHIP_ERASE_2MB_READY_WAIT_JIFFIES,
-				      CHIP_ERASE_2MB_READY_WAIT_JIFFIES *
-				      (unsigned long)(params->size / SZ_2M));
+					CHIP_ERASE_2MB_READY_WAIT_JIFFIES *
+					(unsigned long)(mtd->size / SZ_2M));
 			ret = spi_nor_wait_till_ready_with_timeout(nor, timeout);
 			if (ret)
 				goto erase_err;
-			cur_cs_num++;
-		}
 
+		} else {
+			while (cur_cs_num < n_flash) {
+				nor->spimem->spi->cs_index_mask = 1 << cur_cs_num;
+				ret = spi_nor_erase_chip(nor);
+				spi_nor_unlock_device(nor);
+				if (ret)
+					goto erase_err;
+
+				/*
+				 * Scale the timeout linearly with the size of the flash, with
+				 * a minimum calibrated to an old 2MB flash. We could try to
+				 * pull these from CFI/SFDP, but these values should be good
+				 * enough for now.
+				 */
+				timeout = max(CHIP_ERASE_2MB_READY_WAIT_JIFFIES,
+					      CHIP_ERASE_2MB_READY_WAIT_JIFFIES *
+						(unsigned long)(params->size / SZ_2M));
+				ret = spi_nor_wait_till_ready_with_timeout(nor, timeout);
+				if (ret)
+					goto erase_err;
+
+				cur_cs_num++;
+				params = spi_nor_get_params(nor, cur_cs_num);
+			}
+		}
 	/* REVISIT in some cases we could speed up erasing large regions
 	 * by using SPINOR_OP_SE instead of SPINOR_OP_BE_4K.  We may have set up
 	 * to use "small sector erase", but that's not always optimal.
 	 */
-
 	/* "sector"-at-a-time erase */
 	} else if (spi_nor_has_uniform_erase(nor)) {
-		/* Determine the flash from which the operation need to start */
-		while ((cur_cs_num < nor->num_flash) && (addr > sz - 1)) {
-			cur_cs_num++;
-			params = spi_nor_get_params(nor, cur_cs_num);
-			sz += params->size;
+		if (!(nor->flags & SNOR_F_HAS_PARALLEL)) {
+			while ((cur_cs_num < n_flash) && (addr > sz - 1)) {
+				cur_cs_num++;
+				params = spi_nor_get_params(nor, cur_cs_num);
+				sz += params->size;
+			}
 		}
-
 		while (len) {
 			ret = spi_nor_lock_device(nor);
 			if (ret)
 				goto erase_err;
 
-			nor->spimem->spi->cs_index_mask = 0x01 << cur_cs_num;
 			offset = addr;
 			if (nor->flags & SNOR_F_HAS_STACKED) {
 				params = spi_nor_get_params(nor, cur_cs_num);
 				offset -= (sz - params->size);
 			}
+			nor->spimem->spi->cs_index_mask = 1 << cur_cs_num;
+			if (nor->flags & SNOR_F_HAS_PARALLEL) {
+				u64 aux = offset;
+
+				ret = do_div(aux, n_flash);
+				offset = aux;
+				nor->spimem->spi->cs_index_mask = SPI_NOR_ENABLE_MULTI_CS;
+			}
 
 			ret = spi_nor_erase_sector(nor, offset);
 			spi_nor_unlock_device(nor);
@@ -1923,34 +1968,42 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 				sz += params->size;
 			}
 		}
-
 	/* erase multiple sectors */
 	} else {
-		u64 erase_len = 0;
+		if (nor->flags & SNOR_F_HAS_PARALLEL) {
+			u64 aux = offset;
 
-		/* Determine the flash from which the operation need to start */
-		while ((cur_cs_num < nor->num_flash) && (addr > sz - 1)) {
-			cur_cs_num++;
-			params = spi_nor_get_params(nor, cur_cs_num);
-			sz += params->size;
-		}
-		/* perform multi sector erase onec per Flash*/
-		while (len) {
-			erase_len = (len > (sz - addr)) ? (sz - addr) : len;
-			offset = addr;
-			nor->spimem->spi->cs_index_mask = 0x01 << cur_cs_num;
-			if (nor->flags & SNOR_F_HAS_STACKED) {
-				params = spi_nor_get_params(nor, cur_cs_num);
-				offset -= (sz - params->size);
-			}
-			ret = spi_nor_erase_multi_sectors(nor, offset, erase_len);
+			ret = do_div(aux, n_flash);
+			offset = aux;
+			ret = spi_nor_erase_multi_sectors(nor, addr, len);
 			if (ret)
 				goto erase_err;
-			len -= erase_len;
-			addr += erase_len;
-			cur_cs_num++;
-			params = spi_nor_get_params(nor, cur_cs_num);
-			sz += params->size;
+		} else {
+			u64 erase_len = 0;
+
+			/* Determine the flash from which the operation need to start */
+			while ((cur_cs_num < n_flash) && (addr > sz - 1)) {
+				cur_cs_num++;
+				params = spi_nor_get_params(nor, cur_cs_num);
+				sz += params->size;
+			}
+			/* perform multi sector erase onec per Flash*/
+			while (len) {
+				erase_len = (len > (sz - addr)) ? (sz - addr) : len;
+				offset = addr;
+				nor->spimem->spi->cs_index_mask = 1 << cur_cs_num;
+				if (nor->flags & SNOR_F_HAS_STACKED) {
+					params = spi_nor_get_params(nor, cur_cs_num);
+					offset -= (sz - params->size);
+				}
+				ret = spi_nor_erase_multi_sectors(nor, offset, erase_len);
+				if (ret)
+					goto erase_err;
+				len -= erase_len;
+				addr += erase_len;
+				params = spi_nor_get_params(nor, cur_cs_num);
+				sz += params->size;
+			}
 		}
 	}
 
@@ -2144,9 +2197,12 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
 	struct spi_nor_flash_parameter *params;
 	ssize_t ret, read_len, len_lock =  len;
+	bool is_ofst_odd = false;
 	loff_t from_lock = from;
 	u32 cur_cs_num = 0;
-	u64 sz;
+	u_char *readbuf;
+	u32 n_flash = 1;
+	u64 sz = 0;
 
 	dev_dbg(nor->dev, "from 0x%08x, len %zd\n", (u32)from, len);
 
@@ -2157,23 +2213,54 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	params = spi_nor_get_params(nor, 0);
 	sz = params->size;
 
-	/* Determine the flash from which the operation need to start */
-	while ((cur_cs_num < nor->num_flash) && (from > sz - 1)) {
-		cur_cs_num++;
-		params = spi_nor_get_params(nor, cur_cs_num);
-		sz += params->size;
+	if (nor->num_flash)
+		n_flash = nor->num_flash;
+
+	/*
+	 * When even number of flashes are connected in parallel and the
+	 * requested read length is odd then read (len + 1) from offset + 1
+	 * and ignore offset[0] data.
+	 */
+	if ((nor->flags & SNOR_F_HAS_PARALLEL) && (!(n_flash % 2)) && (from & 0x01)) {
+		from = (loff_t)(from - 1);
+		len = (size_t)(len + 1);
+		is_ofst_odd = true;
+		readbuf = kmalloc(len, GFP_KERNEL);
+		if (!readbuf)
+			return -ENOMEM;
+	} else {
+		readbuf = buf;
 	}
+
+	if (!(nor->flags & SNOR_F_HAS_PARALLEL)) {
+		/* Determine the flash from which the operation need to start */
+		while ((cur_cs_num < n_flash) && (from > sz - 1)) {
+			cur_cs_num++;
+			params = spi_nor_get_params(nor, cur_cs_num);
+			sz += params->size;
+		}
+	}
+
 	while (len) {
 		loff_t addr = from;
 
-		nor->spimem->spi->cs_index_mask = 0x01 << cur_cs_num;
-		read_len = (len > (sz - addr)) ? (sz - addr) : len;
-		params = spi_nor_get_params(nor, cur_cs_num);
-		addr -= (sz - params->size);
+		if (nor->flags & SNOR_F_HAS_PARALLEL) {
+			u64 aux = addr;
+
+			ret = do_div(aux, n_flash);
+			addr = aux;
+			nor->spimem->spi->cs_index_mask = SPI_NOR_ENABLE_MULTI_CS;
+			read_len = len;
+		} else {
+			nor->spimem->spi->cs_index_mask = 1 << cur_cs_num;
+			read_len = (len > (sz - addr)) ? (sz - addr) : len;
+			params = spi_nor_get_params(nor, cur_cs_num);
+			addr -= (sz - params->size);
+		}
 
 		addr = spi_nor_convert_addr(nor, addr);
 
-		ret = spi_nor_read_data(nor, addr, len, buf);
+		ret = spi_nor_read_data(nor, addr, read_len, readbuf);
 		if (ret == 0) {
 			/* We shouldn't see 0-length reads */
 			ret = -EIO;
@@ -2183,8 +2270,20 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 			goto read_err;
 
 		WARN_ON(ret > read_len);
-		*retlen += ret;
+		if (is_ofst_odd) {
+			/*
+			 * Cannot read from odd offset in parallel mode.
+			 * So read len + 1 from offset + 1 from the flash
+			 * and copy len data from readbuf[1].
+			 */
+			memcpy(buf, (readbuf + 1), (len - 1));
+			*retlen += (ret - 1);
+		} else {
+			*retlen += ret;
+		}
 		buf += ret;
+		if (!is_ofst_odd)
+			readbuf += ret;
 		from += ret;
 		len -= ret;
 
@@ -2202,8 +2301,10 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	ret = 0;
 
 read_err:
-	spi_nor_unlock_and_unprep_rd(nor, from_lock, len_lock);
+	if (is_ofst_odd)
+		kfree(readbuf);
 
+	spi_nor_unlock_and_unprep_rd(nor, from_lock, len_lock);
 	return ret;
 }
 
@@ -2219,6 +2320,7 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 	struct spi_nor_flash_parameter *params;
 	size_t page_offset, page_remain, i;
 	u32 page_size, cur_cs_num = 0;
+	u32 n_flash = 1;
 	ssize_t ret;
 	u64 sz;
 
@@ -2232,11 +2334,41 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 	page_size = params->page_size;
 	sz = params->size;
 
-	/* Determine the flash from which the operation need to start */
-	while ((cur_cs_num < nor->num_flash) && (to > sz - 1)) {
-		cur_cs_num++;
-		params = spi_nor_get_params(nor, cur_cs_num);
-		sz += params->size;
+	if (nor->num_flash)
+		n_flash = nor->num_flash;
+
+	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+		/*
+		 * When even number of flashes are connected in parallel and the
+		 * requested write length is odd then first write 2 bytes.
+		 */
+		if ((!(n_flash % 2)) && (to & 0x01)) {
+			u8 two[2] = {0xff, buf[0]};
+			size_t written_len;
+
+			ret = spi_nor_write(mtd, to & ~1, 2, &written_len, two);
+			if (ret < 0)
+				return ret;
+			*retlen += 1; /* We've written only one actual byte */
+			++buf;
+			--len;
+			++to;
+		}
+		/*
+		 * Write operation are performed in page size chunks and in
+		 * parallel memories both the flashes are written simultaneously,
+		 * hence increase the page_size in multiple of the number of flash
+		 * connected in parallel.
+		 */
+		page_size *= n_flash;
+
+	} else {
+		/* Determine the flash from which the operation need to start */
+		while ((cur_cs_num < n_flash) && (to > sz - 1)) {
+			cur_cs_num++;
+			params = spi_nor_get_params(nor, cur_cs_num);
+			sz += params->size;
+		}
 	}
 
 	for (i = 0; i < len; ) {
@@ -2258,9 +2390,17 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 		/* the size of data remaining on the first page */
 		page_remain = min_t(size_t, page_size - page_offset, len - i);
 
-		nor->spimem->spi->cs_index_mask = 0x01 << cur_cs_num;
-		params = spi_nor_get_params(nor, cur_cs_num);
-		addr -= (sz - params->size);
+		if (nor->flags & SNOR_F_HAS_PARALLEL) {
+			u64 aux = addr;
+
+			ret = do_div(aux, n_flash);
+			addr = aux;
+			nor->spimem->spi->cs_index_mask = SPI_NOR_ENABLE_MULTI_CS;
+		} else {
+			nor->spimem->spi->cs_index_mask = 1 << cur_cs_num;
+			params = spi_nor_get_params(nor, cur_cs_num);
+			addr -= (sz - params->size);
+		}
 
 		addr = spi_nor_convert_addr(nor, addr);
 
@@ -2701,7 +2841,15 @@ static int spi_nor_select_erase(struct spi_nor *nor)
 		if (!erase)
 			return -EINVAL;
 		nor->erase_opcode = erase->opcode;
-		mtd->erasesize = erase->size;
+		/*
+		 * In parallel-memories the erase operation is
+		 * performed on both the flashes simultaneously
+		 * so, double the erasesize.
+		 */
+		if (nor->flags & SNOR_F_HAS_PARALLEL)
+			mtd->erasesize = erase->size * 2;
+		else
+			mtd->erasesize = erase->size;
 		return 0;
 	}
 
@@ -2719,7 +2867,15 @@ static int spi_nor_select_erase(struct spi_nor *nor)
 	if (!erase)
 		return -EINVAL;
 
-	mtd->erasesize = erase->size;
+	/*
+	 * In parallel-memories the erase operation is
+	 * performed on both the flashes simultaneously
+	 * so, double the erasesize.
+	 */
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		mtd->erasesize = erase->size * 2;
+	else
+		mtd->erasesize = erase->size;
 	return 0;
 }
 
@@ -3060,6 +3216,17 @@ static int spi_nor_late_init_params(struct spi_nor *nor)
 
 		nor->num_flash++;
 	}
+	idx = 0;
+	while (idx < SNOR_FLASH_CNT_MAX) {
+		rc = of_property_read_u64_index(np, "parallel-memories", idx, &flash_size[idx]);
+		if (rc)
+			break;
+		idx++;
+		if (!(nor->flags & SNOR_F_HAS_PARALLEL))
+			nor->flags |= SNOR_F_HAS_PARALLEL;
+
+		nor->num_flash++;
+	}
 
 	/*
 	 * By default one flash device should be connected
@@ -3068,7 +3235,7 @@ static int spi_nor_late_init_params(struct spi_nor *nor)
 	if (!nor->num_flash)
 		nor->num_flash = 1;
 
-	if (nor->flags & SNOR_F_HAS_STACKED) {
+	if (nor->flags & (SNOR_F_HAS_STACKED | SNOR_F_HAS_PARALLEL)) {
 		for (idx = 1; idx < nor->num_flash; idx++) {
 			params = spi_nor_get_params(nor, idx);
 			params = devm_kzalloc(nor->dev, sizeof(*params), GFP_KERNEL);
@@ -3289,10 +3456,14 @@ static int spi_nor_set_octal_dtr(struct spi_nor *nor, bool enable)
 static int spi_nor_quad_enable(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter *params;
+	u32 n_flash = 1;
 	int err, idx;
 
-	for (idx = 0; idx < nor->num_flash; idx++) {
-		params = spi_nor_get_params(nor, idx);
+	if (nor->num_flash)
+		n_flash = nor->num_flash;
+
+	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+		params = spi_nor_get_params(nor, 0);
 		if (!params->quad_enable)
 			return 0;
 
@@ -3300,14 +3471,32 @@ static int spi_nor_quad_enable(struct spi_nor *nor)
 		      spi_nor_get_protocol_width(nor->write_proto) == 4))
 			return 0;
 		/*
-		 * Set the appropriate CS index before
-		 * issuing the command.
+		 * In parallel mode both chip selects i.e., CS0 &
+		 * CS1 need to be asserted simulatneously.
 		 */
-		nor->spimem->spi->cs_index_mask = 0x01 << idx;
-
+		nor->spimem->spi->cs_index_mask = SPI_NOR_ENABLE_MULTI_CS;
 		err = params->quad_enable(nor);
 		if (err)
 			return err;
+	} else {
+		for (idx = 0; idx < n_flash; idx++) {
+			params = spi_nor_get_params(nor, idx);
+			if (!params->quad_enable)
+				return 0;
+
+			if (!(spi_nor_get_protocol_width(nor->read_proto) == 4 ||
+			      spi_nor_get_protocol_width(nor->write_proto) == 4))
+				return 0;
+			/*
+			 * Set the appropriate CS index before
+			 * issuing the command.
+			 */
+			nor->spimem->spi->cs_index_mask = 1 << idx;
+
+			err = params->quad_enable(nor);
+			if (err)
+				return err;
+		}
 	}
 	return err;
 }
@@ -3341,8 +3530,12 @@ int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 
 static int spi_nor_init(struct spi_nor *nor)
 {
+	u32 n_flash = 1;
 	int err, idx;
 
+	if (nor->num_flash)
+		n_flash = nor->num_flash;
+
 	err = spi_nor_set_octal_dtr(nor, true);
 	if (err) {
 		dev_dbg(nor->dev, "octal mode not supported\n");
@@ -3382,15 +3575,26 @@ static int spi_nor_init(struct spi_nor *nor)
 		 */
 		WARN_ONCE(nor->flags & SNOR_F_BROKEN_RESET,
 			  "enabling reset hack; may not recover from unexpected reboots\n");
-		for (idx = 0; idx < nor->num_flash; idx++) {
+		if (nor->flags & SNOR_F_HAS_PARALLEL) {
 			/*
-			 * Select the appropriate CS index before
-			 * issuing the command.
+			 * In parallel mode both chip selects i.e., CS0 &
+			 * CS1 need to be asserted simulatneously.
 			 */
-			nor->spimem->spi->cs_index_mask = 0x01 << idx;
+			nor->spimem->spi->cs_index_mask = SPI_NOR_ENABLE_MULTI_CS;
 			err = spi_nor_set_4byte_addr_mode(nor, true);
 			if (err)
 				return err;
+		} else {
+			for (idx = 0; idx < n_flash; idx++) {
+				/*
+				 * Select the appropriate CS index before
+				 * issuing the command.
+				 */
+				nor->spimem->spi->cs_index_mask = 1 << idx;
+				err = spi_nor_set_4byte_addr_mode(nor, true);
+				if (err)
+					return err;
+			}
 		}
 	}
 
@@ -3505,19 +3709,23 @@ static void spi_nor_put_device(struct mtd_info *mtd)
 
 static void spi_nor_restore(struct spi_nor *nor)
 {
+	u32 n_flash = 1;
 	int ret;
 	int idx;
 
+	if (nor->num_flash)
+		n_flash = nor->num_flash;
+
 	/* restore the addressing mode */
 	if (nor->addr_nbytes == 4 && !(nor->flags & SNOR_F_4B_OPCODES) &&
 	    nor->flags & SNOR_F_BROKEN_RESET) {
-		for (idx = 0; idx < nor->num_flash; idx++) {
+		if (nor->flags & SNOR_F_HAS_PARALLEL) {
 			/*
-			 * Select the appropriate CS index before
-			 * issuing the command.
+			 * In parallel mode both chip selects i.e., CS0 &
+			 * CS1 need to be asserted simulatneously.
 			 */
-			nor->spimem->spi->cs_index_mask = 1 << idx;
-			ret = spi_nor_set_4byte_addr_mode(nor, false);
+			nor->spimem->spi->cs_index_mask = SPI_NOR_ENABLE_MULTI_CS;
+			spi_nor_set_4byte_addr_mode(nor, false);
 			if (ret)
 				/*
 				 * Do not stop the execution in the hope that the flash
@@ -3527,6 +3735,24 @@ static void spi_nor_restore(struct spi_nor *nor)
 				dev_err(nor->dev,
 					"Failed to exit 4-byte address mode, err = %d\n",
 					ret);
+		} else {
+			for (idx = 0; idx < n_flash; idx++) {
+				/*
+				 * Select the appropriate CS index before
+				 * issuing the command.
+				 */
+				nor->spimem->spi->cs_index_mask = 1 << idx;
+				ret = spi_nor_set_4byte_addr_mode(nor, false);
+				if (ret)
+					/*
+					 * Do not stop the execution in the hope that the
+					 * flash will default to the 3-byte address mode
+					 * after the software reset.
+					 */
+					dev_err(nor->dev,
+						"Failed to exit 4-byte address mode, err = %d\n",
+						ret);
+			}
 		}
 	}
 
@@ -3595,11 +3821,15 @@ static void spi_nor_set_mtd_info(struct spi_nor *nor)
 	struct mtd_info *mtd = &nor->mtd;
 	struct device *dev = nor->dev;
 	u64 total_sz = 0;
+	u32 n_flash = 1;
 	int idx;
 
 	spi_nor_set_mtd_locking_ops(nor);
 	spi_nor_set_mtd_otp_ops(nor);
 
+	if (nor->num_flash)
+		n_flash = nor->num_flash;
+
 	mtd->dev.parent = dev;
 	if (!mtd->name)
 		mtd->name = dev_name(dev);
@@ -3613,8 +3843,17 @@ static void spi_nor_set_mtd_info(struct spi_nor *nor)
 	else
 		mtd->_erase = spi_nor_erase;
 	mtd->writesize = params->writesize;
-	mtd->writebufsize = params->page_size;
-	for (idx = 0; idx < nor->num_flash; idx++) {
+	/*
+	 * In parallel-memories the write operation is
+	 * performed on both the flashes simultaneously
+	 * one page per flash, so double the writebufsize.
+	 */
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		mtd->writebufsize = params->page_size << 1;
+	else
+		mtd->writebufsize = params->page_size;
+
+	for (idx = 0; idx < n_flash; idx++) {
 		params = spi_nor_get_params(nor, idx);
 		total_sz += params->size;
 	}
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index b2997eca7551..6c3009796013 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -21,6 +21,9 @@
 /* In single configuration enable CS0 */
 #define SPI_NOR_ENABLE_CS0     BIT(0)
 
+/* In parallel configuration enable multiple CS */
+#define SPI_NOR_ENABLE_MULTI_CS	(BIT(0) | BIT(1))
+
 /* Standard SPI NOR flash operations. */
 #define SPI_NOR_READID_OP(naddr, ndummy, buf, len)			\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 0),			\
@@ -144,6 +147,7 @@ enum spi_nor_option_flags {
 	SNOR_F_ECC		= BIT(15),
 	SNOR_F_NO_WP		= BIT(16),
 	SNOR_F_HAS_STACKED      = BIT(17),
+	SNOR_F_HAS_PARALLEL	= BIT(18),
 };
 
 struct spi_nor_read_command {
diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 813a5b1a269b..577121ebd6e8 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -478,6 +478,9 @@ static int micron_st_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 			op.data.nbytes = 2;
 		}
 
+		if (nor->flags & SNOR_F_HAS_PARALLEL)
+			op.data.nbytes = 2;
+
 		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
@@ -489,6 +492,8 @@ static int micron_st_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 	if (ret)
 		dev_dbg(nor->dev, "error %d reading FSR\n", ret);
 
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		fsr[0] &= fsr[1];
 	return ret;
 }
 
-- 
2.17.1

