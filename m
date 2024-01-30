Return-Path: <linux-kernel+bounces-43880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EBF841A58
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9724F1F27D3E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F562376F1;
	Tue, 30 Jan 2024 03:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o6U53Y2H"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA8A33CCF;
	Tue, 30 Jan 2024 03:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584758; cv=fail; b=pDyce7oXXQVfPMZLBPWH2mVJ0z4rpUV445Ho2xSf0m3t/niMXPSTz+vTUMOUaMjbgVMphcCYkKg44xfbFN9sz5rTLrZSDQ9+fAw4+jFWaMbmaIJwJnTrU7T0wij9Gw1b+evdmTTOneKll58WNwBt+jGDYn4ojySKsxgvHMdxVws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584758; c=relaxed/simple;
	bh=0G893uXq6j8C35Bu9LEWfW3UuxUFjqrvGD2c9z7oHsE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjAGGQlaMojPvOHO0zcKnQHbFw15GjnVKVEPm2t65mQFNRCdVqI4oF8qrLIoRjDwR9OIer0K0i4yCmmEsZkXO2xYOlxeH2LAvCM+LuDsDPaWqeFkew3rPHz7y3fY6734xSqRzvxKrX4jLeoIkknLpLNglB2Pel2VqOzrnFE+1N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o6U53Y2H; arc=fail smtp.client-ip=40.107.212.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDOn3+3CsVUuDe3mlqRJ+zDm7pr+9jLpyJMbmm0OrzevhKYidsLJlmZZGRddMNMZp49aFJk7UYq5yuTYNO8TRjSjao/8BFnn+nMDUYkhK/Ej6Rjyse5XoWQ9b3LAtcMIeqNE4YH2DQM+PfBZUMKKY2UTC5fcqgkiG+TCw9WhVIOLkIaMgLn9OHgfeTZWGlo5mFaAoCuBON+1omp3abWlDDpjT6eE70UBb1EgqEdpe7bM8erR8F/+mjfVLKNgrq0FRFlT97RLZcygoCbG7UCPbLMcqR33K9NfmLqIO880+zl3bTUXghNUhR0A7XtPrhj9u5TfNd0AghmKGTEAkZQ/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=El7iS3nTWLyttkc/AHd0Q5tO2IGNevZrBoWvB0GxErs=;
 b=irIIxqt9Zka2GsVbMYoHy2GZ3dYkaYt1a96rVA7pllznCUwzog9QLpKXEmftE7EbkxvLKcmyZQVXguuPa2zGchQ6nag1x8C3JBmmojWIgtj9DsN5fx8SkXeGzW021S5VA8zOX//V4dWvBdKSQ0UaBLh9/7QITiAf74789F6W0hk9UpwMRl7IbTuYw99n+Bb++6bjwJJxdKKH/h47cC4jZAzXbALLC6D4fJSKF5W0DkbdV0uPbUbeBDixaQJ35qFKpNdxX9NImLJ5Njz19mXiSE/QzBXYxW9s9sP441rGMPd4eZp3XLdGCK5GDJZfSpF/x70/eIiTZpTQtjHdZW4s6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=El7iS3nTWLyttkc/AHd0Q5tO2IGNevZrBoWvB0GxErs=;
 b=o6U53Y2HMV+0inYZRrEQ9P9qDfBQW5WRDyA5ndZqMYqXu2JoEaxITNnAqscYd470BgaOYhrY+SSoZjuD5iBXPLwuSLhBZYWHcajxCUDZ2Jpe+Lz4vmCPhL1tN93OKX01k2llKBXTOho6TcujWQnIsDNCZSTMy6dseShy4vknang=
Received: from DS7PR05CA0001.namprd05.prod.outlook.com (2603:10b6:5:3b9::6) by
 BL1PR12MB5351.namprd12.prod.outlook.com (2603:10b6:208:317::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 03:19:11 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::39) by DS7PR05CA0001.outlook.office365.com
 (2603:10b6:5:3b9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.20 via Frontend
 Transport; Tue, 30 Jan 2024 03:19:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 03:19:11 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 29 Jan 2024 21:19:03 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<Borislav.Petkov@amd.com>, <viresh.kumar@linaro.org>, <Ray.Huang@amd.com>,
	<gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 2/8] tools/power x86_energy_perf_policy: enable AMD pstate EPP profile switching on MSR based system
