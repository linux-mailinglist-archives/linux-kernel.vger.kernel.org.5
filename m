Return-Path: <linux-kernel+bounces-166251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158188B9818
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383C11C21E2E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3C95645E;
	Thu,  2 May 2024 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vmybJzQH"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CAD5466B;
	Thu,  2 May 2024 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643507; cv=fail; b=i1Dv1FIiRVQ4qDjxkzeEcy33TyQf3aqK45G2V+3V9I+A97kLo1Pe7iKHaCCdFLqL0PgejlkGhYV2dTPykOvRN+HWFy5np1x03BhGL0QXvxC/5RMNKZpyJB2OpFpit6GW1+wYTlAfptxaJtEeMefgGnB4WJOxPl+N23+a6xAdjig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643507; c=relaxed/simple;
	bh=rF7lfPwMUQFPxce6EjOqvBAojbhZJwLrtvFv6mm6Kzw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=McM3/Jqcz2gySHMVynPyDq8Db1s3CDhLdgXWjAI1uCUeMtmzw3CKkudYmBxq3qjyhmrvLuzwupVzjjKNjav3uJyZrtqqg2VakhjYSto1kYd9HK3PFCwd7/HdfVe0a4Wmne6CA/DGOucv0XH9dF/O5JS3hcVqsddNHWmWJKo2rSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vmybJzQH; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkt40RjN7o48+VxEu5+UNcplsG4d8EnyUMz8L/UnrglhT5LLVZTz4CgfP0pMKAv8dAaarv5O3pS6hsD30iaoBoLds571vJZWfDjdM1tlgW6/b3UsSKiCrUoVDY3z6CB+gUCenVB16sSm7aOyWrVROO500yjfc5e+c770NF5agRG18lTmYo5DYDOqXJhgeXq1j0GNhp+OKjPqaQbpEiIRPFOVPCD37tN77J0JCmMp+UryVoVodSkarv61ChXzVmIWeHRomHPN/IoksJp41moX5lPELzNdPrL8SGCuHEn9cTUuKhnAHCBV0sF5ryVxjArNlMD/F3VDbwAJFFgsXgjzKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tgWn4nOX3OuUTOl5cdSu8WwxiRBHKcAVq1FoP7j3Fw=;
 b=K6N0DkjSDF9aMrHTa6xdCAwIzD/5Mc0H/Th2PE7jHRnExjBiihrI92Fx0OoK6y/7PXKP99w30kedF53OHiPjKnVFqFwK12yaaxfN2LrW+c1O0v9aG1DovxMrKytLfvvl880fwwwajv6OGNxo3NlcU6kD3+UxnGCJDeTsYUVdUsKTZL3tdzV0O8mpgZ8riAF6XVbxV74Tf8roKulOkrURqJGH/8syeswUzqdbJRrshlQ7ilTShrR9/Ghx5KXFZP17bi57XF5xdt0fZl/7GKihFu64tNP0c0jvPXyn+u+x5WPSFGCroC1HGgiS6PquHmnM8pS1NYoiAkFLM4Qfu+QZfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tgWn4nOX3OuUTOl5cdSu8WwxiRBHKcAVq1FoP7j3Fw=;
 b=vmybJzQHqfr1rIiHHzl+ZhFGgzJ9ZVxxwZ1aVIVtXiquLAGFxfaSnFu5nrOCUEE0zomheAIYFY4o/82oRQ4RLmuXHSnKJsa83rZlUiHBJ5Ng3WiPAXwICelC5aNtogj/0GElvHyP1oBBD7on53Hhscd8Ka7yYr68q1WUoFJy8wE=
Received: from DM6PR03CA0015.namprd03.prod.outlook.com (2603:10b6:5:40::28) by
 CY8PR12MB7314.namprd12.prod.outlook.com (2603:10b6:930:52::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.28; Thu, 2 May 2024 09:51:43 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:40:cafe::e3) by DM6PR03CA0015.outlook.office365.com
 (2603:10b6:5:40::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30 via Frontend
 Transport; Thu, 2 May 2024 09:51:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 09:51:42 +0000
Received: from BLR-L-DUGWEKAR.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 04:51:37 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <ananth.narayan@amd.com>,
	<gautham.shenoy@amd.com>, <linux-perf-users@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sandipan.das@amd.com>, <alexander.shishkin@linux.intel.com>,
	<irogers@google.com>, <gustavoars@kernel.org>, <kprateek.nayak@amd.com>,
	<ravi.bangoria@amd.com>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 0/2] Fix energy-pkg event for AMD CPUs
