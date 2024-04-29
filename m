Return-Path: <linux-kernel+bounces-161833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A956A8B51F1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3656C1F21557
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27A014A90;
	Mon, 29 Apr 2024 07:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eGANkATs"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35D71426E;
	Mon, 29 Apr 2024 07:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714374246; cv=fail; b=PSU1d04ur24BS4ecX8hmFagouw4lLIMV6RHuKT0GvLuL/WfHB49ew/uo/qO3Hvu83DItzum2Ny0Py/440XmfyfNJO56DElQyiWyws29jluewDz+7+N56nONdCrGGXC4TBw+5w9+e+RWlbCCtDEkK/RcvbRHBWUhuIgWys4gmrAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714374246; c=relaxed/simple;
	bh=9eqzXa1iwgTiH0uGFLgK/7PZRVtEuk3TwiboFBA75Iw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ndAheLAIq0ofbOKvJhsDNp2EYhOlwuvggeTd481EPt44MUw6XDDrp5db/os7wVZAWCCEsQ/maZxq3IeGZw5LsMn6OZelOYta2vbbtJyZOMx0O1tvTZC56ASXcV1l5vKzWj1Mmc8v3G5mrBu1fKg65a5+TEzHBA38nbLuZfY6l3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eGANkATs; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6elnDvjjgBBaqgDteYAjWx4JXMCmtPfQgpL0giY6SHehDcU83xyqc7QOYVDul4vxAkBWL++hys5dOVYLqaTUqjiZEMJPAfdvA+bZNz1oVW+6rGtQirfPI3/83q3jNW7sRFIwDi6IZfoU4klElegNFbg8FnK5b9CTbuokb/U3Gv+sh19RMIZsf1jK7MJiC0oRL5Cn9/f4EULxxKZcJmmM2421wlhw7B5CjNfC6zpZ7zrDaw99qoO+04neaXJBawfYD5LHgOLPfuYSKsH3x2nYD+fl5zM9RDAQPh1okr3BEQrieNfKHHH+0vfTYEkOf1OFZJcVqReheLPAOpJvRaSeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WD5keXYSgtpPpkiog9lQQg5mjM17XJl+MtHnlG6oVUc=;
 b=ZSArMo477dW7219D1wd2GDks3ArGZ1mUj5NqckKffAJV17A06PrIncYUhhFtEGPyBB9mRUSeYEfgoghhlOVC6igSgXg64eV9psimfzRjHRIEgqVk2Tj85vKftNo+fq7Fb3xfC9YG98JBa2paKY01edzZ73NUIbnsekDPIckW/JLLV5UGDqBw23GYMp1z7/4f5EKPj37DLOhpDnnvKhVZvqft40Y7Hk0+h9Ss17NGwoTIQPRfbPK8/MldKRb36BgkvKJrJpiCMih4iJpLPSCvsokVOwZKuHxgXq1d4rCJ6v/1UC2tl9clRsKT+y+Vd1o2Po9MAukt9A72jKBblsO2Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WD5keXYSgtpPpkiog9lQQg5mjM17XJl+MtHnlG6oVUc=;
 b=eGANkATs8vWnboD2EOhUeNMpdSzSxB21qFtVOTbbjz9Psk1TLaUI667ULu0JSH3B5WGy0xbfiwmW712c9TmF+anH5kQQhMS+f4Yz14ZX5VHBLnza1zP1GwGPqHwyD5Zafcf2ket6Zi16xYmXwNc7dz4Ny35pAZm+GYDYbiwPJFg=
Received: from MW4PR03CA0112.namprd03.prod.outlook.com (2603:10b6:303:b7::27)
 by SJ2PR12MB7942.namprd12.prod.outlook.com (2603:10b6:a03:4c3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 07:04:01 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:b7:cafe::90) by MW4PR03CA0112.outlook.office365.com
 (2603:10b6:303:b7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Mon, 29 Apr 2024 07:04:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Mon, 29 Apr 2024 07:04:01 +0000
Received: from jenkins-amdgpu-2666v3.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 02:03:56 -0500
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<daniel.sneddon@linux.intel.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <perry.yuan@amd.com>, <x86@kernel.org>,
	<ray.huang@amd.com>, <rafael@kernel.org>, Xiaojian Du <Xiaojian.Du@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/2] cpufreq: amd-pstate: change cpu freq transition delay for some models
