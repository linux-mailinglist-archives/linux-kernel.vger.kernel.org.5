Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE097C8311
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjJMKb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjJMKbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:31:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9A6CA;
        Fri, 13 Oct 2023 03:31:21 -0700 (PDT)
Date:   Fri, 13 Oct 2023 10:31:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697193080;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hob1pPMiTCm3R6nB1NIaTX7kXJllqZiibswxfoVZ4uY=;
        b=nZBku9abSMRq9jgjupGcxGjrEQ8/dGMNkvmQBBus1/vHko+hiEmCpNkrsuEkOruJ+2P+k+
        AzbXu+MIwlFIsjCIBdBp0q2+8PFme2vScIUasxDleSPGoFtJPs/EKteawgVyfIuVnJsW9B
        P/CM2lJHqTVwwa9YFVXTh9gD0zg6u8HQaHHFmKWAOeZWE4c++AZ6uZeO455pH6u6fUI7PG
        bh5Uf/Wwzh46lJw6pugCqZkwa0GjYZGnQApMmw+MUn+JXRaS45z7Yf5Fjz5dwSwE5aYp/q
        2aPjVP61ZJrNR1fGexIRiytiRqH6z6oXKOIJxFws7Nej6qdoavL21oadty7Dug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697193080;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hob1pPMiTCm3R6nB1NIaTX7kXJllqZiibswxfoVZ4uY=;
        b=OfWI2O4obWmqEuIwGijGjzk2YcUFbKEvFU6I28PoEkYr+S+KvxatOnh6EK8ZqotC31zEt4
        5UX9ewcWCxfvzuAA==
From:   "tip-bot2 for Keguang Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/generic-chip: Fix the irq_chip name for
 /proc/interrupts
Cc:     Keguang Zhang <keguang.zhang@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20230925121734.93017-1-keguang.zhang@gmail.com>
References: <20230925121734.93017-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Message-ID: <169719307970.3135.13937631733550216078.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     021a8ca2ba23c01487a98ad23b68ac062e14cf32
Gitweb:        https://git.kernel.org/tip/021a8ca2ba23c01487a98ad23b68ac062e14cf32
Author:        Keguang Zhang <keguang.zhang@gmail.com>
AuthorDate:    Mon, 25 Sep 2023 20:17:34 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 13 Oct 2023 12:25:31 +02:00

genirq/generic-chip: Fix the irq_chip name for /proc/interrupts

irq_init_generic_chip() only sets the name for the first chip type, which
leads to empty names for other chip types.  Eventually, these names will be
shown as "-" /proc/interrupts.

Set the name for all chip types by default.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230925121734.93017-1-keguang.zhang@gmail.com

---
 kernel/irq/generic-chip.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index c653cd3..81ecca0 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -219,11 +219,15 @@ void irq_init_generic_chip(struct irq_chip_generic *gc, const char *name,
 			   int num_ct, unsigned int irq_base,
 			   void __iomem *reg_base, irq_flow_handler_t handler)
 {
+	struct irq_chip_type *ct = gc->chip_types;
+	int i;
+
 	raw_spin_lock_init(&gc->lock);
 	gc->num_ct = num_ct;
 	gc->irq_base = irq_base;
 	gc->reg_base = reg_base;
-	gc->chip_types->chip.name = name;
+	for (i = 0; i < num_ct; i++)
+		ct[i].chip.name = name;
 	gc->chip_types->handler = handler;
 }
 
