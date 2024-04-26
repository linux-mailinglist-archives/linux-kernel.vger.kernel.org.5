Return-Path: <linux-kernel+bounces-159576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 721DF8B3085
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2968E28793F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2787113B280;
	Fri, 26 Apr 2024 06:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GtRkCQEz"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA64C13AD0A;
	Fri, 26 Apr 2024 06:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714113327; cv=fail; b=oB13eE4R2LMHPm3TqYLXEJfOSCcMQC+fhLDof2oxO5djB8PI2DKk7wtUavTAEFO2s79UA/piODwlWInnp3QPDJfCSwBG/rw0gooLpYboEN8ITHEEbfAXQNXFCgDE0h/7suTTqOzB2At904M2jBd8xymXS9iddoNDTXVo6nQ8Mmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714113327; c=relaxed/simple;
	bh=PxYKv2MIAAV0A1VPzM23ltZW+LhYQwN0E4NhW8T3Lhk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XT4gkrB61mqrYX/Nvw6Tx3gCRd0sNqqT2k9j1nPMqo9NevAQDs0ovywlMkVhID42XQC/Zlc76aThF8tInQQVMDDe1ArglMyoAc8TX2m5QcsNdAyBPAwmR59UvDccXL/nTvnsdLPU1ZbVn7inXQNcCGG9uLcnAhvzfuxEW0KqfuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GtRkCQEz; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyhmYi4geOEgQfc1u1KHtTFt2KT58hVYh7y3TJc9zyz/ZcYVI7FJquQ7GNrvFc5P9QYoMVOjygv31919WuipXI+X8Lxyr7A+sk4BvztsIh789p49Y3SjUhEUYbPk0FvAqllUuvgmTSLzM8bMmrADedX/0qSIwpqX/lgabqn760TSUg4Oxvp1JKOcN5mk2INEzfGzOFN9wBjt+Sn3cEN+61fgqvnBQEiOOZ/DD7xbA5C6juhoCqIzBc28Ongtgg+YyOguV5wso8KBoyB0XmgcPg/fnKa7yy5JSq/S+0oj8B8a276DnIVnaAJZvf0YLDk6VOERlNVML5PjDNw4MiMnQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tI12f1oS4SvZAa9wpyemhn0+jB5lsGSbx3LBzQFbtvY=;
 b=dCScgKfDCwG3CzmpdjruXo0HYCGMGf5Knv0pfG4JWVKqQbSucWMBhVwq425riYGJ9fpkuE91m6ETZYAj3nDX+Fy51uQhpgGDWHARfTbWI6uCqiT6KxnpSlcHMuKeRPtSsgd70Us7Lycb0OiN4gvf4jJZysauGASU0j+kuBZdurVN2OCa1GRUp5cfuNVBuYdSojg9SGKH+0FEoa/egUUhiHAGzedNdtbTBDIIS00DWZ88NlVoj6GQrXFrpGRsVJuTjrxbcTg5n2Z33VQlLa+iapWvf/y9Yh8EwKG3PFZWvHgVTunuIUmd2xmXM3vedNKyPDSW7ES6tqhZxoNmxD3O2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tI12f1oS4SvZAa9wpyemhn0+jB5lsGSbx3LBzQFbtvY=;
 b=GtRkCQEzbii0v0RgWCyobrpDXeNBwiGOhxT31NCb2vBIYKILoh5L2wvE/AxwVHSiAmWq6GacxfbO7M0jO4EGJ5CsEtOJnf9Go8GHWUtr4NXa/fjMLAR+AamX/yn5ECbHzzUSMbvb5nNbpj2LivRZbGjLjfh5TcpqoCyvBdj4K7g=
Received: from CH2PR08CA0020.namprd08.prod.outlook.com (2603:10b6:610:5a::30)
 by IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Fri, 26 Apr
 2024 06:35:22 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::86) by CH2PR08CA0020.outlook.office365.com
 (2603:10b6:610:5a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.29 via Frontend
 Transport; Fri, 26 Apr 2024 06:35:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 06:35:22 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 01:35:19 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 4/6] cpufreq: amd-pstate: fix the MSR highest perf will be reset issue while cpb boost off
