Return-Path: <linux-kernel+bounces-51405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD2A848ADD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7A181F22C77
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910F5B651;
	Sun,  4 Feb 2024 03:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OVNgv7p8"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4913A92D;
	Sun,  4 Feb 2024 03:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707017207; cv=fail; b=jPk+HH2VlDKmmHzmxdFcoRft2ITKZ3TgVaswWJ6uiEp8yCLEP2l+4ZCFsteXHa3mMMSpD9DdDAZSO3eA005XDLdA51b1OHG3hFm2Z4nmjBtV4OQYS3HEDlFJK424/f1cu/4nolHEzROnJNhugTq7sfiTRM/vJBGOE0G1g2SFZ5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707017207; c=relaxed/simple;
	bh=bWnyWjWQFuMjC204Y8elk5xFuwTMRESzd8hyhx49RVs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GuVYnt5nBjUeFQdSSfUjW7h7SIZragdcnCMtnmB2xI/XPCkHkCG5yaDRN0uw7RLIHOmXdhZeN0vthoKREKyFixkmfDXpTkJp0g24IsBW+QDB5GI2G47VHQVEFSzvUy2JJNL7QpvTBcu2cLxJw8RCVT8r90C7ayOchhPFWKn3AyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OVNgv7p8; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQMjCqAH+ZxnCLux23BjFCJsIRALHEUOWzHTjJ2Ci9KDiy0xZRpIoLQYk+KnisOu3MSFnDgHtMsqrozucyLhpPPoAOVVh/vjn660VEpFOKBTLRp6xC0/1tlRJoBX1T6MrLjwBAVcUGyb3Eas/Fi9fucLzpi5S1HWUYwwLCkYSwZtrJvt/UavZ6hv4z9ucsXlNE1Wdlk0tGGDoJhPsWVskcDjK3LcP3eTHsp3KOY3YmOh+S88LCzBfhds3ilP6D+tFSj5+Kgo3aYjZM7Hoco12NhlmC2Q99I3+VewcoJUStEyGw/7SLi3PIukzULXRtrfGgaTtcSx+e9A2foXwhW0JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdJ95iUPa8vjYVWMej24FSv5Oggyfd92h8+N+k2OMLY=;
 b=G/QNPacTG2A/5CiQkKZfzxk1HuI01eTVNNNiiAgFD9ma5HsFDKNpwLc0+NOfBqJqc2zyrCydPGcli19FDBn6/PS7zufqH5K1qME0douY/TegQdaHo790R8BH4qmNoZwyYw87zUNNWl3rHtanHypVQDaN6tV/jwx/oOLJal1j7FfaI1b96wX57+d+x6ZS05jXuLZfAtzbmTzAT0lc0Jxb4DwQjGcX8nQi2SeDPSBh66IAUqFj8Qa5fIzMrJZeFiAhr10Kf7wT/9ZnB8aVFvP4vG0eEDX7fUYjfJF+svYLyZyelHX0FLpfK5+hpffAqNrpFbaXhw/zZuuLq8bw7cFG6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdJ95iUPa8vjYVWMej24FSv5Oggyfd92h8+N+k2OMLY=;
 b=OVNgv7p8clkIAx+ABw1Jou2V4JKUXeGlb+Tpkx8+w8n6lPTLNY9mxt9ROomP8ZsnJuQse4Jgc/hhp2SakRI8v+L6OSy7Tweja+xPpwgUJJFHbZfoKX/uU0+9uzuMrDtgjAcydQWeVbb6Xa06GlG9GoRvlvyl1aDA0NT68G5e6WE=
Received: from CY5PR13CA0035.namprd13.prod.outlook.com (2603:10b6:930:11::24)
 by CY8PR12MB8316.namprd12.prod.outlook.com (2603:10b6:930:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.13; Sun, 4 Feb
 2024 03:26:42 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:930:11:cafe::8f) by CY5PR13CA0035.outlook.office365.com
 (2603:10b6:930:11::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.12 via Frontend
 Transport; Sun, 4 Feb 2024 03:26:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Sun, 4 Feb 2024 03:26:42 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 3 Feb 2024 21:26:39 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/6] cpufreq:amd-pstate: get pstate transition delay and latency value from ACPI tables
Date: Sun, 4 Feb 2024 11:26:12 +0800
Message-ID: <4e21b25ed21e3718cade07d3f72eef1a96cd7135.1707016927.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707016927.git.perry.yuan@amd.com>
References: <cover.1707016927.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|CY8PR12MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: fbfe2b0c-18bf-4e46-744c-08dc25311b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a9bco9Z/LFAy6hW610w7iei2CGw9xTY6fyd8/X4aMF/c0YcsvV14f8ycJqDtwYKO8tiEm8zjW7swTAsElOLRTLxOff1Ib2aKtiP5/T5WWiKh80YZJ91Ud4SE4ti9wLiMWi2ULMGmLkXchvv72Kte42XUnwV2S1NSf5FpmAXH7w1aFsWTEKKJleZHhAs5pDJbRMpe9N8TK0usEN2HASX+IzEb2svUVttPCum/svv+h9ceZpf9WcIc2IfGqZrzPw2WbyOxfYdiRAMUvIvJrkBTk54N3XgFNt9pGvkqICD/URkYnlkm8eID2DOkYgmu+sDf/RqKFlKn34ofWs9eWb7BBztDz3ZmnJ3okmbneWGgoEttlgbLAYCyVzSWb4TQ1SjVsvN9+UE8Bcfml3iobRNI65chBz4prHvArtdB/xwV2TrSFQkn4CWxYs3svsa7izyNoA4uJEyU1ddndcj+6fO/YQZKDGsUSfGJA8YB5tiDWuKGATpzTo20PPD2Zr9MMYUM9dMkIPv/2sz6JRolCeQXXeTrw22OzN9m8eEcVrv+CPJGiUOkRxTjx15oyZtchnAn0xv9gzlPgAJYtD2eefOtYAIyMX3M7fK9XM3CYsdKuh2voIIbceL+Afd2B8PaWCiGOcSsRYL21ZcQYoVwaXqxBJrB6F6RZXx0+8qB9XWUW9TAv4fvMjxpGis2+8kXG2YhSd4foGdikw8crHIJ/ZhIMR9vr1HajNubjESdGzr2m6KV2wPvtUWzwbFzg0ZCLoT+me7AN25tig/ENYJp8EYPCw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(40470700004)(46966006)(36840700001)(5660300002)(478600001)(54906003)(7696005)(6666004)(86362001)(316002)(36756003)(8936002)(8676002)(70586007)(70206006)(4326008)(6636002)(26005)(47076005)(110136005)(82740400003)(41300700001)(16526019)(426003)(2616005)(81166007)(36860700001)(336012)(44832011)(356005)(83380400001)(2906002)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2024 03:26:42.5144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbfe2b0c-18bf-4e46-744c-08dc25311b96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8316

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


