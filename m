Return-Path: <linux-kernel+bounces-131696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1BB898B05
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AE91B2E27A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF9474C09;
	Thu,  4 Apr 2024 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AAxV0cm6"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB45D12CD8F;
	Thu,  4 Apr 2024 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243673; cv=fail; b=cq+zieElnVWkj/1j1yzYplGhqs6e+RI2XAc/nvBZ8shxtUL0dIpRCKONOioDFHjMnQ7vnBwTRABkJcfPD41T6oQLUWgvJ39csSZd5cpi0wzsKTnnPpiI7GJgG/E0pWFQm7NC+x560Et8BHgq7hSUU6KH+kuW59ZMUvfbRVhb8XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243673; c=relaxed/simple;
	bh=y76o4+UtsLidBYG3iCwFjDAYJ7mdGQqRUvl1J3GvqF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MgrNHXAbhW7sBUTewjvFVNq4I00XgheszSFKIvh8ebO0FQHYy0AHcrfCyy5t6jv4LVgGkSCTAa27fOxHhw9pcjYdwqBdRWcBPC6IM5X0xbbuv54WPBO7Zipk2I9+0skR5yA02yaas5fKNfClABJJFNNraeKz03fK3oC3iUSfNm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AAxV0cm6; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQiVBzmWGtKQAXmf4grz+0nI3nayAcdQe5lih6SZ9dhWdDNIuB4DtGNkgU5KJOiHRAZECxM5OQDDAKYneNQDKnW93h8vn22UEYHAZfxycnz0R1rJuOsWJPW95PtF9I9Vgt+q7P1J9E0QSeyp3GqC8LDTDR+lXMsPsasnrxqmqFkkhsaowql5X3X6nxz/2/ybG14Cm8yg12evPFOtFuEqekHYeiz0EI3Vrl31f0xmacJfW/lziAR0sU/3oIF54iSW6WplsHnuIiMghL9IWo9zvKMJOgIr9TqB4vQ6C+E39s29Tig34yLEd9WaKCVkjWf23sBXJTBooiJYnbKSlc9YGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iu6p98+cqmewLR13M8JOW8IGBPDT8tqFpev+EABVYV0=;
 b=l6prR83Pe1777CIQjfBQr0CbXA03IOscIjCG/mmpVCAOAf3/EWWrCWZdCEtFWgPoxuu/+v0b+yWlPwPjJZkE8bPaefZZ65g//A60cBuuDK9IDQTLyR/Xkama26qq3E/VYU29S+QCndYrd2cxB29Du8E3eiqAmSWj9KfaKEHtDJ25rpzwUABWL6WoY7LgxfdJRVpVVn/SkxY9bCzg12yYVeYpIihaFi967gX8sOhF2XAChkX6IkAu/qGfw3oaYBJ4a4i1xgVQDp2/wZswzfiW3Prnd0L1PfIBc07/ldLS6lPQYT9no/Gw5QaslIsG/QTrZVAdkRDz1NPhiupMt/qAJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iu6p98+cqmewLR13M8JOW8IGBPDT8tqFpev+EABVYV0=;
 b=AAxV0cm6WsB+c43p3S9ltXvPYLuhmesV/1NxYF45xQA97LlnFTH5lRSVqrgPyRKeBH0KKngK1AL4K3+ZG2gqfS6mZRJfDo0tKl8A7zlq3H0f01o0G+UKgN/c/XyJNNBK/Iv1Mk/lCX6kzaY7LxNdVRbpH8EYPj0CUB7DMnXZ1CY=
Received: from DM6PR18CA0029.namprd18.prod.outlook.com (2603:10b6:5:15b::42)
 by CY8PR12MB7490.namprd12.prod.outlook.com (2603:10b6:930:91::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 15:14:28 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:15b:cafe::5c) by DM6PR18CA0029.outlook.office365.com
 (2603:10b6:5:15b::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Thu, 4 Apr 2024 15:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 15:14:28 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Apr
 2024 10:14:14 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<Avadhut.Naik@amd.com>, <John.Allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 14/16] x86/mce, EDAC/mce_amd: Add support for new MCA_SYND{1,2} registers
