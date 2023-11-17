Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE247EF65B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346135AbjKQQj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346117AbjKQQjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:39:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00678D4B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 08:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700239192; x=1731775192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=luUpQwdOFY2sOihm+F4UzO30tVZ0bcq8Vqnr7JY27Wc=;
  b=ibVTt/ciTM1Rbx5u0zjQQVlWZt4dy1FfppF6iur2BWIC8e8ufl4zkE3+
   QwL2pkhzwYVoHuR06fCKCsLRxMs8QZ9CEv3m2bWlKXqGJL1On0RBiVRxm
   MY5cEVcR8//RCpzL3HLtOKgCWuE+4wlGRH1OUQsSrDd0UkIM8f7DGEGFW
   7iVowYMfc7+NqQbZu6vzLD93aE3ZIAOcS1wCPuMS1wzbClGktk9VgsfSa
   CeW7CLX1VOZhK0sVDhUdF+OhlBs6sfOJzFxVh5fBg7FPijUvzk9DCwcv2
   X1pzxnT72BDdEqjcG6MFaFH4Wv/6+j2tDP3P5Cs1BfNgAaq8iRCNJeQqd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="390185877"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="390185877"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 08:39:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="1097146196"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="1097146196"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga005.fm.intel.com with ESMTP; 17 Nov 2023 08:39:49 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Ammy Yi <ammy.yi@intel.com>
Subject: [PATCH V2 2/5] perf/x86/uncore: Use u64 to replace unsigned for the uncore offsets array
Date:   Fri, 17 Nov 2023 08:39:36 -0800
Message-Id: <20231117163939.2468007-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231117163939.2468007-1-kan.liang@linux.intel.com>
References: <20231117163939.2468007-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The current perf doesn't save the complete address of an uncore unit.
The complete address of each unit is calculated by the base address +
offset. The type of the base address is u64, while the type of offset is
unsigned.
In the old platforms (without the discovery table method), the base
address and offset are hard coded in the driver. Perf can always use the
lowest address as the base address. Everything works well.

In the new platforms (starting from SPR), the discovery table provides
a complete address for all uncore units. To follow the current
framework/codes, when parsing the discovery table, the complete address
of the first box is stored as a base address. The offset of the
following units is calculated by the complete address of the unit minus
the base address (the address of the first unit). On GNR, the latter
units may have a lower address compared to the first unit. So the offset
is a negative value. The upper 32 bits are lost when casting a negative
u64 to an unsigned type.

Use u64 to replace unsigned for the uncore offsets array to correct the
above case. There is no functional change.

Tested-by: Ammy Yi <ammy.yi@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
- Add Tested-by tag

 arch/x86/events/intel/uncore.h           | 6 +++---
 arch/x86/events/intel/uncore_discovery.c | 5 +++--
 arch/x86/events/intel/uncore_discovery.h | 2 +-
 arch/x86/events/intel/uncore_nhmex.c     | 2 +-
 arch/x86/events/intel/uncore_snbep.c     | 6 +++---
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index c30fb5bb1222..7428ecaddf72 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -72,9 +72,9 @@ struct intel_uncore_type {
 	unsigned single_fixed:1;
 	unsigned pair_ctr_ctl:1;
 	union {
-		unsigned *msr_offsets;
-		unsigned *pci_offsets;
-		unsigned *mmio_offsets;
+		u64 *msr_offsets;
+		u64 *pci_offsets;
+		u64 *mmio_offsets;
 	};
 	unsigned *box_ids;
 	struct event_constraint unconstrainted;
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index cb488e41807c..9a698a92962a 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -125,7 +125,8 @@ uncore_insert_box_info(struct uncore_unit_discovery *unit,
 		       int die, bool parsed)
 {
 	struct intel_uncore_discovery_type *type;
-	unsigned int *box_offset, *ids;
+	unsigned int *ids;
+	u64 *box_offset;
 	int i;
 
 	if (!unit->ctl || !unit->ctl_offset || !unit->ctr_offset) {
@@ -153,7 +154,7 @@ uncore_insert_box_info(struct uncore_unit_discovery *unit,
 	if (!type)
 		return;
 
-	box_offset = kcalloc(type->num_boxes + 1, sizeof(unsigned int), GFP_KERNEL);
+	box_offset = kcalloc(type->num_boxes + 1, sizeof(u64), GFP_KERNEL);
 	if (!box_offset)
 		return;
 
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 6ee80ad3423e..22e769a81103 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -125,7 +125,7 @@ struct intel_uncore_discovery_type {
 	u8		ctr_offset;	/* Counter 0 offset */
 	u16		num_boxes;	/* number of boxes for the uncore block */
 	unsigned int	*ids;		/* Box IDs */
-	unsigned int	*box_offset;	/* Box offset */
+	u64		*box_offset;	/* Box offset */
 };
 
 bool intel_uncore_has_discovery_tables(int *ignore);
diff --git a/arch/x86/events/intel/uncore_nhmex.c b/arch/x86/events/intel/uncore_nhmex.c
index 173e2674be6e..56eea2c66cfb 100644
--- a/arch/x86/events/intel/uncore_nhmex.c
+++ b/arch/x86/events/intel/uncore_nhmex.c
@@ -306,7 +306,7 @@ static const struct attribute_group nhmex_uncore_cbox_format_group = {
 };
 
 /* msr offset for each instance of cbox */
-static unsigned nhmex_cbox_msr_offsets[] = {
+static u64 nhmex_cbox_msr_offsets[] = {
 	0x0, 0x80, 0x40, 0xc0, 0x20, 0xa0, 0x60, 0xe0, 0x240, 0x2c0,
 };
 
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index fc6587016af7..344319ab6dd5 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5278,7 +5278,7 @@ void snr_uncore_mmio_init(void)
 
 /* ICX uncore support */
 
-static unsigned icx_cha_msr_offsets[] = {
+static u64 icx_cha_msr_offsets[] = {
 	0x2a0, 0x2ae, 0x2bc, 0x2ca, 0x2d8, 0x2e6, 0x2f4, 0x302, 0x310,
 	0x31e, 0x32c, 0x33a, 0x348, 0x356, 0x364, 0x372, 0x380, 0x38e,
 	0x3aa, 0x3b8, 0x3c6, 0x3d4, 0x3e2, 0x3f0, 0x3fe, 0x40c, 0x41a,
@@ -5326,7 +5326,7 @@ static struct intel_uncore_type icx_uncore_chabox = {
 	.format_group		= &snr_uncore_chabox_format_group,
 };
 
-static unsigned icx_msr_offsets[] = {
+static u64 icx_msr_offsets[] = {
 	0x0, 0x20, 0x40, 0x90, 0xb0, 0xd0,
 };
 
@@ -6184,7 +6184,7 @@ static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
  */
 #define SPR_UNCORE_UPI_NUM_BOXES	4
 
-static unsigned int spr_upi_pci_offsets[SPR_UNCORE_UPI_NUM_BOXES] = {
+static u64 spr_upi_pci_offsets[SPR_UNCORE_UPI_NUM_BOXES] = {
 	0, 0x8000, 0x10000, 0x18000
 };
 
-- 
2.35.1

