Return-Path: <linux-kernel+bounces-54310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D63A84AD8F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B29284DCD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3362177F2E;
	Tue,  6 Feb 2024 04:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BlQ+zg1k"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6411254661;
	Tue,  6 Feb 2024 04:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707194091; cv=fail; b=GQPkpTEW314E0gJ/rhjOt8XRxAigqUoe5Ypz28KlLyNnsAfhWr1k+7E1vzaioKsFRCtmLNkajbsfFRqoCXqxi46sDQZGdndn83iGnWxTiQq5ariua5XvwVep9g9O4Pl/fR2N9T5UfVRFs8D71Vr8VKQtMvlJzjYzIwgm/RDe1j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707194091; c=relaxed/simple;
	bh=HubZNQzU9aQqod6pV+sudabbJXGtn2Iw4YW5ClCJe4Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XC19ZFTzsdtbWdo7my6UeRhMcQ3h86Gy63fK+NZRbk6gS/Nv8XYbI3KlG5pUkbMB4mohK0PYsvMOE+L5zUijztVHPC1pPHNozvNGk8cU3ICi84xKmLrBb7zivMnlZ3piWEfQqoasbUFART3k/oxro4rK6opkGSIz2kNaLJZCFqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BlQ+zg1k; arc=fail smtp.client-ip=40.107.102.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmpfdxEOxGtQFuuWXqZfhVtWcs2VYluCNOj3zpKJdii4hiPPidELVY3fBfGBxLgsm9gcr91tztmi0Zxjo2v1W7UN/I40rc8hh2wtFxSV3PsilsyRfOJo8qicNwUs9z8Ynk1Vz93Fht2WUZRhmcL9opZI7HGLUIkTGX3EWIzAfJCMq5XgSRrDCumqf60dPrIarw10nT+xAVp4k2FpQ15DvQp22Neb7RdWhccYyEe1x8Khw/dm5h8N58dZRJxvAjEanAWA9Y4ZUTiPEbBJGsU6B1JPl/nvT6H4e9paivUwFGczvWGdvCxt5s4TiUgPF3zqkYOo5o/7mStSIQdU88p7fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thPCeUFDDd7hvzNDyz9efuusyMuLpNr4M+MsDfA1DMs=;
 b=PM7SmID5yQSTFwFx2AGmUTy2qy0Bj2YmKPM1ycGXkn3Moj3t/r93Zee0bRboeCeCNC0nIrFeuBtvh4mREAjXGldTCuTivnSG6LjsZHJZOaOa6hSKa0sHR+mgEW4ULUAwih57NkA5lNyc71YNIDrv++ISXihVu7GTGq7bututG+CVwoe+Xr6YJiIc/gLE8umKRCXt0ZCHZbsazWNNg7AkFPXj9pULfUC5qLQ6ORweXnv0EExxtGoSt6dn9MtmeNWjL8CMDQ3hBRSy9YQJ7/TcqFaeD+m3bXMXgza2oEkDeg7KMN0nMVQOQkTrIzUC/D9imf78N1M1IYfvS/UGa/CItg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thPCeUFDDd7hvzNDyz9efuusyMuLpNr4M+MsDfA1DMs=;
 b=BlQ+zg1kFvlZ2nY94zCstBBtg+VMq9v7Fh7xJiridxDw3TE2FoYNklXV6w9WKZJTRS4w1SUJdZtVam3PhoSHoJbyq3XiwmPEU/8gIBosPH3osRx4Nx8dIGxZX+uzunopf660GayoRfxR53MXjGNRVi8yJGtJrIXOaI7kwNVORLE=
Received: from BN9PR03CA0304.namprd03.prod.outlook.com (2603:10b6:408:112::9)
 by CH3PR12MB9146.namprd12.prod.outlook.com (2603:10b6:610:19c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 6 Feb
 2024 04:34:46 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:112:cafe::20) by BN9PR03CA0304.outlook.office365.com
 (2603:10b6:408:112::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 04:34:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 04:34:46 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 5 Feb 2024 22:34:24 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/6]  AMD Pstate Fixes And Enhancements
Date: Tue, 6 Feb 2024 12:33:53 +0800
Message-ID: <cover.1707193566.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|CH3PR12MB9146:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a84168f-e7bf-41b6-bb82-08dc26ccf294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QI3+B7jMwBcU086dhBLyPz3vHVOSJuscEBtJzE0EXQroePZRzKmcekpCB7S+jNZzIzxvDj9Bu9VwaXyYMH83aROcwtS3VJwd+Qakm9iijNHgXlX7jHui0BFLdhJgfRwCCRQ+ABWIdYjInlkNK19jQs3MrUJ8LPRVMKCMfrFs4Q+GeAs324CfzJGbVCcoSmzK/htDr9MXB1Rh/T7TnNYDHEt1vTUQeHc7QKpu4KVXlu5KsfFa73qUD0HqpfuU0yDIVqibfSPQeVPi0rakoFXJtt4zwkj8eoiHG206S4zdqlaV7LMgcFg9t8Mfmzk2/yXJyt5OfC3vxIGFO/JeEm2L9pOb3DgWp4z+eeNn3qWbFI+zW2v2ursYRe4P4f/kvQzuqOHblcGlhv/4Yfd3LKkzrmxOO1D5AKqtrdXr4PE0tK2YwUgxKt9IPQhJBLSY6TkRYPPszWe2nb4NeSfuFDiIjMgyS0Rvl62KucLFOrPHU+vn4dUx5Bs6WwYlXW3oG5q1lNXWtDvvNsdgpdkduK7vFsLH/ptz9J3SemvyR7SiYiVCN6sEk35iwyMyZ/SIuvqm/mPwqVyqiBOdJ1y1adlnnHsNbtCbQXJ/5UXA7ZXvaUnVauobXUF6Abx7wIXtH55qUzMd0p2uLiePPCad6b3UeofOws/3WRXAcnEQ72f72zYZXZe+s77+PcEcVlD07l4hGiBU72OahxCUu3MSc739H47/wDBgL4NF2pWSJUZXZ/DvrtzmgUExsqA29hk2wsD0A1I5Zr3NP4A7uuzJBSB8ZdCkrhv03SGaWxPMpXQzMzc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(81166007)(426003)(336012)(40460700003)(16526019)(40480700001)(2616005)(26005)(966005)(478600001)(41300700001)(36860700001)(316002)(6666004)(82740400003)(7696005)(356005)(54906003)(47076005)(86362001)(83380400001)(110136005)(70586007)(5660300002)(70206006)(36756003)(44832011)(4326008)(8936002)(8676002)(6636002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 04:34:46.4316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a84168f-e7bf-41b6-bb82-08dc26ccf294
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9146

*** BLURB HERE ***
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
 drivers/cpufreq/amd-pstate.c | 118 ++++++++++++++++++++++++++++++-----
 include/linux/amd-pstate.h   |   6 ++
 4 files changed, 111 insertions(+), 19 deletions(-)

-- 
2.34.1


