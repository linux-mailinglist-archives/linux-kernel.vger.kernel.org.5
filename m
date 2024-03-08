Return-Path: <linux-kernel+bounces-97460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAF4876AC6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 233F2282E8F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524F62C194;
	Fri,  8 Mar 2024 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ry6Az/cf"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D347729D01
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709922964; cv=fail; b=Cd1iKkrDnLpVnzDWMYYkkk9sG1+9yVdhOAk8Qe8K3Acdht3G5/JqF36rXYmsgtm2uFRhHtHZvDzKaKgWZyrNnUqBaiHMl7RFpHgj8bgar9NT5KYH8hM91fNPcYoQ9a1RDpNZN5BMf5iWYXIdrsHHYYbeYFKU8NqLWwVZP76D4PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709922964; c=relaxed/simple;
	bh=eP4BphBxVDxrrwu0NaUxE+TSSXfmjzX5mn3cDTAmeWk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bKZoq6XNFsYidwqpKgU52hqCPCWkNFE0T7BwdEv1zZk+Vbu+xRKBt1D2/nLmCbIyLdQLjYBH1CzvQNbEhmGFDNqgJAdlgHBu60FsIoDygiJYvYeiCPmXHSJsfPgskYS0iydlFnnt+kRT9zKpVBcV8sD/HW6BiIRpN0q6UfP8ey4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ry6Az/cf; arc=fail smtp.client-ip=40.107.96.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DywOe+VSO1eSrwRuCm6IsU/2MmNma6Mj6rCO9lILYlTNjALzthX1SQRaJlW44aBV2LXQgbj5i62UnXhabWQMY5Mg33hCIQ1pXUOhSRyn7LB7j8qima40kqvRIQVlLKROCh84s6KTxwO0v8g4voc++i64ynSMQcghFbeIzvr/XwMFvro5pb+on5RJqfpbR1UjqXzPjpaDY9l8YuT9T26oe01NMMX6yJU0imwvIEeQD/ZnRJPPtj+fxWDAjed2ajVkJJyfh3lhezWIAWZexT3867Lct5CXy08K89G3G+b66hy/y6WjltNkBHT+bP/t7t/GITORyoPBL+KKnviGSV/MxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7nW4DhcYa9YyIilkj8vaJ0o/fm5XdPzRgmF95RRLmY=;
 b=FVT0E+uASMfkR/KnvAhNzRcTrSkzb7FFIGus3GZdkLg+RuARK9kLMAepgWjqu+zedvp9QqACAhNQhSPEykF+xkFiSTOnUODvQXqc93kixzvBE/KfBJ728+iicKEYGgudajHxsNcKuB9nzlk0+G5QavgnRLfTRtcHccQIl0xdPuLXTcIAFjeUSab09gTNvIDLhSrGWTNHRCtRjmOsV+W/26fLNGXFzcJFM6gKiJVgdJwuF3nwG2gXdvHG3w9/KXmH7z7BcXAdjmuNAUBsUN1SoVg24gb5O6RPgMfjd4AqTBUZWNVZO5YTbIbRSEKzIqzOnTeiNwNJ+nfqymHxR+vVIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7nW4DhcYa9YyIilkj8vaJ0o/fm5XdPzRgmF95RRLmY=;
 b=Ry6Az/cf5kkvDJbO81/paL3eitJlCkDkGw1uIU5HXsbeSjvaegtgBrM3kwtf3MPS83oG/rS91xl9DMBkK59qtk3hfWxMyid5+DMSegTmFS5AMQ4klZoKIankQQYKh5GeeaQ0aLJqT7+0vMgRy2Bsmf5F8E2O7XKZF9/agfcwXqI=
Received: from BLAPR03CA0013.namprd03.prod.outlook.com (2603:10b6:208:32b::18)
 by CH3PR12MB8512.namprd12.prod.outlook.com (2603:10b6:610:158::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.52; Fri, 8 Mar
 2024 18:35:59 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::5a) by BLAPR03CA0013.outlook.office365.com
 (2603:10b6:208:32b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29 via Frontend
 Transport; Fri, 8 Mar 2024 18:35:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 8 Mar 2024 18:35:59 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 12:35:58 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 02/14] x86/sev: Make the VMPL0 checking function more generic
