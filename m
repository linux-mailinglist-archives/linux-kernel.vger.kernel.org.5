Return-Path: <linux-kernel+bounces-32579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D0E835D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993A31C23CAD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0296E39852;
	Mon, 22 Jan 2024 08:59:41 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C3139843
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913980; cv=none; b=Idma+wZA8cp0/EEfGWKMWtXYJf8ObwoPFMIj3KlJy0b+PJwnNvcXBPymvlN41Jo5jfs2l6C/Lz1wvE4ycaRyHy6exb8oL3YS0CUPx1qLaDxEB++RUb9pRXd+tuPWL3W5mhkq2D62Sw9VwFF6nkTe3YoI8zA+/rn39DsyV7MiuV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913980; c=relaxed/simple;
	bh=lB0SWPsLNlYzXLrYG14lw/+vjjV0BTHHMLQlL39mo70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RMj7NRv1ScrjqLFoEDu/dW24mW0tyzqngWKQLQQA5VTVViUpEhWjSr5xn4qPmOevTbQEgf8E1ZF4dga69jiYIin8bZw2wDirwm4qYB1f3F8j/kIusDoYHCLDntvbiQOZgMKAGoDpXzOdhKe11DmT4wTeFCDL4YTqXDtypC8NeII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp75t1705913948tfi179xy
X-QQ-Originating-IP: i6JR3JSt3cx8j++LW7stv6+R9DhNrBauvB6V63faj80=
Received: from localhost ( [183.209.108.228])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Jan 2024 16:59:06 +0800 (CST)
X-QQ-SSF: 01400000000000504000000A0000000
X-QQ-FEAT: hUW8LCq5FglZ2z+ojiA3s/8JPKADLltKuo8EOcgk5msgqoe62zuiEGg6SlCHi
	6xpSw7HQ/6r00e0SG9EC5RqgvQYBXdxFdi5RDepHdoDaO6vnArAjkdqWn8v94RjAqQePshU
	38XwU7VNCKsCS78/KkXygITyYGrpscfRaNSow/O5FWqicd5LarvNGa0JRr3FZsPl3gwGmZi
	uXyLQayzaVLcLq/QNJtaGltRk3S+wEk7WUJ88R6IHiY7Zv4x/SecMwIIdi9mI9lk/X8SjHp
	lSzSzo3BBw4+7uhYWxt3jXiBUGO3GpMkStQTahVxYwjiawW+ahRSlGYBM0cuzGJFRwL/mcP
	oSxMJwaFBRtFWMZOqWy5n4VwSOuAb1zhyybsqNxWQw6OoTo3mQJuTdXp4Wvql6LJSOrLyyC
	eTZIm8xcyFFSEwdIDfbVpg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17265005081318603409
From: Dawei Li <dawei.li@shingroup.cn>
To: tglx@linutronix.de,
	maz@kernel.org
Cc: sdonthineni@nvidia.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dawei.li@shingroup.cn,
	set_pte_at@outlook.com
Subject: [PATCH v2 1/5] irqchip/gic-v3: Implement read polling with dedicated API
Date: Mon, 22 Jan 2024 16:57:12 +0800
Message-Id: <20240122085716.2999875-2-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240122085716.2999875-1-dawei.li@shingroup.cn>
References: <20240122085716.2999875-1-dawei.li@shingroup.cn>
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

It's worth noting that this conversion would be impossilbe without
support of commit 7349a69cf312 ("iopoll: Do not use timekeeping in
read_poll_timeout_atomic()"), which remove time keeping code from
read_poll_timeout_atomic(), reason below:

Compared to other 'ordinary' device driver, IRQ chip driver is kinda
special, whose initialization(via init_IRQ()) happens pretty early,
even before timekeeping_init(). As a result, calling time keeping code
in irq chip init code is bogus.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/irqchip/irq-gic-v3.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 98b0329b7154..020a67195b16 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -19,6 +19,7 @@
 #include <linux/percpu.h>
 #include <linux/refcount.h>
 #include <linux/slab.h>
+#include <linux/iopoll.h>
 
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic-common.h>
@@ -251,17 +252,16 @@ static inline void __iomem *gic_dist_base(struct irq_data *d)
 
 static void gic_do_wait_for_rwp(void __iomem *base, u32 bit)
 {
-	u32 count = 1000000;	/* 1s! */
+	u32 val;
+	int ret;
 
-	while (readl_relaxed(base + GICD_CTLR) & bit) {
-		count--;
-		if (!count) {
-			pr_err_ratelimited("RWP timeout, gone fishing\n");
-			return;
-		}
-		cpu_relax();
-		udelay(1);
-	}
+	ret = readl_relaxed_poll_timeout_atomic(base + GICD_CTLR,
+						val,
+						!(val & bit),
+						1,
+						USEC_PER_SEC);
+	if (ret == -ETIMEDOUT)
+		pr_err_ratelimited("RWP timeout, gone fishing\n");
 }
 
 /* Wait for completion of a distributor change */
@@ -279,8 +279,8 @@ static void gic_redist_wait_for_rwp(void)
 static void gic_enable_redist(bool enable)
 {
 	void __iomem *rbase;
-	u32 count = 1000000;	/* 1s! */
 	u32 val;
+	int ret;
 
 	if (gic_data.flags & FLAGS_WORKAROUND_GICR_WAKER_MSM8996)
 		return;
@@ -301,14 +301,12 @@ static void gic_enable_redist(bool enable)
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
+	ret = readl_relaxed_poll_timeout_atomic(rbase + GICR_WAKER,
+						val,
+						enable ^ (bool)(val & GICR_WAKER_ChildrenAsleep),
+						1,
+						USEC_PER_SEC);
+	if (ret == -ETIMEDOUT)
 		pr_err_ratelimited("redistributor failed to %s...\n",
 				   enable ? "wakeup" : "sleep");
 }
-- 
2.27.0


