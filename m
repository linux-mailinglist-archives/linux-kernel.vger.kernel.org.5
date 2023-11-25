Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752DB7F8989
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 10:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjKYJV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 04:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjKYJVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 04:21:49 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F0C1988;
        Sat, 25 Nov 2023 01:21:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaH0UML3Ok5VkMJ08+qg7Gk8Gjbul0/DMeurEjFBCBOCxTndgRWA/vwdTRuf4kVCPGsPyrZh6ZuwKpXH1bUtpExzuSXrw26V2M+cEgiQVCwqTPdQYTSgNG9wndRf/2unk5mbhCc2JnyniumaNG/HPXbKBmArn5/+Yp834hsmmRcAp+lRaiPVLNqII/GbgECbtHQtjm64oEETRpk2wD3m8+UNGB7ileipPDxtVBB1BpTjsV+ZW5OuRSQcEJAZ27K+NXhy5rjTBqvlKRkcEJZW7436roU8HV4uFPY/L2m0FvJtI3yDZeE0nPM/SL/U2LxknlKibt3XFOW46O9qtHytqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOcXqCj/Ujdo7ubKiSjoRigKz4vONyHsJeJ/DMgGmdU=;
 b=bj5EGfhPxFTpbRqXxeydPTL1kPVhnTiKt89pSwPO6Pw6siZwZ6AVozq5n0tDBd9/e838aIGSo9e21GQO5aEI1HOzwtg7kKig7EJw+3hegcZ5hlE7wUwhQ/VRD3p9vJZX6E0Cn+JD8r8S0PEp0SmezL3N5sNNLXTCGdK6bojHpDOghHPG1E9Ir/w/3u/dUxsNepvwTziXGIqvWeXwUAM3HHMT6Zy5exlGh6x3otzh1o6MW+4wSb3n5FHbu/QnRP5rzmIojACycZ+RXVn1hFbailjwuI+ioK0Rm85fsatbzzrAJAXEFOvYpxZvVZkyzsp86ahV9a8Mmq1YlBSZVgVR8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOcXqCj/Ujdo7ubKiSjoRigKz4vONyHsJeJ/DMgGmdU=;
 b=yDrY78bt53PAcTlRXeB8FDj6J4I6wSJPQ9dO+/SXvIitVBlid5HbtKMBwFHXxav7oNdhLG62XnQFejptLV06gbKFycXO6kVMxkoql2oWLQj9tLPtAJoYLuG4v5gFlc6mqh9AnTgbIhoz9Pq13IGfFyE9oNN0ns45aRNY1LSQOg8=
