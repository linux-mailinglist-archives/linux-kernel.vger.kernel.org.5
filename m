Return-Path: <linux-kernel+bounces-142541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971B28A2CF7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513AA286B38
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803B555774;
	Fri, 12 Apr 2024 10:59:32 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B318B5491B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712919572; cv=none; b=Mw4MS/LeSvx9avKtv0lItPX8s3hju6/bfzPFgm3BepinatUKFAoERtqSPaToVXhp38T8x9muzoN3E/FPgghIZJfflksui+KMcR2hJF6p4es5UUhHcm0cjPUZaO9htsNrEdv7sbltNkPPtc7Vt05Ws/4i/ChCLnYdEkwkI4KS0TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712919572; c=relaxed/simple;
	bh=89OWL6oKQL9eoj0BTb0SEH2HgmwDSvtWGUqC2G83MKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ueqPK0YCwF0cwzumd1llzmZ93fauA2GTfWHslPCeBDqlzVhkg8srsLP/yjAcaNR/BAnZq14XJjju5Ruy6H96WkCXwVjzngqquYDt6DIc0fy06RxswYLHKL2QRwc/3vylqknZbDYyyAb49Zz2pftMl1StmUq5ngv4VjiII93KDi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp82t1712919548twkgcxfw
X-QQ-Originating-IP: cTu8bWC6MQj9EpB/V8OFtgVpRbN3pOE3oBFgWv0OihE=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 12 Apr 2024 18:59:07 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: RrZlkntZBfmamcRyuPfoyReZ1wjERGVK+iTPLZgwTojoaJ8M98IfPlIFJMjVP
	VYRr+4hX1twh8sTPH2sdFyggPmEN+vCMbfTm885aXD4a0kazTTdZYBVaqTzVPWzQjWxSMr6
	tCkKOIki8KkWyQ9eYJ2d8gea8uBIcX/IUNMf/u+IQXQfpKUE6vfLkoChCJsH7k/9uL4QT0J
	Z75YR/YFWJ+oXLNuCiW0O2eAOQ5VqElPIbxPzTV7WHPkLDlqxNMtQu7hqYuJaMi6LanxywJ
	0TIyujtEQGZqknhgAQe+VVYCrZ4uw81UkVBi5/SnpkjpuTZjZJoTlx+G+4M4mpBi0dKvBag
	cF1YgsBIFhCt/9yMwPcmTmA8Jy7W3LkIz+uhphaycwLywOD4OaZxcUwn1byriJ1sykK+kaU
	NQqNqjmjqCcRVKAl3Nr9oVLLRH4ebc+y
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11251082261756714604
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
Subject: [PATCH 2/6] irqchip/irq-bcm6345-l1: Avoid explicit cpumask allocation on stack
Date: Fri, 12 Apr 2024 18:58:35 +0800
Message-Id: <20240412105839.2896281-3-dawei.li@shingroup.cn>
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
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

Use cpumask_first_and_and() to avoid the need for a temporary cpumask on
the stack.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/irqchip/irq-bcm6345-l1.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
index eb02d203c963..6df37957b39c 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -192,14 +192,11 @@ static int bcm6345_l1_set_affinity(struct irq_data *d,
 	u32 mask = BIT(d->hwirq % IRQS_PER_WORD);
 	unsigned int old_cpu = cpu_for_irq(intc, d);
 	unsigned int new_cpu;
-	struct cpumask valid;
 	unsigned long flags;
 	bool enabled;
 
-	if (!cpumask_and(&valid, &intc->cpumask, dest))
-		return -EINVAL;
-
-	new_cpu = cpumask_any_and(&valid, cpu_online_mask);
+	new_cpu = cpumask_first_and_and(&intc->cpumask, dest,
+					cpu_online_mask);
 	if (new_cpu >= nr_cpu_ids)
 		return -EINVAL;
 
-- 
2.27.0


