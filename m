Return-Path: <linux-kernel+bounces-39746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F4883D5A6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B5EEB261B0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E5B6A01B;
	Fri, 26 Jan 2024 08:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Oe1lhNwj"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9B06A011;
	Fri, 26 Jan 2024 08:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706256548; cv=fail; b=KK91O6/sUHVb9bwr0HSuSK85trSr4XzVSWUvBkJYeSYbqqP/QQ7oiJXshaw4FgwRlWQGOAwnaihiPVE+1X1ZKUuRLW9E11AFyUIF9rE2jLAB2ZGBbawb0PU2cM7d3MGSkYdGxwp8M0thGyRkjRMG49+EjxkmXcPrpDzkSQISQB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706256548; c=relaxed/simple;
	bh=M4/qwvxU6Y+sZcnEZ0MOa/RCcaIUtKNnuvnxPqz/xQo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXwQv6bp2FiCaqjVdB0gQBZzsi66aryrGzZGLudM7Kipc6rrXy9XK0RUd+s5fL7yztzSXe011w0gci9OaN28WP1mph+03y4Ne67vwg8MI6mC9ROBYJtIh6BCOq8wXSD0goeIFUsq5bA/qU+o67CvU1AFF0+FJ9e2WmYl62mbNpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Oe1lhNwj; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZSMsXr/UesJeUWuDTZPJsR0yiFg3jUebIEpo26NBgYf4f97UN4oQZ5jIrTqXUcaglMAXlk6CZYWT0fcDxhyF0TB/Q0We98uQwK3+h50xLwX6uuwBU0eBCbIwHGJ8p+OWPr54Sj8kDISPTPkhxXSj4poJ4nm5p7qZ93FFkS1ZfeX/50GB5WA5uAC6ADQjTv1jdSBdVPL/NYPeBzxUYwBR4gaBBEKYdI4pMLWC8pEykRhtPyO4dnNxX9CwfbKOmzfzeikYAjSYJrVfJYdO4KdrTu+N8dah6OW+e6YsUL2dwb5bqWM+1ZFoQFXFFcCcEcjcH8gYExwjcWkxVW2ew1tpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSVXH/Glb4osiEi1PuWUEzoJaQnYF588omniEI8iyvk=;
 b=g5WOEq3/tERSGKmdyqtKru0dVoMmktcsUq21HawoOkUVh29D2sd0XlWXoeiI37kKndJrUARmWEQee31jfi4cN4sI8Ggk6zkAmZsrmFGyoJ9DaptzZq3pN+ihk0yDoAzzUnjPoXT8+MWYKT7zUiBXpTxOMeb7oLMjV0HIGxcDM05nQb9Y2WGdglDNQWyt7dn9BQja4ow/otMv9yrrJO+/vH1SS6MLeo0m75czxCHvH7qmCmV42QXTvEdSVGykTYBl4ixT3WL5t+XnkgmO9PcEXSAm8/1OBOyqN36vSYk5EaiEsrlQ7M7mqdL5KD58PBXpWfW6gdsldioX6DzjD8FeAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSVXH/Glb4osiEi1PuWUEzoJaQnYF588omniEI8iyvk=;
 b=Oe1lhNwjxutrqTSYn9Z361bUERNNuIhN9kNrHZubzQl68I6UzA5QLLD0AjG5P1djx7/qTfZJxbOuFIHVBBdprpeC63QnSlH9tz9qdX4gFb/Z/pP36ye7lYia0PU1U0lkiXP3F3oIjBEkeQr2b/0uf89W7tFeZGNOUNJTrGkP11U=
Received: from SJ0PR13CA0135.namprd13.prod.outlook.com (2603:10b6:a03:2c6::20)
 by DM6PR12MB4172.namprd12.prod.outlook.com (2603:10b6:5:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 08:09:04 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::f0) by SJ0PR13CA0135.outlook.office365.com
 (2603:10b6:a03:2c6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.10 via Frontend
 Transport; Fri, 26 Jan 2024 08:09:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 08:09:03 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 26 Jan 2024 02:08:58 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 6/7] cpufreq:amd-pstate: add suspend and resume callback for passive mode
