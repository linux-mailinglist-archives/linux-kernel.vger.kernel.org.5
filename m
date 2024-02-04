Return-Path: <linux-kernel+bounces-51761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AAC848F04
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59611C21E50
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F171225DE;
	Sun,  4 Feb 2024 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SmAPnwwO"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4965D2261F;
	Sun,  4 Feb 2024 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707061885; cv=fail; b=ho0ZUn+bgai9oLepKR91ADwQIiaTL7WZRWCYYy6sh15UNXuQWhKQEmadT73ZEYBnqW48oOTF4XvXmPrg0C71dUutUY+lKRtG9UX6n0D7Lw9xebs2dyVWh6T0DOjOjiMDK/BYke7P9I3UvF+qG9Andt8w9Ez4Ni42T6a6opCT2NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707061885; c=relaxed/simple;
	bh=IZ2yY35WRSrVl1vUswGDAQNqmhV88hYmwJYVfBW96oU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QSU8j5EsOqaAYEiUDwGPCraZL0TVzzlBOs7OwgCS01omoLpsIlxXG8fG1Lcy+5HYHCzgbvg4n0YZqFXKqXY6fL+2Pv6FDMwGLoGi+4ib10EqDy0zoMzDJeIfcXAEBbwv6aR2pFooeFp5yYhA2n6A0BqC6MTNevMmNBCvrJQ9SFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SmAPnwwO; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFeuBjGREQ0hmxMK9h04VEWakwyU7HQGR4EHCZy37f9Ti7roqR5Yw/9MCEY04ihwU/txbz8Sqs23m3yuDfq2bgDRPMXEfRstYjjivhsqyu/MCtmvcSxFVcWqKNuP2PZlU43E8a3lX1tjpkyN7dpqbtIZfirTHJg9Slrv8MndT1kZXKbJ3ZkJhvcZS62DBKYUJRwJ2q533zeGQCxm1D68PZT3leK3lTuDfpzaXjYyhNtoYXSYDK+eO24VkFdrChz7+vT7cGpysbGE8orc+hxYD2G5ZxZqgV8+8G2KaEsBZPXgz6VgyQ3y5TwvaOMFe8Rhk3LkLBk3gmZ6lAMATp3Olg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJeBZdPKE378NT5tKJwNsRb91vNjRTz+TSqgUExmYEs=;
 b=STPks0FFUTo9pFizl+DEMQ4apfJmv17ev9b1b7V9IKkzgvRVu1r+6PJYL78YRpOP/d1nHw1dj3QBMPEp4MsNWZY9jNKzIMCtIeuA6fp9H4WWjnE+AO1cDyXUR34ieFc2hdtboBrWrfpl05utv3zX/cN7KFU34SHDDRSjdy4nSQH+DW+C1zpVsC8TehM4+5p6Jd8mYD8fPecfl9akm5wf1CEIdoKj3JfdPiDQRan4fW7C9OQKuEXn57QHYVv+Q1fyqciDsToQUrQe6axFpJr/hI8sMVSgt2ajRiIYMJZiDNMdtVfL6ngPyajRg4hZnGl2azeD4wHuDxXS+0tM4FG2Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJeBZdPKE378NT5tKJwNsRb91vNjRTz+TSqgUExmYEs=;
 b=SmAPnwwO7WE/uRWzUqnSlbtewlpHn+dodkMMqmzaAc9dMeyzf5ID1sIzfdYaPSfjj8r4L0qNDxiLFgRVlySu5MkhN2HJurpP28iTDM7zHj6nU14voGxUuL6m2MpP/UStyK3oqEM3ArjWJYAJT6ssBvcUt/CF7UqgFyDGcnjUMeY=
Received: from SJ0PR13CA0058.namprd13.prod.outlook.com (2603:10b6:a03:2c2::33)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Sun, 4 Feb
 2024 15:51:17 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::ca) by SJ0PR13CA0058.outlook.office365.com
 (2603:10b6:a03:2c2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Sun, 4 Feb 2024 15:51:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Sun, 4 Feb 2024 15:51:16 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 4 Feb
 2024 09:51:15 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<john.allen@amd.com>, <muralidhara.mk@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH] EDAC/amd64: Add MI300 row retirement support