Date: Fri, 8 Mar 2024 12:35:17 -0600
Message-ID: <417c91d3c9d54deb38292ac34b47f636dd5175ac.1709922929.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709922929.git.thomas.lendacky@amd.com>
References: <cover.1709922929.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|CH3PR12MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: 022dafee-d9ba-4643-ccf5-08dc3f9e99c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o28W2+chlUg2f3KyUnB+2k0nmyJbA/agWQqVLusjHu62vO0VgB9GHEhkZsIeyfbWjbp+PP+SjGKjIKnbPE/eRoy6XLi1G44cQM/DymBdRRpUxBSxHabKFa7xPgxp4gyrU9QZNfjGwh2WmzC6N0ZCYLF48x9CAtkHROysX6ZxRC8H218IPz12hgx8zyFdf6myam0jtIP1tZczxhNBlTPOXgV2Jsws//SzOGM/5AWCcWXDbZXaOgBKp/3HU3y8CKQ+ZyDueKbk0iY28Go0Sy+WD6a+SJZkmbW9Mk0iyJDh1nXYynJ3dyfsG5JnLgFJCiXTb6wuss/P0O9Z5NxswiHegYn0uw1MnGHUUeid4+lOM5JAJGjb/ZdGlthkDg482r3R25uRhg28tPdojbm7zYqLD2OF9S5P+3pdblHCt7cOXKB1Kz/wzNjfmb8wJh+eWdIo3fvEaFbDcAQhngeBTTz8CF+Wetsaj+my3CSdcGuWSDaCchHapT8O0v6mW40c4oNpMMsPP8vYIXHzXlcHClSyrurndaIsjp8W2C6OwE7X/fWiizwhVBvm7xJ/7QRYTyezmCWHH9+g120mPFN+1tE9msiVzYDL7Sau/X4MZr1R+M1dVZk5y4gynSURnbyrcmMCEzuehqoSGxSBBdyWnWigbl1LZuPj5auORbO/MrzfEv6KUSoKwVa/UyjktoU110YMta1zNVScjEFLsAr9iCOMlc8Yq584zTKcfWIcMuW4PjOS4ei55UjQvotQw8TVf3nK
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(7416005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 18:35:59.6179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 022dafee-d9ba-4643-ccf5-08dc3f9e99c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8512

Currently, the enforce_vmpl0() function uses a set argument when testing
for VMPL0 and terminates the guest if the guest is not running at VMPL0.

Make the function more generic by moving it into the common code, renaming
it, allowing it to take an argument for use in the VMPL0 check (RMPADJUST
instruction) and return the result of the check, allowing the caller to
determine the action taken based on the result.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/compressed/sev.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index bec0bbfc6403..bd7222aad540 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -335,10 +335,9 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 }
 
-static void enforce_vmpl0(void)
+static bool running_at_vmpl0(void *va)
 {
 	u64 attrs;
-	int err;
 
 	/*
 	 * RMPADJUST modifies RMP permissions of a lesser-privileged (numerically
@@ -347,12 +346,11 @@ static void enforce_vmpl0(void)
 	 *
 	 * If the guest is running at VMPL0, it will succeed. Even if that operation
 	 * modifies permission bits, it is still ok to do so currently because Linux
-	 * SNP guests are supported only on VMPL0 so VMPL1 or higher permission masks
-	 * changing is a don't-care.
+	 * SNP guests running at VMPL0 only run at VMPL0, so VMPL1 or higher
+	 * permission mask changes are a don't-care.
 	 */
 	attrs = 1;
-	if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, attrs))
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
+	return !rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
 }
 
 /*
@@ -588,7 +586,8 @@ void sev_enable(struct boot_params *bp)
 		if (!(get_hv_features() & GHCB_HV_FT_SNP))
 			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 
-		enforce_vmpl0();
+		if (!running_at_vmpl0(&boot_ghcb_page))
+			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
 	}
 
 	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
-- 
2.43.2


