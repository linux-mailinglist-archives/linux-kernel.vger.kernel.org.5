Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6437D90F0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbjJ0IRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJ0IRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:17:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755A91A5;
        Fri, 27 Oct 2023 01:17:37 -0700 (PDT)
Date:   Fri, 27 Oct 2023 08:17:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698394655;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vA788SE7Noptz4+WSt8tuziUT4TBDJvVXqWFU9PxDEg=;
        b=wj1Y3IVme6Am94VhHc64GpPt3JUPS8c8mScILGrQQEgCK9dE3ciCKRjRP0o3WRY66VbbL/
        pwYWEnv/mCsCsly3rYfOV8s5+3F9/BNBQpkSGMP7tDxeAsfdCmAH5hndixy3gLbYyjgdsY
        lpcSVJ5LXB61dbrRdG7/eRqRbF1wxm7uGEgq9EylgoESOIaAgUWYb7uBIUkbbaC0FKJD9d
        qz9xHokF8H+Sr4xyYwLUm6duk1Xuv2XgogPiQ/4LwYKSO1WAT69V1WRdi8o9T6sepJaeUE
        yJBIf3Jvy0/G/6p2WVtuNxq5dCMIwnTUeV7ybEhAxG32XvP53hMysVUO0BkuiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698394655;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vA788SE7Noptz4+WSt8tuziUT4TBDJvVXqWFU9PxDEg=;
        b=z3GGGKhPmiHgj9sccLvo4Wl4Gx5TzcTCwpiIagdgQcgSkmX0Ve5h99Ajz57mPSfH8WJK6j
        VNXhYhkfCdfCT8CA==
From:   "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/sifive-plic: Fix syscore registration for
 multi-socket systems
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20231025142820.390238-4-apatel@ventanamicro.com>
References: <20231025142820.390238-4-apatel@ventanamicro.com>
MIME-Version: 1.0
Message-ID: <169839465507.3135.1764002917624211334.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f99b926f6543faeadba1b4524d8dc9c102489135
Gitweb:        https://git.kernel.org/tip/f99b926f6543faeadba1b4524d8dc9c102489135
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Wed, 25 Oct 2023 19:58:20 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 27 Oct 2023 10:09:15 +02:00

irqchip/sifive-plic: Fix syscore registration for multi-socket systems

Multi-socket systems have a separate PLIC in each socket, so __plic_init()
is invoked for each PLIC. __plic_init() registers syscore operations, which
obviously fails on the second invocation.

Move it into the already existing condition for installing the CPU hotplug
state so it is only invoked once when the first PLIC is initialized.

[ tglx: Massaged changelog ]

Fixes: e80f0b6a2cf3 ("irqchip/irq-sifive-plic: Add syscore callbacks for hibernation")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20231025142820.390238-4-apatel@ventanamicro.com

---
 drivers/irqchip/irq-sifive-plic.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index e148490..5b7bc4f 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -532,17 +532,18 @@ done:
 	}
 
 	/*
-	 * We can have multiple PLIC instances so setup cpuhp state only
-	 * when context handler for current/boot CPU is present.
+	 * We can have multiple PLIC instances so setup cpuhp state
+	 * and register syscore operations only when context handler
+	 * for current/boot CPU is present.
 	 */
 	handler = this_cpu_ptr(&plic_handlers);
 	if (handler->present && !plic_cpuhp_setup_done) {
 		cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 				  "irqchip/sifive/plic:starting",
 				  plic_starting_cpu, plic_dying_cpu);
+		register_syscore_ops(&plic_irq_syscore_ops);
 		plic_cpuhp_setup_done = true;
 	}
-	register_syscore_ops(&plic_irq_syscore_ops);
 
 	pr_info("%pOFP: mapped %d interrupts with %d handlers for"
 		" %d contexts.\n", node, nr_irqs, nr_handlers, nr_contexts);
