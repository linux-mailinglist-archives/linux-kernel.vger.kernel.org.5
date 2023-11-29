Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6443B7FCFFE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjK2HgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjK2Hfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:35:53 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1841AD;
        Tue, 28 Nov 2023 23:35:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+D1chwr2waQQB/4gqvj0BSadp4d8PLAGoEGjRD3+nBmPnc2p8FZSAjkmSiE94hxXROWpTvRUF1FSrSBkvTIZPE1FSN5mDP2CBi5lDJKJTrtXOy6nf8zioSUfH8YmEgKjVfQmJO4+un9CsJE5u+urplMTtl+HZgwx0e/PKMkzsAEaD/9HLCGVBdNBzwEniPCZfRuBSZ1OpTf29v3IWhEJx+OafK4iHk1mhNLbOhCHvilm7sRdxkZ6kS42vqfW0onaUDeSf/4FZzzumbwsl9lisO3i37Rl8cMT4xVEeDdQ1fZATp5eVQE+hN1syvaO+Hlo0MrgjhXa9JrW3cpEeA59Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwwuCJ/th4Ym/fVFD26+MLyJv2rIe36VZBEymKaqOmo=;
 b=B1QmQpAB6AFSvBaz2wtf/miTiRpnUIVandZl1hr/gIo0icYc2D4NiWpNDg6GA/85AIvUIXIVglVzqnXWNi4XNYZox77fcqBsZZFl4ceujT8WGJqDVC4nKPYxyL3TYjOYSQ8wXDIlW0qjO1n8zkgMxSGML2Zm2qKEqmitBygQIjVIDhTcD8fwlop5etT3MdItfTPI5opTZzRb9AOWQ/oT7tGyArUfi2qzXWS23eBRHLf9RSj5r+HO5Jn8r/leenOgak1kpofRBGbvjpnzbzF8vGQTqT5Ie5c4iDE0c/JRoTfZaWJ64KNYZ8BYw28WsAibQCO2VjZP+9NOXLuOHrXOSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwwuCJ/th4Ym/fVFD26+MLyJv2rIe36VZBEymKaqOmo=;
 b=eT4YHBWwWIYG59PyMLecnVR4/xDfMxG7mLAE6k6A63lvvp1ChQ+c6wDzUlMAyY/1Jp03E2bKZjWriuG0nDl4Vz3Y+vNuWIOgdERRE2B6zHPVz/7IadEIYtKaCGRmf3NgSHrFBCheFMEQradK3BdL7RY7ssWC7qK4BZmCXbL9uGc=
Received: from SJ0PR03CA0222.namprd03.prod.outlook.com (2603:10b6:a03:39f::17)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 29 Nov
 2023 07:35:57 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::a1) by SJ0PR03CA0222.outlook.office365.com
 (2603:10b6:a03:39f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Wed, 29 Nov 2023 07:35:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 07:35:56 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 01:35:54 -0600
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH v2 6/6] RAS: EDAC/amd64: Retire all system physical address from HBM3 row
Date:   Wed, 29 Nov 2023 07:35:21 +0000
Message-ID: <20231129073521.2127403-7-muralimk@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: d3ad1ab6-cc56-49ec-f140-08dbf0add348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jL8fX1p4W3fEBZm/ep2dUnuEx50ZGCJhWwB1o1S3DO0p5yiI3GgIgPjCqC2rfYQ7iJIfmgpi93Bb6RHMKOGO+f6t6vEJ27JIRy/0D0yorKGQp16EKCJv1Y12qHgTlvwP7CNBeScDVXnrSYvKmr8+YkCrx3e9TGFfehLFSIz5MuvGbIVuhSZM30ND7/1gYDf5GzgfHONkLVGfuSTMxWLYHKusfY/RlqhfrgE9Da0sxu/ztQKKVi0recQp94gaJtBhGETXl+wgCg1xszfEJuOKUQJt+b2fnBz7LSz9bV/8iLmo3TmhDOxQ73g4eWa/sMMkZT72b4cAQyYbJka/KKjBpRoPipNR6ZYzyY/rsZflI1EiLjRk2T19cQKYXZH+vycOxrb1TpGohLa4HGgNkuv0FXydyqZgkuKCmdNjdzq9Bp9Bz/1E8cRFl2Mxyar+geqLtyKwA2B7Nv5hh7yW7n0LBslhQoBCDIc8AzuozpNn1DP4dBIz3XVyzalU53eJ70MO21qh4/vqZANXPj6kHk0OGLCMw909LEPI12Bmyos9QfdeK2WufRsopdKbLV0Xit0X2JvOL37e7VrFdTqnTCMgCutSDmamV1iL1neQ7k4MnxZQqi9ZecjBSzzaDouBE1DmzbyUWSUbqZlQLBINjVTO7nF0KTFklr+GlMRVXtutCKD/yuvC4W9UV5bfxQ5M5ExizS6lilGGu7IsadJRMT40zCHyZ0+A6e+me0YwcYDWWD0P5cjE/LDhRYQ2CE6fYxVov310pxDVXPaLzCAdXPLLpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(82310400011)(186009)(64100799003)(1800799012)(451199024)(36840700001)(46966006)(40470700004)(36756003)(41300700001)(2906002)(81166007)(356005)(47076005)(82740400003)(83380400001)(40480700001)(5660300002)(336012)(426003)(26005)(1076003)(16526019)(2616005)(36860700001)(8936002)(8676002)(4326008)(6666004)(7696005)(478600001)(40460700003)(316002)(54906003)(70586007)(70206006)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 07:35:56.6276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ad1ab6-cc56-49ec-f140-08dbf0add348
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446
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

AMD systems have HBM memory embedded within the chip, The entire memory
is managed by host OS. Error containment needs to be reliable, because
HBM memory cannot be replaced.

