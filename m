Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05817CEA06
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjJRVdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJRVdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:33:42 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810B7EA;
        Wed, 18 Oct 2023 14:33:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnFMufZclCQv1CWhAKWJvebyCX6WDGds4n+z8Rytokxm5NuTXPFPRxRSHXaT062ao2YnV5SQkkoBOu6OUPJ+DyWxhWmtIhettOfMlTvgJGzRWDm9LUf9p4hPsClXpeibH3Rxjj0j3/OZ63G7tV0fQCtgoiCXeavaWeHxKXIO/3Ax8+DY53XWjon88Md53nG9naLWy0r9mSsEp/OoPHEixdWXz1K7eWwGQxE2mgifjvItiy8jONnLHs+krivwiwvCFQ06yysZijoVZ02jYBj9Kh+wDcNcYZgmZRB2ijE1yUqAdJqhNM074o9tSGi6aY7KI2ZvF5lAbD8zie3rTayevQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZJf3dWJ5dccTpwwgFSj6zYDxzFMNRu3mpXFOAPN1bM=;
 b=PcQgEmq78clFhQ1y+jLChwIHBp9okA+Vwna9VcCiuX2sxbDtKY1hZsiN5yDp3aKClam4zWHZ4v8ht7b4Qx84J/WVZ8bx2X7BEs/9Fl3nXt40XfYpSA3BKeROzTL2KPxJdCcCeQcLpKpfg2Uw5jAMp6MxeDTFHBmrnYnLBEe1UtTLPuxksyb7BlgQWvXPVeEHeF8sBK7JPG9NpKbDcHNI7ITAAXOPB2b7L9iaQbixlJzOKfZyCyEjSD91DyS4yRU8m8TquuR7umLtombSMtmSx34AKzYbQ4nocZtPAi4yWE9kxuAn3jNzD5pvhrZmQmyOMVHFlmmLhfyJyvtTKi5idw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZJf3dWJ5dccTpwwgFSj6zYDxzFMNRu3mpXFOAPN1bM=;
 b=tX443nRGbE4JYSko9Lcg73R9ExtLuM8uoXy+nDVGOwf4vQsshvTLSkPV7fmUX/kIibqfXO20c0Wr1uQMaYtiurUnnIIcafuz0O5uVdfLiNlV6IqqpaW5zVQWDlGVvvC7aRWf52jBdrEOkesEU8X2id4y9Ifs9xiwYdK7B8WosZE=
