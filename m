Return-Path: <linux-kernel+bounces-159393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0FE8B2E16
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E9C1F230B2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E835EA4;
	Fri, 26 Apr 2024 00:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2NKrcsy/"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2BEA35
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 00:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714092115; cv=fail; b=daEYLpv1M0w+37ZsvEQoGCwaIGnmV1iggLgmfteIQ8VcotUb7hS3RyzxbiC/QVpZcSGz3P05yHH1dwlB1VoOLOGvrcdNxxqKgeH6qy5jJuSmjUEh4F/hPqUW4p2b5yMNfk1jKitfarjgjDl0QTrBEY0y/oQ4tCzsibSclLyapiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714092115; c=relaxed/simple;
	bh=IXueb3om/YmR71Cg5FUbsWfg9xmbJjC86uPJUOmX+L4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o8IrcgeXdz77FNuL92MCc8Xf6F5oNXCCm+a+ay+RoNnpoNlYg3lbucLBTfsXep8TQoN/GvLTqeTM314WBvgle2/ok0FSNwVV3rOP1LacXtOa9sP1Jsz2I7+2EVO3WM8uEGr/n+/1xWlLl6o64PXJeXlcsYCmnpVpQROMxm936t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2NKrcsy/; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuWRaiPn6X+0shma7N45/TJBUgnPCysL14HV3a6yTcRcx3S3y63mLQXcdRfxNwvr5slgYghTs0ZN27JLXnooFAQKsDU3qOZ/FOt5Sme9yNJ0QZ1qGqa3HsJ0rWa/AwGBdR0gfSYYFJtYiZSOX3NtUnVLJarBWYE2sItYnZySddbJINu2jOybtEnxtFwqOQ3yC3Xi8sOHD1RCriBKxNka1o3oLZJNRKp5VOllJOdyP2sbajLxVz0Rv4kYBVePJLh8njK/2b836jfNa8ryWE0WEvtbxHgOg7qYPca8SNLYSHB2ucM3UrIZUTYH4pYXw+Ejd85MHa5nHlVMZeyUsBlQjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpU7htbXKHEicSll8vMt/Ky9+2XNMdFtksbXyhgnOAo=;
 b=DX9hAQyoRwmcEWLvHwbHOgH57N5q4PI+rsfzuKLQZCyEMvuwcCDG7uMjLSE0WJgJxDy7bXnfD1YwIuoi95LIHUtI4pkjrNqhKXUZG01wQ8CDW10j1A61eDE8BqmEFnSHCx6Fjg9tBT3KQ6BhOt0/IE6pjGImRLgWM/f8yXeyHEN3Z+vrRR8s3OpSJTsRhmc7oMlbbivIuQjuE1FY3vsC2KStx8kI6+HZBqu1rTusCF4u1h5m1CkmPvEAHo6XxHneyQt2tlvnACSRFNiZIgkcSwkCNPlrScQ6OKddhLtlMr9UATcj1dphbc0a7csIoK7v2ypw8ocgHbnY9i9K8aShYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpU7htbXKHEicSll8vMt/Ky9+2XNMdFtksbXyhgnOAo=;
 b=2NKrcsy/WIL9zco2gYGF23BLRwRM8JBFFYEIDMKgua/RMjhdgbfU5OyBAOq49Z8yPyktclnaOU5mVQe7sQL3pJrCrqC5cZqo1ox9ADKuqMSHHo24rfpBU/vhTow+fD3Tv8Jpdme5MHDev9mYF/YpJBJ8T2sbpJoAiBt36nYxWH8=
Received: from BN9PR03CA0251.namprd03.prod.outlook.com (2603:10b6:408:ff::16)
 by MW4PR12MB6922.namprd12.prod.outlook.com (2603:10b6:303:207::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 00:41:49 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:ff:cafe::27) by BN9PR03CA0251.outlook.office365.com
 (2603:10b6:408:ff::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24 via Frontend
 Transport; Fri, 26 Apr 2024 00:41:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Fri, 26 Apr 2024 00:41:49 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 19:41:48 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<jbohac@suse.cz>, <dyoung@redhat.com>, <luto@kernel.org>
CC: <rafael@kernel.org>, <peterz@infradead.org>, <adrian.hunter@intel.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <jun.nakajima@intel.com>,
	<rick.p.edgecombe@intel.com>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <seanjc@google.com>, <kai.huang@intel.com>,
	<bhe@redhat.com>, <kirill.shutemov@linux.intel.com>, <jroedel@suse.de>,
	<ardb@kernel.org>, <kevinloughlin@google.com>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] Apply RMP table fixups for kexec.
