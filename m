Return-Path: <linux-kernel+bounces-162281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D028B590A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC281F2698F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2105353807;
	Mon, 29 Apr 2024 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2B+M3LEs"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17C810971;
	Mon, 29 Apr 2024 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395023; cv=fail; b=E5btr2MtQH6q/SkejtIC8b01Q6DwttBZ2M7u3SFepNbRhNOtZPf0n1RPiXmKXmurdRSUJIy0TmWW3s8ZcMWea6JDRm+w6W3Alrulifl4HJU/YDKzUqLAko97F5t1djP9VjQCVsRDVsNMw1KtxozlCD+T/AbyYoyKykeV0MxItT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395023; c=relaxed/simple;
	bh=o/1zOvfRw9xJaJV6WJRFaawA1eV8fvGOQn3Kqpo/LzQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gqv8Ri/d+oYNGNBt1Hv0Hv4Eb59hyrXzDJG0DXWQNtYEdaVYncnB4C+4iFw/rLLWBny+7PCWZk7yBarKIOKopYNVdWQcs6n9x57jDrbTazah3VFdN0TWg42uM8WT7PtjCqqJ3+3ENbYVV6MiSEODlo9YHjzdsPHRnNBS9Dbbr+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2B+M3LEs; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IC9Nc5iR/JfhWlsFBs8z4zfi0vyPc35610pTfoYgLK8VAO+u+ZPf4Z8qUQ8uZxp4OvQR6vQZo1200Y4LcY2+h6EVcUED8eJdGy2ckJ8HhUYxaK2F4WIpfvgsBavgWgajAVZXNdZF30xU4mZ1nDDM/4RUnPBXPcku9YvCKkd2AbN6vl8qrhKUD8pd+96QUl5dQSxJqWBIFwLDlzlL0Wa5ulbL51CaaTMFL0zJ44EhmzBueBJiYnA0SQkjxbBDpTPccY07MesWgVO1U94YiEux+25dXiLkQX7pABwyM5Rtb2Ct9PZu9kzw525hfd2hugnb1P/tvDZ6R0ECJyoYPypSQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNpZGOFKX5U8FZY1CdMFdMBag8VFSMtpgu8iPZCyPjU=;
 b=VF2LQI//Kivj72Z9P3tm+VIbxDJJ1uXia/LzNha8l352xK8VAFRflzUbBGLW4A9U/q2kg5axYAKGXn7YLw07i1RUdBPsg3oYT1ZRcdHsf2PR19ZEfZTRX3TYNSxbPm3ISBbF22HF4SRluW1BAP3n2xpqCjlhEBqVgNwzUfw+eur/QmWM0HtMFbt3d66dVD5TEdK17ZhrY661WPvZTqpGej3bHNlhoZEJ1qMCkMbxxmvkcQN3hEdpuixdjamaJmJ+cU7hVl8KDnwlkfY2n44YX0jwxLwuYXRVLdAyv4VhZnKgJ+MdvChL3JtDodLE6l6cD8FgRGIUvqEjq6sj7r1Ryw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNpZGOFKX5U8FZY1CdMFdMBag8VFSMtpgu8iPZCyPjU=;
 b=2B+M3LEsnqcfX5w26ueYhKzTtgFJzws+mMXc+jk680kBIE3XRdS8aJqILKi1LRbethOgZKq9eOrxL72a1GV1Qacr+mIhpjB6bUnrsZ6ywZXBs8RbDvSEKFPsPGfijWBo/vFVV86jUl8LoPpAH3oW8KSv8/haGcAGeSmdynOTRJk=
Received: from BN0PR04CA0108.namprd04.prod.outlook.com (2603:10b6:408:ec::23)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 12:50:19 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:ec:cafe::88) by BN0PR04CA0108.outlook.office365.com
 (2603:10b6:408:ec::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Mon, 29 Apr 2024 12:50:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Mon, 29 Apr 2024 12:50:18 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 07:50:16 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 0/7] SRAT/CEDT fixes and updates