Date: Fri, 26 Jan 2024 16:08:09 +0800
Message-ID: <fa430f6288744c760145f4acab952c2bd0f947ad.1706255676.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706255676.git.perry.yuan@amd.com>
References: <cover.1706255676.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|DM6PR12MB4172:EE_
X-MS-Office365-Filtering-Correlation-Id: c69c41a8-2d83-4a7c-81ef-08dc1e460fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1g+umRVw36QsDv9ltFeoGF2780uBo04cbuhvNlZ/3Kdvrnd0IeecqN5IH03ylMvkJOruZU8kOUUSR7OEaAkbjllCBw7aXlMoKJASH9Sl4KQJ8EaMdda4w6Rq7xcrX3PL7lybMVOr4rwqKp+ngabHpNLruF+ncsjCeYV5ZWLaBpm+fCSbr+h1lmpRun6rVE6Up1NMzW6qVA8j75IuwHq0Z7YaHXupKQePa4QIX5q4XFVGH0++5CIkCLEEJKJiXioyxMlgYHWiSqrYQM0/zOare0WhxcJcedGAC/N3whmA6Oep1b3AHrzvfx8uPl/Ch3borghUG3InX1DUTER4EDywEzhUiYbc0hU7loMJiT8radiXCoS534if7YwqcP7SB3R/fcrHGCz6aKwWnUGaMA8qjOi9j5ba9jgPgHeN1pVEw8XV9hqKgkLt8LAMjGixJwtt8/3D95jMoo5dNX3idCQt6QTWOUUYfknw8BmKksBhicONpIiLTALAK4NJrj7Oy2OUWyJlHmUZeJ0adBdAksoZnc2K47BfPpvDnp2fEvfR6ZAt1ggarepgA2sxXsAG4PqMGg/N/WwKD6fc4ftN3LW1c48XF6AJdrkklgwu50NZYcVEZZY3U0hs9jXxqd0stNrSkBAvw2zvF8mJ40eTUxZh6/A5jp6QgHc/ILlwflbnlyFD/AAc6pKqzjwOwYFN2KtkVlaQ16tfTmszwoAzaUZHOrJgH67GtD+k56DATJY2FMC7WMwGkZF94i2x7qn677huvQULCQeAA+Gh5yYwBF+TkQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(41300700001)(26005)(16526019)(2616005)(6666004)(7696005)(83380400001)(426003)(336012)(8676002)(8936002)(4326008)(5660300002)(44832011)(478600001)(6636002)(316002)(54906003)(86362001)(70206006)(70586007)(110136005)(356005)(36860700001)(82740400003)(81166007)(47076005)(40480700001)(40460700003)(15650500001)(2906002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 08:09:03.9245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c69c41a8-2d83-4a7c-81ef-08dc1e460fc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4172

From: Perry Yuan <Perry.Yuan@amd.com>

Add suspend and resume support for `passive` mode driver which can save
the previous CPU Pstate values and restore them while resuming, on some
old platforms, the highest perf needs to be restored from driver side,
otherwise the highest frequency could be changed during suspend.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 48 ++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5cbbc2999d9a..bba7640d46e0 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -785,23 +785,61 @@ static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 
 static int amd_pstate_cpu_resume(struct cpufreq_policy *policy)
 {
+	struct cppc_perf_ctrls perf_ctrls;
+	struct amd_cpudata *cpudata = policy->driver_data;
+	u64 value, max_perf;
 	int ret;
 
-	ret = amd_pstate_enable(true);
-	if (ret)
-		pr_err("failed to enable amd-pstate during resume, return %d\n", ret);
+	if (cpudata->suspended) {
+		mutex_lock(&amd_pstate_driver_lock);
 
-	return ret;
+		ret = amd_pstate_enable(true);
+		if (ret) {
+			pr_err("failed to enable amd-pstate during resume, return %d\n", ret);
+			mutex_unlock(&amd_pstate_driver_lock);
+			return ret;
+		}
+
+		value = READ_ONCE(cpudata->cppc_req_cached);
+		max_perf = READ_ONCE(cpudata->highest_perf);
+
+		if (boot_cpu_has(X86_FEATURE_CPPC)) {
+			wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
+		} else {
+			perf_ctrls.max_perf = max_perf;
+			cppc_set_perf(cpudata->cpu, &perf_ctrls);
+		}
+
+		cpudata->suspended = false;
+		mutex_unlock(&amd_pstate_driver_lock);
+	}
+
+	return 0;
 }
 
 static int amd_pstate_cpu_suspend(struct cpufreq_policy *policy)
 {
+	struct amd_cpudata *cpudata = policy->driver_data;
 	int ret;
 
+	/* avoid suspending when EPP is not enabled */
+	if (cppc_state != AMD_PSTATE_PASSIVE)
+		return 0;
+
+	mutex_lock(&amd_pstate_driver_lock);
+
+	/* set this flag to avoid calling core offline function
+	 * when system is suspending, use this flag to skip offline function
+	 * called
+	 */
+	cpudata->suspended = true;
+
 	ret = amd_pstate_enable(false);
 	if (ret)
 		pr_err("failed to disable amd-pstate during suspend, return %d\n", ret);
 
+	mutex_unlock(&amd_pstate_driver_lock);
+
 	return ret;
 }
 
@@ -1460,7 +1498,7 @@ static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
 	if (cppc_state != AMD_PSTATE_ACTIVE)
 		return 0;
 
-	/* set this flag to avoid setting core offline*/
+	/* set this flag to avoid setting core offline */
 	cpudata->suspended = true;
 
 	/* disable CPPC in lowlevel firmware */
-- 
2.34.1


