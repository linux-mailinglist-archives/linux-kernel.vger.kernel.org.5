Return-Path: <linux-kernel+bounces-43882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C532F841A5D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C341285268
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC18374C9;
	Tue, 30 Jan 2024 03:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BOiVpver"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45E0381CD;
	Tue, 30 Jan 2024 03:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584765; cv=fail; b=YOwF+uuDBa47/HBfU9ocTp2VOFhSGTheBqTJODKUBvgzOMb+JZWNmBnZTjNf5qnrrEOiYpAjUzsvh6tF9ElhoxXCxMxs4xsOtO7dcRNwhKiGdSpY5Md2I125EuxSpdewCcT1f5N2YhYLQDIW6l2wMys4c8i+shj62YSuDiB+TNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584765; c=relaxed/simple;
	bh=teFimkOVxyXI31svoAtx3GCZGYHyVM54itfN6YkWVL4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rmr+CLksLD/msUJlJ9se3jZDvjWA7F9EDNxboMbuysumoykDgM+7cuPWBKOrYIZ1xQIHojp+eK8j134AgPYUCAllosfJaV8xMuit0GWIWYGUdG8prJyQcULB0b8Xh8P9O4m/FdAWH9u+03fWUIoK2KGFniitQGNQg0ioUDCA1xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BOiVpver; arc=fail smtp.client-ip=40.107.100.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/3Yb+12OlBd2ga3fdu+6l2Awwm3zPc8hj8K03jfAZfxJEtD1jE6phVwAcWyvhqUnNFdzMdEN/sWabmdl4bgf04Juk2RLTq4oqqC9RZT3MW5tga2Y/7FtUKfGLbqCF/Iey0X2GMTZK5xs2DmU9j0+4uqcBnIztT3kv1PlVdQ6x68ewimcMefq4JKxtsQcGrBfMY7vMoZMwb3o52xlBHJViTOjjghCRafmG/ltSqL+Ld9ulbswC81cZUpptWeEczYajiFh7eClGWEJC7XwUSK7lhM7sdbmbn5UIhfW78AwZk1GKI3CntY3YCGQSwF5oIwgjLEoXVHJr3khrlo9dZobg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5HKmZ9uadfRO+bMt4fbRgFv0pZ7OfSnHUNJQLDHx+A=;
 b=TX8pxayNXEZ7xX1odti58xYvzrE75mUTdhTzlQZmzq6QX+oEJdNs7lVb7GSkW7I+VleRYrvsdhsqIkUiibYFC5XGq7aV5EVZXc9inFddlCDKPqDKxDtJVfNWGjvYqFxCdHuReY270sOFbG7rabyoi+OZmhWTYCbvu/SZaTfyUauAd6zQSO0HCwqNcSKVeBEtSXxvOc12VSBAqw1m2CCsj1Ausl6LkFBKwBwxcaAhDOg0/+UNv0SClqJ99HZLwUNGtQ55sUrpNjHOOgpkOoq/JGAXIRQjKce/RjdKlP7sB1s1U7MKTbmECFN+epAetMXXtLkYJ0mCO0zX7BBwby8u7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5HKmZ9uadfRO+bMt4fbRgFv0pZ7OfSnHUNJQLDHx+A=;
 b=BOiVpverl82TzRGQJjnYlb2blCLe0W2JY4YNGrPparXqFsjGYuRclxuLZVeu8leasoryxQZ7d2kvVCtRvaZmgZ2FJDO81N+/6WR3+u7CPAoinBax0x63kRiM+/jImd+GjONnrea79Td7XH/5NOAYhmIA3wIsPXd7iIJl3CZGhlk=
Received: from DM6PR14CA0039.namprd14.prod.outlook.com (2603:10b6:5:18f::16)
 by SJ1PR12MB6145.namprd12.prod.outlook.com (2603:10b6:a03:45c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.33; Tue, 30 Jan
 2024 03:19:16 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:5:18f:cafe::24) by DM6PR14CA0039.outlook.office365.com
 (2603:10b6:5:18f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 03:19:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 03:19:15 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 29 Jan 2024 21:19:12 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<Borislav.Petkov@amd.com>, <viresh.kumar@linaro.org>, <Ray.Huang@amd.com>,
	<gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 4/8] tools/power x86_energy_perf_policy: rename get_cpuid_or_exit() with intel prefix
Date: Tue, 30 Jan 2024 11:18:32 +0800
Message-ID: <88bb415e8d8d8c651a4127be94a6ca8f773eab66.1706583551.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SJ1PR12MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: 538c0700-30a7-43c8-f907-08dc21423d47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n//lpu1wKvwPoWv7YWSBrGDf/JFKUOU+0kT+vRhwnRUmhId/IxVzTOFxkbvRMr274A/ZrMS1vsEFx9eT5U40CepnM1l8UDh0cKDWQ6gM7UfM2DO/QTzkweW2PvpeyL5ayUenhWNdeiS89Uf19qRgdviZ61DfZW6lO/m5Xl7RIgU2+t7aytmjIIVXaaqCnmuCs+TnZEvFgIQE2bMWgGmbmR7Zwf9T+iWuy+anGOwXxSemrS0pXsDD3mhcrlfcajnq1p5Uau6WNNEn4mpHs5ghMCjYKE2Qfr2M2cuJhLQCBVaeBwLaMIVduxnE7xXQG+8XIYVf+Irtf+/z2LJ2gFjbKefNn31WjDUu3IM5QLvA73EvOqFFUKvFdN7orS/mMrNQq3yWNv1uUTCIfIs5JaJ9H4grVjeD0jPD+FAkylxTME2tEBXjBxQVJmYUkO+y5vevvDOqpWyMUtqAqoeVjj7sFW1yiu/9Sgmr6/rDqFAoB1cA+kogcqb6dituiZyKf6wi5j65NErkVG4luSE/IzqFmP4Uoof+64QtmV1avXJPzSqZbjbeNRFGYQQCO4RHGVs7BDNitQUClpQDqcJ4Pwicr24CLS5N7fqrT2gQ9ezyEOJt2F2G85yppWYllVaD7Gie7Q4LqMnErrFFtFwTJJvxMPE7SjCxnokYc0wAYVW8UkHVaEkTAmRYJlGd5h9AECHSEJ5xvLFzradOSwJrZOwXDeAYVbSMCJmeIsI/+95oiqPUHez4gID19NiCZTm925oEthRqFHx+NcMr8ILwEP8rcQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(83380400001)(336012)(356005)(86362001)(36756003)(26005)(81166007)(44832011)(82740400003)(36860700001)(16526019)(2616005)(47076005)(426003)(7696005)(478600001)(4326008)(70586007)(41300700001)(70206006)(6636002)(110136005)(316002)(54906003)(8936002)(6666004)(2906002)(8676002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 03:19:15.8046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 538c0700-30a7-43c8-f907-08dc21423d47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6145

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


