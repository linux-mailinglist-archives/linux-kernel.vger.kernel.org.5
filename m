Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14B07CEA15
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjJRVei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjJRVe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:34:27 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58A6191;
        Wed, 18 Oct 2023 14:34:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NV0/ozMkpftfK1f8m01drkrOrvVy0yKqh1Yk6Ch7SGyXG0AiI+klZoPzj+d3wG4jdDibRC52XO+UjLaI1tlK8guf3/ytQpeFWStlnJy/FeWNgWoxKdW19DB2puHKAp5kRto76U5KJa7/GGzhiGpctbbUYyEbG7fdvI6ZMuTUG7o8v7+NAHXy6t62md5Z/u9txkAyhhXb/RDaDth3gQ0E+5cVfT/kLvhSv0GtWgjDEtPosmBzSyBX/gt54cHya8eAEwACPrba27EOrm9Q1WJOUWNMipFSTzxgVa7sHavUKEGIh7IwaKs5o0oXAG76MEKTNxybJmppcSnEpoq7DumNOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hTiAM7lZyRuu8gHyeHcxDR709uFZddNWoaMnXILV3E=;
 b=bhmIaDkWrtHrV/rVjra64v53IfIdOAtrtN+IjWhz7kiMkbTEg16tzWiRPajW7Wx/BmHLN8I+9Ksdp9PfxSmvASCacPPwOOUUV6K6BSCtHyDnNgSLYC9UGuZB8Rxm3sOgcKycfSqVGkzHHA6FxqvSX7duZAtLE0rEyNgVe1UswZm1+k/jgbuhb5y4eSt1MvWD4eHJfpyXmCIsY2Rw5HiFDs4AIDCeazNDinAzzVXeVx92jdM/YC4ZUUmBnzDE8NormFWdQkNfRRBYlGHXCierVCPKGD7hqK3lwmdAnNWOapXHUwy0D2J1M+HVYEL40oxxMtQxOegbFZNB2cYDZ2TCXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hTiAM7lZyRuu8gHyeHcxDR709uFZddNWoaMnXILV3E=;
 b=p2D9vBW618XkUmJWve98dqk02hMzx/tfHONdjAMYtsTvMeYIFz1b/r1fkjXC9f7JaTy39G0qOe1AuYaeWi1lVpP6MXRA1HwazadApB1cTdMuckQ68AvBpLJMIZFXIDW9BA+U3WsmYdgy7yjaW4Je6VYt/3N8gvZu08BEUjl7gJg=
