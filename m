Return-Path: <linux-kernel+bounces-43959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD9E841B9E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCCD1B24C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 05:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C3B381CC;
	Tue, 30 Jan 2024 05:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RuZS5sHK"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D386381B0;
	Tue, 30 Jan 2024 05:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706594214; cv=fail; b=HMQxrP9GTCHaa8vwJLCmnbp0As20Z/GhXBGRDD0jhQ/uBXqJgWYU/VXqid4NtN8+nGdoBcPiehBUIqAoN5ft6rcJMfyn+bpN6zip0VaZE1vEfi8rJ4VEmrwTxQ1blS7zGczR9jKKLmsTvzBJoQpYZLCnEY0RolRQOE0JsU+9KSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706594214; c=relaxed/simple;
	bh=SsKOfRGh4jqOKkxIA8zI2+9kUacSyofnk3dFgFp01Is=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zd/FpBxaFXnBYn41FzX+CyB5sGpZpkRiNJXwfofl9irlKdhDWrqbJjc/rID81PJ5kPdfwnLYDRUbCjzJWD/AQT34Zq5T0Y5mKMWELa77lHnpHnh3DvkJ7i1asme5PTg1k34mYmF1Sh2InP1ENbsVHcv9nvXZZcgLyYfE2ry30nA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RuZS5sHK; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSNQD2lIkTwpXl9MvlvNHRpoIgZ55+7cze/dQlVJDT3a3ws60d0tMFn4lix3DoK8cy/wsVee2PQYJB8yIJ6Md62NIIhNoR77EfQobEqeTbT1IUDx7vlt78s0lTXLT/fXe8Ye8kSSrZCw6n+e6Z+N9NekVa0ynWmqhPA6riw4BObnJhnrLSv1zLh9RtJyhPX33qLLYkiSzspPpN1dcHPDitdfzIkbrUqpGCHzI5NEySQGK5m0ZSJOwW+EaumQqubnJmmQbDzu+0gqdy20mVqFzc37YaRuxzcSmFXzfxkBPfQfYmICXppe/pqTMcGOhvIp9n4OQ06utlAloxmBndVq6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJuyMaMF//sBStXTT7ADJ7NPGmdN4to1c9LiaN+XTJ0=;
 b=F6XUGgws5QUOlA0Qx1JkakbX6Y07RNp8wJlsr4Q4VE25a7ZJanFl2FZry9BDebXD27dEEQ9WWdecitGJgqdo1R2kT4HA1+noadJyX8FCEmHQjc7nYxzeDjI69MuY5ZtpVrWBy8oO2Q7ZDHIuBShEM/Z4KFjFkp4++VpXO5jY8eNp7V5Zgs2Yu4uQNyKst3LHfPDpAp9ThnddEltAp1BNAI7X0ITGro+34D/2xWOLjkI29thigomatiRnh1UME4vxjI7LAGjfDafK3LrirdOdIs93Nxz1eoTSVi+DYm/wftjNx9Jz81O4x2N69kDeOjjVgK5vtEwROquS+U7OWj1LXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJuyMaMF//sBStXTT7ADJ7NPGmdN4to1c9LiaN+XTJ0=;
 b=RuZS5sHKDSc9mmAcUaqbgq8Z288PTUAehPr37HaPgi1/jTqlelSkSq2zooLhXusjuyzrwQpsFGZuVQhcFkbe0OPTUI+EB4ZSOYA72UjyY1fLAri9eolZ8iYAPO0kL2ugBInxbHVPvWEpI7dbL7yYUjj8NSxZqEtGmWPAhX1npqE=
Received: from CYXPR02CA0010.namprd02.prod.outlook.com (2603:10b6:930:cf::21)
 by IA1PR12MB6260.namprd12.prod.outlook.com (2603:10b6:208:3e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 05:56:49 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:cf:cafe::81) by CYXPR02CA0010.outlook.office365.com
 (2603:10b6:930:cf::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 05:56:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 05:56:49 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 29 Jan 2024 23:56:45 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<Borislav.Petkov@amd.com>, <viresh.kumar@linaro.org>, <Ray.Huang@amd.com>,
	<gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH Resend 0/8] enable x86_energy_perf_policy for AMD CPU
