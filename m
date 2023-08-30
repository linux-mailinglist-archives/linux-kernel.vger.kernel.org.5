Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9139078DFC0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243435AbjH3TNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243508AbjH3LM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:12:58 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4017DCD2;
        Wed, 30 Aug 2023 04:12:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKFMKRvL6/YVTg4qpdQz3W4e7yPXsDlPhoUeTVW8n5UxWnbpmebUnQlsSuMBuOuxiq5PMWdLDYZgYFAtrBLXrdMIJM5/XmF0hefNhjt+7yl+MutVjNYOZT/EwDLc37QP5PLZtxB76AmYgEkwaTT9rfjOyJKHR9HrgPftjs9esq7oyRXb/Dr1AW4g/ZKsByZ5WZKC6Co+HeK7fZ2PS2cfKQOxP1rlcIXzSU4Ru/ohwi2D+47g47/P/L2tbmIF2AQehJs0pw00NW5CfwcTo1wu9u9b5DRHOJ1/slm6zbYfuaSGnqeZUUwM51qv1pCEPsmJYxAzY6Y/ZrsmulPUh1+Jbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRPWyppAceuvfSFgwLFF7O6J8nvnNKM01OGA0U4NISU=;
 b=acslouzMFyBbzbqScT6QtHsYRD7Zmpm5g0ZKjX9v8P6E7aECiHDQIPCyLMwJ7AMkD4ZXSzjBLUdrwbsUEjNyXG3fHYAZY5+xftHyTVOAzo7+HjnBHj0fT+9pEq7c0x9IUrVWOk5PehRWxCDb1d8XksTS04X8DBYBv/gOL9zlPfstWSti4LsT5vDFHNQqWpzDF/dP1Awtu6F6m1hwJQSp39HHDYHk2qpdeHdkI4RZSalSkt6iGtfNqQ23JrE7xYV3yHUVMlH1QDuQEM1zqnpI3UD8FLoaIlv5J1taMKY7nRt81hjxYpQBlHYaGjQX7u3WA1TK3tMhNVz5xiEkjQcglg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRPWyppAceuvfSFgwLFF7O6J8nvnNKM01OGA0U4NISU=;
 b=Su/CGuCetIEopBVPURIemhK7nqh7j1XZYcg/nF7e5htSj9mCjrZmLjfUUzCLc8nZNHOqiAKXl0r3eWI9U3r7nTFs215VegiQLzPSMzPbY/neymzDyNat2T7q4sRodmkmsHo7BcYw5Az5+6wPtoY+wvk6xj0bc+GtwnhY9505ubLDcRl0/EZUzPOjkvfseH4rueEPZAOnOH6M4mjoQbatIiA+RkFnTHYEsMTn/wD5yvF2bbHamBPXfjvf51xP7g/cu2ITXnnk+05pzu+0B4LwSx4ZP6ezE7tbS8gYThfkrx1woh+SL0qVwM3P26zpsvz2OVAcQg1Ydn8SAez/00YNtQ==
