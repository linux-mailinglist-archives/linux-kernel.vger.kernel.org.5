Return-Path: <linux-kernel+bounces-39740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0803583D597
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC7E1C2671C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F47664B0;
	Fri, 26 Jan 2024 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QD4JrRyN"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5443D134B0;
	Fri, 26 Jan 2024 08:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706256529; cv=fail; b=gsIn/Oowo6jK5dBE9bRFWaohfvIY/vxk5R5UEkOS2r0xRoXY/hWSP4eSTK4amNh4nn5G7nFLI7iGHlVj0tNzqtBoKOn7GJK7Y01YW2Kl32VK3hbNSTRyJpA8EtgVxRwcKZxqH0LX708IqIgM8qBY7gEtNB5j+jsYd/Ou1bQ7f8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706256529; c=relaxed/simple;
	bh=8UAV1Rvk2da0nerHrm0uNXazGBsJPqjm5xMJG2ONr0k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C40qd56KVosK+Ay9w+6sOpBKyn6pEtaaphc87HcTU6ZxqBUf59baE6WZaPMhgrA4Pi4h7TzyTpsnE+CzWuGmS+SpRQTxCCqqQZFiDLOD2cwuqnuUQgyOj7scVwKBKK5doHnJXzYp1EOQJjMchx5qiHY2NVI0fAEMNMch3bF9UiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QD4JrRyN; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CI5POUREse0UGV2W4Qdy0r0k7kekQFVokUDeKL9TsRHm2o4rlHaKdwRRolKD6EGUfHyTPxhto3eGYnwbHZi4mP6N+Z1lXEMT5W4tkLmm6SaICDuk5Sr2dDP49dAelkmeoNfEX3usQfXIgy8XluAyQ8dH9o6mt9LvnAXHPY3eRytqXH0DCrnCowvX8h/6tNxSslBOMTSe5JcylTUbhaKkNzI+RPK7qBpuTqfnCPb040S+MHX1jMguhLaNYgRxPTJKne/vhzN14a9rySxbF30Z7jpCkar83EFhzy2VAs/8Kn2bm/TKm08NazgK5xtAxKhc6fu9V5H/iZa5yFqP+ZdRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7llw/HJjJQDB4xB7rlbz1hX21PpKFfiujvi4DuMQ8to=;
 b=gAxCneSzmtQHWjzl/KSyhhzLfAJDfZDWv34B7dlb4j7xy/lzKl3OfnbdzvAYfOdGG0L5D14YHj3PXZpJRaqUooQRTy2ImmabO927k+m0JYpzvjwEaJ6XglQ1520Llt5qwH3HsnIaS1EWWTYZT7AFPVslq+rKcXh8h06vgrJzHf5jrEA6Dk7LXwFMNvkp9iMFqTBd2rR5U7fTKKujwiMK2RUxP8INvQPeSPpfUIjp2+QT+dUz6PNvvLTWq2/g1exQZf8/Si82Fn+uZdLeM/yjCvo6BLC635dTvmdnP7HRUMmhtvkcCp9KtzTmTYRz97r2OTpUE8Vqtt9guejEhpgyZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7llw/HJjJQDB4xB7rlbz1hX21PpKFfiujvi4DuMQ8to=;
 b=QD4JrRyNr4K6YEECf3XQYiFPTELUuY2pF1v3wW29hCEDnfHV7Zp1hayMnYs5b2fNCorO0au+BFFhQ6vc7toW06j/34LKCTJw4DwjG5YoZprphXU3eEq+MUvNdD9mL37KSjCy7me/POB1Mb/212dK2dSyH0HXY02NfNOD/IE4mIw=
Received: from BYAPR01CA0002.prod.exchangelabs.com (2603:10b6:a02:80::15) by
 CH3PR12MB8971.namprd12.prod.outlook.com (2603:10b6:610:177::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 08:08:43 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::f3) by BYAPR01CA0002.outlook.office365.com
 (2603:10b6:a02:80::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26 via Frontend
 Transport; Fri, 26 Jan 2024 08:08:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 08:08:43 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 26 Jan 2024 02:08:26 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 0/7] AMD Pstate Driver Core Performance Boost