Received: from DM6PR06CA0062.namprd06.prod.outlook.com (2603:10b6:5:54::39) by
 BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.24; Sat, 25 Nov 2023 09:21:47 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:5:54:cafe::ff) by DM6PR06CA0062.outlook.office365.com
 (2603:10b6:5:54::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.24 via Frontend
 Transport; Sat, 25 Nov 2023 09:21:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Sat, 25 Nov 2023 09:21:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 25 Nov
 2023 03:21:46 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 25 Nov
 2023 03:21:45 -0600
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Sat, 25 Nov 2023 03:21:39 -0600
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
Subject: [PATCH v11 00/10] spi: Add support for stacked/parallel memories
Date:   Sat, 25 Nov 2023 14:51:27 +0530
Message-ID: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|BY5PR12MB4179:EE_
X-MS-Office365-Filtering-Correlation-Id: 90b9c222-9a76-4186-eb47-08dbed97f2a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QriRegH0EdXlaEFmG2V/BAjzuJ3Uts8uxf4hq38QZ84MiCgxyLCjC6YPFLznD7CIDsyS5QOdAdlFu0/Q74qttSxG/TInHOYLQEgne8jVke7ALHzZyCpt/X86sttIf9ASLbUKbR6GwMapOMIbVycvKCjXcbDqgJuCPqXbH/0bmgDHnqfqFHwgCySqVlej/+1I9h4qoN0ILVLC762s+tNR46PWnBJojPgwFKnWVIikYkgXRA4a+7HGXWnukIFRjSLA+QXajD+mAXVKL+HQhF59/y8IbqcC5bOm3iVBfXf9PHle+cLL++7xkcgT3a4OB6bEQ+h3quiomi0LSSXf8CDbbJs7qjhG0R7LJe3EGVcEx0QTGIzygaF3WyMyITriYfCSIZloGnu3Tj7gipEQaYg8N73+MhF+08ohjVjtltJayUp1Hr/oaQDon3WRm6A9aXmjMPXvdakJzrog1c0qxmV7F19wGKu6N+HCZ6ui5okiUP1poN/w7KvhDl99lArmgVHgBunU0H/2YJLHwGZXx1yKG6EgRkB/EI57skDg2+GC15R6oyLaJVlJSv3+0f48s/Qzi2YnqoC7JbI3a/Y/vEzKuePHaDT6jc2t9ANJthN56J7edNwQ2buv1Oz7fSzHsdLp2jBNNUh/zbsdTsGxw5oD5ncBqchT1b3lVSZnCJac5pjaLFxXW5Auxa5/Fvg/gVA+mEXHdsUtuKuRwRinmpVEhmepV37qW4VRUQ8dGwhcmannA3bqv71kLTCEemOwtCjYTNEJdgYh5x2ryDG+Ul83NJndfslHycXENEqFw4XrPlbfcZOzZyX2Nwcm4wAt/n15VGr79XP1JaaP7sdFyODwe3zvw3nNrCkMSgZKVcZNYS4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39850400004)(376002)(136003)(230173577357003)(230922051799003)(230273577357003)(1800799012)(64100799003)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(2906002)(7416002)(70586007)(70206006)(110136005)(54906003)(41300700001)(8936002)(8676002)(316002)(478600001)(966005)(6666004)(5660300002)(4326008)(2616005)(336012)(426003)(26005)(1076003)(83380400001)(47076005)(40480700001)(36860700001)(86362001)(40460700003)(356005)(81166007)(36756003)(82740400003)(921008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2023 09:21:46.8964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b9c222-9a76-4186-eb47-08dbed97f2a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4179
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
for-next But the rest of the patches in the series did not get applied as 
failure was reported for spi driver with GPIO CS, so send the remaining 
patches in the series after rebasing it on top of for-next branch and 
fixing the issue.

CS GPIO is not tested on our hardware, but it has been tested by @Stefan 
https://lore.kernel.org/all/005001da1efc$619ad5a0$24d080e0$@opensource.cirrus.com/
---
BRANCH: for-next

Changes in v11:
- Rebased patch series on top of latest for-next branch.
- Added a new patch(1/10) to replace spi->chip_select with
  spi_get_chipselect() call in tps6594-spi.c.
- Added a new patch(2/10) to replace spi->chip_select with
  spi_get_chipseletc() call in cs35l56_hda_spi.c.
- In spi.c initialized unused CS[] to 0xff and spi->cs_index_mask
  to 0x01 in all flows.
- Updated spi_dev_check() to compare the CS of old spi device with
  the new spi device CS.
- Updated cover letter description to add information regarding GPIO CS
  testing and added Stefen's Tested-by tag in 3/10 patch.

Changes in v10:
 - Rebased patch series on top of latest for-next branch and fixed
   merge conflicts.

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
Amit Kumar Mahapatra (10):
  mfd: tps6594: Use set/get APIs to access spi->chip_select
  ALSA: hda/cs35l56: Use set/get APIs to access spi->chip_select
  spi: Add multi-cs memories support in SPI core
  mtd: spi-nor: Convert macros with inline functions
  mtd: spi-nor: Add APIs to set/get nor->params
  mtd: spi-nor: Move write enable inside specific write & erase APIs
  mtd: spi-nor: Add stacked memories support in spi-nor
  spi: spi-zynqmp-gqspi: Add stacked memories support in GQSPI driver
  mtd: spi-nor: Add parallel memories support in spi-nor
  spi: spi-zynqmp-gqspi: Add parallel memories support in GQSPI driver

 drivers/mfd/tps6594-spi.c        |   2 +-
 drivers/mtd/spi-nor/atmel.c      |  17 +-
 drivers/mtd/spi-nor/core.c       | 683 +++++++++++++++++++++++++------
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
 drivers/mtd/spi-nor/swp.c        |  25 +-
 drivers/mtd/spi-nor/winbond.c    |   2 +-
 drivers/mtd/spi-nor/xilinx.c     |  18 +-
 drivers/spi/spi-zynqmp-gqspi.c   |  58 ++-
 drivers/spi/spi.c                | 259 ++++++++++--
 include/linux/mtd/spi-nor.h      |  21 +-
 include/linux/spi/spi.h          |  51 ++-
 sound/pci/hda/cs35l56_hda_spi.c  |   2 +-
 21 files changed, 1085 insertions(+), 270 deletions(-)

-- 
2.17.1

