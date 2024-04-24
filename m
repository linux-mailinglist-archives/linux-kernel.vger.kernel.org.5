Return-Path: <linux-kernel+bounces-157272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD6B8B0F43
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4F61C2183C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9685C161308;
	Wed, 24 Apr 2024 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cGy6T1fC"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30E41649DB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974332; cv=fail; b=OWjrf9oidOE6Y/zLLgprxW8x5Klo7eG2O2b+L3zu+yOMNygRJq/5klmUsUhJaObT6L5aIC4xwrRRHxoDlCZp+PEwtq/axTVtdTFON82QFe2MJM4tw339ih/sdwN+jvizOn50LUh3TzuuRflVFPbTGPnX77haqBTcnaU/UG7a6kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974332; c=relaxed/simple;
	bh=NA+MQQ1spUiJ5qyQR2IEak0qZZ8Nb59mjPmcb3W6zTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CEdQ2+GcMBGgzWPqbWYoRerGoagUKCl6bTwAqViWSQfbDPHpwW1B1zX2Mv9SFLEjZUYb6s73j2ASMEImfX1YGu1mESbvYle9SefycMbCtib5Zwbdbb9GVZ54Pq6fdQi1jv5+MlHH0Ki8qkvUC232l4XCE2ZVPg4Yn5+qL4jwpAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cGy6T1fC; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkYnPgPz1enEHrdzIJw1y8PI3hdHgAW/gn8wuT01cHc5YKrm3Rm9gaAS3AXESValjqNfr4F2OAHbADyd3d94aqsMrAzoIg2r2ZI96Y0RcefrZ03Xg1TO09r19cnmaGxLuTBNvw47/KG6INotj9i364SrB9DaqqxNVd6ESvb4KH7EeZ/Ex/ioXgauO5SoH5ICohkY6z86hImmak4kQ80giBjtNSHgawLmo/Gw6Pc3LpBAboOsvV0g8If9IximFk+ylM+G7Cyu46jhfiTfXc1S7aqK4nzjhT0l3b+zbTd8/89fnOIPdAz/xl+BgZpL1izcga6CT+Vb/OFrUE3djE64rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bf6ndJ/A4gb88kzQ8k9yLqu7IKvmb6aKaA2Sh//c/u0=;
 b=nTt5G6X/1JO3V/V+F6Rc3DhUyhqUqHPldfCheiuj68aayh6WnnohJOg9+LnTRCpo6PJqrZc5X39SeAeLaHbv8MJXGb9ok/Qb7RRcHknPGpS4aQVn8Ab9mV7+pSL7Q9KLzOMx+ghY0SagWJofWoO78yuvPebr2PnoZ90zEG7L49a+oM1Dc5kBRLKqdcpX7ZW926REZMVDRoNTwUcKT/5GDUdTru7pnaKlGedTzLdh9jE/JZry65+8SL3Gu8SQxThmm8CJLBjF7s/unw5lp4/bpc7afnPv50DoIL+s+QuYk6UJY0AeYgY9X02Ui77d4lFDOiyFVL2TpqGALDJGLr/ytQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bf6ndJ/A4gb88kzQ8k9yLqu7IKvmb6aKaA2Sh//c/u0=;
 b=cGy6T1fCCJ6pXGsOzTLg3a2YDIuifVqw/Ailutzro70NZ192TEox4rm3R5JGrFevTktqIcPWCYBkRJglbOW5nUTWNg2j9BU5xKslewIvYBkkHQZkWZmEpoQdS6BlxI/l3SC3O0z63nntUUv5uzYZwIL+iPIfaSavGU3XoCcP1kA=
Received: from PH7PR17CA0003.namprd17.prod.outlook.com (2603:10b6:510:324::23)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Wed, 24 Apr
 2024 15:58:47 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:510:324:cafe::b7) by PH7PR17CA0003.outlook.office365.com
 (2603:10b6:510:324::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23 via Frontend
 Transport; Wed, 24 Apr 2024 15:58:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:58:47 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:58:46 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v4 03/15] x86/sev: Make the VMPL0 checking more straight forward
