Return-Path: <linux-kernel+bounces-43960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B501F841BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ABA51F26B59
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 05:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CC1383A1;
	Tue, 30 Jan 2024 05:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1F4Y5TH+"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53E3381CF;
	Tue, 30 Jan 2024 05:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706594217; cv=fail; b=EHSLSGL9WV/lPOFnDngGtRpOpFRsyKYWxa8gTFB5rpz3WFt+OTroAfRJOwBgtSBuBk1EkpitPuKZu5GB2gsb6f91rq3t/SOC8O3dSQ1c3yHeBuSZEdJSOY3edFPNk/igJDsbrd/x+6fy89BG1LUFGdsA9Nz6k89u5kU3keWvf/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706594217; c=relaxed/simple;
	bh=RD+ecJhVhLsoT8daC5wFIiOq6Catkv1Z4Ie1TUS6CXs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G5vevcRck6OYEgKwdrUQLRGtsr9L4+5BAGRU1NB1vRzi19RzqnM4bzBh2/PNRgfDP6uRnMjRZCWGhqE5uAee34xJ6V6Pt1iRSgJs+vz6Mh1VqhtBcbISgv1UtOv57gH5yCjVduqRIbapvXGELpKU+vZesDwNyU+VnWKN/XAzq2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1F4Y5TH+; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gq7XUhNFY1D03mT7JmxA0/IeMQfV4aH/MUFDQYN2W3cSd9HzjgPGGV6WXYQRVniBCuSoVkzmExGQugC/97nzlLxHEUPiEwsdAooQs4m1Riy21ELehdtxwPe2z9wUX+K1vXYPTayCDQV7DCkEW0vk5HAzoc12LZ3FbJ0I1rjxknRwhqjR35RhEXfOXqrje9Wk4vt2Y/TvwgKMMr4K7a2hUZFj4pEq79+ureQ/U+S7lIulPcMnrMYcTl8dm5y16AXBddyREN08jDMTVSixv0N1NOkbagBFKVRvbkSI4RK28IPQWfqpBs2USpjdi3BS8Pk+gDZujqc98tPKDacV5lPeVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coyXAFBt2hffQGMW99CX0xxsYWfs7o/9RjHDdqsbAlY=;
 b=oOzyeJdJqDIVcGO4MP69BXMnzZUBncNfFOzeVATDzwdqmsej8cRKinF1hJkJMLiczvpImQkmsuCIS21j5Br1KHiDH/Q88YfTSjir3CJJQJ5G4XqtBmE+dHL7h0SZCuXsn77b9Sk6BaVr/vqVZ+rtExkyeruxjSDH07Bl42Gq5Ilu2PWwtYOQoK0b7lhCX0tGK8CPz9/1L68S1zZyh/9LRCOL2ETbSue642pm5snPJEhkJfhlKkyIad+fSKpNWNOu3Ls7d2tPgrq3Oozl9RwyA/pf8Gc/WH8mpIftovBJdzslN1CZDVhbFPwTL9vDJ4vCLiKI6B/2E7giypWuI2YDGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coyXAFBt2hffQGMW99CX0xxsYWfs7o/9RjHDdqsbAlY=;
 b=1F4Y5TH+5tzRgGQ+3/ZODdaFXU6s5zh69UtAVT4kY3SxZ/N6+j/Pft6GzLDSCxWWZbjBNQLzbWkP9TYjFnXnPTVj8+dR9JgSAULVtYf1zAra90iUzQw9iphqd8l5g/VCfxjJSH3Jbjd/bjsecLoHvMBWk9WPldE1QIjpa6r7+wc=
Received: from CYXPR02CA0010.namprd02.prod.outlook.com (2603:10b6:930:cf::21)
 by DS0PR12MB6416.namprd12.prod.outlook.com (2603:10b6:8:cb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.29; Tue, 30 Jan 2024 05:56:53 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:cf:cafe::4f) by CYXPR02CA0010.outlook.office365.com
 (2603:10b6:930:cf::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 05:56:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 05:56:53 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 29 Jan 2024 23:56:49 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<Borislav.Petkov@amd.com>, <viresh.kumar@linaro.org>, <Ray.Huang@amd.com>,
	<gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH Resend 1/8] tools/power x86_energy_perf_policy: add info show support for AMD Pstate EPP driver
