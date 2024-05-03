Return-Path: <linux-kernel+bounces-167303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9818BA77B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A442828147E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B65146A75;
	Fri,  3 May 2024 07:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BuPDEDL8"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EC6139CE9;
	Fri,  3 May 2024 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714720598; cv=fail; b=SK9ugF6AFu57zYQ+uj9dJmjtfPIFc+AX3kmwc5EWGdx6hTTGd1ruidjJ13mVqE9u4aB9gR7/8xfVeUj42QZ3ycR80wgfQdT6nD7g4d2HMY1gGQ9OEczLJxoBwamV3XLhNwTlFjOAXWSFuGpIbMH1YsAhINz1w1q2remn9M3mjv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714720598; c=relaxed/simple;
	bh=RbIU7SrlM9+SuFmDuE5WYwOi0UEoTcfs0aLbu3pBTLc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N5sybqnnfNR7MxDQiBDry9HDCDQYTuPRb6QBEr1rmE/BkO3CN/W1a8Nl8x5GAA5MCBvZejVqgnEhUemkXMFGeykLpu3+jtqszYwaAAYcCJ/EabFfnX7z71snM+iGB9oXUbQW8r+KyM57+iys6UCPvRFSUivRlWfsNA5YvFrFx+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BuPDEDL8; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmFBR5eoE8gHV1hZKspbrX05KR8oG1W0Yq8DLU7YxMbCaG/mtkV8r7UnJelVpEv0zCwM76azse/zyemkXUOz+xSTxmNEru4ewQKO737PuTY9ke7Z9xF0gWV8ptNHKGspyiNDXv7bnNe3LfRO0P/gqDLLDsELLMoWmQG81XQ9r1LBpkJ7RWly0aQeSeTrEVooNk/Aar//OCiQsItbSjLVjKa+ya2oLAqL+sm87XkeUZ7fP+nHGT5tSGnzMl3mLEv6nCqn++Qj473DXkRRC5Pa3Iwko+9SFoVb/h8kw5vHgUFkvuiNaLRphmPeWYpFeTfvUctrFQk00Qq76e7SIuyzWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFlt4GbCEPI0umE1wyZD4MIH0bItQIqziEyPpyZPvck=;
 b=NA1049LPmJqHREQFtYkvszplg6MCUHvLd0OC9qrTLm4/qka74X4DCSA0Zyc78R2MoAg3HC0aGFfVMa6kkZewrqdPiBQmBf1NJzYgDMJKoWG6H8ZnKDvUSvoMWWgfsReuuryHwKpjMA612h02++1RHSjBAteXOi0sTny+7knSUEZdTnsTj7fzQwB1QkMTvwQ/m/4YVV78SUSFYkVj9rdAaQV35Sd3uwXwu/dFZ8ThvaChVHPSdfcGKXKDX7hb7NupyZbV9V0yrrpDagoxKK3UL2joG26zAkYP2W7jedhv042TFqgx7hXH9KPVhnOn80KH/WGf28i8KPVSmxUfarksZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFlt4GbCEPI0umE1wyZD4MIH0bItQIqziEyPpyZPvck=;
 b=BuPDEDL8cfqpblcGHBM6jS+VWu/LGoLRZbltn8oPZjKZ9iufUWzauD+8snuTMIZt8SSHg1nlqONFUlxjR3XZfua9d1e9Sum9fjZcz2Vypl/YAeNVnKDHldpqjAlb5R4dcZzzKymwUSRfNZJ68hm9k/yi7e0j3fDcuRhAw8Y8wzs=
Received: from DM6PR02CA0073.namprd02.prod.outlook.com (2603:10b6:5:1f4::14)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.31; Fri, 3 May
 2024 07:16:34 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:1f4:cafe::53) by DM6PR02CA0073.outlook.office365.com
 (2603:10b6:5:1f4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.32 via Frontend
 Transport; Fri, 3 May 2024 07:16:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 3 May 2024 07:16:34 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 3 May
 2024 02:16:29 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <eranian@google.com>,
	<ravi.bangoria@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 0/4] perf vendor events amd: Add Zen 5 events and metrics
