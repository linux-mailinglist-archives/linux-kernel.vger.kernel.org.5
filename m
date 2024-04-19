Return-Path: <linux-kernel+bounces-151528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DD68AB017
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA161F2454A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2AD130A61;
	Fri, 19 Apr 2024 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L+xwa0/x"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A0C12D76E;
	Fri, 19 Apr 2024 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535357; cv=fail; b=tG/iP6Yp5mioiWzamScvtHm+ouFtpXEsM3J3B+wMyxtWzqb2acnGTO91+y89K1qP3M4TKrZU3iYMLHAsG2RavfRJusyRo1bZbkSpf+tUCU+FBHIw8s5fDfGnM6ZtXdJSGwBAnmv6Oa4jcevRnGgwj1YmW1MYPkCI1j3ZFKRKE88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535357; c=relaxed/simple;
	bh=mIYKxi6BsOayDBptA2OeXrsth/N28wBrtDKOjtgD/X4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qBT4HJ+Oexp7Sr3idCNLBjBt41iWfbON24mwGv5ULLlA2Ud1wpeApugsfPiAdutRoMyjhdZ0cUwhKMPxPQhiomnmN4y9rz/wyHaBLQsyT9bWEcAKY8uFI0yZgp/eXD5M6zFIhXKvAQcenn1mbLVdgdZv37Zb1WzTGAVqvG5lYyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L+xwa0/x; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WcIrplutusplgDtT3+bc4udmcRl3A8V7jI3f07CHmt7iaZzgt+i5+/0VToZg5Vxqzdc+RB22ZSRl373iI7BEUZfHNRyenkXS3T97ERdOpWMjB5lIGIydll7D1xy+aR8WFPlW3uP8KpUZlqDRmg++88LZ+E4Z7mERkzyUExeBM7++w07kiMk99sF5uPSOPgCWKuFTjSxYzGxPPitdeec68lJLeUVRSqi0eDsTDuxOBtwl2Eb0xaNtjiH2z46UpgUp98eJFSxH1ysiA2ki3P3l/TJkBfDJzjtJOVW1p5ZeBpJ//A8mstXQAV8HV2WGHEADO2Z8eyNaQQYVuormE0cnDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eyh1TDynz2Je7q5y/9GMNs7wZxU8h+6c7/6IfPh46fU=;
 b=DwalPnE5dCiSoZe7EajMjkSQueHXW9nDCq6Fhp1TQ5lmD3/Fy79JnqVJyKPqxrs8iTQE7MZ4RZhHoUagxLMUkTLunBlG0E0xgUbLU1OTGpRZWD7Kn+4V6eZ7Nc1q0oGUt6dVJjkRqVEYt7frlCSRSLj3oIl8kS5ObbYATwoGOWSPFP9BvS/i0Dy8Yj/2roGRVs2MkAGTjVpw6nH04JBZSERWUI3vkJLR70U7owQGQgxi34I0PGLeHc8qxLTzSO82TpGKbyUFjrJEuha5nhBkYPh/uQB++Z4t3a0DICklV7nQpndK1aUDnU2uGrr03Q2cjfx4c8VXwKSQo2y4xPGGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eyh1TDynz2Je7q5y/9GMNs7wZxU8h+6c7/6IfPh46fU=;
 b=L+xwa0/xvBPv188roYg2e0fm01LWn3JkHkpqklMed9Xgit7upAC9aytgpH4zbGY59m7rQEfGNwwapRPVz0Ior/AugnyUjGK3FbtoA2AolS+htU9ZC4dsldK2i9YQsePLYQg08yXHTP77RK8Y1nTlHV/Hcxxa77DgeLRhKK/l5Mw=
