Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5A67F02A3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 20:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjKRTeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 14:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjKRTdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 14:33:18 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A25D56;
        Sat, 18 Nov 2023 11:33:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1HmO4F3MTcOQ4bqLSpQ/qRG1+kxlKqnLwNtmZACmgZLd6sIfaGPA03r3dgut1mgMVo87nhXHVrdrpVXqUTlT6pDcH32VDlPabguwKYmeFoB+95VAccKdIcU8ba0iwH9oKNa61GqCaeJYIXyElroxOyy5qtVeD1QzNYqgUe02KSy5Ws/MsOpVhZ4+Lw4EGQstLz2rigTpD1/GqhtLgh8WUgibm8UoJW7sVmJasKlc0Xi6Ng24IZchennNbWyV018tnfLl6AUe0SkwHbV6sYDuNb8bq9xTD41x1KWgWWasER19GrrRzyVzTL5hoMk4S8zF7WERXchjV1fCVMwdZyZ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JnaKGmmyTrUkWs5wuv/ACdweQ7EyN+DFj9iGn5AMSo=;
 b=WrpHDTrGx3WTov0gWtJj00uwTm337jAeefgpaPN5M00rVizE8KMrluKnWqWIH19W7OQn22lYdYOwsECY90YZzeXjFx6ZZ/4VTMBq/Yyc8MR8E59oh62wk7TC/egvwCYVIvJNj9yvWQK2wOcGYRaMU3cBS32IrRWzABXBJZ6WXVP25C4tusPk/SXDU6HPHlLSM8tTN3iijDxWPzHpMEAcnutZkPa8AcEZOmaylbS+WJ6Mtt29hHj6TH6Zb9EfKwLUf6WyZLvMAjCUXSCld/fYAI1E+xj70812lkyMA+mkJ9q18BU6D3dP8mUVQVHWEtpKa2oWH6SgVZ9U3e8y68Dbgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JnaKGmmyTrUkWs5wuv/ACdweQ7EyN+DFj9iGn5AMSo=;
 b=vLm/8TBnbsfAb8ozZueM5Nbsl/Z/i0vEQdPHTkN4Jaz0eYQHw1PpofrnyY5EvN67Bx61MGhsvbcJOuTVxoy9QB6OYcyHacaco8IKKn2PsVkJ3AyIQb28lGhmnioIIqVPXw2U14wfGfJTHIcYJqm3xa6oSkT6u2J9lpfOUOU45mY=
Received: from BLAP220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::26)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sat, 18 Nov
 2023 19:33:10 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::f4) by BLAP220CA0021.outlook.office365.com
 (2603:10b6:208:32c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23 via Frontend
 Transport; Sat, 18 Nov 2023 19:33:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Sat, 18 Nov 2023 19:33:10 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 18 Nov
 2023 13:33:08 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Avadhut.Naik@amd.com>,
        <Smita.KoralahalliChannabasappa@amd.com>,
        <amd-gfx@lists.freedesktop.org>,
        <linux-trace-kernel@vger.kernel.org>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH 14/20] x86/mce/amd: Unify AMD DFR handler with MCA Polling
