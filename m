Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873197F02AB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 20:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjKRTe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 14:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjKRTdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 14:33:25 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A070130;
        Sat, 18 Nov 2023 11:33:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFGg0DurXotyeuRTaTcZ9JK+2Mh3+N22axIlAXD1iWFoweuxkK2s11OH5efmuoI+gJh5I00OmS/RsuYrgsxQDJSheK6AuzYHVKkT5LJigr9N2wBWOyNEs6H4VblH2Bug//Hx7fy/mFPaZ1zWCWYje1fYs6vzOiBs7GC5+jle1nie5B8IhcnUL+RGz9njFsWOeqgI5A0Un3eNGQ+eVBvzYweE61tzh1mjHRGzmdI4r30ztR4xjZ5UNsFObI60lcU6v3dMfx5CE0gDMik2cpKAlTg4txRtXBXBpxGT8WBWy6s9FivtVYIKMui0zD3dEcokoV3gQ6mgCX/0VfSLhJE48A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qfwij/JM06VZSQt1W2rVqsiuOek45fBEfJ1SSEUk8gw=;
 b=ZM2Y6b3R6wvCjX9fNoqq2spXtkwvyTirpDYGUfavIN7DJS4Srft7DAEfm9tsQ6OlUeUKQ9bNnM/9BX9iObFbUrjbBkJoBVciGRRuBLwQhSysRSfCv2L1Hq8rRJ487rPPibzxcsqRphS64RhU5YGEdLqKS4YR6eP/FZLViomWITArcMblElDS1jOzGY8nQJ7y3A72ite9TYWiIotovg5YMf1Hfaga2rW+9tu7AVQIv3oiDphh1xgs5Vex3krU6vkrznh49J+T0oScGUiwEdrS+F50GM3cMi3WYrt04wchgi75Eulz/RlZMDrz15UH2IpgdVebCs3wTeM2HJFmnjqDlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qfwij/JM06VZSQt1W2rVqsiuOek45fBEfJ1SSEUk8gw=;
 b=SD0l/WpT54p72yzu4J83fjB/C24jQ+t7WnYSQpB2dmYCE1QerR7YL+EsNVfgtUgJ+Oc4YXqYfTJqc7KrdE/P7KwHQk1aDjqAtRDcad/DtLTfgRmsI4GpSiDO1HXYaDDJJmyqVhRT/bkoM4DGiurWyau+BkIzEIFxl+JBAIRL910=
Received: from MN2PR10CA0017.namprd10.prod.outlook.com (2603:10b6:208:120::30)
 by SA0PR12MB4526.namprd12.prod.outlook.com (2603:10b6:806:98::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Sat, 18 Nov
 2023 19:33:12 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::75) by MN2PR10CA0017.outlook.office365.com
 (2603:10b6:208:120::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23 via Frontend
 Transport; Sat, 18 Nov 2023 19:33:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Sat, 18 Nov 2023 19:33:11 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 18 Nov
 2023 13:33:10 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Avadhut.Naik@amd.com>,
        <Smita.KoralahalliChannabasappa@amd.com>,
        <amd-gfx@lists.freedesktop.org>,
        <linux-trace-kernel@vger.kernel.org>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH 18/20] x86/mce, EDAC/mce_amd: Add support for new MCA_SYND{1,2} registers
