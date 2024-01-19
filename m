Return-Path: <linux-kernel+bounces-31642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AAE8331CA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 01:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4DCB1F225DB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 00:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0347239F;
	Sat, 20 Jan 2024 00:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J0stu7Nk"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97904EA3;
	Sat, 20 Jan 2024 00:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705709962; cv=fail; b=CNAaUFBz5R6IN3KJZYgYimFqXbx5OLF/4fc5acTzugwKpa3ozJP169ThpyRhNDPUVaNixWgM2Iu/bDtcgBPVrQ3N42QN7ZzJ69mhwsg+8G4W6hHnOHo0lSI0nwt5Vy79g081HlFbOGkmxtpH+6xwEUrT2eBdg2+1hv+kfnsvIdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705709962; c=relaxed/simple;
	bh=QCUZLmTe+r6yLvRbBo8F+jlQq9pH9fGtNGKoZUvUSUc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HZrWk5uIHSD9PW434MCwMpXLTPa5cy+fo50HRuiRfx7GXkzl7tuWYJ+vs/eCNn3OhJ+MrG36KUOWhAsJRutQ0vtPzI2rGgU01gcg6lasj7NTpbKzVk2IWDVdefsuxxWKTl10Lc5W49+Lt7AVTNpnf33secTsSPm3p89SQ05C9M8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J0stu7Nk; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoWuLB0VlppCr1fW8dlt0C7qwXPBuJNYOECrIZnLPNLg491bnhGRWiuEKCm5uAYG/FEOw4e+5ux9o3gKOAe7f+i/WYP8CP/vrRYpFl/XnT4O9qBryn8VXxtuXCyjBc/kjJidCrpYXN4y/MO9fMF4SNHidwIXst2Gt1lnw3EyWWLWEuneLn13yktG3ckYnqKAv7fbyA0HkY4mYPXqY9236nND2Ub8G7IKsHYG6UhOL5aHWUq8YaZAt6geNGL6CHTE/aLxmwD4rQaMz9paIeFFD1pBtmRBDSbXuI0wPbblCWx7w8ChhrYIVCSeyCCx9OUrPKlO37+SKMvy7TVc/BiOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cf4itouiItrbdsCsPFCWZjNS07w9tcXJHynBa3gMyo=;
 b=OgvMuwmuWSnNenOYDG+AXUtrTuF4lm40YjOA+cbd4SiLdK1K9MRLZkWh9fv7I9F8znpl3bIxhuBlaolZ6lXue8cQvZC6RaQopqYsiueBib1UmBMpKwddpikre0SW1vGAgkjJU4kzK331JeP8VA9JAQLyI6OacIG5c3N7kvMpo72oZ9/Gt5r57ruILTKx3oV7/MewqQEFzAn+4nNRRTkoiUlD4c8lDBMe7E6ELCUaMu1Ohxjj+Q04AdWMP5TecTztax5exLbnTu7DE1XRypl2IHR2RAFXYfVry9BV1kCpsJKsCca+lHNvdw+qUZSezJWMprfiMOGjok6x+NMuNGuiTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cf4itouiItrbdsCsPFCWZjNS07w9tcXJHynBa3gMyo=;
 b=J0stu7NkKFwzPd0cLnaIA1OX2arVdJA4wiskUVyMv8mqExcxtTPgfU3ucUtM0rUGiC81Pfu2aa0zNoNdCnbn5DfkCyLLHIDHS9n2noT8RwwldaIRXgwSPD4zEqc+NpdLKBmxHrAiwQFtSdwUxmhgM63z/e+AjzonU1wN/a84ZNM=
