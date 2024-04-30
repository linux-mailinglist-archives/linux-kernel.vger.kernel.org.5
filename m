Return-Path: <linux-kernel+bounces-163678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C368B6E40
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2661E284DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778CF19DF5B;
	Tue, 30 Apr 2024 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zF4rex7S"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0E219DF45;
	Tue, 30 Apr 2024 09:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468945; cv=fail; b=VDJz4F954/l3V29gtbXNaq/yvJbXt3P0MY5QaRoNuHUDg4xbLe0e1nYPVvygd2dSHCl+8wxZXPRcOHosEqNfWI/jLp3Xu7NSsy5d+BBcwgLxYkcFhtrJlfnkt9k/JlAOXJPHLbA9nHLDCeqDveMIY+ClpRMVm3EZbaFR5VfrmNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468945; c=relaxed/simple;
	bh=ALE6JfSX6aZwHJAwYpZFE/bDf1WRPDKKVVZaRFpep80=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YnQ46Au7NAoRvwIPMnvGjXX9x16IRVDlFZfj7pKSxNjpecj/3QJPmdLfs8xE/ZUlTTWyEgAUTwdVGtHVOo2ENAoLd+0NVyNIyqTa27xJCQy+CcAzdLEIKVO/ua8Tg9qYgm/ojrma7cbY4R+HcNBImb7uIs8K3lvGKRWAIBFRwSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zF4rex7S; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lf9xHi0QCNUqQDX33Edz7PDFVnGult5hCDU3pTm+f05Bq5blNXRt78AUSY41NOMuu3CedGJfJU4fUjdG969maJPXA5B/dNrd3BMiQKAjQ6q1uJnczD+6pbyPVYCf+UMqRiff8TjtLwEqnqX7KAGWui9nF/bmoKIc0/d4S+97DmDNaB3BSjQ7+kABg7+f1ieVhIY10Wbc4NlxsynsBmRcKO8jhRn3RJ5HdrRMkF/wknymyLk2LHJo4/ZAkzSEtjz5baTYXZ347TTWOH+gKdOA1s8OGyRT4VaAWPJtuYJ9rv1gF/+T1ims14q6ZogccimbsmD6wHQyciKYcE5O+GOldA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ca8AkeLuqhVtooLlvja+NozjMg+iAwH2uC8qqoY4ajw=;
 b=BRQXlM7iusvxykDebSdRAGaMMj0MFchG3uNyWNJD+ShQe8TBflFFBV+ewQsSrAR5xSAAvtm/p4/RcjHt2JH665gKao76D53mHQ/M84PxGFFm0/wzpo4qb3AFL4oE1xZQZSRiIM4Rbw4JR5Uwu/QKlpYSmAelrnIyPxQmmG/qXwIfUG+mS21QHcFL3Ud+K6NDac/ntrvFuViVcFOznFZNV4YgcbHg2jVk8ado58iFxmrKLMk3bN49PtaV8+AN0YgTgkm7Tuo0KWrpKxT5L4JGnZsz1gVyQsi8xFE8XYkMKGN7QRZDAqNhJjwsYM8rN1loWSqWBTP/WSFa+LjnYlqX1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ca8AkeLuqhVtooLlvja+NozjMg+iAwH2uC8qqoY4ajw=;
 b=zF4rex7SfS4XLtQK0jDVGg8hj4KY3dYhRt7yFUnU4NivtyciIqwbS74mEh4UCqtTgAB735ohT3gqBYxLH6xweomfEPwO8PTgLiS08r8LRgCazrngqOPo8+t0KWSzDiA58Ijg3aawXq9WRRvZM8OrpbZid3ox0hlX8zWfgE0CVjk=
Received: from PH8PR02CA0023.namprd02.prod.outlook.com (2603:10b6:510:2d0::15)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 09:22:21 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::2c) by PH8PR02CA0023.outlook.office365.com
 (2603:10b6:510:2d0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Tue, 30 Apr 2024 09:22:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 09:22:21 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 04:22:18 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 0/7] SRAT/CEDT fixes and updates
