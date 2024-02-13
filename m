Return-Path: <linux-kernel+bounces-63411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEC4852EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD1C5283D2F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888B1383BC;
	Tue, 13 Feb 2024 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aIqqe8VX"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C867B37710;
	Tue, 13 Feb 2024 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822963; cv=fail; b=Ww6ddHSRoWqaN5J3B3lkU4AXa0rJOhfcZLlihVvw4MxqZlQ3bErNuc7n+tP4C2LwEN1Sy+tnSl9jLQnm4zHbejhLoH0MbdWMZeeF+7YenWCwS9kdKs9Rkka1sgi2O0aOYAfEbvSpqvcRN7sIL3Ue55ABcSrMgdWpMIGhJkNdbp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822963; c=relaxed/simple;
	bh=Jy6eVYV3XOONq40i68ru4ykCL2BVRK/o9lE5PSdfHIY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R20d7jeJKhUGw9NxgxK+S5sSLotZTAw8tNdKMRoUNOhIgNGEQeD1bpyqInf0NcT1LE7cNo2M1HcDwOvjN6bIKuBHfUP01FRfkj5WH/RGmPM8lwO8rS+oLLbJoEe56OX3i8ppxmznJboQGYGPnZWXJV6OLXjhjraf69qjFrYwb/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aIqqe8VX; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTOID17ZIqFfMlGj+wezFp39+c84C3mSTPbrjvBX6OPGaB5kR+F6PED1/hIdaejTVfH0AOjfR4V2UjC+pcxf2YWUTg+SinpjKT8t827XfqTBX1XoG1JTekuWhZI9NKF3d7lnZriQGak17qBXnGjqw0pbrdfMrbTk7aVRyaJiv5HZAI5UFlXAGC4UKTwW2nxx1u6C0IYXilxUChTRpuw+rn8aEZ6xWGoDA7Ia8zaW2TLBQKA6xc7ga6DWS/+I9eL1l988JDbo3BeUZXgYNWbJh7Io1Vww5V8u2CAZGcoaze4YErpNzDCU51J/wRRbXyvm0guDnfB6dXKuyVL8OrqabA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThFSIJZGp841I63Van74rEmxPS4mnIBwWMX9Kk8WlPY=;
 b=no5ygbdd6mALKx5Fw7EUqJO6ti6P+pvuyteTfndaDOQ40ooI3BtfyuH2Cwd9KDv+9J0oos+MbquhkrLJU71RIMZAFAqy0YCkoObhUxdBMoF2dMMXwWZ9p9VyE8GW4q7s2SOi1wXXLyCVw5kr+e5iiee0AZey1WU+AS04D1qWcAWkN+rFSfZ/fsQWrGlQohHEdyqWp88SZPqArTIqTWZb2igJCTUV9pDVzE44/bTm1jmLjKb6MrHRz/wgne1evw5U6n1LJxw3bhZyJVJFwXplM/lvbopD0vinjzEQkhqEIoag/y3uFzLi9AvPQWKmElyjFlqpWnumipncPg+mJF1azg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThFSIJZGp841I63Van74rEmxPS4mnIBwWMX9Kk8WlPY=;
 b=aIqqe8VXN1Rv/C4ajeGcqsS+3+z+dO71qikoIdK0ci4/cjj6NGDW0LWX9oRWKNniJhd02ZPQH42s743OF+E2gcDvo58+vtCbiX06jBBkyZ5cSyHwfxLKCmjM96xhyQJXDdxpzJYY5JarQw0P7kssI3z7EuwjHoBmt7D9VyFR+aUtea9yji98I4cmcdCSc+o/nMq6JblYr7eGBj6roaukSsDYnuPZQ8qLQ4x2q/m5m72iV/Mzd0+NLCwcFA+nDYa1oMDKhejQW6zsPIkUZ2HMVRnI4bW7hFAnw/MuwFaRxL6apc40vwM0/bvREtu/o+fMd5bK4xVwdhtY1rMbBnSp3g==
