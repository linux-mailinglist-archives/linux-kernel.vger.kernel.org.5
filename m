Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019747AE45F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 06:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjIZEGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 00:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjIZEGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 00:06:10 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7ACBF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:06:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V36jKDHAtl0u3NtVXDDzr9L38Zw56gNQjRAbXaZQyGwBEMuixYbX92iB3DgC5c8z9EkJ+n/GeVhcpwkU+ACT2eMN0xbOg6oVKb2x/Q5Eb1LpdMGHT7FyFNOyzwFUXP3YaHghNsUgPSec0IsNfR7JKktIAybO9sA1z+yqYppzDzLOtPHqtL2go13TsCwWTq5PQW4bIHgfbv+blmMcEKcuANMXp9zya+5USQ+iF9Hr9yBBUswda0Z0nxKLrKfd6dOrE25GNtkmpQy9oLfTNUh/svyonwuozttQpSdPg7CJIH4ueVoaP7r4v7yuvbgdYgfs/ZaChw0VkWxgybwLYVgB7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDHx3oIT50QBFPLD8JBgm7y1V4LVPreLa0eRUXgfjjg=;
 b=CvTAdT5GY310VAzJJYfzWL3CN2J3zlkRBi82xUp9pmUSjRLckv0PTV0BKBCLkIjRk7nNn/Rxx5/gBXVm/KQ19e7nwxmSHZPiPru7tvF5LX7PILw2udyjbyDoAATy+Qc36xSsaDSYFjwJ7k4hUHa7heMcz8P1EYvLZARu1dsSeHbSgAcKPjAQIXXceT0+ANzw+iQqDMggFMHQyByhuNliQ2py1KgcUTCYr3gg2gxby2PEutdBKOLJzZZPaZLHHLUGjLBoU1nhj+4ULJfyrGP15FVnYrjsKSkFxv/+ZUHD71APY2xg6CtT+pwTVB4eMe9mJn9gdnO+1uYzdZWufej+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDHx3oIT50QBFPLD8JBgm7y1V4LVPreLa0eRUXgfjjg=;
 b=j1rqv3N/AR7JG3y36udLBCzrcYF25Sgo2G+Bhbcge+QIgduCa5L6GvOxstuC7miSitdDROqadYj1lC8s3DQgyo1pyh7uEdOYM7GAXkrog0ecZwidBN6ryAvhPV+CoRbtN8gpf7xOvG9+oYh2lU95rD5TfI1SRVL72p8QRvYsZm0=
