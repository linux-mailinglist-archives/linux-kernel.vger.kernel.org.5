Return-Path: <linux-kernel+bounces-158176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721348B1C8D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70135B239A1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2337985299;
	Thu, 25 Apr 2024 08:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jXHfMgVh"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C071074432;
	Thu, 25 Apr 2024 08:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714032525; cv=fail; b=NFRFDZH/XThkXI1xm6DpTcOdF5Cs+1A5pZgsdRnMgYIV4Aenefr+c1UbMmVZ6hwmofxjBr3aSTV9LrEluVubvCyN9j7dfgwul9RsFvvN1AiVrCy1LYAKwZxF7tWHd7tBxK2dr2oUg+n6bSgMU0YHBCXPFRAXoGOmdmbmROdmjpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714032525; c=relaxed/simple;
	bh=g6WD0ANrhaMgE1Y1p/jcF0wVTNB8YbtDmxbug3MTWRU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pK63hyjO0VR7x8kRdg/K89n0pyQWAE53ztPUeajHc/KXTYA0Yw6RGi5I+H4VPo4p9L5JzXk5Wvy95JnSmENzSF517G/YPcFmMTMsoGKCJpYM3W6nRiv7duxhHgpPXsbL+tO4b9lz6BHI28vQd7yus9a31kJNWAIurxdbTbaywTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jXHfMgVh; arc=fail smtp.client-ip=40.107.102.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpTNETFrWEJAUHsmJe/5IyXKO90XkhZLnyaun7DhHlFNj/y9bPBuaenh8rNHmIqGPxk1CS2lHhDtkWUyeSN1Gj+eOT11HuC8CQd6vDR2iZiXOiAz4DvMz9FN19Jyt6sAh5tpkjM8sSEPFAvoxS95tXRuPVg39VxveafKC6aJf72CRd6WmRs7zLWP/MXP6Vky4CEIW0umtdei6r6KfMOLN5xWWSn7y2QKrWYoSFoUQYflpgasCmZ/Wwium2STLR8rC5FTkOKu045McrI7901e4QGU/5NVz/qkLyWAqeEI+bUNaGMaxMUkTpUq5e1ov6GKC6mVW3V1XkJXZlQrNZ70Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQelncCBs748RSNbzkjYxC5MXTdjjmvR9tO/qsHHwQY=;
 b=mp0FJnysCLbk1bwWzNrRT+8w0rHl/TYYyoHIhWU+gUeYm33qpahsFvCgOwlqg14GGLshyUoPadVLGCZUxpMrdij5GxIdrNO5wQ7sYXoWPgMuIUO50MYiXs2EVDLl9iVyhOQzv7IqjHOWeAJ4bVxH6C7M7kOWHnIECmraljVAbrclDxYIpuaL0ig0QltnFEqk8QH07h+SS5OOy3G+C0XrupkNd2vqfZxflFSHWVqwk8p8DsyUpT9QsYJg3s/f/xQ3MymNsIBeNifFVYBCAenw4GBIyiMghXcjfZFabJOhaeE9SWbn+ZJsvicQUwJRaSEDDJQ10ESTTD2iyQtRTdbSrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQelncCBs748RSNbzkjYxC5MXTdjjmvR9tO/qsHHwQY=;
 b=jXHfMgVhX5Iv/BGu0whxkdT34naimqaERTJZYcR8rnhJ46j0SSWGYRPPlryuipHpJKjFPTkMUn6Oi+AF8WXyS5wUlpTlION15eNDTD1kct4ZaILlb7+rzuCaDxZigy++zsEY+RgVxaXfnqToitUiYybNbELDJUVe210sHUVp1oo=