Date: Wed, 24 Apr 2024 10:57:59 -0500
Message-ID: <ed01ddf04bfb475596b24b634fd26cffaa85173a.1713974291.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: a433dfd5-0bc7-438f-2658-08dc64776d0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|1800799015|36860700004|82310400014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5/rYA/jYGeb/Kwm5PPTNYFC0L4sZaLuHNk0nN1tdXV7vMJ+BZCiOnZwXbXDi?=
 =?us-ascii?Q?cBz3OHGQKRJt9zfDUTn9eG+9WMc12if/w7sgisq3OBPCfW7bmJOuGbjgYm5j?=
 =?us-ascii?Q?JAe51KY0K5CEkavbCVYmBG17DYAfmUAYbpkK6C10mBGha7uCFFjZoFCezpuJ?=
 =?us-ascii?Q?9tXJS9dKB9FQJnpzTBX0yy2PDYYcxGkgCWZZmn+nS0/tjFubp9YLQ9ZxvKuP?=
 =?us-ascii?Q?5HAW5+N7YH0s5gryj97xia3zsWdC4Ip7zB10EleiypDjQhTwebpjCbriNvfV?=
 =?us-ascii?Q?oRvUtY/NtOMaqdQ3sC8VIuKWGRcuZ9dlU5IxHGg7iXDxMMoLCexXIn0perX8?=
 =?us-ascii?Q?DDohKOUPaJw+fTOg/ofHbCBcygM+3ZGACQ9sXqbljCqjVy7T27TCzfCAZF+7?=
 =?us-ascii?Q?asM/se16B/ZKDsR9mTReNwy5OoqVX1TyLHUN52QXDQUdSkqej57qtmSL+TcI?=
 =?us-ascii?Q?MdZHCMHIu0V+KjmwvCfLZ1bJbljefs2qxz6xHRe3lyJy3w4vubKXM9JvDzu7?=
 =?us-ascii?Q?ImBJ3o9J78/Ao7iPxzJNBW04mY45aVShBI4hQOnucqGLD5DoSiQ3xirldmji?=
 =?us-ascii?Q?rr75NVgUpvto+M0VwZPO/VfTEg8W90Jw4VYXOVhPwOQ4d0l7LZYXSWZAn5ik?=
 =?us-ascii?Q?JpHBx7XHWPQBUbirD1AAhUmcGa5C/fIwIgAqB/vRnr8bwohxWWtpY9wCk9Ut?=
 =?us-ascii?Q?r2VAeQKSoooUEic1jGeIfsQjvKFCab1cK8AK2J9k7w7skgj+wjNF0XHfqhMN?=
 =?us-ascii?Q?5lEKBFtMPan/KZ4SqUndUWZdTLbeUaZCSC3g9NtLHceL32oDk2YzAFCyxF/2?=
 =?us-ascii?Q?C0YK3UwzITyM3cD7VHImgp3Feo/0l9/sxtfZ7IDfzg2aRyU3N45vT6TMgWvF?=
 =?us-ascii?Q?OtpKOZYmvBLBrq0RGeLTZAJsc/3jYfh8hR3WDgUjmviF1Svos7DeaM5jSKmC?=
 =?us-ascii?Q?fZa+hE9FTfYNx0d1C4SZvEIo2I1UvvKs96VHPZBYEIEzIWVtr8nPg0W/6yFB?=
 =?us-ascii?Q?k5+CEndHaWGSRsqy8mZ6xallXu9GfIJPuZugypDgxbFGlDeqxtx39Ox2NQNK?=
 =?us-ascii?Q?tasIIrko7UxKLmQQr6Hsbk+7eGr8vFd9m+Fp5MC0W8Mey/awaqHkhE/yN+4R?=
 =?us-ascii?Q?PfiYdhiSwzHB8FNLbGxDto3PI1LYf+VNXNBE3VQ368ZU+7UcJqoT9hDLJh3L?=
 =?us-ascii?Q?DgrvybzJqvWbCpzF+Hyfuc4j/cGtHbLn+jtCKbq1TEPZInGcFuFexRniCDp8?=
 =?us-ascii?Q?Eb+tsD36gQWw4+Tl2O9s0D7bgGPhHs4UvGvsR8Wur6GqacFXGoWvZXLCx2CC?=
 =?us-ascii?Q?Fw254cZmHpZVxtvOv35+t7UnPWTUGcNAcIsQ2TviZXoGas/x5ISeCHnjP1Ga?=
 =?us-ascii?Q?8b3pUJmgq80MfD/+5gxa39booV9l?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:58:47.2146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a433dfd5-0bc7-438f-2658-08dc64776d0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918

Currently, the enforce_vmpl0() function uses a set argument when modifying
the VMPL1 permissions used to test for VMPL0. If the guest is not running
at VMPL0, the guest self-terminates.

The function is just a wrapper for a fixed RMPADJUST function. Eliminate
the function and perform the RMPADJUST directly.

No functional change.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/compressed/sev.c | 35 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 5ad0ff4664f1..0457a9d7e515 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -335,26 +335,6 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 }
 
-static void enforce_vmpl0(void)
-{
-	u64 attrs;
-	int err;
-
-	/*
-	 * RMPADJUST modifies RMP permissions of a lesser-privileged (numerically
-	 * higher) privilege level. Here, clear the VMPL1 permission mask of the
-	 * GHCB page. If the guest is not running at VMPL0, this will fail.
-	 *
-	 * If the guest is running at VMPL0, it will succeed. Even if that operation
-	 * modifies permission bits, it is still ok to do so currently because Linux
-	 * SNP guests are supported only on VMPL0 so VMPL1 or higher permission masks
-	 * changing is a don't-care.
-	 */
-	attrs = 1;
-	if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, attrs))
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
-}
-
 /*
  * SNP_FEATURES_IMPL_REQ is the mask of SNP features that will need
  * guest side implementation for proper functioning of the guest. If any
@@ -588,7 +568,20 @@ void sev_enable(struct boot_params *bp)
 		if (!(get_hv_features() & GHCB_HV_FT_SNP))
 			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 
-		enforce_vmpl0();
+		/*
+		 * Enforce running at VMPL0.
+		 *
+		 * RMPADJUST modifies RMP permissions of a lesser-privileged (numerically
+		 * higher) privilege level. Here, clear the VMPL1 permission mask of the
+		 * GHCB page. If the guest is not running at VMPL0, this will fail.
+		 *
+		 * If the guest is running at VMPL0, it will succeed. Even if that operation
+		 * modifies permission bits, it is still ok to do so currently because Linux
+		 * SNP guests running at VMPL0 only run at VMPL0, so VMPL1 or higher
+		 * permission mask changes are a don't-care.
+		 */
+		if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, 1))
+			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
 	}
 
 	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
-- 
2.43.2


