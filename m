Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86837FCFFD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjK2HgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjK2Hfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:35:52 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B51E1;
        Tue, 28 Nov 2023 23:35:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKP3XXgAdgttPeVaWRuMRVn0I2GhzX3cBkkHvfJkgf1o4M0//3eEz9Qiz04mczkjeqJQIl+VQmawf213M2q0QILRgpRD2DPMwp/rXoQ3MrKnS9hcwwKZNuzgDooqJf1/Z4e7oWQtPL2thxy31Z0J9BkRGPy+EM+Gzt4l1R5KYe270QIrUvhdMglsV0qEGASPfb4gxRLJnDmE53gwH3oN7DziiTiDktAOTTcPXGVQD3ODRTH0JiEdZY3ltSEOnEO8gR5X8BDrNsvST+pi+5LsYsJw4aLTGpFi9swEzV3tIMt8cgF8sh52wf8jmEcCo+ccmPL1dPFfP78vZGoUab1NgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRsmIIO2mD3KoxwrnP2poQfIl2uWtLwQwFukcnl9i9A=;
 b=B/24Pw0m2YCuRj+UwVSYv+2cXmb5SG41Lj7Q0oVnx5LgSpW0wQoH8UWFEBRoa3/46qt6U0P64smSFVoF8XSmQ5l8eZNYeMHUb3sWtWcIi6+owK2rXsXtcbG3MkUaGAWRjQHwfAfUlN3nfL8TMVsdSG2lafuLPlOA40+wTsMLJnYFHxcW6KzaRylI87APdDXkT57Z9GoYpbORvfK9QZE3B0EdsF9dgW882d9WzrdBHbE/iUNH0RSPvqir8KXKlTgDkBru4TdAyaMsfDKuF9UK6IsJDV+HfIlxkchzMp/CoFSzlEvPIlFKFr7iPk8LL0ed353kFVw+yZAeVlgVbA8krA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRsmIIO2mD3KoxwrnP2poQfIl2uWtLwQwFukcnl9i9A=;
 b=0ikaEmvCgx6V0VeNeHwDkb7BfvBWOC0rt1n1d27VHe2rjR9J8nKu4ZrtgSijpbctRVLLpR4d2NaOFwrcBNZqa+gQPnvE8wmm2d3zZZrl/B/O8wG09QF4jnYR3BoRj4dWXLs8VWYAThFkZLVzaHG2eWJfCR+5WuBs7tINbzOKg4Q=
