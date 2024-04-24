Return-Path: <linux-kernel+bounces-157282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DADC8B0F65
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB169B3025E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FFE16DEB7;
	Wed, 24 Apr 2024 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y9oLYYoW"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E51316192C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974381; cv=fail; b=TQB6eQUdZsfWWnckv7duRc6WlgMGUZCogUSbSsX/cfwF8umc0iXuYFsl9vwxtjOwu7AWPIMmqO6HI6kZY5imh4eioQViYPuGlQbGzHfY2p1v/TTaUxfG0ZN8NxNnhLpC8wFTn05KJ8hKeOOB1PeiWFWj8PHlYq7hk4hWDFpDkpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974381; c=relaxed/simple;
	bh=k5dqfCB1Ny7K9oxiexb9YQ/Q3eD7iadwyVpqzh3QELo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbGfJsxKYWz57/GaZj6n7iV9HP6wm5nxonUZkvSBmb7Jzusir+dp/s6DLoHjLNPfvmSTGBxc9fT3Z88WEXfqo/D8ihJiQRFVYebLX5oxO5qQs9BpkbUNZwOqYlcJg41AD6o3/4z8OfC0ptzJ/Gc+HFheSIFy3WYzBrP3MAt+bCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y9oLYYoW; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWkTPhs4s2pHLskt6c2sCGaB2hF1YMKJRKs3qzWP3jojKEIrm5rLmaZHcldNyHzVeHuFeWhiB4b88sf4bV0S1VIUM9yhPdHeG4hr4SfWdfq9/4HB4tk/K6nxD0/yO00uDUMF3nogZoIdydC2tuxWrlZ/PHCeIgg3O00ynu0MPdGuwugaZ7BnFL0TwsYGG+qH8pe1WAb7vVZFVuqlBPI2yVVfbo+uytpczDn6sIllgpOoWnGN615sgxr8WFvqVNhnAlbzSqPQy/0oTDkhzqGE/EQ7ZH9tOKcLZ2qEpm5TH5CjxUwghCZLSa0VVuJqK66XfNd0uv8K+qQ9Jc9jkp48ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJrOw01MQaT9tkIKTDOXvm9NDgY/m/tu/OEjNakftDE=;
 b=GGb7g+/Ed45h01St1GGXnPueGWTG4t9MPlGwgyph8wUbWJN2GsRpXVlFYuVUsrYPaXEHy8zkmfgoVPgQLS40cD5PcZ6BoBOJK39FOQD7UOkQ3bWHYnoMVu/2hBfOgGZah/cSOai19kQGQB5xUVOpovim2Y3fUWSOHQ7Sni9HdxE3L+vL7MUNV3W+6w58M+hJoX9Lexl1/pQjWzkv1ZburG6EzIH4BDOannsm6Re43GwE5PEcksIILvX5iXYLQfU34k/N9ohZB7DoMES7bmPIfUB0OPc/kIFYAZTo63EygotfdY+F+Av0/JVtsPIGD5Gcp6VqQQRdb7xEJZH5PhM8ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJrOw01MQaT9tkIKTDOXvm9NDgY/m/tu/OEjNakftDE=;
 b=Y9oLYYoW18uz4sP7ls7kLGwGOg4WyAyXGCWw8tugMM3pba0z74EmMxOSx0xi7vfvizvqgPG5rrbywMWkhSg3odCv+5i8ed71NDku7y9NonsEQlTfugYO5ehdMTbYymw9Lb67ZnsKwg+sbLr+sy1N+cL3b5/Dm37mwqVGBVv7mwY=
Received: from BL0PR1501CA0036.namprd15.prod.outlook.com
 (2603:10b6:207:17::49) by SA1PR12MB8141.namprd12.prod.outlook.com
 (2603:10b6:806:339::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 15:59:37 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::8b) by BL0PR1501CA0036.outlook.office365.com
 (2603:10b6:207:17::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Wed, 24 Apr 2024 15:59:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:59:37 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:59:36 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v4 10/15] virt: sev-guest: Choose the VMPCK key based on executing VMPL
