Return-Path: <linux-kernel+bounces-64709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738B48541CA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D10D1C232ED
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 03:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B04B666;
	Wed, 14 Feb 2024 03:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1qnibZ6Z"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC075945A;
	Wed, 14 Feb 2024 03:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707881734; cv=fail; b=rf3goDawFognFr0ZKOHurfc7OIlJWySpA83OcpZKxgPkGDh7mwDTNFXUF7up+nA6EzSLy6DTXwZ1nwzGLugsjlOW6g0gRYSRCWctwVzwWth+NJaITGbyXfiyr1KQoYwjDYy5YHqGYfe/L+l6D08tMIK2pFH1MC+6f7Ss1CUmPqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707881734; c=relaxed/simple;
	bh=Cpi0eCfGDWwKyGH60UTituQHta3MTs2CyE01xy+ceFE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYx0B4CtkVcDybhmRkJDNZqfTv7IQEYFIfhMd/tBvsiTsYY4b+Wv1xt17PlXtL6aEWy53OGz3pJ0WeKvzS1bkN1R1Z/Ik7YZ9vHh3gTD8vbObmyPX3LL/C08GP0iCYUQHTfMs/BLVw7MGC4PrLJJpX0+SxAVbtv9hVDTFYy4uCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1qnibZ6Z; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lICBWvOECGcUEbIpQRCfdGudCM4s6+ygcu7G8He710+jd/WEPO0ADTSNxOiz6gSZzR1XFhaR0CdPW3uSuUgb0JsplVSUd2Yq6gne2nsmUmFiBoYc0uNLSGE8b9TzgxiTbzXoG7xnSK9ug1XwP0+85F/viJnGVx+AosZU/WkOZIOkFkfHAwGwjfMdVQ0G/uxY+b0HKjzCxvbAleJdOyak/UvKzyTNdZ+GLl0p73Fbj0IjkcHMurBfhctJ8nlYt7c7q0Ubm0edEpn4TPwIouIG3ppIiYkuwd3tm1d9CiUpPzn5jUzlkO0Lm2s4B1CNI+LgPCKcWaydHb64jlmAD136uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/V9qXthCZLwHnNIJ3EDtMWR1WEfu1QkFnKKujxJ5uYU=;
 b=lmi+wUl2s/DJDLNvplqX/N6bPtcEl4HWkzh6SEodDfKyvDMK+XGrpktmU42SrkzGEGotwg6t8ow5zaIPEo9Ujz0nOiwYCq9IOmxtfxFM6SfbluzRH/pS43avoZpAIju3pLoQDRGNVsMcD8eG0hRG8Do2hx8oe+M88Ljfblb42hwSr4p9cpTiv9wSLqc+hl0jMZbGLWEHwiRGqB8VdilOYr8LXjtNP1z5dgSdeSGNSDWn0knw366aV19XdSOOtqNrqMP8oDh9AmIxKRwpHOmpNQhIpvhY5VTsIWG4YofWvrOS3DrwS8o0itxSI+DletkT29hNRqcw3zRxUM3DF0h3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/V9qXthCZLwHnNIJ3EDtMWR1WEfu1QkFnKKujxJ5uYU=;
 b=1qnibZ6ZoGExHKcb6LjSzPAvTaYA1UWwTUCrFvmT0yT3/aJ+pjlcXrs0w139NrG6vA7a4UE2wm8A7Iq9tTZ9SQixC2v8NiVN7putIjbP5Ni1ZPKxswOW+2Ib24SJQomgjTI+JB+oZnWCH+eoZVwMzaSNkirKgVOF6H8IYflWgjk=
