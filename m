Return-Path: <linux-kernel+bounces-44324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F28948420CA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E4B2B315A7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414F667E8D;
	Tue, 30 Jan 2024 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rpdenzid"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E7D67A14;
	Tue, 30 Jan 2024 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608454; cv=fail; b=hTdubMb+3biEcmphPUtsznouQqK+R0o2qgGXDTjr5PpPCeBYuzd2qbRaZLeVjVIFKPQfakaTpWnd4lSENRbuNdaUlYV6Qm1dwnkdXGrRseofNt5NXImhSduftWnErsZYoJ5ihXbU/jT5lo/IkQWqk/B7tsOcV3qZz2dI+IJ1IvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608454; c=relaxed/simple;
	bh=NNHforVWClA2HyHaHLld7hjQUbtIPpoobmozhmNYWN4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iAmrOc+bMwcRQPe9PpFQey01Og64nBXE3RdfM+2uZJMUFOGjZSyifLWhN0rqDnsQ4cRNDlywxpY6+wroteRMNqbE1915dOX9Ep0WNY1DzUxS1A1mHG5j12UEcT/ELCcO+J7okChyEzLF9eiTN0yt767FBNU/sDTznFnX+BDNAJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rpdenzid; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cp9IqKYxwzTCAbbd0L6jByj7+zLwsaVgspWNeWcYltbUo/ioK6BFtr8/AkYFAc0W23dxTbrhEqVmRQCpOEm5MWgZWycwkC2IyAn2UlNR9K9l2X7vbvd2pNeic/jeROW+jr4eS/kWcGwCWvm1dse26Dfwd4+kmMLTczZrg6qj27cNZijLPCHEHiZTE/VgSrQyzq3gWziQyYaQeEtSAPuiX3nvvlrQFDluvVAjyhUFEj5lEEJZMcBoIPnc5I8f2XPw0FUkuSZOCW13/O3OW58pcXbzBd+L0ttjHt5326Aq9pyGCCeppPlWCT671b//inJN8LJ9fL6obbpGAGTtUCFGsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+Tfzvy2SbYDUQFCH6eXTeIV++mYJXK+qaEhxAeokfs=;
 b=cCkP4teLXLYneZ5Sh+eWLYPJzoAKunJcwGOSYN1bzkW5X43tbfqy398Ekds7acWcID9fi2gxQrOxQ3oQmY1fadEPMJg9tFIWZ2JoMHK+yBd/Lyt2Iy0yppL4v369d0IrKuArLF4noBJWZOLhGLHYCpODxfK6BkId16GwXvltpVCmJnDu1PgoGWWds9hc5Fsk2YwLpifVYBjCbvnAi8JvEGpkOVC+CZX8ZKTfam49ZLAEZOax7VUKGSX8kLw8ZkAh2WNoEZRb7U9D69Dhy4tFFzRpQtSmDDGAvqecvlPGWaGQL7NEnJpjbYqaLyy1RK4DkbXLeUMH0wQghOR78JhPxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+Tfzvy2SbYDUQFCH6eXTeIV++mYJXK+qaEhxAeokfs=;
 b=RpdenzidD7gsIR61FxqFSs0+RSHlTe1HvcUwC3244DBV6Hf5Rx5mgqELFI6cKpf//nkyw+gm8EOv6zZ/FetSJDQ5O4ThT1BorHuMR27Z/UsHCG5+Emb1MVHFXKWNfYRvLsZOYMU/zt9JYr+1eRRCGOPb9DosV/iYp1dQeZr5agBJs+a+j5rZhz56e2b6ca0eInXGmu1GFwT4rUegJPkkf/BXqHblRfq6KaIdQDjOUPrW2K2JRaPcfz/b8tH280lhaLV1lEvwaikHTVrNcuUcMM0FxyW7SQRKUlkDSYFNdmKewa4MObpVw9oU4KneDLpJE4LVCeOTKbj5O7UcG+65GA==
