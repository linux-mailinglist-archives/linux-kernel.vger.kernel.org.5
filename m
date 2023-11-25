Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A9A7F899D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 10:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjKYJXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 04:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjKYJXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 04:23:21 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA290212E;
        Sat, 25 Nov 2023 01:22:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqz4dkzWJ14pHF61jCW8D3e0I8cZrJVqNr52rvD9EUIjT3HonW0wGa/ZZ0RKkjoXYrAvvWbwTA01+ceqReheYbgQP/5R3SybbOSzkdUHlP1FMG4nZPPpiEcs9pC5Ggi2ht7rV0mIkAM9AoBVSJzbKSzWGSgvRb9hukVEpPz76Jg1O3a4paBRR5edHaGOjBex8yfh7itRV2vRp97pXfyombtoiT5OKR4tUFHIlET1XCRJ1eV6vPJ/GOFieebV47GttxDTo47kFXCPUTdC1rtTEtt/g0ZEmYdRHfalWLcwnENw6wgJjRkc2s1D4+U09NY4440AaIT51VbR+yuElICHtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQa9GPkrCGOp5ad8QlFuAGLTRq4s361ZkeiJ5fBIuRg=;
 b=N2v+Mi69ZQkedgx8ZK0MPtJkqdlMh1e9zUCh1hc+bcF1QP47ljckLe4nepPLZnIHkpApDPaqth9ezi9MmIUsYLpz7Bn/kxSVasv5nck1njlW2e5CsvLSH9bB4UqeSSNQLn474VxDQCYr0cXaYNXl/QLgeuBP71WNUUwPonRyCw4QeK5iKf9nW33hLABQmtfd2kXBGDRgU0TcbsLvvn9LlVxhMMBB83ee44YhfWU/yU5+yxEaQVPyao2Ci2Dnz6E6T+U9mSwOh7l8fCDt5isdGql5AYxuzMsl3kXJS81G/MoGqwD20nnOxbTnQ5gS8sxpju42Xf3P9Tl970YL2zWu5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQa9GPkrCGOp5ad8QlFuAGLTRq4s361ZkeiJ5fBIuRg=;
 b=kNE4A3v6hjBnxhbxiCyOzlRtAGd16aLa9rnl0Ih0U9tifA/gzWgOk3zMfCTnHLSKlPS6LBlHIqZzYGz7DA0EuxvKUAFiLGylItp5KrXJnZhBeH4anbRgPBhizuz4ypm5BNH2mSHWbAUGWnZ0kZ61Z/0IbCKzUa0QvIdigzrdQJQ=
Received: from DM6PR18CA0034.namprd18.prod.outlook.com (2603:10b6:5:15b::47)
 by IA1PR12MB7544.namprd12.prod.outlook.com (2603:10b6:208:42c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Sat, 25 Nov
 2023 09:22:53 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:15b:cafe::50) by DM6PR18CA0034.outlook.office365.com
 (2603:10b6:5:15b::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20 via Frontend
 Transport; Sat, 25 Nov 2023 09:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Sat, 25 Nov 2023 09:22:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 25 Nov
 2023 03:22:50 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 25 Nov
 2023 03:22:40 -0600
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Sat, 25 Nov 2023 03:22:33 -0600
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <broonie@kernel.org>, <tudor.ambarus@linaro.org>,
        <pratyush@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <sbinding@opensource.cirrus.com>, <lee@kernel.org>,
        <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
        <rf@opensource.cirrus.com>, <perex@perex.cz>, <tiwai@suse.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@tuxon.dev>, <michal.simek@amd.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <git@amd.com>,
        <amitrkcian2002@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH v11 08/10] spi: spi-zynqmp-gqspi: Add stacked memories support in GQSPI driver
