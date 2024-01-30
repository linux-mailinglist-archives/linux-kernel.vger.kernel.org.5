Return-Path: <linux-kernel+bounces-43881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD7C841A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4311EB2340F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1683770C;
	Tue, 30 Jan 2024 03:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iFc6oSiU"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C1B3717D;
	Tue, 30 Jan 2024 03:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584759; cv=fail; b=AhwWh3vj/AN5aYb33TnWwVL4JcM53xgizMUITe91BAn4mnIVBjqOfVOVaONYhWGnn3TC3yplR32cT1xCGweyAKdMH1eLT4GwmcCCeRYPV54mNykupUu/eXBKEtMYuNLHQbC3Orewn+/fBct3JFJC+1sxYN2UfbDTYzSaQvMdMYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584759; c=relaxed/simple;
	bh=UCGdGPe9jdOw+7qgjNLQd/iLNNFxxkVEm66mfL2pPaY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=acIDDiQWrITi73UAffr9K52QBMCAkr6eFlxgO3z2InnKAnM/WLlJ5FEbSIWWdj1qHZdoxjpO9Vr98AANgN/csqC3j/B0Kwjlvytffwp7+kAe1OoVkVgebVPDJRLhCDXvl/SYTXhBxgsg7qFfapbBN1cWyL0+BJTEAS3h0vSr5wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iFc6oSiU; arc=fail smtp.client-ip=40.107.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bP6ORW1HG1BxXazrT6sky+N+ClzWSjRpgwGkVs4oLJKZPyiJCiDpK6d8tyFR4odhSLXm0bZlT3HYbBUgDULsPQHbaTnjbiKt+1oUd0coFUco28h/Y9AX04/WU26Pn9b9nuDP/Ojimpi6TDqpLJwYh8uX6d5/jUPZHxxUFn7M/vevQ6yHne8j8z4dzRdCMWAB/ds+MvdKew5a6d6hoMeVtY3dk8kD2U7Pfy2LPeF4qK2YTXHsjb74+PNUMdRQg2RWg6xJK3YGnKGdoFBOxzVgrsnkvsZFB/nlIYWI/zJGTTrdDI7dax5Ey5dx/PIS3FJWEKb+PJQ8PqBsEc+Du18r+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49fLhi/NRv3PdyX0LrMee0uf/A4mAPmq1nZZg5HYUDg=;
 b=bEMFC0+Gx5EbhZ4y1Eq0astRIRxiKeZ36KkKinByXU/lk6n8N2OldMnHQz1OV5Y536p8XSlSEAw6G8ExTOhpININftVApBsf6IkPkzxRNTZ5Tl5q/xvX5qBXgAeNPZ97PvpUd8DCsDgqv7ZfJC6HhcQQ/3VT3OG1b4bx70qXgWFia7jmVgr7nGGmsNFh+Izg/S33wkWGSeLWxB8LepciCWoNJTQW3ulTVt29JmofL+jdBgCvPpNlnHJYrNbeWvwENa4cS0aSFivOkfXi2FEYfKvQ71oqwMcn9CmmL0flRD0EhTllLiySW8Y4yco8m9ttaE4vMPtqfc7XpucCnmM7PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49fLhi/NRv3PdyX0LrMee0uf/A4mAPmq1nZZg5HYUDg=;
 b=iFc6oSiUQfoD4ISNo5IzvRl3JNZ5G81jT/RBBgZggwiUAtNO+YYXC4FUMmpV6fkRAleu9dJn2u//bO5bT+XlUe7pY5I+q3j+NikXkdkiIggZPkYRRBNoyaK2I2iy898FlGWb7H0x/UHesyc8LJQpRORBHqOBr9+TfkWq9NJB+Ok=
Received: from DS7PR05CA0026.namprd05.prod.outlook.com (2603:10b6:5:3b9::31)
 by BL1PR12MB5109.namprd12.prod.outlook.com (2603:10b6:208:309::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 03:19:13 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::ed) by DS7PR05CA0026.outlook.office365.com
 (2603:10b6:5:3b9::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.21 via Frontend
 Transport; Tue, 30 Jan 2024 03:19:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 03:19:12 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 29 Jan 2024 21:19:08 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<Borislav.Petkov@amd.com>, <viresh.kumar@linaro.org>, <Ray.Huang@amd.com>,
	<gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 3/8] tools/power x86_energy_perf_policy: rename get_msr() and put_msr() with intel prefix
Date: Tue, 30 Jan 2024 11:18:31 +0800
Message-ID: <03a45b3d1b5969f8c86ac40297be96228cb21392.1706583551.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706583551.git.perry.yuan@amd.com>
References: <cover.1706583551.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|BL1PR12MB5109:EE_
X-MS-Office365-Filtering-Correlation-Id: 081564d1-049b-41c0-630d-08dc21423b78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pGYIoZX4r28G2rqcAmG+XPxDl3Wxd1BHl3ue7gQ7oawow4pOu9Xy5SsSq4PUyEjhcSrGYSq/g6g3/oCa1ITLheQiF91olX3M3zFE7n9ami3nJb7qsq9w2Y3C4cyCKoqC8kkxWdO0yx/sXXNlBa/j8y9wApdWDcFehJsilg/eW5P+SOuHGottzHsHff4jTSJYD9x0uvJWJb+OCCKiQt8N5mldYq4bbz9RBvSDJgM8JEKJKJeAU/hVhltp6kjFnDHdrIFF8E/oxBTB9FychDaQCi2WBRWP1lKXJhHl8Z9Qrb04wRe+CR9pL7PAWI2fzxZxjbdod/lXyfElO/nUomznuCtof7lgT3AfPJ/fqjfq7UzD8MTscsJ4+OYYf90P/3JBAsFfH/WK6bgjrhqxj7BAq4QAKHirnWpfkU9T/0TLXmjJcUqN8T5bZjLc3AhJwRvHIqEHaG0NQoPwZYHdZaq9fmQlKYi76JpOJK4e77p7zuGABHimk+HcKkXF2937P6KQD+C5OnIUN8kLCSMZXr7TH3PqXNmJx0Ox2gcSd/yGBtPUgpxA5ytwYTexNOkup87RP4nUxBCCoiqV75ZVjfl3p7JPN1Gqz/UhAI53DwFmaQVcWsUhSijppQRJskvcuRBTlXAwfWGLJmod2tAbHPoD0uZ0BvjaDYcr5px5IlYrVikcGBobFQuHsPV3lwnu+03ZirlPIk4HEI+0sb/EcpC3kHf/5P7qVQsOgDvQ/fNND8yTezG1chYlFbEz7KUjy9cKTDE63XWD+fnduN1XVFEx2w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(1800799012)(82310400011)(64100799003)(451199024)(186009)(40470700004)(36840700001)(46966006)(82740400003)(8676002)(4326008)(81166007)(8936002)(110136005)(70586007)(54906003)(6636002)(70206006)(316002)(86362001)(36756003)(41300700001)(2906002)(44832011)(356005)(5660300002)(36860700001)(83380400001)(47076005)(40480700001)(40460700003)(7696005)(6666004)(26005)(16526019)(478600001)(336012)(2616005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 03:19:12.7977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 081564d1-049b-41c0-630d-08dc21423b78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5109

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


