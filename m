Return-Path: <linux-kernel+bounces-163496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8318B6C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04BF72835E3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DCC44C9B;
	Tue, 30 Apr 2024 07:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l8OHCC4R"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013D23F9E0;
	Tue, 30 Apr 2024 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714463362; cv=fail; b=PaypXBiwmkcJowKhqbNodSW5BQ+MCjozauNGYZ+soMgmFopuxdfRhw3c1iVOgQxcQ7oIYTxBAP6xnJ2dum3t4CBwjFVg5YAtlLjn9yGU9rxNepJ93+QX/iOsCvtwpIRrSq+Ni9g03gsd88U65MfyPzjun27bBNs4o0njjsppTtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714463362; c=relaxed/simple;
	bh=qLSQqnUQ5PF7bZevK21wkBttmbspkxTscpzpEGAUaao=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JeL2o+DMxZgILiG5WaOmHBvmPTJsRcbm6KWE6Se1FSOHsR9ZxK4iMR9F1UzDTQPyHhfJJZQhgWRnfHoaGsK+xm/7hV8cmvK5wysfY12J4SmU9u6I2Zp67bcc3xKkLcs/Xn0ys6P3SWO9N9EgGNpufeiy3GTVGdMmhIQw2Z7Yqm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l8OHCC4R; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RavQdFv/WZX5ND3r3duv69sydTdFimmbbgQoQjGcRhhHNUVms71oFJM5D2TMpAhEnFZZJtMVnZo/o3dDk6y0810kLIOn0yyoDFKyhu2jPxSsb8vuyvjlwrSSMV6R+KCOVqyVoC9sCIaMPZFekOJnZT6eYBxLVeU7ToGuWl4pUSoA7x1AaYpF+BtikyGEHnyjf5fD6cyPVRuwUu17T2/btz9+jMM4wStnTlndwJZV1ntwgNRaEeZ2AIEcfc01rwWZoDo+xt9MYiTQ6jXMHIlycTUnOe92Vg2KRAkvnniEHv6WI6zx7BTTz/RVzJwmu07pB+R8tQd3uIqQ1hW0pFO/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T98INIRW5NnCwnNMDvF2nZO+dq9VJzWgMZBN2OlGBSo=;
 b=bOI/dZyUZCSrVdDY8Kc3RqR8gHFQ+bljkmDeRQNDtGcBjxZCOtbA4K1Gq5tXuUcRVhFPWIWc6MUgk7rnobCh12/culiEWs/XnzWor6VXRB5wX5dcPeytN1u6Ifx4HOowynf8wxOWgKCw2JyrGR5dGYTiLgtLSlEdaEHFFeNPuYvGlVMDKw436XWFLIJB0MexUgQN+wwv2kX5h1tBRUTKZtua6FfrucRw05VVMOIMAJjHv+NX/vJLVR68NSYr5p2DtnaVUB6YNSTJpQZ5j4V95fUO+1WcR1eSeExLiOjwjCd51I6STeuCiimrjDfM61Yuz3Ea1rGYiA0xon5hob9fJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T98INIRW5NnCwnNMDvF2nZO+dq9VJzWgMZBN2OlGBSo=;
 b=l8OHCC4REijGcmeWffRgh1mADwKrx80SAo+Q7zJ4NDmwNEtp+XCAlL0evKdgYZ8HGYgM6+Rzuwbfg1GNklstZ4SObtE7GC2CwQqIueQh9viVcJ1Fz8KODQpN9iHhTHDeymh+44ESRVMmaahtbLLOgciNJL/NWkvNfrTUTZbtmpw=
Received: from CH2PR05CA0052.namprd05.prod.outlook.com (2603:10b6:610:38::29)
 by PH7PR12MB8013.namprd12.prod.outlook.com (2603:10b6:510:27c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 30 Apr
 2024 07:49:13 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::f0) by CH2PR05CA0052.outlook.office365.com
 (2603:10b6:610:38::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.22 via Frontend
 Transport; Tue, 30 Apr 2024 07:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 07:49:12 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 02:49:09 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] cpufreq: amd-pstate: fix code format problems
