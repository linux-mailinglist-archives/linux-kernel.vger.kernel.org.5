Return-Path: <linux-kernel+bounces-40745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DFC83E513
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C511C232A0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CF555C37;
	Fri, 26 Jan 2024 22:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XUtj3Y+u"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581D955797
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307426; cv=fail; b=o3Xt/PBsevRqcyUDrLpFhjedGaeZ1s/29aqaaAeRPfpFOM05JJPQpYaaxraFPenUBsFwR4pIrboIeKnWiVwpHU3O9J2+fFGlr3SL8Vr3h4jJ2ckZxql1YfSKmIwBvfzZiI3dlfKqCjtVVTCXmRR6Pan7WXXZ+QFaamsC+83TIy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307426; c=relaxed/simple;
	bh=oq7YfFD2dDgLtmFugXOCuVkrbCbu3KiOTFU9CGemJhQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V+Y7Jpr+Hejuvf23ZDYd+Yl1SADrq0SeCINK4qIZLw1oPOXOKr2IY2MZn08JM6nDoqh+tOOi3V6pJIbJuay3cEXg7uTn+mAPpNC9E2nyQnePNWeQ7Xw/fQopSxNrRHa7idMm/pLMeRBP4Jr7Y30URtsI38r5PsnKJe88BnACxDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XUtj3Y+u; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ey2/y6PURau74jarG44Qct48JwldZ0FEl+pTkSIwQDf1AT6w1B9QjAcpjy56jAUZM9UcrV7rZ63/KASehYF6RbVS7XfppYkLUQGHoM5ZqPbXFSZhrJnstLCAwPw/JDMKbtcUKcO9a/GoFqKt1ydHXZLpUdIf1EyVqilBbhCPNqKrWQmgYNGCRJJU4m7TiStrAruWGwWnVrzh7xyS+aMcSBDwyxH+I17tSz+PgqbjfHkA5H6DijsfR1JEawxzrS3o3/7+dfUvZ0tJJ9y6Tn6lHord0cnmovtdCFtEzVn97d+FA8DA3Dib7gUavJv2sQWuhyDOFTu96LqSxke9VqZS+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ky/2oTXlLBO58QPkIvtKmVm+qw3qmD3XCklbrcvsxII=;
 b=QMWAva9xdTnSN9RnijUCA7iUM0XLLDXKQ+zn21RXeTKv/RbSItXKEkGr7xoo7yjTsII4FnWOygR9/8QkFUSkyOSukKf+bW6G2BaLxU+vJGCVWL3YqU9nwsJnC+6RQO52GMJ9ctLU9SqXpsmO1wt1vtYl3aJTjt9OR216yHPEAbq/qlCsMmyY62ISgm+kNiqWTwMHWK2CTq5OZ2lpgk3LGwLGuDpr6DED//O0lQOL5HwXDpxUxWYfrEPzuvFKk4eKI3AkFURWLF6Ex+bxSI8BIU0ni/2ae38xrujaW/EmUK81ZmpLuzdPaByZ9PsZVs301VK23B1/Rojk5FlUsfDvKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ky/2oTXlLBO58QPkIvtKmVm+qw3qmD3XCklbrcvsxII=;
 b=XUtj3Y+uV8W67wsXXrpUuXr14ngM3kNfhUSZsSbAAZOHP8LkSa/hbllVC3Kc9Y1QETO3ohsRDkV7B+Ak4Pq4hVahbggpPkWxMpR0hsuDN3eIHTaMeQ/ZH5CvObOlva2jO8kRbwjcpxwfrWlw4dSKlGnIq7xMud2DtqvmA3z1w4A=
Received: from DM5PR07CA0072.namprd07.prod.outlook.com (2603:10b6:4:ad::37) by
 PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 22:17:02 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:4:ad:cafe::f0) by DM5PR07CA0072.outlook.office365.com
 (2603:10b6:4:ad::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26 via Frontend
 Transport; Fri, 26 Jan 2024 22:17:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 22:17:01 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 26 Jan 2024 16:17:00 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH 07/11] x86/sev: Provide SVSM discovery support
