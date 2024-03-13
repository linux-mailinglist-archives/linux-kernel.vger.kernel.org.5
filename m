Return-Path: <linux-kernel+bounces-101308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9287587A564
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48EC0282300
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4442F38DE6;
	Wed, 13 Mar 2024 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="307jvVEz"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92CB134C8;
	Wed, 13 Mar 2024 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710324051; cv=fail; b=dsDmDCwLowhrmEaizljWUo2xNZQnJfhkD0+RXCqxKWEl+UIfBJa45Kv+d9mREay5ve3BAibnL8jJ1PF1sxQWmCKQRYWwM+TVmJ9huxM2CIhNtQz/cFTeszU/GB6jFkoUbDD5HMr3IaoXatq6O41faE21d9eRKMdP8KWtIxu0q10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710324051; c=relaxed/simple;
	bh=axxfziLu8m6E5dJ+/4G0zFzVXab2cLwcq0fLrGB24l8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q75snuR7YhV7kMrRm9wA22US0m9vDOwm0COMz2AxJ+dYB5vwfM+yJcy4CLnIrFyMI1k4vSc/Uvx8v8dX9LkzuXX71pc2aZPP8BPFoorFbFIommFHJDQkBZIjsiQ7xXFN0h1UilkEMjE+CZS/m4ryjarK6PW+A8m8EzF+d0YKgJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=307jvVEz; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfTJAaQt7jNy2RnqvQY+0wkJui7R6USlfi1SnpQuXOYLbCqzsaG574CwtPQYxJLB1/QUYhuZQwCnRI+xKZQTto9n9jFwlvuULLJS2pZu4D3pl5Oy0RK+U2cReYihNSHmsSUtiErqtWMJt/IkE9brhtYIViA319PY8+WgB4yo5oO6vGtBnsfznR+Yf6Ca2HNRc+MN8CPHThzu0dmZmbQ4oYFd3y43Ely1tsgg8rM+2cEiIKHTrwujtpSPrQiee5Lg81kR95I6hIedQxwjj8CVWJQeBkC2w2XrH85mL3C+S1rwWevbIJWL/IlVbjL/NK2cCm3XrULEMXbbxzVyiuMuZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbG7i+9ftXBtX7xk7vsMY1sseNdCHeO/p6zcFONreEg=;
 b=NuplI1FWKu/inBWZDAm+GjI8OSyAX60RyR6hC4GZglgIeJYBs/GNMl9hplfQInKQBFPuc6BoYiziMYaBjl+DVo0qQi62UQ0RIlM8VWFxl3rJyesvt9zR6xQLOzJpt7koh/3ALLVJ8CYIQwZ2j7xNDwIfjW+4lO9v5aYaFk3fOqEZFRSo0LgTo7FYXTx0vzSvtp3MBmGmNWoCK68esT3TjePO9qakWMLq5cKJvJ8H4eghmzGAxD47ISWDxzHsVQRJhCS9JIu+Atv78zPR+/I/YvFPBk3yMBlooaxIt7t9Wa5gr62WqIKuxrvsoxBFoPsocAGf0iJtTlv0yNPooleYlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbG7i+9ftXBtX7xk7vsMY1sseNdCHeO/p6zcFONreEg=;
 b=307jvVEz5GXok7Gt/7C78E/fsu5JMVCz5rtHVlQE6fonTMOscb56maqskjFx0PdTet5rWtZcaQk2hyd1jf8U3Urek3d9EE2LRZuGgnXC4Ya1wCSJ4ChpJor/Wy2Lq6LE/nkFLxvTTvwO4gB3DSIhPRoLDycMpJIQIbJwvNpAHyQ=
Received: from SJ0PR05CA0077.namprd05.prod.outlook.com (2603:10b6:a03:332::22)
 by PH8PR12MB7232.namprd12.prod.outlook.com (2603:10b6:510:224::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 10:00:44 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::d4) by SJ0PR05CA0077.outlook.office365.com
 (2603:10b6:a03:332::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Wed, 13 Mar 2024 10:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 10:00:42 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 05:00:35 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 0/6] AMD Pstate Fixes And Enhancements