Date: Tue, 30 Apr 2024 11:21:53 +0200
Message-ID: <20240430092200.2335887-1-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: 542ff614-d91a-4fe8-fef4-08dc68f70a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400014|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fFR+nhZAg11RqgmaVSX9d1V/bJlkA/vkI9BqOR/rK8fbb3/VungXZsI0Gqpd?=
 =?us-ascii?Q?sP2bZMKH9kjFJOx4gbTOPQ9W1FPkY4zFOSWFx4hIjRfoc62w97tU6Jocq5cI?=
 =?us-ascii?Q?PMT/VCb6Cade7fLEJfrjwujZ+5jR0Gud5yqwTC6A04sAsWmEdgYOQMGAafnv?=
 =?us-ascii?Q?kT3ghbCSyUHMs5YfS5GA2OO/iOwlZFjQYpmQAdI1SLPwMCsJQ/JFMsCSc0D8?=
 =?us-ascii?Q?1VbvT3UOUk8s0CrBi2Bf11wCl4SA82JR5UjnMX6YUC38TnCXUGtrjt0BgNCg?=
 =?us-ascii?Q?+LzRyK68BggnRI1p0krGxSSI6+VLaruMBKqBCLX/O7xAlB5j+qlb5HXx5yHb?=
 =?us-ascii?Q?YmAlRvee/YmUShFX122AolUSzH9V+AMVLJnbIep9rQz8aMAux5/jWFNij19y?=
 =?us-ascii?Q?cf+NDrTvVgbimg8BjiphPoSm577LNfZgr/S0FCF0Hn3JYvFqhla9UWe80AOa?=
 =?us-ascii?Q?slNO+lfRrBBdxe9j8NaKy1ETpgJ7/Ola2nIvivUsZuLEFTC5RTbLysISW/GW?=
 =?us-ascii?Q?mvc4dAEfnVw+CMblujZ/jIATdm1JRN3SVXqs4ld6giFTMYhfr6pLfMSD5b7u?=
 =?us-ascii?Q?YX7fHyz3+XcnLY+HY4Ab03CO4js11XIYPUqeBYkxJ3qT/fWSa6Cn/V31u9fe?=
 =?us-ascii?Q?ZVnENhV4/AMdGOn2014ufi/CkpWI/k81eFbV6qaIHN2RGXKvpUVUsZ4Zq8Uc?=
 =?us-ascii?Q?0AwzhhKN4vnas1PhMUOy4r0yK8t5bSYq0UBeJceNu4SQaNQ/SfAbkPucaIam?=
 =?us-ascii?Q?ZHQNfj2unAiqYk5Tpd4BAoh73GuAbrPTe33kwcoWzrXbBF43S0FdV0MuCn0+?=
 =?us-ascii?Q?B67EtXJXlZGSDvFchtNgOOaX02GUZ/oslz/1peXOjVlfeQYbjnSvTqF8yydn?=
 =?us-ascii?Q?gyEuYLhB404LOiczuYrSjuVxDFvSm1Nfum+/C5fnYl/pj4ipSkCT2mx4pGJZ?=
 =?us-ascii?Q?avWadYSRQplSDsFSDkOrhaIfhVZpc/Q8QAOBroTg0k6wHmLrih6imbZEr9Ks?=
 =?us-ascii?Q?2N58YGrjkuIMO5U4aJBe/ERH8oRXqpu29X1vmhNSX2ppkuC+O2gNDvSjyjto?=
 =?us-ascii?Q?wtSEO5Q9ciGg6PQ912dv8DYmDVzDPRyxeWFYdHRoBhT029bWthPUiej1GQCu?=
 =?us-ascii?Q?WxJ/LpbTwLtiYsY/Aqwdvae7j9jgWfz7b12Lgi1WWRK4DbDffa5cunzcxPKh?=
 =?us-ascii?Q?JgL3HAUGC5aUIqshh0BJGn9l2jexg+hKzyn4E7NQEy5VuPP+L+3GpJiID2WI?=
 =?us-ascii?Q?tlVFDBvKgp3UWmtA7B9RS62k3rRTnvyIskS0BnIJN466AS4rpAg4qiURbbfM?=
 =?us-ascii?Q?z5L8k54EIh2ngcX9VxsxY8ihM4uCAOFDm/oeTJiiRU8zDYCYbNFl9BACfuN6?=
 =?us-ascii?Q?lL+iDu1nosWLPldO9g3bhBe/vjZ5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 09:22:21.3836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 542ff614-d91a-4fe8-fef4-08dc68f70a11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106

Some fixes and updates for SRAT/CEDT parsing code. Patches can be
applied individually and are independent.

First patch fixes a page fault during boot (fix as suggested by Dan).

Patches 2 to 4 remove architectural code no longer needed.

Patches 5 to 7 add diagnostic printouts for CEDT.

Changelog:

v6:
 * rebased onto cxl/fixes
 * fixed 0day build errors in patch #1:
   https://github.com/intel-lab-lkp/linux/commits/Robert-Richter/x86-numa-Fix-SRAT-lookup-of-CFMWS-ranges-with-numa_fill_memblks/20240429-205337

v5:
 * dropped: "x86/numa: Fix SRAT lookup of CFMWS ranges with
   numa_fill_memblks()"
 * added: "ACPI/NUMA: Return memblk modification state from
   numa_fill_memblks()"
 * conditionally print CEDT extended memblks

v4:
 * updated SOB chains and desription
 * added patch "x86/numa: Remove numa_fill_memblks() from sparsemem.h
   using __weak"
 * Reordered patches to move CEDT table printout as an option at the
   end
 * split print table patch and added: "ACPI/NUMA: Add log messages for
   memory ranges found in CEDT"

v3:
 * Rebased onto v6.9-rc1
 * Fixing x86 build error in sparsemem.h [Dan/Alison]
 * Added CEDT node info [Alison]
 * Use pr_debug() for table output [Dan]
 * Refactoring split in 3 patches [Dan]
 * Fixed performance regression introduced [kbot]
 * Fixed checkpatch issues [Dan]

Robert Richter (7):
  x86/numa: Fix SRAT lookup of CFMWS ranges with numa_fill_memblks()
  ACPI/NUMA: Remove architecture dependent remainings
  ACPI/NUMA: Squash acpi_numa_slit_init() into acpi_parse_slit()
  ACPI/NUMA: Squash acpi_numa_memory_affinity_init() into
    acpi_parse_memory_affinity()
  ACPI/NUMA: Return memblk modification state from numa_fill_memblks()
  ACPI/NUMA: Add log messages for memory ranges found in CEDT
  ACPI/NUMA: Print CXL Early Discovery Table (CEDT)

 arch/x86/include/asm/sparsemem.h |   2 -
 arch/x86/mm/numa.c               |  37 +++---
 drivers/acpi/numa/srat.c         | 207 +++++++++++++++++++++++--------
 include/linux/acpi.h             |   5 -
 include/linux/numa.h             |   7 +-
 5 files changed, 176 insertions(+), 82 deletions(-)


base-commit: 5d211c7090590033581175d6405ae40917ca3a06
-- 
2.39.2


