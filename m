Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2817CEA0D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjJRVeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjJRVeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:34:10 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9B811C;
        Wed, 18 Oct 2023 14:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvTTE32C3kWsd4RSSgaPSA/pwjS8oTKK4c/0bA9gk+pBJ9PzOGOVCJmsHbV12OwncIUMQn3Eauu54JhHcHT4Y1z/RmE0rYrVd802fyQXQzykMOoEZVujvjrAw2W6Su3wKxdaMlhbzvqltLcuQyC4o4Mxrxi5Urf/VgPW3zlQlaVJM/fXQ1zA8schC3VVGD2EHLnMHewfeRK0/yVmk6f8tCQABwm+MtH3/ejOjKIq05CCvnNCp32UB93IPkfAac0yKf1xSLRdAZPOHsSEnUHJNiXW06E2EDkYIMzzzO/JGg8kAr2AFeg4UdrxOBxWBdegfWo+vTPwSU48jP6BV5upiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCJK69DpXY60Ti5gLK1hNBtUswpLaoVQDQyn157hQIQ=;
 b=ih5MlEo3VqtS1oX89PSvlr/NE1h6E4GKfbOcZNe0/bLy4nwDmYYFP5NVGV1judDnP4azqpbzJx7Mutf53t8ynONiUu278PDFwxg+Tpvqe3qoerjmpmbZz3q3pgnnnWwr8uPgK755a2wjsrT94olCAi9e3uBNTBKqQDUEKXXra1NHb7mXgqlOdaK4Y/LTe8TvpjFXIT0l1URuloKwLwf19FhtuIcf6ltg2LADxUdo8BdvrJVR6U1vNd4OAtsmAPFNuB+egJ/7P7BQhbEjgXLslFAWQQfo1nPMs9EnubvZBl8eZ/QCIcgBm8zhtvvkWdsRvndSbk4c7etKcwKAME4w4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCJK69DpXY60Ti5gLK1hNBtUswpLaoVQDQyn157hQIQ=;
 b=istb9MHFm8+5TrdzG80TFlPnvYdZhPhd+gAzHka+bkEcgRhyjEurw/bbksdsphzASQH66vEaoqpYaq4QFQhqacUsjQIbTtj4/JovsjogZ8ddwKNuA1gQBqNjM1aKzyzlNWw2tORjgaLbYwb8Yo2oFfSwuIcAKpz+AKPMdUZaKl4=
