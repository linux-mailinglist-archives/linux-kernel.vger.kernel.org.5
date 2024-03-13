Return-Path: <linux-kernel+bounces-101321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB6A87A582
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98FA3282A04
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4BC3B789;
	Wed, 13 Mar 2024 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LIYRZa1u"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80093A1A3;
	Wed, 13 Mar 2024 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710324316; cv=fail; b=Yl1xnks0NXTkc8glyrIQ4CbOn8ruSzhvwfJ9ZDwDlKXb6IAt8cBvXNGA6B2dJyBokxrQArmeTNM+lElL3xXOle69U6c/vqflqv3aNNq4RXjbJEOKOtDSPONOcax+Mh7egWAkpZFk1y+8BDXj3KSEjqejoyxOTs7A2HgtdwlTgLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710324316; c=relaxed/simple;
	bh=+4hq6036+U12DPPrN+8dk7oAZKPI0vaZqI+kdD6avVc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ooPoLGMOxz8ZMAIg8aialBN8Fd6KFSsXuurxWVJv9GhG1f0pm5K0XlfpmpbX4LL6q4/8mxtVVfNkoeCqXVX0jxtg6VCoPDIWYJY2f6BD96T2Bao2sa61ggqJmfQdmgz5Xv/RH4IxvKLBSisWP1Nx7M7LJYSN5Mg/oJbO6NuUtlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LIYRZa1u; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irghyeaJARKqZ4SexYg/+doJfM+vuT/+OySwKLhp/G9kqj0y7rSg5eQgcnDAHBq41TzaiCZJOuzdi0dNjwMfc9eL0qnsFRLpIb1zJt1tTeszUny/JLx30YjoBMdbOBjrqRRChrb0Qh7ZqgIIGjX5J+n+dZWeeR4MkaO/LT02b3FuMvYy7UBDOMl4wskPZoLgRfeZD2/wjI1RLmbsK++l3Af5/EhPnMorTJATZwxpC33C8RhR1frKuTJcb1RlupGsJBK6/DrRPNNQ/kW6RqhbcoT3HJS9hA59GDSSZx6bmt3FQKZ097CUGQEhCNl8bdQDuJyYt9zItH9Pm6T22EdGbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHzJ9CW/0SYYQRZ8aS+yEcch1FpZ8blP/2nXMKvyn38=;
 b=eBF+yAOiHnzdTrOZX0d+91ZyrNSkhQybP+BctXh2s2ihKCg16yxFMcyJ8gW9TagfXrW6pGTJ93ccqZr8ecBMNfcXS2+lhDDdp5RMqOd9pvbvmdpu7Ivc79twyPjpzehvQAzaMU+ryAM9CQiTU3xnM8ISCavdOpvhwyLDIU06H0CbW0yN55D4FSRnCdkE+OXljOZrBfRuVNRLU/GpQ2yMsMPcwRBD1vlhwPj8eiCzVPnwlODz1549/d1nOseMdltZwum/WqIhPFhUdLzgvOazS1cedC3JBl9Cv7D+HeSf23jkW2uqrBKtCHcpe8uwjOmNnBJSV9UHfwBt8CYmDqkbyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHzJ9CW/0SYYQRZ8aS+yEcch1FpZ8blP/2nXMKvyn38=;
 b=LIYRZa1ur7WTfXB6qyeTB/baX5ClcseE/ITLPRA6+K+Xn9Vf4gvZxNsxj7QAElWG4bO8EyTcj9jCfVZawsV2gwmGkbR2hjx6bOs5cmRLEbQBqGKF2UAGD7SdcHrj4I0A2HjZeOgSaVxPTouTXlDqQAfvpFXffPWfGkUr/+SXd1E=
Received: from MW4PR03CA0214.namprd03.prod.outlook.com (2603:10b6:303:b9::9)
 by IA0PR12MB8279.namprd12.prod.outlook.com (2603:10b6:208:40c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 10:05:11 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::19) by MW4PR03CA0214.outlook.office365.com
 (2603:10b6:303:b9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19 via Frontend
 Transport; Wed, 13 Mar 2024 10:05:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 10:05:09 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 05:05:05 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/7] cpufreq: amd-pstate: fix max_perf calculation for amd_get_max_freq()
Date: Wed, 13 Mar 2024 18:04:40 +0800
Message-ID: <1da9848e022c49fef0a8cc390feba95c74be531d.1710322310.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710322310.git.perry.yuan@amd.com>
References: <cover.1710322310.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|IA0PR12MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: fad30bcc-2ef5-4277-cd9a-08dc4345111b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3egCThHhwi0wnPLRxFI3QhtMpmlqqx8bO/foHqe/pWp6+T4MzvT87b+lP1qsXCYPcfPgwNn9uEC/cLwpzkD7zB8EDA6CJjpD3ueLnpA2cxzcYpNLxql62+y/RPja3wSF66Z3gWwIOTfu4keEQJf0yAuZ20JteEqNg4iGCh3B75HphbI39qMNEh3pLCe3gremx/FuAOzCD+6vPBb46AHUXxcLUz8e06Ve63SllRHzr8xvL8uicNJNWxpzC98M/qaLXy2ACcKiHt7ZpudFCy9ShaDXdXaTXqH0EEf+r4OdswNqjsfZwPL83TzXlGuSJzbVc8Fdlvuz0+Ybz+fbZpvMWLnn8qXw/Lbo5P8noUUWI3YR3hq1Taz5w8Rvg0j/S0gJv31h9U5zDb7t8wYmYf3ArloIOOZWTVHD782t42QUxQk/yAJxuAq92T9jryLdXuehugWeVO/AGT7q/cG3Fa24Psw4lCxL7GysqKbMuMh4IwbKJE8v5YzfNUqUKNxjtYaLS43FBVtSmj2WtrcUSvw1HzbKxNY+yvFXM+Bg4vvy4lECH/wUkz4e//qZfXXNUsKCB+O/fiKsUQO7LPSt+yiiRTJlJZv5ITxr+wfDf5PsJ6L3Nd3wQRCttebateLmLiRvlNxEi6pDzSRlbXsBg1XawvKcWstdSNXy9gXui54VTJVqsHUV439sYEyu7AzqYhBdLkv0gI7vynhBwO9nYfAU2cD7ICIccwL+cCQUm+fJRiXZvbs0DKlScdH03ZdyDuUL
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:05:09.7044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fad30bcc-2ef5-4277-cd9a-08dc4345111b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8279

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
index d54399ebb758..0965fbf660dd 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -632,6 +632,10 @@ static int amd_get_max_freq(struct amd_cpudata *cpudata)
 	nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	max_perf = READ_ONCE(cpudata->highest_perf);
 
+	/* when boost is off, the highest perf will be limited to nominal_perf */
+	if (!amd_pstate_global_params.cpb_boost)
+		max_perf = nominal_perf;
+
 	boost_ratio = div_u64(max_perf << SCHED_CAPACITY_SHIFT,
 			      nominal_perf);
 
-- 
2.34.1


