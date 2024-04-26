Return-Path: <linux-kernel+bounces-159395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD788B2E1A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE461C222F7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BCDA35;
	Fri, 26 Apr 2024 00:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4qFFnc89"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E119EC5
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 00:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714092156; cv=fail; b=lCCPqLqzMRRx+8/3agTQfa9HxZYxbZni24XlO2dJUtXYbrWomGEGKLRVYpg10BGcubpOo9EsFqtCOs8S5TPOlbRymuKxVM7laeLrbw7d8hcbpKz5mkBSdpuTmNqsXmDinQpi4PfYaypCon23Ame1sgLU1ivlWKfPir4cCf98Rj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714092156; c=relaxed/simple;
	bh=0RetvHtJXLM6lpX2/OSvflcnawVVGie5gKyQK95RI3E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edzRD2B8wL5wdIYUcifaKA9k1pToEarRSBpdKfqA2a4QLh4a/9ldXjq0Nr6CmKsLCU3kwMAoo8OjnvPijSwyelMKj1sfAaCmsQDMfrujSl24CZBCgJjVncwNRP75ytrbKuBSwd2YJ/26DtnpnSshfhP9dcMz3MU79yZkz9G71rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4qFFnc89; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UF3VrbC649OcPjtEw+QHEUyks157kl+p+xbLzBI0/aNKqdViEk7yUJAR+vHfdWKk+DxN/vJ5OcgfC6hsF0GTK+4Ce1w9pnixdNC0RXczdjYCAcsBDnN8ocLFEJxk3m12HtvgEEHsXaU+ozNHQKuU9GfkjEV+Ktc9NXXUBRo7h0u5yTkmuk/Nvzm+Sl01PQRgHaTfFgr6dwiudrcS6yZANX5YO9WfOgoLOIDpfi52CaLhMNqm02yvbD8Kpeh5cYfkKc1bzb6e/ggW5dS5gcpeU+lNHToLxkN35je24zrrnvdvQboloLZ2SfdBBaN34vpMV8ahnF1BfnD9bRgHv+rH0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2eTkdvJBhnd9MXbddikR6LxOiTu84iJjzumusFQfxc=;
 b=PBGh33k3zZQd+G9/gWT330f6CownZQ3csl2gELpej68t+LXY+YV92EYbQ1LPpBRpgu699o4Y8Fp+G1WWTechNxZDRfvzqn87YexMbdnjcJWTjB5fNNF5fh6yr1/Rw6pzNdktFzU9H4ef1wgGXL8XZELpagxJPtOmUV1UJ2PzjbEbLWWohDRFtH0kOcSJs0doYAVO9ZoDnufnD3l/BuGrF6HA88onfzAn1s3nL/aafBpQ7mG+XypXQEsKbXKn5gFoGaTpXt/C3pa61DAUYC8H5eTwzSF3bpqDKeAjbVNZh02hzXpTm//j6GSnU7y1GHNIKnKvFD+StdRKKtB7XDx59A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2eTkdvJBhnd9MXbddikR6LxOiTu84iJjzumusFQfxc=;
 b=4qFFnc8924upEncuNJXDBH+vGAozfgGcWq+eFNfOyZMJ0gi/YuJ3dicyxWPetT9kFUA3j6fknbgkdHozhChDoz7f9VNCnwkuYaGLeACinfIMJCXtQu3M9QDrQL23N4cHayQ8layOcsbChzX5/8DzRBeup2m3p99vTwUq0L9/7hE=
