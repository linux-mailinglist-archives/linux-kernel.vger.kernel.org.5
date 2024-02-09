Return-Path: <linux-kernel+bounces-59118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 280E984F17F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 068BFB238A8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3954A664B5;
	Fri,  9 Feb 2024 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OOXDHFVf"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B95664A3;
	Fri,  9 Feb 2024 08:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468038; cv=fail; b=YRGaHPBUOwQnDEaeg64nhhBhDfyzvlOjXrbQylzSIf1UqY7oBgF8HoUJtP5jHsmqA9qu6XU9xoe6ixcBAKgNsHC4BVMbiS6ZrOew5hzTz3BGs86W5IkgYXjlcAQE+sqse4gEdZKozbZI8AJVwpUYlKxKPyNtV4Jej7FPZVPBSNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468038; c=relaxed/simple;
	bh=iwxIfL3BRl2s/RdxnJ/l/m0BxRF2hXa5DFn8OSL4O0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JtDZeZqiXuti/N7HHRzs67ypE1qeM08k6dZCH0swXcBX5uaifswhwCanzwJL0YHmqajgHqs7fD2MAE5Jab0z28/7lNTwbEGw9kI5o07/6GQrMAWhR/hHGEOnG/sOgnoyNkreoedVcQMM6hLbgPEOfqeEWanIGtk3Y2jp4096u4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OOXDHFVf; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+9t9cs+Th2aFkQOxXQc1MHO1cRd0GLYGsNmZrPn9nbuaM8z107XWW9Tb4ixZg0Pu3Dlyo/x2y7aU1SdnN3/4AU7ZG6VIkUOvg10LmC9P1QVDXboCGrPC6m7u6mmdQdEeIeCRRl+pxMjGmb18NNO9AXVy3YbBqSxeXKzfLD1BjqRPsUBAzB+V/8Dbs0wt4mcZZkRNmla6jfBJRjprW5OlFmwrfHL4EuXS97corr+57dHdRSujCb8F85yPvtQfmzomSsE1BJKwDg0VjHQ6nwWRHf+hm74C69QZqO/1NB0qEzkaz/1X0qhVeO3ly76No98RYhCH8Ypp1rJaNEGE2BPVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vedIqzSP9LYhLSc7fEzE8oeyW7b9RTVcMS1qheeKS0w=;
 b=TPKzBMK+xSQIGXb2y31lwXvB0fKass1n6ADSAGFLDQ5V0kNQVTjnSEBL5xVFD/OcT8IhpuLeWoEVsB73MnhkKzOPrjPdcZww2Kkxdky5NPLisOPFVp4h89MGIlfABMeVH8pmOXCXMw0Q7S0L8FMGdU8S1z2HM60nFUMP3a8kOnHKh2WHENvw5S2f8mystCtPgF3djdllIGtRDGpddCMIexnlS4MCtJkFwlClAIddzHVP6gRBRyiAk/guLaFnO5CztfA5Qafck1Tdba97ksdf/3noKjdwscshxGfaOM7KzgDFZFRO9nG5/xAFs27ZnlHlrRkC9EYvRzjQXTfUOq4iUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vedIqzSP9LYhLSc7fEzE8oeyW7b9RTVcMS1qheeKS0w=;
 b=OOXDHFVfxRwVevCVPcVCEyZcoemLfleoYcm+UovPVe5agN2kfhc92goJJRKPHp4y1MivgpkUxzOgnpXwTskj61CSwt6JOXIAAAkukPw0CdvoRKcUDBfQ5wA9U6i6ipfrFhsMs4bPYKNPeXkmW6XHGyFFkeU9KdtoCO4pPcT+ZzD0D1W1kUbuH7rYO0VPxrJNuSKWh9rjEQL+7cmTHdVrkC/Z+dp+5L1nUJUUE/W0tQc5CeZq0WJ60fmp/pVm/eD9U4vy4ZYdWkfrdmxdQAWZRs+bszJn7SgD271sJIkQ7PZ8VC0lAi4geJ+VQ3zPHXJPU7jSNX5o+KP6ve7cZYYkaA==
