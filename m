Return-Path: <linux-kernel+bounces-158169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A31A8B1C7C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89A6DB241B9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703256F513;
	Thu, 25 Apr 2024 08:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LwU/y7mL"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFE91EB48;
	Thu, 25 Apr 2024 08:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714032500; cv=fail; b=tsGQR9PO3C7wXiViPeJJQzFpNdrjATuoK5HPn4Is7ig1WMyywSstIrMpJ+BuDUoSAm9dqYRZkl6exjmyc8TYig3wVFlknNEQBFDYUIzH60UOmsqhcXIj+BiURnsI2PCXjnpvV9EeM/kfr27w0cVoqgCFeiMZc29XILXjnHId7+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714032500; c=relaxed/simple;
	bh=N9+0lD3VcuUVzf2dDShClmuL//7VSux4vGlreimsAG0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QKhjzX4iyibAvEqvwAiNb+WEq6hqYsVs1Hki6D2t55hkUQmi4AjJ6syllF5mCaXVYogUtVJrUuY9l8b4QVNFdt5IIqlcGf+oC9evPx5ESfNuZg/kfi20mCko/2UViypD/Ztyk04+tEoX1w2UA6RgdivETjIL9H8fatf0+qIVR0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LwU/y7mL; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lK4CrrQcQ8f5xOYcFQuP7wctK2Qx5bok1/9iZ3u2Kq0GwmPErJeAr28zam0Gw38kZi1z4wSKYYtoETAYY8XPizglQbcRQR4LxJ8FJkYJKulq2pjArYsCJyj0TGNpxzMqCRw6ZsN6qSynxuJH0Ay19RGi7S5OSfMMgwYbNtWD+DunbtyPm7auPgRsE5uG8bRNpd/k1J46nmHakcBV+YH/puSsWqDVoTBb+cIIQF6a5kGBE4P9O5l9i49SXgMKzDQSzi4UxeaRocK1j8VLVRr5Ih35LhuLJ/Yuh0rD48jJLtIU2NhevehwKYduKgqa3hbEJHldkd0bs/3fL0AhiS5AIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dC7C8CWHs29ceQfeMzJrfNxbBHgp/07dBpLMW5QVR2A=;
 b=a2bzHsem1VwV5CT/fHfz+VM0Y0Udd6G/N1f36emEQJ+++LG5nHdsBykRlCXEJO0lf9dKB+R+PJaVzB1GCqJAbP03wr4bDonswu7U3ojVtZyhGTG5FfHPnwHSgFr+0yEK90Xl36UXgGRnxZnmHrWoA4NhHYTi5Teyl68BofgucYCrhucdDlzVxa5pSulLzoN6ozIpK700Y4RjgWWUgKp20xvZhai3hO/TsWElguF+AtLoY2Voq+rC3yKhS08oWDGUcf5kshHG7oDPpR0tZuxmqzQpWlxSIfO1qmClqn1TFeoS1jFZeGK1eOhgmYyJMMJtcBqwCc5EOJC1bj+9eGdG0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dC7C8CWHs29ceQfeMzJrfNxbBHgp/07dBpLMW5QVR2A=;
 b=LwU/y7mLNqbl4EZq6cF4IHCeG8JPALDCa+F5AhjocHojtAtvL0hk37lNnjpDmhlVKgqgQTnhpjJOjIREXT7BQ66MOee3xFI4PjyZYp4vwxX/zYcoDtmVyCPraShuPxJE/X52DVG+XBDLB+5j2flxZIYAAlD/8DbsyTwIC6scxKQ=