Received: from MN2PR10CA0019.namprd10.prod.outlook.com (2603:10b6:208:120::32)
 by SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 21:34:03 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:120:cafe::63) by MN2PR10CA0019.outlook.office365.com
 (2603:10b6:208:120::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Wed, 18 Oct 2023 21:34:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 18 Oct 2023 21:34:03 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 16:34:03 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 14:34:02 -0700
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Wed, 18 Oct 2023 16:33:57 -0500
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
Subject: [PATCH v9 5/8] mtd: spi-nor: Add stacked memories support in spi-nor
Date:   Thu, 19 Oct 2023 03:03:25 +0530
Message-ID: <20231018213328.40131-6-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231018213328.40131-1-amit.kumar-mahapatra@amd.com>
References: <20231018213328.40131-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: acca08de-a678-4ed1-fc24-08dbd021f319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uEYb8lBMIEX+sGm8kGVwqkuSrrIdWsZX4TahsMIhMyyjpsQRWdTfggHF5KJYHiKwCH944VPAkc0gFFkCrYPOWuayDbrvduGe4a2qHu1R92tahKN80kccjEndrHw7p1Oaf8/70L85RKP0eXuxT9PHPhpKVjqsOPuUXSMXjscO3G1tpPmLtvHC0DcXcnR+SssyeafetCmbXPG5A/sjCT/rKFA5yA3YLIXDc+9LF8gxDWxz4GEQZI/LKFKOU5OLNjtVrMyWmx+RwGoVccD/xOq4pS5JozFWswRJWMIXAou4LopR/3QD5PajddhF89xFd5NpJ3GmJjE6lI9YuvQV8FOSQs+VUWx8/MwFQM5hCo5+t9rwuVsyJmXVtUIuOKsEBVvdrWglrurLapv4zT4UPinoKn6fLZ3gH20joGNZov56OxMz+FTdgCwmvhoYDNwcd5gx/jjh68fOGFkLEmwuXFQlm8WNfFAt4SSzhcQRKa63Cjwoz1CfyQzGSyWe9rS6RN0Twh7CmLrdghgwWDXdRVGzTvfjxk991DTzKFhbafxxvnuqpt1VXqAVHjaUvDolYxA0q1srz3rQvf2ZvD2CsQkIR9s/HV/gFhKqvjjvOgh1/8hHqJb0UqiqSA/RGO3SMmRCp031bWPTMJLYjmb6wSzQw72sGcGYju2m5qjw338ikdh71dBueJLmhKh85NBVA7l/N9msXZAmce4k5fLCRNK0AeokOcPq8cP74oGIsWL9RXvLGRCGkstzmCHyjY94zttIbnBee6y4bdTne9Z/QIUR0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(186009)(82310400011)(1800799009)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(41300700001)(6666004)(478600001)(70206006)(110136005)(54906003)(70586007)(336012)(426003)(26005)(30864003)(1076003)(316002)(2616005)(8676002)(7416002)(4326008)(36756003)(8936002)(5660300002)(2906002)(47076005)(81166007)(36860700001)(83380400001)(356005)(82740400003)(86362001)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 21:34:03.3652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acca08de-a678-4ed1-fc24-08dbd021f319
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each flash that is connected in stacked mode should have a separate
parameter structure. So, the flash parameter member(*params) of the spi_nor
structure is changed to an array (*params[2]). The array is used to store
the parameters of each flash connected in stacked configuration.

The current implementation assumes that a maximum of two flashes are
connected in stacked mode and both the flashes are of same make but can
differ in sizes. So, except the sizes all other flash parameters of both
the flashes are identical.

SPI-NOR is not aware of the chip_select values, for any incoming request
SPI-NOR will decide the flash index with the help of individual flash size
and the configuration type (single/stacked). SPI-NOR will pass on the flash
index information to the SPI core & SPI driver by setting the appropriate
bit in nor->spimem->spi->cs_index_mask. For example, if nth bit of
nor->spimem->spi->cs_index_mask is set then the driver would
assert/de-assert spi->chip_slect[n].

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 drivers/mtd/spi-nor/core.c  | 274 +++++++++++++++++++++++++++++-------
 drivers/mtd/spi-nor/core.h  |   4 +
 include/linux/mtd/spi-nor.h |  15 +-
 3 files changed, 242 insertions(+), 51 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 3396c2d3d97d..115d7bf7d6ca 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1821,13 +1821,18 @@ static int spi_nor_erase_multi_sectors(struct spi_nor *nor, u64 addr, u32 len)
 static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
-	u32 addr, len;
+	struct spi_nor_flash_parameter *params;
+	u32 addr, len, offset, cur_cs_num = 0;
 	uint32_t rem;
 	int ret;
+	u64 sz;
 
 	dev_dbg(nor->dev, "at 0x%llx, len %lld\n", (long long)instr->addr,
 			(long long)instr->len);
 
+	params = spi_nor_get_params(nor, 0);
+	sz = params->size;
+
 	if (spi_nor_has_uniform_erase(nor)) {
 		div_u64_rem(instr->len, mtd->erasesize, &rem);
 		if (rem)
@@ -1849,23 +1854,27 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 		if (ret)
 			goto erase_err;
 
-		ret = spi_nor_erase_chip(nor);
-		spi_nor_unlock_device(nor);
-		if (ret)
-			goto erase_err;
+		while (cur_cs_num < nor->num_flash) {
+			nor->spimem->spi->cs_index_mask = 0x01 << cur_cs_num;
+			ret = spi_nor_erase_chip(nor);
+			spi_nor_unlock_device(nor);
+			if (ret)
+				goto erase_err;
 
-		/*
-		 * Scale the timeout linearly with the size of the flash, with
-		 * a minimum calibrated to an old 2MB flash. We could try to
-		 * pull these from CFI/SFDP, but these values should be good
-		 * enough for now.
-		 */
-		timeout = max(CHIP_ERASE_2MB_READY_WAIT_JIFFIES,
-			      CHIP_ERASE_2MB_READY_WAIT_JIFFIES *
-			      (unsigned long)(mtd->size / SZ_2M));
-		ret = spi_nor_wait_till_ready_with_timeout(nor, timeout);
-		if (ret)
-			goto erase_err;
+			/*
+			 * Scale the timeout linearly with the size of the flash, with
+			 * a minimum calibrated to an old 2MB flash. We could try to
+			 * pull these from CFI/SFDP, but these values should be good
+			 * enough for now.
+			 */
+			timeout = max(CHIP_ERASE_2MB_READY_WAIT_JIFFIES,
+				      CHIP_ERASE_2MB_READY_WAIT_JIFFIES *
+				      (unsigned long)(params->size / SZ_2M));
+			ret = spi_nor_wait_till_ready_with_timeout(nor, timeout);
+			if (ret)
+				goto erase_err;
+			cur_cs_num++;
+		}
 
 	/* REVISIT in some cases we could speed up erasing large regions
 	 * by using SPINOR_OP_SE instead of SPINOR_OP_BE_4K.  We may have set up
@@ -1874,12 +1883,26 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 
 	/* "sector"-at-a-time erase */
 	} else if (spi_nor_has_uniform_erase(nor)) {
+		/* Determine the flash from which the operation need to start */
+		while ((cur_cs_num < nor->num_flash) && (addr > sz - 1)) {
+			cur_cs_num++;
+			params = spi_nor_get_params(nor, cur_cs_num);
+			sz += params->size;
+		}
+
 		while (len) {
 			ret = spi_nor_lock_device(nor);
 			if (ret)
 				goto erase_err;
 
-			ret = spi_nor_erase_sector(nor, addr);
+			nor->spimem->spi->cs_index_mask = 0x01 << cur_cs_num;
+			offset = addr;
+			if (nor->flags & SNOR_F_HAS_STACKED) {
+				params = spi_nor_get_params(nor, cur_cs_num);
+				offset -= (sz - params->size);
+			}
+
+			ret = spi_nor_erase_sector(nor, offset);
 			spi_nor_unlock_device(nor);
 			if (ret)
 				goto erase_err;
@@ -1890,13 +1913,45 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 
 			addr += mtd->erasesize;
 			len -= mtd->erasesize;
+
+			/*
+			 * Flash cross over condition in stacked mode.
+			 */
+			if ((nor->flags & SNOR_F_HAS_STACKED) && (addr > sz - 1)) {
+				cur_cs_num++;
+				params = spi_nor_get_params(nor, cur_cs_num);
+				sz += params->size;
+			}
 		}
 
 	/* erase multiple sectors */
 	} else {
-		ret = spi_nor_erase_multi_sectors(nor, addr, len);
-		if (ret)
-			goto erase_err;
+		u64 erase_len = 0;
+
+		/* Determine the flash from which the operation need to start */
+		while ((cur_cs_num < nor->num_flash) && (addr > sz - 1)) {
+			cur_cs_num++;
+			params = spi_nor_get_params(nor, cur_cs_num);
+			sz += params->size;
+		}
+		/* perform multi sector erase onec per Flash*/
+		while (len) {
+			erase_len = (len > (sz - addr)) ? (sz - addr) : len;
+			offset = addr;
+			nor->spimem->spi->cs_index_mask = 0x01 << cur_cs_num;
+			if (nor->flags & SNOR_F_HAS_STACKED) {
+				params = spi_nor_get_params(nor, cur_cs_num);
+				offset -= (sz - params->size);
+			}
+			ret = spi_nor_erase_multi_sectors(nor, offset, erase_len);
+			if (ret)
+				goto erase_err;
+			len -= erase_len;
+			addr += erase_len;
+			cur_cs_num++;
+			params = spi_nor_get_params(nor, cur_cs_num);
+			sz += params->size;
+		}
 	}
 
 	ret = spi_nor_write_disable(nor);
@@ -2096,9 +2151,11 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 			size_t *retlen, u_char *buf)
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	struct spi_nor_flash_parameter *params;
+	ssize_t ret, read_len, len_lock =  len;
 	loff_t from_lock = from;
