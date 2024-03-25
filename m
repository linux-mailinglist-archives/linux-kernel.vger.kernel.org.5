Return-Path: <linux-kernel+bounces-116432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6240B889D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16E82A78F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7442A176FD8;
	Mon, 25 Mar 2024 07:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WCuMz2GY"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEF738EF4C;
	Mon, 25 Mar 2024 03:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711335853; cv=fail; b=qk0GitXY/uFvO+yTtyQct9T+9QD0j1eHbp4AjYdhi1ckPLoZdgCd4t/MMTeHkZYWQA9sjk7P7rlKFxk5GAFsY/UWZ8Ofs0KhCmGBUJCTD3s3AuugXpW9rqffi0F5Wk+3xF28kO/7jI0gcKxd52cdYTU73J4OUyBYXTmdzH3AEVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711335853; c=relaxed/simple;
	bh=nLn98yROnBQx8E9QtoVP0pqqc4krE4PUqBHPqldyyOA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JfMpnZJxa1iseBuQZJZpbJRoYCcyr9RkOHfb31nV3MVznI0BsigryoSlmLMcMl79WGxstIuFKzTPpIyWxB4QZFZeusT+m1aGemlJGF1WQPj+KpFqQqv4LA+golWJbMNDMCetOH1JnlbN5cdThCGGteoZ5FU9KTRO+FAABxxmtd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WCuMz2GY; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgvbKCG1hvKxuqbPXKH6P+kW5C+HMtsq6p2t1pmuo3pL2w6t5CIt7b9Z+2RQqWSI0Dc19laN0PEXDiP5mcMs07bdPrzNUloe/jy/dWS/MR2UokyHlg0jZVvOp5mhvGZSoHqg0NdpmR/3IJfkujZizmJ9qKTZVUJjKaIyP2IoMrXMuNlo9Kn6dqlQ+bKg62yeliLTF58WggkhAd+rpgLBrRAPySFHfrol6aPXztJvGlT5f9xuxxWaGVlasR8neTsQ+OH2oCme5b1kksP6kylcJvi2HttOnx2XKhEnn2wJig0vL2IJ4IrPO4SGKcUqVADvKde+T9x6L3pZTWor+v9y8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3xooCLWXGRJ6GETW4odN4MI/Jf8aJsl5FNL/ecChcw=;
 b=KrYrW4/M9PFbM/FQ+2bzurssy8BT7h/BKrETuhgXsDAu24kKe1BUrRBnAY3MdxuSsdbLupqk92H2XNLqxZqPalip76pdZymoMOy6QyNTCxM2Qm05GEFqkNisr5x4b5N3YqRpPbtTcWchZTe/khQaEvKJAdTdBvJ4UqcCYoInaf9rfEhAWqIoA3LJEA51VxiPJjxNptMC1wSOsxPOOKFwxjMu/uT0bqYsGYTPcdSCZMxp5YhpWPVMm6SEJTfH6X4kZZCpJHB6Ea6dxa8pi+uLLuaQJqhWefgb4jNmm7DlYAZUD8LaOn9VGqhe/7kPg2A8yBl2vR3sgXKIo5r+Ar8vNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3xooCLWXGRJ6GETW4odN4MI/Jf8aJsl5FNL/ecChcw=;
 b=WCuMz2GYB6q9wbyXeqb8pWcZhTffdX7nUiBLVicxbV4l1Btb4jmcCt2VPZ4T0zzhCEy2bhze3wWU7/JutXWgrRBSUTDUGj94+2jyd2VC94lZgRq81iMUG22xKbbnB8ws4ORToGIrf+1VR7/m55cvvHLG0A5NMLFKYX2OOvoVMvQ=
Received: from PH8PR20CA0014.namprd20.prod.outlook.com (2603:10b6:510:23c::24)
 by DM4PR12MB6009.namprd12.prod.outlook.com (2603:10b6:8:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 03:04:07 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::7d) by PH8PR20CA0014.outlook.office365.com
 (2603:10b6:510:23c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 03:04:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 03:04:07 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 24 Mar 2024 22:03:39 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 0/8] AMD Pstate Fixes And Enhancements
Date: Mon, 25 Mar 2024 11:03:20 +0800
Message-ID: <cover.1711335714.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|DM4PR12MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a0d090-97bd-4101-eb2a-08dc4c783c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dKqN4YXNrQmZwANLciG/cLvem+Dn5GNdUlt+LhFVQAMOrLR3yikaedUsD6r87mruRvgkV8eQ9jOrDJXk9kfS/FZ1H73luUpS4u28ibKwcbXZ8Zod0Bd7l0XIRwPW5XHkiLaFn+UhrZbZ1ZSqq1tRSrJE/G7iw9iQoVRV0a3YBIfHrRcMEEFqFkXW2J9ZfSptNQPNDzkCabmBQqSc7u7EDW3gJVujF7WblNIjb7AYgfSRyswH3aHUG/RuojMuYfofITYsuYquwiLukrgNlkWEazdbKbnYP1D4Ix03N6woxOJZA3Ez9EQQovtJKlrjCZtzyeQfB3ThSGULnbxfaFwNlq3rig3DY35b9mZw8DN9WFa5ybqpNwyGOG2TfglOkyAJJlqGWU3Eg3LYZ1I4/6FY+YfllXq+T5lYNeOGiVUVFTDQz4/H2f7yOnBw3/obBx9Iwx3zeiJxDKvgjquihwJqPqJOiGzxj9/FHn6yK8vdcsH0dUltBk/lXw4Zq+WgoRT2IxdwTu/2CZ8UZwTXwiQqKM6dBlBeISY49JwjwLFFnAIGKAwb7dnvsfPSYLQV6uG+xt9ltz4pp7PK/0quEw6NbrH1WPyJiC/VDoPX8kTviTS9G9N+zKrtWU6T4q1JWOe3L+gdEQT6YyO8SXHzPhZwouLJj0mpIM8tbKUZhqf3Np8SDOBKRIixiKd/76FnpCCxpV4kgHlWo1q61CQmYrOm7g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 03:04:07.1601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a0d090-97bd-4101-eb2a-08dc4c783c60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6009

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