Received: from MN2PR06CA0021.namprd06.prod.outlook.com (2603:10b6:208:23d::26)
 by PH0PR12MB7863.namprd12.prod.outlook.com (2603:10b6:510:28b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 21:33:36 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:23d:cafe::ce) by MN2PR06CA0021.outlook.office365.com
 (2603:10b6:208:23d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 21:33:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 18 Oct 2023 21:33:36 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 16:33:35 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 14:33:35 -0700
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Wed, 18 Oct 2023 16:33:30 -0500
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
Subject: [PATCH v9 0/8] spi: Add support for stacked/parallel memories
Date:   Thu, 19 Oct 2023 03:03:20 +0530
Message-ID: <20231018213328.40131-1-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|PH0PR12MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: ec7b64d6-4a11-4834-0901-08dbd021e2ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MMpEvFYei4PVAFtDcEJeQSLj2PPXnBs/03ThViSOr3dGat3tXoRyePg8fTLto5Lfem2roB9/SrufjXXPVIt09EcNXiAjbRxfFatre1y6k7rWKsb3f6WNsE3eKp2e8NmfKE38TLD0MaF8UqkVKo+Jb34UZa2z396hK+ny0pONNYnOR1isumgwKFYB+1zsI9r6RHApuFtHZKj8dQzlt/NfTCE21xNnj8663TUqtbSLnh9kLQKnsKF5fTiT76Mn/5tGDHloP+fl8/BtvEpjlmFB5KHV+mGvG5B5W3cqH4p3TpPU2FYC4Ej7GMkaRRXVJ1chkGWFqoY74SYGGbKQ+A/PIe7MuopGAUCzPJXlO/bePbX6RVvY0+Y1MDsy+dVoBJbvAvwwGXc0j0QiyqP7fxBXyHOFIHkA5AnqZXV8jRnpi/fe5RnIegbWTfWtnpSmzdCeJuDIKldHjRB17HYbc3kVPXsV659kL8vG3rWIxV31YgtwBnbMxlHZ6pUNoxN6wTX6X7c6QSgtRWpGNaCgJQGGAN+TPRpZDsXexh0ta67oowELh0d+fWPhiOqmD77gJuXgKfPFJuThtWwSSWzoj2s1y0QEVym9OvTX6W7wv7HzcMbH0O2p+R3aTACE/CsZr3D4jwbXuFeYnvSKoYn056/ZE8fYFUZBc5/D/qkpcXKkHDcGg/VdaV1Ipe+O7Xe2+Kvt7g1sTNkNsYQzfLafUgZsVTcPlRH0R3WAZZKVheru/VnVrqBKBYJ6Q/lpGHPEOBmCWt/WUvopQvxi0Acf90vPQOWTmQxdvy9OD3zsDISFOQ4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(86362001)(41300700001)(7416002)(5660300002)(8936002)(4326008)(8676002)(36756003)(47076005)(83380400001)(2906002)(36860700001)(54906003)(336012)(426003)(316002)(26005)(356005)(2616005)(81166007)(1076003)(40480700001)(82740400003)(6666004)(40460700003)(70206006)(70586007)(110136005)(966005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 21:33:36.2271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7b64d6-4a11-4834-0901-08dbd021e2ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7863
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is in the continuation to the discussions which happened on
'commit f89504300e94 ("spi: Stacked/parallel memories bindings")' for
adding dt-binding support for stacked/parallel memories.

This patch series updated the spi-nor, spi core and the AMD-Xilinx GQSPI 
driver to add stacked and parallel memories support.

The first nine patches
https://lore.kernel.org/all/20230119185342.2093323-1-amit.kumar-mahapatra@amd.com/
https://lore.kernel.org/all/20230310173217.3429788-2-amit.kumar-mahapatra@amd.com/
https://lore.kernel.org/all/20230310173217.3429788-3-amit.kumar-mahapatra@amd.com/
https://lore.kernel.org/all/20230310173217.3429788-4-amit.kumar-mahapatra@amd.com/
https://lore.kernel.org/all/20230310173217.3429788-5-amit.kumar-mahapatra@amd.com/
https://lore.kernel.org/all/20230310173217.3429788-6-amit.kumar-mahapatra@amd.com/
https://lore.kernel.org/all/20230310173217.3429788-7-amit.kumar-mahapatra@amd.com/
https://lore.kernel.org/all/20230310173217.3429788-8-amit.kumar-mahapatra@amd.com/
https://lore.kernel.org/all/20230310173217.3429788-9-amit.kumar-mahapatra@amd.com/
of the previous series got applied to
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
But the rest of the patches in the series did not get applied as failure 
was reported for spi driver with GPIO CS, so send the remaining patches 
in the series after rebasing it on top of for-next branch and fixing the 
issue.

CS GPIO is not tested due to unavailability of necessary hardware setup.
---
BRANCH: for-next

Changes in v9:
- Updated 1/8 patch description to add an high-level overview of 
  parallel(multi-cs) & stacked design.
- Initialized all unused CS to 0xFF.
- Moved CS check from spi_add_device() to __spi_add_device().
- Updated __spi_add_device() to check to make sure that multiple logical CS 
  don't map to the same physical CS and same physical CS doesn't map to
  different logical CS.
- Updated 1/8, 5/8 & 7/8 to support arbitrary number of flash devices 
  connected in parallel or stacked mode.
- Updated documentation for chip_select.
- Added a new spi-nor structure member nor->num_flash to keep track of the 
  number of flashes connected.
- Added a new patch in the series 4/8 to move write_enable call just before 
  spi_mem ops call in SPI-NOR.
- Added comments in SPI core & SPI-NOR.
- Rebased the patch series on top of the latest for-next branch.

Changes in v8:
- Updated __spi_add_device() and spi_set_cs() to fix spi driver failure
  with GPIO CS.
- Rebased the patch series on top of latest for-next branch and fixed 
  merge conflicts.
- Updated cover letter description to add information regarding GPIO CS
  testing and request Stefan to provide his Tested-by tag for 1/7 patch. 
- Updated 1/7 patch description.

Changes in v7:
- Updated spi_dev_check() to avoid failures for spi driver GPIO CS and
  moved the error message from __spi_add_device() to spi_dev_check().
- Resolved code indentation issue in spi_set_cs().
- In spi_set_cs() call spi_delay_exec( ) once if the controller supports 
  multi cs with both the CS backed by GPIO.
- Updated __spi_validate()to add checks for both the GPIO CS.
- Replaced cs_index_mask bit mask with SPI_CS_CNT_MAX.
- Updated struct spi_controller to represent multi CS capability of the
  spi controller through a flag bit SPI_CONTROLLER_MULTI_CS instead of 
  a boolen structure member "multi_cs_cap".
- Updated 1/7 patch description .

Changes in v6:
- Rebased on top of latest v6.3-rc1 and fixed merge conflicts in
  spi-mpc512x-psc.c, sfdp.c, spansion.c files and removed spi-omap-100k.c.
- Updated spi_dev_check( ) to reject new devices if any one of the
  chipselect is used by another device.

Changes in v5:
- Rebased the patches on top of v6.3-rc1 and fixed the merge conflicts.
- Fixed compilation warnings in spi-sh-msiof.c with shmobile_defconfig

Changes in v4:
- Fixed build error in spi-pl022.c file - reported by Mark.
- Fixed build error in spi-sn-f-ospi.c file.
- Added Reviewed-by: Serge Semin <fancer.lancer@gmail.com> tag.
- Added two more patches to replace spi->chip_select with API calls in
  mpc832x_rdb.c & cs35l41_hda_spi.c files.

Changes in v3:
- Rebased the patches on top of
  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
- Added a patch to convert spi_nor_otp_region_len(nor) &
  spi_nor_otp_n_regions(nor) macros into inline functions
- Added Reviewed-by & Acked-by tags

Changes in v2:
- Rebased the patches on top of v6.2-rc1
- Created separate patch to add get & set APIs for spi->chip_select &
  spi->cs_gpiod, and replaced all spi->chip_select and spi->cs_gpiod
  references with the API calls.
- Created separate patch to add get & set APIs for nor->params.
---
Amit Kumar Mahapatra (8):
  spi: Add multi-cs memories support in SPI core
  mtd: spi-nor: Convert macros with inline functions
  mtd: spi-nor: Add APIs to set/get nor->params
  mtd: spi-nor: Move write enable inside specific write & erase APIs
  mtd: spi-nor: Add stacked memories support in spi-nor
  spi: spi-zynqmp-gqspi: Add stacked memories support in GQSPI driver
  mtd: spi-nor: Add parallel memories support in spi-nor
  spi: spi-zynqmp-gqspi: Add parallel memories support in GQSPI driver

 drivers/mtd/spi-nor/atmel.c      |  17 +-
 drivers/mtd/spi-nor/core.c       | 685 +++++++++++++++++++++++++------
 drivers/mtd/spi-nor/core.h       |   8 +
 drivers/mtd/spi-nor/debugfs.c    |   4 +-
 drivers/mtd/spi-nor/gigadevice.c |   4 +-
 drivers/mtd/spi-nor/issi.c       |  11 +-
 drivers/mtd/spi-nor/macronix.c   |  10 +-
 drivers/mtd/spi-nor/micron-st.c  |  35 +-
 drivers/mtd/spi-nor/otp.c        |  48 ++-
 drivers/mtd/spi-nor/sfdp.c       |  33 +-
 drivers/mtd/spi-nor/spansion.c   |  57 +--
 drivers/mtd/spi-nor/sst.c        |   7 +-
 drivers/mtd/spi-nor/swp.c        |  22 +-
 drivers/mtd/spi-nor/winbond.c    |   2 +-
 drivers/mtd/spi-nor/xilinx.c     |  18 +-
 drivers/spi/spi-zynqmp-gqspi.c   |  58 ++-
 drivers/spi/spi.c                | 183 +++++++--
 include/linux/mtd/spi-nor.h      |  21 +-
 include/linux/spi/spi.h          |  51 ++-
 19 files changed, 1012 insertions(+), 262 deletions(-)

-- 
2.17.1

