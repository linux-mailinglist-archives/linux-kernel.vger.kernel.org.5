Return-Path: <linux-kernel+bounces-154641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B51178ADF09
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289EF1F2440C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0E653E2D;
	Tue, 23 Apr 2024 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F0KdmjmZ"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97479535DB;
	Tue, 23 Apr 2024 07:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713859127; cv=fail; b=VztfVCLTn+dA89lLMtj1LVRcVENIBLFMJuPjTu+3XWnu+KDwcPHwGQ9FBXVLWoKyKjzatzSpUNNQdnzjlYqmnJbRgylvH8uRZUeh3N/2qXVdehFCcoHtiio4WruhTdAYBCQWSo8HxTnkyakmfNeDDBWCGYSF+j6JKOvh4IU2MjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713859127; c=relaxed/simple;
	bh=7GXog4csUtc9jsmMsw0fCaBm6PKmSbHAcuGLpdP6kTQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L2Lgv0Ffn/b3RnnpFzHRoyWpOywLzf/VRD17Lfh9YssLo0vxzMY+Aic0Ay0JytRKq5y2Q1Ia5M+6TgljOgAJO4mP8/tR8suTRnwQwCx4A+srZOF/+jlu0l1hiDnBimP4PXxn7al9rCu4Oc3oAgoJDBSrtXyYtotZHXtFUDDeSIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F0KdmjmZ; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWHyTB8N7AfZq2zLiQUDR2xDWSqsWcGJSlTXcTEwxOBiT1t3FyKdJDbo6xFHrEraq6zFe4FQCdQjoqQhp2wo1pMvCFlZNrLa1K4lAJgsBLzJ1zfggH4tfEqaEQrnqxz3w1qakJ1pjGlNyqQQu6qLMNr2GgO6gecERvT4zepL8q3DKKak1tD8vbJlGLlBwjq3wRcD46xyna71JFTvvx1z0EgDlairjOoCH0FludJxV0ns78+DjjoNmRaWaX4VPx9WNs7Bg7Oh8jD3dGhZfvqlKee5nMu4kDQfp1iow/TjXQvnVyyh1rhv4GgroqKmxxA+dJXHYkzS5AO4NTd6O2VsKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzoK7tlrYM12kYGxHJiLmSwLH3WAl7g7m/Pri7GU4d0=;
 b=aE7vzDnCOPw/lCD1F14faVrg/b7S9Sy9H6IZUX/nxKBeB0QtiEofauHUJzhSvIyuZWH+LqmpnUOEPis5V/nk2J4wDW7oNlYEOjqEnNvPuzHJw0TeK4ERgeN7gCEywlEjH7z/iXevmCEs/vBPCCSQhwKAj4u/jJatEBxpph6ZDCyn+EZ6vkrT+87uIHfFEUfk0PKEvGIwlBRM+oFyKcqMTV3J1ZZnMvr8TO05voTooQ9Zgg0dY7H8w6/RT7oGYOxmiU5OFY0VRAvJ8mMtPEP+1iaxB8Jhbcqh7DfiJN5ZsxlMjB8CsydtqFcA8qJ4ImCYlgiW5RMkpNP//Pk+06zgaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzoK7tlrYM12kYGxHJiLmSwLH3WAl7g7m/Pri7GU4d0=;
 b=F0KdmjmZAIrNkbK9qBILm8Cg2TYIgjGhaFKiTB3W5oeddxTtRwhLTEYfaJeiK4U4i1IBnA2Aw0sh139PuvpVbMyALGeNB153v06wbwfSMU/C9NcCqXHNjuJM8eJh6RBU0aXntlM4URx7DXG0NYfHu+sN/Q0aT8yGL1GQf8DNW7Q=
