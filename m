Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEA17FD10D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjK2ITT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjK2ITM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:19:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CD41990;
        Wed, 29 Nov 2023 00:19:18 -0800 (PST)
Date:   Wed, 29 Nov 2023 08:19:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701245957;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=613qQrAItfeBdqDlIfIp86mma761JzSXjqdXNEXKyO8=;
        b=C9xVCI8/zaLgMwcrr/L30dE0oy/MmhL+Hm1WUdnlJgyfSYc5puF2TNJyV3w4n7kSmU2ixi
        jFTj25539WPScTGRHdaPV7KtJvUwQCSn+PQ9yFn1fsezOXP8UkU4DyovaX9PdnMltCubNA
        3S1g838g8AjNTJ5biUYVtP4olG0vGYzuLnZqncA3T2D9+luTnfAMBYZyLN9sxAN8i4NIyD
        ScGgu5cWSdJ70ENACkuZBA1KLOqKrc4rTk2iTSfNXtiVch3k528QeQQrT1mLPOyyYp8cpU
        NOntObSM0UHOn6E/YjK//Xn4sG8sq6OajDdEhhOIi3G85Ntj5GmZciTFq6yFLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701245957;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=613qQrAItfeBdqDlIfIp86mma761JzSXjqdXNEXKyO8=;
        b=xC/xIssdd8sCCnMIXWWpxxV4BAwKCZdTg99FdN/JdKxSqs7vq7ytf9N9DQxMwQR8jyhgN7
        YrAH8lgJjfZpCOAQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/uncore: Use u64 to replace unsigned for the
 uncore offsets array
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ammy Yi <ammy.yi@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231117163939.2468007-2-kan.liang@linux.intel.com>
References: <20231117163939.2468007-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <170124595632.398.8666452870830009586.tip-bot2@tip-bot2>
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

Commit-ID:     b560e0cd882b11921c84307efe139f1247434c5e
Gitweb:        https://git.kernel.org/tip/b560e0cd882b11921c84307efe139f1247434c5e
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 17 Nov 2023 08:39:36 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 24 Nov 2023 20:25:01 +01:00

perf/x86/uncore: Use u64 to replace unsigned for the uncore offsets array

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

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Ammy Yi <ammy.yi@intel.com>
Link: https://lore.kernel.org/r/20231117163939.2468007-2-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.h           | 6 +++---
 arch/x86/events/intel/uncore_discovery.c | 5 +++--
 arch/x86/events/intel/uncore_discovery.h | 2 +-
 arch/x86/events/intel/uncore_nhmex.c     | 2 +-
 arch/x86/events/intel/uncore_snbep.c     | 6 +++---
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index c30fb5b..7428eca 100644
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
index cb488e4..9a698a9 100644
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
index 6ee80ad..22e769a 100644
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
index 173e267..56eea2c 100644
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
index fc65870..344319a 100644
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
 
