Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405677E1829
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 01:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjKFAd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 19:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjKFA3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 19:29:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC35E0;
        Sun,  5 Nov 2023 16:29:07 -0800 (PST)
Date:   Mon, 06 Nov 2023 00:28:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699230545;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3xq+5DOBB1dI8DqvWcQNMKQaktWNVBj4yETwIhzumWk=;
        b=0JPNS52jezPkRhpIsy+sdBlsR+IxydmPcv9GQDN1nWmSgceikJeXdzfCk5HitlyMZ5Pt/g
        Gu9ZS4jh9qtp8mJzm9zTrs7Mssum+B1T8B8cGcKFtD/ScDJo+uGiecu8AkJnW3oQ47XM0F
        lJzu5tcGUt8kFuxdxepbj5TzhXo4pdo8tQ2etZcbqaLfGnHJXaxB7XJxcoscGTEZOEu69y
        fMbEsZVfusnHak4y5+27SPHytdz2I+Y5sF8SEvt1akTEJuwB9H5jPJkyUgOeI6KcQBVuvU
        YlHLN4GuBQL/aOB0dzwG7Cx0ksvXdubXB1iA06TC+eXINYL5v5Urs6QZKaLMEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699230545;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3xq+5DOBB1dI8DqvWcQNMKQaktWNVBj4yETwIhzumWk=;
        b=BXxWrGSaNdoEmZsMCeYZdHtbMthhI1C7qtnSN4G8oUkrs9YV+dGDuPb/uHt9HTx3klkfw4
        n3IfdX6P7IrYPPDA==
From:   "tip-bot2 for Fang Xiang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v3-its: Flush ITS tables correctly in
 non-coherent GIC designs
Cc:     Marc Zyngier <maz@kernel.org>, Fang Xiang <fangxiang3@xiaomi.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231030083256.4345-1-fangxiang3@xiaomi.com>
References: <20231030083256.4345-1-fangxiang3@xiaomi.com>
MIME-Version: 1.0
Message-ID: <169923053565.3135.5315727184274747802.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     d3badb15613c14dd35d3495b1dde5c90fcd616dd
Gitweb:        https://git.kernel.org/tip/d3badb15613c14dd35d3495b1dde5c90fcd616dd
Author:        Fang Xiang <fangxiang3@xiaomi.com>
AuthorDate:    Mon, 30 Oct 2023 16:32:56 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 06 Nov 2023 01:16:33 +01:00

irqchip/gic-v3-its: Flush ITS tables correctly in non-coherent GIC designs

In non-coherent GIC designs, the ITS tables must be flushed before writing
to the GITS_BASER<n> registers, otherwise the ITS could read dirty tables,
which results in unpredictable behavior.

Flush the tables right at the begin of its_setup_baser() to prevent that.

[ tglx: Massage changelog ]

Fixes: a8707f553884 ("irqchip/gic-v3: Add Rockchip 3588001 erratum workaround")
Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Fang Xiang <fangxiang3@xiaomi.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20231030083256.4345-1-fangxiang3@xiaomi.com
---
 drivers/irqchip/irq-gic-v3-its.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index a8c89df..9a7a742 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2379,12 +2379,12 @@ retry_baser:
 		break;
 	}
 
+	if (!shr)
+		gic_flush_dcache_to_poc(base, PAGE_ORDER_TO_SIZE(order));
+
 	its_write_baser(its, baser, val);
 	tmp = baser->val;
 
-	if (its->flags & ITS_FLAGS_FORCE_NON_SHAREABLE)
-		tmp &= ~GITS_BASER_SHAREABILITY_MASK;
-
 	if ((val ^ tmp) & GITS_BASER_SHAREABILITY_MASK) {
 		/*
 		 * Shareability didn't stick. Just use
@@ -2394,10 +2394,9 @@ retry_baser:
 		 * non-cacheable as well.
 		 */
 		shr = tmp & GITS_BASER_SHAREABILITY_MASK;
-		if (!shr) {
+		if (!shr)
 			cache = GITS_BASER_nC;
-			gic_flush_dcache_to_poc(base, PAGE_ORDER_TO_SIZE(order));
-		}
+
 		goto retry_baser;
 	}
 
@@ -2609,6 +2608,11 @@ static int its_alloc_tables(struct its_node *its)
 		/* erratum 24313: ignore memory access type */
 		cache = GITS_BASER_nCnB;
 
+	if (its->flags & ITS_FLAGS_FORCE_NON_SHAREABLE) {
+		cache = GITS_BASER_nC;
+		shr = 0;
+	}
+
 	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
 		struct its_baser *baser = its->tables + i;
 		u64 val = its_read_baser(its, baser);