-	size_t len_lock = len;
-	ssize_t ret;
+	u32 cur_cs_num = 0;
+	u64 sz;
 
 	dev_dbg(nor->dev, "from 0x%08x, len %zd\n", (u32)from, len);
 
@@ -2106,9 +2163,23 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	if (ret)
 		return ret;
 
+	params = spi_nor_get_params(nor, 0);
+	sz = params->size;
+
+	/* Determine the flash from which the operation need to start */
+	while ((cur_cs_num < nor->num_flash) && (from > sz - 1)) {
+		cur_cs_num++;
+		params = spi_nor_get_params(nor, cur_cs_num);
+		sz += params->size;
+	}
 	while (len) {
 		loff_t addr = from;
 
+		nor->spimem->spi->cs_index_mask = 0x01 << cur_cs_num;
+		read_len = (len > (sz - addr)) ? (sz - addr) : len;
+		params = spi_nor_get_params(nor, cur_cs_num);
+		addr -= (sz - params->size);
+
 		addr = spi_nor_convert_addr(nor, addr);
 
 		ret = spi_nor_read_data(nor, addr, len, buf);
@@ -2120,11 +2191,22 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 		if (ret < 0)
 			goto read_err;
 
-		WARN_ON(ret > len);
+		WARN_ON(ret > read_len);
 		*retlen += ret;
 		buf += ret;
 		from += ret;
 		len -= ret;
+
+		/*
+		 * Flash cross over condition in stacked mode.
+		 *
+		 */
+		if ((nor->flags & SNOR_F_HAS_STACKED) && (from > sz - 1)) {
+			cur_cs_num++;
+			params = spi_nor_get_params(nor, cur_cs_num);
+			sz += params->size;
+		}
+
 	}
 	ret = 0;
 