Date: Tue, 30 Jan 2024 13:56:24 +0800
Message-ID: <cover.1706592301.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|IA1PR12MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: 012443fa-0a5c-4dbe-47b4-08dc21584027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c8/81JiVn8kC/p7yao6OJW5CEPqMmSqb4IDX4hPEr5YPp1DHkvLGDgMhOIZX2QOZ8p7onllrNyUBidWP/4mvwN2P3HBDAuqh+XOefW4Btog6ZzGmD2Tnt1EDz3uwSP9e2VcaMmNhmyQeBoOl3Lgp0FAwpB+UF4kAi6H7t7zB2t/V4r3RDrYWbWSBOUg/eSndeQy/dSTRLzj7ViEEJS3hPF/LqFMMwulrgF3cTaPYlEdq1WlanQB176vRw5djH+8iML5aTgBaSQw1iFicSpW/mdIfnM1vnDqrmyBYmIt0PrXOZvvUeDMM37EbYmbA2EDOvS3RIG6k/GY3bwo08UlFHuQbB6Z2mr+oeVYLq659aTnwXLRPyAlRKU5atU8rDv7vdqil/LC6Dg4PbtF/MSoakxFt/UjbBANu52jyz3cP9X1tKoXLejjxnmaGLtIkAe6iKKRaAPwKfdqTsrJu2Ns/sBWKJHze9qdDjjClJEAymO0G4r7Fuu5228xtuzOztUH7Qm0khyaTs96JcmjoOjw/qvrGTamhuJDozLUCqzXMQiTq+AGMuEDo9Z5KAXE3+g9a82T2X/mj2h4ChI39mjAIB8ydzcInfcZInku8+o4jOgHMW8G9WBIgdWAgz9Onz4SGYBBwlaGAQcu0bophSfwNaJ0V84Dbn8a0VSjRvg19jaxVfS2LKCeQ7z9lbOpkmnyBtNJoR274ub1Nfsj8VRCd1wgrSEx8jFpISQckqhpmgtqDCAoJIw8d+swd2Zj6SGeZjUcaeVVabvMMpUy8OrbqNg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(40470700004)(46966006)(36840700001)(41300700001)(2906002)(36756003)(47076005)(70586007)(6636002)(110136005)(70206006)(40480700001)(83380400001)(54906003)(86362001)(316002)(478600001)(40460700003)(2616005)(6666004)(7696005)(426003)(16526019)(356005)(5660300002)(4326008)(8936002)(336012)(44832011)(81166007)(82740400003)(8676002)(36860700001)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 05:56:49.5828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 012443fa-0a5c-4dbe-47b4-08dc21584027
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6260

Hi all,
This patch series introduces support for the x86_energy_perf_policy utility on AMD processors that
utilize the CPPC (Collaborative Processor Performance Control) interface for frequency scaling,
using the amd_pstate driver module. AMD processors already support various
Energy Performance Preference (EPP) profiles. With this utility, users can now seamlessly
switch between these EPP profiles using the provided commands. And check the CPPC capabilities
with this tool.
This enhancement aims to improve power efficiency and performance management for AMD processors,
providing users with more control over their system's energy-performance behavior.

There are some EPP profile already support by AMD processors, user can
switch EPP profile listed below with the utility commands.

User can change EPP profile like this:
$ sudo x86_energy_perf_policy --hwp-epp performance
$ sudo x86_energy_perf_policy --hwp-epp balance-performance
$ sudo x86_energy_perf_policy --hwp-epp balance_power
$ sudo x86_energy_perf_policy --hwp-epp power

0 performance
128 balance_performance (default)
192 balance_power
255 power


It also supports to check CPPC capabilities and change EPP profiles
at runtime.

$ sudo x86_energy_perf_policy
cpu0: [AMD HWP_REQ]: lowest 13 highest 166 desired 0 epp 128 window 0x7829a7d0 (80*10^7us) use_pkg 87
cpu0: [AMD HWP_CAP]: low 13 lowest_non 68 nominal 77 highest 166

cpu1: [AMD HWP_REQ]: lowest 13 highest 166 desired 0 epp 128 window 0x7829a7d0 (80*10^7us) use_pkg 87
cpu1: [AMD HWP_CAP]: low 13 lowest_non 68 nominal 77 highest 166

cpu2: [AMD HWP_REQ]: lowest 13 highest 166 desired 0 epp 128 window 0x7829a7d0 (80*10^7us) use_pkg 87
cpu2: [AMD HWP_CAP]: low 13 lowest_non 68 nominal 77 highest 166

cpu3: [AMD HWP_REQ]: lowest 13 highest 166 desired 0 epp 128 window 0x7829a7d0 (80*10^7us) use_pkg 87
cpu3: [AMD HWP_CAP]: low 13 lowest_non 68 nominal 77 highest 166

cpu4: [AMD HWP_REQ]: lowest 13 highest 166 desired 0 epp 128 window 0x7829a7d0 (80*10^7us) use_pkg 87
cpu4: [AMD HWP_CAP]: low 13 lowest_non 68 nominal 77 highest 166

Your feedback and review effort are greatly appreciated!

Perry.

Perry Yuan (8):
  tools/power x86_energy_perf_policy: add info show support for AMD
    Pstate EPP driver
  tools/power x86_energy_perf_policy: enable AMD pstate EPP profile
    switching on MSR based system
  tools/power x86_energy_perf_policy: rename get_msr() and put_msr()
    with intel prefix
  tools/power x86_energy_perf_policy: rename get_cpuid_or_exit() with
    intel prefix
  tools/power x86_energy_perf_policy: add nominal and lowest nonlinear
    perf values showing support
  tools/power x86_energy_perf_policy: remove the invalid feature options
    for AMD processors
  tools/power x86_energy_perf_policy: rename some perf output strings
    for AMD processors
  tools/power x86_energy_perf_policy: change intel msr functions to be
    static

 .../x86_energy_perf_policy.c                  | 355 +++++++++++++-----
 1 file changed, 271 insertions(+), 84 deletions(-)

-- 
2.34.1