Date: Mon, 29 Apr 2024 15:03:22 +0800
Message-ID: <20240429070322.999500-2-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429070322.999500-1-Xiaojian.Du@amd.com>
References: <20240429070322.999500-1-Xiaojian.Du@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|SJ2PR12MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c427d90-20f9-443f-e631-08dc681a8c9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|1800799015|82310400014|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Efm2YP8v+cnzbrE5ZBzPStCbLophexcVOBtqoAJNtE+2gGcR71Fb3Bxqv+x?=
 =?us-ascii?Q?oxPmwUJ66LHR9gUdiAQ39uIMDsOPpyy64WJh5UzwWmXcz/5OZgKYkknrFYOP?=
 =?us-ascii?Q?6O6H3aHRVlIJ/oQZUhPPYSRztc3OdNLOKtFPzUJRsJJ8EoTL+rAH8OagQRaR?=
 =?us-ascii?Q?HlLDK6UeTJ34RaFA/uDLP+GNjs2synTo6K5fv4xqBHjTQBkzeTCyjW5k7nA4?=
 =?us-ascii?Q?VqGNNRYsQ8R6FUrv6BfZTZY/SRcIJJm0TmIehAuHY5dHMh01311ksL59wkJy?=
 =?us-ascii?Q?WjiaozYI+ZAHzhn5DKv+EFLv2zpl64PlFR3FEBcQ3Tb5mezr6y81wYxO3pCV?=
 =?us-ascii?Q?0vdaQE2ROsymc4Z7Kt3tBFgaOtGvMKok8ULogGGCdTgX4+RlWWwfUaRfJRRa?=
 =?us-ascii?Q?MlRzyynWvweghkXR187wUO5f8U0GuehfokRR1jzHOCYgpPpxcruUhkkznayV?=
 =?us-ascii?Q?NBYjfRoohnzGCs6ZK0p2GQFc4Sck3oHlPMJACbSqjZToJ3ayPpU2Wzg2RlQI?=
 =?us-ascii?Q?VKUng6xmNxdc0rMz+8jOHdOEvvK7U+7TXNnZmxWS1nfbUYRa4ppM/a0YRNxB?=
 =?us-ascii?Q?xvbWPwUHxJvwF14rF2fnu7W+yVoYrSH/09kydLx97OvvmHSSCjMAOznRVMft?=
 =?us-ascii?Q?4UvksWYVXvwcljWSPE5k0TounovkekBpY9zx6Xv6XFpRzPJlikV/uCZvC7J9?=
 =?us-ascii?Q?fi/ntDQaHJp/8aeS8tUy0/69BeGoaju2FU2EoandA7qbTHoeQh6a924os3OX?=
 =?us-ascii?Q?uMxqI+dTPww989moN1kJwofLXdRy4I/vpk6JDJMxM5hYXRcHBGkYehLc9mvH?=
 =?us-ascii?Q?mo2L5RNwre605aw+BfX1Ct0Xt89BO6V5lQzSxi6uM+gYl7XOSGQBJxZvBFUs?=
 =?us-ascii?Q?2jmOmkPvST2SAfC4SPtb8m+bQ4kVJNFWSHb8/THJ/5aIuXyL+YsZRwJ38dMh?=
 =?us-ascii?Q?xynG0oN+LgCwrQ0ZVnr03A1CjsY80yTTjSjmDoryKKoeTjrC6153Y6rCn1dZ?=
 =?us-ascii?Q?ubse557VqfvMvivAkJX6EyJaEylAAD8IRP3Kkw5wox2/tjUhT+8nxGfDIrgY?=
 =?us-ascii?Q?ZfyWNy8JTrzAYyu1k1uiGY94RPC6THMUFvqtGds5+Yn1HMNrhAsuv5Dm0BYo?=
 =?us-ascii?Q?+pLiS/k4t5X0gOG/sacBMR72YY+kJ3hP8eB4WU+1Qk1w3squ8xDgcMqKntUW?=
 =?us-ascii?Q?SDKiOWAVIRvOpHtpvn5ltGcIWKhj+ZEtgVxkB9xV5jlGDWa8visoYalgYdjB?=
 =?us-ascii?Q?aIthaRNaTFdtKCzQoMfm1pn0vSlbVvBnEMiQsFd6Tftnhf80YujStYYY8j7l?=
 =?us-ascii?Q?ge9uH72zOoF5zGNEtUyGbCBx9AY/UinxgI9JbB8S1pMqNRre3e7w+hleQvs6?=
 =?us-ascii?Q?UCSCGAk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 07:04:01.5776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c427d90-20f9-443f-e631-08dc681a8c9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7942

Some of AMD ZEN4 APU/CPU have support for adjusting the CPU core
clock more quickly and presicely according to CPU work loading.
This is advertised by the Fast CPPC x86 feature.
This change will only be effective in the *passive mode* of
AMD pstate driver. From the test results of different
transition delay values, 600us is chosen to make a balance
between performance and power consumption.

Some test results on AMD Ryzen 7840HS(Phoenix) APU:

1. Tbench
(Energy less is better, Throughput more is better,
PPW--Performance per Watt more is better)
============= =================== ============== =============== ============== =============== ============== =============== ===============
 Trans Delay   Tbench              governor:schedutil, 3-iterations average