Date: Fri, 26 Apr 2024 14:34:47 +0800
Message-ID: <1d623d592548c7349254cb7dbea8826bb8a99eb3.1714112854.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714112854.git.perry.yuan@amd.com>
References: <cover.1714112854.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|IA1PR12MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: 57721e14-b5b3-4d55-dcc7-08dc65bb0c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lecn/UtVCHtb/XZlfZzjKklDuMqKMAhFd8HhIGQo9t0ejoBs6hKqWQzOLx2/?=
 =?us-ascii?Q?Ds7I/JJagxS+88bglx953vNKiW6L9UOlxres84/a0bAztDwBsPp5hwn5FP6k?=
 =?us-ascii?Q?Zde5l6znm+iEmyvroFe7eJuRNv6VtEsGJPZ4+R2EinVhFKyEALGm5/aoqjY/?=
 =?us-ascii?Q?bFlgc0+9Qx7fpggGohkIhU6J+OTKlZ5cL9DkMgp7tSNsgVHe/7JvKpY/SJXw?=
 =?us-ascii?Q?1s6TsDAfEU4ut5WU1GNAPtgLPlMGKaIfibbgtGg+cNy+5MpcFQwrtSdvvjuW?=
 =?us-ascii?Q?TJErp68xTiN83QGg0hvW6YlCd/SIORv0jyIZcxeOofh2ibynILEiQJi6/bKu?=
 =?us-ascii?Q?W0ujh9+gc9ZmktfLEjjuRCPNfpPZO8JiDSpo9V5JdF8CRSdJ27QqnD/QuhH8?=
 =?us-ascii?Q?v9DLye8awwJ2NJitEqIKe4M9OEiUG+EsIpRr4vhwWRbDPuBCjl6cuZYFYKmo?=
 =?us-ascii?Q?tSqdbC+/pqzBFaSBmjkTDjQACLvbzRLms5OFG7DzpRuY7NB1THF45/IVT6AI?=
 =?us-ascii?Q?IWaKyzjhNfcD42ac95Y0/X+TUIVtnirPS7HUQ/ml7HA7QxTr73e8QQe7ac5B?=
 =?us-ascii?Q?3R2QZTCZYwwHiHJrJ8dzSRX7nKgfumKliRstz5wQ1ZSrNSyGivrCtthyG00E?=
 =?us-ascii?Q?hcHwdV2EkEzWM33Y7R94ybND3z3K7m1ytEgHFaYMO8MV5QanlOJYorUgx67j?=
 =?us-ascii?Q?NdLmhQVA0x0G2ZvUdNR2hTaSWn4hFAki3ghMbZw4WkMlbTtRJvHkVNxC7Kti?=
 =?us-ascii?Q?X0NT8DxGXptmcCpg9JZQ71/Nw/Jgd1kJDJWFEsha+JDdSYL83HwdmoRhQVAS?=
 =?us-ascii?Q?64beGQy/bkDHETQz0bmRwDnYeKvy4PyE6uSDO8NzZS6V7IeBYPFkWwjfbcjo?=
 =?us-ascii?Q?TNmshwm6eF3ibLQ13AtRoJc4Mycw1e9Zk4rXwIwyOBXQjiYcAVOLCdpfo6Nn?=
 =?us-ascii?Q?tWBkfS2STn7HWJtDAt3PEc1wjDFZLkdDTR1CcDkuilNeugen7zn2ZELZU+Wk?=
 =?us-ascii?Q?WTa1SUTDzzdPpbj+xpI8G0eaVG6zpm6+uTRgNyVNMrZlmqOEW2Jt1EvyENLs?=
 =?us-ascii?Q?s+UTpNIe8Ii4lJzWU/XBGJSZG8Wo8OieejIQQwsZWL+vVo8JmrTpU4unHUHX?=
 =?us-ascii?Q?4tdT2f3Teq61M82vEMyQljmufj2RbnOeB4vQ8k/XDJFVfgm7ZyawY3HKx1wZ?=
 =?us-ascii?Q?S7Zwn3rPIq6HRtv49pbwvwarjnlk1tXBQWcr/v+pHqr0PMPlhokxGEdVzcv5?=
 =?us-ascii?Q?7GuHfflfOutFuhgD9Y4cdxXpIdfaZ7UYvRhlw593d+DpVYuXQ1Pmy49GioxH?=
 =?us-ascii?Q?pug1dezdjFUibWQMCHMZsHSz4yDJlgyjENWupOXcnXRf0bsoV7RKpsA/BS4P?=
 =?us-ascii?Q?SIMKDUIzdw0GjMMcR3nlmx3UnOpN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 06:35:22.4064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57721e14-b5b3-4d55-dcc7-08dc65bb0c9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6137

From: Perry Yuan <Perry.Yuan@amd.com>

Select the min perf to fix the highest perf value while update pstate
CPPC request MSR register, here we need to limit the max perf value when
CPU boost is disabled in case of that highest perf value in the MSR will be
reset to original highest perf value which cause the BOOST control
failed.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 53ef39c6dbfa..993e3e6b6609 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -476,6 +476,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 			      u32 des_perf, u32 max_perf, bool fast_switch, int gov_flags)
 {
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
+	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	u64 value = prev;
 
 	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
@@ -495,6 +496,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	value &= ~AMD_CPPC_DES_PERF(~0L);
 	value |= AMD_CPPC_DES_PERF(des_perf);
 
+	/* limit the max perf when core performance boost feature is disabled */
+	if (!amd_pstate_global_params.cpb_boost)
+		max_perf = min_t(unsigned long, nominal_perf, max_perf);
+
 	value &= ~AMD_CPPC_MAX_PERF(~0L);
 	value |= AMD_CPPC_MAX_PERF(max_perf);
 
-- 
2.34.1