Date: Tue, 30 Apr 2024 15:48:56 +0800
Message-ID: <20240430074857.2069301-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|PH7PR12MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a713085-cc9a-4dad-16b0-08dc68ea06ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b5+PVge82TheAK0pEZot2p+efrZowF2aXy6ECvEJ8yjM4e8QMRnUnJnYAOts?=
 =?us-ascii?Q?4lpEsQXMIVzF0I9bn3aLMPjBg6L1BCZ430IjG4PK6824lI+v0VyjZaStVvLa?=
 =?us-ascii?Q?tiNNRbEW57k7Ahh79MywwSzEpZ6YqeNWDjk4BkTW1shq5Vr9JZ1G3u2upQkO?=
 =?us-ascii?Q?WgIVC7WD5bFYt83r39V4uivlLQDWM/Q5+cg0sAj8voSKlvZ9hcze3LsiZKma?=
 =?us-ascii?Q?/3+RaF/aX/amwIV8/pzZ1LsAWDIEi8+tp+dNAWms3zonO2wqrnXwPm+CKK4O?=
 =?us-ascii?Q?ETStXmGVgJUZZdO0XEXDle7FAqC1WjRvvnc7oIju327kOaBqOTZqd10ZHoOF?=
 =?us-ascii?Q?NAuzGDZZvSIKZ6DaA5izx758oVzparyz6yyuMa1l3Tdl4fnJDssHg5ARSFMB?=
 =?us-ascii?Q?483RkITdTRyrFyB5lwX6lMAo3QfaMukmQXIJKMdsD9bPX9tKlAjyMlcq5FFC?=
 =?us-ascii?Q?1IrmogXMZbG+K/CDn/dL7F8AvLpYx+hHMUgmtGzRpFp6qKO1WDfdoQemawqz?=
 =?us-ascii?Q?sdSXPGLC90iBgigfG++o0/gPsSKVMuxeBB9ayyzECFIb0XmWEamJaxbfIx0S?=
 =?us-ascii?Q?lKVWeadytarHN8gYBVPHSub7L88WsHPlSCvT96QZOWOuHi/p+r3lqtPN8sdJ?=
 =?us-ascii?Q?VIUHYRCzAzoj73rWqUG1kq9YQgkZvuotQRVjKlX6C6Sdclfn68Jr5jC/gk56?=
 =?us-ascii?Q?f/1C1fDpyRJPEwRjKfyRt1cxyvyhItJ1BB/XbD9cooYmOw1ihHLOlB1QITRF?=
 =?us-ascii?Q?M+9sgcGmQFmB31Jf5rnVl8KooeYQJ+sA4j2cgFrXBioCTBAYVzpi8TKhs+vq?=
 =?us-ascii?Q?fI+pcr7R+ZQnByUFuTEb2armXlTjUdDpuFzWckP2taBN+flyqjvM/hXoBQAv?=
 =?us-ascii?Q?Gte0eo7EiVQbcUx3gxc7w9UqFuYIy7iotPpP3Hqktd15ou6XTXRSvgkZEsCt?=
 =?us-ascii?Q?FwGWDAMZDOfumQA+WcQ/fa77qs0ustOv5kQn49oIH9rSDy+MT48hCTcGlDIT?=
 =?us-ascii?Q?oHYDfyuOTcGMTDZ5mTYppJybqXRBDFE9pm7DzR7DGBHvna+zq28m7GBK3SdL?=
 =?us-ascii?Q?e+54mDpV8e1XpLfSPogdv1O0dZb/o45M5C+6Xozfz6RbCBjGAQpYp3pztqfW?=
 =?us-ascii?Q?d2Qa2XXy/apnL5qIvedELMCSg9ceqZJt2xdelsJzpn7keNEpbfFm1I8e6RCV?=
 =?us-ascii?Q?EFNbD1bgRMJzWUcY5GSn+Qjfx9ZYG0TL7dq8vxE57IVvcQ0Rf5qSEm+IrAdN?=
 =?us-ascii?Q?eJJz6rc80z31mq0tgMHRMLNe7IseQboSsipXVIy6O9EP5qaarLCMgdL0vUoc?=
 =?us-ascii?Q?UWAX1nOwBdhEIhO+VVuKWAywDXS+y5ahM6m6FNHS+FiN5n99rRC2FOP6nfhH?=
 =?us-ascii?Q?TpsVC4eadbvSx3Vhvl23t2HK98xo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 07:49:12.6914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a713085-cc9a-4dad-16b0-08dc68ea06ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8013

get some code format problems fixed in the amd-pstate driver.

Changes Made:

- Fixed incorrect comment format in the functions.

- Removed unnecessary blank line.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404271148.HK9yHBlB-lkp@intel.com/
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 83a29b257794..85656342a101 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -792,7 +792,7 @@ static void amd_pstate_update_limits(unsigned int cpu)
 	mutex_unlock(&amd_pstate_driver_lock);
 }
 
-/**
+/*
  * Get pstate transition delay time from ACPI tables that firmware set
  * instead of using hardcode value directly.
  */
@@ -807,7 +807,7 @@ static u32 amd_pstate_get_transition_delay_us(unsigned int cpu)
 	return transition_delay_ns / NSEC_PER_USEC;
 }
 
-/**
+/*
  * Get pstate transition latency value from ACPI tables that firmware
  * set instead of using hardcode value directly.
  */
@@ -822,7 +822,7 @@ static u32 amd_pstate_get_transition_latency(unsigned int cpu)
 	return transition_latency;
 }
 
-/**
+/*
  * amd_pstate_init_freq: Initialize the max_freq, min_freq,
  *                       nominal_freq and lowest_nonlinear_freq for
  *                       the @cpudata object.
@@ -843,7 +843,6 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 	u32 boost_ratio, lowest_nonlinear_ratio;
 	struct cppc_perf_caps cppc_perf;
 
-
 	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
 	if (ret)
 		return ret;
-- 
2.34.1