Date: Tue, 30 Jan 2024 13:56:25 +0800
Message-ID: <445ff0fcfa7b3c8f8e687819ebbd111e3c1c4b80.1706592301.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|DS0PR12MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: 30819a09-5b89-4817-1b9e-08dc21584242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YfBG+BZkG4p2KtIZRKn6McpBccdXu/OsegEHyxlFqpnrRKQRxpbGaLvjqIf0Pfv1koN/jyiskwIegVm/d0EJ33jcQzld7kkhDOhugaMY8AOWjRXDg1YpC40mylIAy9cG+WnKmMToTiyOGzrGYxjozsJufTj/KorxVqxIWGrPgVv1mbFj/cPI1q56Xo2zeomZzR0BWvykkScLKiALymKUrD/Chn5m+0EXACcQELiWJV5Jtbg8Vq14TL1hqUYjlUzCI6fqnZkyNE4EME+CgkRuEhBk40JPZUggrfgLTvfxoIh/fRNBt/1nRi3nPLZnWWKqL+afUroS01fJgd03pJ2cabh1MimbnFRKIVyGfzE8cDr7ElUqbLqNi0SJdRYETWMTPvj3Q5Jz7NNNmfEH7yEmI+JhQvNVYOL4+NSNq0TmorDmy9JrPU1uDsZNQwnWZnGnGm3F+gIKjZuBLsPkUaU53TDDrCNDnaeaRlt+vBtoXGhEH9A9ckCFpEO6TaKcTrBhifarkQDBGPzPDeIdIpTBRJVIfuBAga9j1oX4+XD3cnDFEY/10ZJWSc2YqGLn9/Mr1qAJFpN2HDAINFEtOy+rJFFrGIC+PiAeT9RibtrswycBlCWdhsFWhFkZA5gqGXqM7IPDJhQTmavUWzj15mhRpkVmH3dmJNUtPrqAprOCDrZER8PNNaYJ9W1MFjiwZB26gFcMxMrK2mmTglygUDflgIEmMiSH4RsWESZLx6GVkoarcz5SzGWYzJk3Mf6j2vfhOnvRN/ysSB3Kki4WeeiFng==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(316002)(54906003)(110136005)(83380400001)(70586007)(86362001)(47076005)(70206006)(6636002)(478600001)(40460700003)(40480700001)(6666004)(36860700001)(82740400003)(81166007)(7696005)(426003)(336012)(16526019)(2616005)(26005)(8676002)(8936002)(4326008)(356005)(44832011)(30864003)(5660300002)(2906002)(41300700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 05:56:53.1141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30819a09-5b89-4817-1b9e-08dc21584242
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6416

From: Perry Yuan <Perry.Yuan@amd.com>

With the amd pstate epp driver implemented, the x86_energy_perf_policy
will need to implemented the utility support to display hardware energy
and performance policy hint information on the AMD processors.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 .../x86_energy_perf_policy.c                  | 211 ++++++++++++++----
 1 file changed, 167 insertions(+), 44 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 5fd9e594079c..5daf1c2bb601 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -76,6 +76,8 @@ unsigned long long pkg_selected_set;
 cpu_set_t *cpu_present_set;
 cpu_set_t *cpu_selected_set;
 int genuine_intel;
+unsigned int authentic_amd;
+unsigned int max_level;
 
 size_t cpu_setsize;
 
@@ -724,6 +726,53 @@ int put_msr(int cpu, int offset, unsigned long long new_msr)
 	return 0;
 }
 