Date:   Sat, 18 Nov 2023 13:32:42 -0600
Message-ID: <20231118193248.1296798-15-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|SJ1PR12MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c0d46f6-284e-4d7e-5d80-08dbe86d32e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0CajMJlqsCaXGRZGeF8F6NqW72l8ciRs50ytCMN3lYqoViteqSNduebea5zNdmNl+DggjPIMM+mo7KIjo3b7o1EaA2KwK8bD8kZKNLzqlxbxgyP9kXqO+i8ZeoiVB4SB/Ro0UWEJA25xWcurM5I826lkS8HpmVkh7HwIaWNRocrvE+ifJH9Tnasy1KzXtzg5ZUEk8jw86n23Y+THKEevkq+OWu1KnfodXFH5xi79JVAwPRjtj7s7IhfAok6tF5DL5M9lH/7QLkcgKF6dAgwkkjTFEsexgrbB9PkgkVc5LnrV5ZjqC8bxnsRYvzG7FFBFYKyQGVWauYulcHELtzjc2GKmQ7l5amqKo3PB9VvimPMESgvj6GIjruejTOZfCD79EJOXLYlfqtEx4xr6M6paoDfoVN1YFulWRjKpOwHMWDxMAdyfgMHhca+r33PXRG+vAqlbVHZIB7CG4uujJ22Jl75jDVQRpAXIZL3CzEaRs2mQGQxK/qE7iTOu0j5c93VSL9zd0Uwi8cbF0Hy+ITrjuhzFwWyM+BcV4YlhFUkO7L0DLGJuUuXdcLOSI+sgFjKtA3/kDJxqy3e/7AG9HT5AsjRtal6Rwr10Apt3zeNGyoRV6iGRXnJHQ1qY7WDxarzn77c6Ni7gWpes5hFe02PUAgafKubw+8Hxt7griwYCDCnOpiAlVpgdeOHjifLevqyypxKAakUKRgMGqbcl+xHOG1b/09FLg5YuVsTVVeFL8TZ6HEHV7CgwWe+/y8eHP0aVrzvYUzxQCEuaKDUpOHVsdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799012)(46966006)(40470700004)(36840700001)(40460700003)(83380400001)(426003)(336012)(26005)(16526019)(2616005)(1076003)(47076005)(36860700001)(4326008)(8676002)(8936002)(41300700001)(2906002)(44832011)(5660300002)(478600001)(7696005)(6666004)(70586007)(70206006)(6916009)(54906003)(316002)(36756003)(81166007)(356005)(86362001)(82740400003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 19:33:10.5585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0d46f6-284e-4d7e-5d80-08dbe86d32e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD systems optionally support a Deferred error interrupt. The interrupt
should be used as another signal to trigger MCA polling. This is similar
to how other MCA interrupts are handled.

Deferred errors do not require any special handling related to the
interrupt, e.g. resetting or rearming the interrupt, etc.

However, Scalable MCA systems include a pair of registers, MCA_DESTAT
and MCA_DEADDR, that should be checked for valid errors. This check
should be done whenever MCA registers are polled. Currently, the
Deferred error interrupt does this check, but the MCA polling function
does not.

Call the MCA polling function when handling the Deferred error
interrupt. This keeps all "polling" cases in a common function.

Add a "SMCA DFR handler" for Deferred errors to the AMD vendor-specific
error handler callback. This will do the same status check, register
clearing, and logging that the interrupt handler has done. And it
extends the common polling flow to find AMD Deferred errors.

Give a common name for the AMD MCA interrupts handler now that both
interrupt sources are handled in a unified function.

Remove old code whose functionality is already covered in the common MCA
code.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c  | 122 +++++++++------------------------
 arch/x86/kernel/cpu/mce/core.c |  16 ++++-
 2 files changed, 48 insertions(+), 90 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 8735a8b9b7cc..b45ee297cde2 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -325,8 +325,7 @@ static DEFINE_PER_CPU(u64, bank_map);
 /* Map of banks that have more than MCA_MISC0 available. */
 static DEFINE_PER_CPU(u64, smca_misc_banks_map);
 
-static void amd_threshold_interrupt(void);
-static void amd_deferred_error_interrupt(void);
+static void amd_mca_interrupt(void);
 
 static void default_deferred_error_interrupt(void)
 {
@@ -595,7 +594,7 @@ static void enable_deferred_error_interrupt(u64 mca_intr_cfg)
 	if (setup_APIC_eilvt(dfr_offset, DEFERRED_ERROR_VECTOR, APIC_EILVT_MSG_FIX, 0))
 		return;
 
-	deferred_error_int_vector = amd_deferred_error_interrupt;
+	deferred_error_int_vector = amd_mca_interrupt;
 
 	if (mce_flags.smca)
 		return;
@@ -874,33 +873,6 @@ bool amd_mce_usable_address(struct mce *m)
 	return false;
 }
 
-static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
-{
-	struct mce m;
-
-	mce_setup(&m);
-
-	m.status = status;
-	m.misc   = misc;
-	m.bank   = bank;
-	m.tsc	 = rdtsc();
-
-	if (m.status & MCI_STATUS_ADDRV) {
-		m.addr = addr;
-
-		smca_extract_err_addr(&m);
-	}
-
-	if (mce_flags.smca) {
-		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), m.ipid);
-
-		if (m.status & MCI_STATUS_SYNDV)
-			rdmsrl(MSR_AMD64_SMCA_MCx_SYND(bank), m.synd);
-	}
-
-	mce_log(&m);
-}
-
 DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_error)
 {
 	trace_deferred_error_apic_entry(DEFERRED_ERROR_VECTOR);
@@ -910,75 +882,46 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_error)
 	apic_eoi();
 }
 
-/*
- * Returns true if the logged error is deferred. False, otherwise.
- */
-static inline bool
-_log_error_bank(unsigned int bank, u32 msr_stat, u32 msr_addr, u64 misc)
-{
-	u64 status, addr = 0;
-
-	rdmsrl(msr_stat, status);
-	if (!(status & MCI_STATUS_VAL))
-		return false;
-
-	if (status & MCI_STATUS_ADDRV)
-		rdmsrl(msr_addr, addr);
-
-	__log_error(bank, status, addr, misc);
-
-	wrmsrl(msr_stat, 0);
-
-	return status & MCI_STATUS_DEFERRED;
-}
-
-static bool _log_error_deferred(unsigned int bank, u32 misc)
-{
-	if (!_log_error_bank(bank, mca_msr_reg(bank, MCA_STATUS),
-			     mca_msr_reg(bank, MCA_ADDR), misc))
-		return false;
-
-	/*
-	 * Non-SMCA systems don't have MCA_DESTAT/MCA_DEADDR registers.
-	 * Return true here to avoid accessing these registers.
-	 */
-	if (!mce_flags.smca)
-		return true;
-
-	/* Clear MCA_DESTAT if the deferred error was logged from MCA_STATUS. */
-	wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(bank), 0);
-	return true;
-}
-
 /*
  * We have three scenarios for checking for Deferred errors:
  *
  * 1) Non-SMCA systems check MCA_STATUS and log error if found.
+ *    This is already handled in machine_check_poll().
  * 2) SMCA systems check MCA_STATUS. If error is found then log it and also
  *    clear MCA_DESTAT.
  * 3) SMCA systems check MCA_DESTAT, if error was not found in MCA_STATUS, and
  *    log it.
  */
