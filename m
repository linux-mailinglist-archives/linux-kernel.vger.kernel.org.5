Return-Path: <linux-kernel+bounces-55868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A288C84C2A9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18810B2A68B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3B815E89;
	Wed,  7 Feb 2024 02:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jds92u9/"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D395E13FF8;
	Wed,  7 Feb 2024 02:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707274020; cv=fail; b=iR6tSUngYwchgZYQIo6kD6/nOvEvPAp2G5/beBCYEnm+jOU2xmJHWLWwzCwD8tK7RFT3ZPptrYKXSkiR4STHsNsE/w/Lr5qJ1sz3Kb2SczlG9SLxN80pN772EmBW6cpyRNX6EymX2Hq+4ajI3Vq4/Vig5DGnfJCg8712JvaN2nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707274020; c=relaxed/simple;
	bh=bWnyWjWQFuMjC204Y8elk5xFuwTMRESzd8hyhx49RVs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WW+QucE5aVi7yaT5k8PeFfGOpoOWVjJyxmXIcuzjaMDbPcGQinsDFaMRgPH0f6pg6sCS6G+DDSh2YmkfPjYF34C8NkTV4CkqSsRT4WIF7tKeQFdLxOroY+AL+W8OOtZuZixu3MvaQBuq2qVMMdEwR1NMdS5kpAe0m+Y7cFSvQbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jds92u9/; arc=fail smtp.client-ip=40.107.95.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJ2/OTDUnO/bXCLgjoubWuQSCbCbGA3Z+To9QzQlNvbTIdTy163x21DzGKGW5Gylv5vdT190yl7yajIH5AetPnAwwSUvMxaHKm+uuekNlHaLHCqrk8KASb2f1dVVU+CrRbMJN0YKPzyqoY8l4hG/ui0z3wc8iAq7dPJyC1mMW/LMYW8FZ5c3txDks8yXKaolYZLguW0YOps8gVdv7jT891HpVgzL573rrIIQ4nWJTTRFsCNK6lhUmb40amGOio6B2Ii+VDA1zAo0RC0vr/MOsshjR+Ri+IV1Nsq1Er6arKZPQdZRNu3TkN5RjNxwtBaWeHS0s0k5/HRxpuxWY7UfIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdJ95iUPa8vjYVWMej24FSv5Oggyfd92h8+N+k2OMLY=;
 b=T7kXv3UILSz6CzmQLsdDvvvMjCg8+NM0E/FGvxxC5NTILvQJdLjg2DkDT08XOh0DDU8Sj1pr28ob6eBP9sCR/EeqxpsXKq5+d20lPO6vUJh3fNgpq5tf5Y0gSAda0PuVexhFsKeWQ1xBvDGMHUYMiP6Te/iem+J8DvW10Q3CZOkwbQHy2U3CX13UiJuHwAZWucar62WDW6o0Ew82eNyNz417rQDw4GM2LNgVRVM+5XIQ8r3rIwOh/yO/BenbOBDbOWcs4FPx8gvEoFFDCO/o1vR4uHJi65LOVaQK6ucV65uZtG8zf6SeKpy77dIm7jUIs3VUtzSftEYu9U4TAiJHcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdJ95iUPa8vjYVWMej24FSv5Oggyfd92h8+N+k2OMLY=;
 b=Jds92u9/7BGw+TLbZVtWqifzug+cNKnOr1myn1TV4LSFLfsfBFmFU2tGrVqgHUnpXOzPtkP5xdikERHgCrSseKMFZniIpgooLLV3hCorIfdoSuVkUrboHY5OLVz3XIoTx7aRTHMo4IUc0CPgRq2E3Kozle2u1FSin8Q+bMsmQMo=
Received: from DM5PR07CA0074.namprd07.prod.outlook.com (2603:10b6:4:ad::39) by
 SA3PR12MB9131.namprd12.prod.outlook.com (2603:10b6:806:395::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 02:46:55 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::25) by DM5PR07CA0074.outlook.office365.com
 (2603:10b6:4:ad::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37 via Frontend
 Transport; Wed, 7 Feb 2024 02:46:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 02:46:55 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 6 Feb 2024 20:46:51 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 4/6] cpufreq:amd-pstate: get pstate transition delay and latency value from ACPI tables
Date: Wed, 7 Feb 2024 10:46:13 +0800
Message-ID: <4e21b25ed21e3718cade07d3f72eef1a96cd7135.1707273526.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707273526.git.perry.yuan@amd.com>
References: <cover.1707273526.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|SA3PR12MB9131:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a5c113-f485-4409-22bc-08dc27870c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U/yDE3xECPWiYNnSwKrNBxDihGmIo33sAQLjVAXfgvq4kHL4Yrjk/NPljmrhaMI55fkgjDkpM7hNHP5kWfhSGzDhIEQMn04+DZMTtpfMDuXikxz/HuuRfhz+w1ZUL9trlapLuTAvzxJYl9UvUZenTDPPxyzRWzSg2ZSOaMoBsnSKI9jUChXeejMMz0dUogDN4E0MECA8erZd3/3j6+itK5oL7a6MugCC0PYM+mrxHspYmW6WClCXHmO1LuaupRR1G2/CQnwzp4SL4222PXhtnEPZ5UnsCaZRMM7wYhs1Ahy3wg+LE824uK6ECK0N2tDZkbJTbMNst+w8BWX8I+LRSrvlz1N2wJJvi3v/KewpT9bvrENIhK7YWbB3XC9gGIgISu1XyXTgel16rid92gU/zXfIL6/TIxscrpYGYDizUBfkstQ7Tg4M6XmCuowb8XVRIF38BqW9wUj6Wkm1dTj3Abt9p9sqYID00QtodI2hl9luoebCKab1TZQR1wr3WecljOUMTaxeWKG7MZ46GYkqpsQJtFyFtGx7IFEd48wYmBZuZZwZNX5OiXtjmS2hXpWF4kGcyLC1HKLo3L8j69L79Bb2J1+drNRpDD2hGhm0WjWCJiWTxzqfUXakGAiVgLaHZOBDViOIrUIdTZyvA9Gfw4HlZJKNC1zXjg1quiRooo3f1xqcN/TZVrYJL5OoH/h2JotocFoNku8jZFWU/lHBzu6UP4PPKH2eFEv/CiEZh1gzx40ysXsA51qLDyRXn2BWF+sEBxg56MFD7wA8irFOSA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(86362001)(54906003)(26005)(16526019)(47076005)(83380400001)(426003)(2616005)(478600001)(36860700001)(82740400003)(81166007)(356005)(5660300002)(6666004)(336012)(6636002)(110136005)(4326008)(44832011)(8936002)(70586007)(2906002)(316002)(8676002)(70206006)(7696005)(36756003)(40460700003)(40480700001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 02:46:55.6074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a5c113-f485-4409-22bc-08dc27870c28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9131

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


