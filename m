Return-Path: <linux-kernel+bounces-43962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F194F841BA4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225DC1C25160
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 05:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7673CF64;
	Tue, 30 Jan 2024 05:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QoWHv3yQ"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F19938DEF;
	Tue, 30 Jan 2024 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706594224; cv=fail; b=KoEkuPeLL59bJncvtGffzAfXkoB0A/n8qiVh5tBSoKoq6c/rFdCMt8KByo1Opu1m0xYkjW+jCn4I3ivr6VdpxKMJ3Zp1MMl/Wy2NXhO1AHG4NtTJdYS792VbHzFFH0DuJYbCM8jHneAkqR9s1p1Xk5lw0PQtd+fiiLLhk0Oen5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706594224; c=relaxed/simple;
	bh=UCGdGPe9jdOw+7qgjNLQd/iLNNFxxkVEm66mfL2pPaY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWGi4YBpX/dOAHfpunGz2fJsl3wDx3dN14f/N7aAhZb7b8q4k1QHq8RJBwVSzgjJYue7lTskUksb4PiCoC4kISg94Qi2oQFqr5RjoNBg3wXLk01uVHHIt1symai2yJxNe46+dxy4vQ7aDRdMe6n1Z/Db6B8M1QP5ioC/0qgQJO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QoWHv3yQ; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hzbo/RIgbcRGxlYYoajSvf3ZZwYqj/9eFWDbLfVbW19fSCgzBpRcswoxbeRqnKKVWi00qGiOO6SyP29eBLJ3zgNOA7U4hgZV36XlhxBd9nBo9t2xE9iGMFyrEkzK9Qysv5yBNc74MxFQ9F3zgxUwy0ddrWtXXuW0IZPtYY2Dh9M3sg7uiaGOHqJcB0JTu/bJX0ClCkNoFUW9y3DyVku85q37uNfoOR1wc8yuWftV3gPs0fzHUtYHGRgex1dtqK3dWjFIJfgKJ0QrOdcsZ02PDlxkBdvzGPFk9zgRMtilhXwuFChWlURcUwkveh+XU1BgK3pi2UVK/3ccDTWA5VbfkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49fLhi/NRv3PdyX0LrMee0uf/A4mAPmq1nZZg5HYUDg=;
 b=R3MZ5LbfQoSf3p5NbGpGlHGll/mBeF4GMbCuOwhl4WjXtUzufwrdvMEdnlCwPE5e1eGXvT9spONWDTA7FzL5K0Fmya8eGOEFcqRkn1nPYgUgVKEEm7OLcKrGI3BXGl9gv9Tf8BhaxZEZdaqRSeOWAHOaeIgIaSkUcnlg8ki7nY5P4/qMQ14q6MPk51ruaq22PS8szNYaC/U3dg15F1qGRQ6mgswYZC1hPfLwpVmxlfczLgEl7Vu6ypnw3sFav5pJtYvHJngUSa5pVOQJJJeSMzCR4/wHAWv2QjdkQA46TXGvWeEQWjOvMrPhHhHOiamG098WqYmNz5Vr910jeXOKZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49fLhi/NRv3PdyX0LrMee0uf/A4mAPmq1nZZg5HYUDg=;
 b=QoWHv3yQwwGkYnimf8iUjXEWVPaueZ2Pf2kLQT3fS32d8RDskpMuzeGhulxJ75K2enBLep+odevrwwdrgQHpQ3RiPBuccpJbpor9WYGqxY+f5P9Mg3lLTSTpfpLN3HKbzOUAzQu9SYYAjjldw1BuicsIR08FdYrCzYUpUZcQc4E=
Received: from DM6PR04CA0019.namprd04.prod.outlook.com (2603:10b6:5:334::24)
 by DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 05:56:59 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::b2) by DM6PR04CA0019.outlook.office365.com
 (2603:10b6:5:334::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 05:56:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 05:56:59 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 29 Jan 2024 23:56:55 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<Borislav.Petkov@amd.com>, <viresh.kumar@linaro.org>, <Ray.Huang@amd.com>,
	<gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH Resend 3/8] tools/power x86_energy_perf_policy: rename get_msr() and put_msr() with intel prefix
