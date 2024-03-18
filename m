Return-Path: <linux-kernel+bounces-105966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB63487E6EE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22AE282B57
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA321381AB;
	Mon, 18 Mar 2024 10:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eNOsnW9x"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83A03770C;
	Mon, 18 Mar 2024 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756695; cv=fail; b=lseWS+4N0YNz3cMTWf7QlPrWx5z4Lgc1hK/hoDMcGgZdNPxFCqCVjpCSfZgoMFK6Oz7/+797VFsvbh+DWE+2HsAglixyOaxehILyZEiKo7VQAR+3max03DQE+ui2QAnD2M4piKooCEXaasGsJaZAyRr1sbEDpnMgabQSOc+rKcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756695; c=relaxed/simple;
	bh=xtyhXkY1/RUa1o8jvW0Wj5cwZRVTUv0l863IPqI2n84=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cLjOI2CwA4slR/DVa53mU/iqxZP3qStXnJp0DrKo+Yb5Hu/a3j3YyAlno/fPybRENQvgFiaeXv9u71/gVMYNsY7Rl/8k0vJp94//nYo1tJIvfsWbhqPsEz8Eho6pBBvNj6NHAzf7rTDluEnqJMYRra4GZbF3lDLIu/sBK+nf1c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eNOsnW9x; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBo5YVJOus3PoT8aSVVNjO2cMXkxHdPBoIMhrbT6CpNj+iK2Tx7GUjdv/VMhWLv0VqIALghSqvliHrWSSn7Uk9pU7oXWyullV5Hnu3ytBFaPQAJ+StL4fa/44M1BDjkPrQh/qykTG6cCIXBf9BA6gHP8c0R/HjVHfmCA6dhl4dE4Fnwm0+SeCX/Fhcb0Qlzdgu6vnpI3ktRoR01ZuZLcC/lYjt3NLCq+B/wJ8yOpDuCHdGl91SXN12clCJukOYewPiG789QiXL28hYysF+ICxXCf96CkERjy/i89iSQvLMU3czsY1+ajEWamnf6PkKKVllXHIgT9Kgko9O9Ts5j5/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m09Z/nSzvbWZGwPkQv/+9hJHSO4xyPQ1z/plsEuqwrM=;
 b=klzTd+oN3IlwSBEXdLCvAXNwOfDhE26OJzGwUQx8y5VWsREZcIGdm0hg4mpGuhfVefIYvBptv8yGrPX/VGY3/oNJfn7P1CaCPiy4JmnSanM5cGnnAxAwTfeY71RKvFpTAM3BSjnxboqOwIyzwjzn0wK7IMRUg9X8hifnr/LQFqjOZcKzUqyBcAtgJovzFooMrs3OytBQWjxEwmrmfICVlulVYyiZsaV9XRlKYgAaYN8vQeHt1eFjLyaU4Wq01rPkr4j+mWSxHYK3pQHAMPxXnWg2QMXDyHqKc08RZnHFq69YDEOe53ckKCJKJEsOkN8fgV3otJ07Ag8dFo+w005KCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m09Z/nSzvbWZGwPkQv/+9hJHSO4xyPQ1z/plsEuqwrM=;
 b=eNOsnW9xSWdrbFTGRn9vpUQTgwH7XOJJNlJoiz4s22orHMIqxCTFc72GiZHXJjqnyUr2bFfonlzVkomL16Y0duYLx1I7zTIeYFXybiUnR1O6Pfki8CbLdyTiqyOxz1IvrI3POivNoAoyWgPd0kPbLKusQVbr3GE9jSx7DEbXZhk=
Received: from DM6PR17CA0003.namprd17.prod.outlook.com (2603:10b6:5:1b3::16)
 by PH7PR12MB6563.namprd12.prod.outlook.com (2603:10b6:510:211::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 10:11:31 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:5:1b3:cafe::32) by DM6PR17CA0003.outlook.office365.com
 (2603:10b6:5:1b3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 10:11:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 10:11:30 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 05:11:27 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 0/6] AMD Pstate Driver Core Performance Boost
Date: Mon, 18 Mar 2024 18:11:07 +0800
Message-ID: <cover.1710754236.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|PH7PR12MB6563:EE_
X-MS-Office365-Filtering-Correlation-Id: a39b530a-be61-4cdd-db0e-08dc4733c83c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oEBvFU3p542Gp0u/27NkY8CQmHasOfSXvP0LlAGKLCfXeC58anDLJ/kYXqdfhwDNudojCWa1V6WL3gUn8O7PyLyT17UFk0/MzO81F//ZIToYat+mU+xSiQbOLlXr7ZYkgHT9A/MN8WiRu+XFRVSeZrnkPzxzPIvL8R8KUxo02SQjnH2BYQXroHYg7v2sJMLDeUcJ6HJwAblb6zItiDdkwbSfXQbDjP525szDsLMK+lUYNEjf8Y3nH3a/toUtIl8FUgUspESyKJEtAJuDxbVNcUFwU/cvSCjWnkiFV55dNmkLQNSpzD4vTXPqcVmz22UGbgIijS03yfflX/nDAv+3Bc7Z0pXe8oxRLIeBSxyrux3KrmnIlkOke3MOrHwkL8ujW0qY+WJl3sBlgClu9yMpaHrH1vXE5bC9344VCpNRJeISVdqpw7lOI+GNIUhDuMJjvIdSuyp2fCFQb5mtCb2ISBHLCdypkcmT20Q3Fl4xHSn8tkEVjJduuNRUR5+wrEbrDQscMYEIsgsVhBUGf/bZ+DJ0HH9UAeiDKIRM06wmHXNh0d30Pxb/nbqyHtnjYlhi4i3mdmx+UTw4x4bCXwsGjKQ5qjAKEbLGa/GPIEGfzfPIzkY00u1AhbvC5civRdx1toiSPrLS+YZV9Xgrb5qjxgEtuPEJ6Yr61eFJlCvec1GI7QaXWWKwewSAZgTyocUJ+9A0Rz1iDIKWUde0PUSqlw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 10:11:30.6853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a39b530a-be61-4cdd-db0e-08dc4733c83c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6563

Hi all,
The patchset series add core performance boost feature for AMD pstate
driver including passisve ,guide and active mode support.

User can change core frequency boost control with a new sysfs entry:

"/sys/devices/system/cpu/amd_pstate/cpb_boost"

The legancy boost interface has been removed due to the function
conflict with new cpb_boost which can support all modes.

1). enable core boost:
$ sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
$ lscpu -ae
CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ      MHZ
  0    0      0    0 0:0:0:0          yes 4201.0000 400.0000 2983.578
  1    0      0    1 1:1:1:0          yes 4201.0000 400.0000 2983.578
  2    0      0    2 2:2:2:0          yes 4201.0000 400.0000 2583.855
  3    0      0    3 3:3:3:0          yes 4201.0000 400.0000 2983.578
  4    0      0    4 4:4:4:0          yes 4201.0000 400.0000 2983.578

2). disabble core boost:
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
https://lore.kernel.org/lkml/cover.1710754409.git.perry.yuan@amd.com/


Perry.

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


