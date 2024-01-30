Return-Path: <linux-kernel+bounces-43886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFF9841A64
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348D51C219C6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EF837169;
	Tue, 30 Jan 2024 03:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K7MYwIUb"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53FA376F7;
	Tue, 30 Jan 2024 03:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584779; cv=fail; b=U9SNgTYSqPEVt7TbowKe1gyq5tMrdLM7R5xWd8oG/0/rx8PIpx5bMcrCzH/mECynmEjzy4ULZDDEhc/PQ4/1SIcZTgKSmWQdrsBYGlQvJFp9pwtAmiN+mHjUv8uGGg6ADqo8IBDKkVoFMYXsp3ztbQ2q0/JAQbyd/fjdxAWJ7qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584779; c=relaxed/simple;
	bh=612kO+TH6TlNm4ODdMrCES1Lkpwd9h1t0jXfRl79f10=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUpheTD4qqy95g1UgBZharY4lLD9EmsEcbCaA6zKpwrNVf0vsxFQjgJmitwC3XuNB3al+xDtt1PAiSF2/d80xjpJWh/g+Y1iXMfdgLq4EZWztEtUfKB+hQIQU3v/3PLuz3w6cfF25IdOxbH3biQvjK+wJ7YHADEOLcq+pvGalJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K7MYwIUb; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nA8TXJoiahZiooE+Wzuq8m7U+u6yMNeJdezPabK9Juo6iOuE/lpe4NA0zwHBsRvkFESUGqvdg0oB55z3LRxZZF1tiTOIf9S5TfaTU2bLzcGnDp2tsYtLk2skJAIxpYqRDL18LsurU0ZV053kPclxdAsEz9XG/NPPt1xwGoyYRtvVYvvNXEchlBzqyNA0oZSglm2uvC1xkTXIhcm2Lp9jepJV0awCLUUzX06XAJ/DRkylVXtYBHQaCPLOuQp6x2S1dStCSLTxeDKFPYW2dM1ZQ2Gx6FTupuMKJ3QYtng8oragJYBZlUm2AaHYtY5f3xvGm2VmFwLB+kpnevC4Rmex5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y51n67YWs6bh5EFkFdb8SW3bQKZLCzt2euRRQ7ae0J0=;
 b=VldaDBIXw/HRV+C+tEYycm45zJxWTf4583CE0bV3bMeTClHByTyg5d18aB+/YboRbv7kr8bPmypTd5amv4bT1xXV1xMi50ZgNBcU3hb7g6jMiR88mZ9EkBVKAt4/PIs2JxZ2iXZSA4+KMymwhuvdF3Ob3dk087yezVUdWUySQJnO/ZFJCIFK1GvvfhinWh+9EWSxRuECNid8ofG2DxBm8xMgFs/Ve3BuGLKCbI0QVYFBlSZbD0+lBN4q5WND2UdaSnAONQzLzbHwFzeFWmG0T4Zl10CrGssCawOCSazL2CwvNAPfAq1V+DtkKxkPG6KCnqjkYBQdKK8yuv0L37oDWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y51n67YWs6bh5EFkFdb8SW3bQKZLCzt2euRRQ7ae0J0=;
 b=K7MYwIUbCNszZOtkG/8jGEPvkJ7itLwzejUDuFI+xvGDtq8x9WutKwtZ3WcPu+OhO4Lld3D6p18n/DjuBfpeB8abVB6fy4OOdedIqLXa82YSJOI+V08PaMSu8A9bbJQjcA4hgzrIGPmIGcIBqEx8lJzAZrIDLJd2uA4JpgFkcPQ=
Received: from CYZPR02CA0005.namprd02.prod.outlook.com (2603:10b6:930:a1::19)
 by BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 03:19:35 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:a1:cafe::62) by CYZPR02CA0005.outlook.office365.com
 (2603:10b6:930:a1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 03:19:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 03:19:34 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 29 Jan 2024 21:19:31 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<Borislav.Petkov@amd.com>, <viresh.kumar@linaro.org>, <Ray.Huang@amd.com>,
	<gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 7/8] tools/power x86_energy_perf_policy: rename some perf output strings for AMD processors
