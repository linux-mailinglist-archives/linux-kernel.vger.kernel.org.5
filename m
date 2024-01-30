Return-Path: <linux-kernel+bounces-43887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F70841A66
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C925BB237DE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAC3524D1;
	Tue, 30 Jan 2024 03:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JfCCE9Z5"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E9543AB3;
	Tue, 30 Jan 2024 03:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584782; cv=fail; b=FeyDgAovyeR3k9MB6amcmlAFEJrI9lclEMbC+MeK6ZunBZI37BPrJ3n5YBqns1hsvABVIS3DRxMloBGKmL66kKnUOlR99C7V00+meKDHkvBGyFBST8pzVK0ZX6ntpCp4tTzrfzf5GyShGtlP6DPZokxPnufEciKbHSJyQbc6Deg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584782; c=relaxed/simple;
	bh=3ME+v1M95ybXx96nhasNEZ3w22e2BKuPtRJR41vGdaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4fymJozOoHwU8CZRgOg42dFVm8eJDmkTqfKPkvODgN/xwVlEfaNaUqMQLVF2rx8cHWLNOgmVGjOZULLiokTh4i9aWAICeg1ihkK3zdQk1uoVgdS90nppAoeYTOisXaLOpKkrfeN0ZKg98xAUqVjvAkfXJslCzCVoypT1K465Pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JfCCE9Z5; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpvJXYRcxiJ1yevzKaxxF2uI1ipD2EUNTKt5WwJaQYuDKLEa427xmRcXLlL5+g60bbCIsM7PABntenyztfZWKXaVVhBDP/K//ck6O0QQdr0oxXXEGsM3fVaq8eLbl5X2Ysx44ljUDyZHhMB3RDzBJFdJyDb++7sW/jL3jxm0ijlD6wrRA8SFfy6Mr/+PYJSGoldPzK6BtaiFEn6oiVf84y+IGfgnZnfoVE69cKDmIeadRHDpUNkF5U66CWrapXkzGK4dZN2Av53mG435eYggD4z6iKr15pnc/4DEqDlpTEWuA2LX2Cn7k3HeODrEWy0u5dNzQq2Rc1OF34ICbHvy/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WUTkD0MHNo9tADSWnprHWaLAzSOW0I26nQ+yW648ws=;
 b=FEO9qIjWAs/u1ubEtNsHifwxaEgoA0xPSa01vD+IWpZ6HqRwZ0pFmrce23997fB9Yd2pMViLjwLcWHLGW3cWK0tTbhYuNII5NlRanYe23L9Rv898Q9BeEN/079AUAVPmhaxFv+DSLBfsK/Kqx4VdXhfbJZHHWGjYEyvPHrte4dxX2Hk7eK836BnyHm4S668lKn3MFGPbOklT0B1UzHD77OwhPygphWEaj6Umf2OFIKwoJXqFX/2K/TbK0m/3Aej8cYlO3eA/6lVj0BBftJyeyaOH3ic+SY6rbA/GYPoINzkeZcfQWqHmIKYdlOG6SF3CdZMEIgW9ZBZv53Q6FfF4LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WUTkD0MHNo9tADSWnprHWaLAzSOW0I26nQ+yW648ws=;
 b=JfCCE9Z59eKviVE27AsrV5+BKPmLWbY7sl4ReMIXjMm1KFvQoDtcsgHs8IVu68/Yv61yInx0hPpHnizU2TjHJpDC+P0Lf2e5M5P3Z5dqv56WBCkQiC72L+RzJ7wGIAXT/3fS9lbC9jOU1ly6ot7ccNY9azXdkoBYZ9qYq8gFsjc=