Received: from CH2PR14CA0016.namprd14.prod.outlook.com (2603:10b6:610:60::26)
 by PH7PR12MB5783.namprd12.prod.outlook.com (2603:10b6:510:1d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 14:02:26 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::df) by CH2PR14CA0016.outlook.office365.com
 (2603:10b6:610:60::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Fri, 19 Apr 2024 14:02:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 14:02:25 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Apr
 2024 09:02:20 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 0/5] SRAT/CEDT fixes and updates
Date: Fri, 19 Apr 2024 16:01:58 +0200
Message-ID: <20240419140203.1996635-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|PH7PR12MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7c58ce-9fd4-4e9b-f842-08dc6079578d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6r+gdEsXttozKe0pPXsPRXcMKZ7+imHcBSnj/WpE/+tGvyk49m+U8xubeGVBmHDOligpCxsxsDx9e672GY9uEni/vabrmTCY9Er2f9Y1mnxvrdA10TTLfsVwiuGJvIvFU8JML/c9s4+93lLmmnGwOjunQj7YDm8tXFdaY83dCcO86OqHvCKVN5Bu4B9KFw9Mf099db7juO0Bkmj/jRkXTsbUYU0wpiULs66dWUReiHfAooS1SILAD2T2/oeFjfXt2c8ablp2BuHZQ2Ik+Ym+JT8EMrcCU6k8Mya31cTR8/7Hlt6NK5yzAuS27HBdj8DPbLPhkEeMd5XTertU56aMC0VTQVLvxypIfjVqLRGfx5OoGYDRUw2t0KmAqTLl3YcI7Iw2aI2TEE9e97i70mWGrieeoZPpQiS/iTU4FRhtHSkFrAbLZ+hT+YwP1kI+Tkd6RA5O36VC9KbcwbSpVngSFX5PfjTkj6+KbG+o+XLU3qrZ07Iggkci5ibPB+db5Es4RU+fRlpQMKiGcXkYcsy+gjtHXuvN0t+FgfZPRfqs4/yyhwRBE2LdBNZT5pAiSo1zrszqh/IJNgFPJ3hyLpRRt/O4QN2MhkqE0ZZucF3E84IOZQw/RnbgVsL25d1b3v1+nNQidES7PZKpsH9UDNp8Q+90tWoM6WQx1wBWu4tO8z7XnLF7wgG079DlQF+pyOzySsewFkQloVcwAqoSTTcKMaK6OAYh85ybpdd/FdLBQJyG4uxbntM1fPN423f0PP9w
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 14:02:25.5061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7c58ce-9fd4-4e9b-f842-08dc6079578d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5783

Some fixes and updates for SRAT/CEDT parsing code. Patches can be
applied individually and are independent.

First patch fixes a page fault during boot. It should be marked stable.

2nd patch adds diagnostic printouts for CEDT.

Patches 3 to 5 remove architectural code no longer needed.

Changelog:

v3:
 * Rebased onto v6.9-rc1
 * Fixing x86 build error in sparsemem.h [Dan/Alison]
 * Added CEDT node info [Alison]
 * Use pr_debug() for table output [Dan]
 * Refactoring split in 3 patches [Dan]
 * Fixed performance regression introduced [kbot]
 * Fixed checkpatch issues [Dan]

Bases on v6.9-rc1.

Robert Richter (5):
  x86/numa: Fix SRAT lookup of CFMWS ranges with numa_fill_memblks()
  ACPI/NUMA: Print CXL Early Discovery Table (CEDT)
  ACPI/NUMA: Remove architecture dependent remainings
  ACPI/NUMA: Squash acpi_numa_slit_init() into acpi_parse_slit()
  ACPI/NUMA: Squash acpi_numa_memory_affinity_init() into
    acpi_parse_memory_affinity()

 arch/x86/include/asm/sparsemem.h |   2 +-
 arch/x86/mm/numa.c               |   4 +-
 drivers/acpi/numa/srat.c         | 198 +++++++++++++++++++++++--------
 include/linux/acpi.h             |   5 -
 4 files changed, 150 insertions(+), 59 deletions(-)


-- 
2.39.2


