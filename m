Return-Path: <linux-kernel+bounces-55865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6024C84C2A3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8961F2333E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73715FBE8;
	Wed,  7 Feb 2024 02:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZKShqtIy"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66285EEDE;
	Wed,  7 Feb 2024 02:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707274010; cv=fail; b=M8ALDBFH1jRWSPLtKiNSZOdBHRa7zju0VnoVkFWjcW7o9mZnwObpMzMT/xT16gebs8udlX/6aV/jog5n0DmsPoX0R/9ICGsZfdKh0UPau/SlEBqlrK3wLIWuiUEo04tTLEWQpuSUXFed5MMUx7hLJsXiZQA/X1kAk6pkL1uuFJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707274010; c=relaxed/simple;
	bh=9/3mDfcsbrOPVTlRFOzGdtUxEfitsMJebNMJLkg2RhQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=odMfXmDa2TbNpKdKAUv+26jzfqr11CTqpXij9RxMOQ/Uc9pSoeyP7QoRBxcwVLXmJABedLSGNIb1RDn5kGcq5BlrBwHbwlEzTw6GBclTJiYB6ElAH6884xVnnyjjbU9u9qREJfMNHOGW1SWYFFycWPUWbIZGAO2NYxd1TzmfHcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZKShqtIy; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfT/klL4MnUSrXC1omFEBi9Y/udCb3ABfPKD8nR66hHUGbZ0ON3YGT4VwogDJD/P5GDAlqJN9FKWCNzwsPNUp30qus4q9zRxeovu7X76gvR1Cye/NxHRhkrmUzkIi/rR0G1bOEqOEqvL23dpM9Y/Z6ZNS2BKbJhtnCrPEY2ybesELp8C/VTsuPSo0tq0P31EcoXv7scC3uHGZpokfkjcpYy06OoEaNjdJdrcQooDPRFuN6WomF67ZQRovw2GajVUKtb6VTkTW2f6NSsJIoORMuoDQeGK2QqFas/2EGg3VIWCEk4i4biLQOjbJXxhtcBJnGgJwWwdT8N5MjiUJd2mZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fP/pL3BwTGp3HwZrIaJfPeMAkR/kLUmAeEbUITz/bLI=;
 b=E0uMkG8NO7/+WNBuMA04OuR1ABOXynWoYqNf6VyTXrmn25OS95OLSuZRxOlflYHiCCnzmn2CVgFLYAYl+bm9deSSSolCtKnthqnec1UB8ZcDNE5rjEpD5xA+mDEpJGg75QqIQxAxOixauzAD1qzEc3boe+lBGmHVyrpIH6H78fVxZoWVx4wMm+x+3nkfunHx+bB9Nwxyh25lnnhkxpCfHKG+iaWUB+opYBmYH03U5tGCCfppMyZoxbyVyF5CKBIDlS4lp6+fMfLX2/UY6i0TOSfKtdxOc0iADHKPqRtomtADXxhqdVgU0jQVnrXB8LtA2PVA6I0/+Esh5otOia96eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fP/pL3BwTGp3HwZrIaJfPeMAkR/kLUmAeEbUITz/bLI=;
 b=ZKShqtIy5hAzV+NvoCq+d96HQPAexOl1nL2g+vj4mMGz30YYc6JhWaeiygevZFyE2gF1rRkE6/niK6N3/Kzt/Mj6QV8RZJN0m3v1xiRuY+U0FwYUFnL9MDToHqCvXB1zfJ4eqAO6LpOhxsv3bEaMN2Zzg6gtdYbYrGQP+/5kY8o=
Received: from DM6PR03CA0059.namprd03.prod.outlook.com (2603:10b6:5:100::36)
 by BN9PR12MB5082.namprd12.prod.outlook.com (2603:10b6:408:133::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 02:46:43 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::95) by DM6PR03CA0059.outlook.office365.com
 (2603:10b6:5:100::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 02:46:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 02:46:43 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 6 Feb 2024 20:46:39 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/6] AMD Pstate Fixes And Enhancements
Date: Wed, 7 Feb 2024 10:46:09 +0800
Message-ID: <cover.1707273526.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|BN9PR12MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: 5354cb7f-1d41-409d-7436-08dc278704af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vj9zGkUG49ja47rUAYvSzDsyhilQTHq3Dhok0NDqGcfCfHogmkX3owY6XSUJj9mih1t2h/a5DesXUFtIYE7gxWLQTH77ZDjBfmMUn750KNS5560yaG917Jv8RTXbrTedsKsWZ052kzOnKUxM61eTPDEhRXx+vj0PeGXIpX0dSsPyeHBB1QVCcj1jbO0Z3cbs/UmBNr9qyf3W3iZGrDDGhvdoq6LEDC153/diexL/NmVTrDQgLJu0SqxG2hPcNkYflfmC99kE2GhF6imGP5oilo2VCKEtoy1lYW3p9WMEPCDwr2BIy2Ys5JmzgwslD1inuX7XM1S5FqnqXvvse8iIzjHZZwqL5Gpo7JefAKIKtRQSBAqX6TFns4VQ3/9U8gAT2Sx29w5en88kjqHbJTKr6w+sh9mwCjetKvqix19eyNnnXgEBl2P6Ab01wzyvCyXMcPz7pTkShvgoa7v9ph/xqkLIYEguMYpPP2tsPyBvH9//58XrYuACtgQEq+Gp/SlLydLKVFTiV/ECLh442NsjBzm92wnFXqR25+ghqRWppJTey745V9ADaT6aqBMfV5XA9v4RNe9/QY6/4B5KnqCLw1/H2Lpd5WX9oCiHje964OO2wqdO+yJJj/9r78RL6Bibgjn1h2+nV6ZPSD+8Pp6huRcLwlHXPGnx4i9Gw/Of6prR3mZ0oLROaTyJwjaocNXyPXSNzRhdFDj8/6+raikJx03fkWl6UpGXv/4p+HrdnbzveE5G4J+VEsaOf7UqfXh3a8GvwtcoEzM7+ZaYE+8+1zopJ46bSuevL2Yhi1SFBNU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(46966006)(36840700001)(40470700004)(426003)(40480700001)(40460700003)(2616005)(16526019)(336012)(26005)(82740400003)(41300700001)(47076005)(36756003)(316002)(54906003)(81166007)(966005)(6636002)(36860700001)(356005)(478600001)(83380400001)(7696005)(6666004)(70206006)(2906002)(8676002)(86362001)(70586007)(44832011)(110136005)(5660300002)(4326008)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 02:46:43.0724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5354cb7f-1d41-409d-7436-08dc278704af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5082

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