Date: Fri, 26 Apr 2024 00:41:38 +0000
Message-ID: <cover.1714090302.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|MW4PR12MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: de07bcb7-156b-47e5-4342-08dc6589a886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N4g9XoQbdg/LpudsylvG7BiT2S5k/7hQMkZRwWQXBFYsevOkg7Cvl5fC+97a?=
 =?us-ascii?Q?FPz+FisSR0u7V5RDPChfy+dCqQEfmeL6minX83gUtTF3ir7VfhReB8DcHnmY?=
 =?us-ascii?Q?oSQw938jVui9GrEre1H09liv7HjYNysDmYdS4BJ1hnlbMkGPkLqqPYcqw9b6?=
 =?us-ascii?Q?VG7Nfrv1XQH53lG2NncXkc2XkCMwpNQpuusDqywYNmz0SBACKbctRrZg+ovl?=
 =?us-ascii?Q?ExVK2RHiSr8PvlvrVP0ygkKQnwMQPZZ1Mvotlozgec9veJKkKKw3rjHLoziz?=
 =?us-ascii?Q?ht3TUaJq4Pq6JrsSlkIWvT5Ok5w9eHfPlvkBLLPIKdgEGekHjq+gP8yiTX5+?=
 =?us-ascii?Q?Aq9gxXuwlpZd7Rtb+27m1n0ILgZSowQqCHnEinpJ17/NNAucR4l6YTLd6305?=
 =?us-ascii?Q?OwBDiPsso6Xrj6OjOcvbqSDYk0WDWRUUiL+F1pefbW6UQkcEkQPmeUUkkUsC?=
 =?us-ascii?Q?WahxqyFXCPacCYWFtQBAsOZX0kXtJgNHHjT0LTw6M+U1548lBxmAxxjpf1zh?=
 =?us-ascii?Q?FdtbJuZWauRgpq4aTR3IxCsLcpQ0flrNG8ogI7bNbzu79wB9EBMhiAi5+IpE?=
 =?us-ascii?Q?kA/1BfKcQfw1gZh11wwGTEJa3jFpQuZPTVPz+s7C8u6Un/bYX9nORtTXh9Is?=
 =?us-ascii?Q?ewqt2PrJrn4lUb2ZfFCvNcxis55dHmLv/PZ1ou0M9ivIIUg0FMR8ACxKOb/u?=
 =?us-ascii?Q?uHRbUUpFA2RYga8T9SwP8Lyj01WR5AEqxYhNC1XHBiR3QHlDBthbD22NVhyS?=
 =?us-ascii?Q?WwGevn6sXFeJn7EpowpNCACWdH93Mz3cd+XIieCubnpftN/glMvnbsDhITeX?=
 =?us-ascii?Q?G0bA+oJHzQtHuHJL2dDD0M8N2LTHHvMoK8Ic5ltJ2lgSl2imLmRjvcAU4lzR?=
 =?us-ascii?Q?iQegqIX/HwX1eg4JvLN5IWDBl+IrKZ42XHSyA6P24WPrQl09OkhZuT51sBzB?=
 =?us-ascii?Q?BVLEssGmkVOl/1QxuHifV7ZVSH568m0qsC/Fz/cxhPTZBfxCKD/Nzorj98Uf?=
 =?us-ascii?Q?zHgBQ3CeNOaDahUwJNpAbD1SKqmRext/oG1rG1n5OLvv7P26mH7HREVsPNDm?=
 =?us-ascii?Q?YnzhnpTxSI5S/AMC3V2jbn2HjTJ1mV981PRayk6hGd0i9lDOlH5ovEFejpQ9?=
 =?us-ascii?Q?eFbZtgfIwBiOKeJhOF7/M9CHpk5yWciHiQxcszR/gkgsPBPWU+Uj2G2yAOWa?=
 =?us-ascii?Q?gTjYhKYSWbKaaAUaKBD5yqz1AMXrMmieD5G9UK+jaSDHOpBQY0JzY8nhF499?=
 =?us-ascii?Q?Tn8vTanLz2ig9feQOAbVwVC9DUP8rZZEwNcwubkP+XIMpz49gd0Uw+eOHmLq?=
 =?us-ascii?Q?p5a7HDfPaD8waUFQnKVfi2TdtqvZWXDvKWZC+rJCbU86ANr10I6VQAxP3avb?=
 =?us-ascii?Q?e2U+KGcZw/ACaXKdBNPxh4IfkZDQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 00:41:49.1282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de07bcb7-156b-47e5-4342-08dc6589a886
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6922

From: Ashish Kalra <ashish.kalra@amd.com>

Handle cases where the RMP table placement in the BIOS is
not 2M aligned and then the kexec kernel could try to allocate
from within that chunk and that causes a fatal RMP fault.

Check if RMP table start & end physical range in e820 tables
are not aligned to 2MB and in that case map this range to reserved
in all the three e820 tables.

The callback to apply these RMP table fixups needs to be called
after the e820 tables are setup/populated and before the e820 map
has been converted to the standard Linux memory resources and e820 map
is no longer used and modifying it has no effect.

v3:
- Added new e820__range_update_table() helper and updated all
  internal and external modifiers of e820_table_kexec and 
  e820_table_firmware to call this new helper function.
- Updated and restructured the commit message for patch 2/2 to
  explain the issue in detail.
- Added, merged and cleaned up inline comments in patch 2/2.
- Added new __snp_e820_tables_fixup() function to be avoid
  duplication of code for fixing both RMP table start and end
  physical ranges.

v2:
- Remove overriding e820__memory_setup_default() to invoke
  snp_rmptable_e820_fixup() to apply the RMP table fixups.
- This callback snp_rmptable_e820_fixup() is now invoked
  after e820__memory_setup() and before e820__reserve_resources().
- Expose e820 API interfaces to update e820_table_kexec and
  e820_table_firmware externally.
- snp_rmptable_e820_fixup() now calls these new external API
  interfaces to update e820_table_kexec and e820_table_firmware.

Ashish Kalra (2):
  x86/e820: Expose API to update e820 kexec and firmware tables
    externally.
  x86/sev: Add callback to apply RMP table fixups for kexec

 arch/x86/include/asm/e820/api.h |  2 ++
 arch/x86/include/asm/sev.h      |  2 ++
 arch/x86/kernel/e820.c          |  6 ++---
 arch/x86/mm/mem_encrypt.c       | 13 ++++++++++
 arch/x86/virt/svm/sev.c         | 42 +++++++++++++++++++++++++++++++++
 5 files changed, 62 insertions(+), 3 deletions(-)

-- 
2.34.1


