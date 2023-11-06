Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F43E7E27BD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjKFOyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjKFOyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:54:12 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DAED45;
        Mon,  6 Nov 2023 06:54:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDMHS7VBI9zzY3jIVZJSOBUmLjXEQU6yNaukiEnQK1pgVQ/FMqsl72o4U6R9UZK3M47lp3WydxIdPz6Hn36Uyz96fmxBnl7UlmaHLNDxC8e7H8K+OCu99WBTbCJZmw5dbEvlwTvokfNk7Bsz1nEs8FTJ+eGH5Pp5PU8Hb60D1uhab7WicAyShfpXnm6JKyGCV4zAV1L9AVHBib1u4i6JLeZIIEswaaUTvqdsSCAWXjzT8UUC/wMNAQe83FzCJCr2DiDMivkfXCyqg+Ml7htL9TvSwmw0g90cP5U41flkehKC1DCUugJCeW/GEF/vqokYgX+mI9T4x88lGMOxVbl1Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4T9hUrRjlxuj3B6UlVcXUOLBpmgEa0vAGQHkdFJ6/8Q=;
 b=X2/CZhqN2zzGNpDjYhAuUFD/YgHpkJMPQkqPi1wM53knaSpSn3LPFPhzssEdEPMX3rKqCw1MK/AMIzduCM1UJJs6LW+VCJTaIw80+4bkh3oNBRAwqMnV/Nirsa32UZEMe8wX7mozLwTDXXR8rRE568TeXYY5cVfOazNgd29VtRHPbya+D4sWC33dItroVyCnVSINjWCJg1SGfSUILrLGlzNn7GiBSKX3gz51j5bDt4snlSn8Yiw+2FSUHbJ3/6S1rTVEubDE/957ZZzV+IY8oVAlLZa+NbnnAiS0tIpb1LDz1CNQO7M+dBChPZSPnDl6PHK1q0Gs+V3U0wQET8HXYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4T9hUrRjlxuj3B6UlVcXUOLBpmgEa0vAGQHkdFJ6/8Q=;
 b=fYTZeK8HBMW0ISZW45jwGP9LJtx6EzxB6uku2bEXD92AaRJ46XKPK/dR7q+Oqg0k8nBHe8c/PObiXSjJ6l+UtJ4fKEij70bwvbJhn0Jra2V9DKQi3FszfFbPxHUIm4ioUeEoInr9GpAfXwd+AB4yu3l0ZsikNiGYAfvCuMe0tEw=
Received: from DM6PR11CA0020.namprd11.prod.outlook.com (2603:10b6:5:190::33)
 by SA1PR12MB8860.namprd12.prod.outlook.com (2603:10b6:806:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 14:54:07 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:5:190:cafe::1e) by DM6PR11CA0020.outlook.office365.com
 (2603:10b6:5:190::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27 via Frontend
 Transport; Mon, 6 Nov 2023 14:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Mon, 6 Nov 2023 14:54:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 6 Nov
 2023 08:54:07 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 6 Nov
 2023 08:54:06 -0600
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Mon, 6 Nov 2023 08:54:04 -0600
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <broonie@kernel.org>, <amit.kumar-mahapatra@xilinx.com>,
        <michal.simek@amd.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        "Radhey Shyam Pandey" <radhey.shyam.pandey@amd.com>
Subject: [PATCH] spi: spi-zynqmp-gqspi: fix driver kconfig dependencies
Date:   Mon, 6 Nov 2023 20:23:55 +0530
Message-ID: <1699282435-884917-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|SA1PR12MB8860:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be5d429-ccf1-4837-aa48-08dbded83a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ctBcqG0iRAJxzpceDX5qpCI8PTlQBsOKbxzmE9rcfFPs6pSghj88UViOYT4nc5QV3bsyRB5lhFGH5k/rVpeHcEe+N/6xz71TylJuU9EvoKPtjKPmyAo1DYr1rjAGoKQHFMmFnIqehBdWq8q2ogIw/rBETelUSzzzaYi93CAF1GCgBBbC2dJOQN+taLo+FbJEFOv1sM6lOOqluA8O0KQgNfPg5BMShhGYL5DFoKTXKAt80ycPJbmvCXm8J0ERmsum7cGBroH25CPGUP96/zLv566uB1Btz2q2kK/9q6y2/ukPj5I/jvGe9gLXYouB8L8URH85qX16qSFyuwcxVXkkbRiIwlYRpbk8io0okKmXCD8XbtV0vTrAs0PVeb0wR0C/0sfhJrCZn7H/zxB+kWPikpfSQOY+FsgyR3VjrrE4yRM0VN122R9hlIS7iHh3xT03zNcMkzMXQsgv7JO6McBFifF8Pfl6MsNwxjYuWIYrmSAIl+eRD5ZJVzeePnVERMyiNd+uTUF1yviTjLaPL4OMRc/WnXzZF/l7MRQCCccc4fHtQgKrypqYYBkAjiQViYoiDnkvdNelbw+Sc+pa0vZU62r7ntkk771XHeD+LMP8JQXGhf3E5BQ+z/E6V7BI8i2A8yPztD3xlbwpD0dp/WuTCmzxc+YCBZ1V7sOm+KJ6NF2fSzbpJ7N1f0iaS3emlus2ke57or8IwP5YG46tV9ZDSZRb29CtJyBQFuSbL0aI0Sa6b9eDkb4laDRaWRxVu1ZxOI3JOqh/KZi4HqLBs3IojQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(36756003)(426003)(336012)(83380400001)(8936002)(8676002)(316002)(26005)(6636002)(110136005)(70206006)(70586007)(54906003)(5660300002)(36860700001)(2906002)(47076005)(41300700001)(478600001)(2616005)(6666004)(4326008)(82740400003)(86362001)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 14:54:07.6843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be5d429-ccf1-4837-aa48-08dbded83a6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8860
X-Spam-Status: No, score=-0.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>

ZynqMP GQSPI driver no longer uses spi-master framework. It had been
converted to use spi-mem framework. So remove driver dependency from
spi-master and replace it with spi-mem.

Fixes: 1c26372e5aa9 ("spi: spi-zynqmp-gqspi: Update driver to use spi-mem framework")
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/spi/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 35dbfacecf1c..caaf2aa38f21 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1176,9 +1176,10 @@ config SPI_ZYNQ_QSPI
 
 config SPI_ZYNQMP_GQSPI
 	tristate "Xilinx ZynqMP GQSPI controller"
-	depends on (SPI_MASTER && HAS_DMA) || COMPILE_TEST
+	depends on (SPI_MEM && HAS_DMA) || COMPILE_TEST
 	help
 	  Enables Xilinx GQSPI controller driver for Zynq UltraScale+ MPSoC.
+	  This controller only supports SPI memory interface.
 
 config SPI_AMD
 	tristate "AMD SPI controller"
-- 
2.34.1

