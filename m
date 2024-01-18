Return-Path: <linux-kernel+bounces-30052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B00B3831874
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36631C20E05
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF60C241F5;
	Thu, 18 Jan 2024 11:30:00 +0000 (UTC)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F746241E6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705577400; cv=none; b=rfN+v0reGB+9DCp6x+FDufiYyKfSvGCfbKGGvwPDrlxQVsExRA10PgBPCdYAF9MuX3onpTA7f7Wm89Mgb08y2hsWag7N9b+LqirspksjpxUUo/UsYJB3c7ZR6L5G5Jyg6eNuwoPttHKHMi/S4Zkwr26QocWeUiFtDybAy0QknMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705577400; c=relaxed/simple;
	bh=mxbFnAWvYxONRJamr2rRROrpwNYKGzQx7a4/fqyrHh0=;
	h=X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:X-QQ-FEAT:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID; b=Q6jQxx//thS5dm6Q54ev5JFl/tyR1puS3aVUoglB8v7PeL0ZEIvu5kIlrcBivFgejgitUJ3wgxxvPeWKJs/xkL7Ne72hxCRS+Q5/jDaebZZfHJ+3v5jxo+2tO8Wez9P2y2eQNzOtW/6tWGuN9Oot8P+MmBdId7UbN3+CMp1Bj1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp83t1705577367t5i7m3uq
X-QQ-Originating-IP: crRyA8ASh2OZBJ3ZtqXMJ8f2PolwNAW2z3CcI2liUJg=
Received: from localhost ( [183.209.108.228])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jan 2024 19:29:26 +0800 (CST)
X-QQ-SSF: 01400000000000504000000K0000000
X-QQ-FEAT: 96k0+YG2NiUznyX94RbUHJpQca5nJHiVw3v/7rb0ObtAxL1zT+7AZvIDS6qax
	CtGWYvYzEOpSw+2fV9y788JzdrVqR2hCdzRe05f4uvl6R8WRScmCN/qmJ0LQHEfBXzrO/MO
	Wd1W+YkNl0uDHNtCOyqgKdmrXzrT6fqhRnnu5a3Y73uL4KGjt67XVEu7eStsFF81HYqScWm
	UMecbrWl3WOr2aMS2K1RxOEGDJ1oMqujYrbWQpU++cPki6u25hQNsl61YBrJ2IplPlhQFmX
	ebU3AoVHY0l+vyIQGcsOQRjhCWS+pMHIIJY2LHQr4Cp/llgC2H16hrbLPk+vRP0XEpdVFUu
	IAN8M2pWunXibDeq1qzSvQI1zbV49eq6eK9YQjITwCY77dzLSJP4CeoudyeqkHSeDu0+viO
	koKhjmwrWAU=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4984385950916111259
From: Dawei Li <dawei.li@shingroup.cn>
To: tglx@linutronix.de,
	maz@kernel.org
Cc: sdonthineni@nvidia.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dawei.li@shingroup.cn,
	set_pte_at@outlook.com
Subject: [PATCH 1/4] irqchip/gic-v3: Implement read polling with dedicated API
Date: Thu, 18 Jan 2024 19:27:36 +0800
Message-Id: <20240118112739.2000497-2-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240118112739.2000497-1-dawei.li@shingroup.cn>
References: <20240118112739.2000497-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Kernel provide read*_poll_* API family to support looping based polling
code pattern like below:
while (...)
{
	val = op(addr);
	condition = cond(val);
	if (condition)
		break;

	/* Maybe some timeout handling stuff */

	cpu_relax();
	udelay();
}

As such, use readl_relaxed_poll_timeout_atomic() to implement atomic
register polling logic in gic-v3.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/irqchip/irq-gic-v3.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 98b0329b7154..b9d9375a3434 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -19,6 +19,7 @@
 #include <linux/percpu.h>
 #include <linux/refcount.h>
 #include <linux/slab.h>
+#include <linux/iopoll.h>
 
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic-common.h>
@@ -251,17 +252,11 @@ static inline void __iomem *gic_dist_base(struct irq_data *d)
 
 static void gic_do_wait_for_rwp(void __iomem *base, u32 bit)
 {
-	u32 count = 1000000;	/* 1s! */
+	u32 val;
 
-	while (readl_relaxed(base + GICD_CTLR) & bit) {
-		count--;
-		if (!count) {
-			pr_err_ratelimited("RWP timeout, gone fishing\n");
-			return;
-		}
-		cpu_relax();
-		udelay(1);
-	}
+	if (readl_relaxed_poll_timeout_atomic(base + GICD_CTLR,
+		val, !(val & bit), 1, 1000000) == -ETIMEDOUT)
+		pr_err_ratelimited("RWP timeout, gone fishing\n");
 }
 
 /* Wait for completion of a distributor change */
@@ -279,7 +274,6 @@ static void gic_redist_wait_for_rwp(void)
 static void gic_enable_redist(bool enable)
 {
 	void __iomem *rbase;
-	u32 count = 1000000;	/* 1s! */
 	u32 val;
 
 	if (gic_data.flags & FLAGS_WORKAROUND_GICR_WAKER_MSM8996)
@@ -301,14 +295,9 @@ static void gic_enable_redist(bool enable)
 			return;	/* No PM support in this redistributor */
 	}
 
-	while (--count) {
-		val = readl_relaxed(rbase + GICR_WAKER);
-		if (enable ^ (bool)(val & GICR_WAKER_ChildrenAsleep))
-			break;
-		cpu_relax();
-		udelay(1);
-	}
-	if (!count)
+	if (readl_relaxed_poll_timeout_atomic(rbase + GICR_WAKER,
+		val, enable ^ (bool)(val & GICR_WAKER_ChildrenAsleep),
+		1, 1000000) == -ETIMEDOUT)
 		pr_err_ratelimited("redistributor failed to %s...\n",
 				   enable ? "wakeup" : "sleep");
 }
-- 
2.27.0


