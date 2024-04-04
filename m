Return-Path: <linux-kernel+bounces-131700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4968898ADF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4FB11C21D86
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC957134403;
	Thu,  4 Apr 2024 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2UQcfZol"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA54212CD9C;
	Thu,  4 Apr 2024 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243675; cv=fail; b=PcU9kamfinefJS9VUK7GDVLcwGwZMBQ4poGmsQG0WOsNkcgDw435VMgXQj2rFn3ogxtXfM7/EFuBxDooNWXWSCPs5spYGYuMbzq0QXVkkr0wO+2ZmuDDcR3uUDs5Ly9tmltU5qndhqsEsH59iwtArWJn5cCrFgfKOBR9W7/NpEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243675; c=relaxed/simple;
	bh=+yPBjOYQKajTvuBsIBpsMVunvh6lB3TZh0WTlNrqnx4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJXMHYDdOkV7YNNrRh7OIyV/on4QBwaIDvUF6YCcG+3MZ9CGFqxb+6RyFltfCkJC/f7Tl69JDKQiDvKa+SAP+WiGU+OhZl3PdoJXLCIt3+lb7ViXV1pqIe5n/dUv7iNNi6s+NYng5Of9aeiC4ukwl58vWLvkn6LvfJong65hXCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2UQcfZol; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjLLE+8tsEgJfjHjGNdKuEq9JfDYQ1z7WDaoHyacprU2288o/9/NlJq5fw6xO6UHl7gbZh9I+egH+BlRVf0b3Kyc1uZ7rFjHYRGbztDx2pJaRU8A49CgmE4HGTw51k5Hug2mso78e5lURjhJ9ZX3MiM49Q1BA7ZA0v8N7tX8lH/d3I4ZcilypRTTBwGC9kIM6VGEyfqRWteJfiuvhOIP9cxe9XDlzU3c16r2BNI526bOJVziIoALhJS5FQ1PUkiObBW+6V8DLl/b343GlSLdzvpKh+kj68HMYI+8BDhkNvPuL+qAYEh4V8/T8MJPgtpdANvt6rJ324mFHKcyK5kr/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7B+k5mlnz84kjuZ98pZ/2qO0gpdKe1t9aMXYkFs4sk=;
 b=OCuxsJcgy39dLOrefAOwY/nY9pOxYmJXGEFwG1idau5+MHn2lq5g6ji6bsD8rQueo0zdUtuTkCPiL74X4s4XwowXc/QmjMrqeSbk9TCdbZ2f6oWMSjJUBW1gRwSRHzLIYi3BKxM+F7upiPCZRh/NBx/ih1TtD2EzvuwBImAW32yrhHg4MGv8lFfM7am6vhjwUqNmhSh0O/I6bcqXV612vKC0Lvnxhmhub/5GpmSTT5QTtkBxPES/Km3ZlOSIk93Kj6Rl53BJDvKZE5Me3wywm3A3Hdgu7w8DMa0WnzR1aQETK6HQV6N+PDlb0DntAt0pPa0RWqPES/an0vyg2dmEWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7B+k5mlnz84kjuZ98pZ/2qO0gpdKe1t9aMXYkFs4sk=;
 b=2UQcfZol19h9wvmpd2up6rbMpyidtW/3U/f4HFO9RfM4+fgM88vheDfFZ+4Z1ONd913aGvwPVOExRZGlJkXcLufW+T5MofVC7Qk+zd9V06CMd2wksxnB3WUqx/adD5NEfxgHIOB/R8Uw3D4g7Yh5THUm5HFeJlSCf63bHs5vxbE=
Received: from CH0PR13CA0003.namprd13.prod.outlook.com (2603:10b6:610:b1::8)
 by CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 15:14:28 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::bf) by CH0PR13CA0003.outlook.office365.com
 (2603:10b6:610:b1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17 via Frontend
 Transport; Thu, 4 Apr 2024 15:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 15:14:28 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Apr
 2024 10:14:14 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<Avadhut.Naik@amd.com>, <John.Allen@amd.com>, Borislav Petkov <bp@alien8.de>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 13/16] x86/mce: Add wrapper for struct mce to export vendor specific info
Date: Thu, 4 Apr 2024 10:13:56 -0500
Message-ID: <20240404151359.47970-14-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|CYYPR12MB8654:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ca1c95-911b-494c-74df-08dc54b9ebe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l9rWw4ZdgMabahlpAXkkjo6OuEbcnaTln+dGjvGIUSA56d4YY3eHFqDP0IQQBuBvOu7hTwVv2J+CFof6EjJFcyfV+yu1FZkA6XcTgHT9d/5uLggNZr57IPNgRA2Z+aRRJYcCmipJJK4ywGJq1Cd/mauD+I8PF4D0kZiZstVf3AbT4jGEWJM5Ep7n8fH3IAJL/UuA/d7T4QMgP0Rn+vUSmTtNSBCW9XfORLkESB3A6cb3qvwbK4/t6YfJGsiwKSp4LzsR+P94NGE8farN+Hkg5aq28qmVxv85Ja4AMOoj72vW74ouoQSpyrvlBR9Q4LIkuFMBZetuIw/KDYif8rgp3phc/e/IotOi2RgRpO/r59SCYAA0asfgstbGjpz/0xTCgtBHAoSrmz9b0xSHaBdnvgt6UaAan+y6uCwWeh/LqGSIgwLtuTcNOuiUHQee9Cudf75EZNoWKElipIp+egSKBGqIP+uzryjngpgun65YWg5mUdMNS0Yy0p08PLV0eC55+3nU1kddLDTX4CS363vWWkqbfhC0Jysd0pysUO6vTXdH1eV2VWMOI3+8SBkptaqhMwD7aR4k82LjuxE8GMVKLpQ6cGtffctv2xO7zOG3qVMpqsVrGUB/aqQhHQKGg1SqhAmXkn5WAvNKqhUyGdnMbt541fGgCkIfTumYSwsrqjiudPofjX6zJaA51Dk2koeBMFR2cdT6XkAiLj31/HtcwA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 15:14:28.0881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ca1c95-911b-494c-74df-08dc54b9ebe4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8654

