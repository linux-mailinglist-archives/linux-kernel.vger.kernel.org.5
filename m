Return-Path: <linux-kernel+bounces-118106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB5B88B40D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29FE2298DCC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED9076023;
	Mon, 25 Mar 2024 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vm69o6ue"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8026479DB9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405674; cv=fail; b=gKXpVYG6KsMXdaro+99Sss790JVVOBIwPzFNxO10V4DRPYXkMoEHs6k5f1zzjMN7l2ii1LzjrPHMv4DircaZoA7AXRme2mrP7mMWHS2G1cAXi4LPoEExV82xRz3uQxoxeO/XzvIXaPqgpMYcDsek+jr8VYbMVZsA2JhnWT5C4H8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405674; c=relaxed/simple;
	bh=XEHK48UoZVdRFi+ouiDElocCFCWd7/OHjXwAVnnNO04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0J7r8qOxpFooN7k9SOOlkNUlika3sbi6/X0GNaLj5ge2x10t/GzGYSoTmc+lYaQ2gRzFm4WTJm3QoyFirbX1nlr/hUUsdNf8EkQsX3Y+2Mi3duKzPWyxKySieST9I6kDrIyA+rrnWx+t3hVpuXeUl+x8GqaAnDNglNDLsFp1d0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vm69o6ue; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+JxAsUftURqmsNWFrAvJJSXvifsdNcqPmDltCRw8G7nnQOj0E2Y/vZH6vPJiYOwbIqIzVzSmvmg54HbAZkZcz/GtuR2UmZi4wTSXov9Ryddgs0c1SdBRF0qZ6KXXt11g/4cKdD3xVHPkJYt1AoD7zjtyrZk2keGH10r8e7SuUYWQSm6dsk9StC4ow22gwHPv0epUJjhB6E40AVJ7W90h4szf4qKfOrORllCrlYeHleVm7mi3d3ekXJkcdRy3lgf+GSTetOy+bdfDcIHIX+09duTqZr0iqlWTGzPQ+pFc4hBbFEGsic0450af5xV7OV6a6R15jd//4nbuGKoQpzJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9y7Qs8owcCGIArd5/qD8aez+FctSryByYyMxiAU78g8=;
 b=CTa9TZF27Kldvks9juo0SXaIC74rsnKtJsER77I4sv08aOG+xQgFUdcq+x/IaWirOZPjuUv+YTYVFqjC1CAt+K6K+50slazyAxotYUzb8sNWezglG/tSHnFEfKLdKi1jedmW/5XdXoadtMjX3PHif4Gx+jEShiH6MilwwFkU23HTzer2EXLWgymq74Yu0J5sXC1GzcuZzwI6zTFTFBtp3+qUPwiu4S4yqJ5Rqo+j+Pzrwlzkp4Mlyv3lZMt8YpTgGfDhe9f+kPWnN9AyvICNohxIvsnPK8gcc9X+Wq4VQDlihr7dhqYpSsEQlv9w4ekwooRQC8uAlEgsg8vhCuScUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9y7Qs8owcCGIArd5/qD8aez+FctSryByYyMxiAU78g8=;
 b=vm69o6ueJ1MH1iCEETRdekH69cLq4+yYgygvYUKzfxiCbUqsbqPDnM8y+LUTyL+tcm10vYPCxrKZFg7vgkZK0cU6FDjOKc1GflffguQuU5Xex7m9TuUkQXvP6cZoZcVvREqUtFvBJe/qA5C0kLq14ncYfH+IK0NCN+Tk323Lqms=
Received: from SJ0PR05CA0112.namprd05.prod.outlook.com (2603:10b6:a03:334::27)
 by DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Mon, 25 Mar
 2024 22:27:48 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::75) by SJ0PR05CA0112.outlook.office365.com
 (2603:10b6:a03:334::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Mon, 25 Mar 2024 22:27:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 22:27:48 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 17:27:47 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v3 09/14] virt: sev-guest: Choose the VMPCK key based on executing VMPL
Date: Mon, 25 Mar 2024 17:26:28 -0500
Message-ID: <9615e6055e5b262a22bf312608647223517595b5.1711405593.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1711405593.git.thomas.lendacky@amd.com>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|DS0PR12MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: eea6356e-7d19-42c8-6c77-08dc4d1acd16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8+85Th94efYneApQSu2pWiGcSBdn1VBAM75eFRrPMCG1bkBqgOn3E5g70m/zSqNm69PO07ORyd0D1Gf2WMXZuH0JihlgU5MSiXf+5679uDc8Ikp5wcFluX8iLrjhD+bio8UvSKC9dEzTqUMoiOff+00Zq5Yy6WsIe2ujpEl7oGlzTsqgigIU0BkUtRQaTltAszMMW69DwSIiaNJtq0Y3IyuuhrVOjj/Y2P4KpLrL2Dm3xmSEK3E5qh3cXS2xD5tWDfuvTWWJF4IcdW6nVSeLQKiaROQ0x5aa6813e5B/7sC1Tu9deih4dIw5y84tIhxZStnqFw8qkUhVbhKV3HuvtdLiYfPQcRrs5QrcwyYbpneY41xwN2hhxkhmfb8gPGcDYC1QJmJSqnK5QkKGqagEpQTYCzimOvKDfFWy2cF8uq9Iwwj5wMBpzjT8xRPqsqRu5sebDnJb2au8x7U0UQcTYt96iAFZLDBUnlOWdbjCXmmoqtfYuOMOzLvPIFgvsTzfQ57Z3o6ST22CYXuCMOL2a6J3bUf8bnUxKCSpp+M/hikYMUKnGdf10e9q03A+mpk4/SbAf8zuU1m1zQs1y9dK5GbIsbSipWrHjopIuvrP0FP/KjiwueBIljcuigQMd0kxNhDJ9V1ok/aRjaf0jbHJ9RooCmRkV4jj9zrFl43Bmkp7OqaslkMMIUOJqiV+n+jlgCxY7DQa5HnueO2kedPkzsYvRI0/45j85fjJ5bA7U4CtTVhKjh+UQ6u6LyC0uWe9
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 22:27:48.3648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eea6356e-7d19-42c8-6c77-08dc4d1acd16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780

Currently, the sev-guest driver uses the vmpck-0 key by default. When an
SVSM is present the kernel is running at a VMPL other than 0 and the
vmpck-0 key is no longer available. So choose the vmpck key based on the
active VMPL level.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/sev.h              |  2 ++
 arch/x86/kernel/sev.c                   |  6 ++++++
 drivers/virt/coco/sev-guest/sev-guest.c | 10 +++++++---
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index d7be613b7372..066eb0ba3d63 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -308,6 +308,7 @@ u64 sev_get_status(void);
 void kdump_sev_callback(void);
 void sev_show_status(void);
 void snp_remap_svsm_ca(void);
+int snp_get_vmpl(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -339,6 +340,7 @@ static inline u64 sev_get_status(void) { return 0; }
 static inline void kdump_sev_callback(void) { }
 static inline void sev_show_status(void) { }
 static inline void snp_remap_svsm_ca(void) { }
+static inline int snp_get_vmpl(void) { return 0; }
 #endif
 
 #ifdef CONFIG_KVM_AMD_SEV
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index b027b00e315d..7e2b9934a95d 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2464,6 +2464,12 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct sn
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
index 87f241825bc3..1ff897913bf4 100644
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