Received: from CH2PR07CA0049.namprd07.prod.outlook.com (2603:10b6:610:5b::23)
 by PH7PR12MB6587.namprd12.prod.outlook.com (2603:10b6:510:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Thu, 25 Apr
 2024 08:08:15 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:5b:cafe::e9) by CH2PR07CA0049.outlook.office365.com
 (2603:10b6:610:5b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.37 via Frontend
 Transport; Thu, 25 Apr 2024 08:08:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Thu, 25 Apr 2024 08:08:14 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 03:08:10 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>, <Alexander.Deucher@amd.com>
CC: <Xinmei.Huang@amd.com>, <oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 0/8] AMD Pstate Fixes And Enhancements
Date: Thu, 25 Apr 2024 16:07:50 +0800
Message-ID: <cover.1714032153.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|PH7PR12MB6587:EE_
X-MS-Office365-Filtering-Correlation-Id: 9624f49a-104f-4911-776e-08dc64fedb66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kbPVDL3l3UYY+NswpfUCQcPq32DkBBPUMoipumbVFVqmTw7l7GFcw6AEdVLq?=
 =?us-ascii?Q?h/cyVhaMz/riE9dWDt1Wg9nWD8whvuWKzmX9uCZDBqlrGKF4MjQ8vF/nhIOr?=
 =?us-ascii?Q?+tA3oiP/z8FAIxq9qze4e+YJuTh1eSKHVmQX/H8vWDTVseSrihHjGuGbdgq+?=
 =?us-ascii?Q?NPaAqhbdUnJXNTeppLn8VujMCt0D8IrokCH+9EqkFALqNs+7AycdwK9KZCcd?=
 =?us-ascii?Q?qVImKPFL1tN7DWk264AWiNfLsge4cpBtij7nNaTfLKT9IEiDN+RQ6hXIjqt5?=
 =?us-ascii?Q?Z+Nixsn9xpp7jSkjDSPrKYNvMVBAE1maRyKML25u9rnASfrkpJ0isCcJFCEi?=
 =?us-ascii?Q?2YhtHKhCWuize6vTfu3ZIoKsqxuMVwqfvf+eJrU33f7BA5fpdqIJpxvx21CZ?=
 =?us-ascii?Q?q748/Sr8BWFLHF6vDhClJoMx5M6Khj1GBFdcKXI7+zbeRZt0moYU9tSjsolK?=
 =?us-ascii?Q?sRRftamJJQ9xo0AyoDhIBZESv4C4y3kn//G3bYQAAyquZtDRL8i3V5+zwq5h?=
 =?us-ascii?Q?39YFBejZI2aBIdTT9xKib6glf+CRgdGhijrMWyJs0EIvRqeObiupbpEttluN?=
 =?us-ascii?Q?Fw5G/hMjopwjRKyNrbH9r5dqj3ZanB5zsqmxk6eS4pvXkvy8t+oJiDzrdGh1?=
 =?us-ascii?Q?1ixzhzsd8F4hWhp3P6zMMRYp6RKYfEouIHLkg0uS+3dhNX0jmlJHqb8KjCKD?=
 =?us-ascii?Q?mmjBXuGwzP5zs93RM2mnMGkuKtkn9UWyS5hZl3xmrpEDGly8o6d/T+HjDEIG?=
 =?us-ascii?Q?MnxeqYVzOO8vtahghuxEgCbZwr10lrq7ZMR0jxUK/Him7wJO/mxwjayvCf22?=
 =?us-ascii?Q?CI+NIAGPG8jwYjeRhw+5psfK2XtMHgyfs4RUgrOTo0DQVfiQx2xXbcY8h5NS?=
 =?us-ascii?Q?U38Z+ABMQfSSkURQhgTpTpoyNJajC7+lvmgEdPQveZosxEdGoJKjCOYwbrqm?=
 =?us-ascii?Q?Z31SBSElKgc80V7uVJo2I/fX6vYm8RdosCHclbNuYrV43dE5QaGuaYh64dAc?=
 =?us-ascii?Q?D81bG1j+KZ/2fQAkoGxne1m3aLPOd0KmK8+ZMj8j6833RplSVwcg6xKdcWwU?=
 =?us-ascii?Q?y11cUzmUVG1I+/rYyLjB2oS2pllyhsyrVif65fz1fgIvFRMYraHdTnTThng6?=
 =?us-ascii?Q?laIviEHufIdDPpTlL6n5X80P2wtw6FKcI19ePoMjlrFncbURGAwJVJGHMFhy?=
 =?us-ascii?Q?ZC7ObOUBdXmocmoq5HUVy0kGoqK/9/1zJzbfO6AII1uG+aB+C1LjtJgGu+st?=
 =?us-ascii?Q?X1I1ZwjK67G8oe82zk0wN3B6fo1q/5zBBAL/x7j+Ahta87ck5R8rFSD6KTrw?=
 =?us-ascii?Q?TpmWLOEFTl7FD/Wx4i86CfsE0tLfUPQkRFG1eDOvQ5dzjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 08:08:14.4539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9624f49a-104f-4911-776e-08dc64fedb66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6587

The patch series adds some fixes and enhancements to the AMD pstate
driver.

It enables CPPC v2 for certain processors in the family 17H, as
requested by TR40 processor users who expect improved performance and lower system
temperature.

changes latency and delay values to be read from platform firmware
firstly
for more accurate timing.

A new quirk is introduced for supporting amd-pstate on legacy processors which either lack CPPC capability,
or only only have CPPC v2 capability

Testing done with one APU system while cpb boost on:

amd_pstate_lowest_nonlinear_freq:1701000
amd_pstate_max_freq:3501000
cpuinfo_max_freq:3501000
cpuinfo_min_freq:400000
scaling_cur_freq:3084836
scaling_max_freq:3501000
scaling_min_freq:400000

analyzing CPU 6:
  driver: amd-pstate-epp
  CPUs which run at the same hardware frequency: 6
  CPUs which need to have their frequency coordinated by software: 6
  maximum transition latency:  Cannot determine or is not supported.
  hardware limits: 400 MHz - 3.50 GHz
  available cpufreq governors: performance powersave
  current policy: frequency should be within 400 MHz and 3.50 GHz.
                  The governor "powersave" may decide which speed to use
                  within this range.
  current CPU frequency: Unable to call hardware
  current CPU frequency: 3.50 GHz (asserted by call to kernel)
  boost state support:
    Supported: yes
    Active: yes
    AMD PSTATE Highest Performance: 255. Maximum Frequency: 3.50 GHz.
    AMD PSTATE Nominal Performance: 204. Nominal Frequency: 2.80 GHz.
    AMD PSTATE Lowest Non-linear Performance: 124. Lowest Non-linear Frequency: 1.70 GHz.
    AMD PSTATE Lowest Performance: 30. Lowest Frequency: 400 MHz.


