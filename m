Return-Path: <linux-kernel+bounces-159573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E54D8B307E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A53287610
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B180A13A87C;
	Fri, 26 Apr 2024 06:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LQjtuVdN"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F7F2F2F;
	Fri, 26 Apr 2024 06:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714113320; cv=fail; b=UOGfbTRaXUKwFZjHQ6navSHk4sXPdKdV6HOZQXyqme0kI1J/3yc+5b5BqQXe0rAbIY45T0ZYdX/AAjWmSmNQ7aP2QODTOWvh4Xrom9C8RKXymC9qzV13EgLpaxHwgOl7c82vf5dcERWry+2Wdu11ZSVTizW6pUuzNifntoxE4uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714113320; c=relaxed/simple;
	bh=SKymTnBUicLMPvEgdigjmHo6NOsAQnh1UdGY2Y/xF5I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uOQPPWzvbKUjFIhKGY0fDg6WaGLfWvkTJw6jqY57MRa/qbGe9nr0CNhpDg/lOR/d5LiJx1U1sjNt78+PetBvjwwlL3k6E34P5NTeugDwl9F3b+0UwWxKQpTcvTqi2W4x5KaNJIG1MZBMW2sgbL1yINbhGY84S1w/YSKTLQHc3Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LQjtuVdN; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=It4A1yeK4PUQ/Y5voi/LWdORkjLEfGL8LZjoAEHFqyxTpJJaTPZZWwgxFK2diRbTO/+qJ5U/RtFjSJiuSaz7DGABtBKaw6hPvGbpkapRsAT0U/OCrWA5BKwUimy4pcndSYSxagjY64Kir6iMhXrBSh+OJtW7tqsOADOvHarZBN6KBCwa3spOFmkerM3eZvF45WW37oxAcmvM149jBVlG/TiDBnCEpqgCNhcwBY0WZi7BGe/Gt6SNzz8qyl3HJnoTldZPk4OELJmNo6zENGFANggX466QMItZvMi5Seu2vd/NBvWjC6F3QY43cX7n8KBC9iodPCrmpfiTfDwYVsIGtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+UlB61kFpW8UU0I+ArwiomP4WLsewnxO7rtI+HAotA=;
 b=IThQkuIriMp6RYzkwdh3virT60/+b8mWmhIsbOgLQ2B318O0raYYB8bavxEwqmT+Ge2Zh+4vFkevXWOo4iCsaD0Je5yufFhM4C1rPlWIdoPCxBF70iMM/q5XFaCZoEc4zHbhwL/euV1CdgtsuHFBAQoFaInQGbBVZ0DFyStN/P34oqK0vJlSg2j4aiK22OG3nBz53tcNuAdWyUUfFDE3wd7NgEbl7LXnmtSzLk2CiENzEHKslNLlpyqq33WhEtexAtE+Py+PZ+6Idt73X57Ds8w9WV/OyownhOcPwR7Of0LUUcjTvRhDklWBdu4+6SmqbqCEf/Sa82Xr71m0KTO5ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+UlB61kFpW8UU0I+ArwiomP4WLsewnxO7rtI+HAotA=;
 b=LQjtuVdN1H9+RDLjTlSWVmW0hR7RYsUGoLlItULpltx2yT/p5RIPktq1R/UZ22bEbWpoBvGxacJ2ILs5JbOOmfV1kA++1XVpQUtL9z1hfOvuQSxHO+rckxnFvaiNaZS8gZ1v+wPar7H9vYQILfY7fTebZcTGxEc86hvkRAm1vg4=
Received: from CH0PR13CA0029.namprd13.prod.outlook.com (2603:10b6:610:b1::34)
 by IA0PR12MB7649.namprd12.prod.outlook.com (2603:10b6:208:437::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Fri, 26 Apr
 2024 06:35:09 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::d4) by CH0PR13CA0029.outlook.office365.com
 (2603:10b6:610:b1::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.10 via Frontend
 Transport; Fri, 26 Apr 2024 06:35:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 06:35:09 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 01:35:05 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 0/6] AMD Pstate Driver Core Performance Boost