Date: Tue, 30 Jan 2024 13:56:27 +0800
Message-ID: <2fbfce6d4f39f5fb64e95a2f36641f109f2c1613.1706592301.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706592301.git.perry.yuan@amd.com>
References: <cover.1706592301.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|DM4PR12MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 78262ea9-38c6-415d-9226-08dc215845e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jQsjrHOoaSSGrQEhWC6606ou6ihfGxeM8XYOD0mkd/nT8haI/kKtAFm/wo4xu/OW/I+d4773jNY6fuF8djPOWjEtfCJcL11qsnIJqadEE8mcU3/sz9aZTj0uAu4mrRcy4uA1jsMwGjSpftE80hASrvUTMTj6fIICvV9DKHIf7R+Ue0ICJ5XfYUGQ32+PsvrmNAzeppRKKYkKGMDyIXo3r4FEWSbxjG9clKS7T5WETk6W8CjEcULzWAJPgR2LzJLRoS4sOMBwzZVmZCSE4AFWbldyTen6w6wTtLJ/hljn57q8I+LueVC9HD6xKpkVrvrGZH+sZ3F65tlFvBSRHKH6sXQ7VtwS2wp5WXH7Cu7pOQzK71fe2K4p62vg0+9EbM6rJqO2PoVoYyfODozRwMy/80MVgR8EobiBIGch4c4GRxkECzEboAlWgXqC+BJ+hUEDECAqSSfcbzAwKP7UlPi6rnb+TGqHWIOsp8l5X/KAXfgFVueBP/qVVtccOtXtS3imbNrOgx3qkcOelHIP81V69zOemMKZ4LOHv0ptrtPJC7bqSq83BPN42NBYDl39cBFJp3htvYsPEEUaFQPmimUPDD5uu2dyFh1+lS0bmcrHVa+VE59995v23SfMmy4klKmz4bZEMcd6k+k8S1KPvtVJbbAyTEnl3uth+wQO2IrZGYriF/z496gt3IfCBKCai55nASLBJEEihtfd8bVM5Bt/E6oesAJxm2OUntLCDXnIUKxH23IqWk84HYoMFOHDCenhf65JN2eHDjv+Rxlqhh1qEg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(36860700001)(47076005)(41300700001)(36756003)(86362001)(356005)(82740400003)(81166007)(6666004)(4326008)(7696005)(8676002)(6636002)(316002)(478600001)(8936002)(110136005)(426003)(336012)(70206006)(70586007)(54906003)(16526019)(5660300002)(26005)(83380400001)(2906002)(2616005)(44832011)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 05:56:59.2473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78262ea9-38c6-415d-9226-08dc215845e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648

From: Perry Yuan <Perry.Yuan@amd.com>

Rename the get_msr() and put_msr() function with Intel prefix,that will
better help to differentiate with other processor msr operation.

No functional impact.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Suggested-by: Fontenot Nathan <Nathan.Fontenot@amd.com>
---
 .../x86_energy_perf_policy.c                  | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index da9087873915..3f09c12f24fa 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -679,7 +679,7 @@ void err_on_hypervisor(void)
 		    "not supported on this virtual machine");
 }
 
-int get_msr(int cpu, int offset, unsigned long long *msr)
+int intel_get_msr(int cpu, int offset, unsigned long long *msr)
 {
 	int retval;
 	char pathname[32];
@@ -697,13 +697,13 @@ int get_msr(int cpu, int offset, unsigned long long *msr)
 	}
 
 	if (debug > 1)
-		fprintf(stderr, "get_msr(cpu%d, 0x%X, 0x%llX)\n", cpu, offset, *msr);
+		fprintf(stderr, "intel_get_msr(cpu%d, 0x%X, 0x%llX)\n", cpu, offset, *msr);
 
 	close(fd);
 	return 0;
 }
 
-int put_msr(int cpu, int offset, unsigned long long new_msr)
+int intel_put_msr(int cpu, int offset, unsigned long long new_msr)
 {
 	char pathname[32];
 	int retval;
@@ -721,7 +721,7 @@ int put_msr(int cpu, int offset, unsigned long long new_msr)
 	close(fd);
 
 	if (debug > 1)
-		fprintf(stderr, "put_msr(cpu%d, 0x%X, 0x%llX)\n", cpu, offset, new_msr);
+		fprintf(stderr, "intel_put_msr(cpu%d, 0x%X, 0x%llX)\n", cpu, offset, new_msr);
 
 	return 0;
 }