Received: from BN9PR03CA0594.namprd03.prod.outlook.com (2603:10b6:408:10d::29)
 by SA3PR12MB9179.namprd12.prod.outlook.com (2603:10b6:806:3a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.21; Wed, 14 Feb
 2024 03:35:30 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::20) by BN9PR03CA0594.outlook.office365.com
 (2603:10b6:408:10d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Wed, 14 Feb 2024 03:35:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 03:35:30 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 21:35:27 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<john.allen@amd.com>, <muralidhara.mk@amd.com>,
	<naveenkrishna.chatradhi@amd.com>, <sathyapriya.k@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH 1/2] RAS/AMD/ATL, EDAC/amd64: Move MI300 Row Retirement to ATL
Date: Tue, 13 Feb 2024 21:35:15 -0600
Message-ID: <20240214033516.1344948-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214033516.1344948-1-yazen.ghannam@amd.com>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|SA3PR12MB9179:EE_
X-MS-Office365-Filtering-Correlation-Id: e9958659-9740-423f-9d49-08dc2d0dfe18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uaqV9xwJ9KoaiCMqAz9wBJEc1dm67y4T+UGvqyxlkqn+WuODTa4jPLFbdglx5ipq7M9pkDRNmsVz90W+roEGlpzKuny3qtiegc8MdABb+xdZpmsRH7k4FyzCBThyxVcSMsdvP9cDwlUDXt7x5KqOD2I6qivpcEyYwjZHaNlFMn6D2jD3yMnuxRwNB74APHAJJEqogRu1yQaaPqHaM9HDDzMPBISZsIOk/bWvKrd5uAcvsO8jB2fdEl37cs3LeKehIj6KgPy/hEnzfifTy04mvJ7eqp3I/+YxA/pjDQGlQffJ0WNXIrCY7X/YEi/vVXdbtJPHRyqlSopWvyifcF21VrF7aV75L29Hpkx1ntwK/TVBwBg3phzR9QcxNRaJI91sN/MypaKlAHwPJxyP0vOcUq+CmaZzzkE1H3rfc8qA2nw6bpYsdL9p4IXUWTZ855hYTOE1DyKaHNAaBHf810NCdB83QSVu1M/2flv3zDOTBQBxi/fBtSnYgo1VN2Hm8xd1owbJTKNU2ANdpTKfdOLb0ZBmc+MxulUUrPNiXyh4ow3qxV5zlxx8mTer1GUGreWod3bmtswuTexr4nnG4q4Q/xEBXGBIeP+q+ExTHoYeEWQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(82310400011)(451199024)(1800799012)(64100799003)(186009)(36840700001)(46966006)(40470700004)(7696005)(36756003)(44832011)(2906002)(70206006)(86362001)(54906003)(81166007)(336012)(8676002)(5660300002)(356005)(426003)(478600001)(82740400003)(70586007)(110136005)(6666004)(316002)(26005)(83380400001)(4326008)(1076003)(41300700001)(8936002)(2616005)(16526019);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 03:35:30.0149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9958659-9740-423f-9d49-08dc2d0dfe18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9179

DRAM row retirement depends on model-specific information that is best
done within the AMD Address Translation Library.

Export a generic wrapper function for other modules to use. Add any
model-specific helpers here.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/Kconfig        |  1 -
 drivers/edac/amd64_edac.c   | 48 ----------------------------------
 drivers/ras/amd/atl/Kconfig |  1 +
 drivers/ras/amd/atl/umc.c   | 51 +++++++++++++++++++++++++++++++++++++
 include/linux/ras.h         |  2 ++
 5 files changed, 54 insertions(+), 49 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 8b147403c955..16c8de5050e5 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -78,7 +78,6 @@ config EDAC_GHES
 config EDAC_AMD64
 	tristate "AMD64 (Opteron, Athlon64)"
 	depends on AMD_NB && EDAC_DECODE_MCE
-	depends on MEMORY_FAILURE
 	imply AMD_ATL
 	help
 	  Support for error detection and correction of DRAM ECC errors on
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index ee2f3ff15ab7..ca9a8641652d 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2795,51 +2795,6 @@ static void umc_get_err_info(struct mce *m, struct err_info *err)
 	err->csrow = m->synd & 0x7;
 }
 