@@ -2145,8 +2227,9 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
 	struct spi_nor_flash_parameter *params;
 	size_t page_offset, page_remain, i;
+	u32 page_size, cur_cs_num = 0;
 	ssize_t ret;
-	u32 page_size;
+	u64 sz;
 
 	dev_dbg(nor->dev, "to 0x%08x, len %zd\n", (u32)to, len);
 
@@ -2156,6 +2239,14 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 	params = spi_nor_get_params(nor, 0);
 	page_size = params->page_size;
+	sz = params->size;
+
+	/* Determine the flash from which the operation need to start */
+	while ((cur_cs_num < nor->num_flash) && (to > sz - 1)) {
+		cur_cs_num++;
+		params = spi_nor_get_params(nor, cur_cs_num);
+		sz += params->size;
+	}
 
 	for (i = 0; i < len; ) {
 		ssize_t written;
@@ -2176,6 +2267,10 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 		/* the size of data remaining on the first page */
 		page_remain = min_t(size_t, page_size - page_offset, len - i);
 
+		nor->spimem->spi->cs_index_mask = 0x01 << cur_cs_num;
+		params = spi_nor_get_params(nor, cur_cs_num);
+		addr -= (sz - params->size);
+
 		addr = spi_nor_convert_addr(nor, addr);
 
 		ret = spi_nor_lock_device(nor);
@@ -2193,6 +2288,15 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 			goto write_err;
 		*retlen += written;
 		i += written;
+
+		/*
+		 * Flash cross over condition in stacked mode.
+		 */
+		if ((nor->flags & SNOR_F_HAS_STACKED) && ((to + i) > sz - 1)) {
+			cur_cs_num++;
+			params = spi_nor_get_params(nor, cur_cs_num);
+			sz += params->size;
+		}
 	}
 
 write_err:
@@ -2306,8 +2410,6 @@ int spi_nor_hwcaps_pp2cmd(u32 hwcaps)
 static int spi_nor_spimem_check_op(struct spi_nor *nor,
 				   struct spi_mem_op *op)
 {
-	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
-
 	/*
 	 * First test with 4 address bytes. The opcode itself might
 	 * be a 3B addressing opcode but we don't care, because
@@ -2316,7 +2418,7 @@ static int spi_nor_spimem_check_op(struct spi_nor *nor,
 	 */
 	op->addr.nbytes = 4;
 	if (!spi_mem_supports_op(nor->spimem, op)) {
-		if (params->size > SZ_16M)
+		if (nor->mtd.size > SZ_16M)
 			return -EOPNOTSUPP;
 
 		/* If flash size <= 16MB, 3 address bytes are sufficient */
@@ -2920,7 +3022,10 @@ static void spi_nor_init_fixup_flags(struct spi_nor *nor)
 static int spi_nor_late_init_params(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
-	int ret;
+	struct device_node *np = spi_nor_get_flash_node(nor);
+	u64 flash_size[SNOR_FLASH_CNT_MAX];
+	u32 idx = 0;
+	int rc, ret;
 
 	if (nor->manufacturer && nor->manufacturer->fixups &&
 	    nor->manufacturer->fixups->late_init) {
@@ -2949,6 +3054,46 @@ static int spi_nor_late_init_params(struct spi_nor *nor)
 	if (nor->flags & SNOR_F_HAS_LOCK && !params->locking_ops)
 		spi_nor_init_default_locking_ops(nor);
 
+	params->bank_size = div64_u64(params->size, nor->info->n_banks);
+
+	nor->num_flash = 0;
+
+	/*
+	 * The flashes that are connected in stacked mode should be of same make.
+	 * Except the flash size all other properties are identical for all the
+	 * flashes connected in stacked mode.
+	 * The flashes that are connected in parallel mode should be identical.
+	 */
+	while (idx < SNOR_FLASH_CNT_MAX) {
+		rc = of_property_read_u64_index(np, "stacked-memories", idx, &flash_size[idx]);
+		if (rc)
+			break;
+		idx++;
+		if (!(nor->flags & SNOR_F_HAS_STACKED))
+			nor->flags |= SNOR_F_HAS_STACKED;
+
+		nor->num_flash++;
+	}
+
+	/*
+	 * By default one flash device should be connected
+	 * so, nor->num_flash is 1.
+	 */
+	if (!nor->num_flash)
+		nor->num_flash = 1;
+
+	if (nor->flags & SNOR_F_HAS_STACKED) {
+		for (idx = 1; idx < nor->num_flash; idx++) {
+			params = spi_nor_get_params(nor, idx);
+			params = devm_kzalloc(nor->dev, sizeof(*params), GFP_KERNEL);
+			if (params) {
+				memcpy(params, spi_nor_get_params(nor, 0), sizeof(*params));
+				params->size = flash_size[idx];
+				spi_nor_set_params(nor, idx, params);
+			}
+		}
+	}
+
 	if (nor->info->n_banks > 1)
 		params->bank_size = div64_u64(params->size, nor->info->n_banks);
 
@@ -3159,16 +3304,28 @@ static int spi_nor_set_octal_dtr(struct spi_nor *nor, bool enable)
  */
 static int spi_nor_quad_enable(struct spi_nor *nor)
 {
-	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+	struct spi_nor_flash_parameter *params;
+	int err, idx;
 
-	if (!params->quad_enable)
-		return 0;
+	for (idx = 0; idx < nor->num_flash; idx++) {
+		params = spi_nor_get_params(nor, idx);
+		if (!params->quad_enable)
+			return 0;
 
-	if (!(spi_nor_get_protocol_width(nor->read_proto) == 4 ||
-	      spi_nor_get_protocol_width(nor->write_proto) == 4))
-		return 0;
+		if (!(spi_nor_get_protocol_width(nor->read_proto) == 4 ||
+		      spi_nor_get_protocol_width(nor->write_proto) == 4))
+			return 0;
+		/*
+		 * Set the appropriate CS index before
+		 * issuing the command.
+		 */
+		nor->spimem->spi->cs_index_mask = 0x01 << idx;
 
-	return params->quad_enable(nor);
+		err = params->quad_enable(nor);
+		if (err)
+			return err;
+	}
+	return err;
 }
 
 /**
@@ -3200,7 +3357,7 @@ int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 
 static int spi_nor_init(struct spi_nor *nor)
 {
-	int err;
+	int err, idx;
 
 	err = spi_nor_set_octal_dtr(nor, true);
 	if (err) {
@@ -3241,9 +3398,16 @@ static int spi_nor_init(struct spi_nor *nor)
 		 */
 		WARN_ONCE(nor->flags & SNOR_F_BROKEN_RESET,
 			  "enabling reset hack; may not recover from unexpected reboots\n");
-		err = spi_nor_set_4byte_addr_mode(nor, true);
-		if (err)
-			return err;
+		for (idx = 0; idx < nor->num_flash; idx++) {
+			/*
+			 * Select the appropriate CS index before
+			 * issuing the command.
+			 */
+			nor->spimem->spi->cs_index_mask = 0x01 << idx;
+			err = spi_nor_set_4byte_addr_mode(nor, true);
+			if (err)
+				return err;
+		}
 	}
 
 	return 0;
@@ -3358,18 +3522,28 @@ static void spi_nor_put_device(struct mtd_info *mtd)
 static void spi_nor_restore(struct spi_nor *nor)
 {
 	int ret;
+	int idx;
 
 	/* restore the addressing mode */
 	if (nor->addr_nbytes == 4 && !(nor->flags & SNOR_F_4B_OPCODES) &&
 	    nor->flags & SNOR_F_BROKEN_RESET) {
-		ret = spi_nor_set_4byte_addr_mode(nor, false);
-		if (ret)
+		for (idx = 0; idx < nor->num_flash; idx++) {
 			/*
-			 * Do not stop the execution in the hope that the flash
-			 * will default to the 3-byte address mode after the
-			 * software reset.
+			 * Select the appropriate CS index before
+			 * issuing the command.
 			 */
-			dev_err(nor->dev, "Failed to exit 4-byte address mode, err = %d\n", ret);
+			nor->spimem->spi->cs_index_mask = 1 << idx;
+			ret = spi_nor_set_4byte_addr_mode(nor, false);
+			if (ret)
+				/*
+				 * Do not stop the execution in the hope that the flash
+				 * will default to the 3-byte address mode after the
+				 * software reset.
+				 */
+				dev_err(nor->dev,
+					"Failed to exit 4-byte address mode, err = %d\n",
+					ret);
+		}
 	}
 
 	if (nor->flags & SNOR_F_SOFT_RESET)
@@ -3436,6 +3610,8 @@ static void spi_nor_set_mtd_info(struct spi_nor *nor)
 	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
 	struct mtd_info *mtd = &nor->mtd;
 	struct device *dev = nor->dev;
+	u64 total_sz = 0;
+	int idx;
 
 	spi_nor_set_mtd_locking_ops(nor);
 	spi_nor_set_mtd_otp_ops(nor);
@@ -3454,7 +3630,11 @@ static void spi_nor_set_mtd_info(struct spi_nor *nor)
 		mtd->_erase = spi_nor_erase;
 	mtd->writesize = params->writesize;
 	mtd->writebufsize = params->page_size;
-	mtd->size = params->size;
+	for (idx = 0; idx < nor->num_flash; idx++) {
+		params = spi_nor_get_params(nor, idx);
+		total_sz += params->size;
+	}
+	mtd->size = total_sz;
 	mtd->_read = spi_nor_read;
 	/* Might be already set by some SST flashes. */
 	if (!mtd->_write)
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 9217379b9cfe..9ee3ff33a6db 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -11,6 +11,9 @@
 
 #define SPI_NOR_MAX_ID_LEN	6
 
+/* In single configuration enable CS0 */
+#define SPI_NOR_ENABLE_CS0     BIT(0)
+
 /* Standard SPI NOR flash operations. */
 #define SPI_NOR_READID_OP(naddr, ndummy, buf, len)			\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 0),			\
@@ -133,6 +136,7 @@ enum spi_nor_option_flags {
 	SNOR_F_RWW		= BIT(14),
 	SNOR_F_ECC		= BIT(15),
 	SNOR_F_NO_WP		= BIT(16),
+	SNOR_F_HAS_STACKED      = BIT(17),
 };
 
 struct spi_nor_read_command {
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 59909e7d6f53..9d72b0bbab94 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -127,6 +127,12 @@
 #define SR2_LB3			BIT(5)	/* Security Register Lock Bit 3 */
 #define SR2_QUAD_EN_BIT7	BIT(7)
 
+/*
+ * Maximum number of flashes that can be connected
+ * in stacked/parallel configuration
+ */
+#define	SNOR_FLASH_CNT_MAX	4
+
 /* Supported SPI protocols */
 #define SNOR_PROTO_INST_MASK	GENMASK(23, 16)
 #define SNOR_PROTO_INST_SHIFT	16
@@ -378,6 +384,7 @@ struct spi_nor_flash_parameter;
  *                      hooks, or dynamically when parsing the SFDP tables.
  * @dirmap:		pointers to struct spi_mem_dirmap_desc for reads/writes.
  * @priv:		pointer to the private data
+ * @num_flash		number of flashes connected in parallel or stacked mode
  */
 struct spi_nor {
 	struct mtd_info		mtd;
@@ -412,13 +419,13 @@ struct spi_nor {
 
 	const struct spi_nor_controller_ops *controller_ops;
 
-	struct spi_nor_flash_parameter *params;
+	struct spi_nor_flash_parameter *params[SNOR_FLASH_CNT_MAX];
 
 	struct {
 		struct spi_mem_dirmap_desc *rdesc;
 		struct spi_mem_dirmap_desc *wdesc;
 	} dirmap;
-
+	u32			num_flash;
 	void *priv;
 };
 
@@ -435,13 +442,13 @@ static inline struct device_node *spi_nor_get_flash_node(struct spi_nor *nor)
 
 static inline struct spi_nor_flash_parameter *spi_nor_get_params(const struct spi_nor *nor, u8 idx)
 {
-	return nor->params;
+	return nor->params[idx];
 }
 
 static inline void spi_nor_set_params(struct spi_nor *nor, u8 idx,
 				      struct spi_nor_flash_parameter *params)
 {
-	nor->params = params;
+	nor->params[idx] = params;
 }
 /**
  * spi_nor_scan() - scan the SPI NOR
-- 
2.17.1

