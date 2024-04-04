Return-Path: <linux-kernel+bounces-131692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF826898AD4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95BE1C21228
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D57812FB3A;
	Thu,  4 Apr 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l4uBQsET"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6609C12AAD2;
	Thu,  4 Apr 2024 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243671; cv=fail; b=EWTrHYn/434p/J9EkqK8ewsh+HS6Q97cVqKrOtpgeE0u+8TcbF+UXrPh0eb9l2nAwRe2qDxmYBIJNi8QVnYcntlTbMH4VJVnsX84Gr26/oMfggjtjaEAscoaoKmbCd2EHey3E7wrbq+3JY3mqoPIN3KAoAeFUV24oDnIPe3fBlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243671; c=relaxed/simple;
	bh=nyk8lJR8uC93sH8936+JiaYpErm7E7JXdwimGb5m000=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kblris+cTPHC0QrsPw2Hk74bKbbXd3DrpjLxCwcYteM3CHlvy5Xa5uufBK2QCJoYB1R+a/m8MCwUVsNP4XTphOvq3P6Kb5vRaNI0PM2WzmDXxLv22YJO4264REzh+R5OcjD/WOHelYBcX7rzTRJaymo5dkSZkBe/iPWTax9S1Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l4uBQsET; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpvVmwefStVWRBgD9SG3RVoAQHjwKMIPuRETuXbbwe/XxS4MosD8W0E+hstwHCAnugzNA30vgpScBvxXjok8ke/j2V0+40gRvsACPpsRRHJCezpiP4laHVIQDHdWg8Rrw+cqNu8CWG0FHGrXdGDILgln5ABJ8g97EwhM4bAPXuNFO2ZBmZ5rIRDntXIHkGyO3RQRO0IWR2bbSgzDGhLQsmTqWkDeerLckQ+TZW8ogLLP/vHxZp9IIs9ASLdnFN2xyO+01+TTarsMlErfJOrTWlzJ6HzL67xBQqZz2oZE3FG2+O8otYJEUjbT16ga7+Bk3hfokMfXTmqCv7gi26Pnqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wM1ULlnV2okVrd3WIjzBTWfF964iCeHNHE1Rh/UL3xs=;
 b=RAwDshpbUdENMF1a86L24ygC42IM5yiKHvgwY0HqmvdzF+cGfcCOAJ4gXotvjSWmtiiusOP1cMaY3+olc37iSkO7JqToAXRa7WwFhbf+Bdx8TpiNwZW0+Wige7Xw+LkxX0N1McUeMBKQVxCgQXvRKfRY9KEtic/E2iI+HaeoVC9L5nhh6Ooi/ph469fYl276e0tpmMOIujuFEa7h1hRbxTGhjs2cUXhqYFUqClJ7SbSSsP9fdHMFcq+uI3JGC5mboz4/k6J94dT9JTDGcVQVUw1tNGCFxCjiimKeG0qq4QdJ7KfSXK0dbw1A7M36HUaVcxRKjKKrZyglQkL9GfHOCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wM1ULlnV2okVrd3WIjzBTWfF964iCeHNHE1Rh/UL3xs=;
 b=l4uBQsETc+Z3DYGV16253jOHpSLBw6H4/uHRgDzctVBrwp1Viy1ayDTN3UaADftBpRCSPhBFzbYmfpwUfHRtSqxd/vzRrd7EdLnsYjQ4epxSFKnSQqiX6NG8b9gh1LAIi+XbzvMj49ZAE7F483Xbzuba0bmXUtIFvtrFSM44P8A=
Received: from DM6PR05CA0057.namprd05.prod.outlook.com (2603:10b6:5:335::26)
 by IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 15:14:26 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::b4) by DM6PR05CA0057.outlook.office365.com
 (2603:10b6:5:335::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26 via Frontend
 Transport; Thu, 4 Apr 2024 15:14:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 15:14:26 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Apr
 2024 10:14:13 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<Avadhut.Naik@amd.com>, <John.Allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 10/16] x86/mce: Unify AMD DFR handler with MCA Polling