-/*
- * When a DRAM ECC error occurs on MI300 systems, it is recommended to retire
- * all memory within that DRAM row. This applies to the memory with a DRAM
- * bank.
- *
- * To find the memory addresses, loop through permutations of the DRAM column
- * bits and find the System Physical address of each. The column bits are used
- * to calculate the intermediate Normalized address, so all permutations should
- * be checked.
- *
- * See amd_atl::convert_dram_to_norm_addr_mi300() for MI300 address formats.
- */
-#define MI300_UMC_MCA_COL	GENMASK(5, 1)
-#define MI300_NUM_COL		BIT(HWEIGHT(MI300_UMC_MCA_COL))
-static void retire_row_mi300(struct atl_err *a_err)
-{
-	unsigned long addr;
-	struct page *p;
-	u8 col;
-
-	for (col = 0; col < MI300_NUM_COL; col++) {
-		a_err->addr &= ~MI300_UMC_MCA_COL;
-		a_err->addr |= FIELD_PREP(MI300_UMC_MCA_COL, col);
-
-		addr = amd_convert_umc_mca_addr_to_sys_addr(a_err);
-		if (IS_ERR_VALUE(addr))
-			continue;
-
-		addr = PHYS_PFN(addr);
-
-		/*
-		 * Skip invalid or already poisoned pages to avoid unnecessary
-		 * error messages from memory_failure().
-		 */
-		p = pfn_to_online_page(addr);
-		if (!p)
-			continue;
-
-		if (PageHWPoison(p))
-			continue;
-
-		memory_failure(addr, 0);
-	}
-}
-
 static void decode_umc_error(int node_id, struct mce *m)
 {
 	u8 ecc_type = (m->status >> 45) & 0x3;
@@ -2890,9 +2845,6 @@ static void decode_umc_error(int node_id, struct mce *m)
 
 	error_address_to_page_and_offset(sys_addr, &err);
 
-	if (pvt->fam == 0x19 && pvt->dram_type == MEM_HBM3)
-		retire_row_mi300(&a_err);
-
 log_error:
 	__log_ecc_error(mci, &err, ecc_type);
 }
diff --git a/drivers/ras/amd/atl/Kconfig b/drivers/ras/amd/atl/Kconfig
index a43513a700f1..df49c23e7f62 100644
--- a/drivers/ras/amd/atl/Kconfig
+++ b/drivers/ras/amd/atl/Kconfig
@@ -10,6 +10,7 @@
 config AMD_ATL
 	tristate "AMD Address Translation Library"
 	depends on AMD_NB && X86_64 && RAS
+	depends on MEMORY_FAILURE
 	default N
 	help
 	  This library includes support for implementation-specific
diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index 7e310d1dfcfc..08c6dbd44c62 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -239,6 +239,57 @@ static unsigned long convert_dram_to_norm_addr_mi300(unsigned long addr)
 	return addr;
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
+void amd_retire_dram_row(struct atl_err *a_err)
+{
+	if (df_cfg.rev == DF4p5 && df_cfg.flags.heterogeneous)
+		return retire_row_mi300(a_err);
+}
+EXPORT_SYMBOL_GPL(amd_retire_dram_row);
+
 static unsigned long get_addr(unsigned long addr)
 {
 	if (df_cfg.rev == DF4p5 && df_cfg.flags.heterogeneous)
diff --git a/include/linux/ras.h b/include/linux/ras.h
index 09c632832bf1..a64182bc72ad 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -45,8 +45,10 @@ struct atl_err {
 #if IS_ENABLED(CONFIG_AMD_ATL)
 void amd_atl_register_decoder(unsigned long (*f)(struct atl_err *));
 void amd_atl_unregister_decoder(void);
+void amd_retire_dram_row(struct atl_err *err);
 unsigned long amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
 #else
+static inline void amd_retire_dram_row(struct atl_err *err) { }
 static inline unsigned long
 amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err) { return -EINVAL; }
 #endif /* CONFIG_AMD_ATL */
-- 
2.34.1