+static int amd_put_msr(int cpu, off_t offset, unsigned long msr)
+{
+	ssize_t retval;
+	int fd;
+	char pathname[32];
+
+	sprintf(pathname, "/dev/cpu/%d/msr", cpu);
+	fd = open(pathname, O_RDWR);
+	if (fd < 0) {
+		err(-EACCES, "%s open failed, try chown or chmod +r /dev/cpu/*/msr, or run as root", pathname);
+		goto out;
+	}
+	retval = pwrite(fd, &msr, sizeof(msr), offset);
+	if (retval != sizeof(msr))
+		err(-EFAULT, "cpu%d: msr offset 0x%lx write failed ret = %ld fd = %d", cpu, (unsigned long)offset, retval, fd);
+
+	if (debug > 1)
+		fprintf(stderr, "amd_put_msr(cpu%d, 0x%lx, 0x%lX)\n", cpu, offset, msr);
+
+	close(fd);
+
+out:
+	return (retval == sizeof(msr)) ? 0 : -1;;
+}
+
+
+static int amd_get_msr(int cpu, off_t offset, unsigned long *msr)
+{
+	ssize_t retval;
+	char pathname[32];
+	int fd;
+
+	sprintf(pathname, "/dev/cpu/%d/msr", cpu);
+	fd = open(pathname, O_RDONLY);
+	if (fd < 0) {
+		err(-EACCES, "%s open failed, try chown or chmod +r /dev/cpu/*/msr, or run as root", pathname);
+		goto out;
+	}
+	retval = pread(fd, msr, sizeof(*msr), offset);
+	if (retval != sizeof *msr)
+		err(-EFAULT, "cpu%d: msr offset 0x%llx read failed", cpu, (unsigned long long)offset);
+
+	close(fd);
+out:
+	return (retval == sizeof *msr) ? 0 : -1;;
+}
+
 static unsigned int read_sysfs(const char *path, char *buf, size_t buflen)
 {
 	ssize_t numread;
@@ -777,13 +826,21 @@ void print_hwp_cap(int cpu, struct msr_hwp_cap *cap, char *str)
 void read_hwp_cap(int cpu, struct msr_hwp_cap *cap, unsigned int msr_offset)
 {
 	unsigned long long msr;
+	int ret;
 
-	get_msr(cpu, msr_offset, &msr);
-
-	cap->highest = msr_perf_2_ratio(HWP_HIGHEST_PERF(msr));
-	cap->guaranteed = msr_perf_2_ratio(HWP_GUARANTEED_PERF(msr));
-	cap->efficient = msr_perf_2_ratio(HWP_MOSTEFFICIENT_PERF(msr));
-	cap->lowest = msr_perf_2_ratio(HWP_LOWEST_PERF(msr));
+	if (genuine_intel) {
+		get_msr(cpu, msr_offset, &msr);
+		cap->highest = msr_perf_2_ratio(HWP_HIGHEST_PERF(msr));
+		cap->guaranteed = msr_perf_2_ratio(HWP_GUARANTEED_PERF(msr));
+		cap->efficient = msr_perf_2_ratio(HWP_MOSTEFFICIENT_PERF(msr));
+		cap->lowest = msr_perf_2_ratio(HWP_LOWEST_PERF(msr));
+	} else if (authentic_amd) {
+		ret = amd_get_msr(cpu, msr_offset, (unsigned long *)(&msr));
+		if (ret < 0)
+			errx(-1, "failed to get msr with return %d", ret);
+		cap->highest = msr_perf_2_ratio(AMD_CPPC_HIGHEST_PERF(msr));
+		cap->lowest = msr_perf_2_ratio(AMD_CPPC_LOWEST_PERF(msr));
+	}
 }
 
 void print_hwp_request(int cpu, struct msr_hwp_request *h, char *str)
@@ -812,15 +869,27 @@ void print_hwp_request_pkg(int pkg, struct msr_hwp_request *h, char *str)
 void read_hwp_request(int cpu, struct msr_hwp_request *hwp_req, unsigned int msr_offset)
 {
 	unsigned long long msr;
+	int ret;
 
-	get_msr(cpu, msr_offset, &msr);
-
-	hwp_req->hwp_min = msr_perf_2_ratio((((msr) >> 0) & 0xff));
-	hwp_req->hwp_max = msr_perf_2_ratio((((msr) >> 8) & 0xff));
-	hwp_req->hwp_desired = msr_perf_2_ratio((((msr) >> 16) & 0xff));
-	hwp_req->hwp_epp = (((msr) >> 24) & 0xff);
-	hwp_req->hwp_window = (((msr) >> 32) & 0x3ff);
-	hwp_req->hwp_use_pkg = (((msr) >> 42) & 0x1);
+	if (genuine_intel) {
+		get_msr(cpu, msr_offset, &msr);
+
+		hwp_req->hwp_min = msr_perf_2_ratio((((msr) >> 0) & 0xff));
+		hwp_req->hwp_max = msr_perf_2_ratio((((msr) >> 8) & 0xff));
+		hwp_req->hwp_desired = msr_perf_2_ratio((((msr) >> 16) & 0xff));
+		hwp_req->hwp_epp = (((msr) >> 24) & 0xff);
+		hwp_req->hwp_window = (((msr) >> 32) & 0x3ff);
+		hwp_req->hwp_use_pkg = (((msr) >> 42) & 0x1);
+	} else if (authentic_amd) {
+		ret = amd_get_msr(cpu, msr_offset, (unsigned long *)(&msr));
+		if (ret < 0)
+			errx(-1, "failed to get msr with return %d", ret);
+		hwp_req->hwp_min = msr_perf_2_ratio((((msr) >> 8) & 0xff));
+		hwp_req->hwp_max = msr_perf_2_ratio((((msr) >> 0) & 0xff));
+
+		hwp_req->hwp_desired = msr_perf_2_ratio((((msr) >> 16) & 0xff));
+		hwp_req->hwp_epp = (((msr) >> 24) & 0xff);
+	}
 }
 
 void write_hwp_request(int cpu, struct msr_hwp_request *hwp_req, unsigned int msr_offset)
@@ -895,18 +964,28 @@ int print_cpu_msrs(int cpu)
 	struct msr_hwp_cap cap;
 	int epb;
 
-	epb = get_epb(cpu);
-	if (epb >= 0)
-		printf("cpu%d: EPB %u\n", cpu, (unsigned int) epb);
+	if (genuine_intel) {
+		epb = get_epb(cpu);
+		if (epb >= 0)
+			printf("cpu%d: EPB %u\n", cpu, (unsigned int) epb);
+	}
 
 	if (!has_hwp)
 		return 0;
 
-	read_hwp_request(cpu, &req, MSR_HWP_REQUEST);
-	print_hwp_request(cpu, &req, "");
+	if (genuine_intel) {
+		read_hwp_request(cpu, &req, MSR_HWP_REQUEST);
+		print_hwp_request(cpu, &req, "");
 
-	read_hwp_cap(cpu, &cap, MSR_HWP_CAPABILITIES);
-	print_hwp_cap(cpu, &cap, "");
+		read_hwp_cap(cpu, &cap, MSR_HWP_CAPABILITIES);
+		print_hwp_cap(cpu, &cap, "");
+	} else if (authentic_amd) {
+		read_hwp_request(cpu, &req, MSR_AMD_CPPC_REQ);//MSR_HWP_REQUEST
+		print_hwp_request(cpu, &req, "");
+
+		read_hwp_cap(cpu, &cap, MSR_AMD_CPPC_CAP1);//MSR_HWP_CAPABILITIES
+		print_hwp_cap(cpu, &cap, "");
+	}
 
 	return 0;
 }
