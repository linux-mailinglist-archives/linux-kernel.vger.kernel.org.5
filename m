Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609637D638D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjJYHiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjJYHhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:37:33 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B9E19B5;
        Wed, 25 Oct 2023 00:35:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9s0NAXkCh117UAXTm44w4ehhmSqIkKLtTdFkY8X2Tom+XG5WFeNOSyycyMxNZ9BWiqfYKSuxWQA+oQL4CS3rtPQlEq8DRIDPYLizwhhuCLXUM90VWncmCqMdGHcvIpDHkFso2Ye11AbucmLC1aSryGskHURwmJ6R8IOVPRX1EmOF5TzgAwdhFZu4eKicGvNvgiSMBYmaMbH8Ypaxfxudj4QN7x6xim7LUEcqZ671P30OCoC70+yebwT1aNRlgE0ayotYc3be9oEN/rvmSfNZdUPvUrIyFH01LRN+pe3p3QqhgiKSS8ZYeQKg10Is29g0AuTCxLur/IME/u7p9gAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyYjYPuqEyptSuSvmwm9hwLqcrOhvOuUUJ9kDFyKlKQ=;
 b=NlJnDXIFSx1W1/qNDmEltTdu+8Lv8P2xU+ND8tq0kGSmyZavvo/ylPOK538x8Kd1JPQSe0vPx9q9NBkdjIW0pUrr74QiHM/Zv72e4rmOJWm5V4yMuoF98hY1jPLwZpIU6okv6iUDvwVnl5giVqJDrap9kBY3jEhp4PGih1MMrStlB+51BqK+86QU1AZKOc+slYmycvMumqbNu/4tIQ8tqwnCIYe6c7el6kHsO5dOvxUscbhatYqTCqTxum6ePBIsmVsMFk9xnONPzhZ7RWtLNDj53SDXAJHYaGIp8HqowV3nFi1zvFSms4rVNOrgefzwJ97GUmQpwt24kziJ0ObDxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyYjYPuqEyptSuSvmwm9hwLqcrOhvOuUUJ9kDFyKlKQ=;
 b=jlQM8ZBjZO2ulrUq+kEmY3r1qE+WjVT3MxHZ89s+x6CUYL5mNodg+xNuqGVubdX+Pj6it3N32zvKj+9VDIibidEL38ynoT+VpPmJlE1m+FR4nr61ZsyMh7Xppimb7diFaEt5y3XEKMlKGY+d57e8nzevJHzUI7+BqfR94DicayY=
Received: from SJ0PR03CA0221.namprd03.prod.outlook.com (2603:10b6:a03:39f::16)
 by DM6PR12MB4514.namprd12.prod.outlook.com (2603:10b6:5:2a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 07:35:28 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::54) by SJ0PR03CA0221.outlook.office365.com
 (2603:10b6:a03:39f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.35 via Frontend
 Transport; Wed, 25 Oct 2023 07:35:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 07:35:27 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 25 Oct
 2023 02:35:25 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH 7/7] EDAC/amd64: RAS: platform/x86/amd: Identify all physical pages in row
