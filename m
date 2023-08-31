Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7798278EB5F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345348AbjHaLGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjHaLGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:06:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655DDCE4;
        Thu, 31 Aug 2023 04:06:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhH2L9f/8IsEvWAnWEkQPVyNGADjHm04gyeM0e8f+7nn6ZpPgJfeEAHKWH5NU1wxDTo1wKpNPKKiv6sLSQj+Rahp1DyBIWAW3YLnwyTnJ2DuvtXqaCtLBKmYNP39USPNtD+gJRsZ1Z4v9w0NoX7wY0h+G3Fjwgfm7LmbfaIqJfH8pgJ06F7gZAKgx2OFr8r9+fGwNVQ0yQxynbLGbCmqio5XYVgiXILuh86qC0gEYtaXors5/5Aowa5x34aN/SeHt09TG7o81PObzr+9UxxCdGI12oqlCc2QEzpAbt8ZRLaFae9NPZCVWbAzikFF+ngu38M5FcrItWkv92OcpNGEkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRPWyppAceuvfSFgwLFF7O6J8nvnNKM01OGA0U4NISU=;
 b=ltumeGVILptMmht6+xipXbjyDJY6R/8XF/4H1nY6psRZ7axmeRngluM2ewlbXjswbH+dZj+D3OLfn7NM1bMb3z/IdbBfh0EBuBo6ti6AU1wsWhSs/PXclTGIB7dxhReHB++5w11+g2Xae0T4A6fxfNnqxxabDZkh1ah8LpOWDmotNd6v5U1mhgOC1Wbm6PesVSQb6LyXHY1OrkCKlZ/S74IKS9DXSWrUvSjqIincTbrXTjp9wnSMxa8sDedl6lWFThZ+Z1C7gzY50WPfRnXcw8o+BDjaDyvspkKEe7UqCy46X2Uu4TT2W9ve/z40adD6lRHm8x7wkXlbwv52omvt6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRPWyppAceuvfSFgwLFF7O6J8nvnNKM01OGA0U4NISU=;
 b=PEb905ywVIEj3LbnZWjxOgycg4ML71yPayJLVDZqOzsGgNve9D2s/JhhWgIJzcwHltDnDMaSRa60AJepsu3r1dK90M68KOlyiqIBR0oDi+9gGUtY2QIyAmol9DH9kUalwT7JBoexn1uMD7tskE4gh6ff0LkQJt1elnKeRyD3MGEOs/lA0JmeZzI/xaX4EM3XYzFM33q6xn3ZrX1T6HdqpIuhPjZ26ttPApvv+FzXPhMwqDE0BL+lV7n44owOb0FY4AFkvc++gI4A4AmkwH9PbTJCrZACUWf7b9eA2CSowF25biOvFQpOivRR8fOJYMGDpRxFsrikzsfT48ofyCrQGw==
Received: from CYXPR02CA0080.namprd02.prod.outlook.com (2603:10b6:930:ce::8)
 by PH8PR12MB6723.namprd12.prod.outlook.com (2603:10b6:510:1ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Thu, 31 Aug
 2023 11:06:31 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:ce:cafe::c) by CYXPR02CA0080.outlook.office365.com
 (2603:10b6:930:ce::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Thu, 31 Aug 2023 11:06:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 11:06:31 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 31 Aug 2023
 04:06:28 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 31 Aug 2023 04:06:27 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 31 Aug 2023 04:06:26 -0700
From:   Shravan Kumar Ramani <shravankr@nvidia.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>
CC:     Shravan Kumar Ramani <shravankr@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] platform/mellanox: mlxbf-pmc: Fix reading of unprogrammed events
Date:   Thu, 31 Aug 2023 07:06:18 -0400
Message-ID: <e51a52445052ccb4af6ce3a7ac3c7ace733396c1.1693479119.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1693479119.git.shravankr@nvidia.com>
References: <cover.1693479119.git.shravankr@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|PH8PR12MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: 73031206-d78a-443d-ccc9-08dbaa1254e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KKu7m4h4hlMF1Jd9d5jsb1DQnCjDAS8InRhCvdRqPpBXv+RWVCQ1V4s1vKnhjw3xuNgoIZU66JvCr8XmabJUmzn0Je68A6kZBHl3XgWM7018uecwRd7al0zvKfBsQ8KqRHpmhTs8D2A1vh9NLB5b0ZFf0iLqXnDJ6RrgEXbxeuhrHRbB1G7Klw8z+ktpZeRJyKZ6cIgwQJk/xgRDK7sKTi0W8D2VCUv52mgJLvVU9yQvtRZCJitvpkL3w7MOvtZwrRmK/9JrDL6tWbvcHF/Af5HRkmKFxAfJ6aTwNl+ROeSAaq0Qt6pFBjp6683aT+BT1ycbk5YDi91Sk6wGVhM77o2JxkSfj196LKC6snjsKUO+PTBTw5iEwWWbPIMx8S62PunA0fo4LqLBcA5iU/yyzj8o74x+P2hbdjsbFJUQRqgkv88VTKJ2ULjaUyD89fWQ4UcXYSI1g+INEmQIXZxvRd2OAQEGJxRrdgnNPsCDeZvvj55dyct/UpCyn7gQgddKVJdiNSBGGgd1V1I4aTfk6UviLkoxy+L1HIuOKYO0o6s6MVfGpCbXUO8j/cgX6smy73MaZFnbxaMz6MhK0rRMXuO9ZcevZUwnOa5Gecuc5rmYMnf6Gjyd3/zkm9WXceD36XH0y1NBVGp7A7sKEQDpTfb+EnWAJHsrQEQ/lpk385SArCEnroTEi0vz3yFqBdDrFZISjBSQK97mZh1uhPy0idgoAcsrsGTp7LEkOI7I50UUjZxNG/UGOLCKfJSbH/iQ
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199024)(82310400011)(1800799009)(186009)(46966006)(36840700001)(40470700004)(40460700003)(41300700001)(316002)(6636002)(8676002)(4326008)(426003)(336012)(2616005)(2906002)(47076005)(86362001)(5660300002)(83380400001)(36756003)(26005)(36860700001)(40480700001)(8936002)(6666004)(82740400003)(7636003)(356005)(7696005)(54906003)(110136005)(478600001)(70586007)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 11:06:31.2377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73031206-d78a-443d-ccc9-08dbaa1254e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6723
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

