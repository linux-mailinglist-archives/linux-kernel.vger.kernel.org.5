Return-Path: <linux-kernel+bounces-154705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0681A8ADFF5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58DF6B22057
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1740D5578A;
	Tue, 23 Apr 2024 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ui+z4lLK"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4471E526;
	Tue, 23 Apr 2024 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861681; cv=fail; b=asvQaalvcGreMpyXJvjF3pHj+/tmCUkXLgCukS2rDi3W6dZRQA2TyiogdMVbALVX0JXAmthhkMz7qT29Flqn6vtln1eL34Lk82gAwDTJeyDPAEOKcnUV0/1wjPbuzSM6MJgaZeAmC6FL/dqewRY0fDw9Bjbe6kEjH1K2COpk830=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861681; c=relaxed/simple;
	bh=gWLRNwdbNnmB8P/wojeD/NtHjIgIN1bRFCa5HygQuDc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E8XxeBPoINU91n78hWWjAqlSWkHPIVXixHYvh11AkIY/LbFzZYOPl58TXCXoaZfaYFySS4fbnsYotHVp7SWr9KmVBquZcTLoW1JhSG6nTgdzW5Da+gG50gQRokgeR1zPtFdnBNqs3Ikb+pwceOP3LeeoVgUpImamKy2ZuGJVzgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ui+z4lLK; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdTaTHXTOLSOVZwsWMex2tY/+BbWEQDlxe3wKYPDt4t8CKEgzI6WgoErShvFWoGct3GMc7IaowI0vsD4VUQXATntV/gzk5n7GTlDNlUSvx1suefwTP0DvW+WyHPIoLApx47KjPvUJcbQ/gZ8PRVkUljsSg/xDrof7+M2cAPIUCoHVg/cLCAhu9ogIDHARmP7ZgKkDJD9WZi/nP6mqUSlcfnZdlHQtrpnr27kBrLejw2PVdkpfWVkq5xM0Qf7yLggYO7VvncSrhg0Nl0E4yZpHCjMgD8o9uPJ92iHHT7oYz/uqeHaKSflOqIZ3vbe5sEgziZ+7UJ2PLvcslFk7Atb8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiSVg/K6sUD7gNGWanRjNz0WS2uCg6ByrpdXJ3AD+2Y=;
 b=IUmuxrF+r4BLCHgrQXFbq3F9VI8eXnc6PbWwrm0dt2kvawqtKo7g/8nkKNP+cwoMNAeyxtVcleX+qHf/NNIaA1P89ZSNt42wdIvACZP8Sbt2cv9+nyix0Lnd6D8IyvMsAm5yrx5oLtU/imQx05U0RQQCs9JtUQKM0I1fxrcNY2TkMSH5Fb7FMgRXP6JL0YfNJ0NGD2/2ng1B+kXiwKluFwMqLYKEG75Dr3yRiiEyUMTyOsYuygzLafEDNMsqklcSaaLJViUELAPMv02GDdJCsDp5xtRUtbypuJIIfs7y+5Hl2P5i3QaGF5inxE0pZEeqlEuBOb+Z2lHsdI7yAqyX0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiSVg/K6sUD7gNGWanRjNz0WS2uCg6ByrpdXJ3AD+2Y=;
 b=ui+z4lLKj0Q4mNNwzItyVqEr0vJSNr0LKuehKE5UA4ZH9/AC6l/ZiqbjyLDlbqMerOA3e5LUXKnCKN/VH9e50r2bPsQfDApephmam+B77mlnowrnlFQm+eIOc+yC/ySc1EUSocrBUzPdFfvC10yPt1qj6/7pJjTOAgVgDWxMk6s=