============= =================== ============== =============== ============== =============== ============== =============== ===============
 1000us        Clients             1              2               4              8              12             16              32
               Energy/Joules       2010           2804            8768           17171          16170          15132           15027
               Throughput/(MB/s)   114            259             1041           3010           3135           4851            4605
               PPW                 0.0567         0.0923          0.1187         0.1752         0.1938         0.3205          0.3064
 600us         Clients             1              2               4              8              12             16              32
               Energy/Joules       2115  (5.22%)  2388  (-14.84%) 10700(22.03%)  16716 (-2.65%) 15939 (-1.43%) 15053 (-0.52%)  15083 (0.37% )
               Throughput/(MB/s)   122   (7.02%)  234   (-9.65% ) 1188 (14.12%)  3003  (-0.23%) 3143  (0.26% ) 4842  (-0.19%)  4603  (-0.04%)
               PPW                 0.0576(1.59%)  0.0979(6.07%  ) 0.111(-6.49%)  0.1796(2.51% ) 0.1971(1.70% ) 0.3216(0.34% )  0.3051(-0.42%)
============= =================== ============== ================ ============= =============== ============== =============== ===============

2.Dbench
(Energy less is better, Throughput more is better,
PPW--Performance per Watt more is better)
============= =================== ============== =============== ============== =============== ============== =============== ===============
 Trans Delay   Dbench              governor:schedutil, 3-iterations average
============= =================== ============== =============== ============== =============== ============== =============== ===============
 1000us        Clients             1             2               4              8               12             16              32
               Energy/Joules       4890          3779            3567           5157            5611           6500            8163
               Throughput/(MB/s)   327           167             220            577             775            938             1397
               PPW                 0.0668        0.0441          0.0616         0.1118          0.1381         0.1443          0.1711
 600us         Clients             1             2               4              8               12             16              32
               Energy/Joules       4915  (0.51%) 4912  (29.98%)  3506  (-1.71%) 4907  (-4.85% ) 5011 (-10.69%) 5672  (-12.74%) 8141  (-0.27%)
               Throughput/(MB/s)   348   (6.42%) 284   (70.06%)  220   (0.00% ) 518   (-10.23%) 712  (-8.13% ) 854   (-8.96% ) 1475  (5.58% )
               PPW                 0.0708(5.99%) 0.0578(31.07%)  0.0627(1.79% ) 0.1055(-5.64% ) 0.142(2.82%  ) 0.1505(4.30%  ) 0.1811(5.84% )
============= =================== ============== =============== ============== =============== ============== =============== ===============

3.Hackbench(less time is better)
============= =========================== ==========================
  hackbench     governor:schedutil
============= =========================== ==========================
  Trans Delay   Process Mode Ave time(s)  Thread Mode Ave time(s)
  1000us        14.484                      14.484
  600us         14.418(-0.46%)              15.41(+6.39%)
============= =========================== ==========================

4.Perf_sched_bench(less time is better)
============= =================== ============== ============== ============== =============== =============== =============
 Trans Delay  perf_sched_bench    governor:schedutil
============= =================== ============== ============== ============== =============== =============== =============
  1000us        Groups             1             2              4              8               12              24
                AveTime(s)        1.64          2.851          5.878          11.636          16.093          26.395
  600us         Groups             1             2              4              8               12              24
                AveTime(s)        1.69(3.05%)   2.845(-0.21%)  5.843(-0.60%)  11.576(-0.52%)  16.092(-0.01%)  26.32(-0.28%)
============= ================== ============== ============== ============== =============== =============== ==============

5.Sysbench(higher is better)
============= ================== ============== ================= ============== ================ =============== =================
  Sysbench    governor:schedutil
============= ================== ============== ================= ============== ================ =============== =================
  1000us      Thread             1               2                4              8                12               24
              Ave events         6020.98         12273.39         24119.82       46171.57         47074.37         47831.72
  600us       Thread             1               2                4              8                12               24
              Ave events         6154.82(2.22%)  12271.63(-0.01%) 24392.5(1.13%) 46117.64(-0.12%) 46852.19(-0.47%) 47678.92(-0.32%)
============= ================== ============== ================= ============== ================ =============== =================

In conclusion, a shorter transition delay
of cpu clock will make a quite positive effect to improve PPW on Dbench test,
in the meanwhile , keep stable performance on Tbench,
Hackbench, Perf_sched_bench and Sysbench.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 2015c9fcc3c9..8c8594f67af6 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -50,6 +50,7 @@
 
 #define AMD_PSTATE_TRANSITION_LATENCY	20000
 #define AMD_PSTATE_TRANSITION_DELAY	1000
+#define AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY	600
 #define AMD_PSTATE_PREFCORE_THRESHOLD	166
 
 /*
@@ -868,7 +869,11 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	}
 
 	policy->cpuinfo.transition_latency = AMD_PSTATE_TRANSITION_LATENCY;
-	policy->transition_delay_us = AMD_PSTATE_TRANSITION_DELAY;
+
+	if (cpu_feature_enabled(X86_FEATURE_FAST_CPPC))
+		policy->transition_delay_us = AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY;
+	else
+		policy->transition_delay_us = AMD_PSTATE_TRANSITION_DELAY;
 
 	policy->min = min_freq;
 	policy->max = max_freq;
-- 
2.34.1