Date: Tue, 30 Jan 2024 11:18:35 +0800
Message-ID: <c091264fa469a6f7e33a050463d229a31fd3bb59.1706583551.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|BY5PR12MB4067:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a645851-a249-4932-c0c3-08dc2142489a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	208vpeKROjZcsS/8LPM1ILbaPdXbQ9mxQG0rQ6yGYFvtOPSfHldDYt2/Qm+XrdE9gVgFw8UNO2/NGFxobK7FQqqlW2XzLc4KGdq6NQVrPVNvDt2/k1DtLNp7ywkgg/FFmTEP9qQSoZpXP+/5DoAFcJTCyVg2xaKbjMEWk3yhGMdQstB9NQRxpRuebbh3cNqA4J1l5NaNZ0+ydUwHuzVQYuDCSN3KdOQHHhglUPc8UBpA+tHDTlwP1FLJiubc05LvoSPuamIa3bBd9p+PVTY5eBhAWpBOwyAABigq2C0q+8b0nQEw9fMkXJMVHBoC+FS1nCPRT3t3WsYzYFctMh8Y0tvgWDKuT23LU/Df8n1l5vOCPHfp6GfcgnVbqClidfRE+jemb0uzo+y0GScM7FO1Jce0362ebPimr9B3JiOaYluM0NCXRU3lGQpWKdGdFltQsAbtUh5VYOpVHBDCWVRAUwzvKdI/w+OirhU94xOCnUMk/ynbBnrtORKGkPH5aIkw0xmt2+Aix4pfBa6KATQjcXjjyGr9ZIIFXXQu2Ph21YwWoqF2g/XGRasm80rF6m6skn6TBRZcx2qe9lhhUTwIrIhBrJSrK0TtObP7Y96k/AUVeIIfEdgBZ5Tt9Fbd9Q0clAD33z51fWVud6qOaIvI/8D1ExCKAkAwa1gIKNA0TN/sztkDA/yKH2IAh3KYbJJgtydPEBuDzHNnZRCmEt2+q5NtlDXnZFVHodBpUcEOq3VPdGDDyITz7BTQ35ZX5izcURuTNv5spQ6Pf3WL+6I+ZQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(82310400011)(186009)(1800799012)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(36860700001)(36756003)(83380400001)(47076005)(70206006)(316002)(54906003)(6636002)(110136005)(70586007)(8936002)(8676002)(86362001)(478600001)(4326008)(26005)(16526019)(2906002)(7696005)(426003)(336012)(44832011)(5660300002)(2616005)(41300700001)(40480700001)(40460700003)(82740400003)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 03:19:34.8333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a645851-a249-4932-c0c3-08dc2142489a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067

rename some perf strings using same definition for AMD CPPC performance
capabilities.

cpu0: [AMD HWP_REQ]: lowest 12 highest 166 desired 0 epp 128 window
0x131497d0 (80*10^7us) use_pkg 89

cpu1: [AMD HWP_REQ]: lowest 12 highest 166 desired 0 epp 128 window
0x131497d0 (80*10^7us) use_pkg 89

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 .../x86_energy_perf_policy.c                  | 23 ++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index ada1aaabad8c..845cfedab06e 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -864,10 +864,15 @@ void print_hwp_request(int cpu, struct msr_hwp_request *h, char *str)
 
 	if (str)
 		printf("%s", str);
+	if (genuine_intel)
+		printf("HWP_REQ: min %d max %d des %d epp %d window 0x%x (%d*10^%dus) use_pkg %d\n",
+			h->hwp_min, h->hwp_max, h->hwp_desired, h->hwp_epp,
+			h->hwp_window, h->hwp_window & 0x7F, (h->hwp_window >> 7) & 0x7, h->hwp_use_pkg);
+	else if (authentic_amd)
+		printf("[AMD HWP_REQ]: lowest %d highest %d desired %d epp %d window 0x%x (%d*10^%dus) use_pkg %d\n",
+			h->hwp_min, h->hwp_max, h->hwp_desired, h->hwp_epp,
+			h->hwp_window, h->hwp_window & 0x7F, (h->hwp_window >> 7) & 0x7, h->hwp_use_pkg);
 
-	printf("HWP_REQ: min %d max %d des %d epp %d window 0x%x (%d*10^%dus) use_pkg %d\n",
-		h->hwp_min, h->hwp_max, h->hwp_desired, h->hwp_epp,
-		h->hwp_window, h->hwp_window & 0x7F, (h->hwp_window >> 7) & 0x7, h->hwp_use_pkg);
 }
 void print_hwp_request_pkg(int pkg, struct msr_hwp_request *h, char *str)
 {
@@ -876,9 +881,15 @@ void print_hwp_request_pkg(int pkg, struct msr_hwp_request *h, char *str)
 	if (str)
 		printf("%s", str);
 
-	printf("HWP_REQ_PKG: min %d max %d des %d epp %d window 0x%x (%d*10^%dus)\n",
-		h->hwp_min, h->hwp_max, h->hwp_desired, h->hwp_epp,
-		h->hwp_window, h->hwp_window & 0x7F, (h->hwp_window >> 7) & 0x7);
+	if (genuine_intel) {
+		printf("HWP_REQ_PKG: min %d max %d des %d epp %d window 0x%x (%d*10^%dus)\n",
+			h->hwp_min, h->hwp_max, h->hwp_desired, h->hwp_epp,
+			h->hwp_window, h->hwp_window & 0x7F, (h->hwp_window >> 7) & 0x7);
+	} else if (authentic_amd) {
+		printf("AMD HWP_REQ_PKG: lowest %d highest %d desired %d epp %d window 0x%x (%d*10^%dus)\n",
+			h->hwp_min, h->hwp_max, h->hwp_desired, h->hwp_epp,
+			h->hwp_window, h->hwp_window & 0x7F, (h->hwp_window >> 7) & 0x7);
+	}
 }
 void read_hwp_request(int cpu, struct msr_hwp_request *hwp_req, unsigned int msr_offset)
 {
-- 
2.34.1


