Return-Path: <linux-kernel+bounces-71848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE2785ABAE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65AA6B25BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C704EB40;
	Mon, 19 Feb 2024 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MRaf230x"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D61487B8
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708369109; cv=none; b=uQfIsX+wZMS8JLUfh/mZifPGgfRoSgoh4ojjv8bl6QLLb/aK7pkWI9r0/e9ZfYZ67CJn9MK0615jM0oQJqlHgH1d5sROMJhONVjn+Opbkbpo8vsNJ+KaEXUfYnjLmvkmMltc/UYpPxtE/B+WywUZ+xBkTdAqQakO7/fgBN+br8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708369109; c=relaxed/simple;
	bh=sQ09ukYCJMs0FVbHxpjJQwqr/OlvaGUdTVWxvm0dbCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvAM40z7/Jz4RUdwYOYkGdX96x7duDtQvoXcl2h0kFWn7iE8m176SxFaVdl5lQ/Ir4IhVrh2vDz8JRTCtpmvRDj+NaYNujf4Wz2hbHrHbIClQ4G5mrPHpumGGMcAsO47K662CSQjpOvMldqPs82/b7lku8TvrBU7j1R5EUarkf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MRaf230x; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708369105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0uvz70joVA5h7nCkx+6qjmdsOAE7FpYRNnHlS3lny0=;
	b=MRaf230xQXz2XUHhNl+qaNg7U148naafFkbpIjvX5ofDIryb/ebMbKl5AfD5yIdB2kC01m
	TSiy2qQWMMmXuqWaBa+9n70/T2Rb0eTsoKGEIAtME5P0eyHqLqsVN+VLPwaNManRBOUCU+
	QyOgXYqz7O7W3v3Lo+/zZnKrDywl9lU=
From: Oliver Upton <oliver.upton@linux.dev>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	Jing Zhang <jingzhangos@google.com>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH 2/3] irqchip/gic-v3-its: Spin off GICv4 init into a separate function
Date: Mon, 19 Feb 2024 18:58:07 +0000
Message-ID: <20240219185809.286724-3-oliver.upton@linux.dev>
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

Burying the GICv4 redistributor initialization into the routine for LPIs
is a bit confusing, and can lead to sillies where unexpected codepaths
may not fully initialize the RD.

Hoist it out of its_cpu_init_lpis() into a dedicated function.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 drivers/irqchip/irq-gic-v3-its.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 0022852ce494..63d1743f08cc 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3173,8 +3173,25 @@ static void its_cpu_init_lpis(void)
 	writel_relaxed(val, rbase + GICR_CTLR);
 
 out:
-	if (gic_rdists->has_vlpis && !gic_rdists->has_rvpeid) {
+	/* Make sure the GIC has seen the above */
+	dsb(sy);
+	gic_data_rdist()->flags |= RD_LOCAL_LPI_ENABLED;
+	pr_info("GICv3: CPU%d: using %s LPI pending table @%pa\n",
+		smp_processor_id(),
+		gic_data_rdist()->flags & RD_LOCAL_PENDTABLE_PREALLOCATED ?
+		"reserved" : "allocated",
+		&paddr);
+}
+
+static void its_cpu_init_vlpis(void)
+{
+	/* No vLPIs? No problem. */
+	if (!gic_rdists->has_vlpis)
+		return;
+
+	if (!gic_rdists->has_rvpeid) {
 		void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
+		u64 val;
 
 		/*
 		 * It's possible for CPU to receive VLPIs before it is
@@ -3193,7 +3210,8 @@ static void its_cpu_init_lpis(void)
 		 * ancient programming gets left in and has possibility of
 		 * corrupting memory.
 		 */
-		val = its_clear_vpend_valid(vlpi_base, 0, 0);
+		its_clear_vpend_valid(vlpi_base, 0, 0);
+		return;
 	}
 
 	if (allocate_vpe_l1_table()) {
@@ -3205,15 +3223,6 @@ static void its_cpu_init_lpis(void)
 		gic_rdists->has_rvpeid = false;
 		gic_rdists->has_vlpis = false;
 	}
-
-	/* Make sure the GIC has seen the above */
-	dsb(sy);
-	gic_data_rdist()->flags |= RD_LOCAL_LPI_ENABLED;
-	pr_info("GICv3: CPU%d: using %s LPI pending table @%pa\n",
-		smp_processor_id(),
-		gic_data_rdist()->flags & RD_LOCAL_PENDTABLE_PREALLOCATED ?
-		"reserved" : "allocated",
-		&paddr);
 }
 
 static void its_cpu_init_collection(struct its_node *its)
@@ -5265,6 +5274,7 @@ int its_cpu_init(void)
 			return ret;
 
 		its_cpu_init_lpis();
+		its_cpu_init_vlpis();
 		its_cpu_init_collections();
 	}
 
-- 
2.44.0.rc0.258.g7320e95886-goog


