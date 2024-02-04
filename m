Return-Path: <linux-kernel+bounces-51401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9788848AD4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B282848AB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8341C13;
	Sun,  4 Feb 2024 03:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UIkg6uQi"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9957310F1;
	Sun,  4 Feb 2024 03:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707017194; cv=fail; b=q6xHsPTTkZ/LfF18R4CBT4ycWvEb/U/arc4ZynZVb+xuIAGmO6tzq6XTGQwOb0r/mmGUrnjIzTHITAlXDs5LpffRxmh8Z2aAYTy/6fKmn1zbqhdnfgNd4T8DPnoBUNfprxHxJL25QQYZkyJ1bsod/kMvXAC16NZ+00bscYPIBI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707017194; c=relaxed/simple;
	bh=VzxkN1Q6KCRRAHNdfhp2IeMulaSJxtP4Cw0+D+3pZiM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RsJV8FnR8IQuRxFjUdQyxcJkomDNncV9DKs3fRPri3Da0H9rjMO7wk6ydhkeRfiWmIx3QgUepMGSFN9O/jthQIbduN4utmC0K+ewRDIDgsKT/6R1hzKl/4jKe0XCSWnjkd+HhzKIg7c256H7Sac9hm7mMBGDPLG5po6BrGMXu40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UIkg6uQi; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1GdqJ8iOT1uRCrsrP2ZRhAdMJ2JCfitHKDtYNjfBkr7+HDqHIZepnIET6AE+qW8r6j5XrK7xJARE0NZEze+ySF7cMmlUNcmqZcPFM60RNC8RzMvAQ1lKnHHR1g4zAF8jbkEh6fkksoYP3Jnprw3esC5XislM7pgr4ATkG/gbs4jCXMfIJdmlMlmR7aRAReMB0aihiZV/ZAwxbc2eeWU/0uhnMhVTR1EaNPA2/TDUdpKhRuXGTy8clU8b+ySfZSW6RHcRv5xrHk7JiXMt/tNVi9tXApMuQDsi2drYStE6lLKkcfPYoYpx3fcO64S46zuGdyeXd5s6OocTvYwzBM7MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLrResU8wGQtGGqBaXNf3pGfdb6zut6S8Dxd+OpjQp0=;
 b=WggJ9B4DJT8n9r3qJzCz7VOd3HUcgOKT/qpeJtJUreYGZfuG8S2jUJNl6Awp17wLr8R/3Ar+1ADNmFHHPLT9oDNqwYkbs6I06Yop1139W3PFb5jJybIA+EnIwLNS+6RRoo9heK0Gi7PqaAisqpCCdpshH+hJn6/vgP+Xigq/+OPSmYxW+DNw0hFMCbbsrD0yZxVvBss1H54l1TNycPRH36EyKvbPGklxRgUcVPlapd6UrTnT1mitvZrd+mqdzrtYfUYOuxZXpYgyIuRj+xKXo6P5lXab1FJUJ2cRxZy+e1VwmCBZ6Z9AFGKVdhe0s6Wyc9dOuTmdTAQP4f/G+93ZmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLrResU8wGQtGGqBaXNf3pGfdb6zut6S8Dxd+OpjQp0=;
 b=UIkg6uQiVRrol115vBnJ0f+DzgiEQ16dgEedzb4SpYR+Mw73fS+9Sn+SpbPHPuP7GVaiOVToA9UK3EaLp6JkBq6KvnHsRqRnAJPtdqLxygmYsnXlYu6SvP2Py465JLKz29B4fmy6U+PZacEXwa9PSMawixpDbnD9rgARWjZMEfE=
Received: from CY8PR12CA0014.namprd12.prod.outlook.com (2603:10b6:930:4e::16)
 by DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Sun, 4 Feb
 2024 03:26:30 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:4e:cafe::77) by CY8PR12CA0014.outlook.office365.com
 (2603:10b6:930:4e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.32 via Frontend
 Transport; Sun, 4 Feb 2024 03:26:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Sun, 4 Feb 2024 03:26:29 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 3 Feb 2024 21:26:26 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/6] AMD Pstate Fixes And Enhancements
Date: Sun, 4 Feb 2024 11:26:08 +0800
Message-ID: <cover.1707016927.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|DM4PR12MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: c5c51bd3-ad85-4f41-c0d5-08dc253113f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u3LM8yWXclj7vz2TOLv7SNGnJSHcP3Kdj41nLWwht4zgWICNG/MnF11UnrMFR7ilzpbE5momGLMjFEcRZP5NXU0+G04zLZM3yJIxtqmWv+QA0P1yw6CjJZT5wzmq5IhX7wGAtzGl7Wm7midRVzz5Z51rfG5IAvKYb5ZOlI+iFcDrDvF2JRRfnib70rYNtm39vKrIZXBXD5bAtxjq3Xo5HUwooGwMz9baBDdQPsVtp3nodM6CfZbVhBp+U4bt1Qkhm4uAZCBLx3DzdxBjMuWNls+jjPc7ArOV54EI7Ss7LMgPHNpaZZAyklouytkIcxNBbgap7WhxJAmMpchbGgZe7rbAjC6J3DvbTNJWAKaMn4zTWZUgkUcf9VBuVU0qH0ycQ5pUIrBcTGkpDbDxGAEtagWIuvlT+8stXF3uREZwWWi4ElqKeAWijV696llb+j/q4SEKq8pkm3XBIs0C6Tg+8MwcBxg9MUaMZGD9L2YJgMWMVw4RXP4dMaHvWm+k2koxDwUzSAUzJc61zALLGZrCAQZlN9c+qR1idp2EVX8/QhmGYD/hqs3IijF9ygYRN/9cI8q4j7QyFv+EKeq6mW6IZEfU0zwArVEDzOvfARC8nM2NHTLjorrC8PDioVhppiI3z36IyxXwE/vYkg1ZHJUijoF/5HN0QjjSgGQHMslF6pHEhueAk+LsHnqy29xwcj+U5IIqkkIBsRg0Ow6koCiAEdjUm9Hj0vCY/XWA9dvRtatp+4Ao8L7gSKEA72zapuCdAyAjOQQUPGr+WnXbJedMj3V0VR6RLgDjekGRAuBmzps=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(82310400011)(64100799003)(451199024)(186009)(1800799012)(40470700004)(36840700001)(46966006)(54906003)(4326008)(8936002)(8676002)(44832011)(2906002)(5660300002)(86362001)(110136005)(70586007)(70206006)(6636002)(316002)(47076005)(36860700001)(36756003)(81166007)(82740400003)(356005)(7696005)(966005)(478600001)(6666004)(83380400001)(26005)(2616005)(426003)(336012)(16526019)(41300700001)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2024 03:26:29.7303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c51bd3-ad85-4f41-c0d5-08dc253113f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5771

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
 drivers/cpufreq/amd-pstate.c | 108 +++++++++++++++++++++++++++++------
 include/linux/amd-pstate.h   |   6 ++
 4 files changed, 101 insertions(+), 19 deletions(-)

-- 
2.34.1