Date: Sun, 4 Feb 2024 09:51:06 -0600
Message-ID: <20240204155106.3110934-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|SJ2PR12MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: 56318c19-ce1b-410a-a7d0-08dc25991fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UhLlwWQccHF3UWHl5rHoFjJ6LSoAgmtU5mhQpUi7AHNv7E3PFQVv/dfiePMV2TdtYSsvnRqeVmMhpXElQC3ZkMbUyiUXHWLCfsX6sxftmmQpuQbi0WFm4E0xJnBL6RMClNbNJXL/1Yb/4IOfVuVaauJYyY+qi6YYxFrF9rhlTML1aygkQ3rak+/H+Y5xTh1J/qGu+Jvaa3QrK6lopFFqjjVlpiMBz8Smd8QGp5HoLz9gtwCOFDKX2vrvuLcIs0Mh77YDbIau2GjtaUzJ/BhULwUuUbM00+MIIC9L9TGA3E+ZdCDIXNJk90Jjhp8Bct28nPNvXVnGp1gLCYuxKuwmIO5MuB3tQ2pVWJWnaLA/NGiDP0NqBGKWMJ0RZ4asrVQz3k+McBoj5dgcLAlvtQWfp+lxQEFDgyKg2n2jIr9dJEputIHYVF65uinpncLK/qUJReWeVUsBm5L6S6+xn2YW66JBzN6sK+5SCPDS5kSnkU1osz4NOgICPzDcJbthdhKjim6re+QWUfv7zEsPXed/ci3xbBvTDqxkYcU0xlsqeuJCGWoGmhxZBJGYTN88Abhrh5dF7q0IiRL2yAGLGUykQ18dmHnIZV5X0iSe/9EAzdV6+RPWukfLUhVlPivUKDZ1NOOE+6ER2TDf1eqSEKwjoX5vyx9VRGOvHiPDKFqi5K1hVL3DAuqgDYlGGqzaHcXCNwvJC/6o0NKmnERgBdjGoIs2re3eJUK5bXqMT7HoRlSb66A+54zYuUasS0vGmn+WJEBvgKsa3Tpw3FOhv+EEDa9KSzXT7jJqwbq2AkOBaWs=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(64100799003)(1800799012)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(36756003)(478600001)(86362001)(356005)(336012)(1076003)(83380400001)(82740400003)(966005)(47076005)(16526019)(26005)(426003)(2616005)(41300700001)(70206006)(4326008)(70586007)(54906003)(5660300002)(7696005)(81166007)(6666004)(44832011)(36860700001)(110136005)(316002)(8936002)(8676002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2024 15:51:16.9772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56318c19-ce1b-410a-a7d0-08dc25991fab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689

AMD MI300 systems have on-die High Bandwidth Memory. This memory has a
relatively higher error rate, and it is not individually replaceable
like DIMMs.

Uncorrectable ECC errors are individually reported as Deferred errors
using the AMD Deferred error interrupt. Each reported error corresponds
to a single hardware error.

Correctable ECC errors may reported in batches through MCA Thresholding.
Users can configure the threshold limit based on their policy. Each
reported Correctable error represents a single occurrence of the
threshold limit being reached.

The current guidance from AMD designers is that memory affected by ECC
errors within a DRAM row should be retired. Action should be taken on
every reported ECC error.

Add a helper function to apply this policy for MI300 systems.

This and similar functionality may be best handled in a separate,
generic module. In the meantime, do this in AMD64 EDAC for simplicity.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Notes:

This is a complete rewrite of the following patch:
https://lore.kernel.org/r/20231129073521.2127403-7-muralimk@amd.com

I'd like to include Murali as co-developer, since this is based on his
work.

The remaining MI300 RAS work will be focused on saving and restoring bad
memory information across reboots. The latest set on the mailing list is
here:
https://lore.kernel.org/r/20231129075034.2159223-1-muralimk@amd.com

 drivers/edac/Kconfig      |  1 +
 drivers/edac/amd64_edac.c | 48 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 16c8de5050e5..8b147403c955 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -78,6 +78,7 @@ config EDAC_GHES
 config EDAC_AMD64
 	tristate "AMD64 (Opteron, Athlon64)"
 	depends on AMD_NB && EDAC_DECODE_MCE
+	depends on MEMORY_FAILURE
 	imply AMD_ATL
 	help
 	  Support for error detection and correction of DRAM ECC errors on
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index ca9a8641652d..ee2f3ff15ab7 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2795,6 +2795,51 @@ static void umc_get_err_info(struct mce *m, struct err_info *err)
 	err->csrow = m->synd & 0x7;
 }
 
+/*
+ * When a DRAM ECC error occurs on MI300 systems, it is recommended to retire
+ * all memory within that DRAM row. This applies to the memory with a DRAM
+ * bank.
+ *
+ * To find the memory addresses, loop through permutations of the DRAM column
+ * bits and find the System Physical address of each. The column bits are used
+ * to calculate the intermediate Normalized address, so all permutations should
+ * be checked.
+ *
+ * See amd_atl::convert_dram_to_norm_addr_mi300() for MI300 address formats.
+ */
+#define MI300_UMC_MCA_COL	GENMASK(5, 1)
+#define MI300_NUM_COL		BIT(HWEIGHT(MI300_UMC_MCA_COL))
+static void retire_row_mi300(struct atl_err *a_err)
+{
+	unsigned long addr;
+	struct page *p;
+	u8 col;
+
+	for (col = 0; col < MI300_NUM_COL; col++) {
+		a_err->addr &= ~MI300_UMC_MCA_COL;
+		a_err->addr |= FIELD_PREP(MI300_UMC_MCA_COL, col);
+
+		addr = amd_convert_umc_mca_addr_to_sys_addr(a_err);
+		if (IS_ERR_VALUE(addr))
+			continue;
+
+		addr = PHYS_PFN(addr);
+
+		/*
+		 * Skip invalid or already poisoned pages to avoid unnecessary
+		 * error messages from memory_failure().
+		 */
+		p = pfn_to_online_page(addr);
+		if (!p)
+			continue;
+
+		if (PageHWPoison(p))
+			continue;
+
+		memory_failure(addr, 0);
+	}
+}
+
 static void decode_umc_error(int node_id, struct mce *m)
 {
 	u8 ecc_type = (m->status >> 45) & 0x3;
@@ -2845,6 +2890,9 @@ static void decode_umc_error(int node_id, struct mce *m)
 
 	error_address_to_page_and_offset(sys_addr, &err);
 
+	if (pvt->fam == 0x19 && pvt->dram_type == MEM_HBM3)
+		retire_row_mi300(&a_err);
+
 log_error:
 	__log_ecc_error(mci, &err, ecc_type);
 }
-- 
2.34.1