Date:   Sat, 18 Nov 2023 13:32:46 -0600
Message-ID: <20231118193248.1296798-19-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118193248.1296798-1-yazen.ghannam@amd.com>
References: <20231118193248.1296798-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|SA0PR12MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ddd959-26a4-41cd-914f-08dbe86d33b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rmZethfCO+3wCn/T5nhVbyxxmL52baJFqTTkph1T1tg/m4R/OdWnGbaTpotCuqiHvIULi6gPydWt+XAzeTqQUX9iMJFoDYP3XQAERq2wTT3qw1OXFz1ZCYBL72gj+SGEV34yGmQCbd+pXg5D4CchNAhGHadGDRDGD9r7a4gDh48NMF3wYwfumXuzwNwlpYf/yeKUQ7lZHRjced6MwdSnrGdptmQ8Bx7W8s13C9PBuWEsnQLC5mzj9BdnpHoEBiU7NFBEoBrsZhYYjiye5PN8fSgSbtmmZsZxaUHKhTTSupu3/XNaZ5etyd40fjzWkjMmuIh+BglzIjj8RUZoC/ZYhZV1NcHuqthzqAC5RtshWx3Oe5lo1UKDOqrebQ6M5WWt/S21OCDJKYLwz3oMXUO+UgSqhhYdFgCFETSpsw6NS484MsIGdvpnciMBiDaXlWPUiH8NzZ0GS8wMaJzRkoJUDJps/eFfqBgrbRyQSZruGLMLINOTUWLrWQm5iNPPIK/zeIN7gfscgxM1K4qxkdAAuVtJLZIV6nGVOgayQz97YwRvS36R/qNddj856YUXZk73j1N+IS6t7Q+PC4gU0phnIwdEeS6QCHq3pH+i4MvwyFMMA54ihgSpyk83knmrDBMxNGGMAh+PXCwdqssXywSDu4Yxp+DY4pVAFimcIF0khLUS18D7CujQuX7oM+SWekdgfSDpaffHsuez/3nJ1RYNU4a0YfxuRBT4GRpvITMxp6ZfiBiJYINsHfQyJEWtRqv0mfOXhzVqxLh02aQpNxEMPn7OUX7pDEBAs8lRkmAnUJCm8OiKBzHTzVM5OlN99OEu
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230173577357003)(230922051799003)(230273577357003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(70206006)(70586007)(54906003)(6916009)(316002)(36860700001)(36756003)(6666004)(7696005)(426003)(336012)(2616005)(26005)(16526019)(1076003)(478600001)(82740400003)(81166007)(356005)(83380400001)(86362001)(47076005)(44832011)(40480700001)(2906002)(5660300002)(4326008)(8676002)(8936002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 19:33:11.9426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ddd959-26a4-41cd-914f-08dbe86d33b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4526
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Note: Checkpatch warnings/errors are ignored to maintain coding style.

[Yazen: Drop Yazen's Co-developed-by tag and moved SoB tag.]
[Yazen: Change %Lx to %llx in TP_printk().]

Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h     | 12 ++++++++++++
 arch/x86/kernel/cpu/mce/core.c | 26 ++++++++++++++++++--------
 drivers/edac/mce_amd.c         | 10 +++++++---
 include/trace/events/mce.h     |  9 +++++++--
 4 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 99eb72dd7d05..1bd3f1e41dbb 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -122,6 +122,9 @@
 #define MSR_AMD64_SMCA_MC0_DESTAT	0xc0002008
 #define MSR_AMD64_SMCA_MC0_DEADDR	0xc0002009
 #define MSR_AMD64_SMCA_MC0_MISC1	0xc000200a
+/* Registers MISC2 to MISC4 are at offsets B to D. */
+#define MSR_AMD64_SMCA_MC0_SYND1	0xc000200e
+#define MSR_AMD64_SMCA_MC0_SYND2	0xc000200f
 #define MSR_AMD64_SMCA_MCx_CTL(x)	(MSR_AMD64_SMCA_MC0_CTL + 0x10*(x))
 #define MSR_AMD64_SMCA_MCx_STATUS(x)	(MSR_AMD64_SMCA_MC0_STATUS + 0x10*(x))
 #define MSR_AMD64_SMCA_MCx_ADDR(x)	(MSR_AMD64_SMCA_MC0_ADDR + 0x10*(x))
@@ -132,6 +135,8 @@
 #define MSR_AMD64_SMCA_MCx_DESTAT(x)	(MSR_AMD64_SMCA_MC0_DESTAT + 0x10*(x))
 #define MSR_AMD64_SMCA_MCx_DEADDR(x)	(MSR_AMD64_SMCA_MC0_DEADDR + 0x10*(x))
 #define MSR_AMD64_SMCA_MCx_MISCy(x, y)	((MSR_AMD64_SMCA_MC0_MISC1 + y) + (0x10*(x)))
+#define MSR_AMD64_SMCA_MCx_SYND1(x)	(MSR_AMD64_SMCA_MC0_SYND1 + 0x10*(x))
+#define MSR_AMD64_SMCA_MCx_SYND2(x)	(MSR_AMD64_SMCA_MC0_SYND2 + 0x10*(x))
 
 #define XEC(x, mask)			(((x) >> 16) & mask)
 
@@ -189,6 +194,13 @@ enum mce_notifier_prios {
 
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
index 8db8ed34b200..e153a21bdb1b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -198,6 +198,10 @@ static void __print_mce(struct mce_hw_err *err)
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
@@ -633,8 +637,10 @@ static struct notifier_block mce_default_nb = {
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
 
@@ -656,8 +662,11 @@ static noinstr void mce_read_aux(struct mce *m, int i)
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
 
@@ -723,7 +732,7 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		/* If this entry is not valid, ignore it */
 		if (!(m->status & MCI_STATUS_VAL)) {
 			if (smca_destat_is_valid(i)) {
-				mce_read_aux(m, i);
+				mce_read_aux(&err, i);
 				goto clear_it;
 			}
 
@@ -773,7 +782,7 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		if (flags & MCP_DONTLOG)
 			goto clear_it;
 
-		mce_read_aux(m, i);
+		mce_read_aux(&err, i);
 		m->severity = mce_severity(m, NULL, NULL, false);
 
 		/*
@@ -915,9 +924,10 @@ static __always_inline void quirk_zen_ifu(int bank, struct mce *m, struct pt_reg
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
 
@@ -935,7 +945,7 @@ static __always_inline int mce_no_way_out(struct mce *m, char **msg, unsigned lo
 
 		m->bank = i;
 		if (mce_severity(m, regs, &tmp, true) >= MCE_PANIC_SEVERITY) {
-			mce_read_aux(m, i);
+			mce_read_aux(err, i);
 			*msg = tmp;
 			return 1;
 		}
@@ -1333,7 +1343,7 @@ __mc_scan_banks(struct mce_hw_err *err, struct pt_regs *regs, struct mce *final,
 		if (severity == MCE_NO_SEVERITY)
 			continue;
 
-		mce_read_aux(m, i);
+		mce_read_aux(err, i);
 
 		/* assuming valid severity level != 0 */
 		m->severity = severity;
@@ -1534,7 +1544,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	final = this_cpu_ptr(&hw_errs_seen);
 	final->m = *m;
 
-	no_way_out = mce_no_way_out(m, &msg, valid_banks, regs);
+	no_way_out = mce_no_way_out(&err, &msg, valid_banks, regs);
 
 	barrier();
 
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 701bc9556414..4d2929770620 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1275,7 +1275,8 @@ static const char *decode_error_status(struct mce *m)
 static int
 amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 {
-	struct mce *m = (struct mce *)data;
+	struct mce_hw_err *err = (struct mce_hw_err *)data;
+	struct mce *m = &err->m;
 	unsigned int fam = x86_family(m->cpuid);
 	int ecc;
 
@@ -1333,8 +1334,11 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
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
index b093cb28f6dd..29d079961aac 100644
--- a/include/trace/events/mce.h
+++ b/include/trace/events/mce.h
@@ -33,6 +33,8 @@ TRACE_EVENT(mce_record,
 		__field(	u8,		cs		)
 		__field(	u8,		bank		)
 		__field(	u8,		cpuvendor	)
+		__field(	u8,     len	)
+		__dynamic_array(u8, v_data, sizeof(err->vi))
 	),
 
 	TP_fast_assign(
@@ -53,9 +55,11 @@ TRACE_EVENT(mce_record,
 		__entry->cs		= err->m.cs;
 		__entry->bank		= err->m.bank;
 		__entry->cpuvendor	= err->m.cpuvendor;
+		__entry->len	= sizeof(err->vi);
+		memcpy(__get_dynamic_array(v_data), &err->vi, sizeof(err->vi));
 	),
 
-	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x",
+	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016llx, IPID: %016llx, ADDR/MISC/SYND: %016llx/%016llx/%016llx, RIP: %02x:<%016llx>, TSC: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x, Vendor Data: %s",
 		__entry->cpu,
 		__entry->mcgcap, __entry->mcgstatus,
 		__entry->bank, __entry->status,
@@ -66,7 +70,8 @@ TRACE_EVENT(mce_record,
 		__entry->cpuvendor, __entry->cpuid,
 		__entry->walltime,
 		__entry->socketid,
-		__entry->apicid)
+		__entry->apicid,
+		__print_array(__get_dynamic_array(v_data), __entry->len / 8, 8))
 );
 
 #endif /* _TRACE_MCE_H */
-- 
2.34.1