Date: Tue, 30 Jan 2024 11:18:30 +0800
Message-ID: <8572a009206244f4caae5a4c9db3c475cfacc289.1706583551.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|BL1PR12MB5351:EE_
X-MS-Office365-Filtering-Correlation-Id: 86626450-f4ee-491e-bc78-08dc21423a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aGCdvEf+JMgDOnEJj4xo6opCQrM3yByVlnOx2QvfHaLotKD8qx5atNqd7370x1w9gbUmL4Q2iqz5bbYfM3iiOYfOVF/p0C/bsRtY+41//I41uJJLRD8Judtv1ttYxP3YqA6sa1d9fnFOroY5R6ceUgqZKDhsLN9rFILoimpYaFhCRCIyGeiFWmoluDc1nn9LLgjUjpSGuDvC5P6DbWRe8xHMBYyz8Ck0LykEv0w0rSe1nKl1gBrAgYAisPXOW5KT59gsA7ctU4uh22ugcbBE2BIXwqJ+P8UWSNkL2+rV1uOLgXdEMMaDq2hdp2LH7UHvnXg02oHpel1Yt1ag0Ne68lGp+e3HV6Y8DjULXPOj2fC+npI4qrGexQ4rQX7RJQ603rKDu6ftdnMkki/mh/cFLyfJWVHuZMwc3TgADgvX12YpJbLSGECqLvhDhEPRxgXcYzxdsYyQpbvRMY46MkcpEsO66qWA6Wv8ZOqqbsKBlG8BHAVtgfl6J0GIXwmlVkGBMHEFmfKFgolKtOpnvVZXb99xnQM/2judNblD0Eb+sQR4PZyQdTVMTbYPbP35JfZ0Kq0/2DBOzoXf/lbUoI8XwYVYhwnDYmg80uU/JUSvJizJRJ7FNSfHlXu4KONaP6OWmtTWQnpGsuaOYtHvUFvJL/8LYUFBVDCq4qTstUK2pilfuQBKPbc1czyHdjyiykkCcTvn4oW9tzqrsq4fkUG+2Cv2uvChbi4uPPAsbeTDs7YslyK+iTekWdLOPWMXFrfrS0E4JdNpJ33SZ/0MtRjq4g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(2616005)(6666004)(7696005)(2906002)(5660300002)(16526019)(54906003)(4326008)(8676002)(110136005)(70586007)(336012)(44832011)(316002)(70206006)(26005)(426003)(8936002)(6636002)(36860700001)(47076005)(356005)(478600001)(81166007)(86362001)(82740400003)(83380400001)(41300700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 03:19:11.2821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86626450-f4ee-491e-bc78-08dc21423a8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5351

From: Perry Yuan <Perry.Yuan@amd.com>

x86_energy_perf_policy adds AMD EPP profiles switch support,the EPP
driver also has four EPP profiles implemented under power
firmware autonomous mode.
(performance, balance-performance, balance-power, power)
User can choose the new profile to use with this utility support while
`amd_pstate_epp` driver instance loaded for the MSR support systems.

for example:
$ sudo x86_energy_perf_policy -d --hwp-epp balance-performance
cpu0: old: HWP_REQ: min 13 max 166 des 0 epp 128 window 0x9 (9*10^0us) use_pkg 0
cpu0: HWP_CAP: low 13 eff 157 guar 0 high 231
cpu0: new: HWP_REQ: min 13 max 166 des 0 epp 128 window 0x9 (9*10^0us) use_pkg 0
cpu1: old: HWP_REQ: min 13 max 166 des 0 epp 128 window 0x9 (9*10^0us) use_pkg 0
cpu1: HWP_CAP: low 13 eff 157 guar 0 high 236
cpu1: new: HWP_REQ: min 13 max 166 des 0 epp 128 window 0x9 (9*10^0us) use_pkg 0
cpu2: old: HWP_REQ: min 13 max 166 des 0 epp 128 window 0x9 (9*10^0us) use_pkg 0
cpu2: HWP_CAP: low 13 eff 157 guar 0 high 211
cpu2: new: HWP_REQ: min 13 max 166 des 0 epp 128 window 0x9 (9*10^0us) use_pkg 0
cpu3: old: HWP_REQ: min 13 max 166 des 0 epp 128 window 0x9 (9*10^0us) use_pkg 0
cpu3: HWP_CAP: low 13 eff 157 guar 0 high 206
cpu3: new: HWP_REQ: min 13 max 166 des 0 epp 128 window 0x9 (9*10^0us) use_pkg 0

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 .../x86_energy_perf_policy.c                  | 69 +++++++++++++++----
 1 file changed, 54 insertions(+), 15 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 5daf1c2bb601..da9087873915 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -902,14 +902,23 @@ void write_hwp_request(int cpu, struct msr_hwp_request *hwp_req, unsigned int ms
 			hwp_req->hwp_desired, hwp_req->hwp_epp,
 			hwp_req->hwp_window, hwp_req->hwp_use_pkg);
 
