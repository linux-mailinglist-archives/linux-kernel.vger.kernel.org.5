Return-Path: <linux-kernel+bounces-63409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A10852EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC891C228CE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A027A374E0;
	Tue, 13 Feb 2024 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WXO2Oxc/"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D41E364C1;
	Tue, 13 Feb 2024 11:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822958; cv=fail; b=OQHlH2lVExueGY9Q+QVk0fcvuLajc4QX4+qUYHh10F60YFz/jOxv9CCVhidyQTJh9zBpbEDMhnIhePYkMKJ0FTJOyS1HYhy0Y0ze7cf2Ry0lywZpcOKavH4/I2TfS6PuAIM802qL/AaS20raYIFhJMULaTT/XNY49rpkGeq69zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822958; c=relaxed/simple;
	bh=OdBgv6GEJgWqm9PHWWDA1ZSXtRp4iwHLdZs+JwuMsnQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b12juSm6fFpFFmR0l9uprCbUuVJVoKsN/vdnmbfqSmvcQMiPmjTlT4IBY2r0jzDTkJOxqE01fxzjtEOq1WVertqaXFvcevu6RcwNhOheblcwysbKKW5bq42ZkB43XlOnbIsEGJ3nOm/EQnmR4ZoH76WATBxxK8Y6f48nqKA4s+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WXO2Oxc/; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfIftdIxavzV9kSYniccolUp7Y72/qnZm3huw+xQi1t5qpp53TZwSzKPQFbIUGyPFj3pkUvvTHfCKT8rxBrF72m0gW/5S5aDsiJpuNYbgWCp014l+4Dwff4/4DuhWP9BsJ+6GVKSFGi/rOqGDm8bPW6gDBcMT29yXLbUw3zfWHuhbyFjnt+FFVj5Th3E1xepQb6K2psbj/Bvce2NMYOwLqPjpRUy3EHVAcsWAOIDLNixgsHNbLe1/+iYA0PeBLxpemRadUvawiTjpFEVXxwXx6XKFMckE3sCCEqA84QlqIeRb2xgH4A6AbDy16SRPEcviv2y4Ruh7Si8g/ObXqyKqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUz2Y/hF4PQixena8vBYg9SMbkpNO+TEcdDXW+HuIrM=;
 b=Ty8dpoxUWKwzGiDUbCC1T+2Vt3UokibxccOk+GeA4/DU+OSFxKNnjimmamSG9Ch3GL5yAVF9CBrpVqMwT21JvKH3HtfVtjxPauNVGFcFBh4dVk8Oc4gheaNjEHRAhbpHaMeNBL1nf1aKm8V7Z5u7zFy8RgGMA3GCyPx04+/++aF8Ds8bmsYDLn5SpWpvnsyjzGE+h8OTGZX2fptgLfkh+av5xu7Ru4mNrNKAYm5zJiJXblEZ48PKfDWpLC7vrA6cVwaA6plS9zzt09XmMBS0LleGMLJUQnZv74LKpyYMvf50nNs043dzNwxaQE7weclQM2q+L9ah9sbbHNW6etRCAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUz2Y/hF4PQixena8vBYg9SMbkpNO+TEcdDXW+HuIrM=;
 b=WXO2Oxc/zbIiICwNvNGQXOR8Ll5ticohWeX3eg/eIkBkB/g1YdPPPuA+9pkgoXRfj3wTaVcLNwl7xQss9yQ/g/2ZT6QnOu2lv5zXO54hq0sSLcczTeMOjilnqbWxF74AjaM6hQo8/x3yojGqZh7V+2d5JoGHAcHnz0xchHJ/AVHIvRnnpWoZtc2FTh34SfAUDsQvjqUgnoASl2ZBE9B3j7DcAPxnOuSY3zfzvrh6CF/19WnaUez4Bo8Z4oQc1zl+peeQCmXXBb1BDMeFK/spomUzbEcBn2hKOStpj1wBw0Fz2WOVm9x3sPzUxs+W4UvpNnSJqIAE0jVp8Z+joz6QCQ==