Received: from CH0PR04CA0102.namprd04.prod.outlook.com (2603:10b6:610:75::17)
 by IA0PR12MB8839.namprd12.prod.outlook.com (2603:10b6:208:493::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 07:58:42 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::be) by CH0PR04CA0102.outlook.office365.com
 (2603:10b6:610:75::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Tue, 23 Apr 2024 07:58:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 07:58:42 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 02:58:38 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>, <Alexander.Deucher@amd.com>
CC: <Xinmei.Huang@amd.com>, <oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 0/8] AMD Pstate Fixes And Enhancements
Date: Tue, 23 Apr 2024 15:58:16 +0800
Message-ID: <cover.1713858800.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|IA0PR12MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: 553371fe-2cd8-476b-ee5c-08dc636b315e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U/ZoQyFA8BtMlRFBSx4es0wa6cZHT6gWcokQxkO1ktuF5QdBbu7GKciaLxIq?=
 =?us-ascii?Q?Zx2/JDkSMkoUxa9mN3JPXB5J7OXtHInKivpMiTghPrqsaxbPZMLE/BYPI8xr?=
 =?us-ascii?Q?M7Ve7gjBFXXYgJSEPO+TaQmSpy89elcJEMoor7TNwo6ucDZBYyQX7TkFJzbc?=
 =?us-ascii?Q?qcrQG13VjTiAhltKZjL93RTGvNpR+T+KYQffolu6dCsEF26Dc/hT60GXcj0s?=
 =?us-ascii?Q?DapWKaRYv9o2UfsQ52Or70UprWnvsqCPynZwXB0Z3eRJ3jZ3s2wage5vWAX1?=
 =?us-ascii?Q?ukXd/OBvf34BJQcnE32QLFWqLSukIwk47R62y6q8v9LQhrELcfXdR80q7eK3?=
 =?us-ascii?Q?+y7B82FMRyrHQPw/dOgNt3cH+ds3sazyJgmHs/wjMc0Bd7/15DV7v/mFAVZN?=
 =?us-ascii?Q?0Cd7ZwqO2sYQtbGU6spPceFq+aYy6Enudg1vEUi85W2sDMDeNzh1fxNVq7VM?=
 =?us-ascii?Q?0fhlN7QR6H4iEW89OoyX6uhOHFHYXgEd3w38/OWnBke9EP5mml55NEPotfDO?=
 =?us-ascii?Q?a7ZATRgX7lI4GVcyyh39FNNma6gD3vsED7JFcr8dhX6iIiuGRDRNTZm5Jjav?=
 =?us-ascii?Q?bNMTTtb9IZXNvlHnhb6ZTzzy7qY/W1ef2o5QZx1p9+rXyNHoaG6zoA6WGF2s?=
 =?us-ascii?Q?7pIIBKS/UafO+ZENU5ImFblEnP3/UAsK28gVXcZdSqPLFi29oRLaMKy+Hjal?=
 =?us-ascii?Q?EZQ2zygndGl1sSKfIAlOIEMKjigLsZ6a31MFkrJpSPu8QOU8x+a+mV/ti/X3?=
 =?us-ascii?Q?tK7r1eMOFylf/6Tu4kmJDmim2thyzWi4z2judKma70jTG6pManAOJJq43gfs?=
 =?us-ascii?Q?ZbTlqn52x7G8YV2LMGv49TndtTw63UkYhT7z/7SW9xbTTtun259o8plwlW/P?=
 =?us-ascii?Q?Dhfdp0VzGzP1H03myloQL9LR+1GRo4uq4wNkQL30Sm4seI1FWrufiw5sjQyx?=
 =?us-ascii?Q?BU4sab8dYKdgtMFFQcQ5QpIs0K+TjlbpDjmrDD0Is2VNusrXCQH3uNODWcrN?=
 =?us-ascii?Q?Nsn9Cqxs1XTN5Ys7A//fKQhXzmGgXBgDOg/B2T5qqWMBssOUgRSG2B4Nct/S?=
 =?us-ascii?Q?ewlDHZKPv8sTbi3VMIcGpqUCgJ3HCyYsXiiP0arvq5Buw8LJ5RNrHz8E4fh6?=
 =?us-ascii?Q?0XDvxoWC03ZDfjRIIg5gvn0v655bSTEKdhWZyRltojUjF6HzG/k5doXbVU/X?=
 =?us-ascii?Q?D9UQ1BMKJ3OKOuBOm51SpTgum7ZnQX8Rn4aHe6U5jAYiCAMAeq1cLNDEotni?=
 =?us-ascii?Q?+1COc8jimZgoPWLaquASkXkF+YkuFhIrhWCDJYnVas2EcXXViENgiygRbPS4?=
 =?us-ascii?Q?rkhYfCbHZ3iSxE991vz/xi7YEeZDVV+v6PnmALtoJ+cQOKXxrLjPR1H2ddnq?=
 =?us-ascii?Q?xJE9i3rhVFQpYEvybz1TXLqviJad?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 07:58:42.0098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 553371fe-2cd8-476b-ee5c-08dc636b315e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8839

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