-	msr |= HWP_MIN_PERF(ratio_2_msr_perf(hwp_req->hwp_min));
-	msr |= HWP_MAX_PERF(ratio_2_msr_perf(hwp_req->hwp_max));
-	msr |= HWP_DESIRED_PERF(ratio_2_msr_perf(hwp_req->hwp_desired));
-	msr |= HWP_ENERGY_PERF_PREFERENCE(hwp_req->hwp_epp);
-	msr |= HWP_ACTIVITY_WINDOW(hwp_req->hwp_window);
-	msr |= HWP_PACKAGE_CONTROL(hwp_req->hwp_use_pkg);
-
-	put_msr(cpu, msr_offset, msr);
+	if (genuine_intel) {
+		msr |= HWP_MIN_PERF(ratio_2_msr_perf(hwp_req->hwp_min));
+		msr |= HWP_MAX_PERF(ratio_2_msr_perf(hwp_req->hwp_max));
+		msr |= HWP_DESIRED_PERF(ratio_2_msr_perf(hwp_req->hwp_desired));
+		msr |= HWP_ENERGY_PERF_PREFERENCE(hwp_req->hwp_epp);
+		msr |= HWP_ACTIVITY_WINDOW(hwp_req->hwp_window);
+		msr |= HWP_PACKAGE_CONTROL(hwp_req->hwp_use_pkg);
+		put_msr(cpu, msr_offset, msr);
+	} else if (authentic_amd) {
+		/* AMD EPP need to set desired perf with zero */
+		hwp_req->hwp_desired = 0;
+		msr |= AMD_CPPC_MIN_PERF(hwp_req->hwp_min);
+		msr |= AMD_CPPC_MAX_PERF(hwp_req->hwp_max);
+		msr |= AMD_CPPC_DES_PERF(hwp_req->hwp_desired);
+		msr |= AMD_CPPC_ENERGY_PERF_PREF(hwp_req->hwp_epp);
+		amd_put_msr(cpu, msr_offset, (unsigned int)msr);
+	}
 }
 
 static int get_epb(int cpu)
@@ -1157,8 +1166,12 @@ int update_hwp_request(int cpu)
 {
 	struct msr_hwp_request req;
 	struct msr_hwp_cap cap;
+	int msr_offset = 0;
 
-	int msr_offset = MSR_HWP_REQUEST;
+	if (genuine_intel)
+		msr_offset = MSR_HWP_REQUEST;
+	else if (authentic_amd)
+		msr_offset = MSR_AMD_CPPC_REQ;
 
 	read_hwp_request(cpu, &req, msr_offset);
 	if (debug)
@@ -1181,7 +1194,11 @@ int update_hwp_request(int cpu)
 
 	req.hwp_use_pkg = req_update.hwp_use_pkg;
 
-	read_hwp_cap(cpu, &cap, MSR_HWP_CAPABILITIES);
+	if (genuine_intel)
+		read_hwp_cap(cpu, &cap, MSR_HWP_CAPABILITIES);
+	else if (authentic_amd)
+		read_hwp_cap(cpu, &cap, MSR_AMD_CPPC_CAP1);
+
 	if (debug)
 		print_hwp_cap(cpu, &cap, "");
 
@@ -1203,8 +1220,12 @@ int update_hwp_request_pkg(int pkg)
 	struct msr_hwp_request req;
 	struct msr_hwp_cap cap;
 	int cpu = first_cpu_in_pkg[pkg];
+	int msr_offset = 0;
 
-	int msr_offset = MSR_HWP_REQUEST_PKG;
+	if (genuine_intel)
+		msr_offset = MSR_HWP_REQUEST_PKG;
+	else if (authentic_amd)
+		msr_offset = MSR_AMD_CPPC_REQ;
 
 	read_hwp_request(cpu, &req, msr_offset);
 	if (debug)
@@ -1225,7 +1246,11 @@ int update_hwp_request_pkg(int pkg)
 	if (update_hwp_epp)
 		req.hwp_epp = req_update.hwp_epp;
 
-	read_hwp_cap(cpu, &cap, MSR_HWP_CAPABILITIES);
+	if (genuine_intel)
+		read_hwp_cap(cpu, &cap, MSR_HWP_CAPABILITIES);
+	else if (authentic_amd)
+		read_hwp_cap(cpu, &cap, MSR_AMD_CPPC_CAP1);
+
 	if (debug)
 		print_hwp_cap(cpu, &cap, "");
 
@@ -1246,13 +1271,27 @@ int update_hwp_request_pkg(int pkg)
 int enable_hwp_on_cpu(int cpu)
 {
 	unsigned long long msr;
+	int ret;
+
+	if (genuine_intel) {
+		get_msr(cpu, MSR_PM_ENABLE, &msr);
+		put_msr(cpu, MSR_PM_ENABLE, 1);
+	} else if (authentic_amd) {
+		ret = amd_get_msr(cpu, MSR_AMD_CPPC_ENABLE, (unsigned long *)(&msr));
+		if (ret < 0)
+			errx(-1, "failed to get msr with return %d", ret);
 
-	get_msr(cpu, MSR_PM_ENABLE, &msr);
-	put_msr(cpu, MSR_PM_ENABLE, 1);
+		ret = amd_put_msr(cpu, MSR_AMD_CPPC_ENABLE, 1);
+		if (ret < 0)
+			errx(-1, "failed to put msr with return %d", ret);
+	}
 
-	if (verbose)
+	if (verbose && genuine_intel)
 		printf("cpu%d: MSR_PM_ENABLE old: %d new: %d\n", cpu, (unsigned int) msr, 1);
 
+	if (verbose && authentic_amd)
+		printf("cpu%d: MSR_AMD_CPPC_ENABLE old: %d new: %d\n", cpu, (unsigned int) msr, 1);
+
 	return 0;
 }
 
-- 
2.34.1


