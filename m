Return-Path: <linux-kernel+bounces-57442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD7B84D91C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86951F22B6B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75CF2C6A7;
	Thu,  8 Feb 2024 03:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U/WKWA6w"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAAA26AEA;
	Thu,  8 Feb 2024 03:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707364254; cv=fail; b=GWAH5T7y2HUonDn8tz6JdWxWH5ZyV22W1PcLimhb8V9to37ArfmeVfPk9Xf8Ve5XCtuYTJYXlpw3TvIi+x+bkvurIi/kbR2fD7xh7GI8N4jdabxbAoJ+/Px4lOQx+9AfLAndw3R8Db1l128ukA/MomvpAsKRdTmtqQbQ2vuuUWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707364254; c=relaxed/simple;
	bh=mF1R+Xse0YZ12BmmCLWxCQZ9w+7fdN0fOdELvVrzDhs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bz60w0AZ6/3t8cHndNmZjwih5CmRdg7baC1BJ5pPjHSrIbPeFYCUgd72mqGO/cpGLezQqBJZiCxpX2HVJlkxbG36nHgBhIW/O2XiurELv7s5RoKx/spr3e9r7DKoaDcpacrZ4F/sadPPEowkQ6SpW71Vl6+ZrrADaSyXtMGbceg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U/WKWA6w; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8oPGZcsEGODn5DI85GsNfpsRtl5Fs03xGknGjmkrvEJm0FQLbLfoO6oM4nj9xLWdRNv5Hlw9+d6+xNzf9PE9/FMrF8/bH9pB9DkTrL2zPK2x5jZybL/LY9wsSk6WnoJERxEQCJipYiY2I1D19e3esZri3vwcXO0WNkfUrKiWwPa40h+HH7jME/a/r5OPvoERdGHhAArERJrHqHnp5igOND1pP3VVB3Ke5CuHELEOilgOAk1zOoyRh3RucTUtVDt61d4uBq38IWBn5ajw6bIkPyW5LY0IBeLCcQJmL2UDps2XZrT5ixf6042UuBUddPiasNOn0ehgIqCfv0wEyKM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhU4oM1vfsXHB8Pbj9j+MboBU+5Ozp0MS+arm8gOzSQ=;
 b=DYjMH04drX5zy9tF0sGG+t1TGbx1Wjgb+Zn5cRfhVg0Nc2XTp8cc8FLaK7yVCfrd4lxY0zF4zuEu9r/o83feBPnBmxfb+LMhZxtMYbdruoziHlWuIXKIU6rCAViPbdPlFyvO72s2YNdQoxOl9emcLHVCrY+4/1Co0hPzi+SdNcbyW1ZwK15T64Dusl/YqXVWbx+deOC/S5YJE6KPyeMuu4Ku6nV7nO47Jbo+h0/Dyqqa1tl/vujpDBHDZYCpoCxbhq47xYWMRmChHmz/nNpRKrvtgLlBgLAoiz10EnLRYvceEQLuiPwuJ7zINS2mZopUDW9Qxl6qxkTEvbDBYlHtXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhU4oM1vfsXHB8Pbj9j+MboBU+5Ozp0MS+arm8gOzSQ=;
 b=U/WKWA6wUYxLIRzW0I5nXG1lFlpcwt99aSvzLbaqJlHbc7O0mS7YwUiimoisyMmRvXZiO20wQLpt+PXNwRHY1fJEK697r69Fn/EUWj4bS6+Bf8db5vxF4BQrRWpqkdaQzD17P7efQUzcGu+utaVeea2Oi7wQByPfGTJPgdyKtUk=
Received: from BL1PR13CA0131.namprd13.prod.outlook.com (2603:10b6:208:2bb::16)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Thu, 8 Feb
 2024 03:50:50 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::8d) by BL1PR13CA0131.outlook.office365.com
 (2603:10b6:208:2bb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17 via Frontend
 Transport; Thu, 8 Feb 2024 03:50:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 03:50:49 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 7 Feb 2024 21:50:46 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 0/6] AMD Pstate Fixes And Enhancements
Date: Thu, 8 Feb 2024 11:46:27 +0800
Message-ID: <cover.1707363758.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 114d361b-4da0-4889-525b-08dc285923e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NB578bs2Ax94Pdv8bgkRhe3Qy2tmUZcKia/8DrBYEE5GPOcIoW8eTMDcbmdVHgLcSAhMUuMdb4/jtwxaYWYzhNSVQw4wEE17IVCz2DZ2Wxqnvh/LndecGp5/ax3ReFW0V4QQmc0E3Y9hvdl9E3SAZRaqeIj9R+jO84dL9H/8wnNf1YdQXcvo63Rx4RZnj1RCmLjo9SVG4ulyQE0L+StQw5BbKvFV8WkfEjsn4vf48hIDAmTMx7lpj28JrncAZ1V2nNJU8Hh2qb3ocbmtnG/IpbPKIpqSvbrF+LZ73ir7X1wtEjl3OZMfclaPpHfhcY50tsltwM8PbnYIuZKDmMHCaibCfjKTKaLrA5ygaSKpvzR+kOxiG/+Trf9C9R3bqOYjF5Kc1ialXxBSQ/uHYAMLVGaPJ3P1+AALJst2XIyrpE9rPNfd3wmhV498bTcBGbSwONX8vdXtqIAmCCRDM3DYbUoJINmDjIj9mBDPRy8pd7qIhMD08KEDftHT/zR7h2SGWLxPISGF6qQYwy2Z4749+WtSjHGYwk9qiQ7RQVLvqB32qoY+Af+qsfn8OEjqc0YxrfrmzaOi4UC9NrkulgoOBdt7k4evgo0OaAMsNI6U5iZKsKHm3XIv+18PI1ifjj0Z
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(46966006)(36840700001)(40470700004)(2906002)(6666004)(83380400001)(86362001)(7696005)(2616005)(426003)(16526019)(26005)(41300700001)(336012)(36756003)(966005)(478600001)(82740400003)(356005)(81166007)(54906003)(316002)(70586007)(70206006)(110136005)(5660300002)(44832011)(4326008)(6636002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 03:50:49.8665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 114d361b-4da0-4889-525b-08dc285923e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377

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

I would greatly appreciate any feedbacks.

Thank you!

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

Perry Yuan (6):
  ACPI: CPPC: enable AMD CPPC V2 support for family 17h processors
  cpufreq:amd-pstate: fix the nominal freq value set
  cpufreq:amd-pstate: initialize nominal_freq of each cpudata
  cpufreq:amd-pstate: get pstate transition delay and latency value from
    ACPI tables
  cppc_acpi: print error message if CPPC is unsupported
  cpufreq:amd-pstate: add quirk for the pstate CPPC capabilities missing

 arch/x86/kernel/acpi/cppc.c  |   2 +-
 drivers/acpi/cppc_acpi.c     |   4 +-
 drivers/cpufreq/amd-pstate.c | 116 ++++++++++++++++++++++++++++++-----
 include/linux/amd-pstate.h   |   6 ++
 4 files changed, 109 insertions(+), 19 deletions(-)

-- 
2.34.1