Received: from DM6PR03CA0102.namprd03.prod.outlook.com (2603:10b6:5:333::35)
 by DM6PR12MB4878.namprd12.prod.outlook.com (2603:10b6:5:1b8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Fri, 9 Feb
 2024 08:40:33 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::50) by DM6PR03CA0102.outlook.office365.com
 (2603:10b6:5:333::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Fri, 9 Feb 2024 08:40:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 08:40:33 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 9 Feb 2024
 00:40:11 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Fri, 9 Feb 2024 00:40:11 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 9 Feb 2024 00:40:10 -0800
From: Shravan Kumar Ramani <shravankr@nvidia.com>
To: Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "David
 Thompson" <davthompson@nvidia.com>
CC: Shravan Kumar Ramani <shravankr@nvidia.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/4] platform/mellanox: mlxbf-pmc: Replace uintN_t with kernel-style types
Date: Fri, 9 Feb 2024 03:39:54 -0500
Message-ID: <73cd5e838695f8e20b022a523dcade108685350b.1707466888.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1707466888.git.shravankr@nvidia.com>
References: <cover.1707466888.git.shravankr@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|DM6PR12MB4878:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e8504f-e098-4745-ea1e-08dc294ac7cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yFlGNlNpiJ81xv40VSkEZmtql2vi9YXAmudJZYAwZk+3vRwm7XUeYTcWEJemDSMEPqYp5Pb3AJWAlbK8xvlTjm0SalI5o91svlDEtqgWMmvTuBm61DrZnXPjzanV/1ziaY4M6Kiag/btpOyUqdeava38z9OOUJm4xjd5qimq6IsNFJhoePSkm2tEZVC2LB+T7+eijuxV7ylfeqqrNmekURiDDp7Tnfn3s7u/+KwIpWUp4WychyZytmnI54fbs8tZOx96auhOd5jdWlX7GLtVUowO7dKzRMB7e60skeDbKUsIjZY1k/9LgK0A/mxW0HQAG8MjewXPuCeN6BG51SS9LwBhvnJD3U/EkrnOOZoxBn08yv83D8yJg9dgTcqAOtXuopXDmhChghS7YPGURUkypDLpF+YSutWUngop74JtmarCsn15gNw/rlOfvZp3n3fwyicNzLVi93kPdX5DeX/LHUEki0D8TH+4zPrFIDEB4wwGAaaj37RLBJ1dleyJgWAI8IHxw28N2or1GwMJy9NoozY6M1DEsYyQK32wv/zmcAWsk/QYQ59J5YdUTbZnMDuIWj94buis5wcHJB9nrKS+qQ12Q6ie1J63j/2Zl3M2saY=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(82310400011)(186009)(40470700004)(46966006)(36840700001)(41300700001)(7696005)(2616005)(30864003)(6666004)(2906002)(4326008)(86362001)(8676002)(426003)(70206006)(5660300002)(70586007)(26005)(336012)(6636002)(316002)(110136005)(478600001)(82740400003)(83380400001)(7636003)(54906003)(356005)(36756003)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 08:40:33.4775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e8504f-e098-4745-ea1e-08dc294ac7cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4878

Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
---
 drivers/platform/mellanox/mlxbf-pmc.c | 121 +++++++++++++-------------
 1 file changed, 59 insertions(+), 62 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index b1995ac268d7..71d919832e2a 100644
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
 
@@ -865,8 +865,8 @@ static struct mlxbf_pmc_context *pmc;
 static const char *mlxbf_pmc_svc_uuid_str = "89c036b4-e7d7-11e6-8797-001aca00bfc4";
 
 /* Calls an SMC to access a performance register */
