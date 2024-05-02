Return-Path: <linux-kernel+bounces-166486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4CB8B9B55
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 699D71F239E8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21EF84052;
	Thu,  2 May 2024 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RRxg/f9X"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E42C32C60;
	Thu,  2 May 2024 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714655437; cv=fail; b=NY2zn4H7ExuBP+aerl0il+gyQ+dfVE/YsPagc0PcEsfwLNFTd8fwdyhrjwaltcZsGbRnp3dt02w1nlsxUQgZoHkZaiKJJuOtHDngKPEiil7V5w3oW15l0m2bJUQ25zjiWORTzpm6+pdBedkig3y1N8UHAcXl+fJt+gBGqsM4Ql8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714655437; c=relaxed/simple;
	bh=00W5juSoKcwkhEp72jV05qml+g1duorhzyYB8KCvIUc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HzbCAug3oltVctOGYGc7CCNcoVl7ny2fqpSRWrHt23z9U0LxXvUHBkq7YkLr9KZI3q1bMNVtrS28Vx7yWcg92P5Y5lf8fm5vtLSADLG8h4128Qk2D5l2BQHq7SrBTxzyxWUg3ayD0HEvxRP4RZd1v9thWy2+qasg8jr+34Q5uEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RRxg/f9X; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DT9NvI+eClUW2cR6NulFFYvf2ZsFHeAfqNiMZ8+ZYoQNMuqaflJfI4VuBLAjqREhscgyGb4Z0sruo6N5e0DguHcDRKeBVm7wJbXK7RVWk2ysGmgdeTV4niFauG+Zs5chTsNvxBNLyZpgEA/hdBpIh5Egx9Qgwel1lUSkJ4XFdYBulr1IxARHuFv0DayVZWcvwC7ZxCSrV9JxrNlyHZ4S1MPLB02faDpIQfuUeudz6zsQTRr50pGju6n0tNCKlLh0MdKyPUJz0gArGBhptrheSbmkudEIkooCxEH9OI2HMVNNXCl1XTCDILmusY+rNMV7q6s7Menfyp5z4fPAyS7Ntg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtnK0y6qGXF0nRccMRtT4Z26QalgCxHwXZxGW6kRTqs=;
 b=aL71+UCQIB/T85wvRYWheeMvuFZznw+JWxLesOwXScP5sFyVl5Ba7jmCsZGTyzU3X2WMFvFINS6zUKUMlYjZcz5AQRbZ6LjW3FGS0ciipMWYTHlXE5nQ764Jm+Jf1GiynN7oDdnTqF12WB7bMV8dgWBVY0irE0lj8Ad8iAassMVz78Vp1eD1gEaCkE3SumZHFJBXvMLVteagTWjphUJ5jH/NI4tWihlfHFkinv29MifMYH1BBY317tdfPGxPYt4Fp90OgfUUvY5JMyMUFugocvMJOZMKZZEInXeGZj9DP0oW7wWMhw2upd+TxfcQL8q5LftcjiZi3VZ4h6/ZCED14A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtnK0y6qGXF0nRccMRtT4Z26QalgCxHwXZxGW6kRTqs=;
 b=RRxg/f9XycE4ywIe+7KFI/Fp1fCAJNxkPYKY+8m7MJinnb78QyhGf8HzMfltU+NmO+DlA1N+8/BczjvPRUmfDz7I5XR+VgVHy2p74ugfMu4fu721zj29iNgAEXb5YaeGfWE641dVF/0ElTtZEqlZ4PROq9mwHPM+PDBTHpT96wo=
Received: from CH2PR15CA0007.namprd15.prod.outlook.com (2603:10b6:610:51::17)
 by MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Thu, 2 May
 2024 13:10:31 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::ba) by CH2PR15CA0007.outlook.office365.com
 (2603:10b6:610:51::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Thu, 2 May 2024 13:10:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 13:10:31 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 08:10:29 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v7 0/4] SRAT/CEDT fixes and updates
