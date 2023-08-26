Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16009789863
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 19:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjHZRSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 13:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjHZRRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 13:17:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21248BD;
        Sat, 26 Aug 2023 10:17:48 -0700 (PDT)
Date:   Sat, 26 Aug 2023 17:17:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693070265;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+884pQb4+uM3VSCP17PeDZpxzYCrz0VcKPEgLZbdQpo=;
        b=Lu1lL36Nz9jRS7B5hO/tzxVnJgKM++j8DWWWEpmP9sa1gmfblokk+WYPEXtHJMsbKdO1Hj
        vQjGM2M2lMEd8EyhFWBHwhsozo+QDHzetmcTYyL/XhisUqb3+UFJLlGEYBjZHNw2OynV7S
        fkx+Ck4c2Y/3Mh3pk7oYTrfeczP1hXdQE1zpm+Q11GyzuKU4Xyl0eFQxj7I4N+2qKhK++s
        H2JkUBiyrPS+Wr1Ccubd0DAnB+lPb4m/6jXEY83ikVAjFA9NDxkCWn8LSteCXRuWZClIfi
        NNHym/JBjI7KuhoDKrADJ4k3VMwUz0E3fd7fpfOaN7Kyo0YK0mE3D7S01JO8Tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693070265;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+884pQb4+uM3VSCP17PeDZpxzYCrz0VcKPEgLZbdQpo=;
        b=UlLdrZQaYVdL49WD44eR/JFrWSyXz2Z6TntPOuQ6PqGvwMU9nua7yhfCY6w/ZAS8A2X0Sa
        bCTTCNONrA6IsKAg==
From:   "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq: Fix software resend lockup and nested resend
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230826154004.1417-1-johan+linaro@kernel.org>
References: <20230826154004.1417-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Message-ID: <169307026499.27769.17332757460481689557.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     9f5deb551655a4cff04b21ecffdcdab75112da3a
Gitweb:        https://git.kernel.org/tip/9f5deb551655a4cff04b21ecffdcdab75112da3a
Author:        Johan Hovold <johan+linaro@kernel.org>
AuthorDate:    Sat, 26 Aug 2023 17:40:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 26 Aug 2023 19:14:31 +02:00

genirq: Fix software resend lockup and nested resend

The switch to using hlist for managing software resend of interrupts
broke resend in at least two ways:

First, unconditionally adding interrupt descriptors to the resend list can
corrupt the list when the descriptor in question has already been
added. This causes the resend tasklet to loop indefinitely with interrupts
disabled as was recently reported with the Lenovo ThinkPad X13s after
threaded NAPI was disabled in the ath11k WiFi driver.

This bug is easily fixed by restoring the old semantics of irq_sw_resend()
so that it can be called also for descriptors that have already been marked
for resend.

Second, the offending commit also broke software resend of nested
interrupts by simply discarding the code that made sure that such
interrupts are retriggered using the parent interrupt.

Add back the corresponding code that adds the parent descriptor to the
resend list.

Fixes: bc06a9e08742 ("genirq: Use hlist for managing resend handlers")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/lkml/20230809073432.4193-1-johan+linaro@kernel.org/
Link: https://lore.kernel.org/r/20230826154004.1417-1-johan+linaro@kernel.org

---
 kernel/irq/resend.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index edec335..5f2c668 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -68,11 +68,16 @@ static int irq_sw_resend(struct irq_desc *desc)
 		 */
 		if (!desc->parent_irq)
 			return -EINVAL;
+
+		desc = irq_to_desc(desc->parent_irq);
+		if (!desc)
+			return -EINVAL;
 	}
 
 	/* Add to resend_list and activate the softirq: */
 	raw_spin_lock(&irq_resend_lock);
-	hlist_add_head(&desc->resend_node, &irq_resend_list);
+	if (hlist_unhashed(&desc->resend_node))
+		hlist_add_head(&desc->resend_node, &irq_resend_list);
 	raw_spin_unlock(&irq_resend_lock);
 	tasklet_schedule(&resend_tasklet);
 	return 0;