Received: from SJ0PR05CA0165.namprd05.prod.outlook.com (2603:10b6:a03:339::20)
 by CY5PR12MB6156.namprd12.prod.outlook.com (2603:10b6:930:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 09:54:09 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:a03:339:cafe::54) by SJ0PR05CA0165.outlook.office365.com
 (2603:10b6:a03:339::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.21 via Frontend
 Transport; Tue, 30 Jan 2024 09:54:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 09:54:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 30 Jan
 2024 01:53:58 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 30 Jan
 2024 01:53:57 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Tue, 30 Jan
 2024 01:53:57 -0800
From: Shravan Kumar Ramani <shravankr@nvidia.com>
To: Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "David
 Thompson" <davthompson@nvidia.com>
CC: Shravan Kumar Ramani <shravankr@nvidia.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/2] platform/mellanox: mlxbf-pmc: Add support for clock_measure performance block
Date: Tue, 30 Jan 2024 04:53:48 -0500
Message-ID: <c818d6398b8f702a978ce4dbffa58bb8b08f36b2.1706607635.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1706607635.git.shravankr@nvidia.com>
References: <cover.1706607635.git.shravankr@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|CY5PR12MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b962bc7-6472-4da7-5b04-08dc2179678b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MbTPrlCFphuAOuJ3l0BzbczZgT0i+4YWvLR/dxxJUNy/hNR2Q4dVMYPA/6dd7dZVzqKZwjR16gOi8HMKpH7jIGvH32jD7DfAteuCV+6yFHm0JebdcxH+wyL0M46oMS7TF2R6A0Xswt+2bfmva28ryYoo5JauD+xQn2+lwelSIn3TLfIIBLw2y5U6dRlcK5AldB16ZnBOo94fRFFbldJ3HQBz2PniEkm6R4kZXoL/bfCnxolbQmsa8+j1SUQZkI7a8C87Mus+eOQGddzpd+Vg/coucrfbDPzd2WZSqWNOvOCTWlZnqqf2HzDZN4W5ipf+zncXL18dI2HyeQyhHqTah57I0z2nhnxc2DeCYTvB0vSl2SK1UxT5xP08ojdQnIaQ+ictIRxEQ6+1hJsuz/JhFs3Muy9JaxGXyPjooBc9KPx+A4UrCw2vKlgVB5+mqGrRK+t/x+qPCpMU9EZG7iX9wj5p2U0F8AQRCDe3WpgyUw/FMDSXGYvPNQ7ORETTT+M7+Hiz9dHoFCSwtJ49GeoPnOuP3Y9ZoFW2EISOWOLCeJtatOUqX3jGCU0vp5NRlZRkoH6Ypnn3gGE4SxSEB4qLpNt9I+GAStQMHRk0vZyh1HFN1aMDh0fE2H9FUASk3fv+XM3R7iHSPWMkHDJvNqfEFZuWNwEEJMI7YYkc339qZuOos2ZH0VrOF9cnir8tKwDvulQhCXA9DT6z81jesyQyjPhemEMNoCzUnn7TmGr/hnvTHicGkvkc6cjIlSNYhUGm
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799012)(40470700004)(46966006)(36840700001)(316002)(2906002)(8676002)(4326008)(8936002)(5660300002)(86362001)(6636002)(110136005)(70586007)(70206006)(54906003)(478600001)(6666004)(36756003)(36860700001)(47076005)(82740400003)(7636003)(356005)(7696005)(83380400001)(2616005)(426003)(336012)(26005)(41300700001)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 09:54:09.0307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b962bc7-6472-4da7-5b04-08dc2179678b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6156

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
index 906dfa96f783..e1c0e2f04abb 100644
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
@@ -1041,6 +1072,9 @@ static const struct mlxbf_pmc_events *mlxbf_pmc_event_list(const char *blk,
 	} else if (strstr(blk, "llt")) {
 		events = mlxbf_pmc_llt_events;
 		*size = ARRAY_SIZE(mlxbf_pmc_llt_events);
+	} else if (strstr(blk, "clock_measure")) {
+		events = mlxbf_pmc_clock_events;
+		*size = ARRAY_SIZE(mlxbf_pmc_clock_events);
 	} else {
 		events = NULL;
 		*size = 0;
@@ -1477,14 +1511,15 @@ static int mlxbf_pmc_read_event(int blk_num, uint32_t cnt_num, bool is_l3,
 /* Method to read a register */
 static int mlxbf_pmc_read_reg(int blk_num, uint32_t offset, uint64_t *result)
 {
-	uint32_t ecc_out;
+	uint32_t reg;
 
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
 
@@ -1498,6 +1533,9 @@ static int mlxbf_pmc_read_reg(int blk_num, uint32_t offset, uint64_t *result)
 /* Method to write to a register */
 static int mlxbf_pmc_write_reg(int blk_num, uint32_t offset, uint64_t data)
 {
+	if (strstr(pmc->block_name[blk_num], "clock_measure"))
+		return -EINVAL;
+
 	if (strstr(pmc->block_name[blk_num], "ecc")) {
 		return mlxbf_pmc_write(pmc->block[blk_num].mmio_base + offset,
 				       MLXBF_PMC_WRITE_REG_32, data);
-- 
2.30.1


