Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE25792860
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239898AbjIEQI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354588AbjIEMtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:49:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D601A8;
        Tue,  5 Sep 2023 05:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgbfRIO+k3Op+FGwqojHs7hmn9olwVVUOiu+NEF1Ks3J3Q06jQ4XonWcB/+FxjuRD2ANdvN9vIRGVcvgj+gXXthpn1NBCjEVXKG4IYQi+hVeWgYHeKbC/Z61VpRYAzfSNLMiX1CmZULegnkUmELyVEH+iqXDVQvNuNn0ySBsnHMgKMMfiwVoXeQwTPk+HuuffxRD24ydCLlo2kWvUi5lIs5MA/A14SG0x82hsjTce6luXpavSJRyixBLWHDaqL1mOjjStBwdwjvIRNnJoxkJOu/xms2iBb52uuZQqLtlXSJGj2brhYT+7QibZ5GtXuLqaSfBJQ+bSsodGrPumR7HMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRPWyppAceuvfSFgwLFF7O6J8nvnNKM01OGA0U4NISU=;
 b=J9FHsAaA1FHQE+nNc0wIEZbOeK4QiOmEkLLaLYIshVBKwP5ySx+KfivPGMZiv9fQhEAtnnL6tK22GXQHFvuM7bKR1h4eIlJbmre1YgEhdCHDkEgM1f0Q87moL2f4PLnuZNEMY49nAOmeSBd9R7y2GVH91kafjg1ryDQz5QYsAUaQdZ21dImvGWbCCecpGiquMYM54PDHsLFOeKlrc+LZtlQit7sDQCkL8RYsvl0lJDW/1NbP4jTZy6ObzS7AYnwbBIUmFcCnPElRTfpg3I0oZQTzIz0So0RD9ozS1v1EE8wVBc2op+kM/F5f5Mk4l3cxtFiukIls/Wh7clo/Pq9G9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRPWyppAceuvfSFgwLFF7O6J8nvnNKM01OGA0U4NISU=;
 b=ZpgpdYzkJpqvSJSg/7DzPuNjnX7yBjrJRJuklZ2Qg2NuQUbW9VX1bEHCPWaPDYXrFv2huC4n8nKhecLIRdiFyFprDZ5N5jnAM6nCtkIjcfACyknGBhT51g11XOYOs3zfDn+kbf+IeVILr8VaasoZneJHjWgfCnSS3VGfRMwPQYrqroDLv0PA9fvuoJoYbfIUTZlc291WemT2Bp+3Q3kybibNU6/q94ixs+xy7w/Uw+LuLyrjEAUwLRw8L10PbxQxzYUNb4RLnMPToJ9q9hVzeBGaHpmqPv7eMWonGcbNyRZEZlswlwgHn12UlNVBU3CEf1jNl15/xFRQJEdySp/iMw==
Received: from CY8PR22CA0001.namprd22.prod.outlook.com (2603:10b6:930:45::6)
 by CH2PR12MB4907.namprd12.prod.outlook.com (2603:10b6:610:68::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 12:49:45 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:45:cafe::8f) by CY8PR22CA0001.outlook.office365.com
 (2603:10b6:930:45::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 12:49:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 12:49:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 5 Sep 2023
 05:49:42 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 5 Sep 2023 05:49:42 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 5 Sep 2023 05:49:41 -0700
From:   Shravan Kumar Ramani <shravankr@nvidia.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>
CC:     Shravan Kumar Ramani <shravankr@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/3] platform/mellanox: mlxbf-pmc: Fix reading of unprogrammed events
Date:   Tue, 5 Sep 2023 08:49:33 -0400
Message-ID: <04d0213932d32681de1c716b54320ed894e52425.1693917738.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1693917738.git.shravankr@nvidia.com>
References: <cover.1693917738.git.shravankr@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|CH2PR12MB4907:EE_
X-MS-Office365-Filtering-Correlation-Id: 47369a45-9400-4294-fa7f-08dbae0e94e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: coKuitk4SdJDShubN2a/wC6qZV2Plwk/OfMDal9QzkXZXENa1lo1eskFTlUH8ZHkAMLuW8DogaF4D8JIjuRuH1P7E8wuQmcgCiS0R/TZLMLCjCmVS/mIgUqYQ0o1RQtQCsRMJsKzTEWP+o6gAEpOI6KKU6st5zXeWjJwyxk/Lg+qWGaVkAmPfIgbBthI8NQBrs31ClCPVpMkICgqayrYd5WM1ZtpGckZP0HNThE4+ZIRpyGcdcWBn6/WwtBvjakmaBDrmSxRb0olXbSH/W8BSQ8vv+4C4R9oLKZ+NKupGlVVFadIJgOYBVyl9MerARSuSKayrr9xX2I1dZLEn8e9AAwEfU4Ba1gy1IgvrWyRsTd/7TqxzXyGSUdKvm0NaAxOjPv0p1NHQd1quMwE0Cxi8WuuCg8EpxTbE4ht+ouhmnP6Clcldu3/12YPioH/GTXubVx2iP5JRTgwMHnIVGp8Rpaluz/tru81AJe9me2+n3O7hiaopv3n6tA/th8TXLtQ0LXj2t0Bw8gK2rXxgc1YFQU7fRqO7dGLzGuC8VSN3TglNXjAZaP1Mott5bSztRzbnsbOxIMiJtKEQHwUpUsu5LE6Wc9o6VnVG07RXVWas3PUg5DKNr2r8C4kv3gFpU7MAoVozh+ARzhcaJrtZiI0JDb6j+rSQPHBdyrf/I5x60+DnCE24xUWQftSM13fY0t/wHNnMu1VBXKAuHsapyV75W2juwy452tfKChW09Vp3GLiCWuZcO3fYnC6CnZmDCbE
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(1800799009)(82310400011)(186009)(451199024)(40470700004)(36840700001)(46966006)(26005)(5660300002)(2616005)(8676002)(4326008)(40460700003)(8936002)(2906002)(47076005)(83380400001)(86362001)(7636003)(356005)(36860700001)(36756003)(426003)(336012)(82740400003)(40480700001)(7696005)(6666004)(110136005)(70586007)(70206006)(54906003)(478600001)(6636002)(41300700001)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 12:49:45.2798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47369a45-9400-4294-fa7f-08dbae0e94e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4907
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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

