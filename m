Return-Path: <linux-kernel+bounces-142539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A38B8A2CF5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E931F22414
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18ED5467F;
	Fri, 12 Apr 2024 10:59:26 +0000 (UTC)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C2F40C15
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712919566; cv=none; b=NOF76q9ALABopXwxmnzzUfogu0uQLH7qg0zP7wJbEo7JeEnStDI93viwaIt9AHIEX4dJBaKeF/9wiyhKrwQwA6vkgA6TcauW3SyHnM65quaTnIBzSeWoH2Q5F0FyXyWfWqefpH7CmC7I7kHxxsbT+lxH2zxMZNlN8cnRic+8ThM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712919566; c=relaxed/simple;
	bh=Y2Fr2z85GiqrsspK1EWPARCrG8qEAgI0otN5jcdYGbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pvZ0q5PDKE/SYXKWk+UM3XAtElrcbL/3ddn/jgZUMjBFbrdHI9pB0aGGbFoCwA7NVZkmyLTZMDvkguPg7tApfcxA8nzZcWYgi0gZjVkzT41UO6Y3gKLF6PR0RaQAPbn8wN6devTFSiTFpXty6MZKvpPmf/H7Folx4goI6rURgJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz12t1712919554t1sc4f
X-QQ-Originating-IP: XtOo9MhHpQmv59Q3FjqVGhMpUYTa/sen1b4+R/N3Lyg=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 12 Apr 2024 18:59:12 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: vrqOr+ppv0swERXAarxGZQvyAMZZ/l6B37dFgG2uQThzhiA2EgalD6ig2x8OV
	NSQ75IlmVX14Xw2yeqH+ooyMOCVMRuqE6/VRs6tGFwE+f6A/aOB8LJl1+k1lZGTERf36BF4
	9IU5PXB9teHLdp0oWbRPjFJFJEUp5Cqxjoj5MEInMdenxQdYYvO0qg1JJoc7ov9kXkWOITT
	z+sMmqpVKdwFA6E1iiUi3dTJjTlbYDhME+SwkD7oWhx2zob5q9iQZ0LlPpxsDZ0/ufsF++V
	4LBjVzJhfblyUIslnzRaqm3Dkg/idVALMz306M7CEkk17p2bYeSJLUQWywONh73BCpI88pc
	/9u6T2QfAuX/ZvO00x42zBDIgY09+6A9cLXXM85TYmzcU6pVx9RuhFK9zOj6LCrCLl1HoDV
	3UcfBM8Is3Flu7zkZtLRBA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10109608025486522936
From: Dawei Li <dawei.li@shingroup.cn>
To: tglx@linutronix.de,
	yury.norov@gmail.com
Cc: akpm@linux-foundation.org,
	maz@kernel.org,
	florian.fainelli@broadcom.com,
	chenhuacai@kernel.org,
	jiaxun.yang@flygoat.com,
	anup@brainfault.org,
	palmer@dabbelt.com,
	samuel.holland@sifive.com,
	linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH 3/6] irqchip/gic-v3-its: Avoid explicit cpumask allocation on stack
Date: Fri, 12 Apr 2024 18:58:36 +0800
Message-Id: <20240412105839.2896281-4-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240412105839.2896281-1-dawei.li@shingroup.cn>
References: <20240412105839.2896281-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

Remove cpumask var on stack and use proper cpumask API to address it.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/irqchip/irq-gic-v3-its.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index fca888b36680..a821396c4261 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3826,7 +3826,7 @@ static int its_vpe_set_affinity(struct irq_data *d,
 				bool force)
 {
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
-	struct cpumask common, *table_mask;
+	struct cpumask *table_mask;
 	unsigned long flags;
 	int from, cpu;
 
@@ -3850,8 +3850,11 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	 * If we are offered another CPU in the same GICv4.1 ITS
 	 * affinity, pick this one. Otherwise, any CPU will do.
 	 */
-	if (table_mask && cpumask_and(&common, mask_val, table_mask))
-		cpu = cpumask_test_cpu(from, &common) ? from : cpumask_first(&common);
+	if (table_mask && cpumask_intersects(mask_val, table_mask)) {
+		cpu = cpumask_test_cpu(from, mask_val) &&
+		      cpumask_test_cpu(from, table_mask) ?
+		      from : cpumask_first_and(mask_val, table_mask);
+	}
 	else
 		cpu = cpumask_first(mask_val);
 
-- 
2.27.0


