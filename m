Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A89A76776E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 23:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjG1VJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 17:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjG1VJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 17:09:49 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B1E449C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 14:09:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+Ji5hpTJaMNfxKFeEYxV2bvEx6u8wTQ0Sf9Pb0kDo9GATSRCLRjQIOiGl2EifPsH4ZP1ivDnmfSHUCiWO5754UHYICO8+7ZwpZ01kgKHgqzmO6GzWuoEfTLS/NzIxp2iMJ+egZR7LuxXwEyUAZCTeDoqeaVJtdTng4R2gpTHosr8X/xiBV5RUexB6bkuu72uF51aam9LZv9d6AQ4tIADiHBZYD1T7l1OShvTqZtODfoCibtVKYtMb+iwTSJfueZSR5B59k2/Sb+Xlok08fj6pwDGFM6mioqeSb1STpSW0QLwnGvcqVJykC2rvSUDrN4ABMLRDdfGt46J+5e+dD1Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yngjZkfD6mNO9aDMYuUIUbXhFRAqO24mWEFww60SLD8=;
 b=EX8Q0kqjKFuiaInA8sLNoU55DR1gwoostlu8quTavNaD8lY4+i821zu5tsWPiju+x9FIZ6XzjLEA6dI81AdcLn9P5+qQDbDGUkElkyoIYguqaVu9j87aFR9E92m8iCJl86e8K1nu6oFhxuF7LDHTzHSjCq325vPkIXFgnRyA5OScOAZydnKrcILFe/pgXGxuKbJePfsT7p87XdvHUXF1wJwtBhtYJAWGfEF0caccZaZukesY8orpdMWEJD2D1ihmrxyZBkSEpknEf4QWzViJ1qOCVh7wATOiY+8dJl0zIHFPuxGAeuP36dq5IBsMXKblQwbVC5HXtv9NYrxV5gj6Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yngjZkfD6mNO9aDMYuUIUbXhFRAqO24mWEFww60SLD8=;
 b=UbHNOuEVU1n7liuhlsFHNI8x/wab9k+7MwOagih46FI6dsxVyDAvEdkVeVbivcMwmCutZNPWj2FYhh5Y2QqhngVft9KRn0leItrJBnje3V4KtsPKoQohqL5Pjtb3J3xflLojcWNxs5vnZ3S/gZVsdlK0MWWCaCusSRmN1twOpGs=
Received: from CYZPR10CA0024.namprd10.prod.outlook.com (2603:10b6:930:8a::8)
 by MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 21:09:45 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::29) by CYZPR10CA0024.outlook.office365.com
 (2603:10b6:930:8a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.35 via Frontend
 Transport; Fri, 28 Jul 2023 21:09:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Fri, 28 Jul 2023 21:09:44 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 16:09:43 -0500
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH] x86/sev: Fix SNP CPUID requests to the hypervisor
Date:   Fri, 28 Jul 2023 16:09:26 -0500
Message-ID: <a5856fa1ebe3879de91a8f6298b6bbd901c61881.1690578565.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|MN0PR12MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: cf358f4c-31d4-4ce8-b5a4-08db8faef7c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fVFpOnHGYxZtsnRJrkQX6kpr7IJ8GlakblSqZtLMXpDqggcOTwzIyEHDzxmd49Qys3A9Ay7pHhx9AzRG1Lbigm+HhYTYaSCjKdvqMfSN2Y2E8DN3+BfwEe/0n9TDWL1HwLNK0M97kCrbEb3bxLk0livQyo+asgOHVwy4g64FQhTFSbZre+87kcsREhYmBj5yLl9T0WFII83uT6Afgv9wUeSeB61NzqlmmAuLxOAeRkIBzRr/jJ8jjyzFYdtW9tsfDuWYlxqa/5B/X8qHBbBfNGU04Kg1/pn/oZ8RIfifB8+2Vnj7MxPziilr0LFhzLH+4CLw+ia3f/nyL3eAqmEvQY2bnDs3FjQO7GXqZM9uKcbG+ZywOF/opIk/ShcnK4bjf10+X3awjxsKT/f0TbV0bUi5WrZc4V+JjkAq9QUBLRiw30NuRR3WpHZizE8TxHua42qTdlZpACJOrNGwZ8wK5t72bpvVYglK3qVNIdo7+tim69oUmfA/84yH/pHJbApWEF9GmUdpsCkm34bUlY3lqzzKE4Nxdl5TMMs2N86rYae1Q+C2vMXAbeBl/P8VJGpnr5+ZekBjC/7QD4vfXo3aOKy7h8fteDt6bokZsDXd72+RCN0rAPMFRGX68T4NpNX8IZcROeegaZgZRVbvv9EHEajPu2WNwpLcrWs/ceGXghKK3O0EtfwTStSAnrWkwixcH7BiPXqrfA8MGef8nASw8NSfadraN2ESl54vsHZfuZQfjjiNGydM6wg9PENqclQGhPzgOoZMB/B92eIggkdKhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(26005)(356005)(54906003)(478600001)(82740400003)(110136005)(16526019)(186003)(336012)(426003)(81166007)(6666004)(47076005)(70586007)(4326008)(2616005)(83380400001)(36860700001)(70206006)(40460700003)(5660300002)(41300700001)(316002)(2906002)(8936002)(8676002)(40480700001)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 21:09:44.5777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf358f4c-31d4-4ce8-b5a4-08db8faef7c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SNP retrieves the majority of CPUID information from the SNP CPUID page.
But there are times when that information needs to be supplemented by the
hypervisor, for example, obtaining the initial APIC ID of the vCPU from
leaf 1.