Date: Thu, 4 Apr 2024 10:13:57 -0500
Message-ID: <20240404151359.47970-15-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404151359.47970-1-yazen.ghannam@amd.com>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|CY8PR12MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: fd1112a5-0e28-44d9-fe32-08dc54b9ec32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pI6FjPVZXiManxwtp3HKqK2WLBGod51BMtTNgI6ZGUhzdCJZBXs5lYIBZ9V81C87oRyLNi9gFMAKjBWKFi81Evnihao6GeT87mdsYL5BrcfvM+n7Q7tIXlGIzaKWS1YF1vIEylMPnn9ktWLy11nSdieJLJSUcSgUE7h7uX3nJPNjCERHeCqigiCvJH/bLsIq2OTwYuhvm5uE7ig5LDNtLedxGmyLkxTgwEu5k8DSn0376zx0sIAdGHkgT1gdfnr2FWlorCkW1mcyFLFnmZrEDS6u/xlt1bo2prJPIa9hvjcrY+PFa4EJMkQLXO68ndeTDOxF3ZqK8DE1eh6ZHT0Xi83yyYrvAe0WXqI5Mt/X4ZICgNBjks7Qy4knokohZx72jQbVcYA1n/4JYmyEQUsiTmlqzmLNZ7LFtggZr+YfUeSa5hsEAZAXVFfpaARNvBWkNLFGTAN2/KDfqL26cph/x/4wbBOZkhbgiXrTGNlgQNbhimhJ3ygIX5OfFQzewnl0JM8k/+q2gv6EfJYbxHyXkvCcHczlEBxwZ/RRgOdiNnLumOTWjBRikM0dW1LaTV4jOy+XhnLcHY4dk8J1x4VL4K02djPts8VJhd5yB1e6kNfcB1nCM9FHqPxaGOIOsFXbWON/EWNdcXfzJp7KSh71HHgkGUuIXG7xGrlXlhpLxZpl33xKG/Fc0l2vNFXOguNy2zEwRq72YUjNNlQz1jUvLQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 15:14:28.6028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1112a5-0e28-44d9-fe32-08dc54b9ec32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7490

From: Avadhut Naik <Avadhut.Naik@amd.com>

AMD's Scalable MCA systems viz. Genoa will include two new registers:
MCA_SYND1 and MCA_SYND2.

These registers will include supplemental error information in addition
to the existing MCA_SYND register. The data within the registers is
considered valid if MCA_STATUS[SyndV] is set.

Add fields for these registers as vendor-specific error information
in struct mce_hw_err. Save and print these registers wherever
MCA_STATUS[SyndV]/MCA_SYND is currently used.

Also, modify the mce_record tracepoint to export these new registers
through __dynamic_array. While the sizeof() operator has been used to
determine the size of this __dynamic_array, the same, if needed in the
future can be substituted by caching the size of vendor-specific error
information as part of struct mce_hw_err.

Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lkml.kernel.org/r/20231118193248.1296798-19-yazen.ghannam@amd.com
    
    v1->v2:
    * Rebase on upstream changes for MCE trace event. (Avadhut)

 arch/x86/include/asm/mce.h     | 12 ++++++++++++
 arch/x86/kernel/cpu/mce/core.c | 26 ++++++++++++++++++--------
 drivers/edac/mce_amd.c         | 10 +++++++---
 include/trace/events/mce.h     |  9 +++++++--
 4 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index e4ad9807b3e3..a701290f80a1 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -118,6 +118,9 @@
 #define MSR_AMD64_SMCA_MC0_DESTAT	0xc0002008
 #define MSR_AMD64_SMCA_MC0_DEADDR	0xc0002009
 #define MSR_AMD64_SMCA_MC0_MISC1	0xc000200a
