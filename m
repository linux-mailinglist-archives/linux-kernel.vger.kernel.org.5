Return-Path: <linux-kernel+bounces-55866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F284484C2A5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64B641F24806
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D0412E47;
	Wed,  7 Feb 2024 02:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UclWc/wo"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708951095C;
	Wed,  7 Feb 2024 02:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707274015; cv=fail; b=c1Izr6mIHgXLZ7dowk5/VryCUcEjWRXJEVwDUdv3UZjY35oDqgUaM5A1WACVYpAfwurMfBKMWNLG6z7jv7LpMgYGklJxMA4S8vbG5mlk5vxHTTdfpqpjdcxXJHZrjg/PSeBKG0BjE7brEgJyoz62wfxpIa9gMafUnsnQJ8M6dZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707274015; c=relaxed/simple;
	bh=a7HUM9GDkpRgPggDObzXxL1tRHl/EW7CtZAkMKBnLBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MaF70CW9EoDOMxwrDU/bBK9YtEhOr77eyQPIBh7yJdcTjx5LPPtLfibj7/B6cTYTcBNQIOnWSiNohVueMpHRbXjG/fWbsmLTQyn+p5Uxh6QuCqO0aK7CCHEYMMfh4Ug150UL+Mz74BmelGXsz/gG+8YxmeHXxKrGxF5ITFWWrI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UclWc/wo; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXo94/pzlNhpmDETTYmozzfWekLKqLY16Zeb2KnXp2g6Dy7s87OJoaZprSQrdzxoRoXEZKblVUPpYu/zZDfgz2+fZBIZU2bhFMn8uFTpO3GRqJCCTVEPyGkIfzVg2sJl+UhdMU6paOTV2T5fJbIJtyQ/OeLdEfYotDXA7RgkMHn0w90olcMWtvBo0akgzw6vE4JCCVxMR/3jB3v3RYhzPt+rbjrZcbolg3v1pZ4P3v8FvWfYU+BDMuRbnTQXpKGTPbaiaKt9NWzl96B0O1KsQD1QHIdtle0ZAM38IOqILEJJnl+cENaEoiQymi2GZJLuxM7xVWDEql/E7notHSBTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFgA1+hhdAvzSZ0OZkDcArmwSqv0z4KqbobNxKdpI6o=;
 b=VY0BadGAb6rts0wKVAN9CcwA3G/t9IgIse9J0V/MZTaXWwQkaiDMO6KthPKXlarY/Fca0Cc46SgI2XcAoBOf7ZYOocLtsOu5mkJLPGHV7fWh69fD/3pa3L4KfSEtrm2ztC6AiASCmV3o2YvFGUxGZmcmZ16lrPN9Ru+UjP2vaJpXjWwWwjIW3X2rOKw1cmc3F9PLsqd1LcwNXJheoFNUXAttH10MfTQl+xNcOV3QYgTKiUeddn/YOTQeJIL42NJikRBjf7pDftt8DEPfe9eh01APwXhaNOgNQuGp5Jm7agIKxk/j7GppnOGqs3UNQ9T6InWzxjy4wrsEPH8Iwdi24w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFgA1+hhdAvzSZ0OZkDcArmwSqv0z4KqbobNxKdpI6o=;
 b=UclWc/woiEHt4a6JiF2aSgQSKFLnhr1kjbJussxDnRltcB8FBx6byBs1dXBpHa0l+WJkalJPtI5LHR2Pay1mpkVObeFNlZPYYdTjlXl39HNZrY3k9I0ti+r2T8xddiYGizTmQorNScRail7gAlCPdbZQqGV41oB9K9HoKM0iG8Q=
Received: from DM5PR07CA0050.namprd07.prod.outlook.com (2603:10b6:4:ad::15) by
 IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.15; Wed, 7 Feb 2024 02:46:49 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::c9) by DM5PR07CA0050.outlook.office365.com
 (2603:10b6:4:ad::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 02:46:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 02:46:49 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 6 Feb 2024 20:46:45 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/6] cpufreq:amd-pstate: fix the nominal freq value set
Date: Wed, 7 Feb 2024 10:46:11 +0800
Message-ID: <ebbe3741501a31b1ffcea208393cdd8929df6455.1707273526.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 848720d0-0ea9-4713-9d64-08dc27870894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xuyBwKgj2MLK3sZnCDBSYlLnYKgJ5/+avG0QUpUsmJN84vPOo3/Z/RI1Bf4noMT1Tl2Wgp0F+Ib+SISanIxvdxGP0ARA9lFWd+PtoWyrm8bXjtkIn+yWTNOtI5D+uhdO5eCK6cLSv1N08QBKmOWM313NAf31thr9O9N9/WBRMCWceXr+EtF+XkDX6p2c/9AMjwBtGTGKXnhPFsdMIippyyG85jlZhBcdZjndDl1lUkqL/vm7Cu8EFPwaQMyuwWZqEQwt4W1zSY7r0CnkrkKgAywoXVOGyYSSnNDn5iNn3NK80kN+SOUdcl0Zy/TaMvZzkpSfm0Jt6HxMAy17Aka8y+XUsmot1qOTt55NPWhvUT5MDpbd3JvqdY95wahU03DTzNgJGNL2FfTwKELyjVPiwhOGeu2jcuKzDa3i8ySNqL8yLhxXznwecibUDuACi/Jz5HTm5FDvooZYbfcxwXyhNAd4rVPse2xWdW61h07C1/n7NaLlafuBiK0TJ/WWV/KWYGFeLbdr0+jocafFg/WmEirN9KGvNagBUcuzYtU2eeabhpkeAMg1N+3t4nyNir5hM1wj5U3iK58YSZ5qdDaFnWujzW+kwv1zx0D77R61m9mJuwISzY64CROMRXNWp8EK2pWQ5kxt40zivCTjyMibq4nplQip1m+7leIEy2PKqH8cYHz2xjysAfrwmYHvhLfXqnwCPSVYEwO4GBR77Y8TlZkiaiDfLsG5ucaR9IRTsNc3x80aNfT2IWHNawPnlqsxdnbFAWITgNr3Hqo7yecDLw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(82310400011)(1800799012)(64100799003)(186009)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(36756003)(40460700003)(6636002)(478600001)(83380400001)(336012)(81166007)(426003)(41300700001)(82740400003)(356005)(47076005)(26005)(16526019)(2616005)(5660300002)(4326008)(2906002)(36860700001)(44832011)(54906003)(7696005)(110136005)(70206006)(8936002)(6666004)(86362001)(70586007)(8676002)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 02:46:49.5449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 848720d0-0ea9-4713-9d64-08dc27870894
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086

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
index 08e112444c27..ac7faa98a450 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -640,8 +640,7 @@ static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	/* Switch to khz */
-	return cppc_perf.nominal_freq * 1000;
+	return cppc_perf.nominal_freq;
 }
 
 static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
-- 
2.34.1


