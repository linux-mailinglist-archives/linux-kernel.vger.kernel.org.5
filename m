Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B1F7D63BE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjJYHoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbjJYHoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:44:13 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589013AB9;
        Wed, 25 Oct 2023 00:35:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Do0jvJQPvCir+AupxNgiSRngdGrkfJb29xGdPrzwypjji4JtaAL8gAX6M9bKlMiK1wDot2QwcZhA6Fta4d75GuuxRRP7YmuHwEjU5AiaPRWpSaD5ngImNmZ4MZ+2ShaBTYMx7E8YyAGMGd2kadXTD/jNhHDZYiiHojmHUzBIbcdpfPoKf+0vE1ro5qYppZ7RM7vkA1imACQkeB0VdP11s3HHRyGyl7gDYXFmH++caUiZZnFcubj5/8XzWvDNMykpUv0A7pcqiQm5bIZiJ5nUZBu1MG1i/joslR969M+3UMDTzMcFfqURYGCZjo1FXsg4C1NwC1jVN9Fav14wOvfMEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpoFvFcZ7Ba18t8x6fW6/vyJJIZnqfA8HkwtyKMz4aI=;
 b=EmHL0q8dkDB4eKJjY31Rur8aGUZU30fWMDZAA3IOK+zlu+kl56J+eIfjAl4uhPqK84BONmq5CFBZZyRN0CC7I3IYuQJDXUWjhBcnalU/RuQRvAinilHc/pEeQf7m6HYQJaVJf1JuQwSTCM6I1lsD0NjUKX6hoavnhKOJY9/1V1UvAfedotppvctPiwyCbotGSYduEt5Y7pFPddKu9bPoqy+aaN7GhBu9CwDL8BrQP7fnHIpSpVG3pE49/MSRu/EMl/NGTBR1o8kK3VbiqQnn8Hib84tt9jp+pUGdkNCQCDQd7MAyx7mNABG+aLT55dZLZgcQT6q0p0XD6nrTwuIz4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpoFvFcZ7Ba18t8x6fW6/vyJJIZnqfA8HkwtyKMz4aI=;
 b=kfkuV2TtO7ZRmvnFVQhl/HzX6CW1X5fHD5hOtX2rVZoKpEwnwaTx0qKpN+Y2ZvsscYdy1DZ352SKmlUHXdsY22A17dqUGBktw9sFqGAnV2iMRbO/gMcdIjAc6lEsJk8MZWonzW3NKbAAbv9vKa6V8+eXMmZjRh9sSY0oagUt0Pw=
Received: from SJ0PR03CA0103.namprd03.prod.outlook.com (2603:10b6:a03:333::18)
 by MW4PR12MB7192.namprd12.prod.outlook.com (2603:10b6:303:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 07:35:23 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::db) by SJ0PR03CA0103.outlook.office365.com
 (2603:10b6:a03:333::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 07:35:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 07:35:22 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 25 Oct
 2023 02:35:20 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH 5/7] RAS: Add fixed Physical to logical CS ID mapping table
Date:   Wed, 25 Oct 2023 07:33:37 +0000
Message-ID: <20231025073339.630093-6-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231025073339.630093-1-muralimk@amd.com>
References: <20231025073339.630093-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|MW4PR12MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: de40815e-2f11-484d-ef59-08dbd52cf2c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4WQWerrufzWdGSmvgsXHqFeAfesn2l+sCJDgiMCv2hC3F5pV95dRoxlidNIlwbFXm9aRmTfmawxvkVJ+2O1oNbjI3plmeeP/JcfVv/DFPzac7v10iFipt5yaUhNlIW3TO/jXUPfD811+z02wZ1MqGpSdMnX+FCuiC83SbB8da4c0L7L34tXyJ4uOWP7YZ1Dd+DCE0Dy173A+QD14XrpfSfIYljX6f779Ta3ngjSPJPu3VwdysyLrg0NqZFLtDecnonaEyRaA0mqeiZ0nE9DA0z8QgBi6UKT+jdSrhkIvCDFfKqzG8DC4lqHuephlKbWGE+iA+sZ0lwXMrPNDvEZnEOVjOcunyn1Dv4gQ0TNsqukIka5lQ+3Wp37NgpJiMcVp+3Xjvdvzpx+zvuo8ISERAtziFe/cQvnCIRQSLUdhI5YlbUqJJd8d8elUakePA5nv1tqdQwQxzU7d9fWCdmblsIRj81P6ptzExrJqXTIXA71mvoWSh6pvPqLPMYVPMDcLMSjqlpPFgYybRWlOwJO0ax2jjg8fD7ElGAiecKPHT2PL9C01ELlJsXBFSgKPP5oZH8VKORKfQJNSP9W/QCYrIPHKBe1eGjK+gx/4SLojQcDuQCx5z9GLHW2gXJ8NHOnlKkg1A2iwJjB8zJSFrXTL2smmvJKj0vLPGXHrsasrXgb5BUQocWVi9cxw9YF1Fl030BuKjHURGTRg4sJPlBprA1YJkrJIXCCIz9/pfhX55izn/xS5STdEPcX8Dv0Eq7Gu+h2ebzhzhyT1W7f3/lwPaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(36840700001)(40470700004)(46966006)(83380400001)(40460700003)(8936002)(40480700001)(5660300002)(70586007)(110136005)(70206006)(41300700001)(478600001)(7696005)(54906003)(316002)(6666004)(36756003)(8676002)(4326008)(81166007)(2906002)(426003)(356005)(16526019)(2616005)(1076003)(336012)(26005)(82740400003)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 07:35:22.9855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de40815e-2f11-484d-ef59-08dbd52cf2c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7192
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