Date:   Wed, 25 Oct 2023 07:33:39 +0000
Message-ID: <20231025073339.630093-8-muralimk@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|DM6PR12MB4514:EE_
X-MS-Office365-Filtering-Correlation-Id: 588e2164-369d-491c-93a2-08dbd52cf591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TEyud1PVUIzKFQMr8MeURiWCaUY5u1n6A8bTL2oA950RSL4G2aoDkHkHoCickSQfNL+CP0YXyaEDD7otuytzeHwQllj63rj7AOeXaNreRQ2sI/I5I/Awow5/lYhYIx/GLXwQZcKWLPn1kLQwbBK7S5rGBc2DXCPsMvXypL83+O6TXaDfH81VDAOFHujOdsN6mQvJQhTUPCBKLfuf3kNypYRl4cp3I2cn1q2ecQ+UVtwDHTmBkEBG9IIVpXn0wed8KgogsLJYtb/8t+lRCj9uaZw5gVkjPNzoY+vQA3TslU1YLI2OwM5Rclr4GC6cxLO0x+8jsMNgvDlPtIV6wWJcQW2rDiGzGMnRc0VCrYad5hCoIvt1OLtQttaK9nleVKNB7OYPqoaQIK7nKk7NknDLgxOnxcOtq3XFjHbcszgydUh6jJyXSHMCvnMbIeWLl4jST3NVlTB5PSdOVXLls5wLBn9AAzpTpXt2mnQHUprC448sirKWkFmJymdjAWP+6WVKyom5Gk8N6TiFeko7fkY6Ohwyjho6TWVCVdhuEgadc+XRz1lLCKBwvD0HiCPKvM877vBxQxZoc2SNf0UsdelgXS1cPZ1nYG8n85WjsXvyecMk9ccrRn8uHpLLVRjGdhVwSeOvVlt0yGXSHmgnwpj7uBMGgcK/5alyIsutBbNmVifdgHGmZJuldv2d9A7k95l76sHcPvN6q8wesMpj/RoDBGiQeqTNxQWU0yOefT57Rrgesu5ho170yqnOBuu3u3vAqfzDd97Jx5wa83FMAhUqTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(82310400011)(1800799009)(64100799003)(186009)(451199024)(46966006)(40470700004)(36840700001)(4326008)(8676002)(83380400001)(8936002)(2906002)(81166007)(356005)(82740400003)(5660300002)(41300700001)(7696005)(6666004)(40480700001)(316002)(110136005)(336012)(426003)(1076003)(26005)(478600001)(16526019)(2616005)(47076005)(36756003)(54906003)(70206006)(70586007)(40460700003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 07:35:27.6886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 588e2164-369d-491c-93a2-08dbd52cf591
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4514
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

AMD systems have HBM memory embedded with the chips, The entire memory
is managed by host OS. Error containment needs to be reliable, because
HBM memory cannot be replaced.

Persist all UMC DRAM ECC errors, the OS can make the bad or poisoned page
state persistent so that it will not use the memory upon the next boot.

The reported MCA error address in HBM in the format PC/SID/Bank/ROW/COL
For example, In MI300A C1/C0 (column bits 1-0) is at SPA bit 6-5. Assuming
PFN only looks at SPA bit 12 or higher, column bits 1-0 could be skipped.
For PFN, SPA bits higher or equal than 12 matters. So column bits c2, c3
and c4 gives 8 possible combination of addresses in a row.

So, Identify all physical pages in a HBM row and retire all the pages
to get rid of intermittent or recurrent memory errors.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
 drivers/edac/amd64_edac.c |   5 ++
 drivers/ras/amd/atl/umc.c | 103 ++++++++++++++++++++++++++++++++++++++
 include/linux/amd-atl.h   |   2 +
 3 files changed, 110 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 79c6c552ee14..d0db11e19a46 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2838,6 +2838,11 @@ static void decode_umc_error(int node_id, struct mce *m)
 
 	error_address_to_page_and_offset(sys_addr, &err);
 
+	if (pvt->fam == 0x19 && (pvt->model >= 0x90 && pvt->model <= 0x9f)) {
+		if (identify_poison_pages_retire_row(m))
+			return;
+	}
+
 log_error:
 	__log_ecc_error(mci, &err, ecc_type);
 }
diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index 52247a7949fb..d31ad7680ff1 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -255,3 +255,106 @@ int umc_mca_addr_to_sys_addr(struct mce *m, u64 *sys_addr)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(umc_mca_addr_to_sys_addr);
+
+/*
+ * High Bandwidth Memory (HBM v3) has fixed number of columns in a
+ * row (8 columns in one HBM row).
+ * Extract column bits to find all the combination of masks to retire
+ * all the poison pages in a row.
+ */
+#define MAX_COLUMNS_IN_HBM_ROW	8
+
+/* The C2 bit in CH NA address */
+#define UMC_NA_C2_BIT	BIT(8)
+/* The C3 bit in CH NA address */
+#define UMC_NA_C3_BIT	BIT(9)
+/* The C4 bit in CH NA address */
+#define UMC_NA_C4_BIT	BIT(14)
+
+/* masks to get all possible combinations of column addresses */
+#define C_1_1_1_MASK	(UMC_NA_C4_BIT | UMC_NA_C3_BIT | UMC_NA_C2_BIT)
+#define C_1_1_0_MASK	(UMC_NA_C4_BIT | UMC_NA_C3_BIT)
+#define C_1_0_1_MASK	(UMC_NA_C4_BIT | UMC_NA_C2_BIT)
+#define C_1_0_0_MASK	(UMC_NA_C4_BIT)
+#define C_0_1_1_MASK	(UMC_NA_C3_BIT | UMC_NA_C2_BIT)
+#define C_0_1_0_MASK	(UMC_NA_C3_BIT)
+#define C_0_0_1_MASK	(UMC_NA_C2_BIT)
+#define C_0_0_0_MASK	~C_1_1_1_MASK
+
+/* Identify all combination of column address physical pages in a row */
+static int amd_umc_identify_pages_in_row(struct mce *m, u64 *spa_addr)
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
+			return -EINVAL;
+		*(spa_addr + column) = retire_addr;
+	}
+
+	return 0;
+}
+
+/* Find any duplicate addresses in all combination of column address */
+static void amd_umc_find_duplicate_spa(u64 arr[], int *size)
+{
+	int i, j, k;
+
+	/* use nested for loop to find the duplicate elements in array */
+	for (i = 0; i < *size; i++) {
+		for (j = i + 1; j < *size; j++) {
+			/* check duplicate element */
+			if (arr[i] == arr[j]) {
+				/* delete the current position of the duplicate element */
+				for (k = j; k < (*size - 1); k++)
+					arr[k] = arr[k + 1];
+
+			/* decrease the size of array after removing duplicate element */
+				(*size)--;
+
+			/* if the position of the elements is changes, don't increase index j */
+				j--;
+			}
+		}
+	}
+}
+
+int identify_poison_pages_retire_row(struct mce *m)
+{
+	int i, ret, addr_range;
+	unsigned long pfn;
+	u64 col[MAX_COLUMNS_IN_HBM_ROW];
+	u64 *spa_addr = col;
+
+	/* Identify all pages in a row */
+	pr_info("Identify all physical Pages in a row for MCE addr:0x%llx\n", m->addr);
+	ret = amd_umc_identify_pages_in_row(m, spa_addr);
+	if (!ret) {
+		for (i = 0; i < MAX_COLUMNS_IN_HBM_ROW; i++)
+			pr_info("col[%d]_addr:0x%llx ", i, spa_addr[i]);
+	}
+	/* Find duplicate entries from all 8 physical addresses in a row */
+	addr_range = ARRAY_SIZE(col);
+	amd_umc_find_duplicate_spa(spa_addr, &addr_range);
+	/* do page retirement on all system physical addresses */
+	for (i = 0; i < addr_range; i++) {
+		pfn = PHYS_PFN(spa_addr[i]);
+		memory_failure(pfn, 0);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(identify_poison_pages_retire_row);
diff --git a/include/linux/amd-atl.h b/include/linux/amd-atl.h
index c625ea3ab5d0..df24ae592c4e 100644
--- a/include/linux/amd-atl.h
+++ b/include/linux/amd-atl.h
@@ -25,4 +25,6 @@ static inline int amd_umc_mca_addr_to_sys_addr(struct mce *m, u64 *sys_addr)
 	return umc_mca_addr_to_sys_addr(m, sys_addr);
 }
 
+int identify_poison_pages_retire_row(struct mce *m);
+
 #endif /* _AMD_ATL_H */
-- 
2.25.1

