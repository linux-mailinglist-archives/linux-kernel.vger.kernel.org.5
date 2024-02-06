Return-Path: <linux-kernel+bounces-54314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A96A84AD97
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DE8BB25071
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92177A736;
	Tue,  6 Feb 2024 04:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RSlp91+q"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3AF7CF3D;
	Tue,  6 Feb 2024 04:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707194112; cv=fail; b=MO9K8MruiZLnOuLDKyY0hJYm38VJyDBbWkhBHfufdI12ImpShSiMJ47LHOkiSUSnfr4bWMyfKHK3C9wQ94IgljkaIrYdcn81VX8W1XNhNox6uf+n3nSjeGiBnIURKbEEtUSvAk86Wb7fkyQCHrabOWwljyen6AJraImlU1j+s7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707194112; c=relaxed/simple;
	bh=bWnyWjWQFuMjC204Y8elk5xFuwTMRESzd8hyhx49RVs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N9xXq8BYTk7CtRWHQPSglzeyfb8+vNeTPVfsPAdsB2b/D10c0riW5G/RrLba38cXd7qyugHsR0vsm5c1w8rWgPKktN7IVmWJRm5rIH8VwVAzAmC7iBVSCHztr8uv1NEHkJO5Lax8jDG/Ca5eh1hvNY3skSmS6ho1rzFAa3QaKDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RSlp91+q; arc=fail smtp.client-ip=40.107.100.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIgAp1Sd66SbZRwVpQpseA/yVErNKKZa+B/Xwf7PWPFS/x9zHoGXMRiendxfn2VZ7aUu9GzBlJ+8qcR+G9g5LOMiyBpqdzdzklYQ+29YWlXke2IXTmc7jMFaw9A5aN4G/vZ5q3F9mvgmCC6npISemthwDs0NeM+UyvGwgtD/MYStHiZRVh2cFbhF3QmdKi3WUtVJh9Pap0cdVo1V4r9aVbjLNbEFqwM8QL1nnOI1hKLB3CqosgILwHa12K1F6V9WdSo0ShCvWnfI4MeN2RIcUweB14dGi2yRtsqKZ1redSYo3cNadojze7OHVLBUStXaxjd5iPYzMvuUQ5Wi+1D2oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdJ95iUPa8vjYVWMej24FSv5Oggyfd92h8+N+k2OMLY=;
 b=ZSDF/KzmDVlwjeNcDjfRs6Nz0t1Vr+L5iw1lhX2vnSp6UJ+EbJgv8flvXC14iU8AFAuZV1b6S2mM4YFwUmLLatQCgpRUCqEaaGIJ9R85TD9o1oPXx+h3tD3iR1K6L/l0DIq101OXU2fgx5Yk2VhziM1x2l/SM6SVo6S9K1bB2U/F/PPvwR6flIxFDUKpMlIAfzmMvsIMCkc+dYRmPrsnTHu7eBz7OErCFo3Imp+1WVM3P59YFbXdwRvtoVM7Tr3TTH6t+U0vO/FQdJ4kh+zrNmg694TqG/1Cbjm+lzpeGQYkxUjpsj5zzo623LI240YMyVB1LS0kQzT5ZXzT7nCl1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdJ95iUPa8vjYVWMej24FSv5Oggyfd92h8+N+k2OMLY=;
 b=RSlp91+qZaB+LomysvRptdTvqke70GKY3yf4icBMsvJFv/v6tkMJi9GXxR55+KK0qubtIM3Yoxr0xpOolxrGdNb53WddfEIX+4YiHaYkyt+gsk6mDRGZk/F4crBwZIfP8PBl1yyUoCmJK9/E8Qi4BlWppn+TPqBDuuw7gUpwrNE=
Received: from BN9PR03CA0281.namprd03.prod.outlook.com (2603:10b6:408:f5::16)
 by IA1PR12MB7615.namprd12.prod.outlook.com (2603:10b6:208:428::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 04:35:06 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::b1) by BN9PR03CA0281.outlook.office365.com
 (2603:10b6:408:f5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 04:35:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 04:35:06 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 5 Feb 2024 22:35:03 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 4/6] cpufreq:amd-pstate: get pstate transition delay and latency value from ACPI tables
