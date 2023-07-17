Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373F7756CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjGQS7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjGQS7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:59:14 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C16F1AC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:58:48 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3457157a164so20525065ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1689620328; x=1692212328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EfmtkIn1nFJzPpqeHKOOLhwST2S07YVZFJfXxqbhgY0=;
        b=D1yapx1Lv8/tzSF+WaDvCUTSWpi2YKsZqA+ywGtnpKvr5SOUGaZ5uWH6be6fTKEA5N
         59CAL1PghSameGhFxIucjgZD0b7W0esrr6OondMCbrZ2yRxtKO8Z/LL+PT5JYix3MSHd
         0zK6oIDMt/ABuWqp5gGvd/l83JmN2bEvKmaFh40ySnav/l85EVh1NWitSqR2U2Szv3aR
         c01Sw6C/vzqlFwW844z5riQVSU9YzOo2Q7g18/hHgNcz42S/UIDp/oM8Uz5162pGGvWD
         Rpb3+atspnSsayHiLs/EC35T/6pBmQTW2anFooHq9Sq650HNpky3RyPY5MTAqsaTuFdG
         JQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689620328; x=1692212328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EfmtkIn1nFJzPpqeHKOOLhwST2S07YVZFJfXxqbhgY0=;
        b=aFPGDixvAjUPVJYA+5bZxlYwQq7AowYZWqUWbYhvjCYm44ZZS7Jhwx8cxXDavUY4oW
         9pnNAkNbBUO/suQyQBKtL1jWpZymfdVRcK5uKxX2e7GSy+7ZnSmPglkTxohx9CpPBtd0
         hFRh7TWTCkvOxlJQR7LOy/TA6HgHOzSaU/HpSa0s79QLc4Ecya9WVI4qE/kZKv7VZpXf
         JhzKJtPsEonl1i+FX+aGmTTF5jDNJFpL+IO81/2gzjM9XLQHz5GDJzfIiWK7Ci8yxhb+
         23kU9VMn3/iWiUiCaDtupS+07QTg3UuWcFhz0n/5fyG0OLm5qI3x7r5eyRQ/qoU3f8Uk
         UCKA==
X-Gm-Message-State: ABy/qLbDfyOu+uQkyeIXzCr/8E2G4v9A/qknqY0s9GLnMam6wwCmkmHL
        GhUKE/eg56mpZw7geTGc7ZdrdQ==
X-Google-Smtp-Source: APBJJlEhvu3bQym103eRoa3eTOAVL431uI1Zb2PLz4J74XzAwMvTWQ5uufumJffdGeald1ECQG94LA==
X-Received: by 2002:a05:6e02:154b:b0:345:66f5:3404 with SMTP id j11-20020a056e02154b00b0034566f53404mr689436ilu.0.1689620328043;
        Mon, 17 Jul 2023 11:58:48 -0700 (PDT)
Received: from sw06.internal.sifive.com ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id r17-20020a63a011000000b0051b8172fa68sm152882pge.38.2023.07.17.11.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 11:58:47 -0700 (PDT)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Samuel Holland <samuel.holland@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH] irqchip/sifive-plic: Avoid clearing the per-hart enable bits
Date:   Mon, 17 Jul 2023 11:58:40 -0700
Message-Id: <20230717185841.1294425-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Writes to the PLIC completion register are ignored if the enable bit for
that (interrupt, hart) combination is cleared. This leaves the interrupt
in a claimed state, preventing it from being triggered again.

Originally, the enable bit was cleared in the .irq_mask operation, and
commit 69ea463021be ("irqchip/sifive-plic: Fixup EOI failed when masked")
added a workaround for this issue. Later, commit a1706a1c5062
("irqchip/sifive-plic: Separate the enable and mask operations") moved
toggling the enable bit to the .irq_enable/.irq_disable operations and
removed the workaround.

However, there are still places where .irq_disable can be called from
inside the hard IRQ handler, for example in irq_pm_check_wakeup(). As a
result, this issue causes an interrupt to get stuck in a claimed state
after being used to wake the system from s2idle.

There is no real benefit to implementing the .irq_enable/.irq_disable
operations using the enable bits. In fact, the existing mask/unmask
implementation using the threshold register is already more efficient,
as it requires no read/modify/write cycles. So let's leave the enable
bits set for the lifetime of the IRQ, using them only to control its
affinity.

Fixes: a1706a1c5062 ("irqchip/sifive-plic: Separate the enable and mask operations")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/irqchip/irq-sifive-plic.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index e1484905b7bd..c2673fdad8e5 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -120,12 +120,14 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
 	}
 }
 
-static void plic_irq_enable(struct irq_data *d)
+static unsigned int plic_irq_startup(struct irq_data *d)
 {
 	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 1);
+
+	return 0;
 }
 
-static void plic_irq_disable(struct irq_data *d)
+static void plic_irq_shutdown(struct irq_data *d)
 {
 	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 0);
 }
@@ -169,12 +171,12 @@ static int plic_set_affinity(struct irq_data *d,
 	if (cpu >= nr_cpu_ids)
 		return -EINVAL;
 
-	plic_irq_disable(d);
+	plic_irq_shutdown(d);
 
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
-	if (!irqd_irq_disabled(d))
-		plic_irq_enable(d);
+	if (irqd_is_started(d))
+		plic_irq_startup(d);
 
 	return IRQ_SET_MASK_OK_DONE;
 }
@@ -182,8 +184,8 @@ static int plic_set_affinity(struct irq_data *d,
 
 static struct irq_chip plic_edge_chip = {
 	.name		= "SiFive PLIC",
-	.irq_enable	= plic_irq_enable,
-	.irq_disable	= plic_irq_disable,
+	.irq_startup	= plic_irq_startup,
+	.irq_shutdown	= plic_irq_shutdown,
 	.irq_ack	= plic_irq_eoi,
 	.irq_mask	= plic_irq_mask,
 	.irq_unmask	= plic_irq_unmask,
@@ -197,8 +199,8 @@ static struct irq_chip plic_edge_chip = {
 
 static struct irq_chip plic_chip = {
 	.name		= "SiFive PLIC",
-	.irq_enable	= plic_irq_enable,
-	.irq_disable	= plic_irq_disable,
+	.irq_startup	= plic_irq_startup,
+	.irq_shutdown	= plic_irq_shutdown,
 	.irq_mask	= plic_irq_mask,
 	.irq_unmask	= plic_irq_unmask,
 	.irq_eoi	= plic_irq_eoi,
-- 
2.40.1