The current implementation uses the MSR protocol to retrieve the data from
the hypervisor, even when a GHCB exists. The problem arises when an NMI
arrives on return from the VMGEXIT. The NMI will be immediately serviced
and may generate a #VC requiring communication with the hypervisor. Since
a GHCB exists in this case, it will be used. As part of using the GHCB,
the #VC handler will write the GHCB physical address into the GHCB MSR and
the #VC will be handled. When the NMI completes, processing resumes at the
site of the VMGEXIT, which is expecting to read the GHCB MSR and find a
CPUID MSR protocol response. Since the NMI handling overwrote the GHCB MSR
response, the guest will see an invalid reply from the hypervisor and
self-terminate.

Fix this problem by using the GHCB when it is available. Any NMI received
is properly handled because the GHCB contents are copied into a backup
page and restored on NMI exit, thus preserving the active GHCB request or
result.

Fixes: ee0bfa08a345 ("x86/compressed/64: Add support for SEV-SNP CPUID table in #VC handlers")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/sev-shared.c | 69 ++++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 2eabccde94fb..e73c90c9cc5b 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -256,7 +256,7 @@ static int __sev_cpuid_hv(u32 fn, int reg_idx, u32 *reg)
 	return 0;
 }
 
-static int sev_cpuid_hv(struct cpuid_leaf *leaf)
+static int __sev_cpuid_hv_msr(struct cpuid_leaf *leaf)
 {
 	int ret;
 
@@ -279,6 +279,45 @@ static int sev_cpuid_hv(struct cpuid_leaf *leaf)
 	return ret;
 }
 