Date: Tue, 6 Feb 2024 12:33:57 +0800
Message-ID: <4e21b25ed21e3718cade07d3f72eef1a96cd7135.1707193566.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707193566.git.perry.yuan@amd.com>
References: <cover.1707193566.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|IA1PR12MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e3ae7c0-af13-428b-ffe2-08dc26ccfe5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IYXBwKZt3W41Qr+BNLqFrP7UKNW6L9PxMnpqecDwB8xxdRzbCSvs5IXNEcxmW34YIKjvUDVi05pTNROgmfi+ysF7NV6l5SzKetSbM3lr+r5NBLQQVREr03XBWSZWLvtyxu77GE9lwXw+B8rLHxIF4OaIusek2J3nrmvzBAq2XrlnTGFxdx7eaX1WwmYtL0N5V+yt3i7qjT4U8VAdccV5zDvsYA6YyGJQgL8pJGhrvTmvKu/6RI7QyF10l12zU1tzCnaSEDMTHIhz4caXmywIuzccjn+7G5kbhy1qS9+aM5c3loNasdRw5mENIaAO2nBtTXOeIyQhy/Bm3CQ335R2LxstcfbfdJ4CoJF5nMi7AQsUHWuOh2DE7mVp/gYDrNCT2xyBtPIcXg9pb5wsrj6OZOfp0d9HV5bAnxTHW1C6WwTCrycrVg//8DS322szbEbkXHGBJQcajKNglQflNkN6bw+LdwBrLgMjFNgwRhdwjaGFdTkO5MCnTO7qWV/uJUCvsQbuAJQzhjx5jrKpcOF8kqGSRiNjPRXBGYvJuIgYeKxEGwBJoGkjKk/1Z2aXzP+xf1Dunjcqu/nCpOA+lG++bdzMViSSpsGQ5fPubR2OuF0IkwCmuG2230EowRcix1zZ6V0L6HZ9xvlbH+QPWNbmNVrsXJJ0kS3x1HhYYpIAo1/wP6Vq5raIIj7bTP8mSb7NAOc3dqyC0XeteW31Fziz6EHGvzQVpMLICXcCiU56Ijcv5ORGX+Q9ItOe4dtVvBAbceaQg4Bh5DEQG/J2mKtoDQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(186009)(82310400011)(1800799012)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(44832011)(2906002)(41300700001)(5660300002)(86362001)(83380400001)(336012)(426003)(47076005)(16526019)(82740400003)(356005)(81166007)(2616005)(6666004)(7696005)(36756003)(54906003)(6636002)(110136005)(478600001)(316002)(26005)(36860700001)(4326008)(8676002)(8936002)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 04:35:06.2056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3ae7c0-af13-428b-ffe2-08dc26ccfe5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7615

make pstate driver initially retrieve the P-state transition delay and latency
values from the BIOS ACPI tables which has more reasonable delay and latency
values according to the platform design and requirements.

Previously there values were hardcoded at specific value which may
have conflicted with platform and it might not reflect the most accurate or
optimized setting for the processor.

[054h 0084   8]                Preserve Mask : FFFFFFFF00000000
[05Ch 0092   8]                   Write Mask : 0000000000000001
[064h 0100   4]              Command Latency : 00000FA0
[068h 0104   4]          Maximum Access Rate : 0000EA60
[06Ch 0108   2]      Minimum Turnaround Time : 0000

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index ea8681ea3bad..77effc3caf6c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -820,6 +820,36 @@ static void amd_pstate_update_limits(unsigned int cpu)
 	mutex_unlock(&amd_pstate_driver_lock);
 }
 
+/**
+ * Get pstate transition delay time from ACPI tables that firmware set
+ * instead of using hardcode value directly.
+ */
+static u32 amd_pstate_get_transition_delay_us(unsigned int cpu)
+{
+	u32 transition_delay_ns;
+
+	transition_delay_ns = cppc_get_transition_latency(cpu);
+	if (transition_delay_ns == CPUFREQ_ETERNAL)
+		return AMD_PSTATE_TRANSITION_DELAY;
+
+	return transition_delay_ns / NSEC_PER_USEC;
+}
+
+/**
+ * Get pstate transition latency value from ACPI tables that firmware set
+ * instead of using hardcode value directly.
+ */
+static u32 amd_pstate_get_transition_latency(unsigned int cpu)
+{
+	u32 transition_latency;
+
+	transition_latency = cppc_get_transition_latency(cpu);
+	if (transition_latency  == CPUFREQ_ETERNAL)
+		return AMD_PSTATE_TRANSITION_LATENCY;
+
+	return transition_latency;
+}
+
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
 	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
@@ -860,8 +890,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 		goto free_cpudata1;
 	}
 
-	policy->cpuinfo.transition_latency = AMD_PSTATE_TRANSITION_LATENCY;
-	policy->transition_delay_us = AMD_PSTATE_TRANSITION_DELAY;
+	policy->cpuinfo.transition_latency = amd_pstate_get_transition_latency(policy->cpu);
+	policy->transition_delay_us = amd_pstate_get_transition_delay_us(policy->cpu);
 
 	policy->min = min_freq;
 	policy->max = max_freq;
-- 
2.34.1


