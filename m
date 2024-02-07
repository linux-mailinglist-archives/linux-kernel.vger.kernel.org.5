Return-Path: <linux-kernel+bounces-55867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C332F84C2A7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BB1283294
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE87714A8B;
	Wed,  7 Feb 2024 02:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bDDw1EIx"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E716125C7;
	Wed,  7 Feb 2024 02:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707274019; cv=fail; b=Zy4vhjOHL23zqOFuvKQXFaX27frUO3Z5pWdPcisbjOjDorhy08IUycJ+VTQVqwfAk5BMh/tkPuUgbAKrp1sYdJRw3FNlNfu72poG51Ye+xbXGO8i3HZeio9RclcHG3E6sHkpc3ZgIo/1IEsUSri+5pq47//gqd2UXYO0jVE0Grw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707274019; c=relaxed/simple;
	bh=i0/3Y1RcrmO1kxZ8mQEqBybxtj69hjageTPfY0V6nOk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UMDSPQfifydQE64O8KvPvWgUT1FcsfUPUmaQnUQ+fdfkxpMxlr7E/tza1FhfzHMb6rCwrTdZ1Q/qyeKRynP1M7kaYg9xErfb+stG/rngr0oZQ56HYtS6+/x2vEGL3nrCJMREr90LRXsewdl5I5UhNP+0LWh7uZJI9j6VJTcHaEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bDDw1EIx; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+0jGao7w8/GBj19umeJhBaBfkKsBFxZ5/KIjKzIe9GkOrkUBlrmtxMy3nnb7KuJFjCwk1HbW1reauyLAigCzyRzG9qZT/2wKM9oilvDOsGdcysZNeLl31CP7sgghbKh4/6e6+AljvYURDzjNDbCdrbxN+dws48DQvGJakawpelAEzVUuXqyFNDJ5QeV3i/SkbJUuZf9mNt0QlqLviE2Stkry4uMw9BBv4927QYXAfJmifT7naOf/2pDrye5swA1TdaTvNq0UQ07WTCAjgpnl3umLyUIFVOGwjMqsj4gFDdY9+2+3FMDoL0hp3ZUFNBoqaMpwD049TwodxisnRJ5Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJsNScROKFRLlT8Fo4CMnc5T+PlU3Oq4bkHlyx0RmNQ=;
 b=TJh7tVqYhEHVEbn+NqH0BOVqI2YLD7EMZEsU3+s5SQ4jXpRQOZ37jZD8e/OGRk58dft5GcJBmeJ43z48CREGtoVrsKHVDXMkvvKeuRxe41fjWeD45AmDP1qLN/8iast2Yn0QsqSvFzNOYoLOHmO5M5hTfFDIxB+Fk1TKbZfS9/QbLOW6/m1n1F6H8j0fxqKnqTtE4pGij/6FzZZVHcUUovAYwEUbXVU9yyWOb/gUYDiYTeEsG0ob0PgbiI9N4k1uv7WcK3mPH4pkHriuqU++V2mFOkcNJP0k3L0FvvNhP/vG7jxgw+CorDL5q9KyJ2nFw9sWGMYbcjEEyIsReB/qeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJsNScROKFRLlT8Fo4CMnc5T+PlU3Oq4bkHlyx0RmNQ=;
 b=bDDw1EIxw9qA9pgVBNnribZpZrLXg6XdliRFkrpLkENr4JrwFhrMsWFdHwzepdW/zykIpeJDo4sBipL6ec6QGxUYlStyGR4Ii2HnBVBlzniRxpuLFFyLOENQ7dR+qryHpZQ5oqilRyZw7c7qH6DY+9c2awC41PEDPydZEy/gVTQ=
Received: from CH0P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::15)
 by SJ0PR12MB7067.namprd12.prod.outlook.com (2603:10b6:a03:4ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.13; Wed, 7 Feb
 2024 02:46:53 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::2d) by CH0P220CA0007.outlook.office365.com
 (2603:10b6:610:ef::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 02:46:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 02:46:52 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 6 Feb 2024 20:46:48 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 3/6] cpufreq:amd-pstate: initialize nominal_freq of each cpudata