Date:   Sat, 25 Nov 2023 14:51:35 +0530
Message-ID: <20231125092137.2948-9-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|IA1PR12MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: 55080efe-9a16-4670-e2da-08dbed9819d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jaSXjDVcEPcid1X4J2jcBj26/+nJcgD9Ae615B1NmAl8viNyXBhUprOf8PR2RuHiGhb/rGZ1rPBxr0a6RTv4bMpuKWoF0h3FwTJM2Cb5bQ0CT5Qj4gr3KhtMi8nQd/n/dXAX8X3a50BnUAol7yFPKSZrPrlOCKlTwG/pPYSyf+fHWuq5wXNYqOwcnQ/R9mJNIv6rx5CYHbK5qUyAPBmRn5q1m0Q7BmXCqDeSH2aIzEuXn1gQMQv6IHq8sSf3WC6P5Y+RcwKyrYQShEG2S/SUx09Inzpu1OwDUJvU3EH4IGxnMUI6xVBsjj2JmOMYqvW1KUfA0BYLhDwq1p07qg0eqx/hmz6VAC3iARZi9iAJD6dyO8udSre5mfqGvj+uYbnkweaWet2ZDHDbr0PGEat9rUzjXQnAULQK5wyXmnNrLmrREHhdBCt7KYnV9w2JLus95S0ZitsApCYLNoIbQrQ1pBXyW4XD4giH/twKFHwu7Jtxz5LEns8bAi9WtarSSrIbx0UjaYPGjp+uJHRb8VN79kv65tUfzemw/X+zidDWBNcF8ppzWJ73eKpWmUqzGvGt1kjJ8MfIqgNmXypL0KKw25noE8x50DB5iRY6AtiTBActKt5NoMe4H4o5O6I/DmZd5thy0XVOr/n1zUpIpfOQ6xyOe29NV0Gw8XssLDnWSDHUuCNTVBMKg+CbTVeWHtt+c3NWWhHl53WpJmcMQBHQ5xxatLJduXCS0oiisWeXxxe+3jsiQ8y9zbwERLXbt1wHkqGICTvN69EmcljkAPBzy5hmLo/M9d/LujJgKOEsXMg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(46966006)(40470700004)(36840700001)(70206006)(54906003)(70586007)(83380400001)(8936002)(8676002)(81166007)(316002)(82740400003)(110136005)(4326008)(356005)(40480700001)(426003)(5660300002)(40460700003)(336012)(7416002)(2906002)(41300700001)(47076005)(2616005)(36860700001)(1076003)(921008)(26005)(478600001)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2023 09:22:52.6666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55080efe-9a16-4670-e2da-08dbed9819d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7544
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GQSPI supports two chip select CS0 & CS1. Update the driver to
assert/de-assert the appropriate chip select as per the bits set in
qspi->cs_index_mask.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 9a46b2478f4e..c5d12ddd4ab3 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -154,6 +154,9 @@
 #define GQSPI_FREQ_100MHZ	100000000
 #define GQSPI_FREQ_150MHZ	150000000
 
+#define GQSPI_SELECT_LOWER_CS  BIT(0)
+#define GQSPI_SELECT_UPPER_CS  BIT(1)
+
 #define SPI_AUTOSUSPEND_TIMEOUT		3000
 enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
 
@@ -465,15 +468,17 @@ static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
 
 	genfifoentry |= GQSPI_GENFIFO_MODE_SPI;
 
+	if (qspi->cs_index_mask & GQSPI_SELECT_UPPER_CS) {
+		zynqmp_gqspi_selectslave(xqspi,
+					 GQSPI_SELECT_FLASH_CS_UPPER,
+					 GQSPI_SELECT_FLASH_BUS_LOWER);
+	} else if (qspi->cs_index_mask & GQSPI_SELECT_LOWER_CS) {
+		zynqmp_gqspi_selectslave(xqspi,
+					 GQSPI_SELECT_FLASH_CS_LOWER,
+					 GQSPI_SELECT_FLASH_BUS_LOWER);
+	}
+	genfifoentry |= xqspi->genfifobus;
 	if (!is_high) {
-		if (!spi_get_chipselect(qspi, 0)) {
-			xqspi->genfifobus = GQSPI_GENFIFO_BUS_LOWER;
-			xqspi->genfifocs = GQSPI_GENFIFO_CS_LOWER;
-		} else {
-			xqspi->genfifobus = GQSPI_GENFIFO_BUS_UPPER;
-			xqspi->genfifocs = GQSPI_GENFIFO_CS_UPPER;
-		}
-		genfifoentry |= xqspi->genfifobus;
 		genfifoentry |= xqspi->genfifocs;
 		genfifoentry |= GQSPI_GENFIFO_CS_SETUP;
 	} else {
-- 
2.17.1