Received: from DM6PR03CA0003.namprd03.prod.outlook.com (2603:10b6:5:40::16) by
 CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Tue, 23 Apr 2024 08:41:16 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:40:cafe::28) by DM6PR03CA0003.outlook.office365.com
 (2603:10b6:5:40::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Tue, 23 Apr 2024 08:41:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 08:41:15 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 03:41:11 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>, <Alexander.Deucher@amd.com>
CC: <Xinmei.Huang@amd.com>, <oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 0/6] AMD Pstate Driver Core Performance Boost
Date: Tue, 23 Apr 2024 16:40:53 +0800
Message-ID: <cover.1713861200.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|CH2PR12MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: c25c224d-fbb1-4031-d8fd-08dc6371238d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1pxHtFQpQuIA4Ta1fdurBANwOZAYB4vx+EHbC74oLlUUUnOw+8rMZ35Lfu92?=
 =?us-ascii?Q?BNwCKzxXwxJFM3atW/kxXyMu7s2tdeUZIx8jtpFrQpXH0h6foAQe8myF7UyP?=
 =?us-ascii?Q?5e1sNHKTrjKlnkRCQPDHq6qMioUXj4hBvJXEUvKCBi2+iKTjzNANbVkUDxHE?=
 =?us-ascii?Q?1Pvqw44kmJEN8h63RYHJ1VdWukc4tOxn00zVwy1itsQrA7veQvsjbsEQl98m?=
 =?us-ascii?Q?C7R0n0rromZFcuJ1vJTCPN1KZwJ1E4t0ktPtQ6Xr8kVoxXarBjmoLP5lXr7i?=
 =?us-ascii?Q?H8wfwpLkC1gi6cw50WHLWGDRITCZcnthFPi98eRMi/Adg/Tw0ReE2NhGWa4T?=
 =?us-ascii?Q?bqZ/dw7u5p1Fb/dBSYUkTLaxP7a9XyrZ29ZvoaPaIIqrtSj2GWKf6DVkc0aw?=
 =?us-ascii?Q?DkkMnLmQdXNf3/IW+uP2xEiw2gA4F30pjoY53AJYBdvNE9xo+mk37MFAuOdf?=
 =?us-ascii?Q?xRUguZpAhxcZCQfPCyZ3qFhAu8BSAlDGGWtOfD4Xrb++Sfz91lmCHg8iUHCY?=
 =?us-ascii?Q?l9FHmvX0Ix1NjIrmvg1pby+5FE/778RQlMxqoxv/2Orb7kjsn0oML4JzZbiB?=
 =?us-ascii?Q?imx3TJ4g9FiUpSjsWGG3S4Ul8D/H1ml4ie3l2O6DT3MvJ+NJhJtvjQJLcC53?=
 =?us-ascii?Q?CKkN37dKAVM5zIT+RkS8klwgvnNhV4SF3t0+fW/fBG5f7aC8OV+hignekyj4?=
 =?us-ascii?Q?zH1E4ZucTXKJF2oFJoD0KZtdC67dq7zpkvhTrRK5udwYO5TcUz0jkJFw6tdy?=
 =?us-ascii?Q?aRNXQ4VICrVt/ojtteJF5G+erECyjb+4ibyGpLWP9ZlypAoQyHU4bJjZ03eQ?=
 =?us-ascii?Q?dEk9NTgRVXPMa4pYCwQCNPUTP3MTjr+vW8kluVEG9IDopB8x6ctKwZlnvDzn?=
 =?us-ascii?Q?f46Li8jw1GhS8TK9/oIVok2V0SXXc5cEVTJf92WtAcdwpv/Pzdx7GfQ23k4s?=
 =?us-ascii?Q?pHIGubLbuaTCJW1clkioi52lex+TwDHmcYzc/908i7NuqX/CbqU7DWl89Mwh?=
 =?us-ascii?Q?kvMLyntIH5KEdSx3Ytw7/Xw+LtK7tjdsdiOvKs1ZeIXSvvwBxoTNN6fvzN0b?=
 =?us-ascii?Q?VMfyMBzxda2084wr9gO8VZ3z/ut3H5MhExkyuFTW/En7BZpJayAJ7rpdgVcX?=
 =?us-ascii?Q?QJsmHYPBhn0IJvLi+1cKfcCRbzMWTdUAdrE+ft2YGVts/2AWfKImT3SYbonr?=
 =?us-ascii?Q?sapuiLgIje2+c3/g0liwT2B1s4LXd8Ze1r4a4D0edNcBJgDr9qspP/UFV9fw?=
 =?us-ascii?Q?l1TNANOWvtlFq6+WMGMwBT8+FUxB04VVKCNx+P1Mx3OkNiOrE3xAEjjaZHLy?=
 =?us-ascii?Q?qLT+VdB1Z1o+jIGDyY6CdChAcNu1q0fSlwl2lB96KlQMqywT18yHNTYXDAIb?=
 =?us-ascii?Q?XVSFWGWCI110/rJDvyNp+ebSlnck?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 08:41:15.7939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c25c224d-fbb1-4031-d8fd-08dc6371238d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232

Hi all,
The patchset series add core performance boost feature for AMD pstate
driver including passisve ,guide and active mode support.

User can change core frequency boost control with a new sysfs entry:

"/sys/devices/system/cpu/amd_pstate/cpb_boost"

The legancy boost interface has been removed due to the function
conflict with new cpb_boost which can support all modes.

