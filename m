Return-Path: <linux-kernel+bounces-43963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A9F841BA6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8790D1C2516C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 05:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12D64EB49;
	Tue, 30 Jan 2024 05:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RRnq3Mlv"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431DE3C492;
	Tue, 30 Jan 2024 05:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706594226; cv=fail; b=NQGNEatt9+SfAPxgINIiQcOErWm+AkvKs0l7oW21zKhPXcVW2VdquvaXz+Cm1NV8bxETpYuYy3cq90q+ht9Bnq4uAvReNJqqemOdZd2cSnJTO5S89hFpqSG35VAuP8lMJkOkdhGyH2wVRN2ALG/eMy/ttmryIx1VBYk3ot7u1FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706594226; c=relaxed/simple;
	bh=teFimkOVxyXI31svoAtx3GCZGYHyVM54itfN6YkWVL4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DvE1mZnQJ3wE5Xs8GPFRGTZJXSe+CMlMT95aoKqVo6gmQAcrjsUyIL78CCDXsKRjHqKohd8g/lSb3a0LZzKcQG9PVC9tMtuaq9mvQZIsvut+ySAPMJQretHqKpIa9LXgV8MwV2Uc3D6vkIO3l+OSQ0aSzwL82oQTJ8An1qjw8fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RRnq3Mlv; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYcTS6A/k0qMC7aSdf68rb/pMH1L2i3wtSJtqSKUH5UquYtumHpl42hlu8tzqKcU0xPF/+m6QUYF+ZIA1PQAf4Va8NvL0ROSaVOECEmjHBSLnYL7jnrEGyIsEol5T3Q3oOgBSzN7+SG3x56PY1T89+9n9gE3ynY4v/eEgp3qYjls1VeDTiXsNInd34msjK0/9wesV4ZpLjhBBm7cGsr7h/bItJ8G2XU88ertbjf2y89JzfslC1ygx3qka7tMmE0PEoheAvwFNjfVfe0wt+UDjrqAcma4kdjtZMkpaRiejksoTlRggELWblSPlBSWOIgDy1oEzCBAJpIxKdU9Nbe6FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5HKmZ9uadfRO+bMt4fbRgFv0pZ7OfSnHUNJQLDHx+A=;
 b=eNnhJ1sdG3j/HwEGavT9AdO3yBaEkKvOZHvH13eJTHkptF8/ChPWeZQgRjDMqY1M4dZ6c9p3l4HVKGhpC8efJcvdLgppj4w9vGqI04O0Zl8tpEYwPI5jzZml8zHK+FfDGNFLcvbFh3NufOWG2wR7U54+lRictTVAcKDdK8fWuTLvlBywmMW7nIcW7X7cOR7B+6jQNT4v1vocbEMyXi2q2hmAbAL1HZleLLj6oLZiJPaW/VkSAo8xIN5ybozNHwcgHXnrwllG42kKfYI+VmtxwFIK6Wo74MD1gBQ0Dj3QENxnuI3cy0xwhCrJ5sI2Gmp94Aobj4mwWFFXOlkxK3qvIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5HKmZ9uadfRO+bMt4fbRgFv0pZ7OfSnHUNJQLDHx+A=;
 b=RRnq3Mlv2UMAgIqJn7hQauM3aip1cQvh/sD3yb2WAdgDJ3DSpez14X5FtQ0H0BlXrv3Pks2ZPkkye0WJiR2bD/aJYj0hNL26q/smbFkCbZ+J+H/qgVdSObLuqo4m+DxLiFu5DtDoffxBCbAkb1CRiuXuIE/e4E5oEl22dAPlhkA=
Received: from CYXPR02CA0014.namprd02.prod.outlook.com (2603:10b6:930:cf::20)
 by BY5PR12MB4999.namprd12.prod.outlook.com (2603:10b6:a03:1da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 05:57:02 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:cf:cafe::2) by CYXPR02CA0014.outlook.office365.com
 (2603:10b6:930:cf::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 05:57:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 05:57:02 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 29 Jan 2024 23:56:58 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<Borislav.Petkov@amd.com>, <viresh.kumar@linaro.org>, <Ray.Huang@amd.com>,
	<gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH Resend 4/8] tools/power x86_energy_perf_policy: rename get_cpuid_or_exit() with intel prefix