@@ -829,7 +829,7 @@ void read_hwp_cap(int cpu, struct msr_hwp_cap *cap, unsigned int msr_offset)
 	int ret;
 
 	if (genuine_intel) {
-		get_msr(cpu, msr_offset, &msr);
+		intel_get_msr(cpu, msr_offset, &msr);
 		cap->highest = msr_perf_2_ratio(HWP_HIGHEST_PERF(msr));
 		cap->guaranteed = msr_perf_2_ratio(HWP_GUARANTEED_PERF(msr));
 		cap->efficient = msr_perf_2_ratio(HWP_MOSTEFFICIENT_PERF(msr));
@@ -872,7 +872,7 @@ void read_hwp_request(int cpu, struct msr_hwp_request *hwp_req, unsigned int msr
 	int ret;
 
 	if (genuine_intel) {
-		get_msr(cpu, msr_offset, &msr);
+		intel_get_msr(cpu, msr_offset, &msr);
 
 		hwp_req->hwp_min = msr_perf_2_ratio((((msr) >> 0) & 0xff));
 		hwp_req->hwp_max = msr_perf_2_ratio((((msr) >> 8) & 0xff));
@@ -909,7 +909,7 @@ void write_hwp_request(int cpu, struct msr_hwp_request *hwp_req, unsigned int ms
 		msr |= HWP_ENERGY_PERF_PREFERENCE(hwp_req->hwp_epp);
 		msr |= HWP_ACTIVITY_WINDOW(hwp_req->hwp_window);
 		msr |= HWP_PACKAGE_CONTROL(hwp_req->hwp_use_pkg);
-		put_msr(cpu, msr_offset, msr);
+		intel_put_msr(cpu, msr_offset, msr);
 	} else if (authentic_amd) {
 		/* AMD EPP need to set desired perf with zero */
 		hwp_req->hwp_desired = 0;
@@ -1011,14 +1011,14 @@ int print_pkg_msrs(int pkg)
 	print_hwp_request_pkg(pkg, &req, "");
 
 	if (has_hwp_notify) {
-		get_msr(first_cpu_in_pkg[pkg], MSR_HWP_INTERRUPT, &msr);
+		intel_get_msr(first_cpu_in_pkg[pkg], MSR_HWP_INTERRUPT, &msr);
 		fprintf(stderr,
 		"pkg%d: MSR_HWP_INTERRUPT: 0x%08llx (Excursion_Min-%sabled, Guaranteed_Perf_Change-%sabled)\n",
 		pkg, msr,
 		((msr) & 0x2) ? "EN" : "Dis",
 		((msr) & 0x1) ? "EN" : "Dis");
 	}
-	get_msr(first_cpu_in_pkg[pkg], MSR_HWP_STATUS, &msr);
+	intel_get_msr(first_cpu_in_pkg[pkg], MSR_HWP_STATUS, &msr);
 	fprintf(stderr,
 		"pkg%d: MSR_HWP_STATUS: 0x%08llx (%sExcursion_Min, %sGuaranteed_Perf_Change)\n",
 		pkg, msr,
@@ -1274,8 +1274,8 @@ int enable_hwp_on_cpu(int cpu)
 	int ret;
 
 	if (genuine_intel) {
-		get_msr(cpu, MSR_PM_ENABLE, &msr);
-		put_msr(cpu, MSR_PM_ENABLE, 1);
+		intel_get_msr(cpu, MSR_PM_ENABLE, &msr);
+		intel_put_msr(cpu, MSR_PM_ENABLE, 1);
 	} else if (authentic_amd) {
 		ret = amd_get_msr(cpu, MSR_AMD_CPPC_ENABLE, (unsigned long *)(&msr));
 		if (ret < 0)
@@ -1312,14 +1312,14 @@ int update_cpu_msrs(int cpu)
 	if (update_turbo) {
 		int turbo_is_present_and_disabled;
 
-		get_msr(cpu, MSR_IA32_MISC_ENABLE, &msr);
+		intel_get_msr(cpu, MSR_IA32_MISC_ENABLE, &msr);
 
 		turbo_is_present_and_disabled = ((msr & MSR_IA32_MISC_ENABLE_TURBO_DISABLE) != 0);
 
 		if (turbo_update_value == 1)	{
 			if (turbo_is_present_and_disabled) {
 				msr &= ~MSR_IA32_MISC_ENABLE_TURBO_DISABLE;
-				put_msr(cpu, MSR_IA32_MISC_ENABLE, msr);
+				intel_put_msr(cpu, MSR_IA32_MISC_ENABLE, msr);
 				if (verbose)
 					printf("cpu%d: turbo ENABLE\n", cpu);
 			}
@@ -1330,7 +1330,7 @@ int update_cpu_msrs(int cpu)
 			 * but cpu may be in a different package, so we always write.
 			 */
 			msr |= MSR_IA32_MISC_ENABLE_TURBO_DISABLE;
-			put_msr(cpu, MSR_IA32_MISC_ENABLE, msr);
+			intel_put_msr(cpu, MSR_IA32_MISC_ENABLE, msr);
 			if (verbose)
 				printf("cpu%d: turbo DISABLE\n", cpu);
 		}
@@ -1455,7 +1455,7 @@ void verify_hwp_is_enabled(void)
 
 	/* MSR_PM_ENABLE[1] == 1 if HWP is enabled and MSRs visible */
 	if (genuine_intel)
-		get_msr(base_cpu, MSR_PM_ENABLE, &msr);
+		intel_get_msr(base_cpu, MSR_PM_ENABLE, &msr);
 	else if (authentic_amd) {
 		ret = amd_get_msr(base_cpu, MSR_AMD_CPPC_ENABLE, (unsigned long *)(&msr));
 		if (ret < 0)
@@ -1561,7 +1561,7 @@ void early_cpuid(void)
 		if (model == 0x4F) {
 			unsigned long long msr;
 
-			get_msr(base_cpu, MSR_TURBO_RATIO_LIMIT, &msr);
+			intel_get_msr(base_cpu, MSR_TURBO_RATIO_LIMIT, &msr);
 
 			bdx_highest_ratio = msr & 0xFF;
 		}
-- 
2.34.1


