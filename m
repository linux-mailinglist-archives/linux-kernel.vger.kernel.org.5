Return-Path: <linux-kernel+bounces-49520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DC7846B63
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409201F2B96E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD2563518;
	Fri,  2 Feb 2024 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Iqrc6oyZ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4506663512;
	Fri,  2 Feb 2024 08:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864211; cv=fail; b=o68ibSrsFpqVnUgcgNGCrl7I+icQtyoQ4FuCe5ldbb+5AZTvSO9TIAsLBow6+vurzyq+oq3AFX2hxAeOr+A64RQ14BFwSRQAj4/8B0IiCDeAuSuUoyoNpvWC4yBxO2c2BelxBqI7fLdi1mut1oX74phw8/Up4fJI3pveevr8svQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864211; c=relaxed/simple;
	bh=bWnyWjWQFuMjC204Y8elk5xFuwTMRESzd8hyhx49RVs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KsJ7kZaxnj2XG1SrtttPcYu+R7o/6TAiNQNQWFPhQVLpMXc6ZTqMTLMdujH8bnJziawEiQQnd1fGISwjzVNprkmIgS92ncILZHB2LUXTAtKLbCVyrMBjEhMxn9MCCJKF0s7WJJNcJBGBjVnBCgb60NNzCb1+edCtKq7EzB3WZm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Iqrc6oyZ; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDLGZrjRlQAMngHT38Vt7l3CF8F4l0ThGZCovNdm9D8XXbW8y+6BSYnsdMsAf88+jWI90OnxhcFK+wXUmulpestcgYGdno0JD6NEDjd++RDNJNWZfySe9GqFthiDtUIMFTY/jxW/ZyYP+7ZVgOtjOGwkPkawF6L03h6jddsvJInKI2QbRzVLRiqVAnZ4uMMyNyUy6W7unmELXLuSxB2AeOqQvr5It8HOUo1tX5oO4vQT8s9LUm92DjgAzPhk5pv4SxK1vvgmUzg3VJqO1D27+4p8FC9zHZERQ9LGSLy3ctekLJByY6k6rdbMWctJudr2FXmBWHmZicS4FXwiRw/7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdJ95iUPa8vjYVWMej24FSv5Oggyfd92h8+N+k2OMLY=;
 b=ICvT/vIf6+aDdf4iw3xwXDr2ckYNrCGg0NpB9aZjhTGt+SLZA3/wqA3dPgXpO89FzB6yrkB/fajH3ooWPicMZjTTAN3g+2UyTsGXmwrvTaVOKCt/gmuOjt3enpR3BbhwIrUkqxgXQR+O1iBjcejokLAuSBFLCoAU49/aqODLzaa0/bFQaa5LCuqAWbi9gooD5EkqB624eKBcpTpXNeFDHSbhFJPL3Ie3sWf6Xi5t7CXGylwB9XLYK8ieThT/cRVorNBnvCsnM277LMK3eu6SorMhCnMThDpiCz+ghG20+nZTmu4mKp2jNcH+XdYBKDgDGQscnr6RjlI20TeEQVJC/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdJ95iUPa8vjYVWMej24FSv5Oggyfd92h8+N+k2OMLY=;
 b=Iqrc6oyZdwuxe06u8ex2mo/6xJSYn+h5X4XLeIGbRt7rXjkbPw0H1mDOkRVICQmHf5EJDpFpS7nT56VbASDGvVQj19YM21LOCZB6AOPxPQUOZYyIh7JXNFZOziofTNbOYV426TpVDJokD4i37VAX6y1lmYbSOg1V7XpRHp+TdRs=
Received: from CY5PR19CA0128.namprd19.prod.outlook.com (2603:10b6:930:64::28)
 by LV2PR12MB5824.namprd12.prod.outlook.com (2603:10b6:408:176::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Fri, 2 Feb
 2024 08:56:47 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:64:cafe::c2) by CY5PR19CA0128.outlook.office365.com
 (2603:10b6:930:64::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29 via Frontend
 Transport; Fri, 2 Feb 2024 08:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 2 Feb 2024 08:56:46 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 2 Feb 2024 02:56:23 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/6] cpufreq:amd-pstate: get pstate transition delay and latency value from ACPI tables
Date: Fri, 2 Feb 2024 16:55:36 +0800
Message-ID: <4e21b25ed21e3718cade07d3f72eef1a96cd7135.1706863981.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706863981.git.perry.yuan@amd.com>
References: <cover.1706863981.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|LV2PR12MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e8dbd5f-1bd6-4740-0877-08dc23cce309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3seLaWfYc/IHsup1zwc/gcdCjaJQ7Q+ygfs7J9o2ZpjvFgIiRHCIJLvb2agutlqgzgk0T8BbH5E+SOZ1UIPN+H6H3ZYg1ptnjkaHbeqFDV6jyr2wsa6qZ2kmF3KBUmwxqHg50O3uOOSDkQilk/Pr8Ix7XEV5ReewUrbmMjYDwKurqstWvjEJLBNGOedd1+uvpcx+EpBTAQjrbqygMqsjSedGIJMq1vyl5kFc7jD31uVe9MxTP//unZ1iDptkOw/zZ9p5XYZii0sil6Oy2xyIarJopvFTSujz0EsAbkH995B0Cw83ZjtUuTxl1B+QE61swbQMde47sbQcmuCx0i51vScPmwtQ+haLJu/8tfnKbgj/YEwR6IKEbrk+FASAmvqPzLz3MGSxV4TfXizSrGsqJelK4MYHJHm4ExucpG68NabxyvWz2sOTqTKm1UXo/vHmemHi3J1GslD0AQ9JSZgd0d4eYFRb8X/eHILGBpEk4JZP4CBbXvEJkOhM2lXcCOyQ7Tx0FR+YQFXETtLL5YCSOp+bQpxKAGyk267G9eF4cuSxYYsTE2WkiQC3fk+99Sq6Q5uFSiEhYCT6awwj2Z2tKpUH3eI8L/u9uk2CGL5WXgmKCLIvtiu+SSMdU29GmePyYUg+5tJzqHVavhMvyj6Ld0xCvhOiefWZIkCGYKumaagUN0GD7vrSFEx8KQaB2bK/xe8NVeR3W8rGR0Ex3TeZs0b8aI2nBFKcyaInhagmNWVcnor0rMGOz8hXwVk0ECXi8knLFf2qd4B2YN7vSwDe1Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(83380400001)(41300700001)(16526019)(26005)(47076005)(2616005)(336012)(70586007)(81166007)(36860700001)(426003)(356005)(7696005)(110136005)(44832011)(8936002)(2906002)(54906003)(8676002)(316002)(70206006)(6636002)(82740400003)(478600001)(5660300002)(6666004)(4326008)(36756003)(86362001)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 08:56:46.8150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8dbd5f-1bd6-4740-0877-08dc23cce309
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5824

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


