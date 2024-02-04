Return-Path: <linux-kernel+bounces-51626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6424848D73
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0EE283044
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB4722EE5;
	Sun,  4 Feb 2024 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zgim8a67"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF15122611;
	Sun,  4 Feb 2024 12:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707048808; cv=fail; b=Lo76Wa8EgJ42OuwbFutokYI0Nm3s1qCl9unTwLTNqAVg5Z2ypKxLTrZo6MVzDkvf/RlDBGWhbIF8ICZpPWfw9FwkZZ/kMt93gbZBJA5mv16QiMcUc/ZmfHke7+IFr649ygCP3rcf2zrPFKt6NKjYtKIne/fM+eNZIkoewRjy7j8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707048808; c=relaxed/simple;
	bh=p6YIHsEmshgVwr8zNfOSfQef6HC6yEn2zPDiz+IX2Ag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X7JzhjlnhlJgVWfnAv920Ceazr+WMsOyMji7oV/xEs6g8tHZBhaajbVbFbWhIuFYErjwxTIu1UZwmxRMfAViFyx/V/sicXlazVfmEf+jLE0W3fWEGY3lcZ2Zpr9n1bd64+DtM05SVLP55zTBO4g/n5PZ85BwY+O/5OznAEagbpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zgim8a67; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S72Fa+3soRLfFgz7wmiWRI17TiAZZM1nf+fl5ZaWw4RBbb3LJpl6nBD+hYkzzJBzNCh15O8F4W7WKPRMTXnAg/STH+CGCe8XqRQ8h7ar4t1wDnVSaOaO9O79+ufQLgUrUTsmwG+V7n75NOjJlAQOzSOwk1sOGJ4JyMyDSEiLm7QzW1Hw4zmBuFPN+IsSuWaTF7jYm/GOXhPyZd02QQI8k9Tqvz4qS90YphN4tUQzihtq0QjBEn4NvYPT6pflb9jMCZCj8DBVD7hzQW1sIAax/03IJ6vy+7cXmyjCDP8Uu/1cM8dG7KgBjaIHGb5kT9m++1q0Mto1pOz/Ido6Raak3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWSFHE4PdTXGLrLjlXsOIy8ChwaYmHvL0SlWmXp5usM=;
 b=V10VlAj0XU4K/j160pFQBLsZJxYBjDvYSLmg3SK5dxJ4gVm6o7JY1tR9LMXbQMzVlFTyz3qedgGnP10LTy2Kjhbop73UO0DGtxRKNUtMcSN3801dqg1vnw6QtF2H5FPT/kTRjji9m78f0IobZCT/UknwpbA/QV1IUtqUKbKWrgqlCwZ6fc1vdJxqtCV0LAjw0EGyabd6/jrqdo4z+DW60+9RZT8VvmjnBA/1i70hjwcairV+Q4y8aUsrj4us/vDHClNnu/9ynGzcuncn6aoI1XoBTPjPM+H3NKYnyPsrsauUYlY1mrJAVMJzgh+hgzkctaonMvTviR1+RjcyS0k1ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWSFHE4PdTXGLrLjlXsOIy8ChwaYmHvL0SlWmXp5usM=;
 b=Zgim8a67ir1dZXAQiQM1RJhmO7fv+MS01uL5HL4ViW/Q7q+PZpT83R4J99JFsW49vdw/Pc1pLeT3XU8uIVgRUMqOPfrgh+dcFsX7vDO1/4RuWr8NM5A3j8ZcKJHIGQZP1fPgy7hhTNnFL5Ianm403eRSk9EGc4bDicIlIp9RmsU=
Received: from BL0PR02CA0043.namprd02.prod.outlook.com (2603:10b6:207:3d::20)
 by IA0PR12MB7674.namprd12.prod.outlook.com (2603:10b6:208:434::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Sun, 4 Feb
 2024 12:13:22 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:207:3d:cafe::4c) by BL0PR02CA0043.outlook.office365.com
 (2603:10b6:207:3d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34 via Frontend
 Transport; Sun, 4 Feb 2024 12:13:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Sun, 4 Feb 2024 12:13:22 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 4 Feb 2024 06:13:18 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/6] cpufreq: amd-pstate: fix max_perf calculation for amd_get_max_freq()
Date: Sun, 4 Feb 2024 20:12:54 +0800
Message-ID: <c9af296855b925db4734628eb0694b2bf1d93cdd.1707047943.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707047943.git.perry.yuan@amd.com>
References: <cover.1707047943.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|IA0PR12MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: e96db40c-02b0-416c-e2ab-08dc257aaea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H31s0R243jN0YyX6Pgq2LSlUFs+WKq/bmlY8YArdDZxbZfJIbmg9QLNCOX9FulVOZDvBvmFsSpIrxWMYZbafV6fgXWNT0Z5W5h+XFOV2C+CUVenBMk1YHIv2bRqS130aENqmyLVPuYkonGEgsk9+iZFQ6SfS8btXtVSRAYFl83ZjIInMefcR/qDbYiHSWDan2WEHRVNjeAPs0wQAqkL+gDCj0w1CyjflI/zOjM+VlEGXdTtj3UrbJ1uhTHOLs9MrJgUIfKBjaIpwgF7DUKCyrPaZE98ZHGxh2Ixv5kobl+LQl7FpPfyjrEKk2DrOxloIKvogAhwhgNSI6MNnzE9JiaF5OKnx3UBm/9BuqdP7i0MYuq1sZEyl8G6/GsGTodH7vpf6I5iUtH+loYxNbXCHOxv7tLYPUGCIrkUdttEOAmCCFLzjCxU+GqixSCepZRzYAt19eGAexCl6jBb4+lSVbDhEZU2H4pokybtYAoap32xdkymr0XOLyOP2r8huSnhbPW/EQpfzJz0rxaKUAEMfgH+cEN7psfh1WRh959YGEUlLQ7a7AzazFxFGM83Ay7aVdeT4NbbYXQZP83+3bfbuvyXw3bffJ+zoTz02zhpLiRDE+OcQS4KFLAz/3C8c4KJtkfN5O1WWkDN4VinFSpRzeBxXQlDDagWuULMbFvj5KtHf6AWsF+z0VdRoK0QkDpNyi5G2KsVO4vsPM6b59pvPdOyu6CDlnaxPWvtGlat8wOFN45vkYn1iEJCR/2c0s7sSOK8iRjI4u/B6Zl5jiRH2YA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799012)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(36756003)(478600001)(86362001)(426003)(83380400001)(2616005)(336012)(356005)(82740400003)(41300700001)(47076005)(16526019)(26005)(70206006)(54906003)(4326008)(70586007)(6636002)(4744005)(5660300002)(6666004)(7696005)(81166007)(44832011)(36860700001)(110136005)(8936002)(2906002)(8676002)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2024 12:13:22.5865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e96db40c-02b0-416c-e2ab-08dc257aaea6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7674

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
index 018ea7cdda2b..107883cf0877 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -599,6 +599,10 @@ static int amd_get_max_freq(struct amd_cpudata *cpudata)
 	nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	max_perf = READ_ONCE(cpudata->highest_perf);
 
+	/* when boost is off, the highest perf will be limited to nominal_perf */
+	if (!global.cpb_boost)
+		max_perf = nominal_perf;
+
 	boost_ratio = div_u64(max_perf << SCHED_CAPACITY_SHIFT,
 			      nominal_perf);
 
-- 
2.34.1