Date: Thu, 4 Apr 2024 10:13:53 -0500
Message-ID: <20240404151359.47970-11-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aadc1b4-46e7-4e39-ecdb-08dc54b9eab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZukE/eDwZWlxD9pd4mKse/15ogafJD6+UTsYs6MTQXcJMUOtHywIZG4baa6AQeY7ToZGe4vSrHUEDulQS8pDEJ8WGcLtWv3+6PzUgTqUEMkwyP+vToRpFNJfW+UTiSELp5zr8ozJ4ubBTCE2l/hA1qeCmCSZ6WTVW6tqdURLPoA9zlT36nV2zAI9o0T8jhLXg1y/A28WEZU91W+WteXdmYp+GSq21f8ArPx8arg7JDHB1lsEWB8J3aniVWSIIInVlXywgq0htDgjSCebbc2EzhfJogaZqCVB1EwY3DplIPNl9Fr8ysLjE0hajy4o3JoSqLBRO8+E2AGJhVMWVzDFauJrvxucHBoGBmWpfCoi12asMygb0HylzHO4MPLmHMtWqBjATw2ZVYtdSR89dkgEpWoLFl4BmZOW1ThryXUDjb9rWXSo4axpdu+CYQGMUR1JgtDsqu+sm3Um2wFeSD9vznqS1HvrrAkrshBK4JpqLgTh8pNTZZe56DYCpRrtQ6QJCDT4uUg6jfCCFqrJ7tIPEsGnBapkJhdXKJVF13OFYSm/QdCs9CR5hW/o4dvtMDNJe4CTna4Pa7RAEQBkO6zxF4E0GQS6SkDDKptqa9Eqc5GapJzCqBHY7r78NJeLO4YumuP/x19lLnuMxYe5QmqyZiV9/LJ158tEDgT7fnsg4W5+hPjlXCAc1U0FlYlsywg0XnAUIzn+qPX+jt9S/OGCzQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 15:14:26.0923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aadc1b4-46e7-4e39-ecdb-08dc54b9eab3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305

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

Call the polling function only for banks that have the Deferred error
interrupt enabled.

Add a "SMCA DFR handler" for Deferred errors to the AMD vendor-specific
error handler callback. This will do the same status check, register
clearing, and logging that the interrupt handler has done. And it
extends the common polling flow to find AMD Deferred errors.

Remove old code whose functionality is already covered in the common MCA
code.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lkml.kernel.org/r/20231118193248.1296798-15-yazen.ghannam@amd.com
    
    v1->v2:
    * Keep separate interrupt entry points. (Yazen)
    * Move DFR error setup for MCA_CONFIG to a helper. (Yazen)

 arch/x86/kernel/cpu/mce/amd.c  | 155 +++++++++++++--------------------
 arch/x86/kernel/cpu/mce/core.c |  16 +++-
 2 files changed, 76 insertions(+), 95 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 75195d6fe971..40912c5e35d1 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -62,11 +62,13 @@
 #define CFG_MCAX_EN			BIT_ULL(32)
 #define CFG_LSB_IN_STATUS		BIT_ULL(8)
 #define CFG_DFR_INT_SUPP		BIT_ULL(5)
+#define CFG_DFR_LOG_SUPP		BIT_ULL(2)
 
 /* Threshold LVT offset is at MSR0xC0000410[15:12] */
 #define SMCA_THR_LVT_OFF	0xF000
 
 static bool thresholding_irq_en;
+static DEFINE_PER_CPU(mce_banks_t, mce_dfr_int_banks);
 
 static const char * const th_names[] = {
 	"load_store",
@@ -350,6 +352,28 @@ static void smca_set_misc_banks_map(unsigned int bank, unsigned int cpu)
 
 }
 