Date: Fri, 3 May 2024 12:46:18 +0530
Message-ID: <cover.1714717230.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|MN2PR12MB4208:EE_
X-MS-Office365-Filtering-Correlation-Id: 6646d645-5fa1-4c49-82fe-08dc6b40f6d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w9YNwn8jItivcUjRpQT3SYe0jnLn529pSbdr7vbhDY0vmOZHpjtbRVxOjRdI?=
 =?us-ascii?Q?HHS9i8ZW6lrUguZpOKJsPTB4bQqcXz17CEzHBnc1WbXDOd+LRJoVG90/VOEJ?=
 =?us-ascii?Q?1jtkwUQ88rUUCEVJ43tXh+pZD/ll7UftkLz5zzRMWu4F2NyelSKxWitD56sN?=
 =?us-ascii?Q?oFZUO5K5KGTuzoKbvyxhWgCU2G6eDucryBlEdM1drsS+WWVuMo0324rVnUJY?=
 =?us-ascii?Q?I6Y6PnwxHGN6fiDLSPCuhC+awfg9gtALBro1R20mtSvlhMXu5mbFkCkbbUB4?=
 =?us-ascii?Q?6Homz5mofkUq4L5WJ8w/pcUzHGWCYc0njnainaX9u29TzWhLdhLsYbR2JfiH?=
 =?us-ascii?Q?fefHBe4OMNdccjkXcuM80J4IZnvOVoE7X6D79PrSpMz8wEcpMKpfs8tvkg8F?=
 =?us-ascii?Q?IZPqz0iRXqMEXiKHCa/2Pys42XPxsn9vJ7RRI8qF25yWvJl7NVXA9YNpiueB?=
 =?us-ascii?Q?a2guKUW+IQ56HLnOc1AVRE2glDxZG5wmDHl8Ne/iAaxeLn9K+OHL5U7JNR+B?=
 =?us-ascii?Q?1DgJ0iRzaUkpytuYhOQ9shTRTX6Pua8Azp/073pvzNw703MRA4zKHl0MzPJ/?=
 =?us-ascii?Q?hwqnmW5jPv60Zo0WJfEANTvylGLlo4a0QOEDs+KOG+fkPO7lvWMKKulvBxdn?=
 =?us-ascii?Q?CDq5Z2uuNXkNQv2jrJ0y4373nwp0u1KIct3VxpZt981ToKCIoHqaRXbR9yx5?=
 =?us-ascii?Q?BQbYuObl87oE6DHvFmODI2PyMOwLeXLV7hEdNPIFONplGNmmY/KVeBQX/QhQ?=
 =?us-ascii?Q?OKdlcr2LzMw7QJcrufFX/EYzNzUU6D4DBjplMpf6UHDZ61mNGWGA4J6FCZJE?=
 =?us-ascii?Q?zGlAB67VTxxj4m15vgcVUIZIkEQHc+6MnripGf93JIhOBoaXKRtTOeYlsrM7?=
 =?us-ascii?Q?06yP9hiWVpBSxHRuOEAJ1VXrhps28ZNC6/J1bqN12Rw2UghsQgvsCzvCJC6E?=
 =?us-ascii?Q?2FON6FASxM52SFXnu1GRfVSsAh3Orq1gt8QcdOLsP0EEbAvkXudJLcgqKBqN?=
 =?us-ascii?Q?6DEtblrOTiMsSpzpbwSSIy5k+JwZ0NyH4BWc2aq6na3mj97/mRpJk0cgsax7?=
 =?us-ascii?Q?k/RCyTu7aG6qiWfpAuDgn148uSER0ILF47CSdU0IB25jPmmMUZKxvkvCu0xy?=
 =?us-ascii?Q?zp70Lw+7n1F5+qn3LdLBQQYArjyePz/xalmOAQFiVK1c7ahMXWjvt8DBstKQ?=
 =?us-ascii?Q?QySLYQD1Wo1a90XPIN4Ek+V0ZT0C1zQBIgnZBQbsrAfUtPd+K8WjRIZG3rXN?=
 =?us-ascii?Q?jqk0ZuDhUa2oAWXgAAS9wz59cRSJWZJ1klZZcsXNYMg8dI2S4SFOvGdEFlly?=
 =?us-ascii?Q?nmVjGckjAytREMRr0whOd27tXJtP90NYjJWzpReVMSj0hQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 07:16:34.2046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6646d645-5fa1-4c49-82fe-08dc6b40f6d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208

Add events and metrics taken from the Performance Monitor Counters for
AMD Family 1Ah Model 00h-0Fh Processors document available at
https://bugzilla.kernel.org/attachment.cgi?id=305974

Previous versions can be found at:
v1: https://lore.kernel.org/all/cover.1710133771.git.sandipan.das@amd.com/

Changes in v2:
 - Categorize events based on their prefixes and rename the JSON files
   accordingly.
 - Change metric scale units based on previous suggestions.
 - Describe pipeline utilization metrics as percentages instead of
   fractions.
 - Rename some pipeline utilization metrics ending with suffixes like
   "_bandwidth" or "_latency" to correctly denote that these are not
   actually reporting bandwidth or latency.
 - Change branch misprediction ratio metric to misprediction rate.
 - Remove some duplicate UMC metrics.

Sandipan Das (4):
  perf vendor events amd: Add Zen 5 core events
  perf vendor events amd: Add Zen 5 uncore events
  perf vendor events amd: Add Zen 5 metrics
  perf vendor events amd: Add Zen 5 mapping

 .../arch/x86/amdzen5/branch-prediction.json   |  93 ++
 .../pmu-events/arch/x86/amdzen5/decode.json   | 115 +++
 .../arch/x86/amdzen5/execution.json           | 174 ++++
 .../arch/x86/amdzen5/floating-point.json      | 812 ++++++++++++++++++
 .../arch/x86/amdzen5/inst-cache.json          |  72 ++
 .../pmu-events/arch/x86/amdzen5/l2-cache.json | 266 ++++++
 .../pmu-events/arch/x86/amdzen5/l3-cache.json | 177 ++++
 .../arch/x86/amdzen5/load-store.json          | 451 ++++++++++
 .../arch/x86/amdzen5/memory-controller.json   | 101 +++
 .../pmu-events/arch/x86/amdzen5/pipeline.json |  99 +++
 .../arch/x86/amdzen5/recommended.json         | 345 ++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   1 +
 12 files changed, 2706 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/branch-prediction.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/decode.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/execution.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/inst-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/l2-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/l3-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/memory-controller.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/recommended.json

-- 
2.34.1


