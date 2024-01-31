Return-Path: <linux-kernel+bounces-46064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 625218439EC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1966328456B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C597762DC;
	Wed, 31 Jan 2024 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J2UU4l+p"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839ED74E24;
	Wed, 31 Jan 2024 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691074; cv=fail; b=VRYXe8J+y1qh5REGkieh6IOnSs04wCIBdhzhzat6u2XKkQi5FqTx9uazKrgLBb8pyRgjteoCnlN02G0H4JhPt5H+zmIkMj+rIcGvuoPhTREQWETWP3kv+Wfb0dJb6ZMzID+JWp3tg+6YgUrMFjsYs5ksSFeAHoPsfw+5YGww/5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691074; c=relaxed/simple;
	bh=yKDjldj812mLUF4eQr4izv4hPu6QgG6mXC3c0/ctniA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHCnZyf20HsPACB//BSO011EMKLjgxiZaacU2EXm0Pzlrl/vSIotMrQito+eoG2NCyjp+FiQWSEEnjVT4XLVZ+94Kd18irZ9gJ5B8WEbtDwTucJ31G5tTf3d5SCAQRdQUZn7UaAMUwcpidoz23S0CPNUWcszQTffIRRleRZpVdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J2UU4l+p; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSXKA0Cd42qffAnT4N4yBMY2tlewNpQjmB3eUdTFg6mqyhG63SODYYLsuF0r9dnLgB6Ud2F0XkK4/fJfqcWcr/BdaTFNt2kYamABxBCi3mg12RThIa2fRbPGJX8i13SwwkJBkpRj23mmE/ODx+q0hkiVr2DvzeGroWryCeZeZYX/uli6Fhr5vkYKZO3Hz9c6XXz67DkyveSAeUoGxVz8R6x/nrxo6crhDhAoSXqqu6k4BGmadywpRVcKefcr0RGMQncfHIJQfbaQiiP21E/5mwobsJ6huZWVgADXzDCyzUhYI+tObKoQ7Ks/1cI6FRiNWXXB2PhbMD83ONvvfhpLBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fu1TgpUM2X0XjTmfwGIuizHULqWT0hiLsWPPmsGU5bs=;
 b=KL8kuf3oGG7HDtGXjD+mJoQ8l4q8wgBfkP50QpmIE4lW7o/5ffBYynZfQ3MyP021ySIholNoPe2pEbCNHFw9nP8Ti5awA9EQaYHnFt8eVZqVs2Ci5Xn/0AE5o5keoZE1e7tnYI4c4tLk9fL5+S27rf8DZAYDOd22C2pPu3hLjPmRfvehJfGadZtLMjMZoEiaNeWaeXDvSP3v/lVYHGvw2l6EpAQLa/Ds1LZm69rUB8syPQZRxRKYZpAQLkqZWC/VeW8aQ3zE4CyOmXdc/CjXbph7JmgbWSgPkwD2ChatIjAkbRv1RJS1INxGpnIxzTCIBnxhvyKQ1bwmvJRP7/h0Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fu1TgpUM2X0XjTmfwGIuizHULqWT0hiLsWPPmsGU5bs=;
 b=J2UU4l+p7L7J7KPQMXWSN/3nz46Rh/9866AfVg5zsWkWXVfoJsAJmrYr0WdsMSeRT1BFDr3JWJxJ/XBM1M0VEHTXtZ+NoE6ImIvzquX01nTjGk/LHvOJxHY7u02ZlKtUmX0Of8BYSEQHk6VKP0FNSWpsuso+HHsfefC625VDgFA=
Received: from DM6PR07CA0127.namprd07.prod.outlook.com (2603:10b6:5:330::28)
 by DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Wed, 31 Jan
 2024 08:51:10 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::b1) by DM6PR07CA0127.outlook.office365.com
 (2603:10b6:5:330::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Wed, 31 Jan 2024 08:51:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 31 Jan 2024 08:51:10 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 31 Jan 2024 02:51:06 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 4/6] cpufreq:amd-pstate: get pstate transition delay and latency value from ACPI tables
Date: Wed, 31 Jan 2024 16:50:19 +0800
Message-ID: <872b172c350021ab3c55f80460c33473486e4241.1706690577.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706690577.git.perry.yuan@amd.com>
References: <cover.1706690577.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|DM4PR12MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: dcba7b6e-df5f-460f-486b-08dc2239c58d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nvYnrOJoAOTnHe0e6f1a3Q+55yIFO8ugMIGfDqYPQREyUAUuNdkEAy8/1enYz8phMDCD3d0LfG4710a8KTyz6wRw0hxTowLKDqPhNwmltfpmDc1NVVDneTigz08HrAWYnJbTyZjRKV9347C1CNely8/89eMh2QFOVIUienjnrO/vu+jMvfg85cum+od/IjrrKhaLw4NUzMzsx/4dUyIRE0D/53zbG8J7mXeBXaRvYVdPJlJ58aLvehg0s9PjrdZPZv3EZIxKJZhzaWYZjBYihRliWXhEDy8fnTU978Wuj89D5MeiLf8g9PF7HX20XYTNSwEdpnMo6VcyG2OTbFc3gDvXX/w8g4g4N0zPAwMm7CUgGTVTtaP/X1L5he5qOZHbQEOy6/9aCY8+idRmuRuPD+pZQ0YTQViMU0m4mlnU3gdYlp3WJ2IL3QZKvMdB+ca4xa4jnXo3/Y0YdcSK/uJWTbZKRAfA0ydfNsCOAals+VdecvYnbziGVTBolvU5t7W24cU7g7oQHAcNnKUrgcJN+4ZbmAmRCOkxRTulpyQwNIEaYt1SQ4T/ZZXpbiubqz9B4e1V+JoL4DJ4duqETY4aAG+TjoIuOpF3adA5JQ7KtWanejM6c3b4kP0aCPriWRLY5TJGm/81QCFvVb031tGmF2ICb1P84A1ffuPcLKvabkNOvCMyth2mzw9oH1b0p0Xwl5bJOD6yo3iGpjVwBy8fwzq+ynFIv9ORpTVeNyeKnhC2k2aBhiqSHQZXwk7g7NrnQalF2pQTnkAt4aFTG0Ihpw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(82310400011)(40470700004)(46966006)(36840700001)(110136005)(54906003)(70586007)(70206006)(47076005)(44832011)(6636002)(316002)(478600001)(6666004)(4326008)(8936002)(8676002)(7696005)(336012)(2616005)(426003)(2906002)(83380400001)(82740400003)(5660300002)(16526019)(26005)(36860700001)(86362001)(81166007)(356005)(41300700001)(36756003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:51:10.1681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcba7b6e-df5f-460f-486b-08dc2239c58d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6424

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

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index db7b36afdce2..eea2e192d748 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -683,6 +683,36 @@ static void amd_perf_ctl_reset(unsigned int cpu)
 	wrmsrl_on_cpu(cpu, MSR_AMD_PERF_CTL, 0);
 }
 
+/**
+ * Get pstate transition delay time from ACPI tables that firmware set
+ * instead of using hardcode value directly.
+ */
+static u32 amd_pstate_get_transition_delay_us(unsigned int cpu)
+{
+	u32 transition_delay_ns;
+
+	transition_delay_ns= cppc_get_transition_latency(cpu);
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
@@ -725,8 +755,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
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


