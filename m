Return-Path: <linux-kernel+bounces-43879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6891A841A5B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B14FAB23C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59702374C2;
	Tue, 30 Jan 2024 03:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VLTCJFXb"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E4837147;
	Tue, 30 Jan 2024 03:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584757; cv=fail; b=VFeSh9hX6GZ2tIe/IKogKZdTVwypxVoW3OCJnMGMPyy1W9M+lTYEmo+3pr/Zamop/fdv7wbTrcQZ3xSFu00n+QfE7QImE26Ef00B7GXKfC8BJ+FG6qRU5OweqjoVSo/POf8ZHfiWz5R+jC4SS5OHWvC+JdJln5NcMaeNWZOMt3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584757; c=relaxed/simple;
	bh=YaQEAPPkO9Wwx0LC94zx9fwxAqMQoV8ST19wXZezJuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aF+Br+USF2g4OweQPaip7X5d5b0McUV1ZGdqcmqridnztP4eGjL6OA4PMmVQwoSScW0Tr7L+52DoldMSOdSN0IvEWG9IjHdb/h4tTnTsJjfHLDB3oIua1O/bsLwEekhpFYkdmpI9XwCcwfEw7/xpCFPBD3m2FM4bzhxiU9C2xB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VLTCJFXb; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4g83Y6o4vUKkcAQEkwHcH8o4zbY2MEh4UqrR+52/pPBMSgWdNlKV+UK3ADEvQEgwM/fUmHDfYq0as78X43HIS2Vuc1rM/fRsKUsEUN5FxXxQx+KIoOTHBXq0NYu0AhGtnbeyulF1cSHLqMP9lHDmzwgDnumfTuagUqU9RT2A+YllAu+lnvhSmJTc+bqX1nDSjvRhWSOb/Bwxsfd+LSnmt8+kSVXV0Q09U1dFBXbTr6vnX41kYZ/t8l3jGUoCfpLSfeLzgXv/tb2T7J8IcY0zSnDxXfL5FAqkYw/P9nQI6URybMBcaw4deuz08uClkrwbZstG7ZxSn+ztaBoZbLwtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzZ3ZTjV1uyukg6N9PGVCGyMcR/wOUzrEb+ZVP8dUvU=;
 b=FMRVImwHLsu/rMjUgGEslw/ksQHD01GTVdfsWae3UjSOjlv6ItcaShfrNw0hWXXPP5rUTZ0dT4d6OF3WjqVU2FLD7pT4PgigsSaZQyzSIGobIhA8iE/7aEth3KVAvpKCe+cNT45opWV7cC4iXpo7yGH7kwM2d9cbCrgbt6ne4/GdjMIPsWJP4XqxfsnbszX+sAzZWl2OvEYfvFxq4JpeJC8IkcqOrBbmYBmhBnOIYqdaZCPZccpzCtTQEvc3JefdRCddwf7VpK0+qWCx3JmToocxYSbFA4WTqgSzgyCKp2wCsHHNfjEUoKiCxy0CbEV/kseDGbaswbNAQOa0zf6cNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzZ3ZTjV1uyukg6N9PGVCGyMcR/wOUzrEb+ZVP8dUvU=;
 b=VLTCJFXbJaprTebmXOD5w9SZtGqwLdoqIrX/c2ICWc7anFA3MVSziyf4dtbVtKYVFeVPqDAzLgW+6mOvIgNDOgNA5ll9A08qp+uwdOJARQHok2yCBKcuBiT771mgdhZDYmYA9KOQw2SXhbhp8juv5Q+e7hplNJ19+HSurrO4LsI=
Received: from DS7PR05CA0002.namprd05.prod.outlook.com (2603:10b6:5:3b9::7) by
 CO6PR12MB5476.namprd12.prod.outlook.com (2603:10b6:303:138::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 03:19:11 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::91) by DS7PR05CA0002.outlook.office365.com
 (2603:10b6:5:3b9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Tue, 30 Jan 2024 03:19:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 03:19:09 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 29 Jan 2024 21:19:00 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<Borislav.Petkov@amd.com>, <viresh.kumar@linaro.org>, <Ray.Huang@amd.com>,
	<gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/8] tools/power x86_energy_perf_policy: add info show support for AMD Pstate EPP driver
Date: Tue, 30 Jan 2024 11:18:29 +0800
Message-ID: <aa25177da3d9355d13622f807ac459a003570e98.1706583551.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|CO6PR12MB5476:EE_
X-MS-Office365-Filtering-Correlation-Id: 185b6337-b2c9-424f-3cee-08dc214239ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sesOP7/68zhrcQTYXWHEh40COfCiVbHaOujuKpQQpFma3GvzSuoMWO6gXwOzPPtTLjJzVxquGjirFReP/ampdx7GOSrB3iPbNHxQueFHI3p5aTIbDZTKXPF07rhxX39DHuC4uxZMlGMCgcHAIAari4nX4fkojoGcc4bsVO/IPsv2wO2wQjeyJAKT/1jU+VwYSUCt3RmGvpNOQHbH9uG3CCD+HWrCql/bmAHYT3MTBSuC4RqRQjH2rUehSK3xfx3VxoXUFEaqjCKu2ZBara9yldaWuzxLdEscfABWreg07uhYxYMohv2OOjcA3fVAr8vzIQwlMe1uIs3FnFYruj85G6LxfdPWWm87YvKeEVdvRN+Dz6yc7VrT7B7GPRcDgCw5Ww21UbVz75ke1T5IZ05BjewKThEH0jIbBQOUuHb4GeOZdYC9H6j0v4MhbONfo+ciCRFnPm9nz0bydm0+VJzqzSuAcLyxe1HuOHdHyZhccIutkdU+dtNqrYnNIOlTGzR+9i4jXwpubXXcGJLizWH1uzJveo6YBbXoEtHhb/Up5d0yeS5wzFOTLInevFf157/tDWUAIUro2+tqimbKH0sd6b+wR6mZ/FHYjhg365QbXXc6szVk8JOFgoVRCb8JIGCUmNpPthEmhIvcSEeqpEY7F3ctHFx6T3xfVwTZpj5UXcLpyyBwz6Oy5wqL6LrkcVBSRNhhOhKJI88innAlt6gmHwYenXJxoKbtnvbyl/CGP6V9g+RuygR/BztCvy/R6l0Z7rAC1OnXwz7nWVMb+qDPNQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(47076005)(83380400001)(86362001)(356005)(36756003)(81166007)(44832011)(8676002)(36860700001)(2616005)(16526019)(26005)(7696005)(336012)(426003)(478600001)(6666004)(30864003)(70586007)(41300700001)(70206006)(6636002)(110136005)(316002)(54906003)(4326008)(5660300002)(82740400003)(8936002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 03:19:09.7821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 185b6337-b2c9-424f-3cee-08dc214239ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5476

From: Perry Yuan <Perry.Yuan@amd.com>

With the amd pstate epp driver implemented, the x86_energy_perf_policy
will need to implemented the utility support to display hardware energy
and performance policy hint information on the AMD processors.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 .../x86_energy_perf_policy                    | Bin 0 -> 50808 bytes
 .../x86_energy_perf_policy.c                  | 211 ++++++++++++++----
 2 files changed, 167 insertions(+), 44 deletions(-)
 create mode 100755 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy
new file mode 100755
index 0000000000000000000000000000000000000000..cb52f00c794f3420dfe832fed92240a52c67c1ee
GIT binary patch
literal 50808
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

literal 0
HcmV?d00001

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