+static int __sev_cpuid_hv_ghcb(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+{
+	u32 cr4 = native_read_cr4();
+	int ret;
+
+	ghcb_set_rax(ghcb, leaf->fn);
+	ghcb_set_rcx(ghcb, leaf->subfn);
+
+	if (cr4 & X86_CR4_OSXSAVE)
+		/* Safe to read xcr0 */
+		ghcb_set_xcr0(ghcb, xgetbv(XCR_XFEATURE_ENABLED_MASK));
+	else
+		/* xgetbv will cause #GP - use reset value for xcr0 */
+		ghcb_set_xcr0(ghcb, 1);
+
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_CPUID, 0, 0);
+	if (ret != ES_OK)
+		return ret;
+
+	if (!(ghcb_rax_is_valid(ghcb) &&
+	      ghcb_rbx_is_valid(ghcb) &&
+	      ghcb_rcx_is_valid(ghcb) &&
+	      ghcb_rdx_is_valid(ghcb)))
+		return ES_VMM_ERROR;
+
+	leaf->eax = ghcb->save.rax;
+	leaf->ebx = ghcb->save.rbx;
+	leaf->ecx = ghcb->save.rcx;
+	leaf->edx = ghcb->save.rdx;
+
+	return ES_OK;
+}
+
+static int sev_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+{
+	return ghcb ? __sev_cpuid_hv_ghcb(ghcb, ctxt, leaf)
+		    : __sev_cpuid_hv_msr(leaf);
+}
+
 /*
  * This may be called early while still running on the initial identity
  * mapping. Use RIP-relative addressing to obtain the correct address
@@ -388,19 +427,20 @@ snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
 	return false;
 }
 
-static void snp_cpuid_hv(struct cpuid_leaf *leaf)
+static void snp_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
 {
-	if (sev_cpuid_hv(leaf))
+	if (sev_cpuid_hv(ghcb, ctxt, leaf))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
 }
 
-static int snp_cpuid_postprocess(struct cpuid_leaf *leaf)
+static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
+				 struct cpuid_leaf *leaf)
 {
 	struct cpuid_leaf leaf_hv = *leaf;
 
 	switch (leaf->fn) {
 	case 0x1:
-		snp_cpuid_hv(&leaf_hv);
+		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
 
 		/* initial APIC ID */
 		leaf->ebx = (leaf_hv.ebx & GENMASK(31, 24)) | (leaf->ebx & GENMASK(23, 0));
@@ -419,7 +459,7 @@ static int snp_cpuid_postprocess(struct cpuid_leaf *leaf)
 		break;
 	case 0xB:
 		leaf_hv.subfn = 0;
-		snp_cpuid_hv(&leaf_hv);
+		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
 
 		/* extended APIC ID */
 		leaf->edx = leaf_hv.edx;
@@ -467,7 +507,7 @@ static int snp_cpuid_postprocess(struct cpuid_leaf *leaf)
 		}
 		break;
 	case 0x8000001E:
-		snp_cpuid_hv(&leaf_hv);
+		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
 
 		/* extended APIC ID */
 		leaf->eax = leaf_hv.eax;
@@ -488,7 +528,7 @@ static int snp_cpuid_postprocess(struct cpuid_leaf *leaf)
  * Returns -EOPNOTSUPP if feature not enabled. Any other non-zero return value
  * should be treated as fatal by caller.
  */
-static int snp_cpuid(struct cpuid_leaf *leaf)
+static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
 
@@ -522,7 +562,7 @@ static int snp_cpuid(struct cpuid_leaf *leaf)
 			return 0;
 	}
 
-	return snp_cpuid_postprocess(leaf);
+	return snp_cpuid_postprocess(ghcb, ctxt, leaf);
 }
 
 /*
@@ -544,14 +584,14 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 	leaf.fn = fn;
 	leaf.subfn = subfn;
 
-	ret = snp_cpuid(&leaf);
+	ret = snp_cpuid(NULL, NULL, &leaf);
 	if (!ret)
 		goto cpuid_done;
 
 	if (ret != -EOPNOTSUPP)
 		goto fail;
 
-	if (sev_cpuid_hv(&leaf))
+	if (__sev_cpuid_hv_msr(&leaf))
 		goto fail;
 
 cpuid_done:
@@ -848,14 +888,15 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	return ret;
 }
 
-static int vc_handle_cpuid_snp(struct pt_regs *regs)
+static int vc_handle_cpuid_snp(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 {
+	struct pt_regs *regs = ctxt->regs;
 	struct cpuid_leaf leaf;
 	int ret;
 
 	leaf.fn = regs->ax;
 	leaf.subfn = regs->cx;
-	ret = snp_cpuid(&leaf);
+	ret = snp_cpuid(ghcb, ctxt, &leaf);
 	if (!ret) {
 		regs->ax = leaf.eax;
 		regs->bx = leaf.ebx;
@@ -874,7 +915,7 @@ static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
 	enum es_result ret;
 	int snp_cpuid_ret;
 
-	snp_cpuid_ret = vc_handle_cpuid_snp(regs);
+	snp_cpuid_ret = vc_handle_cpuid_snp(ghcb, ctxt);
 	if (!snp_cpuid_ret)
 		return ES_OK;
 	if (snp_cpuid_ret != -EOPNOTSUPP)
-- 
2.40.1