Date: Tue, 30 Jan 2024 13:56:28 +0800
Message-ID: <3f9212ab790ebeaa36f7a3fedc4fc533f6c75559.1706592301.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|BY5PR12MB4999:EE_
X-MS-Office365-Filtering-Correlation-Id: d481e48b-09be-4777-c7cc-08dc215847c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SXuQ8G5ojL5QnrhO6syI6sempy8zbIsUgInRL1lO0XIcgP0EL6KTAbSvN5I4VqVk0WG9RlEKERFWT6uctP0zHRqvBDhOV9hTzf8BxnowYKTW8CX0cabZGEMAKHy4XA6pKIwNsy+JYSI+/eoiGLjs4qsidP2Snx2gAiCxMdlPZqf3f0iDRXJnK12XYu//0SIRDFVsCykUc7fD9CLtn5Xo8ewLlcTb64c5oNvTLarEHpffrL9I5sleHvtFoX9bO03NVEXAJSRLpd37jHg3Jp84F8VRFjKq9WdCltmxkw/6gg87Inft9kJeb9rGuXDsWPbzWv5AK7XSGkkeowDUk3673dBIgACv98JoqbjnFmkKL9IprIoUCmSkJgN1O2KCOI11x9rJRg6/9loiBvY38Ht3BcZS3SgADk3YAM3x38vo7rk1IoDqFzQwq+hYoG1NuN8hPavknb73ETUgcdHCYtDLVo7WtzKH0VTxix4xWGzb27IYEYHfymWwfMkIpDcXn8UAi7Ia1uRxzEV1NNe+LMSj24hNMeMVhAthLjYOeBp4k09TEcp3t6HyvuPgy1Zoqtfl/KQqwgYeE67n1nL/InClrOQwXWi8BuBK1w481HLUfjLegO/e71nvsKfjdybeLdyiWv3tUveQc5Gxk0MeNNeA3E2NZPRiiqf+9kPF4uC02npJy7ClxzjQEgft8/P3GKmKwyey3D2PfyxKOQyQNyATePHtpE6pZs9Z2F4ioMN01WKQDk4ypa/9W4yKjBXj1PYIbl+/Q/iTz8ae2Xmk7fMgww==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(82310400011)(451199024)(186009)(1800799012)(64100799003)(40470700004)(36840700001)(46966006)(36860700001)(110136005)(36756003)(83380400001)(2616005)(47076005)(70206006)(6636002)(316002)(70586007)(8936002)(7696005)(8676002)(54906003)(86362001)(478600001)(6666004)(4326008)(26005)(2906002)(16526019)(426003)(336012)(44832011)(5660300002)(41300700001)(40460700003)(356005)(40480700001)(82740400003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 05:57:02.3485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d481e48b-09be-4777-c7cc-08dc215847c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4999

From: Perry Yuan <Perry.Yuan@amd.com>

Rename the get_cpuid_or_exit() function with intel string prefix, that
will help to know the function are used on Intel processors.

No functional impact.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Suggested-by: Fontenot Nathan <Nathan.Fontenot@amd.com>
---
 .../x86_energy_perf_policy/x86_energy_perf_policy.c  | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 3f09c12f24fa..a08403ab219a 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -1515,7 +1515,7 @@ void probe_dev_msr(void)
 			err(-5, "no /dev/cpu/0/msr, Try \"# modprobe msr\" ");
 }
 
-static void get_cpuid_or_exit(unsigned int leaf,
+static void intel_get_cpuid_or_exit(unsigned int leaf,
 			     unsigned int *eax, unsigned int *ebx,
 			     unsigned int *ecx, unsigned int *edx)
 {
@@ -1552,7 +1552,7 @@ void early_cpuid(void)
 		authentic_amd = 1;
 
 	if (genuine_intel) {
-		get_cpuid_or_exit(1, &fms, &ebx, &ecx, &edx);
+		intel_get_cpuid_or_exit(1, &fms, &ebx, &ecx, &edx);
 		family = (fms >> 8) & 0xf;
 		model = (fms >> 4) & 0xf;
 		if (family == 6 || family == 0xf)
@@ -1566,7 +1566,7 @@ void early_cpuid(void)
 			bdx_highest_ratio = msr & 0xFF;
 		}
 
-		get_cpuid_or_exit(0x6, &eax, &ebx, &ecx, &edx);
+		intel_get_cpuid_or_exit(0x6, &eax, &ebx, &ecx, &edx);
 		turbo_is_enabled = (eax >> 1) & 1;
 		has_hwp = (eax >> 7) & 1;
 		has_epb = (ecx >> 3) & 1;
@@ -1591,7 +1591,7 @@ void parse_cpuid(void)
 
 	eax = ebx = ecx = edx = 0;
 
-	get_cpuid_or_exit(0, &max_level, &ebx, &ecx, &edx);
+	intel_get_cpuid_or_exit(0, &max_level, &ebx, &ecx, &edx);
 
 	if (ebx == 0x756e6547 && edx == 0x49656e69 && ecx == 0x6c65746e)
 		genuine_intel = 1;
@@ -1602,7 +1602,7 @@ void parse_cpuid(void)
 		fprintf(stderr, "CPUID(0): %.4s%.4s%.4s ",
 			(char *)&ebx, (char *)&edx, (char *)&ecx);
 
-	get_cpuid_or_exit(1, &fms, &ebx, &ecx, &edx);
+	intel_get_cpuid_or_exit(1, &fms, &ebx, &ecx, &edx);
 	family = (fms >> 8) & 0xf;
 	model = (fms >> 4) & 0xf;
 	stepping = fms & 0xf;
@@ -1632,7 +1632,7 @@ void parse_cpuid(void)
 		errx(1, "CPUID: no MSR");
 
 	if (genuine_intel) {
-		get_cpuid_or_exit(0x6, &eax, &ebx, &ecx, &edx);
+		intel_get_cpuid_or_exit(0x6, &eax, &ebx, &ecx, &edx);
 		/* turbo_is_enabled already set */
 		/* has_hwp already set */
 		has_hwp_notify = eax & (1 << 8);
-- 
2.34.1


