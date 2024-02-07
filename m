Return-Path: <linux-kernel+bounces-56198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEC684C73F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD911F25D3A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9179228DAB;
	Wed,  7 Feb 2024 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1csYY+Xz"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E58922323;
	Wed,  7 Feb 2024 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297778; cv=fail; b=jQ1X0rfpde8mQ5d3iT9sj09YEsNq6eKlbtaW/hQeLf4TNlI7/fXDxgvhe1QBPe8t2ePVsU5vbs9aNgyWyIju0yJuCk9gvOkV9nQFxOP0l2mNiI4aU6qQGvm//aiBwNIVVoPWe8cYvaVBo3HGBEz5zkRt3z9ZgaaOEjd9QQeBheg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297778; c=relaxed/simple;
	bh=uAfvgz28dDSg9yIY0HdANuXRN494fB5lKk5vDyKyq2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iNSxK9+HLQXPB/keFMLgoVuHkg0Dbkg975TlPMw0dAVn8hAd+a1Qc4eSW1pmIHV3gdFvhXKfJ45tlKKQ0IINLXwseHptwDaon/4qaqOXDQnC5glYRjYo3MAggohs0tQN2HUkE4ZXalvdJngc8tSGOQLI1vaqezyWl5aPLII0w2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1csYY+Xz; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfxGHobp7jYbaQodvlFdgGeXkhBhDcn6h+RLLx+JcMPdY0/rH77/2xZwFPKXohTZFUz7ezpUCCykPUZP0Wv22K6mlPH5u9nmNCgVgbf33KLyp9cqoLhT/6x9Kxlvb9ji/pBPY2XRi97f/mqDp6y0yTIroDaK5Ty4zyt7Ob25wlu6MrEhU13DyfdE64Yak7V0etVEhN8xKEFcyzGa55ebGH+LeapgDtY99RPDJHv/gPXLFX7Vc8BaF+YHeaLWDKbAdmVbKLWXEim4fyA5sAUGuT6fZ5dLkWASfczPX4rNgVa8lozDXRPQLzCRKswViqiCACJPsIC0ZmAiebt8/3P0OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kyu4cTOLR0GWzUT2ptQ7PupidvWOS6sQztS7R6U6U1E=;
 b=eGsctP0myys0zR3m8OGSRsrRNLvGRh5XLWJkhe/PEthPRIE3XA4TE7qFcC9S7Wf5U34ZkIe0+bhz4DZ9RfNsLC4mYuzHNBlkGN0etgLqyvYAnJSQ9R1xvZoXH6GvwKnNGdU4fX/O7zxFi0Qp0hoNjlka/OVpe/WsQEAbOuska8EhNf/3AEuTRrIQpZ/Yg7LUDYrGm+8Vritx/Um1jY/brHEB9Xb6khrRiB5nzwozmIVUpsjnTZwSgzHOBSdkNDjypgKcIx2Mso7mOBcTxcJOVi2eQEwjnKXvUk6AC15eRBx+xYhsy6dMCUSQQg8J2ak9jClz/N9/TFeHjzu2dIqiFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kyu4cTOLR0GWzUT2ptQ7PupidvWOS6sQztS7R6U6U1E=;
 b=1csYY+XzAFIceMMyMprYKpAtSign/ECdtX33xSKUr/gcKB7Lfq1vPI2HsazWgHm7Z4TDaSKgC/QY1YVF0Jdb4f7vEcVXCWnB9tCGRrwhc+KIkXlv/+PG1Ge1EnHwlMplx5m/SaMKTSdkmlce7Flex7cgGNfobmRHYf32wjKMCi4=
Received: from BN9PR03CA0104.namprd03.prod.outlook.com (2603:10b6:408:fd::19)
 by PH7PR12MB6858.namprd12.prod.outlook.com (2603:10b6:510:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 09:22:51 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:fd:cafe::4d) by BN9PR03CA0104.outlook.office365.com
 (2603:10b6:408:fd::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 09:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 09:22:51 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 7 Feb 2024 03:22:47 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 6/7] cpufreq: amd-pstate: remove legacy set_boost callback for passive mode
