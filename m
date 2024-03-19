Return-Path: <linux-kernel+bounces-107214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1700A87F95B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483CE1C21ADD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AAF53E25;
	Tue, 19 Mar 2024 08:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d5T5IDWc"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23271D540;
	Tue, 19 Mar 2024 08:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836315; cv=fail; b=OoHAPIVACSwb/ooD1WraG+imWh7McNfLTxI3metFijRV7qE/mihZ0ew5btUZ1zI5vbRBjrKZ+tw0SF+4nZWAAKOJMDok2xY6deKWwmNedtoyiounKHYR3E/CkptQILq6kweqRwrbWRkTg/zTeYA5QIAlCh2G8P7xauiiUwgQtx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836315; c=relaxed/simple;
	bh=8q3opw13EfRX9gjf6Mjx5FOKUZBNYUogO383nI7MolA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DfHDBms219KJvG4jV6FfrvVMpl8F8e7uJuTHkpdklBCFGCIe06ZvqVbJgTFnhLDxfT9oNAsr7cyL9+uWuFGeLJMyprvF7OSDW251mGeR/ZD2Z0Hw3ibul1l7gUupk5pJ36hrH+rHYYMCqK1yC8/Mj14pYzUjCz0dyoEmoSbjE3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d5T5IDWc; arc=fail smtp.client-ip=40.107.212.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gP71wYebfQtJOC8xLssMzc+0DU0TdGgF/zduFzdLWTfcUyqcws0vvlXTBt9aTXppELGn32uTfFNkiavZrNr8vO9y5vRdo0vSzF/8aNd022aZarb1qEQ6ryxVW1fj8sUgVK88C7ItFDLCWmlfLlX3Hjl4jTN48mCAZOOZ9P63ULcYEM9QovQWXsXzptuEhROrdMJQ0bK1pVei3GPKxbHvJ6IbMdryF8vvJAIJmKRrg/n5depAwLyWYznxAHv+49PBwxqJVqDd0lpl3Zee4uB68BazZzEsoEuccKDmDV7oe9R3sdeSSZYdNvHGEkM/sugm1jJvJuqPHWFxKgN72iyu9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AY6i4aW6ceZn/wIDRQ8rfbjoJabZ9FKtcX8e+N6fRAU=;
 b=Z9Ct+0h0AavxxP7HOTCyOe2NxaFZrWrdKJwO4lw8aMlTEzH6zwAkYWV+BOW2/SIHOm5r/Lhxmgtwtna4CsIjfFoVFu4ONi3b7yjjaZtb6fnw+Wt3mSWMT+Jq5hW/I+jAQniUE3kSb9XH0vcMZRQg8FgaQCbKlV6xCf4/iv1lGw5kXtxlOQ1Ie4zVpTYrF7iLqD37FREeHAsc62dRfZfBphXLaMoZ87OIa4P8//EiPyHBc3f4y59zXK1MTbFQH2k/dU5xXcOTf/C5lR8+BA+8puNPnr9Svmnku/FGlJCb0RWUwDFjZvlwcwo73y2atJ0HhmpnJWDpK5y8KHyi5R0nOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AY6i4aW6ceZn/wIDRQ8rfbjoJabZ9FKtcX8e+N6fRAU=;
 b=d5T5IDWc9qamzCiv+bycO7nxcD8iuMkIbNiOf4AQS+qN6/kDrJVrmsY5tvkg/3cSK0h+KFeCYjtM1jEBuvbla83uJsDonJdebggx75sQQc+gHzBSdoAV9JASdER1iR/YNHD+cXE4w/F1+nl6Q9NppZoUcZ/oGDgqT3NJNslVyuY=