-static int mlxbf_pmc_secure_read(void __iomem *addr, uint32_t command,
-				 uint64_t *result)
+static int mlxbf_pmc_secure_read(void __iomem *addr, u32 command,
+				 u64 *result)
 {
 	struct arm_smccc_res res;
 	int status, err = 0;
@@ -892,8 +892,8 @@ static int mlxbf_pmc_secure_read(void __iomem *addr, uint32_t command,
 }
 
 /* Read from a performance counter */
-static int mlxbf_pmc_read(void __iomem *addr, uint32_t command,
-			  uint64_t *result)
+static int mlxbf_pmc_read(void __iomem *addr, u32 command,
+			  u64 *result)
 {
 	if (pmc->svc_sreg_support)
 		return mlxbf_pmc_secure_read(addr, command, result);
@@ -907,22 +907,22 @@ static int mlxbf_pmc_read(void __iomem *addr, uint32_t command,
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
+static int mlxbf_pmc_secure_write(void __iomem *addr, u32 command,
+				  u64 value)
 {
 	struct arm_smccc_res res;
 	int status, err = 0;
@@ -945,7 +945,7 @@ static int mlxbf_pmc_secure_write(void __iomem *addr, uint32_t command,
 }
 
 /* Write to a performance counter */
-static int mlxbf_pmc_write(void __iomem *addr, int command, uint64_t value)
+static int mlxbf_pmc_write(void __iomem *addr, int command, u64 value)
 {
 	if (pmc->svc_sreg_support)
 		return mlxbf_pmc_secure_write(addr, command, value);
@@ -959,7 +959,7 @@ static int mlxbf_pmc_write(void __iomem *addr, int command, uint64_t value)
 }
 
 /* Check if the register offset is within the mapped region for the block */
-static bool mlxbf_pmc_valid_range(int blk_num, uint32_t offset)
+static bool mlxbf_pmc_valid_range(int blk_num, u32 offset)
 {
 	if ((offset >= 0) && !(offset % MLXBF_PMC_REG_SIZE) &&
 	    (offset + MLXBF_PMC_REG_SIZE <= pmc->block[blk_num].blk_size))
@@ -1082,7 +1082,7 @@ static char *mlxbf_pmc_get_event_name(const char *blk, int evt)
 /* Method to enable/disable/reset l3cache counters */
 static int mlxbf_pmc_config_l3_counters(int blk_num, bool enable, bool reset)
 {
-	uint32_t perfcnt_cfg = 0;
+	u32 perfcnt_cfg = 0;
 
 	if (enable)
 		perfcnt_cfg |= MLXBF_PMC_L3C_PERF_CNT_CFG_EN;
@@ -1095,12 +1095,10 @@ static int mlxbf_pmc_config_l3_counters(int blk_num, bool enable, bool reset)
 }
 
 /* Method to handle l3cache counter programming */
-static int mlxbf_pmc_program_l3_counter(int blk_num, uint32_t cnt_num,
-					uint32_t evt)
+static int mlxbf_pmc_program_l3_counter(int blk_num, u32 cnt_num,
+					u32 evt)
 {
-	uint32_t perfcnt_sel_1 = 0;
-	uint32_t perfcnt_sel = 0;
-	uint32_t *wordaddr;
+	u32 perfcnt_sel_1 = 0, perfcnt_sel = 0, *wordaddr;
 	void __iomem *pmcaddr;
 	int ret;
 
@@ -1162,11 +1160,11 @@ static int mlxbf_pmc_program_l3_counter(int blk_num, uint32_t cnt_num,
 }
 
 /* Method to handle crspace counter programming */
-static int mlxbf_pmc_program_crspace_counter(int blk_num, uint32_t cnt_num,
-					     uint32_t evt)
+static int mlxbf_pmc_program_crspace_counter(int blk_num, u32 cnt_num,
+					     u32 evt)
 {
-	uint32_t word;
 	void *addr;
+	u32 word;
 	int ret;
 
 	addr = pmc->block[blk_num].mmio_base +
@@ -1187,7 +1185,7 @@ static int mlxbf_pmc_program_crspace_counter(int blk_num, uint32_t cnt_num,
 }
 
 /* Method to clear crspace counter value */
-static int mlxbf_pmc_clear_crspace_counter(int blk_num, uint32_t cnt_num)
+static int mlxbf_pmc_clear_crspace_counter(int blk_num, u32 cnt_num)
 {
 	void *addr;
 
@@ -1199,10 +1197,10 @@ static int mlxbf_pmc_clear_crspace_counter(int blk_num, uint32_t cnt_num)
 }
 
 /* Method to program a counter to monitor an event */
-static int mlxbf_pmc_program_counter(int blk_num, uint32_t cnt_num,
-				     uint32_t evt, bool is_l3)
+static int mlxbf_pmc_program_counter(int blk_num, u32 cnt_num,
+				     u32 evt, bool is_l3)
 {
-	uint64_t perfctl, perfevt, perfmon_cfg;
+	u64 perfctl, perfevt, perfmon_cfg;
 
 	if (cnt_num >= pmc->block[blk_num].counters)
 		return -ENODEV;
@@ -1263,12 +1261,12 @@ static int mlxbf_pmc_program_counter(int blk_num, uint32_t cnt_num,
 }
 
 /* Method to handle l3 counter reads */
-static int mlxbf_pmc_read_l3_counter(int blk_num, uint32_t cnt_num,
-				     uint64_t *result)
+static int mlxbf_pmc_read_l3_counter(int blk_num, u32 cnt_num,
+				     u64 *result)
 {
-	uint32_t perfcnt_low = 0, perfcnt_high = 0;
-	uint64_t value;
+	u32 perfcnt_low = 0, perfcnt_high = 0;
 	int status;
+	u64 value;
 
 	status = mlxbf_pmc_readl(pmc->block[blk_num].mmio_base +
 					 MLXBF_PMC_L3C_PERF_CNT_LOW +
@@ -1295,11 +1293,11 @@ static int mlxbf_pmc_read_l3_counter(int blk_num, uint32_t cnt_num,
 }
 
 /* Method to handle crspace counter reads */
-static int mlxbf_pmc_read_crspace_counter(int blk_num, uint32_t cnt_num,
-					  uint64_t *result)
+static int mlxbf_pmc_read_crspace_counter(int blk_num, u32 cnt_num,
+					  u64 *result)
 {
-	uint32_t value;
 	int status = 0;
+	u32 value;
 
 	status = mlxbf_pmc_readl(pmc->block[blk_num].mmio_base +
 		MLXBF_PMC_CRSPACE_PERFMON_VAL0(pmc->block[blk_num].counters) +
@@ -1313,11 +1311,11 @@ static int mlxbf_pmc_read_crspace_counter(int blk_num, uint32_t cnt_num,
 }
 
 /* Method to read the counter value */
-static int mlxbf_pmc_read_counter(int blk_num, uint32_t cnt_num, bool is_l3,
-				  uint64_t *result)
+static int mlxbf_pmc_read_counter(int blk_num, u32 cnt_num, bool is_l3,
+				  u64 *result)
 {
-	uint32_t perfcfg_offset, perfval_offset;
-	uint64_t perfmon_cfg;
+	u32 perfcfg_offset, perfval_offset;
+	u64 perfmon_cfg;
 	int status;
 
 	if (cnt_num >= pmc->block[blk_num].counters)
@@ -1351,13 +1349,12 @@ static int mlxbf_pmc_read_counter(int blk_num, uint32_t cnt_num, bool is_l3,
 }
 
 /* Method to read L3 block event */
-static int mlxbf_pmc_read_l3_event(int blk_num, uint32_t cnt_num,
-				   uint64_t *result)
+static int mlxbf_pmc_read_l3_event(int blk_num, u32 cnt_num,
+				   u64 *result)
 {
-	uint32_t perfcnt_sel = 0, perfcnt_sel_1 = 0;
-	uint32_t *wordaddr;
+	u32 perfcnt_sel = 0, perfcnt_sel_1 = 0, *wordaddr;
 	void __iomem *pmcaddr;
-	uint64_t evt;
+	u64 evt;
 
 	/* Select appropriate register information */
 	switch (cnt_num) {
@@ -1405,10 +1402,10 @@ static int mlxbf_pmc_read_l3_event(int blk_num, uint32_t cnt_num,
 }
 
 /* Method to read crspace block event */
-static int mlxbf_pmc_read_crspace_event(int blk_num, uint32_t cnt_num,
-					uint64_t *result)
+static int mlxbf_pmc_read_crspace_event(int blk_num, u32 cnt_num,
+					u64 *result)
 {
-	uint32_t word, evt;
+	u32 word, evt;
 	void *addr;
 	int ret;
 
@@ -1429,11 +1426,11 @@ static int mlxbf_pmc_read_crspace_event(int blk_num, uint32_t cnt_num,
 }
 
 /* Method to find the event currently being monitored by a counter */
-static int mlxbf_pmc_read_event(int blk_num, uint32_t cnt_num, bool is_l3,
-				uint64_t *result)
+static int mlxbf_pmc_read_event(int blk_num, u32 cnt_num, bool is_l3,
+				u64 *result)
 {
-	uint32_t perfcfg_offset, perfval_offset;
-	uint64_t perfmon_cfg, perfevt;
+	u32 perfcfg_offset, perfval_offset;
+	u64 perfmon_cfg, perfevt;
 
 	if (cnt_num >= pmc->block[blk_num].counters)
 		return -EINVAL;
@@ -1469,9 +1466,9 @@ static int mlxbf_pmc_read_event(int blk_num, uint32_t cnt_num, bool is_l3,
 }
 
 /* Method to read a register */
-static int mlxbf_pmc_read_reg(int blk_num, uint32_t offset, uint64_t *result)
+static int mlxbf_pmc_read_reg(int blk_num, u32 offset, u64 *result)
 {
-	uint32_t ecc_out;
+	u32 ecc_out;
 
 	if (strstr(pmc->block_name[blk_num], "ecc")) {
 		if (mlxbf_pmc_readl(pmc->block[blk_num].mmio_base + offset,
@@ -1490,7 +1487,7 @@ static int mlxbf_pmc_read_reg(int blk_num, uint32_t offset, uint64_t *result)
 }
 
 /* Method to write to a register */
-static int mlxbf_pmc_write_reg(int blk_num, uint32_t offset, uint64_t data)
+static int mlxbf_pmc_write_reg(int blk_num, u32 offset, u64 data)
 {
 	if (strstr(pmc->block_name[blk_num], "ecc")) {
 		return mlxbf_pmc_write(pmc->block[blk_num].mmio_base + offset,
@@ -1512,7 +1509,7 @@ static ssize_t mlxbf_pmc_counter_show(struct device *dev,
 		attr, struct mlxbf_pmc_attribute, dev_attr);
 	int blk_num, cnt_num, offset;
 	bool is_l3 = false;
-	uint64_t value;
+	u64 value;
 
 	blk_num = attr_counter->nr;
 	cnt_num = attr_counter->index;
@@ -1546,7 +1543,7 @@ static ssize_t mlxbf_pmc_counter_store(struct device *dev,
 		attr, struct mlxbf_pmc_attribute, dev_attr);
 	int blk_num, cnt_num, offset, err, data;
 	bool is_l3 = false;
-	uint64_t evt_num;
+	u64 evt_num;
 
 	blk_num = attr_counter->nr;
 	cnt_num = attr_counter->index;
@@ -1597,7 +1594,7 @@ static ssize_t mlxbf_pmc_event_show(struct device *dev,
 		attr, struct mlxbf_pmc_attribute, dev_attr);
 	int blk_num, cnt_num, err;
 	bool is_l3 = false;
-	uint64_t evt_num;
+	u64 evt_num;
 	char *evt_name;
 
 	blk_num = attr_event->nr;
@@ -1686,7 +1683,7 @@ static ssize_t mlxbf_pmc_enable_show(struct device *dev,
 {
 	struct mlxbf_pmc_attribute *attr_enable = container_of(
 		attr, struct mlxbf_pmc_attribute, dev_attr);
-	uint32_t perfcnt_cfg, word;
+	u32 perfcnt_cfg, word;
 	int blk_num, value;
 
 	blk_num = attr_enable->nr;
@@ -1718,7 +1715,7 @@ static ssize_t mlxbf_pmc_enable_store(struct device *dev,
 	struct mlxbf_pmc_attribute *attr_enable = container_of(
 		attr, struct mlxbf_pmc_attribute, dev_attr);
 	int err, en, blk_num;
-	uint32_t word;
+	u32 word;
 
 	blk_num = attr_enable->nr;
 
@@ -1914,7 +1911,7 @@ static bool mlxbf_pmc_guid_match(const guid_t *guid,
 /* Helper to map the Performance Counters from the varios blocks */
 static int mlxbf_pmc_map_counters(struct device *dev)
 {
-	uint64_t info[MLXBF_PMC_INFO_SZ];
+	u64 info[MLXBF_PMC_INFO_SZ];
 	int i, tile_num, ret;
 
 	for (i = 0; i < pmc->total_blocks; ++i) {
-- 
2.30.1