Received: from CH2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:610:50::36)
 by MN2PR12MB4566.namprd12.prod.outlook.com (2603:10b6:208:26a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 11:15:51 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::36) by CH2PR16CA0026.outlook.office365.com
 (2603:10b6:610:50::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38 via Frontend
 Transport; Tue, 13 Feb 2024 11:15:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 11:15:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 13 Feb
 2024 03:15:38 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 13 Feb
 2024 03:15:37 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 13
 Feb 2024 03:15:37 -0800
From: Shravan Kumar Ramani <shravankr@nvidia.com>
To: Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "David
 Thompson" <davthompson@nvidia.com>
CC: Shravan Kumar Ramani <shravankr@nvidia.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/4] platform/mellanox: mlxbf-pmc: Replace uintN_t with kernel-style types
Date: Tue, 13 Feb 2024 06:15:25 -0500
Message-ID: <39be055af3506ce6f843d11e45d71620f2a96e26.1707808180.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1707808180.git.shravankr@nvidia.com>
References: <cover.1707808180.git.shravankr@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|MN2PR12MB4566:EE_
X-MS-Office365-Filtering-Correlation-Id: a035e7c8-e6f2-49aa-0d57-08dc2c85230a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z58thS8Fg9CN38sB5OPqULjC9kxJ+r5LyErjEXrwurScq8P9w6PsV0TJ/dprYNj+g8B1O7z+19omzjfAWDeI529IcFxPNmkVdnF5zgX1wySytYvejpNqfQf8r0nNqtrLeWhpbPxfgg8SU3gXn6oKl1xf3qS0H2DTJDHZ8Pn9NGj+4syCV9LFqyp6FgdWKr+7V1zOZ8My5MtvMEUEYiQ8VqQT9ffFUGBFGRKWITKl+TxrijGfaY5GgUHUKKWuaE/FNReaOcq9IGkGaSH68VMAmuPjspOYyhkc5ifjffjq+qJY5CO1oo9mn+hDOaKSxUIEYjhUR964QIUsVZTcSskpcuBdQtIxDbORg3p1NhCkcfA0G1byiE1e7G8UZ4QkgEh71yMLtlQxdkJORztqxW3zDLIfm3ozgcHQGGbG+ApTRsvnOMwSJQuYBNS3vvCHr1lYcY8F9Xr1hlq9i5BOOOdlqY+pjrJcHL5MZs6B9TN5PFDc8GILxLXqvF7gTIJBQF5K2CmHNQFql0nkhThv439z6W2ZFbSmKj6Sn8jXx6Ngb9+a9ZC55gFpLYWbyKg741a/HJTkntFy7uIzjTxh5bOVaEl7ilCQwDxgBl9H9OZ61hU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(186009)(82310400011)(451199024)(64100799003)(1800799012)(36840700001)(40470700004)(46966006)(83380400001)(356005)(7636003)(86362001)(478600001)(316002)(54906003)(6636002)(70206006)(426003)(70586007)(110136005)(82740400003)(2616005)(336012)(7696005)(6666004)(26005)(36756003)(4326008)(8676002)(30864003)(8936002)(41300700001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 11:15:50.8339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a035e7c8-e6f2-49aa-0d57-08dc2c85230a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4566

Use u8, u32 and u64 instead of respective uintN_t types.
Remove unnecessary newlines for function argument lists.

Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
---
 drivers/platform/mellanox/mlxbf-pmc.c | 109 +++++++++++---------------
 1 file changed, 47 insertions(+), 62 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index b1995ac268d7..86044d1b8fa5 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -149,17 +149,17 @@ struct mlxbf_pmc_block_info {
  */
 struct mlxbf_pmc_context {
 	struct platform_device *pdev;
-	uint32_t total_blocks;
-	uint32_t tile_count;
-	uint8_t llt_enable;
-	uint8_t mss_enable;
-	uint32_t group_num;
+	u32 total_blocks;
+	u32 tile_count;
+	u8 llt_enable;
+	u8 mss_enable;
+	u32 group_num;
 	struct device *hwmon_dev;
 	const char *block_name[MLXBF_PMC_MAX_BLOCKS];
 	struct mlxbf_pmc_block_info block[MLXBF_PMC_MAX_BLOCKS];
 	const struct attribute_group *groups[MLXBF_PMC_MAX_BLOCKS];
 	bool svc_sreg_support;
-	uint32_t sreg_tbl_perf;
+	u32 sreg_tbl_perf;
 	unsigned int event_set;
 };
 
@@ -865,8 +865,7 @@ static struct mlxbf_pmc_context *pmc;
 static const char *mlxbf_pmc_svc_uuid_str = "89c036b4-e7d7-11e6-8797-001aca00bfc4";
 
 /* Calls an SMC to access a performance register */
-static int mlxbf_pmc_secure_read(void __iomem *addr, uint32_t command,
-				 uint64_t *result)
+static int mlxbf_pmc_secure_read(void __iomem *addr, u32 command, u64 *result)
 {
 	struct arm_smccc_res res;
 	int status, err = 0;
@@ -892,8 +891,7 @@ static int mlxbf_pmc_secure_read(void __iomem *addr, uint32_t command,
 }
 
 /* Read from a performance counter */
-static int mlxbf_pmc_read(void __iomem *addr, uint32_t command,
-			  uint64_t *result)
+static int mlxbf_pmc_read(void __iomem *addr, u32 command, u64 *result)
 {
 	if (pmc->svc_sreg_support)
 		return mlxbf_pmc_secure_read(addr, command, result);
@@ -907,22 +905,21 @@ static int mlxbf_pmc_read(void __iomem *addr, uint32_t command,
 }
 
 /* Convenience function for 32-bit reads */
-static int mlxbf_pmc_readl(void __iomem *addr, uint32_t *result)
+static int mlxbf_pmc_readl(void __iomem *addr, u32 *result)
 {
-	uint64_t read_out;
+	u64 read_out;
 	int status;
 
 	status = mlxbf_pmc_read(addr, MLXBF_PMC_READ_REG_32, &read_out);
 	if (status)
 		return status;
-	*result = (uint32_t)read_out;
+	*result = (u32)read_out;
 
 	return 0;
 }
 
 /* Calls an SMC to access a performance register */
-static int mlxbf_pmc_secure_write(void __iomem *addr, uint32_t command,
-				  uint64_t value)
+static int mlxbf_pmc_secure_write(void __iomem *addr, u32 command, u64 value)
 {
 	struct arm_smccc_res res;
 	int status, err = 0;
@@ -945,7 +942,7 @@ static int mlxbf_pmc_secure_write(void __iomem *addr, uint32_t command,
 }
 
 /* Write to a performance counter */
-static int mlxbf_pmc_write(void __iomem *addr, int command, uint64_t value)
+static int mlxbf_pmc_write(void __iomem *addr, int command, u64 value)
 {
 	if (pmc->svc_sreg_support)
 		return mlxbf_pmc_secure_write(addr, command, value);
@@ -959,7 +956,7 @@ static int mlxbf_pmc_write(void __iomem *addr, int command, uint64_t value)
 }
 
 /* Check if the register offset is within the mapped region for the block */
-static bool mlxbf_pmc_valid_range(int blk_num, uint32_t offset)
+static bool mlxbf_pmc_valid_range(int blk_num, u32 offset)
 {
 	if ((offset >= 0) && !(offset % MLXBF_PMC_REG_SIZE) &&
 	    (offset + MLXBF_PMC_REG_SIZE <= pmc->block[blk_num].blk_size))
@@ -1082,7 +1079,7 @@ static char *mlxbf_pmc_get_event_name(const char *blk, int evt)
 /* Method to enable/disable/reset l3cache counters */
 static int mlxbf_pmc_config_l3_counters(int blk_num, bool enable, bool reset)
 {
-	uint32_t perfcnt_cfg = 0;
+	u32 perfcnt_cfg = 0;
 
 	if (enable)
 		perfcnt_cfg |= MLXBF_PMC_L3C_PERF_CNT_CFG_EN;
@@ -1095,12 +1092,9 @@ static int mlxbf_pmc_config_l3_counters(int blk_num, bool enable, bool reset)
 }
 
 /* Method to handle l3cache counter programming */
-static int mlxbf_pmc_program_l3_counter(int blk_num, uint32_t cnt_num,
-					uint32_t evt)
+static int mlxbf_pmc_program_l3_counter(int blk_num, u32 cnt_num, u32 evt)
 {
-	uint32_t perfcnt_sel_1 = 0;
-	uint32_t perfcnt_sel = 0;
-	uint32_t *wordaddr;
+	u32 perfcnt_sel_1 = 0, perfcnt_sel = 0, *wordaddr;
 	void __iomem *pmcaddr;
 	int ret;
 
@@ -1162,11 +1156,10 @@ static int mlxbf_pmc_program_l3_counter(int blk_num, uint32_t cnt_num,
 }
 
 /* Method to handle crspace counter programming */
-static int mlxbf_pmc_program_crspace_counter(int blk_num, uint32_t cnt_num,
-					     uint32_t evt)
+static int mlxbf_pmc_program_crspace_counter(int blk_num, u32 cnt_num, u32 evt)
 {
-	uint32_t word;
 	void *addr;
+	u32 word;
 	int ret;
 
 	addr = pmc->block[blk_num].mmio_base +
@@ -1187,7 +1180,7 @@ static int mlxbf_pmc_program_crspace_counter(int blk_num, uint32_t cnt_num,
 }
 
 /* Method to clear crspace counter value */
-static int mlxbf_pmc_clear_crspace_counter(int blk_num, uint32_t cnt_num)
+static int mlxbf_pmc_clear_crspace_counter(int blk_num, u32 cnt_num)
 {
 	void *addr;
 
@@ -1199,10 +1192,9 @@ static int mlxbf_pmc_clear_crspace_counter(int blk_num, uint32_t cnt_num)
 }
 
 /* Method to program a counter to monitor an event */
-static int mlxbf_pmc_program_counter(int blk_num, uint32_t cnt_num,
-				     uint32_t evt, bool is_l3)
+static int mlxbf_pmc_program_counter(int blk_num, u32 cnt_num, u32 evt, bool is_l3)
 {
-	uint64_t perfctl, perfevt, perfmon_cfg;
+	u64 perfctl, perfevt, perfmon_cfg;
 
 	if (cnt_num >= pmc->block[blk_num].counters)
 		return -ENODEV;
@@ -1263,12 +1255,11 @@ static int mlxbf_pmc_program_counter(int blk_num, uint32_t cnt_num,
 }
 
 /* Method to handle l3 counter reads */
-static int mlxbf_pmc_read_l3_counter(int blk_num, uint32_t cnt_num,
-				     uint64_t *result)
+static int mlxbf_pmc_read_l3_counter(int blk_num, u32 cnt_num, u64 *result)
 {
-	uint32_t perfcnt_low = 0, perfcnt_high = 0;
-	uint64_t value;
+	u32 perfcnt_low = 0, perfcnt_high = 0;
 	int status;
+	u64 value;
 
 	status = mlxbf_pmc_readl(pmc->block[blk_num].mmio_base +
 					 MLXBF_PMC_L3C_PERF_CNT_LOW +
@@ -1295,11 +1286,10 @@ static int mlxbf_pmc_read_l3_counter(int blk_num, uint32_t cnt_num,
 }
 
 /* Method to handle crspace counter reads */
-static int mlxbf_pmc_read_crspace_counter(int blk_num, uint32_t cnt_num,
-					  uint64_t *result)
+static int mlxbf_pmc_read_crspace_counter(int blk_num, u32 cnt_num, u64 *result)
 {
-	uint32_t value;
 	int status = 0;
+	u32 value;
 
 	status = mlxbf_pmc_readl(pmc->block[blk_num].mmio_base +
 		MLXBF_PMC_CRSPACE_PERFMON_VAL0(pmc->block[blk_num].counters) +
@@ -1313,11 +1303,10 @@ static int mlxbf_pmc_read_crspace_counter(int blk_num, uint32_t cnt_num,
 }
 
 /* Method to read the counter value */
-static int mlxbf_pmc_read_counter(int blk_num, uint32_t cnt_num, bool is_l3,
-				  uint64_t *result)
+static int mlxbf_pmc_read_counter(int blk_num, u32 cnt_num, bool is_l3, u64 *result)
 {
-	uint32_t perfcfg_offset, perfval_offset;
-	uint64_t perfmon_cfg;
+	u32 perfcfg_offset, perfval_offset;
+	u64 perfmon_cfg;
 	int status;
 
 	if (cnt_num >= pmc->block[blk_num].counters)
@@ -1351,13 +1340,11 @@ static int mlxbf_pmc_read_counter(int blk_num, uint32_t cnt_num, bool is_l3,
 }
 
 /* Method to read L3 block event */
-static int mlxbf_pmc_read_l3_event(int blk_num, uint32_t cnt_num,
-				   uint64_t *result)
+static int mlxbf_pmc_read_l3_event(int blk_num, u32 cnt_num, u64 *result)
 {
-	uint32_t perfcnt_sel = 0, perfcnt_sel_1 = 0;
-	uint32_t *wordaddr;
+	u32 perfcnt_sel = 0, perfcnt_sel_1 = 0, *wordaddr;
 	void __iomem *pmcaddr;
-	uint64_t evt;
+	u64 evt;
 
 	/* Select appropriate register information */
 	switch (cnt_num) {
@@ -1405,10 +1392,9 @@ static int mlxbf_pmc_read_l3_event(int blk_num, uint32_t cnt_num,
 }
 
 /* Method to read crspace block event */
-static int mlxbf_pmc_read_crspace_event(int blk_num, uint32_t cnt_num,
-					uint64_t *result)
+static int mlxbf_pmc_read_crspace_event(int blk_num, u32 cnt_num, u64 *result)
 {
-	uint32_t word, evt;
+	u32 word, evt;
 	void *addr;
 	int ret;
 
@@ -1429,11 +1415,10 @@ static int mlxbf_pmc_read_crspace_event(int blk_num, uint32_t cnt_num,
 }
 
 /* Method to find the event currently being monitored by a counter */
-static int mlxbf_pmc_read_event(int blk_num, uint32_t cnt_num, bool is_l3,
-				uint64_t *result)
+static int mlxbf_pmc_read_event(int blk_num, u32 cnt_num, bool is_l3, u64 *result)
 {
-	uint32_t perfcfg_offset, perfval_offset;
-	uint64_t perfmon_cfg, perfevt;
+	u32 perfcfg_offset, perfval_offset;
+	u64 perfmon_cfg, perfevt;
 
 	if (cnt_num >= pmc->block[blk_num].counters)
 		return -EINVAL;
@@ -1469,9 +1454,9 @@ static int mlxbf_pmc_read_event(int blk_num, uint32_t cnt_num, bool is_l3,
 }
 
 /* Method to read a register */
-static int mlxbf_pmc_read_reg(int blk_num, uint32_t offset, uint64_t *result)
+static int mlxbf_pmc_read_reg(int blk_num, u32 offset, u64 *result)
 {
-	uint32_t ecc_out;
+	u32 ecc_out;
 
 	if (strstr(pmc->block_name[blk_num], "ecc")) {
 		if (mlxbf_pmc_readl(pmc->block[blk_num].mmio_base + offset,
@@ -1490,7 +1475,7 @@ static int mlxbf_pmc_read_reg(int blk_num, uint32_t offset, uint64_t *result)
 }
 
 /* Method to write to a register */
-static int mlxbf_pmc_write_reg(int blk_num, uint32_t offset, uint64_t data)
+static int mlxbf_pmc_write_reg(int blk_num, u32 offset, u64 data)
 {
 	if (strstr(pmc->block_name[blk_num], "ecc")) {
 		return mlxbf_pmc_write(pmc->block[blk_num].mmio_base + offset,
@@ -1512,7 +1497,7 @@ static ssize_t mlxbf_pmc_counter_show(struct device *dev,
 		attr, struct mlxbf_pmc_attribute, dev_attr);
 	int blk_num, cnt_num, offset;
 	bool is_l3 = false;
-	uint64_t value;
+	u64 value;
 
 	blk_num = attr_counter->nr;
 	cnt_num = attr_counter->index;
@@ -1546,7 +1531,7 @@ static ssize_t mlxbf_pmc_counter_store(struct device *dev,
 		attr, struct mlxbf_pmc_attribute, dev_attr);
 	int blk_num, cnt_num, offset, err, data;
 	bool is_l3 = false;
-	uint64_t evt_num;
+	u64 evt_num;
 
 	blk_num = attr_counter->nr;
 	cnt_num = attr_counter->index;
@@ -1597,7 +1582,7 @@ static ssize_t mlxbf_pmc_event_show(struct device *dev,
 		attr, struct mlxbf_pmc_attribute, dev_attr);
 	int blk_num, cnt_num, err;
 	bool is_l3 = false;
-	uint64_t evt_num;
+	u64 evt_num;
 	char *evt_name;
 
 	blk_num = attr_event->nr;
@@ -1686,7 +1671,7 @@ static ssize_t mlxbf_pmc_enable_show(struct device *dev,
 {
 	struct mlxbf_pmc_attribute *attr_enable = container_of(
 		attr, struct mlxbf_pmc_attribute, dev_attr);
-	uint32_t perfcnt_cfg, word;
+	u32 perfcnt_cfg, word;
 	int blk_num, value;
 
 	blk_num = attr_enable->nr;
@@ -1718,7 +1703,7 @@ static ssize_t mlxbf_pmc_enable_store(struct device *dev,
 	struct mlxbf_pmc_attribute *attr_enable = container_of(
 		attr, struct mlxbf_pmc_attribute, dev_attr);
 	int err, en, blk_num;
-	uint32_t word;
+	u32 word;
 
 	blk_num = attr_enable->nr;
 
@@ -1914,7 +1899,7 @@ static bool mlxbf_pmc_guid_match(const guid_t *guid,
 /* Helper to map the Performance Counters from the varios blocks */
 static int mlxbf_pmc_map_counters(struct device *dev)
 {
-	uint64_t info[MLXBF_PMC_INFO_SZ];
+	u64 info[MLXBF_PMC_INFO_SZ];
 	int i, tile_num, ret;
 
 	for (i = 0; i < pmc->total_blocks; ++i) {
-- 
2.30.1


