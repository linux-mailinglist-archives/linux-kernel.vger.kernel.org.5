Return-Path: <linux-kernel+bounces-56191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBC184C72F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E627288E57
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D457210F2;
	Wed,  7 Feb 2024 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c1hU9qLC"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFA8224D7;
	Wed,  7 Feb 2024 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297760; cv=fail; b=QS3GGMgeOAfcJAf17fvkpxqAqR6ewwoq3fgT/ac7PH1a7PmUF+BH+CHWOxLt69ID73TWqwGeAcyK9Ut1CuDAq3cnkmfrAG7l0ILTaC6/f/DNzdFMCADUVIDRMUSLIMk6rzC5aseVVCCJrmOQhubEGnwLb7ygRYw+DDLZPGRrOkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297760; c=relaxed/simple;
	bh=hhK6Hx+zcLKcLXVsGcitYDqkviJ04RJL6whvUbI5sO0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A+FfC63rno79bTNZtvftllFvk3wU7/ZpD+RkigP4ILQ8QeY0+mThZ4vcGsfdBQvZjD8M7VwAUGx7gB/IFfWGRiySa/7Qz+A2bgIYJC8UK5VjnrknP5xigA6bLfSaBv9YoMMeDwPI/SvrNCmxzbWc8t3Tsa+00UWkzcYghyzT1Ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c1hU9qLC; arc=fail smtp.client-ip=40.107.101.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNeGr8nRy4YjIIlXpBig3mfdrUw0JgfRpwvpHtrUneah4/SwHwFBTjorhI/fQFsOO+34i8fUGXosm/IKOiOx5Q1o34mEYLalb6gXkhJ7OTNGMMUvloADshN3eUTXbO2ZYheitRwnCarmrmsJCo2DnFlxsw10Yh3QqGZk+4j+VDvmtoSP0B06A48hEUREcqgn7/2ceGqwF4zqVzvZ0G+jzS2aNi4KXyvfHwbJXfmadlM9VyrllSPPAmFD8GLnxaLSn7BsWXDN7qhdRz54A5Kd1ysvloLOS8uW7vczdZG+5LzT2MSLbOQRgJOf9tXob5ia5JuqYRwI9oUox+/JwPg+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaZH5mEUmoFLORrJ3Z6O0ciOZkMmCIWROxuD/A+vHqg=;
 b=gIuzUmfTedAmT4wy+SMQdRNhMYUNA3r7Jlc1RWCVdVA6UoQP6y7F0KsA4GeYrDwWsXJPmKXKZzPpvr6TBumsBqoTTeyszWSBxu8/zkFTUV3ti7J/nY7Ifa59uySKlAQuCbukYrPwSddNHLwTp8DQpGVtbLP3FTU75gpiPFFwYhZxurnapuWQNVIj+CZlxS9aC3237n88SZCCmpcq5DbaZjSNT5Ch5ZT83u05eRQT3ekdaPtoT2CgPiYh/MtSltK9hxjWZahM/TxrR6zMVz31v/vbOb4Dihj2/OEreZ4j/k/gHYnFTiQo7O9w3eZQNfOVFtuzW+aUgxzJiQncCX1CKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaZH5mEUmoFLORrJ3Z6O0ciOZkMmCIWROxuD/A+vHqg=;
 b=c1hU9qLCothZaTEhBTTpCrS2XbqX2i6DznViaHai75LhOKSa217O0cT9hFmnpdjIYzPMnIpif8+Q1fWNWaroEMYDT5eLS4NF3HpIaIwbNdY30bLetaW5YYb/9hnjxusAkmA9M4aeXH77SglBsbJWWj623QM/nA55RhIa2wqaAHo=
Received: from BN9PR03CA0586.namprd03.prod.outlook.com (2603:10b6:408:10d::21)
 by SA3PR12MB7877.namprd12.prod.outlook.com (2603:10b6:806:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 09:22:35 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:10d:cafe::25) by BN9PR03CA0586.outlook.office365.com
 (2603:10b6:408:10d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 09:22:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 09:22:35 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 7 Feb 2024 03:22:29 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/7] AMD Pstate Driver Core Performance Boost
Date: Wed, 7 Feb 2024 17:21:51 +0800
Message-ID: <cover.1707297581.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|SA3PR12MB7877:EE_
X-MS-Office365-Filtering-Correlation-Id: b20d7d82-c370-475a-01c2-08dc27be522e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LQeV4hJco0VYtVwoKBcttfLJV2UNa2hxF9E6BHAEvYpAB51rM2x73Hw/zYo/KKZSYdt55cxBxG0p5LOwkr8RtXVSmCAtGkhv5HoFJabSKhHni1MIe2m6oPYBLpOkACWLn14iziv5bhvJLVaQNUhhMDVdc+JvZUECyAaTKpoOAtFs93JdHJB5cdAiPcKrdZHlMh6liExWYkv19j5ffKjSNXzzdwDAOo01CHSBo8+VaJdqq2BQKKLg6ZI9z/6sz2Sx1D2aUv9h6q9j8ZyGnIqE0KeT0pRWJRSQoTWGp2eONc5I0qnnkj9Zwa1rKV2E6P3VjlhULzd6ddmX8n9gZlZopwjooI5Ach9QAIv4tMeuk3n9wBpp2/xMPjEV5b8rYAuy759dlS2IUPUYpdFpjInYKDuTyN3hLGQ4GnhcryvKbmGK0Vy9qbedTXrxEeoiM0cUdHcw4SoePUShJ5DIiW1utTfYarnxTrL57efokNXU3Z6rKWbaeB2gyJSbLa8R8FHclprWgEgWYZLcm+hkEWlo+sVFLr0/N8awjpHwkusSFqJ7Q49WOeyBHP+jfsirFKGj8MZrgn7UMpxvgdORObTCYvS0ngdhDhC8kqRFMToUhjCTy5JTBkRZmAOS7HTjYoJ708q3Mv9uSygggRJbJEnu+GmHVb1VjrlkvekBEH67J3ngBqzLrvJVZI4yITYWO4sPUoQepUruR8TOPp5D1DabsNVZ2syd+OwlUnsKqZfq2C6UULjpbJjLkVBWIEs8lhU9Qom/BhoF8+a8nMU9PM4rsJ4Zb2WdE/LVXuu+a3JjdaM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(1800799012)(82310400011)(64100799003)(186009)(451199024)(40470700004)(36840700001)(46966006)(36756003)(40460700003)(40480700001)(966005)(478600001)(426003)(82740400003)(336012)(41300700001)(81166007)(2616005)(47076005)(83380400001)(16526019)(356005)(26005)(44832011)(2906002)(110136005)(70206006)(54906003)(86362001)(8676002)(7696005)(6636002)(5660300002)(70586007)(36860700001)(316002)(6666004)(8936002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 09:22:35.5471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b20d7d82-c370-475a-01c2-08dc27be522e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7877

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

Perry.

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
 drivers/cpufreq/amd-pstate.c                | 156 +++++++++++++++-----
 include/linux/amd-pstate.h                  |  15 +-
 4 files changed, 148 insertions(+), 36 deletions(-)

-- 
2.34.1


