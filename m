Return-Path: <linux-kernel+bounces-56197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE57884C73E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 440A3B21023
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA26288D7;
	Wed,  7 Feb 2024 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V7jzrfNx"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ABD2137A;
	Wed,  7 Feb 2024 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297778; cv=fail; b=uZ2TaVm1E8gBDF/3pWzR9M0+DaW5TsPMyhJFNDPdMpLCl/xyglNh/h/wohXlWkkm2CfvIXkTsMnUaLRyM8d7gcLseg8utn52rlvAR8w+GfL4CFibvkcGcqyuAgnP4xoZpaUX3G9kejTWS+DIALU9y/DzgcCxsmQd461RPkjXMUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297778; c=relaxed/simple;
	bh=VGS+hGARMTajjuPDkUXPxWe/N9W/A8ss4qDodw/edAM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxNCuLqcp0mLQOk22sL+Mkj6LFz3dCsvUVVdkS2BXXmQQvU+XjdXnKyM8lY1TeBpskhwSskMdcDL1h8pR9liSipFa/AxT/7pVY99lGt7yZDE45atppmjSgUSyaw+jR2whoCqJ91YcmTOIUOPwuJdvMku5jYbiSzTgf62lIvqVKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V7jzrfNx; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QH4jl23ULZKjJYGARZqP3hpNUHxukLnMCDMfKQUnFf6ZrhMaShhNvNvagNHJPaydmQunM8kAwlEgHdbbDbvZzn5k6LAdJa9wMfqpYC52hQb9CRmLU33d/va8eDlCzVJs2po0V3zrfZIjJRTwR8iuBjW8w0IDD2wKMzOk2Y60Gl4LXoOJYWxEibjzL6WrpWqukyrbpUUDEU12EqdKD3GgGIbj1nRpNQXV18+LS2J7ZVlAJIzgEo/vBWL60b8Yt8hz4Lns1oL+xk0ze1/IAFJbzTQNastxfX8um3NNBX4Hsl69KP6DwMdbaFuWRRkziqLkrrzHbi+avP9Z0S5z9iDW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FVcmLojJTeF8JSuP0Ro1nGbmOt0d3OeOplpNsH0r08=;
 b=W2RVsB4SxcaALaxCJE2cr/NLuteJX4QHGN+pwqa6aIObiu0et6qlVeaq5TqaxpBYFmHhKJhpddPBCK2qWqXPI8bfZPgViNgW4MqiV59YxMH880OELC0k1uSo08+5xkHH2x7NrBZpTM34tASOqqSVYT26QmHbqsFfJKUBZzz5rYWnZ0QWs64KkqR0sWIMQVphUWhE0j6XdXuGcOXlHLLT1BMw2R0+MhQgeqLWXCJX8FZ8yn8Vlq8SRnFD/JZ5q0OrAQZizVVKeIeNtHOPpvMWoRd5codZLFVaxlKfPV2QjxmBIT1pOVwNA3VTqOogbukrElBWuuVxjBUmPMdg6O0Cmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FVcmLojJTeF8JSuP0Ro1nGbmOt0d3OeOplpNsH0r08=;
 b=V7jzrfNx/4nDv5AHrn+/EkGgwaT+il5LB+UEVEa/hGBvKPESgsLKCMA4qEzbIjRR8ZAysVXyO1ynjhFO76V7QXrUGm+TeMBDG1co831DcRJRkruTHsZAKPJ25/eBQ8i15hDHd/YGG50d0f5N7/6H9p1eOVk8cLv37mcphY8YH48=
Received: from BN9PR03CA0096.namprd03.prod.outlook.com (2603:10b6:408:fd::11)
 by PH7PR12MB6860.namprd12.prod.outlook.com (2603:10b6:510:1b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 09:22:54 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:fd:cafe::ba) by BN9PR03CA0096.outlook.office365.com
 (2603:10b6:408:fd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Wed, 7 Feb 2024 09:22:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 09:22:53 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 7 Feb 2024 03:22:50 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 7/7] cpufreq: amd-pstate-ut: support new cpb boost control interface
Date: Wed, 7 Feb 2024 17:21:58 +0800
Message-ID: <e52ec9efec8022acfea6afde64b883fba7e2f108.1707297581.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707297581.git.perry.yuan@amd.com>
References: <cover.1707297581.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|PH7PR12MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee2003e-b9f6-419e-b9f4-08dc27be5d08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Gw4ZCjTzSHh2I24mXd7cws5GAi1F+6KTRofRt4Mo7ja8C9pvHovIE8qBxvLk4ftenhkTlI5nrDVSKtF7YtpUIqCgu/gBk2m0FwLXJFjX39nWxkO+q57Pnfl8cZKPzHo/7/wX48dcnUXMO94XOoKoA5qCza6Eqp+FAx/6nVWizTZR3+Lirx2kpobDHvmEXgdUQZ6kO5fK8iiYc3hqF5UCMFc3fellM/5o9zwrwS/b9ZnCYT0ccfCIKP+lbrXDIn8OseubJTIxHv7O6LfxzMHU9esP/qkMab/KtD+YmbMXbwL+a5adpVj3/BtM4ULwR+5NC8yrda61cgFSx4i1KBHqXlkNdE0xm1gqLMufN5ySlKJVKI4M4gN3K5Mlw5LM4BHIH42ZGLmt8UMmRG93D/AIql48r6vD7c/t5ak9ZYr2hbo4JpMKMiDP3ENEW0mVssnl4K2xIM5OTqBseF7/LF6Bgbt0yw197JpVikshFYeudI3wQbkBch7a5WhjiaIPe+DVagSjsHgjohM1A/YbGqKFtP1/0ad7OwpY2w1uDJDMDZ1xqzpYO0+wGdfHWYXsLL621lTw1Qicw01DovrUPArqYRDCuvltsh7AWnTrlV+oSeOc7tPltp+9N8WHHIPHCKSKSCLeO4QUSfyjoMpDGkCaa48Hu/y2/rHxTejqZ8V2nPPpTzMPrLvwDLeOdafkl0jKDLSkHDdNyegjp3DroI6kX2p2oMkQED+V4llfUkBTZ3QH8pUmrQigR9IAutG0mL4niTQl3QcZbfyUk5x6t/1MQw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(336012)(26005)(16526019)(2616005)(81166007)(40480700001)(426003)(40460700003)(2906002)(5660300002)(82740400003)(4744005)(4326008)(8676002)(83380400001)(356005)(36756003)(86362001)(478600001)(7696005)(47076005)(8936002)(36860700001)(41300700001)(44832011)(70206006)(54906003)(6636002)(110136005)(316002)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 09:22:53.7421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee2003e-b9f6-419e-b9f4-08dc27be5d08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6860

As the new CPB boost control is enabled, pstate unit test needs to remove
legacy `boost_supported` check and start to use new CPB boost control
interface `global.cpb_boost`.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index f04ae67dda37..91780ec42712 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -226,7 +226,7 @@ static void amd_pstate_ut_check_freq(u32 index)
 			goto skip_test;
 		}
 
-		if (cpudata->boost_supported) {
+		if (global.cpb_supported) {
 			if ((policy->max == cpudata->max_freq) ||
 					(policy->max == cpudata->nominal_freq))
 				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
-- 
2.34.1