+/* Registers MISC2 to MISC4 are at offsets B to D. */
+#define MSR_AMD64_SMCA_MC0_SYND1	0xc000200e
+#define MSR_AMD64_SMCA_MC0_SYND2	0xc000200f
 #define MSR_AMD64_SMCA_MCx_CTL(x)	(MSR_AMD64_SMCA_MC0_CTL + 0x10*(x))
 #define MSR_AMD64_SMCA_MCx_STATUS(x)	(MSR_AMD64_SMCA_MC0_STATUS + 0x10*(x))
 #define MSR_AMD64_SMCA_MCx_ADDR(x)	(MSR_AMD64_SMCA_MC0_ADDR + 0x10*(x))
@@ -128,6 +131,8 @@
 #define MSR_AMD64_SMCA_MCx_DESTAT(x)	(MSR_AMD64_SMCA_MC0_DESTAT + 0x10*(x))
 #define MSR_AMD64_SMCA_MCx_DEADDR(x)	(MSR_AMD64_SMCA_MC0_DEADDR + 0x10*(x))
 #define MSR_AMD64_SMCA_MCx_MISCy(x, y)	((MSR_AMD64_SMCA_MC0_MISC1 + y) + (0x10*(x)))
+#define MSR_AMD64_SMCA_MCx_SYND1(x)	(MSR_AMD64_SMCA_MC0_SYND1 + 0x10*(x))
+#define MSR_AMD64_SMCA_MCx_SYND2(x)	(MSR_AMD64_SMCA_MC0_SYND2 + 0x10*(x))
 
 #define XEC(x, mask)			(((x) >> 16) & mask)
 
@@ -185,6 +190,13 @@ enum mce_notifier_prios {
 
 struct mce_hw_err {
 	struct mce m;
+
+	union vendor_info {
+		struct {
+			u64 synd1;
+			u64 synd2;
+		} amd;
+	} vi;
 };
 
 struct notifier_block;
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index fef025bda2af..aa27729f7899 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -201,6 +201,10 @@ static void __print_mce(struct mce_hw_err *err)
 	if (mce_flags.smca) {
 		if (m->synd)
 			pr_cont("SYND %llx ", m->synd);
+		if (err->vi.amd.synd1)
+			pr_cont("SYND1 %llx ", err->vi.amd.synd1);
+		if (err->vi.amd.synd2)
+			pr_cont("SYND2 %llx ", err->vi.amd.synd2);
 		if (m->ipid)
 			pr_cont("IPID %llx ", m->ipid);
 	}
@@ -651,8 +655,10 @@ static struct notifier_block mce_default_nb = {
 /*
  * Read ADDR and MISC registers.
  */
-static noinstr void mce_read_aux(struct mce *m, int i)
+static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 {
+	struct mce *m = &err->m;
+
 	if (m->status & MCI_STATUS_MISCV)
 		m->misc = mce_rdmsrl(mca_msr_reg(i, MCA_MISC));
 
@@ -674,8 +680,11 @@ static noinstr void mce_read_aux(struct mce *m, int i)
 	if (mce_flags.smca) {
 		m->ipid = mce_rdmsrl(MSR_AMD64_SMCA_MCx_IPID(i));
 
-		if (m->status & MCI_STATUS_SYNDV)
+		if (m->status & MCI_STATUS_SYNDV) {
 			m->synd = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND(i));
+			err->vi.amd.synd1 = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND1(i));
+			err->vi.amd.synd2 = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND2(i));
+		}
 	}
 }
 
