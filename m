Return-Path: <linux-kernel+bounces-101309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D3487A566
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF791C215F4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9C839AC5;
	Wed, 13 Mar 2024 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EfcJoCZH"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C261C200D4;
	Wed, 13 Mar 2024 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710324052; cv=fail; b=kq0YrJ0pRzNZWM0Qp5+ZDmxXV0UrseeozHFvjEupKhEM5A6QQigJvEmER/xKWlxTZA6jB6a6F3RnutkSZxD3OwkEoHDaAO9LEZWlMpBUDD+cwTlH+s/JGOZgWqs2K6NDFoKMh0oz2nBxgojqx+JqzIm+yNfQuBC7uG3UUa0OF4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710324052; c=relaxed/simple;
	bh=Dffh4MwAVvOzEvmJSt5wSFr6/063IqLmOZ5a80aIezE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fFZGM935icxaYxT+biV/eyCCbQFaqcIyV/MnvV5f16gj3XGob3FS7DhQxsCJnVgkyophma1SiUpVvJ32IqGd5UTIRJyNaWTc/nPdoqHoE+z42rTCSgx/O1SsVI/0CbZLSw3P52/YFoNy8NsexBAYSF3he4xzERp+Iqhx62i+FAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EfcJoCZH; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBOo6MpfDTpvj53CH6Kw/ZdklUp1LsOBp864SWclSAKOBWlMx6rItcflR3GfFX4JplhsKm9mabAZGNjgr7sjzd7OILPIcfm+qqKMc5LG6H+o7QeHTQCFiZDCp93ngwR7puf3lPSjIt04p2esQ4SsaoDZsaXxirnQLSJhnCfP6/ABL2vXfjYsEJlQ4cJn9XYGnND70CPQ2FAYP0x0+Q9ifjPJpvDMRT02g9TFBCz+jNeuGPOSZM/hcy16IcQn58/atJ3nkwmnA4m/o0o7aY0m80cveeXoyMsE3mibZSQxNGvGYrPL2RTxbZoyCFHblgZRgY+1V5MbmC3OPna/yHk7ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQdmBy76xAFvPYqBoBG9HygI/Bc/9kmrNeMK30hsSP8=;
 b=JLBuf5VWKdo6MZwhKJ7GkrfnMjvxWgwFcrvTztxTqki1DhOoRhgBVmQ3fSXgiAmvJ5ljUlO4ifogOYcfFTrFplqJtnInltPRaebC8yMEQXy8kmLWSX3fgFF/snB1Ay9iOZro+tCo8ie8emGHp1n2TyxLU67zeAEOTkDAFOqWLUooU6JeoO1j0foVu2yp89Kql8/2/65dSRKR9zEKhbiz2Ja7sWVnO/5ehi3coTGUsOmsXzJ0jjp+3RFOMm9wfLYYyi9FZzLVl52y0C1dgjd8r2Wzy78NNTsa9mTTkZ1gC+dfih8RonrvnnZOjw7ViGOukx4StJh/5Rn37CbJCfiIAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQdmBy76xAFvPYqBoBG9HygI/Bc/9kmrNeMK30hsSP8=;
 b=EfcJoCZHVudm/DGiAhn9dm/FanPhlTVNzpwTWCQLXiRInt6U59MeJZeLUjWc2mnor62DiXIa8V1tpjQEeLSkyu4kf7jAEHHMFdBRsbJQdeKYLUCqnnYB7EEsqqx+Tpec2egVoBAPtaMV74PA/iC/7hUx40Ciov8fQWIF1TDk5Mo=
Received: from SJ0PR05CA0068.namprd05.prod.outlook.com (2603:10b6:a03:332::13)
 by PH7PR12MB9125.namprd12.prod.outlook.com (2603:10b6:510:2f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Wed, 13 Mar
 2024 10:00:48 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::fe) by SJ0PR05CA0068.outlook.office365.com
 (2603:10b6:a03:332::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Wed, 13 Mar 2024 10:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 10:00:47 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 05:00:39 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 1/6] cpufreq:amd-pstate: fix the nominal freq value set
Date: Wed, 13 Mar 2024 17:59:13 +0800
Message-ID: <08ed1f9f76a6a1c401efd8f426bdeb9681c4b4e9.1710323410.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710323410.git.perry.yuan@amd.com>
References: <cover.1710323410.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|PH7PR12MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: ff210852-c70b-422e-a409-08dc434474f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1Y2cygqx1zf0WYDr5CXVRGiZ8dSgmL0zQ9p1OVky/JDDwxsVh0UqVjg3WLfYYSUemoarlZeGyYTqeh+nZLgcQn7dtWkXzQVgfqSTWyQ0jCQqqRIj3qF9VG4DQwkAx7ThYFS0c3Y1MZGy6ak2YviSX9enzJm2zEqEykB9SNcfW3UXQRdv6J0RkciR4GSaNNyrEws3ZUp9qT0/SdqSS0Z4KYZ1XfBF5HssK2ZNImVh869h5WJHI3hGi/yS3IqDdprNx74wbz09KEvmwQSSqiJ4845aQ3BQC2e751kepupscoelkx/287/nSdda/ZCUb9T/6lBJ7GAe0LtAY7aNHSACEJraOJuflMA7G56fDCPYpCXp6N7g8qjwkGluvP96+AFSXqoP6RKjh8cMiipZkiYp4u4JOG1S6NgHscfOSy153MqTisUxuefVVkNVcKy3Jkk/wcod6OeL/8Vv1hYeMr5nc11LdcNJhLcDY2Ata0mYImt8NkwZmoL4oRK56m59QNcAZG/bWPYsLtdKknR1oPV4/Msa5TYeVLptJL9oLefWFgey6OZ+R4Sht3t45bLdMBVt0nstmkB2w0oPwGLUIhb8xYGF7NQjyyfBe/pM7rbskhrCYuag48xdJKwS1KjN/ELXLbmbxyLXhdAfBSSBBfLlf1pL8rHdVzz+EZjGZ6nA9R+xS0lZShG6YUqpmWtSKL9FSFmShSgueaGXtW1TzqOt95LiT9c1SIRV9P/A4BVVVqvlDNOraOH86zUus7eUnSpL
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:00:47.6450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff210852-c70b-422e-a409-08dc434474f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9125

Address an untested error where the nominal_freq was returned in KHz
instead of the correct MHz units, this oversight led to a wrong
nominal_freq set and resued, it will cause the max frequency of core to
be initialized with a wrong frequency value.

Cc: stable@vger.kernel.org
Fixes: ec437d71db7 ("cpufreq: amd-pstate: Introduce a new AMD P-State driver to support future processors")
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 2015c9fcc3c9..3faa895b77b7 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -647,8 +647,7 @@ static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	/* Switch to khz */
-	return cppc_perf.nominal_freq * 1000;
+	return cppc_perf.nominal_freq;
 }
 
 static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
-- 
2.34.1


