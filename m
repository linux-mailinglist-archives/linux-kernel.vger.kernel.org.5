Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B607F0001
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 14:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjKRNzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 08:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjKRNzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 08:55:13 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1913D4B;
        Sat, 18 Nov 2023 05:55:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVr4YLBVdCRiKTth5XjBMQ8iTrKkmL8fs6B1p79hMQnDBMJxyW/bZyUJ50IljEgWp+wqrYgY9GOLUNu/nfRaSQPbprc8DL/zX3wbs/M0Em7erJm8XKNHoxjP3c/spe3gGbW5juAPPcl4wyVGlqT+5FfDKKmzt0dybMdVSI+vHTuDdSqdvfMA/Bw6p5kf1IHyEs4ZTRqtAYLyLE2A7YD5rG7ii+AzXj/aSzd67jvXiuZqwt+NlxUE+hFqNo5GLhsxjV4SItIihHamsQJ7pl9bmfrARkOzqjApCgy3ySz9uQS+BZDtFddqqiXcHmAUJCeWuL3/R7oz+q8C8UasSCnKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5mqpHnfYMEPp/K3f3bZgmug97OgZD/HN9a0e4dtXkU=;
 b=A3L/CyHYIXmo7k9tZOfymuvP6qhs/6lNgXe7R5GbTmFe5AVTGCWOIGyaaWmPJyiHq2YYTJvMOT5wlqBVFU80yfUYRP+wDVewosed1kG0DN3sS5pzrMPDAJSMgaoirljFsE1ez0ymbXHvSb5el0J3WCwl/8/2wSjEGLsey+6AQXLMEjYTsid7sHXUPm5ZJGpoZ3uNa7dc1QHMOmRR6tu/BJDJ8+JJNORykgHQATcJZ8zlPZUgJNW/mgl6cV5oHDfcSjsBhhVBRPb28Lodzm9Ab1tRHj0pdkddEwbRiyTtQ54bRE0NoklsNGxPV9otAgdmH3bghJ9VfKUJGhF9MEyscg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5mqpHnfYMEPp/K3f3bZgmug97OgZD/HN9a0e4dtXkU=;
 b=EDov61IiGSn7tWO8PKfEta3mHmy1W/lLoqFrs4iNq2ZTouGhEI+giF7aUVdKtzzgSvS8Zy2/LGcnmkmrs9M46QQs8FA7TDxyHTPB89qhHgVVHuDZuhjK1oRdj9F0zy2uhOpUTuW/6Wc1ggADj1is932jdeOAiqIW2MT2gT1fWIY=
Received: from DM6PR06CA0047.namprd06.prod.outlook.com (2603:10b6:5:54::24) by
 MN0PR12MB6054.namprd12.prod.outlook.com (2603:10b6:208:3ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Sat, 18 Nov
 2023 13:55:03 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:54:cafe::20) by DM6PR06CA0047.outlook.office365.com
 (2603:10b6:5:54::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23 via Frontend
 Transport; Sat, 18 Nov 2023 13:55:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.13 via Frontend Transport; Sat, 18 Nov 2023 13:55:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 18 Nov
 2023 07:55:02 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 18 Nov
 2023 07:55:02 -0600
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Sat, 18 Nov 2023 07:54:58 -0600
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
Subject: [PATCH v10 2/8] mtd: spi-nor: Convert macros with inline functions
Date:   Sat, 18 Nov 2023 19:24:40 +0530
Message-ID: <20231118135446.52783-3-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231118135446.52783-1-amit.kumar-mahapatra@amd.com>
References: <20231118135446.52783-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|MN0PR12MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 70e031ab-3906-4e9d-51c6-08dbe83df6ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SMRPS6z7lpDHtrLzS5/WDPCpfhEkLeZ7wJu9t9VvvNnGiuJHZdbCPGBj6kb7O0p/u06n6OHXRCKrU3gwJvXE3pEpgTeNRdjSJxUeVQ5S+YReLSdEQGLGK0vMwXeE5CrR77IXnr3lhZVOtnU376aUhmFRx7mHH7FFw4ZbSFqyWBOwplhAaFYeitkabRNtl39obojWKebfr8UiwD75eKraSf/0LrO2DyJwMMC8A+TbDYQEWG3ld0zH05uwui8dNuZY9Jl6i/2zdht+Xbuo4risTysKpAeIfIu5aBRVJlSeokYGdqJ0+VGT3gH/T9JTKxaC2UUosSB0ZZHNai+i2uDnuZnkImyQin0v34Ui/73YKRHvfVnid5U9ZAnlqCA5Vj80f1wOYXtFtmAnDuU28IlNJyjz2tLk0qlpZHyQ/0PYSLhYVpiexkYDsgnLCgyG6wbAhPPF8r5b+t0dOMQYG5QokNOKihNRY6ueW6U1d9wUJm41ddqyeGySeHooW/tyEa8+kgeVhFawGCUTfqKHwhq6CmIErHrcMgvsJDIOGqQIy32M35aBlwAHKUKztXWKZ8rrkeT268jzJTZRnQEgwbZpaa7JXrmdS3NqLjOuktxqhAaDEwZ2NLFG1bxrC28DeP6WuGwuQfIRSvq/Bq/LpOrSKe3UbVWsM1p3t/DMsDa7cwc8UvrDzV7pU/Y6LJNPtlvZMuMep1NHQySpozQsnoDXyyVcAKyhZzllATsP/B0HaCVSBhfiz1MhyqtPhyuItSsVVJeo+gSSvNlZwlxfCXe7Rw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(1076003)(81166007)(26005)(36860700001)(47076005)(41300700001)(356005)(36756003)(82740400003)(2616005)(83380400001)(336012)(426003)(40480700001)(6666004)(40460700003)(2906002)(7416002)(5660300002)(86362001)(316002)(54906003)(70586007)(110136005)(70206006)(478600001)(8676002)(4326008)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 13:55:03.3379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e031ab-3906-4e9d-51c6-08dbe83df6ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6054
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In further patches the nor->params references in
spi_nor_otp_region_len(nor) & spi_nor_otp_n_regions(nor) macros will be
replaced with spi_nor_get_params() API. To make the transition smoother,
first converting the macros into static inline functions.

Suggested-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 drivers/mtd/spi-nor/otp.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
index 9a729aa3452d..23fe75ddc9cf 100644
--- a/drivers/mtd/spi-nor/otp.c
+++ b/drivers/mtd/spi-nor/otp.c
@@ -11,8 +11,27 @@
 
 #include "core.h"
 
-#define spi_nor_otp_region_len(nor) ((nor)->params->otp.org->len)
-#define spi_nor_otp_n_regions(nor) ((nor)->params->otp.org->n_regions)
+/**
+ * spi_nor_otp_region_len() - get size of one OTP region in bytes
+ * @nor:        pointer to 'struct spi_nor'
+ *
+ * Return: size of one OTP region in bytes
+ */
+static inline unsigned int spi_nor_otp_region_len(struct spi_nor *nor)
+{
+	return nor->params->otp.org->len;
+}
+
+/**
+ * spi_nor_otp_n_regions() - get number of individual OTP regions
+ * @nor:        pointer to 'struct spi_nor'
+ *
+ * Return: number of individual OTP regions
+ */
+static inline unsigned int spi_nor_otp_n_regions(struct spi_nor *nor)
+{
+	return nor->params->otp.org->n_regions;
+}
 
 /**
  * spi_nor_otp_read_secr() - read security register
-- 
2.17.1

