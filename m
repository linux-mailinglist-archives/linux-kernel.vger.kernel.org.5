Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1057F0005
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 14:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjKRNzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 08:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjKRNzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 08:55:22 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A673D61;
        Sat, 18 Nov 2023 05:55:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8GajA7kahrVL23UbIvagQFY0mQkNDwt77f/j83WwxWtN9cwRTsX09P/a6bVlWKbRuR2kNunNVMXbvU1Hrm1N7PJme+itRf+2dewp0M6x2ZbHQn+eF3rtkwv2+dwwCLXy9/fGh58bgZcEYCrgxeIq/yZBOTJyF6v1IO1ioiAnu6kvfNG1kEhzfe/ZyhYDt6VuvUzKUDvQekWI7VaMu47sSGpJmeijtCHzeFapyCARsXCbZtKHlt5KqtRuM7yE1Xf3lt1T9jZlNvX7QdEScrXk7G5zP3yOL7YyhvmGBhfTwb2WfeLSlYBdGClSfvN4SW8maqvyeEUBRNzWbArOkqwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PR5pBhrvTa4x88c0miORhGBaiP2C9i0FoWa79d3bN7M=;
 b=Dcq0Fp0cC6g6nJWski1i9AE+An8CMb8PSUwLAhi9WXE3L9jPfehScDegVmYMhFTJhq63SU0hjtaHyLPlbTBYJRVluBJLgu/LiNQ0QOklgeBOW1eQOYWSlRv3T/QglJmDDkwutilrcbWnBe+p4UtzfoMFnbWUGfRlXPJkdY3ou7ov0BMIrql117aVeiGW2hoIVogE92vcFh3JwozOf0U60e6AwdDJukp3yThzAwRI9N/MtzU+Gf7inHhzQXB30N6ZXvCJoxgDCZVrvgAWfnCi8p0MwNbm4MJctSogXni5LxlFcZORL6h1L1t9wdZWq6O7MvtGyiSSxvZu0nwFHC0SaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PR5pBhrvTa4x88c0miORhGBaiP2C9i0FoWa79d3bN7M=;
 b=zrqsg0frSKYiJCVo+8iy0B+V47gM2ZI8gbaaBNmmjB8DpjHf0xkvXDxxSjzrO8bNxoPc8IR2zFBpc+guxBrIIUJsxUvzDwob1MW511FJxAzdaJrekJT1/O+rxOHG/bFRsNQ94P+NYkJ03gpQJmrAIA+S/t1wkqE44SMXfMjEDDM=