Received: from SJ0PR03CA0283.namprd03.prod.outlook.com (2603:10b6:a03:39e::18)
 by PH0PR12MB7093.namprd12.prod.outlook.com (2603:10b6:510:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 07:35:55 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::55) by SJ0PR03CA0283.outlook.office365.com
 (2603:10b6:a03:39e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Wed, 29 Nov 2023 07:35:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 07:35:54 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 01:35:52 -0600
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH v2 5/6] RAS: Add fixed Physical to logical CS ID mapping table
Date:   Wed, 29 Nov 2023 07:35:20 +0000
Message-ID: <20231129073521.2127403-6-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231129073521.2127403-1-muralimk@amd.com>
References: <20231129073521.2127403-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|PH0PR12MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 18610aa5-318e-4069-4ec7-08dbf0add21f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fnnlp4FWLoc4ePmdtpT3JSd+2SeNNqDKoVZvFRybceLDHzPtmFwmd0gGqIZLELIaNYL0s9GXZyhuLWtwmvJ1puMkGToc+NaKYDW3L+J4vQ4CW4vUgejBMsQquDhrGrgEFbbwzYVPs9k17PCL4zEIi+50etPcGjKmgJWWc+WnRP7WxxCWwUIqlcDOKfgL4H/bH5eXPsdtpFwPy8CdTheE6typ74Eq1cUTYCXRk0Dl/+BF+umltW4pvKsLwKS5GderpdliXiJfd1N3FKthqbOWnEhkAGHXklixkgz134bZV7E7fvCdrJjaKwy6denvf/k72OEgHfWbEtk2PFq8UG1kAiqdgmE11etVa2OMThGZsoe3v1THCrdy6yx9jZVXSwh2scShw+zqugKA6HiMgM5GS0lqgR+xIxGPW2QzlCEc/HfsnFU6B3uUkEx/h7uiMbL5Ue5b6ghnK7Ej0+BlDgU/pBxkQeJsBoilznq65GOcskTNW3GVF/b+v1I8EHMKBGh7s6/U8pBfRl0XB0QqTGYbvPTnlKYKYFMGNAtM3jBRGpmqIucUE/VKfN/fCjg0ErN1Iqq2RYGRwjvtZ3cpv3iXe9bo85xoquPjf07jCzsLqCxjDt5xvLMN4IjuBjqNdESk0eR5mgAhUAsqOnJAoUCZMkG+/PAXFaCDSXlACrvMNuyh41ygDMvbu44hKI+P/hTwt6amV2XqrjTNoU+PZFi3Wh0VxLFKh+ecM6OHdHtg5owfPEKr2B1eSpzN4shlZox7wK9eLipIHmb98WPEa7TR7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(316002)(2616005)(336012)(7696005)(426003)(16526019)(70206006)(70586007)(26005)(36756003)(478600001)(82740400003)(47076005)(36860700001)(83380400001)(356005)(6666004)(81166007)(40460700003)(6916009)(54906003)(1076003)(5660300002)(2906002)(41300700001)(4326008)(8936002)(8676002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 07:35:54.6770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18610aa5-318e-4069-4ec7-08dbf0add21f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7093
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

AMD MI300A models have a single Data Fabric (DF) instance per socket.
So, only one out of 4 AIDs are software-visible using PCI Device 18h.

Add a static lookup table for converting physical CS ID to logical
CS ID for mapping of all 4 respective AIDs in a socket.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
Changes:
v1 -> v2 : None

 drivers/ras/amd/atl/denormalize.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/ras/amd/atl/denormalize.c b/drivers/ras/amd/atl/denormalize.c
index b233a26f68fc..4c127347a56e 100644
--- a/drivers/ras/amd/atl/denormalize.c
+++ b/drivers/ras/amd/atl/denormalize.c
@@ -442,6 +442,20 @@ static u16 get_logical_cs_fabric_id(struct addr_ctx *ctx)
 	return (phys_cs_fabric_id & df_cfg.node_id_mask) | log_cs_fabric_id;
 }
 
+/* Physical CS to Logical CS mapping for MI300 AIDs */
+u16 phy_to_logicalcs_mapping_mi300_aid[] = { 12, 13, 14, 15, 8, 9, 10, 11,
+					4, 5, 6, 7, 0, 1, 2, 3,
+					28, 29, 30, 31, 24, 25, 26, 27,
+					20, 21, 22, 23, 16, 17, 18, 19};
+
+static u16 get_logical_cs_fabric_id_mi300_die(struct addr_ctx *ctx)
+{
+	if (ctx->inst_id >= sizeof(phy_to_logicalcs_mapping_mi300_aid))
+		return -EINVAL;
+
+	return phy_to_logicalcs_mapping_mi300_aid[ctx->inst_id];
+}
+
 static int denorm_addr_common(struct addr_ctx *ctx)
 {
 	u64 denorm_addr;
@@ -451,7 +465,11 @@ static int denorm_addr_common(struct addr_ctx *ctx)
 	 * Convert the original physical CS Fabric ID to a logical value.
 	 * This is required for non-power-of-two and other interleaving modes.
 	 */
-	ctx->cs_fabric_id = get_logical_cs_fabric_id(ctx);
+	if (df_cfg.rev == DF4p5 && df_cfg.flags.heterogeneous)
+		ctx->cs_fabric_id = (ctx->cs_fabric_id & df_cfg.node_id_mask) |
+				     get_logical_cs_fabric_id_mi300_die(ctx);
+	else
+		ctx->cs_fabric_id = get_logical_cs_fabric_id(ctx);
 
 	denorm_addr = make_space_for_cs_id(ctx);
 	cs_id = calculate_cs_id(ctx);
-- 
2.25.1