-static void log_error_deferred(unsigned int bank)
+static void handle_smca_dfr_error(struct mce *m)
 {
-	if (_log_error_deferred(bank, 0))
+	struct mce m_dfr;
+	u64 mca_destat;
+
+	/* Non-SMCA systems don't have MCA_DESTAT/MCA_DEADDR registers. */
+	if (!mce_flags.smca)
 		return;
 
-	/*
-	 * Only deferred errors are logged in MCA_DE{STAT,ADDR} so just check
-	 * for a valid error.
-	 */
-	_log_error_bank(bank, MSR_AMD64_SMCA_MCx_DESTAT(bank),
-			      MSR_AMD64_SMCA_MCx_DEADDR(bank), 0);
-}
+	/* Clear MCA_DESTAT if the deferred error was logged from MCA_STATUS. */
+	if (m->status & MCI_STATUS_DEFERRED)
+		goto out;
 
-/* APIC interrupt handler for deferred errors */
-static void amd_deferred_error_interrupt(void)
-{
-	unsigned int bank;
+	/* MCA_STATUS didn't have a deferred error, so check MCA_DESTAT for one. */
+	mca_destat = mce_rdmsrl(MSR_AMD64_SMCA_MCx_DESTAT(m->bank));
 
-	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank)
-		log_error_deferred(bank);
+	if (!(mca_destat & MCI_STATUS_VAL))
+		return;
+
+	/* Reuse the same data collected from machine_check_poll(). */
+	memcpy(&m_dfr, m, sizeof(m_dfr));
+
+	/* Save the MCA_DE{STAT,ADDR} values. */
+	m_dfr.status = mca_destat;
+	m_dfr.addr = mce_rdmsrl(MSR_AMD64_SMCA_MCx_DEADDR(m_dfr.bank));
+
+	mce_log(&m_dfr);
+
+out:
+	wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
 }
 
 static void reset_block(struct threshold_block *block)
@@ -1028,10 +971,10 @@ static void reset_thr_blocks(unsigned int bank)
 }
 
 /*
- * Threshold interrupt handler will service THRESHOLD_APIC_VECTOR. The interrupt
- * goes off when error_count reaches threshold_limit.
+ * The same procedure should be used when checking MCA banks in non-urgent
+ * situations, e.g. polling and interrupts.
  */
-static void amd_threshold_interrupt(void)
+static void amd_mca_interrupt(void)
 {
 	/* Check all banks for now. This could be optimized in the future. */
 	machine_check_poll(MCP_TIMESTAMP, this_cpu_ptr(&mce_poll_banks));
@@ -1040,6 +983,7 @@ static void amd_threshold_interrupt(void)
 void amd_handle_error(struct mce *m)
 {
 	reset_thr_blocks(m->bank);
+	handle_smca_dfr_error(m);
 }
 
 /*
@@ -1514,6 +1458,6 @@ int mce_threshold_create_device(unsigned int cpu)
 	this_cpu_write(threshold_banks, bp);
 
 	if (thresholding_irq_en)
-		mce_threshold_vector = amd_threshold_interrupt;
+		mce_threshold_vector = amd_mca_interrupt;
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 040dc226c6a5..a81c0df217e2 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -663,6 +663,14 @@ static void vendor_handle_error(struct mce *m)
 
 DEFINE_PER_CPU(unsigned, mce_poll_count);
 
+static bool smca_destat_is_valid(unsigned int bank)
+{
+	if (!mce_flags.smca)
+		return false;
+
+	return mce_rdmsrl(MSR_AMD64_SMCA_MCx_DESTAT(bank)) & MCI_STATUS_VAL;
+}
+
 /*
  * Poll for corrected events or events that happened before reset.
  * Those are just logged through /dev/mcelog.
@@ -704,8 +712,14 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		m.status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
 
 		/* If this entry is not valid, ignore it */
-		if (!(m.status & MCI_STATUS_VAL))
+		if (!(m.status & MCI_STATUS_VAL)) {
+			if (smca_destat_is_valid(i)) {
+				mce_read_aux(&m, i);
+				goto clear_it;
+			}
+
 			continue;
+		}
 
 		/*
 		 * If we are logging everything (at CPU online) or this
-- 
2.34.1

