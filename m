Return-Path: <linux-kernel+bounces-131587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDA48989C4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76CD1F2E337
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF23012A174;
	Thu,  4 Apr 2024 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EN9dMlAS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825471292E5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240291; cv=none; b=meuldSmIvOs8GuF+XLfsvBErRXTF6L5iqF8nv7DSurZ3lWv3CrilvQMmEYUfu4xO7KKz9C78Y2v+fzXRVv3AYfoq24+2AhroQR+D4BNLymXXAFb4GO+7syg6hgHbBP+sXQxPecJyC6j9RZxcIu+ELW31CVADP3zvRpyni8TvKVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240291; c=relaxed/simple;
	bh=xo7QFTh0lAdxRyHU1YBKFWYm1MYwdyanuWHejyqo3Yg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uU+yX4lm19sn+vZO0CaQcwESR1QJHDJBm/0MC5ZdnGTPc1Avb4yBulWQH3INQN0MjggPc6//usKpn8kBAQn/eCoruiKsKC6Y5gFITJQl7P7QWx2hMMEcdG8R0jXIFzmJP8CU3SUVQnojrAuvy0mdQ2dUi20xOj6/PDOmfdjGvgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EN9dMlAS; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712240290; x=1743776290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xo7QFTh0lAdxRyHU1YBKFWYm1MYwdyanuWHejyqo3Yg=;
  b=EN9dMlAS+i0VLBQf4Dl0+DR+BPxiPO0y4Y9fZOxZ6WPdIdBtXF+Ek1Sv
   kfUQsMrsLnKjZkk/1qQ2oeoRcCIJ1LdD5LiRVNQs4VSkv7rgp0T4+TbzJ
   XCoM3UZbWFSzMijSj+lUdO2LC00Q6CJRraMTibo19AqjjdTZVsfrtQ2oh
   o7xp36GMW2aS7O7FwzJzHaNk8MuplsgaPsUWv7hSnLfpIM2Pe5JvZwof3
   zM8IBwfHnaOFKndAoltpc3SJirtUFuxmX+GULk+srOqS6XDDXkb9v4gdK
   t9CKgPphY03gKpvmeNCoCzNv13R5CejZir34ODGSC3R0/b80Q1J5OZqgD
   w==;
X-CSE-ConnectionGUID: CAoH38RqTyq9wnYC3YgLIw==
X-CSE-MsgGUID: Pjrgv2M7TpmvZUmlxMJlUw==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7632425"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7632425"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 07:18:09 -0700
X-CSE-ConnectionGUID: slN87P/jTh2/jA7tLC1ZaA==
X-CSE-MsgGUID: 6y9Sw2AgQn2iq5mZE0xGOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23448356"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa004.fm.intel.com with ESMTP; 04 Apr 2024 07:18:07 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/4] perf/x86/intel/uncore: Add Lunar Lake and Arrow Lake support
Date: Thu,  4 Apr 2024 07:17:04 -0700
Message-Id: <20240404141706.1235531-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240404141706.1235531-1-kan.liang@linux.intel.com>
References: <20240404141706.1235531-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The uncore subsystem for Lunar Lake and Arrow Lake are similar to the
previous Meteor Lake. The uncore PerfMon registers are located at both
MSR and MMIO space.

The CBOX, ARB, and iMC are kept. There is no difference from the
Meteor Lake.

The sNCU is moved to the MMIO space.

The HBO is newly added and only be accessed from the MMIO space.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c     |   7 ++
 arch/x86/events/intel/uncore.h     |   2 +
 arch/x86/events/intel/uncore_snb.c | 117 +++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 258e2cdf28fa..8408303fa41f 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1794,6 +1794,11 @@ static const struct intel_uncore_init_fun mtl_uncore_init __initconst = {
 	.mmio_init = adl_uncore_mmio_init,
 };
 
+static const struct intel_uncore_init_fun lnl_uncore_init __initconst = {
+	.cpu_init = lnl_uncore_cpu_init,
+	.mmio_init = lnl_uncore_mmio_init,
+};
+
 static const struct intel_uncore_init_fun icx_uncore_init __initconst = {
 	.cpu_init = icx_uncore_cpu_init,
 	.pci_init = icx_uncore_pci_init,
@@ -1871,6 +1876,8 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,		&mtl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&mtl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(LUNARLAKE_M,		&lnl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE,		&lnl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,	&gnr_uncore_init),
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 4838502d89ae..edebb5a6c9a0 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -607,10 +607,12 @@ void skl_uncore_cpu_init(void);
 void icl_uncore_cpu_init(void);
 void tgl_uncore_cpu_init(void);
 void adl_uncore_cpu_init(void);
+void lnl_uncore_cpu_init(void);
 void mtl_uncore_cpu_init(void);
 void tgl_uncore_mmio_init(void);
 void tgl_l_uncore_mmio_init(void);
 void adl_uncore_mmio_init(void);
+void lnl_uncore_mmio_init(void);
 int snb_pci2phy_map_init(int devid);
 
 /* uncore_snbep.c */
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 05fe6e90bd8e..d1605163f11e 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -252,6 +252,7 @@ DEFINE_UNCORE_FORMAT_ATTR(inv, inv, "config:23");
 DEFINE_UNCORE_FORMAT_ATTR(cmask5, cmask, "config:24-28");
 DEFINE_UNCORE_FORMAT_ATTR(cmask8, cmask, "config:24-31");
 DEFINE_UNCORE_FORMAT_ATTR(threshold, threshold, "config:24-29");
+DEFINE_UNCORE_FORMAT_ATTR(threshold2, threshold, "config:24-31");
 
 /* Sandy Bridge uncore support */
 static void snb_uncore_msr_enable_event(struct intel_uncore_box *box, struct perf_event *event)
@@ -746,6 +747,18 @@ void mtl_uncore_cpu_init(void)
 	uncore_msr_uncores = mtl_msr_uncores;
 }
 