Date: Fri, 26 Jan 2024 16:08:03 +0800
Message-ID: <cover.1706255676.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|CH3PR12MB8971:EE_
X-MS-Office365-Filtering-Correlation-Id: c1457d53-5f7b-4a3a-11df-08dc1e460378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H2HulVxBdh9uqnF7lJycMm0lK5UtGzhDwcVPln0Em7gP3Sq3gKg/KmKTy3BKo3Io717v7Y8v9i8FZf4wHsQ6+MXPPI3mAhunJ0u739DDn4eKhzPD+B+UTesno4/D25djrySSxP/pot3akjSv/LFoDR6lqgSKnsYO4DufCjZuevB4Br3dWV0ifiZk8Kiart5RSAGT9SxiRwmaXZIZ5njMcs75CS06p62n+Z0PzGzM9kM1geAbie9jtwWFeMqjiG5xGdh8fjmdOMhXUqj3A1GfJx5QvtZ7YG6D1t5g6lchm1yVQgdowfSkvzl1KOaVyIDmxf0bBXg0HKwmaOLz/aWqZxhxEGvUDWlBQMCR8HqOlkuRgUxms4m8lgkFyd1WZz8WIedMyUkRhT7U4iWXcUKrmjTO9SZqBTeHecUj9NpN2j4OiVxrO7dbtF++2GkwDWukppBzCHz+MpUDJH3QMP9j62WODxdheMusMBvD1YRanZLqR2pDNgK+bI/okapVvY9/dQHvyNslo8AebK9V+Y+BeitYMFIDeSqB9YyO9Piz2PT91gzM8Ibo/TGeJRdbtHNaxmoNcEgEUnqegubNbXCSWZfYUMqp3Krv7Nv7rtOuFQQyjcTGENT4OOkJvSOPRbOKYBgg415Bb4doSZ7K1G66R6CMOXmBkWCJljzVhJBwjkGItawD9AliBfsixvPYoMFF1B3p93mc70rpz3tj/jdHyW5IQP2UBoSGtqIgkkVsq47Fgg8GplhjSXyxnc27FB/YQ1uDjhMVYSv9wKTzJ1mYkA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(83380400001)(47076005)(26005)(2616005)(426003)(16526019)(336012)(82740400003)(36860700001)(7696005)(4326008)(8676002)(8936002)(81166007)(54906003)(478600001)(2906002)(44832011)(5660300002)(6636002)(70586007)(6666004)(316002)(70206006)(110136005)(41300700001)(356005)(86362001)(36756003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 08:08:43.2793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1457d53-5f7b-4a3a-11df-08dc1e460378
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8971

The patchset series add core performance boost feature for AMD pstate
driver including passisve and active mode support.

User can change core frequency boost control with a new sysfs entry:

"/sys/devices/system/cpu/amd_pstate/cpb_boost"

The legancy boost interface has been removed due to the function
conflict with new cpb_boost which can support actrive and passive mode.

1. enable core boost:
$ sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
$ lscpu -ae
CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ      MHZ
  0    0      0    0 0:0:0:0          yes 4201.0000 400.0000 2983.578
  1    0      0    1 1:1:1:0          yes 4201.0000 400.0000 2983.578
  2    0      0    2 2:2:2:0          yes 4201.0000 400.0000 2583.855
  3    0      0    3 3:3:3:0          yes 4201.0000 400.0000 2983.578
  4    0      0    4 4:4:4:0          yes 4201.0000 400.0000 2983.578

2. disabble core boost:
$ sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
$ lscpu -ae
   0    0      0    0 0:0:0:0          yes 5759.0000 400.0000 2983.578
  1    0      0    1 1:1:1:0          yes 5759.0000 400.0000 2983.578
  2    0      0    2 2:2:2:0          yes 5759.0000 400.0000 2983.578
  3    0      0    3 3:3:3:0          yes 5759.0000 400.0000 2983.578
  4    0      0    4 4:4:4:0          yes 5759.0000 400.0000 2983.578


The patches have been tested with the AMD 7950X processor and many users
would like to get core boost control enabled for power saving.


Perry Yuan (7):
  cpufreq: amd-pstate: remove set_boost callback for passive mode
  cpufreq: amd-pstate: initialize new core precision boost state
  cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
  cpufreq: amd-pstate: fix max_perf calculation for amd_get_max_freq()
  cpufreq: amd-pstate: fix the MSR highest perf will be reset issue
    while cpb boost off
  cpufreq:amd-pstate: add suspend and resume callback for passive mode
  Documentation: cpufreq: amd-pstate: introduce the new cpu boost
    control method

 Documentation/admin-guide/pm/amd-pstate.rst |  11 +
 drivers/cpufreq/amd-pstate.c                | 222 ++++++++++++++++----
 include/linux/amd-pstate.h                  |   1 -
 3 files changed, 194 insertions(+), 40 deletions(-)

-- 
2.34.1