Date: Wed, 7 Feb 2024 10:46:12 +0800
Message-ID: <b4fcf3b4c2b5abcf79bbaf9780fe67b4ec697dee.1707273526.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707273526.git.perry.yuan@amd.com>
References: <cover.1707273526.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|SJ0PR12MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ea48ecf-b828-4202-7e45-08dc27870a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fxr/h04ChVU+0CgguyYHB3gXSCezG51NZIVasLgSHpNGoVikZj+bRF1Oymmci879jc/FhQ4I5CpLEHet8TJNI9EyF9suDUGm3wr3/prP3d+AzqijF0tw/DiQrzZuCZVs997VhS4lELeSeXTHgMtBXEaAsWTtlU2GzNcQJoUu0ug6fPp+k+ML2Z516uzAV+tawdbkSDGFbtxiNoHmxnHunvGc3uqy04DLbdBq+4DZa4fj4RrPM4TU8lW2O7M6eBjG9A/FHMon+hqTJYBRQtaHkwLZx644huqfHBGb7L27al1FxmD4OlGeWLR8f+LfrkNvexYhno9ErUqBdPFZVUA2NPtD4zZ/NeR0koOpTdnaD+Qpx7o/TQv7oNirmtILvajl6CTWNGgFJTyhWSXhYudw0D1lRAG4ZjO648g08gu6mujxsFlZieUz3r4iVUc0yWlxktVLxJS/o9kBCSNYlt0wygXA8bpTnmCf4iJR1mq48bMags1ynJ589ao7xjyy5NbbejPmhK8QSUemAilhcJF0nTcsOR2iDiHb5Dke5Tc489W+ByO7PjxhEVkb61MpO/EuPzUJ3uAh+hANXfbLdg9CgobACB7oWnEoQoVHq635noF/7+aEvNZTRp+FyeeHuse5vy09InmKKYEC0qbkNUZZjqwfxWU1t+gwHLftnfaeKBJ/EK7PCwhjQXoA7OpZXk90WqGdl9YQJEseINmcnvL1InPf8sCb3mDYD4zu9ddopQpVJIRG7bJb2a57lU8PcZeSsw5fUGCWnjEoWJjoKPs7IA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(36840700001)(46966006)(40470700004)(5660300002)(478600001)(8936002)(36756003)(70206006)(6666004)(316002)(2616005)(426003)(86362001)(70586007)(47076005)(110136005)(4326008)(6636002)(54906003)(336012)(26005)(36860700001)(41300700001)(8676002)(81166007)(16526019)(82740400003)(44832011)(7696005)(83380400001)(356005)(2906002)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 02:46:52.3667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea48ecf-b828-4202-7e45-08dc27870a32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7067

Optimizes the process of retrieving the nominal frequency by utilizing
'cpudata->nominal_freq' instead of repeatedly accessing the cppc_acpi interface.

To enhance efficiency and reduce the CPU load, shifted to using
'cpudata->nominal_freq'. It allows for the nominal frequency to be accessed
directly from the cached data in 'cpudata' of each CPU.
It will also slightly reduce the frequency change latency while using pstate
driver passive mode.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index ac7faa98a450..ea8681ea3bad 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -619,7 +619,7 @@ static int amd_get_max_freq(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	nominal_freq = cppc_perf.nominal_freq;
+	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 	nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	max_perf = READ_ONCE(cpudata->highest_perf);
 
@@ -654,7 +654,7 @@ static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	nominal_freq = cppc_perf.nominal_freq;
+	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 	nominal_perf = READ_ONCE(cpudata->nominal_perf);
 
 	lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
@@ -848,13 +848,14 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 		goto free_cpudata1;
 
 	min_freq = amd_get_min_freq(cpudata);
-	max_freq = amd_get_max_freq(cpudata);
 	nominal_freq = amd_get_nominal_freq(cpudata);
+	cpudata->nominal_freq = nominal_freq;
+	max_freq = amd_get_max_freq(cpudata);
 	lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
 
-	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
-		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
-			min_freq, max_freq);
+	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq || nominal_freq == 0) {
+		dev_err(dev, "min_freq(%d) or max_freq(%d) or nominal_freq(%d) is incorrect\n",
+			min_freq, max_freq, nominal_freq);
 		ret = -EINVAL;
 		goto free_cpudata1;
 	}
@@ -893,7 +894,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	cpudata->min_freq = min_freq;
 	cpudata->max_limit_freq = max_freq;
 	cpudata->min_limit_freq = min_freq;
-	cpudata->nominal_freq = nominal_freq;
 	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
 
 	policy->driver_data = cpudata;
@@ -1310,12 +1310,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 		goto free_cpudata1;
 
 	min_freq = amd_get_min_freq(cpudata);
-	max_freq = amd_get_max_freq(cpudata);
 	nominal_freq = amd_get_nominal_freq(cpudata);
+	cpudata->nominal_freq = nominal_freq;
+	max_freq = amd_get_max_freq(cpudata);
 	lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
-	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
-		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
-				min_freq, max_freq);
+	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq || nominal_freq == 0) {
+		dev_err(dev, "min_freq(%d) or max_freq(%d) or nominal_freq(%d) is incorrect\n",
+				min_freq, max_freq, nominal_freq);
 		ret = -EINVAL;
 		goto free_cpudata1;
 	}
@@ -1328,7 +1329,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	/* Initial processor data capability frequencies */
 	cpudata->max_freq = max_freq;
 	cpudata->min_freq = min_freq;
-	cpudata->nominal_freq = nominal_freq;
 	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
 
 	policy->driver_data = cpudata;
-- 
2.34.1


