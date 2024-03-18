Return-Path: <linux-kernel+bounces-105904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A52B87E63C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2BB22815F8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894972D604;
	Mon, 18 Mar 2024 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jtn4prjU"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943332D606;
	Mon, 18 Mar 2024 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755336; cv=fail; b=qwAOfiE8rU+rip+kzEWEzrsplRs6zHVxRrUtO6nPl1tiqupRZ5KAJXhVRshil5DYbrjNKlmrbfNDtqFFWTdrVPcIGhs4zMnCwnf0DzgoT2g++IfysCple0W/Jlm3UdC/1umKcahf7466pXpluAKJIIZ9SmOc0sQH2HASes+6ht8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755336; c=relaxed/simple;
	bh=att+IU8RI7Fr/JC3s22VLfypRIS5pevP8mokZXVzv4U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qRe3ZKk9ZghjOemVzT+YfZaYQUPYAcAQGFLG3P5dro2dUVo5UMylx+LFFkj98vB7gOEWdjM5XwUm+R+6JtQLTF5WpPeYZ/u5wIFiErL1dPO6Zh0+sT26OKqTzOAzzWS6NhnscW7rUbkd8dFKuRrabKDsCYyvw8rlRo+2ZVQlk7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jtn4prjU; arc=fail smtp.client-ip=40.107.96.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESj/SfXvEfZfCr1cMHIm6rwkrBS/wUBpIpx0lyAX981QK2afnw4nnTebb5Xz71ZTNvoh9GIiB69mKcJx7rEdj6HFnmUoACccFqeKPGmDeZUB7jO4MeCg1jmxwXB7yrkIfb1GKRnVkGvwu8c9i14o+ec/mbQd4PhPIshsW9yqc4me/ScogC19I3dViPgd/crQ1HTsb2Ff+lKRgDlQL9zASj/+XDIbX1JI056FmQrjau14/ymFM4pzAY9bgVEmm+MUEZYJKu8dir/g8KhrlGWd3zWgBGqAqnaLe+yFU4+7ca3HA0kDKSSm3t2B24G+66Pl47uQufxYcVfNFGO9D6fDPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6WNc4KaignI/dNKMW60u/MFSFkued8onn47by0jU+k=;
 b=POzzgqsHxY+cGqoOUmjKawyImiYttBdOoFbUj9Pj8g157nXhtH76Q8rWXvUJQ5QZvgtCSQSP0AUKPo2/2iCCDNkutyPhguVkaHke6TqhDjMY4gk7WyQQoQE/zh2yT8uNQJ7263I5PGb96+pPshBaiMmIXFnvxnWqAN0Gh7p+1PmhDlAyEF6qYKFYVlHNEw0L2v7Bfk67f4y02MXagOg/HN9pvH27G/KLIs8AZJz8HIeLWMy27HuFRyMBno3SisoWUXEzZtpb/uQBpc7mdSlWpDH0j6c3/XqoExGaeTg+w+0HC2p/YPhHPdOLGscbFeEWenShUoZXZZWGgpAjLaaKgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6WNc4KaignI/dNKMW60u/MFSFkued8onn47by0jU+k=;
 b=Jtn4prjUYQcyvw9UMiSEWsYW4hKdANM7M8BfO27yOQE2zgbVUjvXqpm+Gfx90Qq0jIzRgic4YXifyp+TrsRAjEFckfx5pIZSfHkJD9ZYUfNWkGVt5GJlRTaFKsXsm9cYmCaz+ap0YquFTkfo/wX92PXL6IgTjMSddUFTHwq3+vs=
Received: from SA9PR13CA0131.namprd13.prod.outlook.com (2603:10b6:806:27::16)
 by MN6PR12MB8541.namprd12.prod.outlook.com (2603:10b6:208:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 09:48:51 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:27:cafe::27) by SA9PR13CA0131.outlook.office365.com
 (2603:10b6:806:27::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Mon, 18 Mar 2024 09:48:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 09:48:51 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 04:48:48 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 0/8] AMD Pstate Fixes And Enhancements
Date: Mon, 18 Mar 2024 17:48:19 +0800
Message-ID: <cover.1710754409.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|MN6PR12MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: 4326e5e6-23e7-4020-a27f-08dc47309df5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x0m4j+VSyW0hL7iwWvrVeVVH5Y17uX/x2bwwW1K1x5ovR7h1xhvp7wcLz9RV35fGF6gCCVZ8ShrhDYsyap6EMP0XaTroZvSl0TNX+MM2CXzCYizM0Vccm8mPLtamJNLINF1NV6d7bZ/TyVWiWg/jhVgQqBvr6ijfqUGjpDbOtP686uBr2mRbVyL2noMgQScNOIZkRVhOFrSedunhd7/CBqfZ/bRHArbRv40q3Way9+VRrXnXJJIvRlEaWfap8Y7GOadqtnR2+xXH95NmicautKWYsNkLd1ZDcZDkOJU0MVGJf8AYmZhEyZ99SDq6KHO5ELtU1hgAmV8QxtUfsoYy6SJ9qbYyqVM8MYwwRdOoEsoYlX+pZOKkHhsxdE482EsbLNmOErnnQ0+vjZ2N5LCcGOPbB2yjPNAcPXVtfU7QDURq8LZpzkOdVmQ3C1eiaJK+Ma0uqxUouLsJ9WaWKlqBafwLD8sz0aIc4xEKWD7gJUs1j6UR95g4hcObepbnIVQTHG8m3vAH7EZsfIJpquWhUabfz42fqL0x3QZC8szEPm3r17npGBloYj0/74vELuu9MpOJttXmks6PQGz+qeFnKiIAd7pF1zEMkND6skjYIcpqr2Lv8dwntDajb6+LVlELjWRchzgoi7au4ffGXw8qcakqeKLgoM2+yKeog2rX9hHM/AdpXSJmsdcXRnZTNH7M/OqqXTG9qZ5uyc2E9ygCJA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 09:48:51.3109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4326e5e6-23e7-4020-a27f-08dc47309df5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8541

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

*** BLURB HERE ***

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