Date: Fri, 26 Jan 2024 16:16:00 -0600
Message-ID: <2518c82f24f3e5d7533eea72512cea9ce985704b.1706307364.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1706307364.git.thomas.lendacky@amd.com>
References: <cover.1706307364.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|PH7PR12MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: cff1de95-a4d2-4c0e-d588-08dc1ebc8522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SXSlH4D8/AeaUUKxr9VHGIb5taeo6Om/aqe9/vERlGVEXvFihKTl7d22LwP/IODMuMdJUEBg0RaiiFOOH7Ln+NDGa7R01+HyMSsBOoay03A6sBLfHLCw10ROXc19sN5WgFJnem/XdLumZW5KVVcix1HKKpO6AKBTjdVgZIFbFpvfewg5yj0OT6VeBeskt4kB7TKNKG2+s3JL3MJ5YmbjGeBZ5xc5ZKndEdDOhoBubDEus8a8470vlw8LYadOhCU7desJefXE58lMeXnyEWM6ZRY5wTQ5055dtasVqqA3T+a9iCADGP3Mz5Rf1crGFtLPjB2MieKsZl4GFABEjH/r3ZvmhvgmKUCEctYJLPrALNok2WBHQITheJ3IJrq+mmHcOkUyqDPapx+E4GLFEuGkfioIscZXW8i/xHvYgB3zkEP8hxLBOgOscVsdtgg+p5RXha8+Pq2fSDdF/ftIkKTjL8VR0w6yGARIbgg6/RltRay18ywxH3ODgUHlEuIDqzjCn8LEMn3NrU2kZqayuRRagVjEiZe1tO6B7O3NlTPR09YYkqKAKRYSvMdXNu3eMOrbtUeH66xLk4WdjbaQ3cQh7aDTNtTlYyrEb1gNc0iHvKpOtbVCgZ4zO9N4bnkieJFUVCfxjFaFw3XPZQqrnec7kasLhwI0HD1KdRl8PsgiexrE33JKEkwAID7kkQ8xR5PoR4t+iYdaTzstyXOzSKVyavoj5wb8ksciCKTy2Zyyo7g87xlJku0/i+jX6FvMvObVpoIAg483HeshD4tYPpfTXg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(82310400011)(186009)(64100799003)(1800799012)(451199024)(36840700001)(40470700004)(46966006)(2906002)(40480700001)(40460700003)(36860700001)(478600001)(7416002)(5660300002)(83380400001)(356005)(70586007)(110136005)(316002)(2616005)(54906003)(36756003)(4326008)(41300700001)(8676002)(8936002)(86362001)(426003)(16526019)(336012)(26005)(81166007)(70206006)(82740400003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 22:17:01.5324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cff1de95-a4d2-4c0e-d588-08dc1ebc8522
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5757

The SVSM specification documents an alternative method of discovery for
the SVSM using a reserved CPUID bit and a reserved MSR.

For the CPUID support, the #VC handler of an SEV-SNP guest should modify
the returned value in the EAX register for the 0x8000001f CPUID function
by setting bit 28 when an SVSM is present.

For the MSR support, new reserved MSR 0xc001f000 has been defined. A #VC
should be generated when accessing this MSR. The #VC handler is expected
to ignore writes to this MSR and return the physical calling area address
(CAA) on reads of this MSR.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/msr-index.h |  2 ++
 arch/x86/kernel/sev-shared.c     |  4 ++++
 arch/x86/kernel/sev.c            | 17 +++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index f1bd7b91b3c6..4746135cbe21 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -622,6 +622,8 @@
 
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
+#define MSR_SVSM_CAA			0xc001f000
+
 /* AMD Collaborative Processor Performance Control MSRs */
 #define MSR_AMD_CPPC_CAP1		0xc00102b0
 #define MSR_AMD_CPPC_ENABLE		0xc00102b1
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index f26e872bc5d0..9bd7d7e75b31 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -628,6 +628,10 @@ static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 		/* node ID */
 		leaf->ecx = (leaf->ecx & GENMASK(31, 8)) | (leaf_hv.ecx & GENMASK(7, 0));
 		break;
+	case 0x8000001f:
+		if (vmpl)
+			leaf->eax |= BIT(28);
+		break;
 	default:
 		/* No fix-ups needed, use values as-is. */
 		break;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index ddb9141f0959..121a9bad86c9 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1326,12 +1326,29 @@ int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
 	return 0;
 }
 
+static enum es_result vc_handle_svsm_caa_msr(struct es_em_ctxt *ctxt)
+{
+	struct pt_regs *regs = ctxt->regs;
+
+	/* Writes to the SVSM CAA msr are ignored */
+	if (ctxt->insn.opcode.bytes[1] == 0x30)
+		return ES_OK;
+
+	regs->ax = lower_32_bits(this_cpu_read(svsm_caa_pa));
+	regs->dx = upper_32_bits(this_cpu_read(svsm_caa_pa));
+
+	return ES_OK;
+}
+
 static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 {
 	struct pt_regs *regs = ctxt->regs;
 	enum es_result ret;
 	u64 exit_info_1;
 
+	if (regs->cx == MSR_SVSM_CAA)
+		return vc_handle_svsm_caa_msr(ctxt);
+
 	/* Is it a WRMSR? */
 	exit_info_1 = (ctxt->insn.opcode.bytes[1] == 0x30) ? 1 : 0;
 
-- 
2.42.0


