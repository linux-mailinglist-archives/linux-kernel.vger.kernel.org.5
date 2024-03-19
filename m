Return-Path: <linux-kernel+bounces-107237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CA887F9CC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA8B282FCA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D0165190;
	Tue, 19 Mar 2024 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dSAxS2kK"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CFA54665;
	Tue, 19 Mar 2024 08:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836952; cv=fail; b=jqEQJ2D5Km2pxJSGt5ZULTgIHyJg5b5GtSah0A0gNniNN7pwWm9EWp4d7f/zqJflweZPckJ0OTfNGDqAR8rMwv9aWHQQe6Z1cZioFFUiCB9VuVL2gcBzTwkYEyVoqkXALBUWY/WlythNcHySEcloy2kjbx2hBR2Z7kv7UnCO2Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836952; c=relaxed/simple;
	bh=eeZ2KGVBpm/P1kCfKMRfbwZN7Yhns7uZLmcb6Woz3eU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mihQziwHNZPkzCpIvFKyfOsa2iz0MpSsF69u0ZwnxNPt7H07Gwjukb9J9kkanNK0JOiveOKGthETkjNf6FNoeBKUlLFG9geiighloA4lpR7TN7A/U8IO+qJt5ikc6yC6fG+dFWXxrYRPkUwrcdaoys0qFSD5jK0uBq4RSjBdBpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dSAxS2kK; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsJU/ae13rV3I86rElNJZJN9rhzMJygY5aNuweNsxSY/K9dGjKsNofBjTmPeyTvNgk5QHOhdu1XWsUk+Kk2ukRrPbZ9g4c63r5tyisbjYe+i+mDGmFABoAkhTxYT4AiRt95GtqkAoE1LV8P0ad+Q1Ier8lHcnFh5MxclsPOd62mAlyZ8VbvZV41Ts4or6Qz0yaQgGr1MqKARnbNEmjZMYR2K26BVnBX6LXD9Q7Gvl7hpHUkaV1CBxQ6QdNepqGll23rPJt0qrQkFxR75wYWgBH5/aswBS5hdhZ9w9V6OCeoMC4vF5/A7xsRKrFmJimeWA0/fYOVfCIf71EHosVij7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RViYNW6QgZR7eH8w5jiClZ/wuEWydKkbGStco+2xIi0=;
 b=Ztn/EcRNJBx3IzOpp9Kj1fAq4BDHYfriuuBhOca+P1gWF2u7Mn8C9ydRl4NAGD2D9mEUhqEtL5dP1mQnxryMOmFW2k28sseohBdZSqqaHL0UyGTUpfYCdF0PfvrdGy5hpQ3K3tMfuhK1HkoxFlBI6ZccCPwXa7wq8gifqUkuMWdh6rrDv/2xGB/TxpVXkTkx7vTgpGMlzMG8JIC8bbzPqkNL+XX3Xwa3n+ZqfdTWvccv/QNv8f1XA8orpz3i4cX56EsuA57mvLqjSERk1Z7FoEHfzpHh7yLO7jZMw7+CG4AzdYhwkikRUAgG03GHqjkB0t4oEkrq5vseakvZzj5g1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RViYNW6QgZR7eH8w5jiClZ/wuEWydKkbGStco+2xIi0=;
 b=dSAxS2kKFnR3wYJ5j3xioiK8EDEr5/fQVM292bH1tltWKgOwcCcL22UL0jEu/GFn9iz6D57mQ+pQ1l5yx1pXRTYuPFudn16WM/CIyM2+IKLMv8/V6kV2mWOXGTUb+bUH+jDyWapqVGLKWe8pz6UZpZAUjkwZIOcDWOB6GzQZiME=
Received: from BYAPR08CA0013.namprd08.prod.outlook.com (2603:10b6:a03:100::26)
 by PH7PR12MB6563.namprd12.prod.outlook.com (2603:10b6:510:211::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 08:29:04 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::1d) by BYAPR08CA0013.outlook.office365.com
 (2603:10b6:a03:100::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Tue, 19 Mar 2024 08:29:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 08:29:03 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 03:29:00 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 0/8] AMD Pstate Fixes And Enhancements
Date: Tue, 19 Mar 2024 16:28:35 +0800
Message-ID: <cover.1710836407.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|PH7PR12MB6563:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b05eb8d-e9b0-46dc-713f-08dc47eea2df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zA6GszbhXIjyVoC7dIpI2fhlX3ORtn4vh64/7msxol1d6oiP6fh4B1Sm7BGGN6vBuMwJ3c1oWpdySzEIBkGCpdVXOZhIr7Edb/H5WT5UAxOO8xaRTDE/uUf2E7jpmbbPg+aIHM+eHGC9XF0U6syVQ7ogYLwMyia6y2ocGiUAQVvhF5nWq3bgmq4Wutc1V46RT1ElNa58CawpYGu53TWctNQvFpkSWB0/W7lkswGd5qV06qHOIiAUKpCMa/m+UsH0nhzwlnGy4uIDcXGYNMY+/N8Q4sSOzwihnlJYSCRc4/Fl66MNI0C1hydxbrBDuMaFpme3UC31c1bxmZJpJ9fkxwi1yRWZixuZVLpplSWov6Jm0zuH0CUUkFCaquxlSS/R8KiVIafs8ibLdtrdXLRwYyNziq0u/tlk5lwaQfdi64A+JVRFToyeUN1ZrTme+vjQhidG0wPt2eD4ZOkSYW6Tt+9Nt9t3xIihBFo2rLjoyPl7X702nGA7ZpmXM21N669DqtsfgbYDo/hrWhv2yAlbSK605H0wVeMSRXkTLeWmfDtg77I/MIqWfUp34pJm8GljiEC7so7hx/f6RuK9E6X9FCqcnylSe660kCscSIKWfro3PTw2Lyxonr+C7mP4MjiddcQIaBYvJZo604Bj1UgzeYFjgQX/VPg97tDANPd5k28mFYNrzkHAJvcJt2lDtlw6lBrEoWZrn7gjLzX+j2RLew==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 08:29:03.8858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b05eb8d-e9b0-46dc-713f-08dc47eea2df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6563

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


