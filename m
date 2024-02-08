Return-Path: <linux-kernel+bounces-57446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE15684D924
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5325E1F20FA4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B493172D;
	Thu,  8 Feb 2024 03:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pNXmNDca"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F112A2E63B;
	Thu,  8 Feb 2024 03:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707364266; cv=fail; b=fV+6ktHVIfATNbvlDeeQbojA7avB7nMWIuA3ZtRJXjNAJATps4+W1L7keHhGlU6PosbrY6HDOLuLDUBWCfFbkwSQT5z+GcIZdt+kU0KFyLRhaCSRbdDOunN8KzGoXlWbosc/fN3G9jY0+mcUrTU2l/oVVGSxZ/K9b/ZI/Hu6sUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707364266; c=relaxed/simple;
	bh=bWnyWjWQFuMjC204Y8elk5xFuwTMRESzd8hyhx49RVs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ca5gMt6I8NRoWBLGU2GMsfdgNQOanmio94Rv6wxcx2g4ISLqCVOsvgPfukVfzUHILjf3wogOgRhCM1Di/qSVVYwbbPOTqgtNSGrMKww/xKxtuyVhtdEOb3h4MUBKRurijOhcR1+XRWjj+V26DwIPx4zdCcv/jggw1gYnP16OBXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pNXmNDca; arc=fail smtp.client-ip=40.107.100.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlF8ZzdeFDBSDyek5hI748RbxcY4rykPeYq5xke1KsyaJGYUGXzCXdBJoX8vmz/Qj2dZrkrkj8FdCmJQ5PWvMt+sO+rvrASNzVYM2Nvo4KKFCTmhAP4xqw7OAfgd6akRjNRlCkJDuiatBirHmZq+zH0cczhewyOfLk6tscaPQfT5Mu7EaPstVw71eoRP4QnIs/CITzdgbCjAWXsFEIzx+3W3wMGBWZ0y9Fq6/RuxeIfpVNbTXW44V2S6VX4RFc0M6Es/PCmeOHPIfz+n1cCMXl4wMa3zjvErwJ8SAUfjt49Wgxa5lILPqWlR4M3dDoEPKG3/atMKjNme04aJPvchjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdJ95iUPa8vjYVWMej24FSv5Oggyfd92h8+N+k2OMLY=;
 b=jRKxtCjDSfS6LwgcA8tEVxrEWnedtdVy0Spq9Hm4Ejvm9XkEjQVLd+3sEPhVpAR6RkeXx9K1p8zV4BMoYdGj9M6JWD/alwr5jQSZypkMn7eaI1CgHjgbYHwORVu4Oebr6lGzyYGMjuyDVJm3IxVu5ImcjBqCcFwPezxSwXBBEHgsArxneqKjILigGR7qrh2d2YD7VWV74D7l1KsfNavtqUgFMc2aeah+Sg1GmXd/Jpw6Svr7N6lOjwPkA1jnDJdHeYUM+blo6WVV+xQMvXOWgl+5ouQ9cqP4mqJNIkLJFr6wC5YOzmP3Y6dmfptB7uoy0/A+FWgqCDG+lH5xs/0+rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdJ95iUPa8vjYVWMej24FSv5Oggyfd92h8+N+k2OMLY=;
 b=pNXmNDcaUYVyXD8njiXgKXMG3eD2T2MIMsAdH+o4mo4bMe41WS0OpixlmVr3vqvJFE+vf1RMwyakESeoZNJPgsOpS6gRHKCePjAw7B88ALvvgcYcXA+JOQ8b/AsuCBQYPeYlNh9vZnoeIYVOguCSAIKlaVfUT+f6pVFNAmLGIC4=
Received: from BL1PR13CA0331.namprd13.prod.outlook.com (2603:10b6:208:2c6::6)
 by CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Thu, 8 Feb
 2024 03:51:02 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::1e) by BL1PR13CA0331.outlook.office365.com
 (2603:10b6:208:2c6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.10 via Frontend
 Transport; Thu, 8 Feb 2024 03:51:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 03:51:02 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 7 Feb 2024 21:50:58 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 4/6] cpufreq:amd-pstate: get pstate transition delay and latency value from ACPI tables
Date: Thu, 8 Feb 2024 11:46:31 +0800
Message-ID: <4e21b25ed21e3718cade07d3f72eef1a96cd7135.1707363758.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707363758.git.perry.yuan@amd.com>
References: <cover.1707363758.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|CH3PR12MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: 40469925-cdec-4e31-fb86-08dc28592b40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8NqBRlYydSn3VM7Zvnyyu4IXP/D7Hd9NV6LVvmpM4Qh6EKt8MIX+aTyg86pfEfS91emCkaScWZZWEbBzoimpdNvTTfYcXgbsSbE7NA3QOkElFM+ce/TdbFqJ2qGNzB2YlVO6D6NxMIuyTIuAXpNpjrdIG1f9m+zBWdiwnR8b9MSlNImC5kKPe9Lb6E/tTjdR6DAOgpQN4X9iAXbkUU5CiAQ9OqJCgy/jxV+ckHUQrXAOS49a4wT3YTYsHaaqpHY408K7jNnCMuDfILQUElwwD9TndsDuiLMB5YhrEu7y8IP6rhwZ8HorYg/2XpcZX5ecPP9f4qVvVJtsOFq6ijK5TZl9y7/F1RlwHUn9kSkSVU86yLp039u6o3lJCneRuof5eM0vPzlWx90mV5nVj/Z0DxzWiaSHjTbMaMthNfeBrF8Jwdi0h+g5kpLPp10vF55CRDBBYthY6HNMcogx8n98yoYF2QC7UExajjHdwcVusXhKXvX0FRn6N8OtZoXxtyhq+q6y+EiPxpRy/dOqbjbP0wBkwt7MHosEiwDkMO96ieuM5XU3kcmWjVwEgcsKzxqy3uJiP3824AGWAJtkqJ9PjcW9y0SEzAprNYidxgHkNDs=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(16526019)(356005)(82740400003)(81166007)(41300700001)(2616005)(83380400001)(336012)(426003)(26005)(6636002)(44832011)(7696005)(54906003)(8676002)(8936002)(2906002)(86362001)(316002)(110136005)(6666004)(4326008)(478600001)(5660300002)(70206006)(70586007)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 03:51:02.2179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40469925-cdec-4e31-fb86-08dc28592b40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524

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