Date: Mon, 29 Apr 2024 14:49:48 +0200
Message-ID: <20240429124955.2294014-1-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|DM6PR12MB4340:EE_
X-MS-Office365-Filtering-Correlation-Id: 900f393b-1913-4e3c-692f-08dc684aecb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400014|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8NI4dDDA2u+oPEWcIBoE7vchVGwA/xbxD54qNV7VNAdxeV1Sb633DJVLdi/B?=
 =?us-ascii?Q?wy5TCDqM3OOr2ZMi0FQNi+gqWfS8ffm6rfsF6PDb2QZCJi/SUpGKX4DpaaWm?=
 =?us-ascii?Q?2mh3OpABYBX/8VGUB4ER4DmMzOtl7FzVAqOQWhv+0qBBkZwTMN1DTPELIntb?=
 =?us-ascii?Q?OFhIP7+Ytawnxh4QPhW9Y4gUHJ3aPkHFj+o5ZpXQRcDWn7uau0tPtXF9Psnu?=
 =?us-ascii?Q?etna2LWq5lLVwXIOOa5FZbnTX+FYCFXN0nHe3Nemb8c33q/PLCWPGSMjB0ze?=
 =?us-ascii?Q?v/9SQ3WDB6MBZgPI5k7wWe0Qpa6Qnhv9mIAYNAZPE5dhgBdxOFX9Na8qdzJy?=
 =?us-ascii?Q?LVyrHost3tffWVw5S11Y0KpaDVZ1tpz7+vorgY3vubAN4g9lpRmbZRVANQHr?=
 =?us-ascii?Q?Xtzfs3l3gJ4fMEVpwv5LzhKa5kYPR+6+sDn69vG38sdAvqatCEV1WX1cgaTj?=
 =?us-ascii?Q?lVezi6ddcRDXNlwnuqKcXWgea5TexC2AU0JHRnr5fdm27QCsU5PPLFwTAW3/?=
 =?us-ascii?Q?kSbOeHS2zznuO0L3vDOnrJF1vJMhjW0rfjSRbNVHjn/WbW8H4Wxv8PXE9VYS?=
 =?us-ascii?Q?SJYwsakcIgSr6oY5N39s5+WdFRksuie6H4kHfPCDqg+8Yp5vv7uEjzo2RWak?=
 =?us-ascii?Q?m53Z1veVRMw1dT6CwlA6T+/yrqw0ogsFLJgosaB8odGBPqKJSLqgRQlXGQV5?=
 =?us-ascii?Q?ERYWIno1rwxd7TrOSXW3BSOipP36zehXQ0sXggBsTgB9YnzIjLr/cZ8rcNBJ?=
 =?us-ascii?Q?aA73+ILHPWWBP5s3Oh5dY79N9NbZ9otzNbc1Izv7kZ3EeavJbOjXawIsGXoc?=
 =?us-ascii?Q?C/odm58vcJQZNAJPXE5rvgqXv64rd0+8bbpGzPPjSNMHdcDiYSQVo6CgU8uF?=
 =?us-ascii?Q?RDlP+Y8+1bbuDmRSm6DyTuLLNwBigwaCHzPLW8QqkZnJmB2p2qTIqxQaVBtd?=
 =?us-ascii?Q?U3zE6J5JPY12j4XDeX+qITcQ84Rei1eSjX0tBzQ+crQleqWXLCSLNcIhZaiv?=
 =?us-ascii?Q?5jPQvmhU5dbw1D1xoK82dpDipPAXsHQ2aKy93XnOV4c1X1O/dt51hgsxEHR6?=
 =?us-ascii?Q?cUxbGF2/UOHZ6nabbyyfTNUnLn9ZjB+paaCtRM3ubGV0XM8a1xEbSlsL755S?=
 =?us-ascii?Q?zjnrOeFZGX2toOWt6AXWiwKjJWTUPV+WLpfV9vDddQ04XaI3Z+nuJVpNkRud?=
 =?us-ascii?Q?ipq5WHc480isD+NQlz6s53tiyA9wWR/E7fPl00iFLR9oqvpeJvBOA9oFeI3F?=
 =?us-ascii?Q?OCpfYwHuUur9t55EtDnPWT1etLbjl5g3qMBFcCqUiZagFhqF4i7iS+yDDyFM?=
 =?us-ascii?Q?7SZkB6gvNUlhT62saAW2keFnEoXR5xeA1E/YH7tqYR0Rl86TEPy1jz1YuYCZ?=
 =?us-ascii?Q?M5ugndyfg2Hk6Zv0082RrVOGR7c7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 12:50:18.7766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 900f393b-1913-4e3c-692f-08dc684aecb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340

Some fixes and updates for SRAT/CEDT parsing code. Patches can be
applied individually and are independent.

First patch fixes a page fault during boot (fix as suggested by Dan).

Patches 2 to 4 remove architectural code no longer needed.

Patches 5 to 7 add diagnostic printouts for CEDT.

Changelog:

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

 arch/x86/include/asm/numa.h      |   1 +
 arch/x86/include/asm/sparsemem.h |   2 -
 arch/x86/mm/numa.c               |  37 +++---
 drivers/acpi/numa/srat.c         | 207 +++++++++++++++++++++++--------
 include/linux/acpi.h             |   5 -
 include/linux/numa.h             |   7 --
 6 files changed, 176 insertions(+), 83 deletions(-)


base-commit: 62dba604a4883169abf959b7d09449900e7d4537
-- 
2.39.2


