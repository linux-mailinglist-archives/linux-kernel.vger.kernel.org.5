Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F310378F824
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 07:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348285AbjIAFnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 01:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjIAFno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 01:43:44 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6900EE50;
        Thu, 31 Aug 2023 22:43:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yz6zCU/aJFsxNWqeEort2xWw2ssUBz4c0/93B7/mlQK8X4OuGYBnS8ZYrd9JMVUB6tVCVvkNALku0XjkDSR52S+82S7K8qTSrtQl43WooaQSOFUzAmRDhUbTAM6LOI4gCpAZD9Cc0mJyPZjuMCkUC5vJeAzUoaEm81vpyxnHuk1FFF1Vc3dbl7o7fb+pD2/9rxknaYrUC/QI1u56LbB3HJEUHEYMzkL5XE/YEkoIX40lmkf4FnTjvMzPS4uV2t7LMfUU8FTD3cIp8DsS6ftCfBgeKtwwVNg92aXlHobGT34zOkNzSLCIqE125ww1ELixHwMTO6U7dliAcdocYxy8Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRPWyppAceuvfSFgwLFF7O6J8nvnNKM01OGA0U4NISU=;
 b=GEKPJGD05kJ4cO2qwfPcHCoMu6C5VDhotQR+lHW6iigwuuW7sm+eNrO5sBcFrFJyYYVJZ5yHFQlNVxOVLNGc9WonA+0Dh/h8jNSvmPhQjDkDPFFmN5ZTTdrsU5tkecQ/umgS3ghjyalRwjMdjZNedp8hVfZvBSpPqLd84gR7SlFfUYvRAnOUp7+gDqtvj9/LRpHfBhRnZdoayH/gyeWHxykETs4f6m+ZfpY76b+Yrxsx30Tv4EySZIUNHSE8xNisAF7PXgQVAdWPQ3sUglcaTgVveJ+enDTn8uI5ZD411JCg5vuxFfhhkCVB36crkygIswgaRL9I86qPhzRRQePuDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRPWyppAceuvfSFgwLFF7O6J8nvnNKM01OGA0U4NISU=;
 b=Q6v6b+sjyjhxBSkWRHVhO+p87sYTo5Om5luDncZxp+PrKc9C/bZUn6LaYXyAmPujXwRJZJYeRqoAbBvEAA1fYyGCZyQPhEqKdIYGdZOOfb6tLO79hc9gJoKaNff4YPalpuHR90t/Eu/aahRNOr9KbXSYGMRRGClwifznmKwuENgJPbEAb+ekEtBddrGePc3v0WWEY/Gs+J1hCwbyhNNASUNb4IznQJ89mkSYSBdoN3EHSn2MqyWK5XqJTFqlwEIs8fi2vDT29L7nWJB/424uXrJ1sScXCY7J++zEgGVxmzvQVO3Owffz8fXJwUM+lnulIFJGO5RqiNc0ZljI/LqyEA==
Received: from BL1PR13CA0301.namprd13.prod.outlook.com (2603:10b6:208:2c1::6)
 by PH7PR12MB7186.namprd12.prod.outlook.com (2603:10b6:510:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Fri, 1 Sep
 2023 05:43:36 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:2c1:cafe::89) by BL1PR13CA0301.outlook.office365.com
 (2603:10b6:208:2c1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
 Transport; Fri, 1 Sep 2023 05:43:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20 via Frontend Transport; Fri, 1 Sep 2023 05:43:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 31 Aug 2023
 22:43:22 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 31 Aug
 2023 22:43:22 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 31 Aug
 2023 22:43:21 -0700
From:   Shravan Kumar Ramani <shravankr@nvidia.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>
CC:     Shravan Kumar Ramani <shravankr@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/3] platform/mellanox: mlxbf-pmc: Fix reading of unprogrammed events
Date:   Fri, 1 Sep 2023 01:43:07 -0400
Message-ID: <e51a52445052ccb4af6ce3a7ac3c7ace733396c1.1693545970.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1693545970.git.shravankr@nvidia.com>
References: <cover.1693545970.git.shravankr@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|PH7PR12MB7186:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f76dd89-d9d0-4423-b8b8-08dbaaae62f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +DlQJ8JBT4LMZHNI9Xjsftkd4HjNYuvGReUoj/UxZ4oI9Fm68aHzORjlSfZcaV3GoKJxM298O856qnngUahdV23uOXZi5nESQ+OgbhSS8yvf1jye6hFjlgviGSFDh6J9jtIo3JjPKErVOlekZJCCM2sNHehsL09nmjq2drqkmi04waCaTTkt2rd0oae40c5api5qtPqyi3rrV/1VU+gyUY8SuAoYHTjN9OSIBxoz/W0OK0k20/1pB7IbXv27cCRZGROOwH2hdoGmTA5xqfzMsGcHMOdwwtw8zb4wbENxL0kwXthBjkUY6cFKwsCY0ABBdZsPaNAFIufaa9t9FAMoW5Bn9OnSpIHwkeFaO/ElOCcH+/nfxbjJikROtmzmcfXZhtKPvctLJxCsXLfe6u8iRw7j/sLXGLm0gycuIPgbpHGS93vLksJ/geAsxmQ+DYDa7yy19kmkUKFyOlCK92R3YdAjmutCShAN0AYd22v6ZUsP4vV9g8gOjNdwu7kiYCPaO326CxV5O1pUwbEQZ1uCbGrvNFS4zXvuLfq1zveOC7v4spMAqFEL5ScEdv5u3ikyJiF+sscm7P8NjzfjXTo4RCBf5ieU5gRGw2jq1wNezCoKUjt3XBd1/p11y8/ikcyHfWI/aoBmz1Q5LthFm6ZuIEfFoVWqBiInVEkHZjU+ZrsNc7Kj9+bd5puFI63zKkZYOuIicQIrXdUM7ue04SaMEFcy/+aaBMxUZdaO3zG8HhdRsL4HP+cLhYtChL7TpRGe
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199024)(82310400011)(1800799009)(186009)(46966006)(36840700001)(40470700004)(356005)(82740400003)(54906003)(110136005)(70586007)(70206006)(6666004)(426003)(336012)(7636003)(6636002)(83380400001)(316002)(86362001)(7696005)(2616005)(2906002)(41300700001)(478600001)(4326008)(36756003)(8936002)(8676002)(47076005)(26005)(36860700001)(40460700003)(5660300002)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 05:43:36.2131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f76dd89-d9d0-4423-b8b8-08dbaaae62f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7186
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

