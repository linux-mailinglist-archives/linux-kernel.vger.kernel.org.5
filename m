Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CF07FD10E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjK2ITU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjK2ITM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:19:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DB319B9;
        Wed, 29 Nov 2023 00:19:19 -0800 (PST)
Date:   Wed, 29 Nov 2023 08:19:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701245957;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mYdBB1y2w8imwSVNLrrn9soOECA16N3YfGk3g89M6vQ=;
        b=UtcX/Hcf7jPXWc141+40L2ZXuvKBhZWrO8QRoQ6/4ypymh44JbStMItEHZzQkj2/F7BH3p
        QTCZnPldwjw/LLiYdkvZfTpBvHWMJ6l00MDbtIjyeDvU5W0g2tRDmzEJLknrBmwXXj9not
        gw47QosVa8yN5G+fIP4ESL2rVB5hPdZUAZaDacgO22gIxSCiTR5SOeRDowAFGmAD0KjnJS
        G599Sh+LawMhSl1/umoLUaMEVjbXxX4gtdP1Lk2PHooX+OH31Zf2htdLQGU1CpXFGWgknL
        ScDHccvQMQlWGCbJ0VF3ZVOxQTb3VhVF97Zi4QckJtRU3RJleXFLjaTtFme9Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701245957;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mYdBB1y2w8imwSVNLrrn9soOECA16N3YfGk3g89M6vQ=;
        b=1+T2/IDX8RePLv3IE9GKwafkJZXMIoE5Ra3UPUVojvVAGG0Ua3tAJBw/goqMg7zq9U5YTh
        i1NUKXa7RsqD38DQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Generic uncore_get_uncores
 and MMIO format of SPR
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ammy Yi <ammy.yi@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231117163939.2468007-1-kan.liang@linux.intel.com>
References: <20231117163939.2468007-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <170124595695.398.7379358629309121857.tip-bot2@tip-bot2>
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

Commit-ID:     cf35791476fcb3230b98a42241a56242d60ebdd3
Gitweb:        https://git.kernel.org/tip/cf35791476fcb3230b98a42241a56242d60ebdd3
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 17 Nov 2023 08:39:35 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 24 Nov 2023 20:25:00 +01:00

perf/x86/intel/uncore: Generic uncore_get_uncores and MMIO format of SPR

Factor out SPR_UNCORE_MMIO_COMMON_FORMAT which can be reused by
Granite Rapids in the following patch.

Granite Rapids have more uncore units than Sapphire Rapids. Add new
parameters to support adjustable uncore units.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Ammy Yi <ammy.yi@intel.com>
Link: https://lore.kernel.org/r/20231117163939.2468007-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 34 ++++++++++++++++++---------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 8250f0f..fc65870 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6079,13 +6079,16 @@ static struct uncore_event_desc spr_uncore_imc_events[] = {
 	{ /* end: all zeroes */ },
 };
 
+#define SPR_UNCORE_MMIO_COMMON_FORMAT()				\
+	SPR_UNCORE_COMMON_FORMAT(),				\
+	.ops			= &spr_uncore_mmio_ops
+
 static struct intel_uncore_type spr_uncore_imc = {
-	SPR_UNCORE_COMMON_FORMAT(),
+	SPR_UNCORE_MMIO_COMMON_FORMAT(),
 	.name			= "imc",
 	.fixed_ctr_bits		= 48,
 	.fixed_ctr		= SNR_IMC_MMIO_PMON_FIXED_CTR,
 	.fixed_ctl		= SNR_IMC_MMIO_PMON_FIXED_CTL,
-	.ops			= &spr_uncore_mmio_ops,
 	.event_descs		= spr_uncore_imc_events,
 };
 
@@ -6412,7 +6415,8 @@ static void uncore_type_customized_copy(struct intel_uncore_type *to_type,
 
 static struct intel_uncore_type **
 uncore_get_uncores(enum uncore_access_type type_id, int num_extra,
-		    struct intel_uncore_type **extra)
+		   struct intel_uncore_type **extra, int max_num_types,
+		   struct intel_uncore_type **uncores)
 {
 	struct intel_uncore_type **types, **start_types;
 	int i;
@@ -6421,9 +6425,9 @@ uncore_get_uncores(enum uncore_access_type type_id, int num_extra,
 
 	/* Only copy the customized features */
 	for (; *types; types++) {
-		if ((*types)->type_id >= UNCORE_SPR_NUM_UNCORE_TYPES)
+		if ((*types)->type_id >= max_num_types)
 			continue;
-		uncore_type_customized_copy(*types, spr_uncores[(*types)->type_id]);
+		uncore_type_customized_copy(*types, uncores[(*types)->type_id]);
 	}
 
 	for (i = 0; i < num_extra; i++, types++)
@@ -6470,7 +6474,9 @@ void spr_uncore_cpu_init(void)
 
 	uncore_msr_uncores = uncore_get_uncores(UNCORE_ACCESS_MSR,
 						UNCORE_SPR_MSR_EXTRA_UNCORES,
-						spr_msr_uncores);
+						spr_msr_uncores,
+						UNCORE_SPR_NUM_UNCORE_TYPES,
+						spr_uncores);
 
 	type = uncore_find_type_by_id(uncore_msr_uncores, UNCORE_SPR_CHA);
 	if (type) {
@@ -6552,7 +6558,9 @@ int spr_uncore_pci_init(void)
 	spr_update_device_location(UNCORE_SPR_M3UPI);
 	uncore_pci_uncores = uncore_get_uncores(UNCORE_ACCESS_PCI,
 						UNCORE_SPR_PCI_EXTRA_UNCORES,
-						spr_pci_uncores);
+						spr_pci_uncores,
+						UNCORE_SPR_NUM_UNCORE_TYPES,
+						spr_uncores);
 	return 0;
 }
 
@@ -6560,12 +6568,16 @@ void spr_uncore_mmio_init(void)
 {
 	int ret = snbep_pci2phy_map_init(0x3250, SKX_CPUNODEID, SKX_GIDNIDMAP, true);
 
-	if (ret)
-		uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL);
-	else {
+	if (ret) {
+		uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL,
+							 UNCORE_SPR_NUM_UNCORE_TYPES,
+							 spr_uncores);
+	} else {
 		uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO,
 							 UNCORE_SPR_MMIO_EXTRA_UNCORES,
-							 spr_mmio_uncores);
+							 spr_mmio_uncores,
+							 UNCORE_SPR_NUM_UNCORE_TYPES,
+							 spr_uncores);
 
 		spr_uncore_imc_free_running.num_boxes = uncore_type_max_boxes(uncore_mmio_uncores, UNCORE_SPR_IMC) / 2;
 	}