@@ -1330,12 +1409,19 @@ void init_data_structures(void)
 void verify_hwp_is_enabled(void)
 {
 	unsigned long long msr;
+	int ret;
 
 	if (!has_hwp)	/* set in early_cpuid() */
 		return;
 
 	/* MSR_PM_ENABLE[1] == 1 if HWP is enabled and MSRs visible */
-	get_msr(base_cpu, MSR_PM_ENABLE, &msr);
+	if (genuine_intel)
+		get_msr(base_cpu, MSR_PM_ENABLE, &msr);
+	else if (authentic_amd) {
+		ret = amd_get_msr(base_cpu, MSR_AMD_CPPC_ENABLE, (unsigned long *)(&msr));
+		if (ret < 0)
+			errx(-1, "failed to get msr with return %d", ret);
+	}
 	if ((msr & 1) == 0) {
 		fprintf(stderr, "HWP can be enabled using '--hwp-enable'\n");
 		has_hwp = 0;
@@ -1398,6 +1484,17 @@ static void get_cpuid_or_exit(unsigned int leaf,
 		errx(1, "Processor not supported\n");
 }
 
+static void amd_get_cpuid_or_exit(unsigned int leaf,
+			     unsigned int *eax, unsigned int *ebx,
+			     unsigned int *ecx, unsigned int *edx)
+{
+	unsigned int leaf_index;
+
+	leaf_index =  leaf | 0x80000000;
+	if (!__get_cpuid(leaf_index, eax, ebx, ecx, edx))
+		errx(1, "Processor not supported\n");
+}
+
 /*
  * early_cpuid()
  * initialize turbo_is_enabled, has_hwp, has_epb
@@ -1408,24 +1505,39 @@ void early_cpuid(void)
 	unsigned int eax, ebx, ecx, edx;
 	unsigned int fms, family, model;
 
-	get_cpuid_or_exit(1, &fms, &ebx, &ecx, &edx);
-	family = (fms >> 8) & 0xf;
-	model = (fms >> 4) & 0xf;
-	if (family == 6 || family == 0xf)
-		model += ((fms >> 16) & 0xf) << 4;
+	eax = ebx = ecx = edx = 0;
+	__cpuid(0, max_level, ebx, ecx, edx);
+	if (ebx == 0x756e6547 && ecx == 0x6c65746e && edx == 0x49656e69)
+		genuine_intel = 1;
+	else if (ebx == 0x68747541 && ecx == 0x444d4163 && edx == 0x69746e65)
+		authentic_amd = 1;
 
-	if (model == 0x4F) {
-		unsigned long long msr;
+	if (genuine_intel) {
+		get_cpuid_or_exit(1, &fms, &ebx, &ecx, &edx);
+		family = (fms >> 8) & 0xf;
+		model = (fms >> 4) & 0xf;
+		if (family == 6 || family == 0xf)
+			model += ((fms >> 16) & 0xf) << 4;
 
-		get_msr(base_cpu, MSR_TURBO_RATIO_LIMIT, &msr);
+		if (model == 0x4F) {
+			unsigned long long msr;
 
-		bdx_highest_ratio = msr & 0xFF;
-	}
+			get_msr(base_cpu, MSR_TURBO_RATIO_LIMIT, &msr);
+
+			bdx_highest_ratio = msr & 0xFF;
+		}
 
-	get_cpuid_or_exit(0x6, &eax, &ebx, &ecx, &edx);
-	turbo_is_enabled = (eax >> 1) & 1;
-	has_hwp = (eax >> 7) & 1;
-	has_epb = (ecx >> 3) & 1;
+		get_cpuid_or_exit(0x6, &eax, &ebx, &ecx, &edx);
+		turbo_is_enabled = (eax >> 1) & 1;
+		has_hwp = (eax >> 7) & 1;
+		has_epb = (ecx >> 3) & 1;
+	} else if (authentic_amd) {
+		/* AMD Processors CPUID info */
+		amd_get_cpuid_or_exit(0x8, &eax, &ebx, &ecx, &edx);
+		turbo_is_enabled = (eax >> 1) & 1;
+		has_hwp = (ebx >> 27) & 1;
+		has_hwp_epp = (ebx >> 27) & 1;
+	}
 }
 
 /*
@@ -1444,6 +1556,8 @@ void parse_cpuid(void)
 
 	if (ebx == 0x756e6547 && edx == 0x49656e69 && ecx == 0x6c65746e)
 		genuine_intel = 1;
+	else if (ebx == 0x68747541 && ecx == 0x444d4163 && edx == 0x69746e65)
+		authentic_amd = 1;
 
 	if (debug)
 		fprintf(stderr, "CPUID(0): %.4s%.4s%.4s ",
@@ -1456,6 +1570,11 @@ void parse_cpuid(void)
 	if (family == 6 || family == 0xf)
 		model += ((fms >> 16) & 0xf) << 4;
 
+	if (authentic_amd) {
+		if (family == 0xf)
+			family += (fms >> 20) & 0xff;
+	}
+
 	if (debug) {
 		fprintf(stderr, "%d CPUID levels; family:model:stepping 0x%x:%x:%x (%d:%d:%d)\n",
 			max_level, family, model, stepping, family, model, stepping);
@@ -1473,14 +1592,18 @@ void parse_cpuid(void)
 	if (!(edx & (1 << 5)))
 		errx(1, "CPUID: no MSR");
 
-
-	get_cpuid_or_exit(0x6, &eax, &ebx, &ecx, &edx);
-	/* turbo_is_enabled already set */
-	/* has_hwp already set */
-	has_hwp_notify = eax & (1 << 8);
-	has_hwp_activity_window = eax & (1 << 9);
-	has_hwp_epp = eax & (1 << 10);
-	has_hwp_request_pkg = eax & (1 << 11);
+	if (genuine_intel) {
+		get_cpuid_or_exit(0x6, &eax, &ebx, &ecx, &edx);
+		/* turbo_is_enabled already set */
+		/* has_hwp already set */
+		has_hwp_notify = eax & (1 << 8);
+		has_hwp_activity_window = eax & (1 << 9);
+		has_hwp_epp = eax & (1 << 10);
+		has_hwp_request_pkg = eax & (1 << 11);
+	} else if (authentic_amd) {
+		amd_get_cpuid_or_exit(0x8, &eax, &ebx, &ecx, &edx);
+		has_hwp_epp = (ebx >> 27) & 1;
+	}
 
 	if (!has_hwp_request_pkg && update_hwp_use_pkg)
 		errx(1, "--hwp-use-pkg is not available on this hardware");
-- 
2.34.1