HBM3 memory has 8 columns in each row and column bits are c2, c3 and c4
which gives 8 possible combination of addresses in each row.

Identify all these system physical addresses in a HBM row and retire all
system physical address to get rid of intermittent or recurrent memory
errors.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
Changes:
v1 -> v2 : Rename and modify function amd_umc_retire_column_spa_from_row() 

 drivers/edac/amd64_edac.c |  3 ++
 drivers/ras/amd/atl/umc.c | 77 +++++++++++++++++++++++++++++++++++++++
 include/linux/amd-atl.h   |  2 +
 3 files changed, 82 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 623f84c53d2d..9872ede7eca9 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2831,6 +2831,9 @@ static void decode_umc_error(int node_id, struct mce *m)
 
 	error_address_to_page_and_offset(sys_addr, &err);
 
+	if (pvt->fam == 0x19 && (pvt->model >= 0x90 && pvt->model <= 0x9f))
+		amd_umc_retire_column_spa_from_row(m);
+
 log_error:
 	__log_ecc_error(mci, &err, ecc_type);
 }
diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index 3533db279cec..de51b666b20e 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -255,3 +255,80 @@ int umc_mca_addr_to_sys_addr(struct mce *m, u64 *sys_addr)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(umc_mca_addr_to_sys_addr);
+
+/*
+ * High Bandwidth Memory (HBM v3) has fixed number of columns in a row.
+ * In specific, HBMv3 has 8 columns in one row.
+ * Extract column bits in a row to find all the combination of masks and
+ * to retire all the system physical addresses in that particular row.
+ */
+#define MAX_COLUMNS_IN_HBM_ROW	8
+
+/* Column 2, 3 and 4th bits in Normalized Address */
+#define UMC_NA_C2_BIT	BIT(8)
+#define UMC_NA_C3_BIT	BIT(9)
+#define UMC_NA_C4_BIT	BIT(14)
+
+/* Possible combinations of column address masks in a HBM v3 row */
+#define C_1_1_1_MASK	(UMC_NA_C4_BIT | UMC_NA_C3_BIT | UMC_NA_C2_BIT)
+#define C_1_1_0_MASK	(UMC_NA_C4_BIT | UMC_NA_C3_BIT)
+#define C_1_0_1_MASK	(UMC_NA_C4_BIT | UMC_NA_C2_BIT)
+#define C_1_0_0_MASK	(UMC_NA_C4_BIT)
+#define C_0_1_1_MASK	(UMC_NA_C3_BIT | UMC_NA_C2_BIT)
+#define C_0_1_0_MASK	(UMC_NA_C3_BIT)
+#define C_0_0_1_MASK	(UMC_NA_C2_BIT)
+#define C_0_0_0_MASK	~C_1_1_1_MASK
+
+/* Identify system address physical addresses of all columns in a HBM v3 row */
+static void identify_column_spa_from_row(struct mce *m, u64 *col)
+{
+	u8 cs_inst_id = get_cs_inst_id(m);
+	u8 socket_id = get_socket_id(m);
+	u64 norm_addr = get_norm_addr(m);
+	u8 die_id = get_die_id(m);
+	u16 df_acc_id = get_df_acc_id(m);
+
+	u64 retire_addr, column;
+	u64 column_masks[] = { 0, C_0_0_1_MASK, C_0_1_0_MASK, C_0_1_1_MASK,
+			C_1_0_0_MASK, C_1_0_1_MASK, C_1_1_0_MASK, C_1_1_1_MASK };
+
+	/* clear and loop for all possibilities of [c4 c3 c2] */
+	norm_addr &= C_0_0_0_MASK;
+
+	for (column = 0; column < ARRAY_SIZE(column_masks); column++) {
+		retire_addr = norm_addr | column_masks[column];
+
+		if (norm_to_sys_addr(df_acc_id, socket_id, die_id, cs_inst_id, &retire_addr))
+			pr_warn("Failed norm_to_sys_addr for column[%lld]\n", column);
+		else
+			col[column] = retire_addr;
+	}
+}
+
+void amd_umc_retire_column_spa_from_row(struct mce *m)
+{
+	u64 col[MAX_COLUMNS_IN_HBM_ROW];
+	u64 tmp[MAX_COLUMNS_IN_HBM_ROW];
+	int i, j, count = 0;
+	unsigned long pfn;
+
+	pr_info("Identify SPA of all columns from row for MCE Addr:0x%llx\n", m->addr);
+	identify_column_spa_from_row(m, col);
+
+	/* Find duplicate column SPA in a row */
+	for (i = 0; i < MAX_COLUMNS_IN_HBM_ROW; i++) {
+		for (j = 0; j < count; j++) {
+			if (col[i] == tmp[j])
+				break;
+		}
+		if (j == count) {
+			tmp[count] = col[i];
+			/* do page retirement, except for duplicate addresses */
+			pr_debug("Retire column spa:0x%llx ", tmp[count]);
+			pfn = PHYS_PFN(tmp[count]);
+			memory_failure(pfn, 0);
+			count++;
+		}
+	}
+}
+EXPORT_SYMBOL(amd_umc_retire_column_spa_from_row);
diff --git a/include/linux/amd-atl.h b/include/linux/amd-atl.h
index c625ea3ab5d0..6cba39be63ca 100644
--- a/include/linux/amd-atl.h
+++ b/include/linux/amd-atl.h
@@ -25,4 +25,6 @@ static inline int amd_umc_mca_addr_to_sys_addr(struct mce *m, u64 *sys_addr)
 	return umc_mca_addr_to_sys_addr(m, sys_addr);
 }
 
+void amd_umc_retire_column_spa_from_row(struct mce *m);
+
 #endif /* _AMD_ATL_H */
-- 
2.25.1

