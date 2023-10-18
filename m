Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443A07CEA14
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbjJRVe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjJRVeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:34:13 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3943D120;
        Wed, 18 Oct 2023 14:34:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCjErHDSDHScfgLdPHFQ/wwcHViXx8iTO2SwZ4ys+4FwdbeCjXU+n25V0GxJEM63dzgl9/vecpEFt5sFTjRQZCEdyO6iNVm2ZrYeMh/bLCrU1DIB/oDuHlqsFlHKDrHJlqZx8w5farufQv/FC/21Cl7y7pdAQvyIHl4zTukO8mjsHRByI0UTeUYlNGpxXNSqTNdPZhju9o/Cx2ev/tQNWz74ErvExPASw3J25MKGhog+s9+C6mVGiOmdhrzNZWANiM6S3eQdOs+jgad25tYO0aI2b36pS5ToIJwmN0ltT37/ZYq+lYQlDPC/fI7IJQA9/7dzUY85QubBDek7rOde6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQa9GPkrCGOp5ad8QlFuAGLTRq4s361ZkeiJ5fBIuRg=;
 b=JfMfwCQCrcjae7xAjPr7UVQjrnINDgN46ksqVaVwo/2ZvjY5ndps4Pxaohx6FOFxrPJBJqB6eC8UtcCOGoWVNecslgQ8Q1wf62+N81JqV8B9kxlQ32cBVl083HrSao4Uj35yhH6rzOBp8DjEONe1AotV/g6j44mIsXGiB/VgwPcwUJmACkqaCVGm3+babPPCP+dFkopZmk4fCpFbxwDEbJCO6raqvjHosy/6gds1kVP9UR20n/PB1sYUTpjv7U9F/cXKDagwEHY4cNRCYYC9bR/7TNieBhzyJMdHBGR6jHktgOwsKeNtgYRoRNB+sQgm+FqnuZcGN64hHZjszfDhBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQa9GPkrCGOp5ad8QlFuAGLTRq4s361ZkeiJ5fBIuRg=;
 b=PZoNrWDfg25Or3Vx2EBcy7OO96W9hkjhzVA/rJMRv/HxgGPvpCBsRzT9HZUZznQ0c4ZS3jPDuMLV0Jcb8jfZPlXSiiYHfswzkQOPNq9cQkfhtxfeyaWe3G9bm/y0dBZeJo7V6DwTpu+VB2trjIAPp6QqeHbszp/xpQzBOs40aHo=
Received: from BL1PR13CA0427.namprd13.prod.outlook.com (2603:10b6:208:2c3::12)
 by PH8PR12MB8607.namprd12.prod.outlook.com (2603:10b6:510:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Wed, 18 Oct
 2023 21:34:08 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::ef) by BL1PR13CA0427.outlook.office365.com
 (2603:10b6:208:2c3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.18 via Frontend
 Transport; Wed, 18 Oct 2023 21:34:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Wed, 18 Oct 2023 21:34:08 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 16:34:07 -0500
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Wed, 18 Oct 2023 16:34:02 -0500
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
Subject: [PATCH v9 6/8] spi: spi-zynqmp-gqspi: Add stacked memories support in GQSPI driver
Date:   Thu, 19 Oct 2023 03:03:26 +0530
Message-ID: <20231018213328.40131-7-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231018213328.40131-1-amit.kumar-mahapatra@amd.com>
References: <20231018213328.40131-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|PH8PR12MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac334f6-9144-4446-730f-08dbd021f634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AJV0jfUFDGdhK3xzA3YfqyiTcOqJPg7RDjauNoxs6G68SWDAbo8Hgzw1Rw4Oi7/GsUVMWaikspuhzleTn7bc4GR7lZ5pU10bc/vmgIXG3SgzQRH2UuF4QBpsX4nN6qjpqiiKg3a6sHMa5WrRXSRX4R21AyW4BleYS5nbRglJAzZI50qI0GYHmA8jhgMguoNWJM/+WoSCDVUHfYQIaoO8ZryEeRZ3mwfmRXSkbsk8nVNj02fMlQcmiyBIvK0Mh88H7VCSsNQ5rWjLhGDhCph8l9C9Ga7CuaA1DKKDrAQC/UOuRlmDVpmrhIC1ULOlX/ynt5iRfif/GVgQcTzzfMU5j191X+bo9q3EUCYqASi8qC+ET3Ijb1HkgLPnYrrFJwmQIKrfV4BOMF4j8EayEyknAnXjYLsqcdPe7xKqC1mnH9OpYtz2EJtkz+SKMSywbCePRyp4efiyO16c4yjGlSWPgL43bWT3enW3n/dDQeQw0yl2VZavZSLAlEEMmgT20SEvXuFQ5tt+4gQHndZA9pFAU/WOYK57YgNojzPMfITw4uMf0K0JS5y9oKMLxgklcQoYx41cBe2agDyy0Tq15jBpl+xYVntiAeZFwSlpHA3ki85jXttnZiwmmktYNT5VFApQb83RgHxIonU93EAGz9XC7a3+NyK26T8fvTXxa5+OG1Dr43NJGogE+WDiiu5ierEu5I7vSJEyE+CiRVAki/rBruqLkDLL/ByoCdmczC3dqC+a9Uf3CwEar9lN6gDLGG7g29RqbfbAtsGXzxT/7orDWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799009)(46966006)(36840700001)(40470700004)(26005)(1076003)(83380400001)(426003)(2616005)(6666004)(47076005)(336012)(40480700001)(478600001)(8676002)(41300700001)(4326008)(40460700003)(86362001)(81166007)(36860700001)(5660300002)(356005)(2906002)(82740400003)(54906003)(70586007)(36756003)(7416002)(8936002)(110136005)(316002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 21:34:08.5719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac334f6-9144-4446-730f-08dbd021f634
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8607
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