Received: from BN8PR04CA0042.namprd04.prod.outlook.com (2603:10b6:408:d4::16)
 by SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Fri, 26 Apr
 2024 00:42:31 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:d4:cafe::86) by BN8PR04CA0042.outlook.office365.com
 (2603:10b6:408:d4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.26 via Frontend
 Transport; Fri, 26 Apr 2024 00:42:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Fri, 26 Apr 2024 00:42:31 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 19:42:22 -0500
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
Subject: [PATCH v3 1/2] x86/e820: Expose API to update e820 kexec and firmware tables externally.
Date: Fri, 26 Apr 2024 00:41:56 +0000
Message-ID: <b726af213ad55053f8a7a1e793b01bb3f1ca9dd5.1714090302.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714090302.git.ashish.kalra@amd.com>
References: <cover.1714090302.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f03805-06e2-4100-8d13-08dc6589c1dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|82310400014|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GIvK0Y0tD83y6IITKH3SVQNQocqDhSDe0nVycrdjVtRsw2QFloc4A/BgiyNt?=
 =?us-ascii?Q?/1JbnfQZCFHHXeYCIvoyZPEJNF/qvq+m4M8I/loVXZcWcy+vCCQnKNY3V4Nu?=
 =?us-ascii?Q?xEWpXrJU4Lty1Yfcg0jAK9h7Sqb//4LOSyzpO9yPtf9FcEu04zRLnTmKUIzv?=
 =?us-ascii?Q?UFtfQxM6KswG2jwD3jjg/62Kda5Yz/RBx6h7LYhp8BIbKkG/xCVysmcFlNTA?=
 =?us-ascii?Q?Zha/DWkyRED/LmPEfeUT+2eEqb2rZoodUmkelyAeSagjsPPj+2vF2tOR7iAi?=
 =?us-ascii?Q?ASNGqI10Y1ylOKi6z1TD3XnO/YZUwllrxktxyJ+3F0zGkArH6+1BrlpLge4m?=
 =?us-ascii?Q?zAIE+/pYNkG2VWjqaNxsGXIqYC3ddfOQbKnkW/WQd3s3DSuz9MdzLl/gbKe6?=
 =?us-ascii?Q?1OEj9jYJvCdB/37pJiTR+H4nog1P1EHiu9500R8bbP1QMeZx2P+HBUi1WlkE?=
 =?us-ascii?Q?4ikJnJ9J1RTZyRPiXrnG3MA7PC4KYrtjVUR5l2hO14bellvzNzyjx+EDviHw?=
 =?us-ascii?Q?eN0YR7jBzCZxoYNm58+pwisFinzoGCAFdniBQubyFd/pKZXDpK8Be1LNwZPk?=
 =?us-ascii?Q?kuToiDUpRTQqq/JXxp2SBl8zYQQw7O9SY0AqstQsIoVaIMYSvf4GHFTKlKSW?=
 =?us-ascii?Q?L/eGHu9m2wNlPEa4LAeZJU4/tobRw+yC1YxEEOT7nsFkuXrQ8i4bXrTFQZ7h?=
 =?us-ascii?Q?EckogzzWZDKKQqmgAfCalUQDVOkbIEr9dFFOYea5jTrEpBgozaL/PxiGOLYK?=
 =?us-ascii?Q?XX/RpcKC4yQJ6RADCuEUter//usUJHrYhWAWSaSl1D8a0kOWXbkSrqwzGzmC?=
 =?us-ascii?Q?J5f4qiNdx41EX8TbfI7F95+5mJ0TLHySYMvVQCQ/R81Au5k6ERILHnGLuHw2?=
 =?us-ascii?Q?bog2y3NWU+My+Gu8mrBzuUfnbBNEa4SJQVyiWYPdLEdVOaroU0OUC/kEApdt?=
 =?us-ascii?Q?8kG/p+EvEddSBh1y3higvsrBpK2qLc8VkVuC6DGw7q0iL8nJ+sKrSXyTM5wQ?=
 =?us-ascii?Q?tXTdhfiyVtPStycya41aDWPFjqFsRRviS2cUCyVAmS0Yv9rl6jC5Ulw7xikA?=
 =?us-ascii?Q?IaVAH1whmCyHxbvJC/F74jYjt2U5Z7js2zFSZbXsCe8gmNsDe8ByIwdWFx4L?=
 =?us-ascii?Q?j/SQtTPrpvVJ+jYo8u66nnW++qy0WXc3GhDMPuNmTNuW/5naB48cKh3UpCt3?=
 =?us-ascii?Q?sBJQf1bdQGQmUoYXmEqUUA05X9K7HWxNOLNQwRAAdMWfIUL46wUMW+qJUJ1R?=
 =?us-ascii?Q?K677NSxRPZ8uF+SkaCgD0KHU9rYy1VFGGKfPGHL+fnD3P6+/MqVGFf8sTDav?=
 =?us-ascii?Q?E5BjoR4SuxrnJYIkKZzc5bdI3SObiQAqOoV0cfV+YsMIw72Q3WEwGeDLKnue?=
 =?us-ascii?Q?095gXpOZw4BDF7InW6tpPUvw0FIH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 00:42:31.6680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f03805-06e2-4100-8d13-08dc6589c1dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875

From: Ashish Kalra <ashish.kalra@amd.com>

Export a new API helper function e820__range_update_table() to update both
e820_table_kexec and e820_table_firmware. Move all current users of
e820__range_update_kexec() to use this new helper function.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/include/asm/e820/api.h | 2 ++
 arch/x86/kernel/e820.c          | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index e8f58ddd06d9..eeb44e71aa66 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -18,6 +18,8 @@ extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
 extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
 extern u64  e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type);
 
+extern u64  e820__range_update_table(struct e820_table *t, u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
+
 extern void e820__print_table(char *who);
 extern int  e820__update_table(struct e820_table *table);
 extern void e820__update_table_print(void);
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 6f1b379e3b38..872e133d2718 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -532,9 +532,9 @@ u64 __init e820__range_update(u64 start, u64 size, enum e820_type old_type, enum
 	return __e820__range_update(e820_table, start, size, old_type, new_type);
 }
 
-static u64 __init e820__range_update_kexec(u64 start, u64 size, enum e820_type old_type, enum e820_type  new_type)
+u64 __init e820__range_update_table(struct e820_table *t, u64 start, u64 size, enum e820_type old_type, enum e820_type new_type)
 {
-	return __e820__range_update(e820_table_kexec, start, size, old_type, new_type);
+	return __e820__range_update(t, start, size, old_type, new_type);
 }
 
 /* Remove a range of memory from the E820 table: */
@@ -806,7 +806,7 @@ u64 __init e820__memblock_alloc_reserved(u64 size, u64 align)
 
 	addr = memblock_phys_alloc(size, align);
 	if (addr) {
-		e820__range_update_kexec(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
+		e820__range_update_table(e820_table_kexec, addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
 		pr_info("update e820_table_kexec for e820__memblock_alloc_reserved()\n");
 		e820__update_table_kexec();
 	}
-- 
2.34.1


