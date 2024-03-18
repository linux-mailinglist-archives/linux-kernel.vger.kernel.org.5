Return-Path: <linux-kernel+bounces-105972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3AB87E6FD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218811F22307
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A6B3E480;
	Mon, 18 Mar 2024 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OFMf/xoJ"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE4D3CF4F;
	Mon, 18 Mar 2024 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756714; cv=fail; b=gq0nXnxfK8+RJIJfWb5XcJHutLwlp3dxi66mnvu+8Z9YPyhBv/Bz4dviZCGEiKm6p9QuJjIBP+2jLSjJYN0zzcdVJNQTzvxQiTyeHLL7sAA1UtjrFw1S/Sc+bXXnlieN/hwIa98GnItOMFIAZZ5p1MJXxfJg8SooJGefgdLvjaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756714; c=relaxed/simple;
	bh=W+dCh9C8EntywcvXhSubkaBnZJJuzKjsF7idcfLgto4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDbuPK7c0SA7NTcgq+JJUprTvq1PCd9r62ev+9f68sFC01ew10dXEscvrkMRFlJVFGDWYBCIz38afDZXqaQp6EI6pPdOMkd6KY/IOuuVMmmfpv/tF+E1YX9ao79Dirr0GZHXWVfCkYb+9gDGMZPx9OKCPHtgBhGn9TQj+H78Maw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OFMf/xoJ; arc=fail smtp.client-ip=40.107.96.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoMaU+oD6EqVX3wLO0MeAKadS9i0GRNpNe21Ob9NmTbGzguIuIXV9mlc/+Qbk9ikSiB+2r2Kf+0PDo+llE2KCtRyTXt2GpvNvVO26yF81FpBD34NJ5c9f2nBP6+PAJYVTEcrYR0DrU36CBDrEI0uUYqvU/ceTaiwBdmgv0Xh9ymeKA76tc2HagyycEDlYnXcAHUN5B8EufhgRr0+Lyfsil3ALZqYzuzkruaXTnxPM2Z7P0yIeA9A3KrYODAkht3O48jL2zQPz1sCpSAyjPSe1ws3DUYX63eyefEuJ1n82+wfU5pgYyPZBPhIXSnv89pUK/NIg3T9W47wcPxUpT2mNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8EDLYk3NSyioGPjxU+pIEAuL4I7f4cRvkuByN872I4=;
 b=jXsF9maqbZlFcik6+dZK4PCT7S67SPp4WAOcQ1JsgRC89gNbeta1Lw4oGr7t1pitIGrZUKvMP3P1gxSGkEpapUPJvnhbnUPPF0pMXNa9DpSb3ZHaas8GS1mvSbqPad7NKFcrVqT4qtb7cS8fU4oCytIbXv3wUrzXvsD1s85M3U3ChD8ls9bPpE/oEDErdmp+43oqlHJckvYPX6JSrcyMaU5cdZFLcNTA75qcFbEkT8KVOORoYTcWFPHcd4Qo8P58GZx02YpVSZ/rWFXaeEZ6xdtK0SAQRVcH2vqzN/oX4PBjBcZy9DZKot5ReH2YsgqClkL2cGBmV+2Hxxa6fM/wiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8EDLYk3NSyioGPjxU+pIEAuL4I7f4cRvkuByN872I4=;
 b=OFMf/xoJ+zE3a0QeUiiamITwLJwwHLF2RYPj6GEGSiS1kv0LhEhkdJRxrjCQ1H3obPTqAWEfPE+1XOqsZaR9pecdjdaZcUMZ3M7X5A6oM9UE/ATgvX70eomfuI9rjX5TT6AGTYHAQB6gSnZlZSRVYQD1H+7/dVsccQmYEJft2OI=
Received: from DM6PR18CA0024.namprd18.prod.outlook.com (2603:10b6:5:15b::37)
 by SN7PR12MB8819.namprd12.prod.outlook.com (2603:10b6:806:32a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 10:11:50 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::cf) by DM6PR18CA0024.outlook.office365.com
 (2603:10b6:5:15b::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 10:11:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 10:11:50 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 05:11:47 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 6/6] cpufreq: amd-pstate-ut: support new cpb boost control interface
Date: Mon, 18 Mar 2024 18:11:13 +0800
Message-ID: <f5253f94e60b03fcec15e3338d9fa9581eeadf11.1710754236.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710754236.git.perry.yuan@amd.com>
References: <cover.1710754236.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|SN7PR12MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: e0991a4a-d80e-48fd-e593-08dc4733d3dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RI2ZaYE9JFPH1Y6Fq8Y0pXUXz9SGVBQfRl5VXMgCtdzIRScqFHbvNwf7rdKeKAwyudslHz8GJQtv1BjvAhjhG3SBvg8VjpX4KdP/0JKuI52cVyEsFxgnErbchXVt9yaJvW/tPMhWKU5yc2kmvB2MP/apliKP5vgtgJExWmcKuhRL/qeKBtJbV4txdBoWiHOBLLVYx39nK367Bdpx/bdDD3bT3DtEoj3MDzWox7NxQ8Snn/r55GWFk33/+o6orl82akct3VUN1xwBAzXcA9o+Xb8miWeO4Whc55g+Qdtl7ofmCCEPs0HAt6coJObswjQAisU5rQylNsXetM/5FXfvY3ooXpF8i8OdikOe7EU1mqqrekBJsSAC0Io6lMkFKv5mbdIAAIJk6EnhU898a21YgaO8XN7C8yVTKj8gfQuS/zBrx8eo3K4FtcXsbDH3+Azue9q6+HaIzTvZ1OZXESoZLvoV9INJ80h1YD2jWTMDzqYZYzhsgrdHVyU7ZzZ0D/56qntqVuYxps7m8dGm3T7NnTbVL4jY6JVauLJFrsnBZc38mqKtRdvvSkAsUNhCwEjao4DgWLenTsYxOB9bV/QJR5wa0w3isLnxWbmASltwVR5y31h6ORbO11XATzAuQqoDm3+GFmC+krm1UzmW2svPUdb/KavvFdchaSGzhE0t5BkoixD4fGfwOCgFI5ZYOB9AvPZzSksPDnSZN13bmN2tjLxZqQL1wXw2KC5Swg5QHUOdmWs1gKVmEM+eV2G4uv40
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 10:11:50.2047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0991a4a-d80e-48fd-e593-08dc4733d3dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8819

As the new CPB boost control is enabled, pstate unit test needs to remove
legacy `boost_supported` check and start to use new CPB boost control
interface `amd_pstate_global_params.cpb_boost`.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index f04ae67dda37..b3601b0e6dd3 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -226,7 +226,7 @@ static void amd_pstate_ut_check_freq(u32 index)
 			goto skip_test;
 		}
 
-		if (cpudata->boost_supported) {
+		if (amd_pstate_global_params.cpb_boost) {
 			if ((policy->max == cpudata->max_freq) ||
 					(policy->max == cpudata->nominal_freq))
 				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
-- 
2.34.1


