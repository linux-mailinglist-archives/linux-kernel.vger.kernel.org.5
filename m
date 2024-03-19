Return-Path: <linux-kernel+bounces-107243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4279987F9E1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7ED9283062
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6B27E586;
	Tue, 19 Mar 2024 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DiGgMZaS"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2327E566;
	Tue, 19 Mar 2024 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836969; cv=fail; b=Sf9Mqv87reA+npwL7NdcYJb4k4xrTivTVctwgMmCaM9oleTxfl8r6B2MoGygq9yYP+JPD4rixMvBd+Rua47AV37y/eYi7xLgVLPo6/g8IujJIKzYmkMq2XvLX3B9erJezQW8VgiG7AZX27EbjIS+vQIltnuZBQyMJvjaECuTgaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836969; c=relaxed/simple;
	bh=Aj6Kakriz3o47gqD0vZBTkwmgo2OVyeTQh4cv5+XaEU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AUJuEQdbL2P699aIBzAW+bbrZ/nNQ7cbGrJwBS417LiBH4XZ6FqNDvp0j1uvCZGs9GRndTYeHbG7bEH8pqZUyuLo4/rCV8rWbmbTDgmfL9N0iwniXptxjIAym0dl7gX9QEH65WfWC14zo8Zn6cyTeaIyWYhx149wj+SAvb3YZoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DiGgMZaS; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5i5qrszL89Sg8Hg781b3UwiWvWk2jyeLwkcl6tQCaPlw56ofe758L1v6f93mGSwLF+pSmj42AAH5sJqsnLy7jBQo9VBFpAxsNCtJQsRfl8KGOZHECiMEXQ8932oOyVKx6Duy0jwMS8ceEyf0sGF4qb5tatXAwyl0odNke82yj0AJk3/Yh8vemOd5D82NOz3s8D5c8AuaNAO7X+O/Se7fHZvT7hmTfFjYNJhaCzZpFAy1xBW8EV1v1SifFcr1+gGk1mmJdSziPHrwE0YBBsnoCYY5gHGQqsOkHjrls27SVv+V+KrU/FtjnkzT9qWKama3o4W/rZqAoCJAyYmM+EOlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXR9F0yX9ODoVqI30hVZKYuStWA/HK4vBspTAUoMX3c=;
 b=S1c2LS0TVya/TDoM0fTmp97e/OduFoUGcsEpWZ0z0TgMsPvwodZ8OFf8ASAS0xs0zQip35vLiVjBH/XxNlgrM0VQMcmRTEg1ZyTgRfQ1c3bQr1Y0dT4L7XcKUbrg1zww/1DcunfoYKtKX3jD88jaKUf90ikfCB/8AUMYrhZlqoLTk1FHOaBRw+CTV86G/65mvqu4kaM5mYx6TciOeOXep/YsCzcCSQKqqVksBqh0Ue9fMHbn9xHbqXkCdMEIcmXCkqg8fz+QtmIyWpvUzmApQI4z3WzJ+RkegGsOjHTcwa2PwyREN97GW6G7UqLCIGrp6d6ydckVcbaFw4Pbc2K9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXR9F0yX9ODoVqI30hVZKYuStWA/HK4vBspTAUoMX3c=;
 b=DiGgMZaScxppCDjsj5+VU2BE0KV0tbtqGUYvTtQ0vMoLtLcWzgCCHwPxko56cNZyYKVH7P72eNnTNrc5G9AXThO7Bzq6sGWnr3xtk4S7c5r1DU8c8GHoavxK9SaC0n01CaQlW2jOmb5VNlOOXiXV5y9QcTBuXfWoM0+fI4YuRP0=
Received: from BYAPR08CA0031.namprd08.prod.outlook.com (2603:10b6:a03:100::44)
 by IA0PR12MB8930.namprd12.prod.outlook.com (2603:10b6:208:481::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 08:29:25 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::cf) by BYAPR08CA0031.outlook.office365.com
 (2603:10b6:a03:100::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Tue, 19 Mar 2024 08:29:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 08:29:24 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 03:29:21 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 6/8] cpufreq: amd-pstate: get transition delay and latency value from ACPI tables
Date: Tue, 19 Mar 2024 16:28:41 +0800
Message-ID: <25f02e3e98ae4b66c11189bc7857de56ba1b129f.1710836407.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710836407.git.perry.yuan@amd.com>
References: <cover.1710836407.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|IA0PR12MB8930:EE_
X-MS-Office365-Filtering-Correlation-Id: 49eec4e6-891a-4fde-eb2c-08dc47eeaf4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1ufozVleMGj7domEmuhisgoPcRtMzZF2jSCS8VKN2TSCinwPlOBVZ0UnM6c9tv7R50ZpqDWhoWTkr6WJvwjfoa3ciYZWcfxMuYTBNJLnLVyTPp7AU14ay6Z09sgihXRmRfe3frIva3BGZCm3rhiJfXdP6Aoasvjw2hrZsCCDrMmjm71UG/Basve12+5lZ4A5rrUQma786O519sEJguML63HiHwsCRV2FhSSXSgRQ+2QScpYCXNpU22t+CPRfz1iIdu+tMURc2BNJb23SyQrvLqzCtbAs8/3Y810jB324tixme1xVtxSeiEOXlCAqnQM2T+AuKQ7zn/AVIbd+brq0KOgn4f2AFgTMFZHwS4T/3+Rw9ljqdVezntOhP0LYqz8WCTiN1x07ihirdVRdBhE4c0DK3tJbKhn2C37aiXY56zTDAVGn64F1BilcHHhpec4K3OzU3mgkK98qxZmNZkhMny9e8pRnWp5CE7DhNjFpdIP7K0SO+QUwVnVdPHWDAKmPEhRxhQ6BOa6NnL6TPHonmQQ7ry5VebZp+ZHoyPtlivswPYrDJ5Q3ImcrlHflt2+nyvdTUieVj+b1K/I/21qICI7nyN/Az0kt+3StcowtAJjp1M2p680CGI5Fqt7A55oJr9Fpd2SBLYPsHBbEk4hIijyxIJLQQGg4QMpq9UBXUMbPBGdi/YkGGRbHW/n/cYXAXOTCzhKYJFauPSL9hFQqpAgXkJ+DMAT162/q/dN+49niem5E4/9VIyZT+hDmKjVd
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 08:29:24.7294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49eec4e6-891a-4fde-eb2c-08dc47eeaf4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8930

Make pstate driver initially retrieve the P-state transition delay and
latency values from the BIOS ACPI tables which has more reasonable
delay and latency values according to the platform design and
requirements.

Previously there values were hardcoded at specific value which may
have conflicted with platform and it might not reflect the most
accurate or optimized setting for the processor.

[054h 0084   8]                Preserve Mask : FFFFFFFF00000000
[05Ch 0092   8]                   Write Mask : 0000000000000001
[064h 0100   4]              Command Latency : 00000FA0
[068h 0104   4]          Maximum Access Rate : 0000EA60
[06Ch 0108   2]      Minimum Turnaround Time : 0000

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6708c436e1a2..ec049b62b366 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -756,6 +756,36 @@ static void amd_pstate_update_limits(unsigned int cpu)
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
+ * Get pstate transition latency value from ACPI tables that firmware
+ * set instead of using hardcode value directly.
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
 /**
  * amd_pstate_init_freq: Initialize the max_freq, min_freq,
  *                       nominal_freq and lowest_nonlinear_freq for
@@ -848,8 +878,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
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


