Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EC07FD10C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjK2ITS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjK2ITM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:19:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3333710F0;
        Wed, 29 Nov 2023 00:19:18 -0800 (PST)
Date:   Wed, 29 Nov 2023 08:19:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701245956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8qgge+FlNVmBpfaVyhYU/jwQ5H4K2/qa1aABsofXgC0=;
        b=BqI/1I/sw4x52TtB4ZRyUNfi9UXN2vhdjhDfQAJeY59I6FOeKhwRTRcBQQJYfSjrRAjC5L
        TtTxrcC3TQ8kjQDt/sbIXsXBffBJLu/MS/p4Ms9d3z301/iiIKN390GitLNlEH6inuBwoQ
        Pu8vlIkuz8bacMIiTmfmLr30ZD17EDCih8ABHkIULs9ADGKsqpOg6QyGCVkUoBmYKtigwr
        g3cT64t8TbmQhs7AQbO/KAvd0JkRJXV2AFrBSY5Slwm2RZ6aGGnqGjPdcO4OXspmfk10i3
        hjW1GJgZIG6OD/y21LDGWzhS9EtE9asmeORO44OFwWdK/TEom+OGLT9wz2N15Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701245956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8qgge+FlNVmBpfaVyhYU/jwQ5H4K2/qa1aABsofXgC0=;
        b=m2K8i7WKGgTecK9hfsdnRYto4T2f+FRdux+hTBa1WorrWUj8qqoLOCRkWod4yV1RbLjIKp
        e8zPnFSpavQGYYBw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Support Granite Rapids
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ammy Yi <ammy.yi@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231117163939.2468007-3-kan.liang@linux.intel.com>
References: <20231117163939.2468007-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <170124595576.398.12370446273177504421.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     632c4bf6d007862307440b177d9fee829857e8bb
Gitweb:        https://git.kernel.org/tip/632c4bf6d007862307440b177d9fee829857e8bb
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 17 Nov 2023 08:39:37 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 24 Nov 2023 20:25:01 +01:00

perf/x86/intel/uncore: Support Granite Rapids

The same as Sapphire Rapids, Granite Rapids also supports the discovery
table feature. All the basic uncore PMON information can be retrieved
from the discovery table which resides in the BIOS.

There are 4 new units are added on Granite Rapids, b2cmi, b2cxl, ubox,
and mdf_sbo. The layout of the counters is exactly the same as the
generic uncore counters. Only add a name for the new units. All the
details can be retrieved from the discovery table.
The description of the new units can be found at
https://www.intel.com/content/www/us/en/secure/content-details/772943/content-details.html

The other units, e.g., cha, iio, irp, pcu, and imc, are the same as
Sapphire Rapids.

Ignore the upi and b2upi units in the discovery table, which are broken
for now.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Ammy Yi <ammy.yi@intel.com>
Link: https://lore.kernel.org/r/20231117163939.2468007-3-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c       | 10 +++-
 arch/x86/events/intel/uncore.h       |  4 +-
 arch/x86/events/intel/uncore_snbep.c | 87 +++++++++++++++++++++++++++-
 3 files changed, 101 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 01023aa..7fb1c54 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1814,6 +1814,14 @@ static const struct intel_uncore_init_fun spr_uncore_init __initconst = {
 	.uncore_units_ignore = spr_uncore_units_ignore,
 };
 
+static const struct intel_uncore_init_fun gnr_uncore_init __initconst = {
+	.cpu_init = gnr_uncore_cpu_init,
+	.pci_init = gnr_uncore_pci_init,
+	.mmio_init = gnr_uncore_mmio_init,
+	.use_discovery = true,
+	.uncore_units_ignore = gnr_uncore_units_ignore,
+};
+
 static const struct intel_uncore_init_fun generic_uncore_init __initconst = {
 	.cpu_init = intel_uncore_generic_uncore_cpu_init,
 	.pci_init = intel_uncore_generic_uncore_pci_init,
@@ -1865,6 +1873,8 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&mtl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&spr_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,	&gnr_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_D,	&gnr_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&snr_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&adl_uncore_init),
 	{},
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 7428eca..4838502 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -593,6 +593,7 @@ extern struct list_head pci2phy_map_head;
 extern struct pci_extra_dev *uncore_extra_pci_dev;
 extern struct event_constraint uncore_constraint_empty;
 extern int spr_uncore_units_ignore[];