Received: from CH2PR16CA0007.namprd16.prod.outlook.com (2603:10b6:610:50::17)
 by DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 11:15:59 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::96) by CH2PR16CA0007.outlook.office365.com
 (2603:10b6:610:50::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Tue, 13 Feb 2024 11:15:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 11:15:59 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 13 Feb
 2024 03:15:44 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 13 Feb
 2024 03:15:44 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 13
 Feb 2024 03:15:43 -0800
From: Shravan Kumar Ramani <shravankr@nvidia.com>
To: Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "David
 Thompson" <davthompson@nvidia.com>
CC: Shravan Kumar Ramani <shravankr@nvidia.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/4] platform/mellanox: mlxbf-pmc: Add support for clock_measure performance block
Date: Tue, 13 Feb 2024 06:15:28 -0500
Message-ID: <1c2f1b6da51523fe0f338f9ddce9e3903148f604.1707808180.git.shravankr@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|DM4PR12MB5232:EE_
X-MS-Office365-Filtering-Correlation-Id: 747482e4-121d-4650-29aa-08dc2c8527f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T9RBRNlAH7ykjg3as2NI2CnHr0k/UHn4/hi26pMtN0nCJo3f+QDe3rPKAw9BLWqkZitaWov6CBjMaaSXPAYjfNY1dv4orHsseFLz+5NRZ3BEOl13QBdqEFeRK2BoRQC5PNdrC3k6QFcaASxd6elao84WDij6oaTrppHVRmOmSicT5LgB+XPFJgQ8CWVoDsI6WdyONRIsJY0YZOF4bztifGumCc7hD6B6OsyNaR1h6gdRZejl1NmBzKXKbjWlL3Lf/hQm7PbHDkvChgwh12fGIqeP5zeAiBwoCOU+Lrs8yTF/bMVAsBwkK/mt4T/RPx/o+5eraVikF8AIiraLiH9hBILi1p7X3L8GuR8Q7XWvY1BZm4u538S5qZc+G0FOgDqEQigqoapYSpxbsaZb+Lf7RfbPXVTWFHcIgXOrJZBlqsN0g0uzI5ucpsUcCau6zlCC8K0gPoO8v2BZ0Vdju4bxQDve+WUvjdGNdb9zKchqi+Gyvjc+doEtF2xkxyPt/WhV8jwip0hQV18UjtQf0ER+mjBOGwbip3DlfuZvPDcaHPP/5qblVBrLrFG3ry200EK5UBrZAjqb/ZhKUk/CPE70M5oiE6Yo45hGq8x6VQNwquA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(186009)(82310400011)(451199024)(64100799003)(1800799012)(40470700004)(36840700001)(46966006)(316002)(110136005)(54906003)(70586007)(70206006)(6636002)(41300700001)(2906002)(5660300002)(8676002)(8936002)(4326008)(478600001)(6666004)(2616005)(7696005)(36756003)(82740400003)(83380400001)(86362001)(26005)(336012)(426003)(7636003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 11:15:59.0528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 747482e4-121d-4650-29aa-08dc2c8527f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5232

The HW clock_measure counter info is passed to the driver from ACPI.
Create a new sub-directory for clock_measure events and provide
read access to the user. Writes are blocked since the fields are RO.

Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
---
 drivers/platform/mellanox/mlxbf-pmc.c | 46 ++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index e2f11c0c63e9..b14fec062e62 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -865,6 +865,37 @@ static const struct mlxbf_pmc_events mlxbf_pmc_llt_miss_events[] = {
 	{75, "HISTOGRAM_HISTOGRAM_BIN9"},
 };
 
+static const struct mlxbf_pmc_events mlxbf_pmc_clock_events[] = {
+	{ 0x0, "FMON_CLK_LAST_COUNT_PLL_D1_INST0" },
+	{ 0x4, "REFERENCE_WINDOW_WIDTH_PLL_D1_INST0" },
+	{ 0x8, "FMON_CLK_LAST_COUNT_PLL_D1_INST1" },
+	{ 0xc, "REFERENCE_WINDOW_WIDTH_PLL_D1_INST1" },
+	{ 0x10, "FMON_CLK_LAST_COUNT_PLL_G1" },
+	{ 0x14, "REFERENCE_WINDOW_WIDTH_PLL_G1" },
+	{ 0x18, "FMON_CLK_LAST_COUNT_PLL_W1" },
+	{ 0x1c, "REFERENCE_WINDOW_WIDTH_PLL_W1" },
+	{ 0x20, "FMON_CLK_LAST_COUNT_PLL_T1" },
+	{ 0x24, "REFERENCE_WINDOW_WIDTH_PLL_T1" },
+	{ 0x28, "FMON_CLK_LAST_COUNT_PLL_A0" },
+	{ 0x2c, "REFERENCE_WINDOW_WIDTH_PLL_A0" },
+	{ 0x30, "FMON_CLK_LAST_COUNT_PLL_C0" },
+	{ 0x34, "REFERENCE_WINDOW_WIDTH_PLL_C0" },
+	{ 0x38, "FMON_CLK_LAST_COUNT_PLL_N1" },
+	{ 0x3c, "REFERENCE_WINDOW_WIDTH_PLL_N1" },
+	{ 0x40, "FMON_CLK_LAST_COUNT_PLL_I1" },
+	{ 0x44, "REFERENCE_WINDOW_WIDTH_PLL_I1" },
+	{ 0x48, "FMON_CLK_LAST_COUNT_PLL_R1" },
+	{ 0x4c, "REFERENCE_WINDOW_WIDTH_PLL_R1" },
+	{ 0x50, "FMON_CLK_LAST_COUNT_PLL_P1" },
+	{ 0x54, "REFERENCE_WINDOW_WIDTH_PLL_P1" },
+	{ 0x58, "FMON_CLK_LAST_COUNT_REF_100_INST0" },
+	{ 0x5c, "REFERENCE_WINDOW_WIDTH_REF_100_INST0" },
+	{ 0x60, "FMON_CLK_LAST_COUNT_REF_100_INST1" },
+	{ 0x64, "REFERENCE_WINDOW_WIDTH_REF_100_INST1" },
+	{ 0x68, "FMON_CLK_LAST_COUNT_REF_156" },
+	{ 0x6c, "REFERENCE_WINDOW_WIDTH_REF_156" },
+};
+
 static struct mlxbf_pmc_context *pmc;
 
 /* UUID used to probe ATF service. */
@@ -1037,6 +1068,9 @@ static const struct mlxbf_pmc_events *mlxbf_pmc_event_list(const char *blk, size
 	} else if (strstr(blk, "llt")) {
 		events = mlxbf_pmc_llt_events;
 		*size = ARRAY_SIZE(mlxbf_pmc_llt_events);
+	} else if (strstr(blk, "clock_measure")) {
+		events = mlxbf_pmc_clock_events;
+		*size = ARRAY_SIZE(mlxbf_pmc_clock_events);
 	} else {
 		events = NULL;
 		*size = 0;
@@ -1463,14 +1497,15 @@ static int mlxbf_pmc_read_event(unsigned int blk_num, u32 cnt_num, bool is_l3, u
 /* Method to read a register */
 static int mlxbf_pmc_read_reg(unsigned int blk_num, u32 offset, u64 *result)
 {
-	u32 ecc_out;
+	u32 reg;
 
-	if (strstr(pmc->block_name[blk_num], "ecc")) {
+	if ((strstr(pmc->block_name[blk_num], "ecc")) ||
+	    (strstr(pmc->block_name[blk_num], "clock_measure"))) {
 		if (mlxbf_pmc_readl(pmc->block[blk_num].mmio_base + offset,
-				    &ecc_out))
+				    &reg))
 			return -EFAULT;
 
-		*result = ecc_out;
+		*result = reg;
 		return 0;
 	}
 
@@ -1484,6 +1519,9 @@ static int mlxbf_pmc_read_reg(unsigned int blk_num, u32 offset, u64 *result)
 /* Method to write to a register */
 static int mlxbf_pmc_write_reg(unsigned int blk_num, u32 offset, u64 data)
 {
+	if (strstr(pmc->block_name[blk_num], "clock_measure"))
+		return -EINVAL;
+
 	if (strstr(pmc->block_name[blk_num], "ecc")) {
 		return mlxbf_pmc_write(pmc->block[blk_num].mmio_base + offset,
 				       MLXBF_PMC_WRITE_REG_32, data);
-- 
2.30.1