Received: from CY5PR10CA0025.namprd10.prod.outlook.com (2603:10b6:930:1c::22)
 by MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Tue, 19 Mar
 2024 08:18:31 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:1c:cafe::2e) by CY5PR10CA0025.outlook.office365.com
 (2603:10b6:930:1c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Tue, 19 Mar 2024 08:18:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 08:18:31 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 03:18:25 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <peterz@infradead.org>, <mingo@kernel.org>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<adrian.hunter@intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <eranian@google.com>,
	<irogers@google.com>, <ravi.bangoria@amd.com>, <ananth.narayan@amd.com>,
	<sandipan.das@amd.com>
Subject: [PATCH v4 0/2] perf/x86/amd: Fix for LBR Freeze
Date: Tue, 19 Mar 2024 13:48:15 +0530
Message-ID: <cover.1710836172.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: e0485b52-add4-4b4b-005b-08dc47ed29b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B2+k2Xcq/8Q7onYsZ0Cx496o0X1Yn2C2Hp193nE8eZ/YR99SN5WWTl64ur0J3uJ/sO1H7J2tmDOuEeM4K3UFH+4wFloyOYcgTyNsNmxTJ+Dxbx1rDV0tnek0R9rL3iE1jmjCLMox2ScOjqWad18St0e1CEewi5hmWWRoU0HtTl9m3wj1l3b/7HPzTeteC1pRyQUgXzX0pP8hIfngoHWCYbCzVs98VM1jmqAZUglF3c/Ym7xsUZy508liJAhI0W9YFYWzhEm2dL/WgtBsHdaouxuGjjUkl6vE+qwu8DFbhisV5kPq7+G2UXzLH9Gerrei/5NcOKINNJuJxDzQbwCv6GVIKTYdiy6pB3KM7zaMIZBIQXa3llIHNdFql3EjByj25autzOQXZK0T0UiWNwNwgEENsogr88qSZYfwQRq4nlcI2i168FLNNWNz159JzGCF96OjedgHY1dpOGb3xH5OAZ3Q2DyOEm6WxO3J1ET0Y5AaBhe4cG2NxsyeXQWDH8UP//bjITfK1XKGSric+GiHd2kMCgRZ0lQm9l1TW+LJQ2TJPhhMkvodsaj/zwfdFzU3e3rfl2vq24TpQOOWr+JLyEfq+VdtuUN/ShHEX0psuiIzVJ924GczS0CNCT24IPy2K0frd+P5dXxJxg8ArA44KYER760NqMOS4NfgshXAmaD0ipMIkg/OEkVSG9D4tZDVcmWm0hUsGJxaD2hT5u9xWg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(7416005)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 08:18:31.0739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0485b52-add4-4b4b-005b-08dc47ed29b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626

Contains a fix for usage of LBR Freeze.

Previous versions can be found at:
v3: https://lore.kernel.org/all/cover.1706526029.git.sandipan.das@amd.com/
v2: https://lore.kernel.org/all/cover.1704103399.git.sandipan.das@amd.com/
v1: https://lore.kernel.org/all/cover.1702833179.git.sandipan.das@amd.com/

Changes in v4:
 - Move scattered feature bits from CPUID 0x80000022[EAX] to a dedicated
   word as suggested by Ingo.
 - Remove patches that have been merged (patch 2 and 3 from v3).

Changes in v3:
 - As suggested by Boris, update the commit message of the first patch
   with the reason behind making the LBR and PMC Freeze feature bit
   visible in /proc/cpuinfo.

Changes in v2:
 - Make the LBR and PMC Freeze feature bit visible in /proc/cpuinfo. As
   suggested by Stephane, this will be useful to determine if it is
   feasible to perform kernel FDO on a system.

Sandipan Das (2):
  x86/cpufeatures: Add dedicated feature word for CPUID leaf
    0x80000022[EAX]
  perf/x86/amd/lbr: Use freeze based on availability

 arch/x86/events/amd/core.c               |  4 ++--
 arch/x86/events/amd/lbr.c                | 16 ++++++++++------
 arch/x86/include/asm/cpufeature.h        |  7 +++++--
 arch/x86/include/asm/cpufeatures.h       | 11 ++++++++---
 arch/x86/include/asm/disabled-features.h |  3 ++-
 arch/x86/include/asm/required-features.h |  3 ++-
 arch/x86/kernel/cpu/common.c             |  3 +++
 arch/x86/kernel/cpu/scattered.c          |  2 --
 arch/x86/kvm/cpuid.c                     |  5 +----
 arch/x86/kvm/reverse_cpuid.h             |  1 -
 10 files changed, 33 insertions(+), 22 deletions(-)

-- 
2.34.1