Received: from DM6PR07CA0130.namprd07.prod.outlook.com (2603:10b6:5:330::22)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 11:12:53 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:5:330:cafe::71) by DM6PR07CA0130.outlook.office365.com
 (2603:10b6:5:330::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
 Transport; Wed, 30 Aug 2023 11:12:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Wed, 30 Aug 2023 11:12:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 30 Aug 2023
 04:12:43 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 30 Aug 2023 04:12:42 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 30 Aug 2023 04:12:42 -0700
From:   Shravan Kumar Ramani <shravankr@nvidia.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>
CC:     Shravan Kumar Ramani <shravankr@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/3] platform/mellanox: mlxbf-pmc: Fix reading of unprogrammed events
Date:   Wed, 30 Aug 2023 07:12:33 -0400
Message-ID: <e51a52445052ccb4af6ce3a7ac3c7ace733396c1.1693393544.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1693393544.git.shravankr@nvidia.com>
References: <cover.1693393544.git.shravankr@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|BL1PR12MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d10b373-3b3b-49db-2007-08dba94a0d3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: utVQBZN/6S4o0QhOukpQy4H4VwCm+ZffHd+tDZkzh6wnq82hYlja0MiKGvfh3hWn2mKzFCQ9affQDiUHwYTb295yhbGOapWup3CilpV5Jy2Wib85jtNlQ8VCKOC3zyhrpX140dy6qP97yP+qbfXp5tus+3DBetYkqHjGCmYzSdas7PiNpccnUumNpP1vnJ5/m4D7DMCbl/yHIstiSGcC8e3SC1EaixbHgGR2t1jXo5X2S+Vi4ER/DIE2xrpqdwTsBW5m4ptd+vhvVWKNT8UzFHC4/JO9ZH1Wbd29aGrAI6wy+z0TesR4gJBqXVgz/cIdydS3pP6/9YhhBZOUfeZrMJVvf+WL5J93TZriEwsbxNVT+IThhbKX34/Xbc5vwYBwsIyb0ISu4q0W6MogbVEczbhQOwG4ErtUbmEkQ3I5CexNk/t4qDApMMMQ4t7TdlWAWQORdjKfLSzhAcaR3kfRu2ZXUGZ6qjYJQ0aJw4VxvXzjawWxXEtsBhFJ/Z2hfKZ2qHVBDBRaUm/vFOQpc4sGKyi5AvXMO0g4lX1CrDHSFwxPBICTE75Afiy/m6eQlJbM5qNYXEnZUz2u5VxR2OmsNwE6smyRFs3eg6MoBbKA5mh0wqGnLUSfgB0tYz5QvZ8L/Na8PoQiS2nRGf9nHZTOMobiSslQbiouVVlCm/A9jyms3wPpN9fqpLgboOHPINfdtlKnMRb4ghNOaMhyG5BMz+U6Vpf+ShlB9JX/yjXhND9AjOBr8rqHYSWQPNEYcdRz
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(186009)(82310400011)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(7696005)(6666004)(83380400001)(26005)(478600001)(426003)(336012)(110136005)(6636002)(316002)(41300700001)(70586007)(4326008)(54906003)(5660300002)(8936002)(2906002)(70206006)(8676002)(40460700003)(36756003)(7636003)(86362001)(47076005)(40480700001)(2616005)(356005)(36860700001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 11:12:51.6812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d10b373-3b3b-49db-2007-08dba94a0d3e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fix involves 2 changes:
 - All event regs have a reset value of 0, which is not a valid
   event_number as per the event_list for most blocks and hence seen
   as an error. Add a "disable" event with event_number 0 for all blocks.

 - The enable bit for each counter need not be checked before
   reading the event info, and hence removed.

Fixes: 1a218d312e65 ("platform/mellanox: mlxbf-pmc: Add Mellanox BlueField PMC driver")
Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
---
 drivers/platform/mellanox/mlxbf-pmc.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index 95afcae7b9fa..2d4bbe99959e 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -191,6 +191,7 @@ static const struct mlxbf_pmc_events mlxbf_pmc_smgen_events[] = {
 };
 
 static const struct mlxbf_pmc_events mlxbf_pmc_trio_events_1[] = {
+	{ 0x0, "DISABLE" },
 	{ 0xa0, "TPIO_DATA_BEAT" },
 	{ 0xa1, "TDMA_DATA_BEAT" },
 	{ 0xa2, "MAP_DATA_BEAT" },
@@ -214,6 +215,7 @@ static const struct mlxbf_pmc_events mlxbf_pmc_trio_events_1[] = {
 };
 
 static const struct mlxbf_pmc_events mlxbf_pmc_trio_events_2[] = {
+	{ 0x0, "DISABLE" },
 	{ 0xa0, "TPIO_DATA_BEAT" },
 	{ 0xa1, "TDMA_DATA_BEAT" },
 	{ 0xa2, "MAP_DATA_BEAT" },
@@ -246,6 +248,7 @@ static const struct mlxbf_pmc_events mlxbf_pmc_trio_events_2[] = {
 };
 
 static const struct mlxbf_pmc_events mlxbf_pmc_ecc_events[] = {
+	{ 0x0, "DISABLE" },
 	{ 0x100, "ECC_SINGLE_ERROR_CNT" },
 	{ 0x104, "ECC_DOUBLE_ERROR_CNT" },
 	{ 0x114, "SERR_INJ" },
@@ -258,6 +261,7 @@ static const struct mlxbf_pmc_events mlxbf_pmc_ecc_events[] = {
 };
 
 static const struct mlxbf_pmc_events mlxbf_pmc_mss_events[] = {
+	{ 0x0, "DISABLE" },
 	{ 0xc0, "RXREQ_MSS" },
 	{ 0xc1, "RXDAT_MSS" },
 	{ 0xc2, "TXRSP_MSS" },
@@ -265,6 +269,7 @@ static const struct mlxbf_pmc_events mlxbf_pmc_mss_events[] = {
 };
 
 static const struct mlxbf_pmc_events mlxbf_pmc_hnf_events[] = {
+	{ 0x0, "DISABLE" },
 	{ 0x45, "HNF_REQUESTS" },
 	{ 0x46, "HNF_REJECTS" },
 	{ 0x47, "ALL_BUSY" },
@@ -323,6 +328,7 @@ static const struct mlxbf_pmc_events mlxbf_pmc_hnf_events[] = {
 };
 
 static const struct mlxbf_pmc_events mlxbf_pmc_hnfnet_events[] = {
+	{ 0x0, "DISABLE" },
 	{ 0x12, "CDN_REQ" },
 	{ 0x13, "DDN_REQ" },
 	{ 0x14, "NDN_REQ" },
@@ -892,7 +898,7 @@ static int mlxbf_pmc_read_event(int blk_num, uint32_t cnt_num, bool is_l3,
 				uint64_t *result)
 {
 	uint32_t perfcfg_offset, perfval_offset;
-	uint64_t perfmon_cfg, perfevt, perfctl;
+	uint64_t perfmon_cfg, perfevt;
 
 	if (cnt_num >= pmc->block[blk_num].counters)
 		return -EINVAL;
@@ -904,25 +910,6 @@ static int mlxbf_pmc_read_event(int blk_num, uint32_t cnt_num, bool is_l3,
 	perfval_offset = perfcfg_offset +
 			 pmc->block[blk_num].counters * MLXBF_PMC_REG_SIZE;
 
-	/* Set counter in "read" mode */
-	perfmon_cfg = FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_ADDR,
-				 MLXBF_PMC_PERFCTL);
-	perfmon_cfg |= FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_STROBE, 1);
-	perfmon_cfg |= FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_WR_R_B, 0);
-
-	if (mlxbf_pmc_write(pmc->block[blk_num].mmio_base + perfcfg_offset,
-			    MLXBF_PMC_WRITE_REG_64, perfmon_cfg))
-		return -EFAULT;
-
-	/* Check if the counter is enabled */
-
-	if (mlxbf_pmc_read(pmc->block[blk_num].mmio_base + perfval_offset,
-			   MLXBF_PMC_READ_REG_64, &perfctl))
-		return -EFAULT;
-
-	if (!FIELD_GET(MLXBF_PMC_PERFCTL_EN0, perfctl))
-		return -EINVAL;
-
 	/* Set counter in "read" mode */
 	perfmon_cfg = FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_ADDR,
 				 MLXBF_PMC_PERFEVT);
-- 
2.30.1