Received: from DS7PR05CA0021.namprd05.prod.outlook.com (2603:10b6:5:3b9::26)
 by CYYPR12MB8964.namprd12.prod.outlook.com (2603:10b6:930:bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.33; Tue, 30 Jan
 2024 03:19:38 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::aa) by DS7PR05CA0021.outlook.office365.com
 (2603:10b6:5:3b9::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Tue, 30 Jan 2024 03:19:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 03:19:37 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 29 Jan 2024 21:19:34 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<Borislav.Petkov@amd.com>, <viresh.kumar@linaro.org>, <Ray.Huang@amd.com>,
	<gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 8/8] tools/power x86_energy_perf_policy: change intel msr functions to be static
Date: Tue, 30 Jan 2024 11:18:36 +0800
Message-ID: <67a44547a902e2d266a872ee1a5f6d9894e401c8.1706583551.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|CYYPR12MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: 32639d07-0c1a-44c2-7907-08dc21424a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MPhC6MjfNOmYrZX0b7+yqeAaEv0kgyv1vCu3OZZEeF6TpMzZDeVOfW9fxoAKEUqX0iG6B5qHUL9yyWOWRVBLnWGLRHAFSAsivRRJiuuId3kobtjSCmot6gpSz8o8JCC7KFNaf6lxkaR7qpuu6cuqoWbRk5GV0Lx6fYJCOsYNjZhcwUvEQyUjvHiN268YTa1SF0ZJWfnqYTOQv5DG1rhe5HkpmS00HDs2pEOoqobKZ8I4fN6WjsMRtOiQzypx/vK1KNsduvGji1wjZeqXe+3WHC9WvgVL5QIZzItEbBahmzkD8rYbalY1tm4lNnS3CPswA7M8OrG81FI5dF+7psH9iMaTFIkvzAE9iycvIDP38XBQT69YAdMLi6uIdwkSfNTtpQn8QV9NMjckAR7xEfTii19ZUvGYuVclSoJ85MTcXQCbsWOyTO7oQ1jC0oXV/7ixUA+rSEyUtYwCdDGBJktvVW2RVYD5wimG4lFNB9I5Nht0AxoiLhEVBzyalHX1EQi9FLMIoaF1RHU6fvOEB9hwWKe5z3mvMvy5IMvOGskJiu1aG8bXRaoA5PeiXM4GUKff9K/inRc8pKTOqmgpsX5fTd+NhxzmsPIdset8IiBRvJjmwhEVdsncuuLTGzMI9lfYSXlH53SdM28fWEoTr1u/qZVDncUdJAw7Z9nFzTvpY3CNLjkA55VixIXzrwJbIsOqHnRx5Bfv6p5Pzt+61Kfx8JUgTEFIzzak7DxnEa8mnaw7yr8n34z0ow9UzP73cTPS8vQQVIFt+ivXU1sr+ywy6w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(83380400001)(47076005)(2616005)(426003)(6636002)(336012)(26005)(36860700001)(16526019)(82740400003)(7696005)(81166007)(4326008)(5660300002)(8936002)(44832011)(8676002)(478600001)(2906002)(110136005)(54906003)(41300700001)(70586007)(316002)(70206006)(356005)(86362001)(36756003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 03:19:37.9697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32639d07-0c1a-44c2-7907-08dc21424a80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8964

change the intel_get_msr and intel_put_msr functions to be static.

No functional change intended.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 .../power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 845cfedab06e..a5f2f96fa383 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -686,7 +686,7 @@ void err_on_hypervisor(void)
 		    "not supported on this virtual machine");
 }
 
-int intel_get_msr(int cpu, int offset, unsigned long long *msr)
+static int intel_get_msr(int cpu, int offset, unsigned long long *msr)
 {
 	int retval;
 	char pathname[32];
@@ -710,7 +710,7 @@ int intel_get_msr(int cpu, int offset, unsigned long long *msr)
 	return 0;
 }
 
-int intel_put_msr(int cpu, int offset, unsigned long long new_msr)
+static int intel_put_msr(int cpu, int offset, unsigned long long new_msr)
 {
 	char pathname[32];
 	int retval;
-- 
2.34.1