Received: from DS7PR05CA0083.namprd05.prod.outlook.com (2603:10b6:8:57::29) by
 CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Tue, 26 Sep 2023 04:05:55 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:8:57:cafe::77) by DS7PR05CA0083.outlook.office365.com
 (2603:10b6:8:57::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.19 via Frontend
 Transport; Tue, 26 Sep 2023 04:05:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 04:05:55 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Sep
 2023 23:05:39 -0500
From:   Alexey Kardashevskiy <aik@amd.com>
To:     <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Alexey Kardashevskiy" <aik@amd.com>
Subject: [PATCH kernel v2] x86/compressed/64: reduce #VC nesting for intercepted CPUID for SEV-SNP guest
Date:   Tue, 26 Sep 2023 14:05:26 +1000
Message-ID: <20230926040526.957240-1-aik@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|CH2PR12MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: 9141b7c5-52ad-4bf9-cbe0-08dbbe45e201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kGjV/4zUpWKklTPPiHqIDHU603h9mHsmLXNxagax5LMFVIqjSLju9itG3lbK8YgPlxjxmVwRn3N9HfUdIrF0IzlzwOzRPj+OED2baC+7An1dfu02olIid1aSppAga5W6BVL/0KKePV/gN4onTj2JY+FtAgtffDRuCu57DVLhASzWSlGnPOo7hBPIdxQX0qdBEpwnS4AIycCcHNN3Kr9a5zneCg5+1AoR0WyoUQHio1C19Qp07NzH9Eoqmyz2VDZuN6cZpmi4Rq6JMhi+KcxdO4efODRRo4VQhd7kGqpI3NQh2w6Ub6wMiGsGG651u5JT/gA5grw8V4UsbhRdXKxegHOQ/V8xRdEta11y87CnSeqSvJrwh/VOAX55OKfSz7+jtOYatv8t5RoW1LT9FInfhSUH/w8Cqp/C68YIZSx9y8jdj7ZQ820cb/qRFenJoMKjWanXqpsS7GBCluuR/bj5xoluVlHWu6CAqSpquaEgAotO51nRN6CdGQyIsecbJ3R1B7ZhaZNlPeXfoQVABOdoNM289fry8ArUrpFtUsA3wLoOh1Ou3ZGbjnsN/mx2YYrHSWZ2bWk4Jif2cIi/zSYGxB6ZcCQMHHtTURDHyqw/uF6KHpoD1OQ+y4u/c4crrnDUkQU9GzEaqY/yLVlQ9MsdDwBCtZigBHR+nKSowtT7/+va3KmKApR4tYN2x7oreXQoe3mQLCgDT4h7NAdxvB/XVSuOL5n1UNp5+9po05KdLfM82cB15Akz+HR31apUx/02WRNTiBTzVGUBXY2L7SuTsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(186009)(82310400011)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(2906002)(47076005)(83380400001)(36860700001)(356005)(82740400003)(81166007)(70206006)(70586007)(54906003)(966005)(6666004)(5660300002)(26005)(16526019)(336012)(1076003)(316002)(426003)(6916009)(41300700001)(7696005)(478600001)(8936002)(8676002)(4326008)(2616005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 04:05:55.6065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9141b7c5-52ad-4bf9-cbe0-08dbbe45e201
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For certain intercepts an SNP guest uses the GHCB protocol to talk to
the hypervisor from the #VC handler. The protocol requires a shared page so
there is one per vCPU. In case NMI arrives in a middle of #VC or the NMI
handler triggers a #VC, there is another "backup" GHCB page which stores
the content of the first one while SVM_VMGEXIT_NMI_COMPLETE is sent.
The vc_raw_handle_exception() handler manages main and backup GHCB pages
via __sev_get_ghcb/__sev_put_ghcb.

This works fine for #VC and occasional NMIs. This does not work so fine if
the #VC handler causes intercept + another #VC, if NMI arrives during
the second #VC, there are no more pages for SVM_VMGEXIT_NMI_COMPLETE.
The problem place is the #VC CPUID handler. Running perf in the SNP guest
crashes with:

Kernel panic - not syncing: Unable to handle #VC exception! GHCB and Backup GHCB are already in use

vc_raw_handle_exception #1: exit_code 72 (CPUID) eax d ecx 1
We lock the main GHCB and while it is locked we get to
snp_cpuid_postprocess() which executes "rdmsr" of MSR_IA32_XSS==0xda0 which
triggers:

vc_raw_handle_exception #2: exit_code 7c (MSR) ecx da0
Here we lock the backup ghcb.

And then PMC NMI comes which cannot complete as there is no GHCB page left
to use:

CPU: 5 PID: 566 Comm: touch Not tainted 6.5.0-rc2-aik-ad9c-g7413e71d3dcf-dirty #27
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown unknown
Call Trace:
 <NMI>
 dump_stack_lvl+0x44/0x60
 panic+0x222/0x310
 ____sev_get_ghcb+0x21e/0x220
 __sev_es_nmi_complete+0x28/0xf0
 exc_nmi+0x1ac/0x1c0
 end_repeat_nmi+0x16/0x67
...
 </NMI>
 <TASK>
 vc_raw_handle_exception+0x9e/0x2c0
 kernel_exc_vmm_communication+0x4d/0xa0
 asm_exc_vmm_communication+0x31/0x60
RIP: 0010:snp_cpuid+0x2ad/0x420

Add a helper similar to rdmsr_safe() for making a direct hypercall in the SEV-ES
environment. Use the new helper instead of the raw "rdmsr" to avoid the extra
#VC event.

Fixes: ee0bfa08a345 ("x86/compressed/64: Add support for SEV-SNP CPUID table in #VC handlers")
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---

This is made on top of (which has the "efi/unaccepted: Make sure unaccepted table is mapped"
fix for booting SNP):
b996cbe1203c (tip/master) 15 hours ago Ingo Molnar Merge branch into tip/master: 'x86/tdx'

plus:
https://lore.kernel.org/lkml/a5856fa1ebe3879de91a8f6298b6bbd901c61881.1690578565.git.thomas.lendacky@amd.com/


rdmsr_safe_GHCB() is in arch/x86/include/asm/svm.h as this is where
the ghcb struct is defined.


---
Changes:
v2:
* de-uglify by defining rdmsr_safe_GHCB()
---
 arch/x86/include/asm/svm.h   | 14 ++++++++++++++
 arch/x86/kernel/sev-shared.c |  5 +++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index fb8366af59da..866ef7d6b7a9 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -673,4 +673,18 @@ DEFINE_GHCB_ACCESSORS(sw_exit_info_2)
 DEFINE_GHCB_ACCESSORS(sw_scratch)
 DEFINE_GHCB_ACCESSORS(xcr0)
 
+/* Paravirt SEV-ES rdmsr which avoids extra #VC event */
+#define rdmsr_safe_GHCB(msr, low, high, ghcb, ctxt) ({				\
+	int __ret;								\
+										\
+	ghcb_set_rcx((ghcb), (msr));						\
+	__ret = sev_es_ghcb_hv_call((ghcb), (ctxt), SVM_EXIT_MSR, 0, 0);	\
+	if (__ret == ES_OK) {							\
+		low  = (ghcb)->save.rax;					\
+		high = (ghcb)->save.rdx;					\
+		/* Invalidate qwords for likely another following GHCB call */	\
+		vc_ghcb_invalidate(ghcb);					\
+	}									\
+	__ret; })
+
 #endif
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index e73c90c9cc5b..b3fb9d0a07c6 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -479,8 +479,9 @@ static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 			if (leaf->eax & BIT(3)) {
 				unsigned long lo, hi;
 
-				asm volatile("rdmsr" : "=a" (lo), "=d" (hi)
-						     : "c" (MSR_IA32_XSS));
+				if (rdmsr_safe_GHCB(MSR_IA32_XSS, lo, hi, ghcb, ctxt) != ES_OK)
+					return -EINVAL;
+
 				xss = (hi << 32) | lo;
 			}
 
-- 
2.41.0

