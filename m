Return-Path: <linux-kernel+bounces-39744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F4983D5A1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30793288CFB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881B767E63;
	Fri, 26 Jan 2024 08:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fbm82af9"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337F467A03;
	Fri, 26 Jan 2024 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706256539; cv=fail; b=eh5k7bvM2R9bRlxHZmCYrbru0qshIbrfR+OCrP5nNZZAMITb8Hz1Mu3jq382rjiTszXFen4J5ee2A181p1S17rigs0hcNXoVQ64wuCgqsn1w73M2eMdSFhr7xRQMlSLpZUNIPJq0mJz5bAY9BoTuOusRDiwkOtd6eVNxYJ9EQCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706256539; c=relaxed/simple;
	bh=QaCVwhJ5K1bcZx9S/s8l5zkzYV25FnXmETFvgzxYmGw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0ID3DMuTCVNUcUCdwDh8U0H6kW/bjvKmdbo+5fU/nMOAye1c4NccJp9r3NzI0bZHlmTIpKLfrJJ6tGa9rhT7v8UcyWjU9mDY3l8tIpOImd11lPFNeoUFuZ4grxnLrFz+QJXzramRPmxh6qofgJvk75qti7258rgnFduEo98a0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fbm82af9; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/MC9wI7aPhr9c6DDKW3haaqMKHWixfdUiRk3rZ3lknOQRzQ3fB0q/hYdsszR3B5TUJ5D9ErlHVjsXdCAR4A4IaAldedgsm/pzpdgYtAnymeGd06dCLlMIN+2rpJVMA3rL3XebLMFtYNbdpZhAei6N2NiX3mE8iMyMDuyZDTBGYtafLu4Wc2niMdrZvx++XCb/Un9GXmg874Llw5aG5ZSPvf7KRl1KZO4IbHbkLTbNhjW35V0GmKavZdnI6pWvoz0/hVzcLpbECqeVP2nxFDkt2N15WMjbWudaowZl4QzIB6CoT2nDGunPif2skcLTuDfez90Xk82ysf5dRUjis2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwVm9ByLssW2HF44IFbTvQDOaahTnjdTRl9oJcjYVIQ=;
 b=K4HZ3nep7wd8oWOpG2Y0QY0me4Ct4PNA7YoDqxfO0GZTLdsE09Dd8ttBZ+G4CQnUgYTcsv9dQ3WJLCBjz/dlv6CjoIyz7PI2v+fYjgb9YUAnDMOv9PwnFF20GL8QnVKjRhJ4S0xsfmQJxY+KqRMztMfgj27Wr2VRdyAn6JgT7b3eq/nQpDjzJBx8TFxge89wsmk54kFg4uwWaMH5lMSqwFObW1r/eUgtUCHW+TihYhvUzPdrMWrobHvaQAsYkuCmX71I2fL2gk6EGjlS4QWGKcuFtoZNUINi9QxKL9n4ot1YI8NFuVv/Y+dXQb7d94xb4Ts/tt9mb+mpnEYLvz3Wew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwVm9ByLssW2HF44IFbTvQDOaahTnjdTRl9oJcjYVIQ=;
 b=Fbm82af9yMRb9+C+xlAycV5GHe7c9gNgHbwh6kNtuECjBfk+x72Q6MW8VLlhQ4GfKFE4WUFVOKnw3admgIg+3tC5xym7Bl/nVWt0guRBOLrccxt2EaHEy2OtACXmYPNyH+zyyWVDBKTuQEF6m7O+JIaI1inYHO4vZre1o7l9Zwo=
Received: from SJ0PR13CA0147.namprd13.prod.outlook.com (2603:10b6:a03:2c6::32)
 by SA3PR12MB7976.namprd12.prod.outlook.com (2603:10b6:806:312::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 08:08:55 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::f9) by SJ0PR13CA0147.outlook.office365.com
 (2603:10b6:a03:2c6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.21 via Frontend
 Transport; Fri, 26 Jan 2024 08:08:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 08:08:55 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 26 Jan 2024 02:08:51 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 4/7] cpufreq: amd-pstate: fix max_perf calculation for amd_get_max_freq()
Date: Fri, 26 Jan 2024 16:08:07 +0800
Message-ID: <675807d1888f77d7d0f3bc335b5bb3bd2c023670.1706255676.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706255676.git.perry.yuan@amd.com>
References: <cover.1706255676.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|SA3PR12MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: edda5461-d99a-4ce9-f592-08dc1e460a78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EMgTtnblQzdTnrur6iwe7ZmxtTiUp75oJ4S4POMPoLDQ1fE7ev9Fbx6eMo6NJhKCeSlaGosNrDsTg1UALgiLVQsxmNBSjKnCl1FxjmGNqpeltC+WH6POZwi3+Sqzu00Kfmxyek1+P7+OurHRj8up4jVv99l3/QPvIldMXc9OnqxVWF/BBzAw/t5nQPnzjPEh2hXJm5cFI5zM81KrTSwH21ACOet4QxCiHabZbsmiNB5cn59asHg6rJsh/bhG2Rht8aVL7iM+eqvLUzRGTDuLPa1SMQYnj3YSESl/NkpzEsHh9QeyK2783j6iTCVN0PE1OXJMO8BzSQReKUtcq71/tyx878O4ONc2lmOxO8tOelMrkcnB7Wi7b0S60QCr7xc1oih5lve1fIzF8dnsfzAup7tUd4GvFMUKjeYEqDuDjdlrNSgtXmRzHYNpr7e75jhqYUYLQyvYcuQDg/Jfn2Y2N5uW2uEQKRe9LtMOQp7bV5Ae1pvzrgi4SpM7YouwTR5VqluPdglHgXHPjMO8yjA5QCHBL/iY04SUh+Un4RNEgIOOXH6j4JFoIoxHN0ji7DIfK9l+wenY4wary1EyQI4jQZNfe0MC7vDbCWqfmTBJInvh/tMjSLglkijR0B3HKMrCsrONOgQhwXNnU8eixETASkEdAqCvEyFOSyIXGiPcrDLJJiEQdp2OT87hjr2H6lwoicGeUswMNdyK9cswnR1VtXh+oRUFrZyzCEefN9zjm60C4JBoVTShAzochMd9IMzBqnCHxn8kuVC63a8xkz0mAg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(82310400011)(1800799012)(186009)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(6666004)(2616005)(7696005)(426003)(336012)(478600001)(16526019)(26005)(110136005)(70206006)(54906003)(70586007)(6636002)(316002)(8676002)(8936002)(83380400001)(47076005)(4326008)(86362001)(82740400003)(41300700001)(5660300002)(44832011)(36756003)(356005)(81166007)(4744005)(36860700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 08:08:55.0448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edda5461-d99a-4ce9-f592-08dc1e460a78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7976

From: Perry Yuan <Perry.Yuan@amd.com>

When CPU core Precision Boost state changed, the max frequency will also
need to be updated according to the current boost state, if boost is
disabled now, the max perf will be limited to nominal perf values.
otherwise the max frequency will be showed wrongly.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index b37bea7440b9..3286d72f375e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -599,6 +599,10 @@ static int amd_get_max_freq(struct amd_cpudata *cpudata)
 	nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	max_perf = READ_ONCE(cpudata->highest_perf);
 
+	/* when boost is off, the highest perf will be limited to nominal_perf */
+	if (!global.cpb_boost)
+		max_perf = nominal_perf;
+
 	boost_ratio = div_u64(max_perf << SCHED_CAPACITY_SHIFT,
 			      nominal_perf);
 
-- 
2.34.1