+static struct intel_uncore_type *lnl_msr_uncores[] = {
+	&mtl_uncore_cbox,
+	&mtl_uncore_arb,
+	NULL
+};
+
+void lnl_uncore_cpu_init(void)
+{
+	mtl_uncore_cbox.num_boxes = 4;
+	uncore_msr_uncores = lnl_msr_uncores;
+}
+
 enum {
 	SNB_PCI_UNCORE_IMC,
 };
@@ -1716,3 +1729,107 @@ void adl_uncore_mmio_init(void)
 }
 
 /* end of Alder Lake MMIO uncore support */
+
+/* Lunar Lake MMIO uncore support */
+#define LNL_UNCORE_PCI_SAFBAR_OFFSET		0x68
+#define LNL_UNCORE_MAP_SIZE			0x1000
+#define LNL_UNCORE_SNCU_BASE			0xE4B000
+#define LNL_UNCORE_SNCU_CTR			0x390
+#define LNL_UNCORE_SNCU_CTRL			0x398
+#define LNL_UNCORE_SNCU_BOX_CTL			0x380
+#define LNL_UNCORE_GLOBAL_CTL			0x700
+#define LNL_UNCORE_HBO_BASE			0xE54000
+#define LNL_UNCORE_HBO_OFFSET			-4096
+#define LNL_UNCORE_HBO_CTR			0x570
+#define LNL_UNCORE_HBO_CTRL			0x550
+#define LNL_UNCORE_HBO_BOX_CTL			0x548
+
+#define LNL_UNC_CTL_THRESHOLD			0xff000000
+#define LNL_UNC_RAW_EVENT_MASK			(SNB_UNC_CTL_EV_SEL_MASK | \
+						 SNB_UNC_CTL_UMASK_MASK | \
+						 SNB_UNC_CTL_EDGE_DET | \
+						 SNB_UNC_CTL_INVERT | \
+						 LNL_UNC_CTL_THRESHOLD)
+
+static struct attribute *lnl_uncore_formats_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_umask.attr,
+	&format_attr_edge.attr,
+	&format_attr_inv.attr,
+	&format_attr_threshold2.attr,
+	NULL
+};
+
+static const struct attribute_group lnl_uncore_format_group = {
+	.name		= "format",
+	.attrs		= lnl_uncore_formats_attr,
+};
+
+static void lnl_uncore_hbo_init_box(struct intel_uncore_box *box)
+{
+	uncore_get_box_mmio_addr(box, LNL_UNCORE_HBO_BASE,
+				 LNL_UNCORE_PCI_SAFBAR_OFFSET,
+				 LNL_UNCORE_HBO_OFFSET);
+}
+
+static struct intel_uncore_ops lnl_uncore_hbo_ops = {
+	.init_box	= lnl_uncore_hbo_init_box,
+	MMIO_UNCORE_COMMON_OPS()
+};
+
+static struct intel_uncore_type lnl_uncore_hbo = {
+	.name		= "hbo",
+	.num_counters   = 4,
+	.num_boxes	= 2,
+	.perf_ctr_bits	= 64,
+	.perf_ctr	= LNL_UNCORE_HBO_CTR,
+	.event_ctl	= LNL_UNCORE_HBO_CTRL,
+	.event_mask	= LNL_UNC_RAW_EVENT_MASK,
+	.box_ctl	= LNL_UNCORE_HBO_BOX_CTL,
+	.mmio_map_size	= LNL_UNCORE_MAP_SIZE,
+	.ops		= &lnl_uncore_hbo_ops,
+	.format_group	= &lnl_uncore_format_group,
+};
+
+static void lnl_uncore_sncu_init_box(struct intel_uncore_box *box)
+{
+	uncore_get_box_mmio_addr(box, LNL_UNCORE_SNCU_BASE,
+				 LNL_UNCORE_PCI_SAFBAR_OFFSET,
+				 0);
+
+	if (box->io_addr)
+		writel(ADL_UNCORE_IMC_CTL_INT, box->io_addr + LNL_UNCORE_GLOBAL_CTL);
+}
+
+static struct intel_uncore_ops lnl_uncore_sncu_ops = {
+	.init_box	= lnl_uncore_sncu_init_box,
+	MMIO_UNCORE_COMMON_OPS()
+};
+
+static struct intel_uncore_type lnl_uncore_sncu = {
+	.name		= "sncu",
+	.num_counters   = 2,
+	.num_boxes	= 1,
+	.perf_ctr_bits	= 64,
+	.perf_ctr	= LNL_UNCORE_SNCU_CTR,
+	.event_ctl	= LNL_UNCORE_SNCU_CTRL,
+	.event_mask	= LNL_UNC_RAW_EVENT_MASK,
+	.box_ctl	= LNL_UNCORE_SNCU_BOX_CTL,
+	.mmio_map_size	= LNL_UNCORE_MAP_SIZE,
+	.ops		= &lnl_uncore_sncu_ops,
+	.format_group	= &lnl_uncore_format_group,
+};
+
+static struct intel_uncore_type *lnl_mmio_uncores[] = {
+	&adl_uncore_imc,
+	&lnl_uncore_hbo,
+	&lnl_uncore_sncu,
+	NULL
+};
+
+void lnl_uncore_mmio_init(void)
+{
+	uncore_mmio_uncores = lnl_mmio_uncores;
+}
+
+/* end of Lunar Lake MMIO uncore support */
-- 
2.35.1