Date: Wed, 24 Apr 2024 10:58:06 -0500
Message-ID: <b8508f57712e3194484aa8695494eea26abe1b73.1713974291.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1713974291.git.thomas.lendacky@amd.com>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: aae7bcbd-84cb-472c-972f-08dc64778acd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h48vaUyOU3JrT6udw8KY/t4wBUhZ1SNvSHxkSUXPMTnZjKN0erB1Ukb9mUN7?=
 =?us-ascii?Q?83xgejRe6QBmfqa5Lgyzu+DOCNakFlkuX7uHd3PudDZStlrGJgPPnOxRENgj?=
 =?us-ascii?Q?BubiWqTspbGgLSnd3OXi4KehKh0q1nRlkSc5FrtrlemSn5DWWg/s/YuvwlU0?=
 =?us-ascii?Q?lNLieujRdVhFYCFGojPBxbByWl/Ltso0kgVDRkJiiXe+7XG8AUdzFaq2tnTR?=
 =?us-ascii?Q?bwm6lRhmk+dvmarp2yKktUzInEqgSqhCqSpYGvJmCe9A+scfQeSd+YWP1afh?=
 =?us-ascii?Q?7A41nlYJfOnadyl99ZiKNKWZxIZvYkAu+FnNeK/OYs15IRI0NFLRYW/w1TsM?=
 =?us-ascii?Q?jRo8fuTzvwscvFT56ZA0GrxIbVYodSVxM/0uHSaVBIyaktk6+WN97KaNb5JV?=
 =?us-ascii?Q?xP10k8vLZPrKBAwdfDHbPnPLc+naqlMu6K2OXzyly+v6dB/GR+bV6ScdC2Sf?=
 =?us-ascii?Q?5uZkwqagHz9zTd5CTy19Yv83wYraaw7CEiNXocAakY9QFomL2QGYPrKTOogI?=
 =?us-ascii?Q?NygBPyZvkRGVY+/jHxHYlPr4bYfpT3f+2jVS+xwAQApjf/O+gmOxlXzacQbL?=
 =?us-ascii?Q?qO+4ObcALzTn2ZIMh/0M+YIBF0/L+a4tP26Wp5Qoek8nlMwrIoWUS7FOSNtN?=
 =?us-ascii?Q?n7CxFawlNsQAG2Aq3NC6IV8w3JhCBtj7RqSy48oH6dsBpCabx0/KqPZxEujW?=
 =?us-ascii?Q?KfrRMDJk3ubs3YR2rEfsyjODuhPtRzph7mwuFes0rXlHkR/9uZRbJYlLsNnB?=
 =?us-ascii?Q?4aekBemxn1s7Sc+15qsy0Y7FBCVrOHBnyq0raB2o0bFjSvuTvf1pnDze1JST?=
 =?us-ascii?Q?kkJEbk13+Yzec9cFXFGtT2G5V00AaLmj/ZlJNCQL1X1fh3MlKRBxz/uCXlQq?=
 =?us-ascii?Q?gJlmG1oY9FivnI2poI20wE5PzLKiIEIkS0D0p2L8IYnivNuGj/ixiU7loxcr?=
 =?us-ascii?Q?umIyxgVE9PslqWrEZg0RMxz6ndmCdu/U/++hwgJ86K70gsZXBf3DGheV6/j0?=
 =?us-ascii?Q?iBEXQch4RhVe+dm13ztbE+Iro2X5uy2S9qPgTo0zLj49Mliuzdlk70nFvBbM?=
 =?us-ascii?Q?XhEKMTclr0RIG2/VVyOE7cGD5iesxqRjYM4Kc/JyDNfGbnMhrgNE5Y4Uo3q2?=
 =?us-ascii?Q?9ivq0fGWdpScGPp/A5gAWfgrbc+7tD3LeyPx7FL8lNFkslEXlESfyt997hv/?=
 =?us-ascii?Q?W3sOai0UGBaPIQk0WZx+x8G2c0pO7vjs0ETcZHff1BrffKWs8adUG1aiWZNM?=
 =?us-ascii?Q?tCC3HRc84pxvuUUjXI3zQ60xgunGmwyyWkn7Z+7XPWj3dMTjngRFjmttQqvh?=
 =?us-ascii?Q?KBsZdDimeLqZ6C3Wgg1YfuF5Zn3AKE5SFimoIk+ZwPCgHsN5XCdqSfRIl5Op?=
 =?us-ascii?Q?P7aFjAg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(7416005)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:59:37.1914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aae7bcbd-84cb-472c-972f-08dc64778acd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141

Currently, the sev-guest driver uses the vmpck-0 key by default. When an
SVSM is present the kernel is running at a VMPL other than 0 and the
vmpck-0 key is no longer available. If a specific vmpck key has not be
requested by the user via the vmpck_id module parameter, choose the vmpck
key based on the active VMPL level.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/sev.h              |  2 ++
 arch/x86/kernel/sev.c                   |  6 ++++++
 drivers/virt/coco/sev-guest/sev-guest.c | 10 +++++++---
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index a7312b936d16..64fcadd6d602 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -307,6 +307,7 @@ u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void sev_show_status(void);
 void snp_remap_svsm_ca(void);
+int snp_get_vmpl(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -337,6 +338,7 @@ static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void sev_show_status(void) { }
 static inline void snp_remap_svsm_ca(void) { }
+static inline int snp_get_vmpl(void) { return 0; }
 #endif
 
 #ifdef CONFIG_KVM_AMD_SEV
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 8edf7362136b..75f11da867a3 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2454,6 +2454,12 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct sn
 }
 EXPORT_SYMBOL_GPL(snp_issue_guest_request);
 
+int snp_get_vmpl(void)
+{
+	return vmpl;
+}
+EXPORT_SYMBOL_GPL(snp_get_vmpl);
+
 static struct platform_device sev_guest_device = {
 	.name		= "sev-guest",
 	.id		= -1,
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 04a7bd1e4314..e7dd7df86427 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -2,7 +2,7 @@
 /*
  * AMD Secure Encrypted Virtualization (SEV) guest driver interface
  *
- * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ * Copyright (C) 2021-2024 Advanced Micro Devices, Inc.
  *
  * Author: Brijesh Singh <brijesh.singh@amd.com>
  */
@@ -70,8 +70,8 @@ struct snp_guest_dev {
 	u8 *vmpck;
 };
 
-static u32 vmpck_id;
-module_param(vmpck_id, uint, 0444);
+static int vmpck_id = -1;
+module_param(vmpck_id, int, 0444);
 MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.");
 
 /* Mutex to serialize the shared buffer access and command handling. */
@@ -923,6 +923,10 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	if (!snp_dev)
 		goto e_unmap;
 
+	/* Adjust the default VMPCK key based on the executing VMPL level */
+	if (vmpck_id == -1)
+		vmpck_id = snp_get_vmpl();
+
 	ret = -EINVAL;
 	snp_dev->vmpck = get_vmpck(vmpck_id, layout, &snp_dev->os_area_msg_seqno);
 	if (!snp_dev->vmpck) {
-- 
2.43.2


