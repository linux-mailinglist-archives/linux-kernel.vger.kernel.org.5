Return-Path: <linux-kernel+bounces-104030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D57987C80E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE458B22AC1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A0CDF71;
	Fri, 15 Mar 2024 03:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xY7nkBbt"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28311755A;
	Fri, 15 Mar 2024 03:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710473991; cv=fail; b=ZY2BaLIb/j0J8by3rauhOB9fuUkdn5AiiY7uJyvTrBXlK9gMuBITQaOiBlqGid+ODuNDDIXtFjnnIeRRIhKuAOeKNqZidwHTEZscsKP6g0Y/ww6EQu6SEQEJYwh9eS7RnhklxyoHQWmeBMeFdetpgK5WOhxBtV5/VaVM9oEzZ+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710473991; c=relaxed/simple;
	bh=W+dCh9C8EntywcvXhSubkaBnZJJuzKjsF7idcfLgto4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQEDOuAyDTzOpcvGvmSHGoQSBs7l8/59OtJ5CoSkzT5oXzjrg3KzULQeUVT353nNetfgp+KZUjloZ/a1Zns3HZE3mbVB8nHWoooWlofqXqpkhWElnGtQVj5FFXQ/kEb6JFXNHDtnfgBylacrdp0eZnm/BoUHeqgUEphonWNj3yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xY7nkBbt; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjGqa68fjT+noMe9xV5mPbvkLjq+ib3cmtnSeaC+qS55H4ilGnYVwDfikV5YYHHbYGFwwEtjmfPa9Vrfv9QNG8dInA6iID6yt5Wp4EiUGc1z7sMVP/A2/v57PN08Habc+J8Z2oTmEnZ70f0tBJl58UkD5WNswvfuDkEeqvjlZKLtvaWNFwzrA9T4dRB3z3ArcbAzcmymKuPcXJDIiDNPDSUsxDvTIBDLNYFAVD+doCk6rDUBiFAcM09fJTsWlG2+qZDhD84lqkKPH08qMKuk+/a9+b5RO5XAB/kCLqhSOnAjGMFuuZyXof/CAGciT/hNYuqG55DmBqdfXuM5tDiuxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8EDLYk3NSyioGPjxU+pIEAuL4I7f4cRvkuByN872I4=;
 b=JdtcCMhNvtXvr2gFYQefVLoeS+7KHIXJ/Su5mJ8ujP6z7+tdFEnjMlbL+rN92NUnLrexSKnriEWMuZNhhbFPz7+8frnplPMX8Hsc+MLk+OA/3d60QGyikWsMtSLP7pTR+swc+6l+eOl4FPn5VVwCbV791xEA5Vhk3rqT3OAh1l6O8KL0otbeWMnTi1pEUuvMhzxTNqOscnjauD20UnKW6Xtxi7pLTJZPTE9rd2lIsJDBeRmk/v9dNJZIr8vUyc7bfdVZi8HWJ7vh+RouaSVnlYk6xynCuO6UG+6RhfuxRNx3/Hy75SaLDp19w2j5gdrsjRwxPWFcuGz8jNketXkhQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8EDLYk3NSyioGPjxU+pIEAuL4I7f4cRvkuByN872I4=;
 b=xY7nkBbtbWOdw0N2Uxovag6/gdxUnN54kFpmh6fFl8VTuvaWRH3i+dVqK6XVXeCgXaPMq9Hmxqvd2jYYVBXUNCBhVOCwZvPG/LvL8HMxB6nTCx7nuSxqZJCBRZJIiRN5B7tJxZxrMX3Dm1mJDHtG3hT+F5qXQW6w+Y/7ym+ZNh0=
Received: from CH0P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::7) by
 PH7PR12MB5759.namprd12.prod.outlook.com (2603:10b6:510:1d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 03:39:45 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::7f) by CH0P220CA0028.outlook.office365.com
 (2603:10b6:610:ef::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Fri, 15 Mar 2024 03:39:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 03:39:45 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 22:39:40 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 8/8] cpufreq: amd-pstate-ut: support new cpb boost control interface
Date: Fri, 15 Mar 2024 11:38:09 +0800
Message-ID: <2ea6bff923bc440b63140388b1a9ec01417d1b40.1710473712.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710473712.git.perry.yuan@amd.com>
References: <cover.1710473712.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|PH7PR12MB5759:EE_
X-MS-Office365-Filtering-Correlation-Id: dfb98b1c-2434-49ca-2078-08dc44a18e90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oKesXTYHR5czBXC4Joqd1NgYffy0/JJE55PUmXo3Hx1ycOdGEeBofTFhoivix66dU+u2Xv4m3UrltrSnUQFm6/7fVDh0n3RlrCQsg6B22DfGeMJsNa1TsqzNGmqhJ9tfq9TAQAgeHsb/4nPtyYVqMm+6z3KU/njg/gqCItGh0zcrldNcNbJdwL2IO50dNXP5zeKyb44GFge2DN3BANv70iOHyYUlUqq4ihio9OvHCn/FnhxUwe2oHoySMSeiToaJB18GIdzcv65ZsaX7ILuqhJsGc1mSzYBbD1QJq2byIuxjtzceZhNfmOponr9iIU0euzRCyoiQJkOBBjg2lBPOD9dkL5MGb5MCb2GRoiDFqGSf0AH8ObL1j+10/6xjG1ODNAZtGdkRO7/A40URC4+gCOQfj/VU/SyPuRgbr73deIhsScxU4Z5hHTdH4GGVrh4R+UmMzD/zSfKJLnxihuVRD+Z6SzhhFm+t7eIIjmsa9C+ZNmpeLYadGWo5vQjKFkwKNkfpz99VDuMoWs0GJT0Bjt67gZ8H7avWyrorOikGiFO67YRcUqIPBzxxusH+Ge8RdiAJcKndmkg9WO9tF7poT46bthdxqKjvXt5kpfkpIu9WR4ImG/nIauyPvqTpamHscw8uyeQQ48whUFJC55RCgnc/DC+XPR69J3JIA+Pp5CuK4V5Pjk4yRA/z6LQFhIeN94SXm4SZJMBxQJ+kWbC/iCNpzinZjftvsPh53SeFbvsUdFxuPo6nTTJz7TlV6fok
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 03:39:45.1532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb98b1c-2434-49ca-2078-08dc44a18e90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5759

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


