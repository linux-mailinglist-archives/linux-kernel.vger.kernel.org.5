Return-Path: <linux-kernel+bounces-157242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A838B0F00
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2DBC1F2231D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF8815FA81;
	Wed, 24 Apr 2024 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5n7LpMgw"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A2815B158;
	Wed, 24 Apr 2024 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973754; cv=fail; b=p5u4MQstKfy9oksnvJ/RQHYRoRvdA+3sISVIr8ScqFO4iBRgTBUDVj30LODpDaW1QzYdtEc3YrTRoh0am+RkUPJ6mQKMSTx1PvESyCsW4zr8aC8x7TJRanxReT6A4AvsfCFDfpIbLx6NTIC6/0vRuYlZiwKq/rGC/ljakUD6W8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973754; c=relaxed/simple;
	bh=WkeSU27yKj+LZ4qjzIiDoUJnqt7Hlu0//dH0Ek/io0c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XzJfs1EdACBoXPYvAnDcnjFbWNJka3whHhJequ42WwPbHdZBa1EQMr3vwjdFKnFFYBuUpmL/GB1+IQF12Bp71/4KoxFhe/V65Yd6GbGT+XoHX5gg23OMBJGNCjVP8+CvibgfKo4m1ZTC0dtffAsqx5sLeVR4D5G+1Cd3rHzV1lI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5n7LpMgw; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lz5+RVmB2KKm5/id+07u7Nr2+pS/chlnaoiBruEu/cw77S1oJXy83Mkd0d5IwEEHKV2azzi1NvIoyl4dtSteJ3f/7xcCehUcQUBlpsm2tejDLQiIWmRTLPkuOPg9lYtM2uMVF5g+ykCNeNnEWeIhZRcIbDkMLQsM1vWAaAzOSOaES2KXFiD3v+Dh1TceBNuJ63voS+O0WKsJWVK+kxjaS1/qUDAh1nrYWmGlTeGxtuOTmVqTkxhuAA/EtL8ZHF6wGkk/eVol4X7iZ7xwqmEdVLGffUIUz2dT8RfhEbXDwOXCNzbcVXLxMEIztsUw6vyr15/NEhKMUtE3M6rdYl87ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqhXjPKXeUXEN5h/L9jmBrnHveDwd64OtdIZppYghdg=;
 b=d0/ikmrkUif6wzVjKb6TgM+Ee7kLZXYVPCSkqwT2pTdQYV5sR+or2di/d4hRM1oGQwzIyyfo0FyGD6Nf8wjNh6I7zU6DqKlUy9ygLobZB4lTpZ7l5densKShv8zsHaW/RFR4XLnE/zzGldReZTX26zo5hvo5M6CeljoBE+nWmEKolJqChkP8XF5D+cYRfEwf1/tCLHxFDpIsC4dOs+Ln9U6FfufGoQh+Z985arQ2XJ09y4s9SWV9cip24FkD9jBRSoaINpgI3w/d4s8AFX6P+T04z28GGcjTpRPtZP8H7B5Svu5pR078RNdzoS1E7RtGw8L3XvgUXlhcr4sSm4lw1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqhXjPKXeUXEN5h/L9jmBrnHveDwd64OtdIZppYghdg=;
 b=5n7LpMgwc85oYfLNTAGEGQe4E13D0/5YbLrStKNH+P0OPo4AslYgO/NpvJrQHu+zgcAStGOE3c1lmxfpTWyNdr0d/S675MbY0c5BCBARWTAWtSEg7KbV17P6lOspAZhcB2Ij/7KN9J07b3WmBgcvGkBbiyYdQAny3NQNHvvdhYI=
Received: from MN2PR05CA0021.namprd05.prod.outlook.com (2603:10b6:208:c0::34)
 by SA3PR12MB8046.namprd12.prod.outlook.com (2603:10b6:806:304::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 15:49:10 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::32) by MN2PR05CA0021.outlook.office365.com
 (2603:10b6:208:c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.10 via Frontend
 Transport; Wed, 24 Apr 2024 15:49:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:49:09 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 10:49:04 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 0/7] SRAT/CEDT fixes and updates