+/* SMCA sets the Deferred Error Interrupt type per bank. */
+static void configure_smca_dfr(unsigned int bank, u64 *mca_config)
+{
+	/* Nothing to do if the bank doesn't support deferred error logging. */
+	if (!FIELD_GET(CFG_DFR_LOG_SUPP, *mca_config))
+		return;
+
+	/* Nothing to do if the bank doesn't support setting the interrupt type. */
+	if (!FIELD_GET(CFG_DFR_INT_SUPP, *mca_config))
+		return;
+
+	/*
+	 * Nothing to do if the interrupt type is already set. Either it was set by
+	 * the OS already. Or it was set by firmware, and the OS should leave it as-is.
+	 */
+	if (FIELD_GET(CFG_DFR_INT_TYPE, *mca_config))
+		return;
+
+	*mca_config |= FIELD_PREP(CFG_DFR_INT_TYPE, INTR_TYPE_APIC);
+	set_bit(bank, (void *)this_cpu_ptr(&mce_dfr_int_banks));
+}
+
 /* Set appropriate bits in MCA_CONFIG. */
 static void configure_smca(unsigned int bank)
 {
@@ -370,18 +394,7 @@ static void configure_smca(unsigned int bank)
 	 */
 	mca_config |= FIELD_PREP(CFG_MCAX_EN, 0x1);
 
-	/*
-	 * SMCA sets the Deferred Error Interrupt type per bank.
-	 *
-	 * MCA_CONFIG[DeferredIntTypeSupported] is bit 5, and tells us
-	 * if the DeferredIntType bit field is available.
-	 *
-	 * MCA_CONFIG[DeferredIntType] is bits [38:37]. OS should set
-	 * this to 0x1 to enable APIC based interrupt. First, check that
-	 * no interrupt has been set.
-	 */
-	if (FIELD_GET(CFG_DFR_INT_SUPP, mca_config) && !FIELD_GET(CFG_DFR_INT_TYPE, mca_config))
-		mca_config |= FIELD_PREP(CFG_DFR_INT_TYPE, INTR_TYPE_APIC);
+	configure_smca_dfr(bank, &mca_config);
 
 	if (FIELD_GET(CFG_LSB_IN_STATUS, mca_config))
 		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = true;
@@ -872,33 +885,6 @@ bool amd_mce_usable_address(struct mce *m)
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
@@ -908,75 +894,46 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_error)
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
+
+	if (!(mca_destat & MCI_STATUS_VAL))
+		return;
+
+	/* Reuse the same data collected from machine_check_poll(). */
+	memcpy(&m_dfr, m, sizeof(m_dfr));
+
+	/* Save the MCA_DE{STAT,ADDR} values. */
+	m_dfr.status = mca_destat;
+	m_dfr.addr = mce_rdmsrl(MSR_AMD64_SMCA_MCx_DEADDR(m_dfr.bank));
 
-	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank)
-		log_error_deferred(bank);
+	mce_log(&m_dfr);
+
+out:
+	wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
 }
 
 static void reset_block(struct threshold_block *block)
@@ -1035,9 +992,19 @@ static void amd_threshold_interrupt(void)
 	machine_check_poll(MCP_TIMESTAMP, this_cpu_ptr(&mce_poll_banks));
 }
 
+/*
+ * Deferred error interrupt handler will service DEFERRED_ERROR_VECTOR. The interrupt
+ * is triggered when a bank logs a deferred error.
+ */
+static void amd_deferred_error_interrupt(void)
+{
+	machine_check_poll(MCP_TIMESTAMP, this_cpu_ptr(&mce_dfr_int_banks));
+}
+
 void amd_handle_error(struct mce *m)
 {
 	reset_thr_blocks(m->bank);
+	handle_smca_dfr_error(m);
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 75297e7eb980..308766868f39 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -680,6 +680,14 @@ static void vendor_handle_error(struct mce *m)
 
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
@@ -731,8 +739,14 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 			mce_track_storm(&m);
 
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