From: Avadhut Naik <Avadhut.Naik@amd.com>

Currently, exporting new additional machine check error information
involves adding new fields for the same at the end of the struct mce.
This additional information can then be consumed through mcelog or
tracepoint.

However, as new MSRs are being added (and will be added in the future)
by CPU vendors on their newer CPUs with additional machine check error
information to be exported, the size of struct mce will balloon on some
CPUs, unnecessarily, since those fields are vendor-specific. Moreover,
different CPU vendors may export the additional information in varying
sizes.

The problem particularly intensifies since struct mce is exposed to
userspace as part of UAPI. It's bloating through vendor-specific data
should be avoided to limit the information being sent out to userspace.

Add a new structure mce_hw_err to wrap the existing struct mce. The same
will prevent its ballooning since vendor-specifc data, if any, can now be
exported through a union within the wrapper structure and through
__dynamic_array in mce_record tracepoint.

Furthermore, new internal kernel fields can be added to the wrapper
struct without impacting the user space API.

[Yazen: Add last commit message paragraph. Rebase on other MCA updates.]

Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lkml.kernel.org/r/20231118193248.1296798-18-yazen.ghannam@amd.com
    
    v1->v2:
    * Update all MCE nofitier blocks. (Yazen)
    * Rebase on upstream changes for MCE trace event. (Avadhut)

 arch/x86/include/asm/mce.h              |   6 +-
 arch/x86/kernel/cpu/mce/amd.c           |  24 ++--
 arch/x86/kernel/cpu/mce/apei.c          |  46 +++---
 arch/x86/kernel/cpu/mce/core.c          | 181 +++++++++++++-----------
 arch/x86/kernel/cpu/mce/dev-mcelog.c    |   2 +-
 arch/x86/kernel/cpu/mce/genpool.c       |  20 +--
 arch/x86/kernel/cpu/mce/inject.c        |   4 +-
 arch/x86/kernel/cpu/mce/internal.h      |   8 +-
 drivers/acpi/acpi_extlog.c              |   2 +-
 drivers/acpi/nfit/mce.c                 |   3 +-
 drivers/edac/i7core_edac.c              |   2 +-
 drivers/edac/igen6_edac.c               |   2 +-
 drivers/edac/pnd2_edac.c                |   2 +-
 drivers/edac/sb_edac.c                  |   2 +-
 drivers/edac/skx_common.c               |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |   2 +-
 drivers/ras/amd/fmpm.c                  |   2 +-
 drivers/ras/cec.c                       |   3 +-
 include/trace/events/mce.h              |  42 +++---
 19 files changed, 196 insertions(+), 159 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index adad99bac567..e4ad9807b3e3 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -183,6 +183,10 @@ enum mce_notifier_prios {
 	MCE_PRIO_HIGHEST = MCE_PRIO_CEC
 };
 
+struct mce_hw_err {
+	struct mce m;
+};
+
 struct notifier_block;
 extern void mce_register_decode_chain(struct notifier_block *nb);
 extern void mce_unregister_decode_chain(struct notifier_block *nb);
@@ -218,7 +222,7 @@ static inline int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
 #endif
 
 void mce_setup(struct mce *m);
-void mce_log(struct mce *m);
+void mce_log(struct mce_hw_err *err);
 DECLARE_PER_CPU(struct device *, mce_device);
 
 /* Maximum number of MCA banks per CPU. */
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index a81d911d608e..40e6c5a98dce 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -921,9 +921,9 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_error)
  * 3) SMCA systems check MCA_DESTAT, if error was not found in MCA_STATUS, and
  *    log it.
  */
-static void handle_smca_dfr_error(struct mce *m)
+static void handle_smca_dfr_error(struct mce_hw_err *err)
 {
-	struct mce m_dfr;
+	struct mce_hw_err err_dfr;
 	u64 mca_destat;
 
 	/* Non-SMCA systems don't have MCA_DESTAT/MCA_DEADDR registers. */
@@ -931,26 +931,26 @@ static void handle_smca_dfr_error(struct mce *m)
 		return;
 
 	/* Clear MCA_DESTAT if the deferred error was logged from MCA_STATUS. */
-	if (m->status & MCI_STATUS_DEFERRED)
+	if (err->m.status & MCI_STATUS_DEFERRED)
 		goto out;
 
 	/* MCA_STATUS didn't have a deferred error, so check MCA_DESTAT for one. */
-	mca_destat = mce_rdmsrl(MSR_AMD64_SMCA_MCx_DESTAT(m->bank));
+	mca_destat = mce_rdmsrl(MSR_AMD64_SMCA_MCx_DESTAT(err->m.bank));
 
 	if (!(mca_destat & MCI_STATUS_VAL))
 		return;
 
 	/* Reuse the same data collected from machine_check_poll(). */
-	memcpy(&m_dfr, m, sizeof(m_dfr));
+	memcpy(&err_dfr, err, sizeof(err_dfr));
 
 	/* Save the MCA_DE{STAT,ADDR} values. */
-	m_dfr.status = mca_destat;
-	m_dfr.addr = mce_rdmsrl(MSR_AMD64_SMCA_MCx_DEADDR(m_dfr.bank));
+	err_dfr.m.status = mca_destat;
+	err_dfr.m.addr = mce_rdmsrl(MSR_AMD64_SMCA_MCx_DEADDR(err_dfr.m.bank));
 
-	mce_log(&m_dfr);
+	mce_log(&err_dfr);
 
 out:
-	wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
+	wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(err->m.bank), 0);
 }
 
 static void reset_block(struct threshold_block *block)