Received: from CH0PR04CA0018.namprd04.prod.outlook.com (2603:10b6:610:76::23)
 by PH7PR12MB6908.namprd12.prod.outlook.com (2603:10b6:510:1ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Sat, 20 Jan
 2024 00:19:16 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::a5) by CH0PR04CA0018.outlook.office365.com
 (2603:10b6:610:76::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Sat, 20 Jan 2024 00:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Sat, 20 Jan 2024 00:19:15 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 18:19:14 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <ray.huang@amd.com>, <rafael@kernel.org>
CC: <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, <stable@vger.kernel.org>, <wkarny@gmail.com>
Subject: [PATCH] cpufreq/amd-pstate: Fix setting scaling max/min freq values
Date: Fri, 19 Jan 2024 05:33:19 -0600
Message-ID: <20240119113319.54158-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|PH7PR12MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b8fd6e-e063-4cde-860e-08dc194d6f94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CgOOpjoxkMOQ9pv0SFlUoCEcJowrR/JOmCQq6dF5/u36f4BVzpPXknqRSONmhTWG8/W4EVmNQoyZx7u4kVdh3uHbgkynrJZS7LRrH4Hfzc+fivonEzuLOE9IV+SVve2/S1BxsxfEercvGpgzAoilC7lrK6uA0PI15Hvs7FU21xCg5XnJGQdRNhUsDwBgUy+Lml8mSUxzxuD5B2APZR+ExGRrXn9lwbyS3daWNr9ZjavO8TKjv5KI+RlYHvGlJKsdHBg11jVBnwluUki0hfnRC9M+9kPdsIVVnOroLrBac0dpRIJoeXiQ0ShmQPbB3o1NRM8s/My8E+nHO9GQeMu1m99t7+R3lvwe8p+31fSO/UEw+rL7qdw4LJQScq3wbuyfqMEFldN+cawllNTc0VdY3nh6oWHO6caQDGP0XorbbXaOjOL/WE7c2EEZoqErADh1woHMW9KHGOhgoXNC3ujBjxtMJDKm7KX/gb3vTHGgOkK87Ag4igRmMR+7P8CxmYwi0nN7/txmJBwsKkjQFzET3+kqktOw/bbTAouDGVnyusKJvLJLmmOiuP5ZV88raqR8RDjgp0jab/h3EClcKGWa94oDFFcbWj8B1LDblkVzTUKRix3yDJYcDjhTMAtDj5ayK9foPW/TDcQcSMumQlFYuUPaCBGIB44uyCLpzOQ0uFwazkVkvLfRKB4DkEEvGTYGVvrdVgsZMP+8tX/Fq19+EEDc/cfHdabsMpZylDvFJV07WX6SECABdp4/dw5QphGBq1PkEFlBGNDlSLMrR8anmybqVbnwgSfK4i4QFY7dSo0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(82310400011)(64100799003)(1800799012)(186009)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(110136005)(70586007)(2616005)(26005)(316002)(54906003)(44832011)(4326008)(8676002)(7696005)(8936002)(40480700001)(1076003)(70206006)(16526019)(83380400001)(2906002)(966005)(426003)(336012)(47076005)(478600001)(5660300002)(36860700001)(82740400003)(86362001)(81166007)(41300700001)(36756003)(356005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2024 00:19:15.4323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b8fd6e-e063-4cde-860e-08dc194d6f94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6908

Scaling min/max freq values were being cached and lagging a setting
each time.  Fix the ordering of the clamp call to ensure they work.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217931
Cc: stable@vger.kernel.org
Cc: wkarny@gmail.com
Fixes: febab20caeba ("cpufreq/amd-pstate: Fix scaling_min_freq and scaling_max_freq update")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 1f6186475715..1791d37fbc53 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1232,14 +1232,13 @@ static void amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 	max_limit_perf = div_u64(policy->max * cpudata->highest_perf, cpudata->max_freq);
 	min_limit_perf = div_u64(policy->min * cpudata->highest_perf, cpudata->max_freq);
 
+	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
+	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
+
 	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
 			cpudata->max_limit_perf);
 	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
 			cpudata->max_limit_perf);
-
-	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
-	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
-
 	value = READ_ONCE(cpudata->cppc_req_cached);
 
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
-- 
2.34.1


