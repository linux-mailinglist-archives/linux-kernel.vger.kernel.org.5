Return-Path: <linux-kernel+bounces-104022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6904E87C7FE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28F01F22E8A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399C9D534;
	Fri, 15 Mar 2024 03:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y9176obs"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C5A323D;
	Fri, 15 Mar 2024 03:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710473959; cv=fail; b=EYoRoFCi+Ahu9EXzzgohyNo19BzvGJTcUcPIj9N4X9dULQoPMXJJFH53ovWsuRkHR2V9cBGJTiuVq4QwNC5yyXykohEJ8jRHdtcRXIBPBBUDsodsgWBym7DknJq+orwuq+xicadW+b2T6jzOrUI7y1x7XQ9BTvmryzmE2tTTc1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710473959; c=relaxed/simple;
	bh=Juzj7BfrLmnw3RA0jtipsieSytGll2kYeImehvm7MBE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MvlBDvLnZns0QsYJFAZv/AorGOceBWIfcJlbUXW204VRA5zml12CaLajssRfb2d1ncwsBnNux/MKdJDOpeTKCR0WS4Hj68zb5IVZSlqREp9itWaRtvK3VLZ6meOg34DbuN9AXophUFTU6ljAhOeehaaYitX7vu6SunHlM/ahg3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y9176obs; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j37IkQW+cjzqzy75Nrqze7hFrNmiA0B1hV4/oN7aFtsy1hjZ1J3MjMXdy849n0DHkjI48frl9qABsU/JBymxaho5VpWEMiByO9MraX5k95BEy1H2L3YH7RWt33fgH+caP8c5lJlLQo83h6jI4HUaI5MAFBVI7vBo87H9Jhk4aJVtfd5xBQEsx2Ypo+DohS6MjWH8kGXdoZMpic1YM8WdvXxqIrqTx225Ef3uN8Gp2SEzq8VF+lU1+unCMSUxkr/un8pNJQWaNqdRqih30vkFIQBaUFglaeUet3q53B4OkUvKSdYqh4TVX8sd2TSfj87sGuQJxSBIJLSlpeFdk5Amkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qnp95cff8GuJbpSFmnj7O6TvSzBB0Vkjg6DWvNUK4vc=;
 b=RxXqs5izCdYNeeLPZmShFA/+GaN9+rpv0uh6FRRHaMhWOUr/o6BwlaUzCxEfWZDPM9bkJCUVGX6GeMaNemh/T0tlB3rrr5uMm6UlBevFhKgShbhl1CyYS1h4Bdi4igq0HcWHcdcwAXMGbHryddVQzUYMuXVRKwixgahFSwxHWK3XjpPKFfHzI+e98xLGBtVOexcJSY5hyXImj6eLtAks7bsGhhld9K2Ww97eeR+sERZ4VfLbTbeBDkntA4wSDreIfsefBvBGrA/auz4O6WVJZRjlsw6tbtcUfcNitj7rD6lrmW5qia7Q2LOSakl+TfnjQOib92P9lMuEPMIafRgB3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qnp95cff8GuJbpSFmnj7O6TvSzBB0Vkjg6DWvNUK4vc=;
 b=y9176obsDIXfJFqt/3JlnbNjTVRj2i6M6xFvytmNRee+ZMWwCLNHvUSSp0z8LXLfLOQYa/D7IGaRpxjD0F4e5yerN0HvSpem/SLydCnQsnp9poyqNDsohPR4XUIbLCPtE1XK+tec1Rv2gDKt0Z6HozNr0hkUzhkUz1GLsHvzj2M=
Received: from CH0PR03CA0205.namprd03.prod.outlook.com (2603:10b6:610:e4::30)
 by SA1PR12MB8842.namprd12.prod.outlook.com (2603:10b6:806:378::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Fri, 15 Mar
 2024 03:39:14 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::55) by CH0PR03CA0205.outlook.office365.com
 (2603:10b6:610:e4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Fri, 15 Mar 2024 03:39:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 03:39:14 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 22:38:33 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/8] AMD Pstate Driver Core Performance Boost
Date: Fri, 15 Mar 2024 11:38:01 +0800
Message-ID: <cover.1710473712.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|SA1PR12MB8842:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e905fde-67f4-4f8d-654e-08dc44a17c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Pi7N5uZnw5XeJA4zMTHU4gBfL4ObBouPrJHsZSHF0/Nk9u+uo0PbFmmgc3KH/oA/MJYKyiYGNLm8EEBGOhdvLzB9pfQ+5hWFICq9rY75P9byVE1AIZaNbyiuC7gsr7nSi4ohh2FduGA/QZ3jlpqeySFG5TSWyvbaIych54xQVpYeeocaYmaqRjSVv6p+hAhNgMNOnbxqx1wldEmLM9gW/Zl0LuOWBZyoQiYVeDaauxgEZNXp5IaGuo4pvf55l1Tg1vlP4Tf1YKu8FwIL0z5QVR+9ksYPg5hQ1kKvrarQdqql1kAt1Hgypk5VFrORrVy/B/TwTW1MTOg46GUx/WxYbdS5bh4Km7SjcqeOeZUFXx44goViLr24mfhJq+Whk0GtV4OCuTY2s0pLDo/KAmRyZbqZT7ANFPucOvHi9GLXvY6ez/o6m/M5DI1Wfu4qPnfw5ftUyOJmg/7oH9+YlOSGaQqtBZ2RqGM50EGY7H8bznGPu7UF3Xa2SOqNvkYA/Okw3iM7fZfl2LZb8RmtaJiylzJpDPXSlMUI0BoO4GirQ3DvRAJKJTFP3MwWR5ATK3V8UXKS1IPp/66Yti6X/7c+zoRiGC3wpv2yqla3UUTVnlxW/Y3LpT2YQEOBDufSCAK5Ew4pGrriOIUqgkjfmRFeiRVzcicdLnhSDdHgGv4ehVD4UxR7w0t5ps22zAhzog0oxCMw+QOnqrhzobAE5sUZ+A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 03:39:14.2195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e905fde-67f4-4f8d-654e-08dc44a17c22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8842

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

*** BLURB HERE ***

Perry Yuan (8):
  cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
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
 arch/x86/include/asm/msr-index.h            |   2 +
 drivers/cpufreq/acpi-cpufreq.c              |   2 -
 drivers/cpufreq/amd-pstate-ut.c             |   2 +-
 drivers/cpufreq/amd-pstate.c                | 157 +++++++++++++++-----
 include/linux/amd-pstate.h                  |  15 +-
 6 files changed, 150 insertions(+), 39 deletions(-)

-- 
2.34.1


