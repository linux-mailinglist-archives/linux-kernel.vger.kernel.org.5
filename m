Return-Path: <linux-kernel+bounces-43878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A39841A55
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF8B3B23B3E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2100B374D1;
	Tue, 30 Jan 2024 03:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gzyK9Neo"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D137376E9;
	Tue, 30 Jan 2024 03:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584746; cv=fail; b=X4VXyzmsqWhDebK8TdfkpZEVI13pa5HhO4rBp9AZAYgiWGh5waF4Vip6dYm5ny32CMmWMJ/YUT0FFBqiUeCFDNTnJa5fXkxN6kKVhirc9EjlNYiioT6/zS60Bc3YKmYZE73IipfdOfXKtErShXlKQqDz2pKvd3Z+hqcZ9UzbslI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584746; c=relaxed/simple;
	bh=XPb07nikLN76Gsbj0GQ7in8HFSgJ5Ua6ET9kQqbLcLs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NN5xN52/hR11BrlogoR7p2jFkFAbzU7QDzMde5Ti2zTRNNgx54Nq1qdgkV6IBjfLGdnrjTnIYSj+/z+LAXWJh6xXJIkte47JJ0Fpolh4bz4exBlhS53yy21hEsbscmexAx/UX4ZZZa7rNujiMF3q0tyDLx1AvLePUaWohADdmhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gzyK9Neo; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SniUVrkik8MZlWpG7UjCpkCKXkV7YcESKmeQTtC+qOr6zYnrHx+8/WnsthcR9Zxmsmwo+owKqecQzFpLArugLQOJQL2wODrNqEPn5ZpifsZ5J4X2o/bSi7OF0g+A7q2wzQ2JQK2khT05+dVsotSDry02h/O+uV53gwmmeWlVTIP5cRLaR1Kntf+elXVU9HNcmt5CRLPPcOgAB2yTEKJBsrjxfsk0RCQzw+7sJ/o16g4jOIV0HmHB3pgQYCJfXC6/kE8O+sevR9vd8BfG2yZFejPWNQlB8GPNfDcxvYOqzkyUC6itY3/gdcs+X4nsZM9sTrP2twd78KF39/dDP1DHPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jl28IBS9BbZYQALlef26RCRomYENhhi/5tgiaiD180c=;
 b=J/GO6NAm+ZQn3AnNvhAvH7zUgkdZ0+3O286qDFhKP2JJElu01+MFPxRrlXTeqfqZ/4aFNq3r+sTLx9II6nmu5ycGFnDWgcVbGHuYqRURGlTxu6NgElGRBHtUUqE71VU30GLeymCJ4l2zZHP/DaxLHzjcxZTMQn5A8821FSoqLqxAsO5A6h574nM0a5xbUCa8+dWe8K2iEzOxSQ8SDzcbj9IxYMOCuIOR/xcDM0064zBe5s7kQm5RyxSGIYplZ7SMCxWxl1NI3LXQTlnsJ6knumGzF4HVzOO53kwEjszdw+AclrCWWE0awbD07vnr4+ICIF+28bCym/317X7mFdJ1Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jl28IBS9BbZYQALlef26RCRomYENhhi/5tgiaiD180c=;
 b=gzyK9NeoXrWx5WvcWyrElAcwG/RNL7WQNY3+GLxPAFWkfN1MBt32YSmu8t25IW1ely+zTwQv1zh7mWuI3Orfnd8EN7uco4oRNwl2wgVBoeCBzNBS/ldd0AxOy24YsFb7hv9IWjfY47H87Dh7Qnfv7YDiqpVCw+nxmgc1prulOEA=
Received: from CY5PR19CA0081.namprd19.prod.outlook.com (2603:10b6:930:69::27)
 by SN7PR12MB8170.namprd12.prod.outlook.com (2603:10b6:806:32c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.33; Tue, 30 Jan
 2024 03:19:00 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:69:cafe::b8) by CY5PR19CA0081.outlook.office365.com
 (2603:10b6:930:69::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 03:19:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 03:19:00 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 29 Jan 2024 21:18:56 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<Borislav.Petkov@amd.com>, <viresh.kumar@linaro.org>, <Ray.Huang@amd.com>,
	<gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 0/8] enable x86_energy_perf_policy for AMD CPU
Date: Tue, 30 Jan 2024 11:18:28 +0800
Message-ID: <cover.1706583551.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|SN7PR12MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 001c5276-29f5-43e2-fc62-08dc2142340c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VjcAe6OjEAp6QLhrLKVxVjy/xZPwjHFOoSxSP6JlpXpPVp0kGCtZuhZ0I02eXHM0fJA2hsUVx+vm56GxNHrtPYxaU9Dh4rlkk5GQUoQihV+9u8LbUyaWqLHcne0Jc2Taba5ymQOlRxIqrINfOKiVkEaVUGJZW59w6Ud9zRA4mGELZFMGPuZOdUBEf1J3KH1AD8lF5N3I5W3QrkShGFlchXwSUCZKAuaBdUlKwjxUnOfZ2aWUPw+8Oh1YoCJ6fAZaN50VcCe+dHO2kmFHyvChP3o86/rq5DFPgQk25pFl2JPoir0p9iw4Uhumj3HB7I1jRGCsxkiPt+PkGQPXSWeMsgjB6jT6vSeSWevonG20oFXQcpC5GB5lHWMCkRSj0l4j5Q9vOLcVUxV1Shv6NFZzhWd/bpQb+B80Chrj9vfV6gbKR98Mpo5jJa3aO4eADD1djhgZh+0AqSbQpOG6FMJRG+Q7RT9aLwLCJ6rs/u/f40w1a2qo9GVbSvLYoHyxVlaeAIk9MO3Yr8/M4Ah6g+4fGmUo0lwsGmBPGA+eSBEflJQBg/otWugDPXGuWcsAmwAvwnd7bCKx6MXe4UMtkpSIfwuRlJsbM8IEQkHzOMkIGHMcpg2nl1cp+/aCye1RWta8VCTMaED/WcnFqZpg+tRRByqjPrafqpI4pTRQizgZ0Ns3Kc8MvEI2cJGn8ANUAj0Uwk75mE9whH0HyFOmgecPcLMBOS9JbsELOxiT/GGIaNHZ7uJBWHhSAAtGyzIjnk51TLhpYvPeo+lqjQX/8Mg0fA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(64100799003)(82310400011)(451199024)(1800799012)(186009)(40470700004)(46966006)(36840700001)(4326008)(336012)(426003)(36860700001)(47076005)(478600001)(41300700001)(36756003)(86362001)(82740400003)(83380400001)(81166007)(356005)(8936002)(2616005)(110136005)(6636002)(316002)(70206006)(44832011)(70586007)(26005)(54906003)(2906002)(7696005)(6666004)(8676002)(16526019)(5660300002)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 03:19:00.3498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 001c5276-29f5-43e2-fc62-08dc2142340c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8170


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


Any feedback are apprea

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

 .../x86_energy_perf_policy                    | Bin 0 -> 50808 bytes
 .../x86_energy_perf_policy.c                  | 355 +++++++++++++-----
 2 files changed, 271 insertions(+), 84 deletions(-)
 create mode 100755 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy

-- 
2.34.1


