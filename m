Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C89A7D70F6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343922AbjJYPcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbjJYPcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:32:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D137182;
        Wed, 25 Oct 2023 08:32:01 -0700 (PDT)
Date:   Wed, 25 Oct 2023 15:31:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698247919;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L4nRcGgUwjIYKtu/Bjz9TtAnlQT8ejqV4enG5LqQq+k=;
        b=Nhbeb3UeZBoTSRhqElJSp/QR5lTI8kzrbXEySS1DuqHeuipT82hjbblFXafkP5lBUb4pi2
        rYiVrPlz52FaDoAgjewJVNSo3rncHm/GlmUdNpdUdFk6tEdETArtfSlJ074iWAGmmD1/OG
        PwOMFOaemC8ulfsr3XXBGIaTjdY4RDYUBMMXqJxukVnyij4Gjw0TYN1Vebi0RiD94GsFpm
        ldd8z35QpmvOtgZVJy/PALv7pSEkOB6eM+OUrj5TYkYDRwLH+ERTbLYhfMeQkMUzI7AGd5
        I9qT7bLsI1cGifK9SbfpRm28IFV/7u6RihJwEeIfkZ8any4OWQOHYD+zCrXIvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698247919;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L4nRcGgUwjIYKtu/Bjz9TtAnlQT8ejqV4enG5LqQq+k=;
        b=Vl0bFDRbM3n8b2K5tUh88hgA7Gl/2HLtgq71jqkanHxK0dmwZ3e0wioj0/ZBbzQj24+OCz
        1663HznkGyRb/tAg==
From:   "tip-bot2 for Chen Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/matrix: Exclude managed interrupts in
 irq_matrix_allocated()
Cc:     Wendy Wang <wendy.wang@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20231020072522.557846-1-yu.c.chen@intel.com>
References: <20231020072522.557846-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Message-ID: <169824791888.3135.11708569136306564605.tip-bot2@tip-bot2>
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

Commit-ID:     a0b0bad10587ae2948a7c36ca4ffc206007fbcf3
Gitweb:        https://git.kernel.org/tip/a0b0bad10587ae2948a7c36ca4ffc206007fbcf3
Author:        Chen Yu <yu.c.chen@intel.com>
AuthorDate:    Fri, 20 Oct 2023 15:25:22 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 25 Oct 2023 17:25:57 +02:00

genirq/matrix: Exclude managed interrupts in irq_matrix_allocated()

When a CPU is about to be offlined, x86 validates that all active
interrupts which are targeted to this CPU can be migrated to the remaining
online CPUs. If not, the offline operation is aborted.

The validation uses irq_matrix_allocated() to retrieve the number of
vectors which are allocated on the outgoing CPU. The returned number of
allocated vectors includes also vectors which are associated to managed
interrupts.

That's overaccounting because managed interrupts are:

  - not migrated when the affinity mask of the interrupt targets only
    the outgoing CPU

  - migrated to another CPU, but in that case the vector is already
    pre-allocated on the potential target CPUs and must not be taken into
    account.

As a consequence the check whether the remaining online CPUs have enough
capacity for migrating the allocated vectors from the outgoing CPU might
fail incorrectly.

Let irq_matrix_allocated() return only the number of allocated non-managed
interrupts to make this validation check correct.

[ tglx: Amend changelog and fixup kernel-doc comment ]

Fixes: 2f75d9e1c905 ("genirq: Implement bitmap matrix allocator")
Reported-by: Wendy Wang <wendy.wang@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20231020072522.557846-1-yu.c.chen@intel.com
---
 kernel/irq/matrix.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 1698e77..75d0ae4 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -466,16 +466,16 @@ unsigned int irq_matrix_reserved(struct irq_matrix *m)
 }
 
 /**
- * irq_matrix_allocated - Get the number of allocated irqs on the local cpu
+ * irq_matrix_allocated - Get the number of allocated non-managed irqs on the local CPU
  * @m:		Pointer to the matrix to search
  *
- * This returns number of allocated irqs
+ * This returns number of allocated non-managed interrupts.
  */
 unsigned int irq_matrix_allocated(struct irq_matrix *m)
 {
 	struct cpumap *cm = this_cpu_ptr(m->maps);
 
-	return cm->allocated;
+	return cm->allocated - cm->managed_allocated;
 }
 
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