Date: Wed, 24 Apr 2024 17:48:39 +0200
Message-ID: <20240424154846.2152750-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|SA3PR12MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a2f883f-695e-48cc-395f-08dc647614dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4suCIq8ThvvXQzYDF/EQwQNliPDI27H8NusHoTtkqCdVrtZwAyO+UjPZrDi1?=
 =?us-ascii?Q?Pn2Svga4M7q50nQwOpbspgC9pvGCRQHwbMsJNLfv9bYXEvkPFe/Tkr5hwmvQ?=
 =?us-ascii?Q?0pKxrN+31raspVhNFMOCt/IZnX4Aw+RCefYUklmqPj/Eh3irboL6w94foI50?=
 =?us-ascii?Q?+Cs4fs8MFlipp8xMWYap9a4XEGsaDq9GDB3S1/XP72UmSdsEz2NL3pgAQaVe?=
 =?us-ascii?Q?WYknhfn1jLkwE5Y1hWjKCRzJ6F7aQPa1HNtCSK0lSdH30pQ1IdRyP8P/2YbB?=
 =?us-ascii?Q?CjB/c7zUfrA9oUwK8GrgK/6jbV8yHl1LGo4txQ9k4drOUUcetsiVcmrS0ZVa?=
 =?us-ascii?Q?JSFewG9SQe7+DwaPtZ/1HGqrmmWtR5EV0dZA+vDcOeB56fbBGjWA3lluVRxS?=
 =?us-ascii?Q?QJ9n81wb5s8X08c6YWOuX952YW5XYYbSyMhr/Ss0dm7uVePbZ1d5yzAmsZBl?=
 =?us-ascii?Q?K3Lmpn8Ujz5BZ+WyucTS+QOHh9VG31GQ9HPFwqGIothQ768i2udc92Yw4bc4?=
 =?us-ascii?Q?DSmesRtqW1z9R9FI7YbGPXY88oEYEv324FXQgU/StAWlt4dwStRRGeTXC3rd?=
 =?us-ascii?Q?gH1t96CWhWJRmYP4R3VnykijFzIxEFbESlECrZkFJiG3bk8Cwxpidgx5Eu1W?=
 =?us-ascii?Q?O7VNXz2sLkxepIZazYg23jGEXN2mlQEVxgB6iyg37IM2SvuCpOWtDdhcUjIC?=
 =?us-ascii?Q?/0Zm9YKLb+qE8KN9lGmiSEXTdOxU5Y3If83K7FcfmoqRE1HUINfUlF9TlmsO?=
 =?us-ascii?Q?UJqIQbY6oMoweSvpu/bb07P8SLCsM+xDOEr8FcQYmW07IClyRRh6Alp11UI3?=
 =?us-ascii?Q?zCAuyQ08JebhmeuA7NxDqwVs0cl9lpBBn4wjFA9HRY32c+Q0BayabuA+78Lu?=
 =?us-ascii?Q?+WQ7uXQ1qtPPsVRqLpce9NpDQQzAl7ow6aHITjYaTcH2qPtgnitNuX5Yvp+S?=
 =?us-ascii?Q?O9ODmgST0YCrwyCSKcPQVjgMeACQUDntmSI5OR+c0uUDHH5keRxA2BYmPF+n?=
 =?us-ascii?Q?qxjMW7t+WM/UX3O4dOGF+7JRu6qsk6vX+uxppGc/gXmcJgsLc+WtLYOxwpUC?=
 =?us-ascii?Q?cD7HE6KFWXeRjitrLYexTSTEPy7eHOtpNnkmsHkNwa2wM2B8/HV2zUCrfiga?=
 =?us-ascii?Q?KP5UMaaTIKkGjxHc+a4v4IYlUtxeIYnQ2qm2xc45waXZgZ8+k6CrG//CxEYx?=
 =?us-ascii?Q?txwZZcfX32WrbGmlbPDlwmoBRdVKkNKO7JkMQ0zExqCDqyNPXbfbsbxsNPVI?=
 =?us-ascii?Q?BqUUi+pN306yWWRpWmBG63BxjE0Sbp1QnyRkC3OlgdgpbQcKb1jPkO/C4ENj?=
 =?us-ascii?Q?xYO/SJchUrhczy7bXThYjKDiZrcbb59WLtKW3xbZ78F0ov5mqIFzsjQsl9L6?=
 =?us-ascii?Q?XRjA2O9f8yOLcDY9N64gTcskyj46?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:49:09.8260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2f883f-695e-48cc-395f-08dc647614dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8046

Some fixes and updates for SRAT/CEDT parsing code. Patches can be
applied individually and are independent.

First patch fixes a page fault during boot. It should be marked
stable.

2nd patch reworks the code around numa_fill_memblks() (Dan's
suggestion).

Patches 3 to 5 remove architectural code no longer needed.

Patches 6 to 7 add diagnostic printouts for CEDT (can be dropped if
so).

Changelog:

v4:
 * updated SOB chains and desription (Alison, Dan)
 * added patch "x86/numa: Remove numa_fill_memblks() from sparsemem.h
   using __weak", please check note on authorship (Dan)
 * Reordered patches to move CEDT table printout as an option at the
   end (Dan)
 * split print table patch and added: "ACPI/NUMA: Add log messages for
   memory ranges found in CEDT" (Alison, Dan)

v3:
 * Rebased onto v6.9-rc1
 * Fixing x86 build error in sparsemem.h [Dan/Alison]
 * Added CEDT node info [Alison]
 * Use pr_debug() for table output [Dan]
 * Refactoring split in 3 patches [Dan]
 * Fixed performance regression introduced [kbot]
 * Fixed checkpatch issues [Dan]

Bases on v6.9-rc1.

Robert Richter (7):
  x86/numa: Fix SRAT lookup of CFMWS ranges with numa_fill_memblks()
  x86/numa: Remove numa_fill_memblks() from sparsemem.h using __weak
  ACPI/NUMA: Remove architecture dependent remainings
  ACPI/NUMA: Squash acpi_numa_slit_init() into acpi_parse_slit()
  ACPI/NUMA: Squash acpi_numa_memory_affinity_init() into
    acpi_parse_memory_affinity()
  ACPI/NUMA: Add log messages for memory ranges found in CEDT
  ACPI/NUMA: Print CXL Early Discovery Table (CEDT)

 arch/x86/include/asm/numa.h      |   1 +
 arch/x86/include/asm/sparsemem.h |   2 -
 arch/x86/mm/numa.c               |   4 +-
 drivers/acpi/numa/srat.c         | 203 +++++++++++++++++++++++--------
 include/linux/acpi.h             |   5 -
 include/linux/numa.h             |   7 --
 6 files changed, 155 insertions(+), 67 deletions(-)


base-commit: d37a823e8ac01a2f657eed7aed8ea7e515c5f147
-- 
2.39.2