@@ -751,7 +760,7 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		/* If this entry is not valid, ignore it */
 		if (!(m->status & MCI_STATUS_VAL)) {
 			if (smca_destat_is_valid(i)) {
-				mce_read_aux(m, i);
+				mce_read_aux(&err, i);
 				goto clear_it;
 			}
 
@@ -801,7 +810,7 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		if (flags & MCP_DONTLOG)
 			goto clear_it;
 
-		mce_read_aux(m, i);
+		mce_read_aux(&err, i);
 		m->severity = mce_severity(m, NULL, NULL, false);
 
 		/*
@@ -943,9 +952,10 @@ static __always_inline void quirk_zen_ifu(int bank, struct mce *m, struct pt_reg
  * Do a quick check if any of the events requires a panic.
  * This decides if we keep the events around or clear them.
  */
-static __always_inline int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
+static __always_inline int mce_no_way_out(struct mce_hw_err *err, char **msg, unsigned long *validp,
 					  struct pt_regs *regs)
 {
+	struct mce *m = &err->m;
 	char *tmp = *msg;
 	int i;
 
@@ -963,7 +973,7 @@ static __always_inline int mce_no_way_out(struct mce *m, char **msg, unsigned lo
 
 		m->bank = i;
 		if (mce_severity(m, regs, &tmp, true) >= MCE_PANIC_SEVERITY) {
-			mce_read_aux(m, i);
+			mce_read_aux(err, i);
 			*msg = tmp;
 			return 1;
 		}
@@ -1361,7 +1371,7 @@ __mc_scan_banks(struct mce_hw_err *err, struct pt_regs *regs, struct mce *final,
 		if (severity == MCE_NO_SEVERITY)
 			continue;
 
-		mce_read_aux(m, i);
+		mce_read_aux(err, i);
 
 		/* assuming valid severity level != 0 */
 		m->severity = severity;
@@ -1562,7 +1572,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	final = this_cpu_ptr(&hw_errs_seen);
 	final->m = *m;
 
-	no_way_out = mce_no_way_out(m, &msg, valid_banks, regs);
+	no_way_out = mce_no_way_out(&err, &msg, valid_banks, regs);
 
 	barrier();
 
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index e02af5da1ec2..32bf4cc564a3 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -792,7 +792,8 @@ static const char *decode_error_status(struct mce *m)
 static int
 amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 {
-	struct mce *m = (struct mce *)data;
+	struct mce_hw_err *err = (struct mce_hw_err *)data;
+	struct mce *m = &err->m;
 	unsigned int fam = x86_family(m->cpuid);
 	int ecc;
 
@@ -850,8 +851,11 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
 		pr_emerg(HW_ERR "IPID: 0x%016llx", m->ipid);
 
-		if (m->status & MCI_STATUS_SYNDV)
-			pr_cont(", Syndrome: 0x%016llx", m->synd);
+		if (m->status & MCI_STATUS_SYNDV) {
+			pr_cont(", Syndrome: 0x%016llx\n", m->synd);
+			pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
+				 err->vi.amd.synd1, err->vi.amd.synd2);
+		}
 
 		pr_cont("\n");
 
diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
index 65aba1afcd07..43e8ecc11881 100644
--- a/include/trace/events/mce.h
+++ b/include/trace/events/mce.h
@@ -43,6 +43,8 @@ TRACE_EVENT(mce_record,
 		__field(	u8,		bank		)
 		__field(	u8,		cpuvendor	)
 		__field(	u32,		microcode	)
+		__field(	u8,		len		)
+		__dynamic_array(u8, v_data, sizeof(err->vi))
 	),
 
 	TP_fast_assign(
@@ -65,9 +67,11 @@ TRACE_EVENT(mce_record,
 		__entry->bank		= err->m.bank;
 		__entry->cpuvendor	= err->m.cpuvendor;
 		__entry->microcode	= err->m.microcode;
+		__entry->len		= sizeof(err->vi);
+		memcpy(__get_dynamic_array(v_data), &err->vi, sizeof(err->vi));
 	),
 
-	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR: %016Lx, MISC: %016Lx, SYND: %016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x, microcode: %x",
+	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016llx, IPID: %016llx, ADDR: %016llx, MISC: %016llx, SYND: %016llx, RIP: %02x:<%016llx>, TSC: %llx, PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x, microcode: %x, vendor data: %s",
 		__entry->cpu,
 		__entry->mcgcap, __entry->mcgstatus,
 		__entry->bank, __entry->status,
@@ -83,7 +87,8 @@ TRACE_EVENT(mce_record,
 		__entry->walltime,
 		__entry->socketid,
 		__entry->apicid,
-		__entry->microcode)
+		__entry->microcode,
+		__print_array(__get_dynamic_array(v_data), __entry->len / 8, 8))
 );
 
 #endif /* _TRACE_MCE_H */
-- 
2.34.1