Date: Thu, 2 May 2024 15:21:13 +0530
Message-ID: <20240502095115.177713-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|CY8PR12MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b292f5e-6cc8-434e-f5d4-08dc6a8d78cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d5rIoDHxXkRMpECT20QbK0OKWtPqh33mj7ORdxPBUrQcftZ85PEofY+HL2jm?=
 =?us-ascii?Q?LVh7XJVUuYV5hNWEqEGnb3gdcMYsbILGlJJronrOmTKRY9vuG9j5qno9hAuW?=
 =?us-ascii?Q?55cgj48OqgY0hwMC2BgjjBUOkZYTOombPEJRIRTrNNRFYL9K6EAYfUb8TEKe?=
 =?us-ascii?Q?o5Int5CNAN3SCGPzM4e43a/bQ7pY+/a46FJA1c2SGj3MBfSQ6/yhCHrNF0ia?=
 =?us-ascii?Q?Q8FF1vVq9Roq4BhUuysO4xZFU+grd0LsSlElwNCJjVFbf/hyqpER4xcv1KdA?=
 =?us-ascii?Q?KQHhMz7ZFM81QlLyv+sONionwz86wrgw4mp886Ac7XSjhX/Zg4RW4BrkYPtw?=
 =?us-ascii?Q?PknnLUWbxF5zeJmPtGqFQVOXpWR9y5Xwj3dTbWa6+NMfeExGVWscQOMiz/Ft?=
 =?us-ascii?Q?xtCvhfMJcxvhl10896bv1mFIPwsTfbuBff5ZHDPRkXu9oE3Ng3HTYNycdt9M?=
 =?us-ascii?Q?UrNTU1zigb1AVqxcPxFy42eVa/efDFUzUQdoQOSISiRzA23IpYVJ3RIzlUVL?=
 =?us-ascii?Q?0xJu2+EhG7wjg8SJGAxRNLGherzRk1z2+u8KBOKKFQDPyKEQ8kY8+E8T8pBC?=
 =?us-ascii?Q?x5f0GC0skHoSE0Tge3GmNerxA5F0bGt2903aWt4STq64zlFa4mv+hNLmAGyl?=
 =?us-ascii?Q?95gv7dAPPWXTaTjEJ80qJyXDGvJHNw8fxV1dS0RyNKHWvx0qz+4F1n/uZxFT?=
 =?us-ascii?Q?xPA10XcG+r8fUe7ArGgV42xSFJjERJN9YpNWCHbICuc9/p2rub+odquMpnH+?=
 =?us-ascii?Q?pwBUHSQThIiwq9mXmSvVOYOZzrHUPDbnXuJ7YLmMwmOJS8BTPee9tinKFfMT?=
 =?us-ascii?Q?LiEyYdtBh5XBO+zFEuYDRgcTZum2uv41vngGnd8fCZEmrsxBTDerznti57PI?=
 =?us-ascii?Q?DL3bUSRVLyScsNYiNJnnx8eiIB+Zrc5EX1wCbyW4z7j7Q90CscUSnYalo1PB?=
 =?us-ascii?Q?K4TzRqjY6Cf74QFBWNDWjl6E1IC+W9FESq9XXuVFRxEpAh/Jj7RzjhqV0nfl?=
 =?us-ascii?Q?+u6tPU4QFGtWPJRdc5+WbVOFBPZBser875coiIWdyH8bWgvRbp7ycX3+Uj7f?=
 =?us-ascii?Q?RlQ6YXatkz5yuHS9vnBN0JpC9J9kxuWTYXVvVjVLGa94UiUcouQzqKLjvBdJ?=
 =?us-ascii?Q?xzcjNJK8Q6a8PTVzArua+lNcJmjuwXAIiGtuhYTEDqiXa5K++Ay2K7+7gUD+?=
 =?us-ascii?Q?E6tdEwW8A4Cf6gYHLGUMbvcOc/XSOaQD9zr8mg9V4C+mbqN+PcYT3bkmt51a?=
 =?us-ascii?Q?+uMJXUZhTbHhgBSLViXzRxBl1wXYoykScCQRzpgg0eIHHXT6EE91pbfOE5YK?=
 =?us-ascii?Q?ouTAJOKQCr733e4/PFMuy4xGSkMXux7dZ2qats/kW7vkhGk9FZLT09Q0LKPr?=
 =?us-ascii?Q?Aj+pLN8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 09:51:42.8617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b292f5e-6cc8-434e-f5d4-08dc6a8d78cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7314

After commit 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf"), 
on AMD processors that support extended CPUID leaf 0x80000026, the 
topology_die_cpumask() and topology_logical_die_id(), no longer return 
the package cpumask and package id, instead they return the CCD (Core 
Complex Die) mask and CCD id respectively. This leads to the energy-pkg 
event scope to be modified to CCD instead of package.

This is functionally incorrect as the AMD energy-pkg is a package scope 
event.

On a 12 CCD 1 Package AMD Zen4 Genoa machine:

$ cat /sys/devices/power/cpumask
0,8,16,24,32,40,48,56,64,72,80,88.

Expected cpumask for 1 Package AMD CPUs energy-pkg event is supposed to 
be just "0".

This in turn leads to incorrect values of package energy consumption.

$ perf stat -C 100 -e power/energy-pkg/ sleep 1

 Performance counter stats for 'CPU(s) 100':

             36.60 Joules power/energy-pkg/

       1.005821050 seconds time elapsed

$ perf stat -a -e power/energy-pkg/ sleep 1

 Performance counter stats for 'system wide':

            414.03 Joules power/energy-pkg/

       1.005252132 seconds time elapsed

In both cases the energy consumption values should have been the same,
but instead, due to the incorrect cpumask, the values are being
aggregated at a CCD level in the second case.

Replacing the die macros with the package macros(for AMD CPUs) fixes 
this issue. 

This patch cleanly applies on top of tip/master after
commit acf68d98cae8 ("perf/x86/rapl: Add support for Intel Lunar Lake"),
but not on Linus' tree.

Dhananjay Ugwekar (2):
  perf/x86/rapl: Rename maxdie to nr_rapl_pmu and dieid to rapl_pmu_idx
  perf/x86/rapl: Fix the energy-pkg event for AMD CPUs

 arch/x86/events/rapl.c | 44 +++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

-- 
2.34.1


