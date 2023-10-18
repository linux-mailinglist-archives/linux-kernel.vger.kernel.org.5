Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A237CEA0F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjJRVeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjJRVeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:34:06 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507A912B;
        Wed, 18 Oct 2023 14:34:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Heufmho7i0jmFY101ZGBIGtIs/uf1Q0o1LEZ9KvQoHHfTMkxq3omtchzIOqHoggVNIegUaaDNLdyiCx/TeE4tk/ZzihBz0sVnGYWHvbaB9KHtH0Vw2KQYAixH7Rkeqp3u7OFfLOB2Rn/x+sUurQz5v5bhuodq+PGfysnaiwwxdpLEJTeGplFh7rt/2oD2xQj9yinxXkUxVi7YLgBcenI5z7DyWsO58bOEwqaVFag8re2TmVrURP+xVPs0FYS9ygbtJDm+QsCs64+6DVBh8EO2tibJcJY8BgRl5gppGMqwdBr7KBxgI1QoRd4KwzX4zfUHtoqACRvj9e4dtgfGJbZrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bsu0Zc4TCfIUAr3dJoctp0MGqpdBm50W65Qc8mpZKGI=;
 b=S9vvnQ7RD1x+JugLKCa9HRElplbWAVZwE7B3G59HgjzuU5B3yx1lPtklpb9G2i8N9VFTNxr+H+RJcKN4lpCZt3MLSAG/RmjDTnvWEKGLKuZKwjE7/ewd9D2Xs44ZtqUq4x3AStUJFKIyaWFvSwtw379GvKo0InQ1xEP+M9bvBL+le0u6Su1Kyv8UiD0DAPUbVoGbEBSaww/9K4WetGUDGxdX0PtJ8RMRWQXRrOhZLeZX9rGXYBQYrny15FMBJwQovyBlYyUBu5TXmGGhInCWngEUozw4uUkPLI6vdZfHBcu4O3qOEG23DD4KQQpTWyTmsedoIKFvNHHCTTe0XdxOhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bsu0Zc4TCfIUAr3dJoctp0MGqpdBm50W65Qc8mpZKGI=;
 b=nxk1IhQrsElO/xpcrv9I2VmemvuD1mJmN96XF/4UBhYBV/suEnTlEB0VZuKoAswUF2R4Q60dhKDjXJIPInoo8IPZnIW423mVC41zECfXB/3SIJqeiYmaHbQROSO3R0Tsc6hMIlmlKGkGK5rgCaabMUl0x+OaHtD9eRC0eqXi+KM=
Received: from BL1PR13CA0434.namprd13.prod.outlook.com (2603:10b6:208:2c3::19)
 by BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 18 Oct
 2023 21:33:58 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::be) by BL1PR13CA0434.outlook.office365.com
 (2603:10b6:208:2c3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7 via Frontend
 Transport; Wed, 18 Oct 2023 21:33:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Wed, 18 Oct 2023 21:33:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 16:33:57 -0500
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Wed, 18 Oct 2023 16:33:52 -0500
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
Subject: [PATCH v9 4/8] mtd: spi-nor: Move write enable inside specific write & erase APIs
Date:   Thu, 19 Oct 2023 03:03:24 +0530
Message-ID: <20231018213328.40131-5-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231018213328.40131-1-amit.kumar-mahapatra@amd.com>
References: <20231018213328.40131-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|BY5PR12MB4195:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c40921-7559-49f1-3d85-08dbd021efd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JCh2VMQBKAK7kkRcurmfKo2zNZGLCs4HtL2KZ0APRd0tuUIIsvIyIXD5c100G59R37TjJv1BEjl0Tpw3bua+7mEw8v87I/NGQ/yUPH05Sf/vjQ8NmnNGmX9PEBJUxy3Fe6c++vrteFcC2g49Xqx4si4cVAizuOQ5bDcKqoGcSJoJvvgRHsgj/VpldFjXdsieNKgBi599sC+maUoNRbK5ZV2ViRbteDDyq8QylZaxP5+NluS8DAXPTetByP/xPvAFUvY0uyVHLv5hI9gW3kXHbeVQM/598QAk0yXjAS8kysSRbwq0CcXJMQDik7g0hHnSgM3qAoVGwm0ylP0b7YvLCld4vwAUOdY0wK0jdb1dgHJidI4PJFfCoVjEHUSfIMY6r8Go/DpoW34dZR9FZ+MeRW1esCoiboBnJM17HSc6juy3m+mjHWfDUlU3BGtPh7QZHF6xYZM1DIqjM/LoxLlS6Fh7FPb8v8nQeG9ZQG8plsYOqy0tifu0vs+/Px5ZMIO9OPYr58UbkPzWXTjyK0M6vpWcYUF1O7yhWH4bnJ/+YJpyQUQjysaWReRymhXKYN3+gkoSW9buAKMO2Gt5UGlrtPWjzuo9LhOd9xWSloq0v1OFGoJXER07tWhu+o50ou/tWmg3P83kZASkIeopBN9yVDgp6YqCYlb4XphZjpTjfNNF2Cy4t2K/uGUicEhLANu9TVf/T1DW7HdPQZ88KhssKX+oFlJWMg/1iZNdeIToOBE7Gt1hdo1saMkj/bg/v8g0U/0o7KQJFHMdtra0jUFKsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(36840700001)(40470700004)(46966006)(478600001)(6666004)(83380400001)(26005)(336012)(2616005)(81166007)(7416002)(426003)(86362001)(40480700001)(54906003)(40460700003)(36756003)(82740400003)(356005)(8936002)(41300700001)(8676002)(4326008)(2906002)(36860700001)(1076003)(47076005)(5660300002)(110136005)(70586007)(316002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 21:33:57.8528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c40921-7559-49f1-3d85-08dbd021efd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
index 539c7b69f7b5..3396c2d3d97d 100644
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
@@ -2186,12 +2182,6 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
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