Date: Fri, 26 Apr 2024 14:34:43 +0800
Message-ID: <cover.1714112854.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|IA0PR12MB7649:EE_
X-MS-Office365-Filtering-Correlation-Id: 02f18326-cd4d-486e-6c4d-08dc65bb04cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JKpTTEhLzbTIWy23erpdPNc1L4GFMX4+831WwSWQ8FajMG2WFphUBvs6BQqG?=
 =?us-ascii?Q?9xwoI0sDZA4Agn1u3ZYW6R0Qxq/lYVS+hsINUgwFBvK014xWgzbS6mZ4c/eq?=
 =?us-ascii?Q?D53F6FwP7kwZIBociLwwgH8x1VGXHc9SoRJQluJDK45YyBPdc5qVH0hqjMND?=
 =?us-ascii?Q?4MCm1fxEnrozhCi8Fa3sx+MJoYb1FjP5OCdyZIGWlmcsbH1xzCodlPJ++0FT?=
 =?us-ascii?Q?LrJ6TAezMLvevu8eJAxrQALtZho+wM6B6TvdYMUnMkmarWCIpYUABGIZrn6n?=
 =?us-ascii?Q?wSAg/54IujVxlqL+MKqTc4JoSLZUhM4kiDyCjbqNfkhMygILKobPv0mV3oGh?=
 =?us-ascii?Q?MdjbB6Tcyqtsu342QPx0u4zrDnXrUlbv/OSzLzog968a8RWqiBdoHcKtcNvU?=
 =?us-ascii?Q?qTIzN5OUBAmboPISldjAcXPvDfZbB2k+CfybHSHTuRiqNw6X/hW4ynM7Fh8k?=
 =?us-ascii?Q?Rv6NMij3334zQdezfOi+3D8/shQ/FqdHC4/vdC+So3zvaIK2dT0vdZj4FYem?=
 =?us-ascii?Q?dJz68r/3uMjiL3AjI3c7ktCpnWCm93bogB9EzAyVE8mUGjda9hXteXGUjTAM?=
 =?us-ascii?Q?bgI307hjt55yeSQOBwZf1z7u4c/llEQ2TSiK5HjcDu3SIOTIuqvcojRCvHN9?=
 =?us-ascii?Q?8IW6ubd8Z8HVJnq9ziSKwrK3F37J+mBinLR9Z1zOnfI5l88czJapHgWz1qPk?=
 =?us-ascii?Q?FksXuNMi7EHvZcijWT2+xIJUyr79hLEc1vP+fMvmRPH46IrgLixb2bPiLWQw?=
 =?us-ascii?Q?7t26VaxfhlaeNASDbzXMtgYDesR1vW3rwz2Zw+hkszdyrliGTGjEzmC4L7aJ?=
 =?us-ascii?Q?sqFSgxNxtPPEt6rIPEBqqMtvJrVZOqbAFjgZyIWjoN/Jvr6NctnZkAH5e4eD?=
 =?us-ascii?Q?x0BhJk+sRt2c53OljKUKiuEWLBKj8/g2GTLDMMnCfMfKwT+eTyl4ieKUbuOl?=
 =?us-ascii?Q?jsOWTHr8oI86jIHlXPPjE9d5/Ctl+RD0UGkeJkx0++h+RUE/gEq5wHudzr4e?=
 =?us-ascii?Q?ME0jj2PJAJxcoxXPHAa9oJWCr19iDbRHL6PPNjU1bCSrzvHvt3oRE5O3y4RY?=
 =?us-ascii?Q?vGJcpkJ5HJ9cQ6ioXVx/2JDPZd1+XVOzpZlvdBeALP9N1X83zupLXMTdw3rV?=
 =?us-ascii?Q?6cQOJc3at+ugCHRzMqhyFicM/z2bh2VE6FOlxIZLrmyk1MDTgW3CxoF1XuG8?=
 =?us-ascii?Q?hGB4ywA0+wCCZ67HuzTAH3uK4DhuYfD/H00Qu02ezLggHtRSl+mSppXQHfOQ?=
 =?us-ascii?Q?EQz21xgxOuQMksGeL7JpBA4CzxoN7q1l3TBjdxNAp6VOSGAflpaYJab3GjVa?=
 =?us-ascii?Q?EGZ1kWcl9dAhu4ovtkFzQN6swra1HpurUIu/yeEicYW5uQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 06:35:09.3135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f18326-cd4d-486e-6c4d-08dc65bb04cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7649

Hi all,
The patchset series add core performance boost feature for AMD pstate
driver including passisve ,guide and active mode support.

User can change core frequency boost control with a new sysfs entry:

"/sys/devices/system/cpu/amd_pstate/cpb_boost"

The legancy boost interface has been removed due to the function
conflict with new cpb_boost which can support all modes.

1) disable core boost:
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

Changes from v7:
 * fix the mutext locking issue in the sysfs file update(Ray, Mario)
 * pick ack flag from Ray
 * use X86_FEATURE_CPB to verify the CPB function in Patch #2(Ray)
 * rerun the testing to check function works well
 * rebased to linux-pm/bleeding-edge latest

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
v7: https://lore.kernel.org/lkml/cover.1713861200.git.perry.yuan@amd.com/

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
 drivers/cpufreq/amd-pstate.c                | 149 ++++++++++++++++++--
 include/linux/amd-pstate.h                  |  13 ++
 6 files changed, 165 insertions(+), 14 deletions(-)

-- 
2.34.1


