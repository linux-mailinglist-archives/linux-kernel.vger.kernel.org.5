Return-Path: <linux-kernel+bounces-71849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA4B85ABAF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0911C21F55
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD1C4F212;
	Mon, 19 Feb 2024 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="erdwcROx"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C878487A3
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 18:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708369111; cv=none; b=HKqRKFi4IOuQVELcYHEoNJpne7FRovAFyhU6SmgYicZ04pFNPRAl4iGBADCweW48c5ZYfcmtGDZMGgU+fUJJBpYh/35TdHHO+BenfFq66v6RLCkpR89Dl7N6vKckt/N6NzI28qELWsBKvMcQLwHB2/g5UU31apiJecUYa8pBbRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708369111; c=relaxed/simple;
	bh=AVsdCCM8FvfXsv0NexSqvyqeP7RkJJs+vf3bnHoUDbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEQqmj4F2Xja86x2jUzuRUZuLloyU+bBvIKgZUjQUP5MmkqFAtBI6Tnx7gVDP5i1RdnF7Lv8ZqEXV9wL+KUVqve3pDHLAZ4V9IchL+05SGssmolAJVchs0IYuAWTBHDkLZWTCqQf4gyJbns2rvh5Gl6VgLj5PhWKmuAg55cMnPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=erdwcROx; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708369107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6mYbl34iGDajSSuwNwYK5N248BsKIXOEJAXAf9uLUE=;
	b=erdwcROxjTVj9GYsF9NxwZtHNpUShYCx45EDDOMeS+jAJihxWdrPa0U1lhk/4/FnuC7+2g
	6JUYy8lf8giYc6dFvutLvzVCiE2tKOwcceN27OylehFuPrm9rlUze2Uoy930paO+8vWiFX
	OVADPtybepCZRTctZIlkmbbnW0WSTKY=
From: Oliver Upton <oliver.upton@linux.dev>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	Jing Zhang <jingzhangos@google.com>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH 3/3] irqchip/gic-v3-its: Print the vPE table installed in redistributor
Date: Mon, 19 Feb 2024 18:58:08 +0000
Message-ID: <20240219185809.286724-4-oliver.upton@linux.dev>
In-Reply-To: <20240219185809.286724-1-oliver.upton@linux.dev>
References: <20240219185809.286724-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hindsight is 20/20 of course, but the recent vPE table programming bug
could've been root caused a bit more quickly if we print the table
getting installed at every redistributor.

Promote to pr_info() and add some additional context, such as the
provenance of the installed vPE table.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 drivers/irqchip/irq-gic-v3-its.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 63d1743f08cc..c3ef9665a2ad 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2835,7 +2835,8 @@ static int allocate_vpe_l1_table(void)
 	u64 val, gpsz, npg, pa;
 	unsigned int psz = SZ_64K;
 	unsigned int np, epp, esz;
-	struct page *page;
+	struct page *page = NULL;
+	bool from_its = false;
 
 	if (!gic_rdists->has_rvpeid)
 		return 0;
@@ -2865,8 +2866,10 @@ static int allocate_vpe_l1_table(void)
 		return -ENOMEM;
 
 	val = inherit_vpe_l1_table_from_its();
-	if (val & GICR_VPROPBASER_4_1_VALID)
+	if (val & GICR_VPROPBASER_4_1_VALID) {
+		from_its = true;
 		goto out;
+	}
 
 	/* First probe the page size */
 	val = FIELD_PREP(GICR_VPROPBASER_4_1_PAGE_SIZE, GIC_PAGE_SIZE_64K);
@@ -2945,9 +2948,12 @@ static int allocate_vpe_l1_table(void)
 	gicr_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
 	cpumask_set_cpu(smp_processor_id(), gic_data_rdist()->vpe_table_mask);
 
-	pr_debug("CPU%d: VPROPBASER = %llx %*pbl\n",
-		 smp_processor_id(), val,
-		 cpumask_pr_args(gic_data_rdist()->vpe_table_mask));
+	pr_info("CPU%d: Using %s vPE table @%llx (%s)\n",
+		smp_processor_id(),
+		(val & GICR_VPROPBASER_4_1_INDIRECT) ? "indirect" : "direct",
+		val & GICR_VPROPBASER_4_1_ADDR,
+		(page) ? "allocated" :
+			 ((from_its) ? "inherited from ITS" : "inherited from RD"));
 
 	return 0;
 }
-- 
2.44.0.rc0.258.g7320e95886-goog