Received: from MN2PR02CA0027.namprd02.prod.outlook.com (2603:10b6:208:fc::40)
 by MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 21:34:15 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:fc:cafe::dc) by MN2PR02CA0027.outlook.office365.com
 (2603:10b6:208:fc::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Wed, 18 Oct 2023 21:34:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 21:34:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 16:34:13 -0500
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Wed, 18 Oct 2023 16:34:08 -0500
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
Subject: [PATCH v9 7/8] mtd: spi-nor: Add parallel memories support in spi-nor
Date:   Thu, 19 Oct 2023 03:03:27 +0530
Message-ID: <20231018213328.40131-8-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231018213328.40131-1-amit.kumar-mahapatra@amd.com>
References: <20231018213328.40131-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|MN0PR12MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d27c191-bfd9-4a76-9816-08dbd021fa61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zx9ZsjNAe0XCAnzgoR0zUakSBo7K8hZzzyeAH29L7TQIEIDBWCFDUTrWuw0S0gXIDLj2skNIQWU3QJsXVYc/5piHo+33A03omBc+HDREhtTVUrNEHKhrbqjBX+1gPMiwPWmN8HHUZKWXBtXwOdgjSbgGwryiigTtoXCI2qxjRt3nQT9s7OgUqbZZ7OpLIEd8ysz9Ta3IORogDy5aqjfc6oV86I/vC+uu74VEVSsYySUEbB8nGjQxgKrwdNzJhdpLcG5/O0gw4y69y5BAo5kCy0lyu46PdAavqkWV6AYO0TRgBR9kEN8MzU/vy72LqlWulE0gVhNrfnZx8b2bZeSZAPhvMXXWYnD2Jt2vDyRziW1HHhFLhD7t0nPG5Y0zJV7m0yZc1n0ZYRr+TjZ1YJEwvWC3gPCrHNY6YA4WX759DfosR0CUJece4bC1QSDDLjBhxmA3FBk1K/dLsq/S84HVQW8KVrcnYiEtYeSSEZiAmZH9S8pwWT6zVPywuQlnhSeMtJYDKa2sTdnjXr1bfH+C99xV8BzbXHgf1+a2qRHW2+ARDTXF5OWDs4HJR1F6TKZrDRAZs4Ahy+QaL0wBl8+bRxGhLwBwTpAQ4Bpjfu59pHQiAlDMQMYfMyqchZpQiJVB/sy4UFtd4UXL7PfmCsoJk3i8QjS0phIguVr/Sz4CazXLw9FBSzZbA/c4QmNSm637K7EpPdEH8yWJ+3YLjfcnKXTiAKJHdJj5eLbFeiKt2LiDQaTHb8B0sihs13aYO0y/H+VsLISIS4x7teOHp/OVqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(478600001)(70206006)(110136005)(54906003)(70586007)(6666004)(36860700001)(47076005)(83380400001)(82740400003)(86362001)(356005)(2616005)(26005)(316002)(426003)(1076003)(336012)(36756003)(81166007)(41300700001)(2906002)(8676002)(5660300002)(4326008)(8936002)(7416002)(30864003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 21:34:15.5316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d27c191-bfd9-4a76-9816-08dbd021fa61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
 drivers/mtd/spi-nor/core.c      | 412 +++++++++++++++++++++++++-------
 drivers/mtd/spi-nor/core.h      |   4 +
 drivers/mtd/spi-nor/micron-st.c |   5 +
 3 files changed, 336 insertions(+), 85 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 115d7bf7d6ca..94786cccd416 100644
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
@@ -1854,53 +1870,85 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
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
+			/*
+			 * ADD NOTE: for why we are dividing the address by 2
+			 */
+			if (nor->flags & SNOR_F_HAS_PARALLEL) {
+				u64 aux = offset;
+
+				ret = do_div(aux, n_flash);
+				offset = aux;
+				nor->spimem->spi->cs_index_mask = SPI_NOR_ENABLE_MULTI_CS;
+			}
 
 			ret = spi_nor_erase_sector(nor, offset);
 			spi_nor_unlock_device(nor);
@@ -1923,34 +1971,42 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
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
 
@@ -2153,9 +2209,12 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
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
 
@@ -2166,23 +2225,54 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
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
@@ -2192,8 +2282,20 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
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
 
@@ -2211,8 +2313,10 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	ret = 0;
 
 read_err:
-	spi_nor_unlock_and_unprep_rd(nor, from_lock, len_lock);
+	if (is_ofst_odd)
+		kfree(readbuf);
 
+	spi_nor_unlock_and_unprep_rd(nor, from_lock, len_lock);
 	return ret;
 }
 
@@ -2228,6 +2332,7 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 	struct spi_nor_flash_parameter *params;
 	size_t page_offset, page_remain, i;
 	u32 page_size, cur_cs_num = 0;
+	u32 n_flash = 1;
 	ssize_t ret;
 	u64 sz;
 
@@ -2241,11 +2346,41 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
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
@@ -2267,9 +2402,17 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
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
 
@@ -2719,7 +2862,15 @@ static int spi_nor_select_erase(struct spi_nor *nor)
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
 
@@ -2737,7 +2888,15 @@ static int spi_nor_select_erase(struct spi_nor *nor)
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
 
@@ -3074,6 +3233,17 @@ static int spi_nor_late_init_params(struct spi_nor *nor)
 
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
@@ -3082,7 +3252,7 @@ static int spi_nor_late_init_params(struct spi_nor *nor)
 	if (!nor->num_flash)
 		nor->num_flash = 1;
 
-	if (nor->flags & SNOR_F_HAS_STACKED) {
+	if (nor->flags & (SNOR_F_HAS_STACKED | SNOR_F_HAS_PARALLEL)) {
 		for (idx = 1; idx < nor->num_flash; idx++) {
 			params = spi_nor_get_params(nor, idx);
 			params = devm_kzalloc(nor->dev, sizeof(*params), GFP_KERNEL);
@@ -3305,10 +3475,14 @@ static int spi_nor_set_octal_dtr(struct spi_nor *nor, bool enable)
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
 
@@ -3316,14 +3490,32 @@ static int spi_nor_quad_enable(struct spi_nor *nor)
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
@@ -3357,8 +3549,12 @@ int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 
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
@@ -3398,15 +3594,26 @@ static int spi_nor_init(struct spi_nor *nor)
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
 
@@ -3521,19 +3728,23 @@ static void spi_nor_put_device(struct mtd_info *mtd)
 
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
@@ -3543,6 +3754,24 @@ static void spi_nor_restore(struct spi_nor *nor)
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
 
@@ -3611,11 +3840,15 @@ static void spi_nor_set_mtd_info(struct spi_nor *nor)
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
@@ -3629,8 +3862,17 @@ static void spi_nor_set_mtd_info(struct spi_nor *nor)
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
index 9ee3ff33a6db..e12482f7791f 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -14,6 +14,9 @@
 /* In single configuration enable CS0 */
 #define SPI_NOR_ENABLE_CS0     BIT(0)
 
+/* In parallel configuration enable multiple CS */
+#define SPI_NOR_ENABLE_MULTI_CS	(BIT(0) | BIT(1))
+
 /* Standard SPI NOR flash operations. */
 #define SPI_NOR_READID_OP(naddr, ndummy, buf, len)			\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 0),			\
@@ -137,6 +140,7 @@ enum spi_nor_option_flags {
 	SNOR_F_ECC		= BIT(15),
 	SNOR_F_NO_WP		= BIT(16),
 	SNOR_F_HAS_STACKED      = BIT(17),
+	SNOR_F_HAS_PARALLEL	= BIT(18),
 };
 
 struct spi_nor_read_command {
diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index baece51322ee..7f8201289915 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -335,6 +335,9 @@ static int micron_st_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 			op.data.nbytes = 2;
 		}
 
+		if (nor->flags & SNOR_F_HAS_PARALLEL)
+			op.data.nbytes = 2;
+
 		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
@@ -346,6 +349,8 @@ static int micron_st_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 	if (ret)
 		dev_dbg(nor->dev, "error %d reading FSR\n", ret);
 
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		fsr[0] &= fsr[1];
 	return ret;
 }
 
-- 
2.17.1