@@ -1018,10 +1018,10 @@ static void amd_deferred_error_interrupt(void)
 	machine_check_poll(MCP_TIMESTAMP, this_cpu_ptr(&mce_dfr_int_banks));
 }
 
-void amd_handle_error(struct mce *m)
+void amd_handle_error(struct mce_hw_err *err)
 {
-	reset_thr_blocks(m->bank);
-	handle_smca_dfr_error(m);
+	reset_thr_blocks(err->m.bank);
+	handle_smca_dfr_error(err);
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index e4e32e337110..89a8ebac53ea 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -28,9 +28,12 @@
 
 void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 {
-	struct mce m;
+	struct mce_hw_err err;
+	struct mce *m = &err.m;
 	int lsb;
 
+	memset(&err, 0, sizeof(struct mce_hw_err));
+
 	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
 		return;
 
@@ -44,30 +47,33 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 	else
 		lsb = PAGE_SHIFT;
 
-	mce_setup(&m);
-	m.bank = -1;
+	mce_setup(m);
+	m->bank = -1;
 	/* Fake a memory read error with unknown channel */
-	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | MCI_STATUS_MISCV | 0x9f;
-	m.misc = (MCI_MISC_ADDR_PHYS << 6) | lsb;
+	m->status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | MCI_STATUS_MISCV | 0x9f;
+	m->misc = (MCI_MISC_ADDR_PHYS << 6) | lsb;
 
 	if (severity >= GHES_SEV_RECOVERABLE)
-		m.status |= MCI_STATUS_UC;
+		m->status |= MCI_STATUS_UC;
 
 	if (severity >= GHES_SEV_PANIC) {
-		m.status |= MCI_STATUS_PCC;
-		m.tsc = rdtsc();
+		m->status |= MCI_STATUS_PCC;
+		m->tsc = rdtsc();
 	}
 
-	m.addr = mem_err->physical_addr;
-	mce_log(&m);
+	m->addr = mem_err->physical_addr;
+	mce_log(&err);
 }
 EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 {
 	const u64 *i_mce = ((const u64 *) (ctx_info + 1));
+	struct mce_hw_err err;
+	struct mce *m = &err.m;
 	unsigned int cpu;
-	struct mce m;
+
+	memset(&err, 0, sizeof(struct mce_hw_err));
 
 	if (!boot_cpu_has(X86_FEATURE_SMCA))
 		return -EINVAL;
@@ -105,18 +111,18 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 	if (!cpu_possible(cpu))
 		return -EINVAL;
 
-	mce_setup_common(&m);
-	mce_setup_for_cpu(cpu, &m);
+	mce_setup_common(m);
+	mce_setup_for_cpu(cpu, m);
 
-	m.bank = (ctx_info->msr_addr >> 4) & 0xFF;
-	m.status = *i_mce;
-	m.addr = *(i_mce + 1);
-	m.misc = *(i_mce + 2);
+	m->bank = (ctx_info->msr_addr >> 4) & 0xFF;
+	m->status = *i_mce;
+	m->addr = *(i_mce + 1);
+	m->misc = *(i_mce + 2);
 	/* Skipping MCA_CONFIG */
-	m.ipid = *(i_mce + 4);
-	m.synd = *(i_mce + 5);
+	m->ipid = *(i_mce + 4);
+	m->synd = *(i_mce + 5);
 
-	mce_log(&m);
+	mce_log(&err);
 
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 17cf5a9df3cd..fef025bda2af 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -88,7 +88,7 @@ struct mca_config mca_cfg __read_mostly = {
 	.monarch_timeout = -1
 };
 
-static DEFINE_PER_CPU(struct mce, mces_seen);
+static DEFINE_PER_CPU(struct mce_hw_err, hw_errs_seen);
 static unsigned long mce_need_notify;
 
 /*
@@ -148,9 +148,9 @@ void mce_setup(struct mce *m)
 DEFINE_PER_CPU(struct mce, injectm);
 EXPORT_PER_CPU_SYMBOL_GPL(injectm);
 
-void mce_log(struct mce *m)
+void mce_log(struct mce_hw_err *err)
 {
-	if (!mce_gen_pool_add(m))
+	if (!mce_gen_pool_add(err))
 		irq_work_queue(&mce_irq_work);
 }
 EXPORT_SYMBOL_GPL(mce_log);
@@ -171,8 +171,10 @@ void mce_unregister_decode_chain(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(mce_unregister_decode_chain);
 
-static void __print_mce(struct mce *m)
+static void __print_mce(struct mce_hw_err *err)
 {
+	struct mce *m = &err->m;
+
 	pr_emerg(HW_ERR "CPU %d: Machine Check%s: %Lx Bank %d: %016Lx\n",
 		 m->extcpu,
 		 (m->mcgstatus & MCG_STATUS_MCIP ? " Exception" : ""),
@@ -214,9 +216,11 @@ static void __print_mce(struct mce *m)
 		m->microcode);
 }
 
-static void print_mce(struct mce *m)
+static void print_mce(struct mce_hw_err *err)
 {
-	__print_mce(m);
+	struct mce *m = &err->m;
+
+	__print_mce(err);
 
 	if (m->cpuvendor != X86_VENDOR_AMD && m->cpuvendor != X86_VENDOR_HYGON)
 		pr_emerg_ratelimited(HW_ERR "Run the above through 'mcelog --ascii'\n");
@@ -251,7 +255,7 @@ static const char *mce_dump_aux_info(struct mce *m)
 	return NULL;
 }
 
-static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
+static noinstr void mce_panic(const char *msg, struct mce_hw_err *final, char *exp)
 {
 	struct llist_node *pending;
 	struct mce_evt_llist *l;
@@ -282,20 +286,22 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	pending = mce_gen_pool_prepare_records();
 	/* First print corrected ones that are still unlogged */
 	llist_for_each_entry(l, pending, llnode) {
-		struct mce *m = &l->mce;
+		struct mce_hw_err *err = &l->err;
+		struct mce *m = &err->m;
 		if (!(m->status & MCI_STATUS_UC)) {
-			print_mce(m);
+			print_mce(err);
 			if (!apei_err)
 				apei_err = apei_write_mce(m);
 		}
 	}
 	/* Now print uncorrected but with the final one last */
 	llist_for_each_entry(l, pending, llnode) {
-		struct mce *m = &l->mce;
+		struct mce_hw_err *err = &l->err;
+		struct mce *m = &err->m;
 		if (!(m->status & MCI_STATUS_UC))
 			continue;
-		if (!final || mce_cmp(m, final)) {
-			print_mce(m);
+		if (!final || mce_cmp(m, &final->m)) {
+			print_mce(err);
 			if (!apei_err)
 				apei_err = apei_write_mce(m);
 		}
@@ -303,12 +309,12 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	if (final) {
 		print_mce(final);
 		if (!apei_err)
-			apei_err = apei_write_mce(final);
+			apei_err = apei_write_mce(&final->m);
 	}
 	if (exp)
 		pr_emerg(HW_ERR "Machine check: %s\n", exp);
 
-	memmsg = mce_dump_aux_info(final);
+	memmsg = mce_dump_aux_info(&final->m);
 	if (memmsg)
 		pr_emerg(HW_ERR "Machine check: %s\n", memmsg);
 
@@ -323,9 +329,9 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 		 * panic.
 		 */
 		if (kexec_crash_loaded()) {
-			if (final && (final->status & MCI_STATUS_ADDRV)) {
+			if (final && (final->m.status & MCI_STATUS_ADDRV)) {
 				struct page *p;
-				p = pfn_to_online_page(final->addr >> PAGE_SHIFT);
+				p = pfn_to_online_page(final->m.addr >> PAGE_SHIFT);
 				if (p)
 					SetPageHWPoison(p);
 			}
@@ -574,13 +580,13 @@ EXPORT_SYMBOL_GPL(mce_is_correctable);
 static int mce_early_notifier(struct notifier_block *nb, unsigned long val,
 			      void *data)
 {
-	struct mce *m = (struct mce *)data;
+	struct mce_hw_err *err = (struct mce_hw_err *)data;
 
-	if (!m)
+	if (!err)
 		return NOTIFY_DONE;
 
 	/* Emit the trace record: */
-	trace_mce_record(m);
+	trace_mce_record(err);
 
 	set_bit(0, &mce_need_notify);
 
@@ -597,7 +603,8 @@ static struct notifier_block early_nb = {
 static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
 			      void *data)
 {
-	struct mce *mce = (struct mce *)data;
+	struct mce_hw_err *err = (struct mce_hw_err *)data;
+	struct mce *mce = &err->m;
 	unsigned long pfn;
 
 	if (!mce || !mce_usable_address(mce))
@@ -624,13 +631,13 @@ static struct notifier_block mce_uc_nb = {
 static int mce_default_notifier(struct notifier_block *nb, unsigned long val,
 				void *data)
 {
-	struct mce *m = (struct mce *)data;
+	struct mce_hw_err *err = (struct mce_hw_err *)data;
 
-	if (!m)
+	if (!err)
 		return NOTIFY_DONE;
 
-	if (mca_cfg.print_all || !m->kflags)
-		__print_mce(m);
+	if (mca_cfg.print_all || !(err->m.kflags))
+		__print_mce(err);
 
 	return NOTIFY_DONE;
 }
@@ -672,10 +679,10 @@ static noinstr void mce_read_aux(struct mce *m, int i)
 	}
 }
 
-static void vendor_handle_error(struct mce *m)
+static void vendor_handle_error(struct mce_hw_err *err)
 {
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
-		return amd_handle_error(m);
+		return amd_handle_error(err);
 }
 
 DEFINE_PER_CPU(unsigned, mce_poll_count);
@@ -707,26 +714,29 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
 	bool error_seen = false;
-	struct mce m;
+	struct mce_hw_err err;
+	struct mce *m = &err.m;
 	int i;
 
+	memset(&err, 0, sizeof(struct mce_hw_err));
+
 	this_cpu_inc(mce_poll_count);
 
-	mce_gather_info(&m, NULL);
+	mce_gather_info(m, NULL);
 
 	if (flags & MCP_TIMESTAMP)
-		m.tsc = rdtsc();
+		m->tsc = rdtsc();
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
 		if (!mce_banks[i].ctl || !test_bit(i, *b))
 			continue;
 
-		m.misc = 0;
-		m.addr = 0;
-		m.bank = i;
+		m->misc = 0;
+		m->addr = 0;
+		m->bank = i;
 
 		barrier();
-		m.status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
+		m->status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
 
 		/*
 		 * Update storm tracking here, before checking for the
@@ -736,12 +746,12 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		 * storm status.
 		 */
 		if (!mca_cfg.cmci_disabled)
-			mce_track_storm(&m);
+			mce_track_storm(m);
 
 		/* If this entry is not valid, ignore it */
-		if (!(m.status & MCI_STATUS_VAL)) {
+		if (!(m->status & MCI_STATUS_VAL)) {
 			if (smca_destat_is_valid(i)) {
-				mce_read_aux(&m, i);
+				mce_read_aux(m, i);
 				goto clear_it;
 			}
 
@@ -752,7 +762,7 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		 * If we are logging everything (at CPU online) or this
 		 * is a corrected error, then we must log it.
 		 */
-		if ((flags & MCP_UC) || !(m.status & MCI_STATUS_UC))
+		if ((flags & MCP_UC) || !(m->status & MCI_STATUS_UC))
 			goto log_it;
 
 		/*
@@ -762,20 +772,20 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		 * everything else.
 		 */
 		if (!mca_cfg.ser) {
-			if (m.status & MCI_STATUS_UC)
+			if (m->status & MCI_STATUS_UC)
 				continue;
 			goto log_it;
 		}
 
 		/* Log "not enabled" (speculative) errors */
-		if (!(m.status & MCI_STATUS_EN))
+		if (!(m->status & MCI_STATUS_EN))
 			goto log_it;
 
 		/*
 		 * Log UCNA (SDM: 15.6.3 "UCR Error Classification")
 		 * UC == 1 && PCC == 0 && S == 0
 		 */
-		if (!(m.status & MCI_STATUS_PCC) && !(m.status & MCI_STATUS_S))
+		if (!(m->status & MCI_STATUS_PCC) && !(m->status & MCI_STATUS_S))
 			goto log_it;
 
 		/*
@@ -791,23 +801,24 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		if (flags & MCP_DONTLOG)
 			goto clear_it;
 
-		mce_read_aux(&m, i);
-		m.severity = mce_severity(&m, NULL, NULL, false);
+		mce_read_aux(m, i);
+		m->severity = mce_severity(m, NULL, NULL, false);
+
 		/*
 		 * Don't get the IP here because it's unlikely to
 		 * have anything to do with the actual error location.
 		 */
 
-		if (mca_cfg.dont_log_ce && !mce_usable_address(&m))
+		if (mca_cfg.dont_log_ce && !mce_usable_address(m))
 			goto clear_it;
 
 		if (flags & MCP_QUEUE_LOG)
-			mce_gen_pool_add(&m);
+			mce_gen_pool_add(&err);
 		else
-			mce_log(&m);
+			mce_log(&err);
 
 clear_it:
-		vendor_handle_error(&m);
+		vendor_handle_error(&err);
 
 		/*
 		 * Clear state for this bank.
@@ -1044,6 +1055,7 @@ static noinstr int mce_timed_out(u64 *t, const char *msg)
 static void mce_reign(void)
 {
 	int cpu;
+	struct mce_hw_err *err = NULL;
 	struct mce *m = NULL;
 	int global_worst = 0;
 	char *msg = NULL;
@@ -1054,11 +1066,13 @@ static void mce_reign(void)
 	 * Grade the severity of the errors of all the CPUs.
 	 */
 	for_each_possible_cpu(cpu) {
-		struct mce *mtmp = &per_cpu(mces_seen, cpu);
+		struct mce_hw_err *etmp = &per_cpu(hw_errs_seen, cpu);
+		struct mce *mtmp = &etmp->m;
 
 		if (mtmp->severity > global_worst) {
 			global_worst = mtmp->severity;
-			m = &per_cpu(mces_seen, cpu);
+			err = &per_cpu(hw_errs_seen, cpu);
+			m = &err->m;
 		}
 	}
 
@@ -1070,7 +1084,7 @@ static void mce_reign(void)
 	if (m && global_worst >= MCE_PANIC_SEVERITY) {
 		/* call mce_severity() to get "msg" for panic */
 		mce_severity(m, NULL, &msg, true);
-		mce_panic("Fatal machine check", m, msg);
+		mce_panic("Fatal machine check", err, msg);
 	}
 
 	/*
@@ -1087,11 +1101,11 @@ static void mce_reign(void)
 		mce_panic("Fatal machine check from unknown source", NULL, NULL);
 
 	/*
-	 * Now clear all the mces_seen so that they don't reappear on
+	 * Now clear all the hw_errs_seen so that they don't reappear on
 	 * the next mce.
 	 */
 	for_each_possible_cpu(cpu)
-		memset(&per_cpu(mces_seen, cpu), 0, sizeof(struct mce));
+		memset(&per_cpu(hw_errs_seen, cpu), 0, sizeof(struct mce_hw_err));
 }
 
 static atomic_t global_nwo;
@@ -1295,12 +1309,13 @@ static noinstr bool mce_check_crashing_cpu(void)
 }
 
 static __always_inline int
-__mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *final,
+__mc_scan_banks(struct mce_hw_err *err, struct pt_regs *regs, struct mce *final,
 		unsigned long *toclear, unsigned long *valid_banks, int no_way_out,
 		int *worst)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
 	struct mca_config *cfg = &mca_cfg;
+	struct mce *m = &err->m;
 	int severity, i, taint = 0;
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
@@ -1356,7 +1371,7 @@ __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *final,
 		 * done in #MC context, where instrumentation is disabled.
 		 */
 		instrumentation_begin();
-		mce_log(m);
+		mce_log(err);
 		instrumentation_end();
 
 		if (severity > *worst) {
@@ -1426,8 +1441,9 @@ static void kill_me_never(struct callback_head *cb)
 		set_mce_nospec(pfn);
 }
 
-static void queue_task_work(struct mce *m, char *msg, void (*func)(struct callback_head *))
+static void queue_task_work(struct mce_hw_err *err, char *msg, void (*func)(struct callback_head *))
 {
+	struct mce *m = &err->m;
 	int count = ++current->mce_count;
 
 	/* First call, save all the details */
@@ -1441,11 +1457,12 @@ static void queue_task_work(struct mce *m, char *msg, void (*func)(struct callba
 
 	/* Ten is likely overkill. Don't expect more than two faults before task_work() */
 	if (count > 10)
-		mce_panic("Too many consecutive machine checks while accessing user data", m, msg);
+		mce_panic("Too many consecutive machine checks while accessing user data",
+			  err, msg);
 
 	/* Second or later call, make sure page address matches the one from first call */
 	if (count > 1 && (current->mce_addr >> PAGE_SHIFT) != (m->addr >> PAGE_SHIFT))
-		mce_panic("Consecutive machine checks to different user pages", m, msg);
+		mce_panic("Consecutive machine checks to different user pages", err, msg);
 
 	/* Do not call task_work_add() more than once */
 	if (count > 1)
@@ -1494,8 +1511,14 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	int worst = 0, order, no_way_out, kill_current_task, lmce, taint = 0;
 	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS) = { 0 };
 	DECLARE_BITMAP(toclear, MAX_NR_BANKS) = { 0 };
-	struct mce m, *final;
+	struct mce_hw_err *final;
+	struct mce_hw_err err;
 	char *msg = NULL;
+	struct mce *m;
+
+	memset(&err, 0, sizeof(struct mce_hw_err));
+
+	m = &err.m;
 
 	if (unlikely(mce_flags.p5))
 		return pentium_machine_check(regs);
@@ -1533,13 +1556,13 @@ noinstr void do_machine_check(struct pt_regs *regs)
 
 	this_cpu_inc(mce_exception_count);
 
-	mce_gather_info(&m, regs);
-	m.tsc = rdtsc();
+	mce_gather_info(m, regs);
+	m->tsc = rdtsc();
 
-	final = this_cpu_ptr(&mces_seen);
-	*final = m;
+	final = this_cpu_ptr(&hw_errs_seen);
+	final->m = *m;
 
-	no_way_out = mce_no_way_out(&m, &msg, valid_banks, regs);
+	no_way_out = mce_no_way_out(m, &msg, valid_banks, regs);
 
 	barrier();
 
@@ -1548,15 +1571,15 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 * Assume the worst for now, but if we find the
 	 * severity is MCE_AR_SEVERITY we have other options.
 	 */
-	if (!(m.mcgstatus & MCG_STATUS_RIPV))
+	if (!(m->mcgstatus & MCG_STATUS_RIPV))
 		kill_current_task = 1;
 	/*
 	 * Check if this MCE is signaled to only this logical processor,
 	 * on Intel, Zhaoxin only.
 	 */
-	if (m.cpuvendor == X86_VENDOR_INTEL ||
-	    m.cpuvendor == X86_VENDOR_ZHAOXIN)
-		lmce = m.mcgstatus & MCG_STATUS_LMCES;
+	if (m->cpuvendor == X86_VENDOR_INTEL ||
+	    m->cpuvendor == X86_VENDOR_ZHAOXIN)
+		lmce = m->mcgstatus & MCG_STATUS_LMCES;
 
 	/*
 	 * Local machine check may already know that we have to panic.
@@ -1567,12 +1590,12 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 */
 	if (lmce) {
 		if (no_way_out)
-			mce_panic("Fatal local machine check", &m, msg);
+			mce_panic("Fatal local machine check", &err, msg);
 	} else {
 		order = mce_start(&no_way_out);
 	}
 
-	taint = __mc_scan_banks(&m, regs, final, toclear, valid_banks, no_way_out, &worst);
+	taint = __mc_scan_banks(&err, regs, &final->m, toclear, valid_banks, no_way_out, &worst);
 
 	if (!no_way_out)
 		mce_clear_state(toclear);
@@ -1587,7 +1610,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 				no_way_out = worst >= MCE_PANIC_SEVERITY;
 
 			if (no_way_out)
-				mce_panic("Fatal machine check on current CPU", &m, msg);
+				mce_panic("Fatal machine check on current CPU", &err, msg);
 		}
 	} else {
 		/*
@@ -1599,8 +1622,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		 * make sure we have the right "msg".
 		 */
 		if (worst >= MCE_PANIC_SEVERITY) {
-			mce_severity(&m, regs, &msg, true);
-			mce_panic("Local fatal machine check!", &m, msg);
+			mce_severity(m, regs, &msg, true);
+			mce_panic("Local fatal machine check!", &err, msg);
 		}
 	}
 
@@ -1618,14 +1641,14 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		goto out;
 
 	/* Fault was in user mode and we need to take some action */
-	if ((m.cs & 3) == 3) {
+	if ((m->cs & 3) == 3) {
 		/* If this triggers there is no way to recover. Die hard. */
 		BUG_ON(!on_thread_stack() || !user_mode(regs));
 
-		if (!mce_usable_address(&m))
-			queue_task_work(&m, msg, kill_me_now);
+		if (!mce_usable_address(m))
+			queue_task_work(&err, msg, kill_me_now);
 		else
-			queue_task_work(&m, msg, kill_me_maybe);
+			queue_task_work(&err, msg, kill_me_maybe);
 
 	} else {
 		/*
@@ -1637,13 +1660,13 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		 * corresponding exception handler which would do that is the
 		 * proper one.
 		 */
-		if (m.kflags & MCE_IN_KERNEL_RECOV) {
+		if (m->kflags & MCE_IN_KERNEL_RECOV) {
 			if (!fixup_exception(regs, X86_TRAP_MC, 0, 0))
-				mce_panic("Failed kernel mode recovery", &m, msg);
+				mce_panic("Failed kernel mode recovery", &err, msg);
 		}
 
-		if (m.kflags & MCE_IN_KERNEL_COPYIN)
-			queue_task_work(&m, msg, kill_me_never);
+		if (m->kflags & MCE_IN_KERNEL_COPYIN)
+			queue_task_work(&err, msg, kill_me_never);
 	}
 
 out:
diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index a05ac0716ecf..4a0e3bb4a4fb 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -36,7 +36,7 @@ static DECLARE_WAIT_QUEUE_HEAD(mce_chrdev_wait);
 static int dev_mce_log(struct notifier_block *nb, unsigned long val,
 				void *data)
 {
-	struct mce *mce = (struct mce *)data;
+	struct mce *mce = &((struct mce_hw_err *)data)->m;
 	unsigned int entry;
 
 	if (mce->kflags & MCE_HANDLED_CEC)
diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
index 4284749ec803..3337ea5c428d 100644
--- a/arch/x86/kernel/cpu/mce/genpool.c
+++ b/arch/x86/kernel/cpu/mce/genpool.c
@@ -31,15 +31,15 @@ static LLIST_HEAD(mce_event_llist);
  */
 static bool is_duplicate_mce_record(struct mce_evt_llist *t, struct mce_evt_llist *l)
 {
+	struct mce_hw_err *err1, *err2;
 	struct mce_evt_llist *node;
-	struct mce *m1, *m2;
 
-	m1 = &t->mce;
+	err1 = &t->err;
 
 	llist_for_each_entry(node, &l->llnode, llnode) {
-		m2 = &node->mce;
+		err2 = &node->err;
 
-		if (!mce_cmp(m1, m2))
+		if (!mce_cmp(&err1->m, &err2->m))
 			return true;
 	}
 	return false;
@@ -73,9 +73,9 @@ struct llist_node *mce_gen_pool_prepare_records(void)
 
 void mce_gen_pool_process(struct work_struct *__unused)
 {
+	struct mce_hw_err *err;
 	struct llist_node *head;
 	struct mce_evt_llist *node, *tmp;
-	struct mce *mce;
 
 	head = llist_del_all(&mce_event_llist);
 	if (!head)
@@ -83,8 +83,8 @@ void mce_gen_pool_process(struct work_struct *__unused)
 
 	head = llist_reverse_order(head);
 	llist_for_each_entry_safe(node, tmp, head, llnode) {
-		mce = &node->mce;
-		blocking_notifier_call_chain(&x86_mce_decoder_chain, 0, mce);
+		err = &node->err;
+		blocking_notifier_call_chain(&x86_mce_decoder_chain, 0, err);
 		gen_pool_free(mce_evt_pool, (unsigned long)node, sizeof(*node));
 	}
 }
@@ -94,11 +94,11 @@ bool mce_gen_pool_empty(void)
 	return llist_empty(&mce_event_llist);
 }
 
-int mce_gen_pool_add(struct mce *mce)
+int mce_gen_pool_add(struct mce_hw_err *err)
 {
 	struct mce_evt_llist *node;
 
-	if (filter_mce(mce))
+	if (filter_mce(&err->m))
 		return -EINVAL;
 
 	if (!mce_evt_pool)
@@ -110,7 +110,7 @@ int mce_gen_pool_add(struct mce *mce)
 		return -ENOMEM;
 	}
 
-	memcpy(&node->mce, mce, sizeof(*mce));
+	memcpy(&node->err, err, sizeof(*err));
 	llist_add(&node->llnode, &mce_event_llist);
 
 	return 0;
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 94953d749475..1905938e2fd5 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -498,6 +498,7 @@ static void prepare_msrs(void *info)
 
 static void do_inject(void)
 {
+	struct mce_hw_err err;
 	u64 mcg_status = 0;
 	unsigned int cpu = i_mce.extcpu;
 	u8 b = i_mce.bank;
@@ -513,7 +514,8 @@ static void do_inject(void)
 		i_mce.status |= MCI_STATUS_SYNDV;
 
 	if (inj_type == SW_INJ) {
-		mce_log(&i_mce);
+		err.m = i_mce;
+		mce_log(&err);
 		return;
 	}
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 9802f7c6cc93..c9db046e7124 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -26,12 +26,12 @@ extern struct blocking_notifier_head x86_mce_decoder_chain;
 
 struct mce_evt_llist {
 	struct llist_node llnode;
-	struct mce mce;
+	struct mce_hw_err err;
 };
 
 void mce_gen_pool_process(struct work_struct *__unused);
 bool mce_gen_pool_empty(void);
-int mce_gen_pool_add(struct mce *mce);
+int mce_gen_pool_add(struct mce_hw_err *err);
 int mce_gen_pool_init(void);
 struct llist_node *mce_gen_pool_prepare_records(void);
 
@@ -264,7 +264,7 @@ void mce_setup_for_cpu(unsigned int cpu, struct mce *m);
 #ifdef CONFIG_X86_MCE_AMD
 extern bool amd_filter_mce(struct mce *m);
 bool amd_mce_usable_address(struct mce *m);
-void amd_handle_error(struct mce *m);
+void amd_handle_error(struct mce_hw_err *err);
 
 /*
  * If MCA_CONFIG[McaLsbInStatusSupported] is set, extract ErrAddr in bits
@@ -293,7 +293,7 @@ static __always_inline void smca_extract_err_addr(struct mce *m)
 #else
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 static inline bool amd_mce_usable_address(struct mce *m) { return false; }
-static inline void amd_handle_error(struct mce *m) { }
+static inline void amd_handle_error(struct mce_hw_err *err) { }
 static inline void smca_extract_err_addr(struct mce *m) { }
 #endif
 
diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index ca87a0939135..4864191918db 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -134,7 +134,7 @@ static int print_extlog_rcd(const char *pfx,
 static int extlog_print(struct notifier_block *nb, unsigned long val,
 			void *data)
 {
-	struct mce *mce = (struct mce *)data;
+	struct mce *mce = &((struct mce_hw_err *)data)->m;
 	int	bank = mce->bank;
 	int	cpu = mce->extcpu;
 	struct acpi_hest_generic_status *estatus, *tmp;
diff --git a/drivers/acpi/nfit/mce.c b/drivers/acpi/nfit/mce.c
index d48a388b796e..18916a73a363 100644
--- a/drivers/acpi/nfit/mce.c
+++ b/drivers/acpi/nfit/mce.c
@@ -13,8 +13,9 @@
 static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
 			void *data)
 {
-	struct mce *mce = (struct mce *)data;
+	struct mce_hw_err *err = (struct mce_hw_err *)data;
 	struct acpi_nfit_desc *acpi_desc;
+	struct mce *mce = &err->m;
 	struct nfit_spa *nfit_spa;
 
 	/* We only care about uncorrectable memory errors */
diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index 91e0a88ef904..d1e47cba0ff2 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -1810,7 +1810,7 @@ static void i7core_check_error(struct mem_ctl_info *mci, struct mce *m)
 static int i7core_mce_check_error(struct notifier_block *nb, unsigned long val,
 				  void *data)
 {
-	struct mce *mce = (struct mce *)data;
+	struct mce *mce = &((struct mce_hw_err *)data)->m;
 	struct i7core_dev *i7_dev;
 	struct mem_ctl_info *mci;
 
diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index cdd8480e7368..2c112d4d842b 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -911,7 +911,7 @@ static int ecclog_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 static int ecclog_mce_handler(struct notifier_block *nb, unsigned long val,
 			      void *data)
 {
-	struct mce *mce = (struct mce *)data;
+	struct mce *mce = &((struct mce_hw_err *)data)->m;
 	char *type;
 
 	if (mce->kflags & MCE_HANDLED_CEC)
diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 2afcd148fcf8..e2fb2d75af04 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1366,7 +1366,7 @@ static void pnd2_unregister_mci(struct mem_ctl_info *mci)
  */
 static int pnd2_mce_check_error(struct notifier_block *nb, unsigned long val, void *data)
 {
-	struct mce *mce = (struct mce *)data;
+	struct mce *mce = &((struct mce_hw_err *)data)->m;
 	struct mem_ctl_info *mci;
 	struct dram_addr daddr;
 	char *type;
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 26cca5a9322d..0c4e45245153 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -3255,7 +3255,7 @@ static void sbridge_mce_output_error(struct mem_ctl_info *mci,
 static int sbridge_mce_check_error(struct notifier_block *nb, unsigned long val,
 				   void *data)
 {
-	struct mce *mce = (struct mce *)data;
+	struct mce *mce = &((struct mce_hw_err *)data)->m;
 	struct mem_ctl_info *mci;
 	char *type;
 
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 9c5b6f8bd8bd..e0a4a1ecd25e 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -633,7 +633,7 @@ static bool skx_error_in_mem(const struct mce *m)
 int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 			void *data)
 {
-	struct mce *mce = (struct mce *)data;
+	struct mce *mce = &((struct mce_hw_err *)data)->m;
 	struct decoded_addr res;
 	struct mem_ctl_info *mci;
 	char *type;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c543600b759b..7c3e7ce811ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3536,7 +3536,7 @@ static struct amdgpu_device *find_adev(uint32_t node_id)
 static int amdgpu_bad_page_notifier(struct notifier_block *nb,
 				    unsigned long val, void *data)
 {
-	struct mce *m = (struct mce *)data;
+	struct mce *m = &((struct mce_hw_err *)data)->m;
 	struct amdgpu_device *adev = NULL;
 	uint32_t gpu_id = 0;
 	uint32_t umc_inst = 0, ch_inst = 0;
diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 271dfad05d68..d3ce41a46ac4 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -400,7 +400,7 @@ static void retire_dram_row(u64 addr, u64 id, u32 cpu)
 
 static int fru_handle_mem_poison(struct notifier_block *nb, unsigned long val, void *data)
 {
-	struct mce *m = (struct mce *)data;
+	struct mce *m = &((struct mce_hw_err *)data)->m;
 	struct fru_rec *rec;
 
 	if (!mce_is_memory_error(m))
diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index e440b15fbabc..4940e97fbcdc 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -534,7 +534,8 @@ static int __init create_debugfs_nodes(void)
 static int cec_notifier(struct notifier_block *nb, unsigned long val,
 			void *data)
 {
-	struct mce *m = (struct mce *)data;
+	struct mce_hw_err *err = (struct mce_hw_err *)data;
+	struct mce *m = &err->m;
 
 	if (!m)
 		return NOTIFY_DONE;
diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
index f0f7b3cb2041..65aba1afcd07 100644
--- a/include/trace/events/mce.h
+++ b/include/trace/events/mce.h
@@ -19,9 +19,9 @@
 
 TRACE_EVENT(mce_record,
 
-	TP_PROTO(struct mce *m),
+	TP_PROTO(struct mce_hw_err *err),
 
-	TP_ARGS(m),
+	TP_ARGS(err),
 
 	TP_STRUCT__entry(
 		__field(	u64,		mcgcap		)
@@ -46,25 +46,25 @@ TRACE_EVENT(mce_record,
 	),
 
 	TP_fast_assign(
-		__entry->mcgcap		= m->mcgcap;
-		__entry->mcgstatus	= m->mcgstatus;
-		__entry->status		= m->status;
-		__entry->addr		= m->addr;
-		__entry->misc		= m->misc;
-		__entry->synd		= m->synd;
-		__entry->ipid		= m->ipid;
-		__entry->ip		= m->ip;
-		__entry->tsc		= m->tsc;
-		__entry->ppin		= m->ppin;
-		__entry->walltime	= m->time;
-		__entry->cpu		= m->extcpu;
-		__entry->cpuid		= m->cpuid;
-		__entry->apicid		= m->apicid;
-		__entry->socketid	= m->socketid;
-		__entry->cs		= m->cs;
-		__entry->bank		= m->bank;
-		__entry->cpuvendor	= m->cpuvendor;
-		__entry->microcode	= m->microcode;
+		__entry->mcgcap		= err->m.mcgcap;
+		__entry->mcgstatus	= err->m.mcgstatus;
+		__entry->status		= err->m.status;
+		__entry->addr		= err->m.addr;
+		__entry->misc		= err->m.misc;
+		__entry->synd		= err->m.synd;
+		__entry->ipid		= err->m.ipid;
+		__entry->ip		= err->m.ip;
+		__entry->tsc		= err->m.tsc;
+		__entry->ppin		= err->m.ppin;
+		__entry->walltime	= err->m.time;
+		__entry->cpu		= err->m.extcpu;
+		__entry->cpuid		= err->m.cpuid;
+		__entry->apicid		= err->m.apicid;
+		__entry->socketid	= err->m.socketid;
+		__entry->cs		= err->m.cs;
+		__entry->bank		= err->m.bank;
+		__entry->cpuvendor	= err->m.cpuvendor;
+		__entry->microcode	= err->m.microcode;
 	),
 
 	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR: %016Lx, MISC: %016Lx, SYND: %016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x, microcode: %x",
-- 
2.34.1