1) disabble core boost:
$ sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
$ lscpu -ae
CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ      MHZ
  0    0      0    0 0:0:0:0          yes 4201.0000 400.0000 2983.578
  1    0      0    1 1:1:1:0          yes 4201.0000 400.0000 2983.578
  2    0      0    2 2:2:2:0          yes 4201.0000 400.0000 2583.855
  3    0      0    3 3:3:3:0          yes 4201.0000 400.0000 2983.578
  4    0      0    4 4:4:4:0          yes 4201.0000 400.0000 2983.578

2) enable core boost:
$ sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
$ lscpu -ae
   0    0      0    0 0:0:0:0          yes 5759.0000 400.0000 2983.578
  1    0      0    1 1:1:1:0          yes 5759.0000 400.0000 2983.578
  2    0      0    2 2:2:2:0          yes 5759.0000 400.0000 2983.578
  3    0      0    3 3:3:3:0          yes 5759.0000 400.0000 2983.578
  4    0      0    4 4:4:4:0          yes 5759.0000 400.0000 2983.578


The patches have been tested with the AMD 7950X processor and many users
would like to get core boost control enabled for power saving.

If you would like to test this patchset, it needs to apply the patchset
based on below one latest version patchset.
https://lore.kernel.org/lkml/cover.1713858800.git.perry.yuan@amd.com/


Perry.

Changes from v6:
 * reword patch 2 commit log (Gautham)
 * update cover letter description(Gautham)
 * rebase to kernel v6.9-rc5

Changes from v4:
 * drop the legacy boost remove patch, let us keep the legacy interface
   in case some applications break.
 * rebase to linux-pm/bleeding-edge branch
 * rework the patchset base on [PATCH v8 0/8] AMD Pstate Fixes And
   Enhancements which has some intial work done there.

Changes from v4:
 * move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
 * pick RB flag from Gautham R. Shenoy
 * add Cc Oleksandr Natalenko <oleksandr@natalenko.name>
 * rebase to latest linux-pm/bleeding-edge branch
 * rebase the patch set on top of [PATCH v7 0/6] AMD Pstate Fixes And Enhancements
 * update  [PATCH v7 2/6] to use MSR_K7_HWCR_CPB_DIS_BIT 

Changes from v3:
 * rebased to linux-pm/bleeding-edge v6.8
 * rename global to amd_pstate_global_params(Oleksandr Natalenko)
 * remove comments for boot_supported in amd_pstate.h
 * fix the compiler warning for amd-pstate-ut.ko
 * use for_each_online_cpu in cpb_boost_store which fix the null pointer
   error during testing
 * fix the max frequency value to be KHz when cpb boost disabled(Gautham R. Shenoy)

Changes from v2:
 * move global struct to amd-pstate.h
 * fix the amd-pstate-ut with new cpb control interface

Changes from v1:
 * drop suspend/resume fix patch 6/7 because of the fix should be in
   another fix series instead of CPB feature
 * move the set_boost remove patch to the last(Mario)
 * Fix commit info with "Closes:" (Mario)
 * simplified global.cpb_supported initialization(Mario)
 * Add guide mode support for CPB control
 * Fixed some Doc typos and add guide mode info to Doc as well.

v1: https://lore.kernel.org/all/cover.1706255676.git.perry.yuan@amd.com/
v2: https://lore.kernel.org/lkml/cover.1707047943.git.perry.yuan@amd.com/
v3: https://lore.kernel.org/lkml/cover.1707297581.git.perry.yuan@amd.com/
v4: https://lore.kernel.org/lkml/cover.1710322310.git.perry.yuan@amd.com/
v5: https://lore.kernel.org/lkml/cover.1710473712.git.perry.yuan@amd.com/
v6: https://lore.kernel.org/lkml/cover.1710754236.git.perry.yuan@amd.com/

Perry Yuan (6):
  cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
  cpufreq: amd-pstate: initialize new core precision boost state
  cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
  cpufreq: amd-pstate: fix the MSR highest perf will be reset issue
    while cpb boost off
  Documentation: cpufreq: amd-pstate: introduce the new cpu boost
    control method
  cpufreq: amd-pstate-ut: support new cpb boost control interface

 Documentation/admin-guide/pm/amd-pstate.rst |  11 ++
 arch/x86/include/asm/msr-index.h            |   2 +
 drivers/cpufreq/acpi-cpufreq.c              |   2 -
 drivers/cpufreq/amd-pstate-ut.c             |   2 +-
 drivers/cpufreq/amd-pstate.c                | 143 ++++++++++++++++++--
 include/linux/amd-pstate.h                  |  13 ++
 6 files changed, 160 insertions(+), 13 deletions(-)

-- 
2.34.1