Date: Wed, 7 Feb 2024 17:21:57 +0800
Message-ID: <fb14f6e7748f1b872f68eb2549d4e6033f0facbc.1707297581.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|PH7PR12MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f26a81-8f7b-4103-17aa-08dc27be5bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KXBkW3ZOime8q5D6zybN4IgTDjtGiQwU8xJT3KkYqSgJdIQ7cqM6a/Iz6uPJae5Wk61WqOK2dtWTT3R/ehpY/fBSmWsvj3tP6QYvWT5rfkIdb7PrXSiR9tDNBOz+ZmafpZZISEUQW0gEtRZQIJcJV2MgjFUaNmmpWnuejmoyN6TyPnqU3T0IwFyMhJ3960NHo5c2Uhx/s+X+DMWQVmZagAoiO4zwetr4gFWixgNckIrBoPKYMu2a2jEph4qqmNN3jR3Wgnj2+Czbcyfjby3uiUcU9DWcorhlviPG9g0AQNwjh1Yab59SLatwhn5HXCmhW9ua1FSnk7afI+DJM2ODjUJ92QRmSwSk+9UQM7Q/Gi75JFQcywOgnaoOceHY3aol7xzYn4fT7lLNqgj71JnsQFO5vuYc/B9BgQqWMMwknCsQuxtL5U6iIULE00BBSLLXJW3U/lWz7bo1XumEzdGhav6LrbVhsf22sgRlAl/Iv/HfaG4w2e/gw4wc0W/W6t5CJzXm1Zt0iOdKQMoR7eqSeBHec0U155gbRh6lp8EZ6dmoDIK7opqnEIojgQdVPZLWy5+EH/obIAATRYONM/x6gv426IixhSh7bDZVfh8lnVOw60a3oCL9Lojrk2Dw1JfhPbdTXe9IR/iM6eERZQmtUbad/srOEkpHSnn6ONbTP28B9Pvs58qUj7SSJ33NlbOuDyjBtNOdjO3CX9nWhv6l6VljYdAPywvS2TKM4tfX9fdcSEBX/DRy0e5RWxEV8izXRE9ubvPVfLDqiAfcC5h4pQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(36840700001)(46966006)(40470700004)(86362001)(4326008)(8936002)(8676002)(36756003)(81166007)(70206006)(47076005)(316002)(6636002)(70586007)(2906002)(44832011)(5660300002)(54906003)(41300700001)(36860700001)(356005)(82740400003)(110136005)(478600001)(7696005)(83380400001)(16526019)(336012)(6666004)(2616005)(26005)(426003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 09:22:51.6015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f26a81-8f7b-4103-17aa-08dc27be5bc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6858

With new freqency boost interface supported, legacy boost control
doesn't make sense any more which only support passive mode.
so it can remove the legacy set_boost interface from amd-pstate driver
in case of there is conflict with new boost control logic.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 1 -
 include/linux/amd-pstate.h   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 35791efc6e88..1dd523db3871 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1675,7 +1675,6 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.exit		= amd_pstate_cpu_exit,
 	.suspend	= amd_pstate_cpu_suspend,
 	.resume		= amd_pstate_cpu_resume,
-	.set_boost	= amd_pstate_set_boost,
 	.update_limits	= amd_pstate_update_limits,
 	.name		= "amd-pstate",
 	.attr		= amd_pstate_attr,
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 465e9295a60c..ab7ca26974da 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -93,7 +93,6 @@ struct amd_cpudata {
 	struct amd_aperf_mperf prev;
 
 	u64	freq;
-	bool	boost_supported;
 	bool	hw_prefcore;
 
 	/* EPP feature related attributes*/
-- 
2.34.1