Received: from CH0PR04CA0075.namprd04.prod.outlook.com (2603:10b6:610:74::20)
 by CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 08:08:41 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:74:cafe::e2) by CH0PR04CA0075.outlook.office365.com
 (2603:10b6:610:74::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.26 via Frontend
 Transport; Thu, 25 Apr 2024 08:08:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Thu, 25 Apr 2024 08:08:40 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 03:08:37 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>, <Alexander.Deucher@amd.com>
CC: <Xinmei.Huang@amd.com>, <oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 7/8] cppc_acpi: print error message if CPPC is unsupported
Date: Thu, 25 Apr 2024 16:07:57 +0800
Message-ID: <b254f5d823cdd5dd380483425349aaf4aa6432c4.1714032153.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714032153.git.perry.yuan@amd.com>
References: <cover.1714032153.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|CY8PR12MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: 7642be05-70db-41cb-8144-08dc64feeb20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WZKuK0Vbu5uzJQcDttd467zDaPi71kSORbjfuFE9XRfQbGVcYU1EVPyZLsbE?=
 =?us-ascii?Q?ezElei2xWNJAmE8d3+yfom+RNxZaRIiqGXkpF35waGJvMcqVdRfUM94UYciz?=
 =?us-ascii?Q?H32uMEojimf9SFwYP1iQUiy/P2ozJHCBIQ8Oik8FS9IFSnacHvHSJCf3Taws?=
 =?us-ascii?Q?isG0f6eCQD9l12PZzl/L6jP/LD3avx1idSVCbOD02mbCpMKRS4r/F8sSyLsq?=
 =?us-ascii?Q?hygatg9ecKwnDP/1Ed+4MyDtsKLKFHvglzUoh25YWIx9i4ZakSuLNN9iqFBQ?=
 =?us-ascii?Q?w2m1QSdn/0IBw3XtDQACwWg1aY5/chwmoCsIF/hz5ahG3kGgBA4JIY0lczY1?=
 =?us-ascii?Q?N3UEftANtqks7Zg2RV4rjTDOamLqPrGkg6qnf+CrDvCSPmL3/75XHAtw9amH?=
 =?us-ascii?Q?vN7spVlorUcXc04MnmxLKxDg/6k6a8Zc4+PtU7XI1dbisG6kEvG3+wnINpfi?=
 =?us-ascii?Q?qRDPPCkmT8sAl+OcFtc7CY4bey5Habyvg1zzADeeOqnVwd+sKnvsaRYCpJ+2?=
 =?us-ascii?Q?4HzVSMxOrZqYsK+JkAvS1ELYmktWyFGUoLxg3TLkF+mCi/Qy3iGCnG0QoUsD?=
 =?us-ascii?Q?wyipt32CjHtIDXlNwAnw+gTTVsxepeLddhI/C9Om1A3WEMI5GfQI/o8zlpwL?=
 =?us-ascii?Q?526UkqicUNsfnWCYAUKYfYw87JFZ4y/7bOSoJktFIIiQkOKEVv2V7YwL27os?=
 =?us-ascii?Q?IPbV10+27Y8NyQCZQcVGKvyHMI5OptbesAOvgVHgF4Sr5qy7KJt8FGCKLpwb?=
 =?us-ascii?Q?t5J5NdqAkFxDYiloPVuEqb1f2m0XnULB9sJIWzGpOib+tEpn1TDD6faHSu+v?=
 =?us-ascii?Q?lzFfIT7u+16AI39NGT3GozdPlR5ZHkJtHM+3YL/YS8w7WYenRKBGw8pE/Qvx?=
 =?us-ascii?Q?RMDmpMl1ByDzDzKHhJihMhUsLPPAVgCTjOd3UZKBrnvUeGhUMj+m1trpJucX?=
 =?us-ascii?Q?6vlhTarGyelH2aLEgXpojRpLZF/aBvcAA4JFsBY+kOwDKEG099Q3kPETYdWk?=
 =?us-ascii?Q?qyDUTjNq1KljKc3BjXMulChUi/lFUp8pWiZD2IgDP/Ys6+raq6+HW5BnI8ce?=
 =?us-ascii?Q?IowIH4hH+gvxtlOqapTaq/M2P1T/a+jJvREfAZgEVMnUxF4q2h3JOu1hsFeo?=
 =?us-ascii?Q?GAJKXZyTkrPJvVJMPmwkEHv5PIilzdZtAqtceI6E5ezFTcnjitsZ9bMUAzoS?=
 =?us-ascii?Q?s3J5m9Mju9iRFbnhVyNBNhl3Q5m8n0A88VmvfBqMHcbtjRRU9N9UTN7oyB7j?=
 =?us-ascii?Q?pyKmIz606IMFGD6ECdbWBjiv4/qZ0YnahrjmQ8CS5rGK00eNEmy7si6nANUP?=
 =?us-ascii?Q?E3Nh6+1YtQC7G78EeNvEuAdwv+VTJaO7Xr4mgBNHO2NC1JD/WJKMbnJbBoI6?=
 =?us-ascii?Q?vn1bld2YZplbiMfDwM2dEHm9lyKG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 08:08:40.8389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7642be05-70db-41cb-8144-08dc64feeb20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7170

The amd-pstate driver can fail when _CPC objects are not supported by
the CPU. However, the current error message is ambiguous (see below) and
there is no clear way for attributing the failure of the amd-pstate
driver to the lack of CPPC support.

[    0.477523] amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled

Fix this by adding an debug message to notify the user if the amd-pstate
driver failed to load due to CPPC not be supported by the CPU

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
---
 drivers/acpi/cppc_acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a40b6f3946ef..1d857978f5f4 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -686,8 +686,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
 	if (!osc_sb_cppc2_support_acked) {
 		pr_debug("CPPC v2 _OSC not acked\n");
-		if (!cpc_supported_by_cpu())
+		if (!cpc_supported_by_cpu()) {
+			pr_debug("CPPC is not supported by the CPU\n");
 			return -ENODEV;
+		}
 	}
 
 	/* Parse the ACPI _CPC table for this CPU. */
-- 
2.34.1