Date: Wed, 13 Mar 2024 17:59:12 +0800
Message-ID: <cover.1710323410.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|PH8PR12MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 38e8dafa-cd7f-43ce-6521-08dc434471eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oZ84EZp6CA/pCvJCmvzi6yob9XxeUA5Dfc5+npM715yfxOWzJIn1t9o2zKpNyxNgGtkmBj7pzxojFj3FL/aKTqGAvCfkuOZ0BRykVpblXbyS1EZliVc0w61kzUqUeK0Gk3lFkbK3M6yRv96mmkRoBTHYt4szQVnGT6VRT44TQ0Ki/HDK8KKIPXgKKoGaR0pp39E4lkFyO+yl1bpfUmqOQxjqpn3FEKA5/wrXIUWTgwUcMBgQ64L9mtNRrTkPDpFjOpJ8b9d9v/PRNNCQ2j5u9JEMqRzF9glLxAVcNnLiuEq+tx1sf0itagb4G+VpIZXjkQ2aQM8q6mMqRZgy+WqBEAq4RDS+iu4vfqqyldjXEnaBTG2LTgQ8UApOVoZYk9qwc2SE0pxFNR9CC2kiV/nSTFnuh2+HZPuv1sIU75n/Ej77gg+T0GhaOwpGW29s6lY6rtKobonzhBS7t0bIEmcuxDawp23rntmpqUgJY0FKej4bAa3NXt48sxFI6Y+rvGYZXPOzB94VJzTq5YzS/DeYBpjxMd4qP+3a73HycBqT9O+4kPkrFIs4U3j/2AGxec+3o1xCTcerbArHQpM8ZVtYgW/Ik/1JHjlWwn5Gu0aGdNMizLXQat8WCa5z+90brFyT1Tr7exTMkHF7gkqyMD+9yXGA28ZWYSQNOvHDW6mQ/JlMLCmtDAjMzxUfX0wbtZK6K+SZCbpwxYM4kTIZlkobAg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:00:42.5982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e8dafa-cd7f-43ce-6521-08dc434471eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7232

The patch series adds some fixes and enhancements to the AMD pstate
driver.
It enables CPPC v2 for certain processors in the family 17H, as
requested
by TR40 processor users who expect improved performance and lower system
temperature.

Additionally, it fixes the initialization of nominal_freq for each
cpudata
and changes latency and delay values to be read from platform firmware
firstly
for more accurate timing.

A new quirk is also added for legacy processors that lack CPPC
capabilities which caused the pstate driver to fail loading.

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

If someone would like to test this patchset, it would need to apply
another patchset on top of this in case of some unexpected issue found.

https://lore.kernel.org/lkml/cover.1707297581.git.perry.yuan@amd.com/
It implements the amd pstate cpb boost feature
the below patch link is old version, please apply the latest version
while you start the testing work. 

I would greatly appreciate any feedbacks.


Thank you!

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

Perry Yuan (6):
  cpufreq:amd-pstate: fix the nominal freq value set
  cpufreq:amd-pstate: initialize nominal_freq of each cpudata
  cpufreq:amd-pstate: get pstate transition delay and latency value from
    ACPI tables
  cppc_acpi: print error message if CPPC is unsupported
  cpufreq:amd-pstate: add quirk for the pstate CPPC capabilities missing
  cpufreq:amd-pstate: initialize capabilities in amd_pstate_init_perf

 drivers/acpi/cppc_acpi.c     |   4 +-
 drivers/cpufreq/amd-pstate.c | 151 ++++++++++++++++++++++++++---------
 include/linux/amd-pstate.h   |   7 ++
 3 files changed, 122 insertions(+), 40 deletions(-)

-- 
2.34.1