I would greatly appreciate any feedbacks.
Thank you!
Perry.

Changes from v11:
 * minmor change for patch 1 "perf" change to "performance"(Huang ray)
 * rebased to lastest linux-pm/bleeding-edge branch

Changes from v10:
 * pick ack-by flags from huang ray for all patches.
 * run testing on AMD Ryzen 5 7640U without regression issue.

Changes from v9:
 * pick review by flag from Meng Li
 * pick test by flag from Ugwekar Dhananjay
 * picl review by flag from Gautham R. Shenoy

Changes from v8:
 * add commit log for patch 1 and patch 2 (Rafael)
 * add missing Perry signed-off-by for new patches #1,#2,#4 (Rafael)
 * rebased to latest linux-pm/bleeding-edge

Changes from v7:
 * Gautham helped to invole some new improved patches into the patchset.
 * Adds comments for cpudata->{min,max}_limit_{perf,freq}, variables [New Patch].
 * Clarifies that the units for cpudata->*_freq is in khz via comments [New Patch].
 * Implements the unified computation of all cpudata->*_freq
 * v7 Patch 2/6 was dropped which is not needed any more
 * moved the quirk check to the amd_pstate_get_freq() function
 * pick up RB flags from Gautham
 * After the cleanup in patch 3, we don't need the helpers
   amd_get_{min,max,nominal,lowest_nonlinear}_freq(). This
   patch removes it [New Patch].
 * testing done on APU system as well, no regression found.

Changes from v6:
 * add one new patch to initialize capabilities in
   amd_pstate_init_perf which can avoid duplicate cppc capabilities read
   the change has been tested on APU system.
 * pick up RB flags from Gautham
 * drop the patch 1/6 which has been merged by Rafael

Changes from v5:
 * rebased to linux-pm v6.8
 * pick up RB flag from for patch 6(Mario)

Changes from v4:
 * improve the dmi matching rule with zen2 flag only

Changes from v3:
 * change quirk matching broken BIOS with family/model ID and Zen2
   flag to fix the CPPC definition issue
 * fix typo in quirk

Changes from v2:
 * change quirk matching to BIOS version and release (Mario)
 * pick up RB flag from Mario

Changes from v1:
 * pick up the RB flags from Mario
 * address review comment of patch #6 for amd_get_nominal_freq()
 * rebased the series to linux-pm/bleeding-edge v6.8.0-rc2
 * update debug log for patch #5 as Mario suggested.
 * fix some typos and format problems
 * tested on 7950X platform


V1: https://lore.kernel.org/lkml/63c2b3d7-083a-4daa-ba40-629b3223a92d@mailbox.org/
V2: https://lore.kernel.org/all/cover.1706863981.git.perry.yuan@amd.com/
v3: https://lore.kernel.org/lkml/cover.1707016927.git.perry.yuan@amd.com/
v4: https://lore.kernel.org/lkml/cover.1707193566.git.perry.yuan@amd.com/
v5: https://lore.kernel.org/lkml/cover.1707273526.git.perry.yuan@amd.com/
v6: https://lore.kernel.org/lkml/cover.1707363758.git.perry.yuan@amd.com/
v7: https://lore.kernel.org/lkml/cover.1710323410.git.perry.yuan@amd.com/
v8: https://lore.kernel.org/lkml/cover.1710754409.git.perry.yuan@amd.com/
v9: https://lore.kernel.org/lkml/cover.1710836407.git.perry.yuan@amd.com/
v10: https://lore.kernel.org/lkml/cover.1711335714.git.perry.yuan@amd.com/
v11: https://lore.kernel.org/lkml/cover.1713858800.git.perry.yuan@amd.com/


Gautham R. Shenoy (3):
  cpufreq: amd-pstate: Document *_limit_* fields in struct amd_cpudata
  cpufreq: amd-pstate: Document the units for freq variables in
    amd_cpudata
  cpufreq: amd-pstate: Remove
    amd_get_{min,max,nominal,lowest_nonlinear}_freq()

Perry Yuan (5):
  cpufreq: amd-pstate: Unify computation of
    {max,min,nominal,lowest_nonlinear}_freq
  cpufreq: amd-pstate: Bail out if min/max/nominal_freq is 0
  cpufreq: amd-pstate: get transition delay and latency value from ACPI
    tables
  cppc_acpi: print error message if CPPC is unsupported
  cpufreq: amd-pstate: Add quirk for the pstate CPPC capabilities
    missing

 drivers/acpi/cppc_acpi.c     |   4 +-
 drivers/cpufreq/amd-pstate.c | 257 +++++++++++++++++++++--------------
 include/linux/amd-pstate.h   |  20 ++-
 3 files changed, 174 insertions(+), 107 deletions(-)

-- 
2.34.1


