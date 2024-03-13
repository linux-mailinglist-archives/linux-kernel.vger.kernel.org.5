Return-Path: <linux-kernel+bounces-101318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FDC87A57C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE54282499
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F5238DE6;
	Wed, 13 Mar 2024 10:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R3H87CtP"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9C21756B;
	Wed, 13 Mar 2024 10:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710324303; cv=fail; b=aO1ltLMWoE/4LVo8Mo7aSCY0yTBJgRUg50L8ic63WziixufrD/kAFdws/DTcwJzb3623+Zeb1Hk4dGypmJcSsWcPjSlOlWYdmZg/i7khzYkmljStJhqtjeHBLc1wGr3vc6PDYr+vhfSUVUssUKKW0ux2ya1mjOGUOBaqr2uS3Oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710324303; c=relaxed/simple;
	bh=ZjMTnfrg+FLZDDj+qRlA/3jnQPL77j7DSDCqmhSvKLY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uw9ZqLdJKm0F1c2Vgg7VMmW4OYTaFMHUPP0ItXp8+wGkR4QioVwCNAi57Pnp0euSmT9y1uromIgZ4cM+y2yyXiV63j2EpTz98imbU0fZ6IQy1Mt45gOAS/GoA0VXDd77l8BnLtlWtzEQ21k0NP/rQyszseK2UzsfYfuAYgCG2qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R3H87CtP; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3AJ/8IVqojkerQ4ulPwsAkJ+It7PfO4+fcEV32u0KIOdVHePA68rP7rV9WME7Mzv5EPUljLvwkjGuWwEaZnBDQEk82fxLeO0At5HOdNsBFqwFv4MRKoXeD4iHLb3b43WWbINUoqLD5qi49SGhL7y4/YEin9EWR5sgdJGfuF5m7FQaQy1Rryw7ABnAsgHeU4xIZuFkfx+Jn8HK61NwUWJq3OXwHU5lSpuCn4p00Fpfeqgee1Lm1E3L5U31F9DzoKOFP7m4od3EZjs42qtJrjs8wua2eDxw/TeXTiRQgIaSUNYtY57Bj4Kjg/OjZqV60FgKhjDrNrwnreCI7bUmI7KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNEJ/c7Mt8N64qtwdIxorszOGFlM1Ggt2ignaz9tGaM=;
 b=fn3813dLET8FUQ2Dz3U8VPaHWTgTITdM7J1P28Vm7axItPvNKr1I+LXyGwboNAc0ODMKKkWh25nCYhJ8Q5sboxERsa7URO3M4gB5mdNnhxCvPvkwRETvm0ABh4NnqyYa2mwB+zsc9d7spQQ2EZxjZmAi/awGD8KDCzq6UarJ9PFqZheLfFQX6rBthW74wOtKjqpA4qlV4aN8GLZkk5q4j/6qQes/13nB8xTOCnYJR+m+9SrNaPcWro4T56bTN1U9R+o8sXplG2cNDjIVIwHjHToLwhwqNMivAIyAEqf3s9g+QIhTfts+4yMkqwKK7MzKYolgUr8yFmeR4XSMrgkkAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNEJ/c7Mt8N64qtwdIxorszOGFlM1Ggt2ignaz9tGaM=;
 b=R3H87CtPyBc5ejqfLfPb7X9gDm+D9V60t1PikbV8e+dIylwJk5OewI+qLS+T8BavD10XJj0eHoVE2q+pn2uB1vX35TDMvuL7gErTKQZ7grYtKAy4Kav2cIST9x1l/2/pQ777OnO5F04jT/BmSJ/ZiKdnmjAeH9QQ3YGN8mz+YzM=
Received: from SJ0PR03CA0114.namprd03.prod.outlook.com (2603:10b6:a03:333::29)
 by CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 10:04:59 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::8c) by SJ0PR03CA0114.outlook.office365.com
 (2603:10b6:a03:333::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Wed, 13 Mar 2024 10:04:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 10:04:59 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 05:04:55 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/7] AMD Pstate Driver Core Performance Boost
Date: Wed, 13 Mar 2024 18:04:37 +0800
Message-ID: <cover.1710322310.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|CY5PR12MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: 2090c4a5-4e4c-4cf8-03c8-08dc43450aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gTnIDI+/Kp2Q/Ml4MVx2jDSnzcXkXMB4eBEFPUDoq2J01eL7xzZBo5d8nTG2tPltVC4IlXNqXzf3FNnwOFYPW8Y9svHI9dznKnnzEVtpTcNY0uP8ImpYuCqszAzo3HPjhAUXJR1xFRcVjldaPcDOhmf2g1gnkD+n1+kY0ulX8OklBvUfnyhctdGJ6ZSjA9UZq9Jh7EoHH2cHnI+l46DqERj9qclHM/3sn/JjyoB6Qluvq5iISxCcwV3N9LR0vO1S/SU0azwrhH1Ee6mpMxbZbX8o654xTgmscFSz0hkruy1cOAuVdrHTy7rRMc+qw4RPWtUnKMZwoETGo6yb/2P0O8L6FxG2wmLLCIkG1RqO1Vhged547CsefPye6zfk7bAOPUPjqvHkMQLwUQEtP6epU/zaqwpUoClYKxgDDqKKiUrMOufcZlthEeP/2MvNlPtVjmDE4yLrkqK5PYRThYC+Xg4vseXjWq9ClyeuSiK6jReXV3gyCYW30VI/1o79yKUuOAbSYKqbgxnkVk9bWux27WHxxl/dZe5j1JHIbpvO8hc+KYfGX2S8EA5aB1Blu+pnnAR+kf512VKchV2PMSKvWUyRl01nVtBlKEIx7L0K4OX8g21VbkN+6qhvgY9Mpm360bUOvgkoyjKDThE4GSmjZan6MSFuaqSP25gLRPwC9UGyHJLqrdZSWn2hdt7cUY3AOrjC5OfJDJRRzBG+hf/AIg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:04:59.4650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2090c4a5-4e4c-4cf8-03c8-08dc43450aff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057


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
https://lore.kernel.org/lkml/20240208102122.GAZcSrIkbPJfIExdF6@fat_crate.local/


Perry.


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

Perry Yuan (7):
  cpufreq: amd-pstate: initialize new core precision boost state
  cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
  cpufreq: amd-pstate: fix max_perf calculation for amd_get_max_freq()
  cpufreq: amd-pstate: fix the MSR highest perf will be reset issue
    while cpb boost off
  Documentation: cpufreq: amd-pstate: introduce the new cpu boost
    control method
  cpufreq: amd-pstate: remove legacy set_boost callback for passive mode
  cpufreq: amd-pstate-ut: support new cpb boost control interface

 Documentation/admin-guide/pm/amd-pstate.rst |  11 ++
 drivers/cpufreq/amd-pstate-ut.c             |   2 +-
 drivers/cpufreq/amd-pstate.c                | 157 +++++++++++++++-----
 include/linux/amd-pstate.h                  |  16 +-
 4 files changed, 149 insertions(+), 37 deletions(-)

-- 
2.34.1


