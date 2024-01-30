Return-Path: <linux-kernel+bounces-43961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 247EE841BA2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5BF81F26F0C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 05:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FF238DF9;
	Tue, 30 Jan 2024 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aT/gFYZC"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A983838F;
	Tue, 30 Jan 2024 05:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706594221; cv=fail; b=K+RdrghyFw1l8pRcLTx1LGz0J9Obk6D9A34lK9ofnHLtQxCzvox4JFt1FkooZH8Nj5Eeehk16TV+9eOv5QGtXicglhGQm9/Tr1qlJsiX3+roOQ++eCRH+moESr/Quy5Yneme5QmbbHOOhxrZFGcs/l5kmBPxAXVflqcradAFUnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706594221; c=relaxed/simple;
	bh=0G893uXq6j8C35Bu9LEWfW3UuxUFjqrvGD2c9z7oHsE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7QCkKhG2PEvZaKBU3mem4s6Rv0L+MmkMU2ZK7CSsKc6C6onoXVZ5nHjao19JPTQr3XVbBhtJ4rKWB9LHjrCvc2Z9+BFb4fdWxSH/SKkvsZb6z7/LOo6tT5HZtF5yaqQdOaQG9Y2kNr1Kq0IToovMlWedTkuqGNod2UedbnD7dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aT/gFYZC; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RraKxiCUZkUTzXjXv+ijzyTh+/ipF+qRlOXXXmS/OiCzTW2yCf0ksGy/XS2VCiQtsMvvK4yDpyeZvUvI+20GX2c8DyA0ZoWwIHfO6e7JKuDf5JHU17/wMAecoRJHpDoY7QPZLUoKpHOlfqQYVYY4Be4wfemYYpWNY2o36p1Ne6ezKgvA2S2vpYrRX03r6s8iz19U/x4MZkGc/5rayP1IReHFB4QYoD+SY6Er8sBcwdYf5ybJlOCTJ0a7R7pMvJM7CsNyiDPOO0deT9H4IZWEV4sfWPBen9PIZF13iHennirPUu0LksFnFovgveBrkQFiQPSoXZQMAM91bQ5b0D5Qpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=El7iS3nTWLyttkc/AHd0Q5tO2IGNevZrBoWvB0GxErs=;
 b=V+I57cSl2OHwAErUT6Xmo/oX13SUvnRC0/oaL2iUveIWkrpWFqMhu/kuFay20N8+UObL2BG/2riDVEpK11eOb6OVEiuurdgirnyt8kekxZixC5lQoSIWRKtH6Bojbl23a7eykFWavzbPAL9VdfZV4jhlB3HXYX+UDAVjHhgxqloh9ZmIRbRCl0aQJXCT0JfEiPKz+WkzdcFm0mf7N2RvLbIYmQu8lUy1HL0jQpUqxf9jmImg2d+Q8BcpGkDmoqxDet04yZ/k2SknlMCNccZ4QMSFnkujWU/1blyWzfFIKLdLs16hEtHhffD9E+m8kXjIfZugOV3iy6ADgnR1lgUceQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=El7iS3nTWLyttkc/AHd0Q5tO2IGNevZrBoWvB0GxErs=;
 b=aT/gFYZCJZYB+JEt7PgKc3jpN+ZmNi/eEoVV0awFqx9xgfoL99SlIiUyjjm2p6mav5fQR6UHOHmf8kijuK984f/RzI1xhfA/SIVZM2MqCu9wHk2ADOddt9kyJbnqUGkk6NFC9ebsM9tM8AylS5AE7H13fJ9+ILffOxqZ9k68MVU=
Received: from CYXPR02CA0010.namprd02.prod.outlook.com (2603:10b6:930:cf::21)
 by IA1PR12MB6211.namprd12.prod.outlook.com (2603:10b6:208:3e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Tue, 30 Jan
 2024 05:56:56 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:cf:cafe::4f) by CYXPR02CA0010.outlook.office365.com
 (2603:10b6:930:cf::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 05:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 05:56:56 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 29 Jan 2024 23:56:52 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<Borislav.Petkov@amd.com>, <viresh.kumar@linaro.org>, <Ray.Huang@amd.com>,
	<gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH Resend 2/8] tools/power x86_energy_perf_policy: enable AMD pstate EPP profile switching on MSR based system
Date: Tue, 30 Jan 2024 13:56:26 +0800
Message-ID: <ecd0310b117e6b68160de9c77517dfed2b8e530c.1706592301.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|IA1PR12MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 78294344-1166-469b-7cf9-08dc21584409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	58qONvTCrQnycnZyMiTxvw/8YkjCjeI7ec7ifv77qq4oVF4hOblSVOClIhaZsoOJSONS0T6aJ/LgUGrZyB6RGY7Xahqp9DekUFaoQFnTr/hCUye2CVjtBkfO+j08r+7YaR1Umtkw0q/m3RFrdFaxTmxDygcYR8mGvom0ePxJv29ZYmbtxjuGQzeTqNGN9dhugBcvk0o2DS7pc3ksw8fpOCL4SOBgvHpmHUFm7JWAM//u3KHCC+QSAGrXs8/6KqayzVGxiBHHWXJczAUVd19AmABXXf74gOE1ZItsAzNFY/Xv+7r6z8eCPVy7b660ju4GkvuW7mZicVnZpADh3cIZ4DTk49X6qDekYrGt3DbavJqBS1Q3RNOwCDIwpflxNkyh8gZneqIKy6ICsMrR0oJ48p/FBRi7tz4kSGPenUum6f3YydM3a5l/dyJrmag+AERVfVmwNR905Q8Mk6B318gxIa1yhZjtWEHBSXXh9fikCo/rHhHO/hnjB3jONEY+qmawPPVC5K98OvP7/iyC7zmyS/wot5WSdeKNOjio731mvMqRL9x/FOko/axsVrEOSOfSEQFTuKcp3MpG+f+NAClc8OctXeIdZ2x+cxuMe4BkwXn4/T2tmXELoCZPrbldebTZSLKhCsfHyjUqis1lfkn3LSU46Kr5xNOICE5E/QSctq4BUE3IvgJdyu1Jt23wvdu+FZUy7RuvGbu73op7S/UV4olZFfN96FVn4mSOuFZC5R+eVqaHbC8iMot0DagkEAZCkejduvgm985ouoXlK3Ndhg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(16526019)(41300700001)(336012)(2616005)(26005)(40460700003)(40480700001)(426003)(6636002)(316002)(36860700001)(54906003)(36756003)(356005)(6666004)(7696005)(83380400001)(110136005)(478600001)(47076005)(81166007)(82740400003)(70586007)(86362001)(2906002)(4326008)(44832011)(8936002)(8676002)(70206006)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 05:56:56.1141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78294344-1166-469b-7cf9-08dc21584409
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6211

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


