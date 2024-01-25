Return-Path: <linux-kernel+bounces-38530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CD283C115
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3ED82954AB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57325380A;
	Thu, 25 Jan 2024 11:36:38 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB9250275;
	Thu, 25 Jan 2024 11:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182598; cv=none; b=FAeX4MW5evepz0viFkDpO3VqbY5Dt/EvjQSzsCZ89J9DNapzzgiCiMV95MUyb5rKr5YqtjubpiKc3VkE/Fpnwg4nKx/DUxDWMAPDUUI0J3pYBDHpgyKZgQLj+lmmSgTDsRwctqsr+GreZJV19ta5G1ztcC1Xd+so5/AAgAf5VwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182598; c=relaxed/simple;
	bh=o2bbRFuK9jNTae4+uSuUwNs8ke+/Xo2zb37ApwwD5kA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jvQf4/8WWNw52NoVQEWcbljrvntwhjavC3aeOHp/ZfszRhjUEaC5eXMAOyg3bCssl9pSqUPhp8W0a7XULtCHsnbazDLp6SYKm6WPODGHAWyLOJhsQQ3SVYmNAGgZzETsmAGHNhJRiu/hBzEno9l6oRihq2IVY5G/yOnLnBsbNp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Axeei9R7Jl8ZcFAA--.1197S3;
	Thu, 25 Jan 2024 19:36:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXs23R7Jl9W0ZAA--.41879S5;
	Thu, 25 Jan 2024 19:36:28 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	lvjianmin@loongson.cn
Subject: [PATCH v4 3/3] irqchip/loongson-eiointc: Refine irq affinity setting during resume
Date: Thu, 25 Jan 2024 19:36:23 +0800
Message-Id: <20240125113623.2043061-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240125113623.2043061-1-maobibo@loongson.cn>
References: <20240125113623.2043061-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxXs23R7Jl9W0ZAA--.41879S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFW8Aw4kKw4fCF1UXrWftFc_yoW8Xr1xpF
	W3A3ZFvr45GFyUXr9Ykw1jq34aya9Yv3y2qFW3Wa97uFs8WayDKF4FyFykZFW0k342yF1q
	9F4Yq34ru3W5C3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU8EeHDUUUUU==

During suspend and resume, CPUs except CPU0 are hot-unpluged and IRQs
are migrated to CPU0. So it is not necessary to restore irq affinity for
eiointc irq controller when system resumes. This patch removes the piece
of code about irq affinity restoring in function eiointc_resume.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 drivers/irqchip/irq-loongson-eiointc.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 6a71a8c29ac7..b64cbe3052e8 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -310,23 +310,7 @@ static int eiointc_suspend(void)
 
 static void eiointc_resume(void)
 {
-	int i, j;
-	struct irq_desc *desc;
-	struct irq_data *irq_data;
-
 	eiointc_router_init(0);
-
-	for (i = 0; i < nr_pics; i++) {
-		for (j = 0; j < eiointc_priv[0]->vec_count; j++) {
-			desc = irq_resolve_mapping(eiointc_priv[i]->eiointc_domain, j);
-			if (desc && desc->handle_irq && desc->handle_irq != handle_bad_irq) {
-				raw_spin_lock(&desc->lock);
-				irq_data = irq_domain_get_irq_data(eiointc_priv[i]->eiointc_domain, irq_desc_get_irq(desc));
-				eiointc_set_irq_affinity(irq_data, irq_data->common->affinity, 0);
-				raw_spin_unlock(&desc->lock);
-			}
-		}
-	}
 }
 
 static struct syscore_ops eiointc_syscore_ops = {
-- 
2.39.3