+extern int gnr_uncore_units_ignore[];
 
 /* uncore_snb.c */
 int snb_uncore_pci_init(void);
@@ -634,6 +635,9 @@ void icx_uncore_mmio_init(void);
 int spr_uncore_pci_init(void);
 void spr_uncore_cpu_init(void);
 void spr_uncore_mmio_init(void);
+int gnr_uncore_pci_init(void);
+void gnr_uncore_cpu_init(void);
+void gnr_uncore_mmio_init(void);
 
 /* uncore_nhmex.c */
 void nhmex_uncore_cpu_init(void);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 344319a..ab31cda 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6584,3 +6584,90 @@ void spr_uncore_mmio_init(void)
 }
 
 /* end of SPR uncore support */
+
+/* GNR uncore support */
+
+#define UNCORE_GNR_NUM_UNCORE_TYPES	23
+#define UNCORE_GNR_TYPE_15		15
+#define UNCORE_GNR_B2UPI		18
+#define UNCORE_GNR_TYPE_21		21
+#define UNCORE_GNR_TYPE_22		22
+
+int gnr_uncore_units_ignore[] = {
+	UNCORE_SPR_UPI,
+	UNCORE_GNR_TYPE_15,
+	UNCORE_GNR_B2UPI,
+	UNCORE_GNR_TYPE_21,
+	UNCORE_GNR_TYPE_22,
+	UNCORE_IGNORE_END
+};
+
+static struct intel_uncore_type gnr_uncore_ubox = {
+	.name			= "ubox",
+	.attr_update		= uncore_alias_groups,
+};
+
+static struct intel_uncore_type gnr_uncore_b2cmi = {
+	SPR_UNCORE_PCI_COMMON_FORMAT(),
+	.name			= "b2cmi",
+};
+
+static struct intel_uncore_type gnr_uncore_b2cxl = {
+	SPR_UNCORE_MMIO_COMMON_FORMAT(),
+	.name			= "b2cxl",
+};
+
+static struct intel_uncore_type gnr_uncore_mdf_sbo = {
+	.name			= "mdf_sbo",
+	.attr_update		= uncore_alias_groups,
+};
+
+static struct intel_uncore_type *gnr_uncores[UNCORE_GNR_NUM_UNCORE_TYPES] = {
+	&spr_uncore_chabox,
+	&spr_uncore_iio,
+	&spr_uncore_irp,
+	NULL,
+	&spr_uncore_pcu,
+	&gnr_uncore_ubox,
+	&spr_uncore_imc,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	&gnr_uncore_b2cmi,
+	&gnr_uncore_b2cxl,
+	NULL,
+	NULL,
+	&gnr_uncore_mdf_sbo,
+	NULL,
+	NULL,
+};
+
+void gnr_uncore_cpu_init(void)
+{
+	uncore_msr_uncores = uncore_get_uncores(UNCORE_ACCESS_MSR, 0, NULL,
+						UNCORE_GNR_NUM_UNCORE_TYPES,
+						gnr_uncores);
+}
+
+int gnr_uncore_pci_init(void)
+{
+	uncore_pci_uncores = uncore_get_uncores(UNCORE_ACCESS_PCI, 0, NULL,
+						UNCORE_GNR_NUM_UNCORE_TYPES,
+						gnr_uncores);
+	return 0;
+}
+
+void gnr_uncore_mmio_init(void)
+{
+	uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL,
+						 UNCORE_GNR_NUM_UNCORE_TYPES,
+						 gnr_uncores);
+}
+
+/* end of GNR uncore support */
