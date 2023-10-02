Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA797B564A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237955AbjJBPDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237937AbjJBPDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:03:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DA2B3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696259002; x=1727795002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TfyWhxyy1mDgZc/yF4XXTFgx0fC2YWrU9qvajoWde6s=;
  b=e0iY/kpxqZVB2xC5kt50rCVMlfUy0jRVwq9XOSeBw/J/Mbn0InOvytoT
   z4mvhwYJrEkDCwiIEu5idesk9cDHZZAluGFhcw/Nv/0IPprTerttWDCXs
   fs46RHgII+ux2PB+K2u1xn1VcPAL7qygsvBOYpWxkDIT7t32rt+uoYkyA
   KBmH3Hhseg4ddltCmU1FYL3paN7jvRWmJWhLFog6JqYQelTiLliAmM3PV
   8PGmqGjKO8AYEdtmAMppi8twIzFGFKp0qv8aw/emSjd0uIB/NNYQU6Eaq
   Typ+T0PO/jTPDaEQX+Y9m75NB8jiih1e5+c8SQ8afsVkctjnj4JkUvcPy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="362033043"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="362033043"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 08:03:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="820904661"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="820904661"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga004.fm.intel.com with ESMTP; 02 Oct 2023 08:03:19 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/5] perf/x86/intel/uncore: Support Granite Rapids
Date:   Mon,  2 Oct 2023 08:03:23 -0700
Message-Id: <20231002150325.2025749-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231002150325.2025749-1-kan.liang@linux.intel.com>
References: <20231002150325.2025749-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

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
---
 arch/x86/events/intel/uncore.c       | 10 ++++
 arch/x86/events/intel/uncore.h       |  4 ++
 arch/x86/events/intel/uncore_snbep.c | 81 ++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 69043e02e8a7..01c01cae82ef 100644
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
index 7428ecaddf72..4838502d89ae 100644
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
index dfe4a84f25c6..e2ce97d73a31 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6574,3 +6574,84 @@ void spr_uncore_mmio_init(void)
 }
 
 /* end of SPR uncore support */
+
+/* GNR uncore support */
+
+#define UNCORE_GNR_NUM_UNCORE_TYPES	21
+#define UNCORE_GNR_TYPE_15		15
+#define UNCORE_GNR_B2UPI		18
+
+int gnr_uncore_units_ignore[] = {
+	UNCORE_SPR_UPI,
+	UNCORE_GNR_TYPE_15,
+	UNCORE_GNR_B2UPI,
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
-- 
2.35.1