Received: from DM6PR03CA0029.namprd03.prod.outlook.com (2603:10b6:5:40::42) by
 DS7PR12MB6096.namprd12.prod.outlook.com (2603:10b6:8:9b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.26; Sat, 18 Nov 2023 13:55:13 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:40:cafe::9b) by DM6PR03CA0029.outlook.office365.com
 (2603:10b6:5:40::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23 via Frontend
 Transport; Sat, 18 Nov 2023 13:55:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.13 via Frontend Transport; Sat, 18 Nov 2023 13:55:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 18 Nov
 2023 07:55:13 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 18 Nov
 2023 07:55:12 -0600
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Sat, 18 Nov 2023 07:55:08 -0600
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
Subject: [PATCH v10 4/8] mtd: spi-nor: Move write enable inside specific write & erase APIs
Date:   Sat, 18 Nov 2023 19:24:42 +0530
Message-ID: <20231118135446.52783-5-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231118135446.52783-1-amit.kumar-mahapatra@amd.com>
References: <20231118135446.52783-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|DS7PR12MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 984e7505-c998-4534-aadb-08dbe83dfce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UROh+2w5/YlkfZBKlu5njKVM/Us+ctBuuNk/uGk0VCwruAjBTQr06kxJX4a85NlXnYORq9RVAipaMWoGlCUErnXeHhpljhg5gueKwVu7V1H2FZoPhlT7R+y9tIv4F8Hs9ZnQ161ezsAsyEYYxTyroeFaQuYU6MG35DZO3sG+Ap8B+xcbeKf5jeusTudIV4wfJoZTYy0eZkEtJTgIp79gu1h94pSNp7eUTTFxdENM5RwczoOe6zc+2OfXveybp+Tr/7sVrW2SHB03xY7rhYi3+0RfUuRQrV2RRlKeuNiIk5f9JAMVI5EiSieqc+Hs6x9YUMF+es/WIGQFaxVMVneB61k2ac5sgdUGvF4HW/2AJudcFws6HMFsxr2zmlvKQJgRaV3c36l6jCb1s6gPvr/OIlqLZeCScewe67deZxYrdDfGI8JnzExN2gyXhyvgTUh6JRvU+tRKgbd1/MMUsJqh3AE5VQz0fAZhi8qePKcqbmBs0k3OqHQG0u3k1SCripQ4yhojnT836ePfzMfkndTK8vsHQhECba6BbAGVumN9oApv2ogHJTmTDA11Y4U6h89YCcvckWVr4bBYLjnEI0vPRuCtwwWVEJmWzUahMY6F1WakPwHJwsMTHmnEeRzCmtZw3UoHwxTmLED5avRrOd6fSZWAkzMZCWLt8S6KmfhWtlJBbkF532QAUkREnDOKxgOQdS4EoZW3uTVUcERH++Ie8F3lYlFw9AsE+30AN/ForcHZR6+pUgokeOJGm33+9T75SNtnrkpnK9DKTwts3Gt8iA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799012)(40470700004)(36840700001)(46966006)(40460700003)(83380400001)(426003)(336012)(26005)(2616005)(1076003)(47076005)(36860700001)(4326008)(8676002)(8936002)(41300700001)(7416002)(2906002)(5660300002)(478600001)(6666004)(110136005)(70586007)(70206006)(54906003)(316002)(36756003)(81166007)(356005)(86362001)(82740400003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 13:55:13.5416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 984e7505-c998-4534-aadb-08dbe83dfce1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6096
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In most of the register write operations the spi_nor_write_enable is called
from within that API from where spi_mem APIs are called. Follwoing the same
trend move the write enable API from spi_nor_write & spi_nor_erase APIs to
the respective write & erase APIs.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 drivers/mtd/spi-nor/core.c | 40 ++++++++++++++------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 72c80d8b5858..93ae69b7ff83 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -301,6 +301,12 @@ static ssize_t spi_nor_spimem_write_data(struct spi_nor *nor, loff_t to,
 ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
 			   const u8 *buf)
 {
+	int ret;
+
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
 	if (nor->spimem)
 		return spi_nor_spimem_write_data(nor, to, len, buf);
 
@@ -1074,6 +1080,10 @@ static int spi_nor_erase_chip(struct spi_nor *nor)
 
 	dev_dbg(nor->dev, " %lldKiB\n", (long long)(nor->mtd.size >> 10));
 
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
 	if (nor->spimem) {
 		struct spi_mem_op op = SPI_NOR_CHIP_ERASE_OP;
 
@@ -1481,10 +1491,14 @@ static u32 spi_nor_convert_addr(struct spi_nor *nor, loff_t addr)
  */
 int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
 {
-	int i;
+	int i, ret;
 
 	addr = spi_nor_convert_addr(nor, addr);
 
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
 	if (nor->spimem) {
 		struct spi_mem_op op =
 			SPI_NOR_SECTOR_ERASE_OP(nor->erase_opcode,
@@ -1777,12 +1791,6 @@ static int spi_nor_erase_multi_sectors(struct spi_nor *nor, u64 addr, u32 len)
 			if (ret)
 				goto destroy_erase_cmd_list;
 
-			ret = spi_nor_write_enable(nor);
-			if (ret) {
-				spi_nor_unlock_device(nor);
-				goto destroy_erase_cmd_list;
-			}
-
 			ret = spi_nor_erase_sector(nor, addr);
 			spi_nor_unlock_device(nor);
 			if (ret)
@@ -1841,12 +1849,6 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 		if (ret)
 			goto erase_err;
 
-		ret = spi_nor_write_enable(nor);
-		if (ret) {
-			spi_nor_unlock_device(nor);
-			goto erase_err;
-		}
-
 		ret = spi_nor_erase_chip(nor);
 		spi_nor_unlock_device(nor);
 		if (ret)
@@ -1877,12 +1879,6 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 			if (ret)
 				goto erase_err;
 
-			ret = spi_nor_write_enable(nor);
-			if (ret) {
-				spi_nor_unlock_device(nor);
-				goto erase_err;
-			}
-
 			ret = spi_nor_erase_sector(nor, addr);
 			spi_nor_unlock_device(nor);
 			if (ret)
@@ -2177,12 +2173,6 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 		if (ret)
 			goto write_err;
 
-		ret = spi_nor_write_enable(nor);
-		if (ret) {
-			spi_nor_unlock_device(nor);
-			goto write_err;
-		}
-
 		ret = spi_nor_write_data(nor, addr, page_remain, buf + i);
 		spi_nor_unlock_device(nor);
 		if (ret < 0)
-- 
2.17.1