Date: Thu, 2 May 2024 15:10:08 +0200
Message-ID: <20240502131012.2385725-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|MW4PR12MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: 71cde2b4-d54d-4c1b-b8a8-08dc6aa93ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?txe51iuvX8B4U9vyi7NfhjCxhNrdS02Gl53zurVDa5wNZDgR5RgAERQLkY7b?=
 =?us-ascii?Q?X7Ahx085u7vwN2TX1PWZEM0dISnscUHpitestnH8kVKpVE5wTChiGSku+kXz?=
 =?us-ascii?Q?s65xbNV+xmDLj9M6e0T/i6M5IlX/bETwFuU9hZxOUKcmy/+d9rNtxPuJ52aX?=
 =?us-ascii?Q?muzB/QZsq69bvTbvpd4Lx3p5ZoA/1C3Z6Ngh3rfH703T0v6bzNu0Fbk3/R+p?=
 =?us-ascii?Q?p//js/T3C2FJz8ywF0YjMUwM15w0vQ6fGVKTnAZfd2bDXm/mDLuop1gdUrxQ?=
 =?us-ascii?Q?ZQFNpBbMl+wI5+7teDgx8BzRk63qVLgfcnCB+Y/Mt9G8g8jJn2F4zV27AQJA?=
 =?us-ascii?Q?SSmv5UO5d2lCoZVv6fwIamgEtIX8ypo3D3YJFycmNQemyp5ya3x1+eAOgjWR?=
 =?us-ascii?Q?ns0gw+koYGcXH2zpAch3ZgfaPBK4gOlS+vtqo2O2k16xTjIWrMGuifEqkkRC?=
 =?us-ascii?Q?67Vc1rYnjCkd8VaaxFccSfTZZZafDGrtsrBAZKflRM0n/ts8b/gd0ABzWs7W?=
 =?us-ascii?Q?Gdr6FcAVp6d8p8dYFR81aJDUb3YO4IalxJ7IRdk0oIYl0BO0F/J72Dra/Kuk?=
 =?us-ascii?Q?b4Gy3+iab0SCdtWse/pj1SmHwni/gG7re8WSAf2u17W/bTJTmKJ7ijmWJ3vU?=
 =?us-ascii?Q?/LH443rZTYTL4IAS6IgNLo7l4CccywhGXi4TXszQH/6AwEXrBdUtzABlezSX?=
 =?us-ascii?Q?KXMRuL2fmx1kNdNUyumCyt/Ce5hk/XRl5YDTw6xdZlDcVfjq6BckDuOROIAi?=
 =?us-ascii?Q?h0iTfgpCbF/Av8jAHDx5UlAQ7Pi2Y9viBDzaLFyj2bZQJeUNerKWFa6l48vo?=
 =?us-ascii?Q?LB1exV/nCCkV9xE0nkSFwCgPAPcLpsBwR0/o99c91pjZ3BVZyK9/iCXao9NC?=
 =?us-ascii?Q?ZFr5P3CkQX961zWR9sRgT8ZoGMr5dQ1eOyMWSINsEuLcldWwtxEFb3XgxPzs?=
 =?us-ascii?Q?pMts8CHFTWw6NVlB+Hs+4BWDSXAe3t4VYDf2NwB9IQRzP7Z3DwxKzqUR9bid?=
 =?us-ascii?Q?+9AXYmFnnYFR+74cVVblAU01abYScKVKrrXXu5OvMualH1eCdk9FdvqCjm8n?=
 =?us-ascii?Q?JGbEHMIhIEaSlIHsP/mOUkKk2HNsLK9wZQxsHhS9K/CpUSsAscb5rmqFZPJZ?=
 =?us-ascii?Q?HQMVZ0g09oXX1uWkgh5pIT4Djs9yAjYTmvcLZ3NZQpAfTpUVn832/xiaNmiz?=
 =?us-ascii?Q?32e6TwBnxEeeaHocByXJa5grXg0OWeoA+IcRWiJklV9wlzfgO3ePQqkQkb3L?=
 =?us-ascii?Q?m2PhKFBBDER9ADaF4kbmfYwipaKxvyzoLeMI9HiHjMOx2LiZcDdgWd/voJh0?=
 =?us-ascii?Q?9paegYvC0wybvmNTnNtSS/iDluaWawUcDrImb1voTQRR5bU99ire4fGBLZKA?=
 =?us-ascii?Q?pKHWTD1YZDqJsB5UOG9LwE1Bx/KF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 13:10:31.6271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71cde2b4-d54d-4c1b-b8a8-08dc6aa93ee3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874

Some fixes and updates for SRAT/CEDT parsing code. Patches can be
applied individually and are independent.

First patch fixes a page fault during boot (fix as suggested by Dan).

Patches 2 to 4 remove architectural code no longer needed.

Changelog:

v7:
 * added Reviewed-by tags
 * dropped printout patches (#5 to #7)

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

Robert Richter (4):
  x86/numa: Fix SRAT lookup of CFMWS ranges with numa_fill_memblks()
  ACPI/NUMA: Remove architecture dependent remainings
  ACPI/NUMA: Squash acpi_numa_slit_init() into acpi_parse_slit()
  ACPI/NUMA: Squash acpi_numa_memory_affinity_init() into
    acpi_parse_memory_affinity()

 arch/x86/include/asm/sparsemem.h |  2 -
 arch/x86/mm/numa.c               |  4 +-
 drivers/acpi/numa/srat.c         | 82 +++++++++++++-------------------
 include/linux/acpi.h             |  5 --
 include/linux/numa.h             |  7 +--
 5 files changed, 35 insertions(+), 65 deletions(-)


base-commit: 5d211c7090590033581175d6405ae40917ca3a06
-- 
2.39.2


