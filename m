Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E927AC750
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 11:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjIXJbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 05:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjIXJbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 05:31:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F879FE
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 02:31:15 -0700 (PDT)
Date:   Sun, 24 Sep 2023 09:31:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695547874;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uhIVsE+ib8b0OcLzP7C28dZ20AkkqV+wYbZP9GhznoI=;
        b=U/PBlAYYJf1FRVGWMJTshREY+NzD6WjH7rNSSYp0LbXPPfiBMT7A5lN2B8bPG5NouSugzS
        2/YI66K6wbP73w6c6v0WYEGhMO1WrhDDtgp0L50K86FedFviTAvCNQ2ZB8Fb8I/PI+NSUm
        dPfvBLtv7yX/K/2iT5fK5PbQ6syf96A/FMNQpl8Opk5dN4uMzOAaxp25nkVCFQHY5D47Lu
        dFOLvov9d2pF7p15pu/nHKTaNE3kc3sffnW/kSMcLr9tbT36fQl3C8pudp1ZPdO5q1ZZmb
        bN4ebuop6edPGUJXEh4rn2YmnEI37cawzFZuAJ6SdSNpdKTm2JRjhO6RS0B+Rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695547874;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uhIVsE+ib8b0OcLzP7C28dZ20AkkqV+wYbZP9GhznoI=;
        b=XXk12dLav9cFryC3S6+GGdIVzw8dYg2wrFGWpj6I5ci176Q6qaW8eajxNVfyHWuyNRKLA7
        soLCGU2Ryo0DPzAA==
From:   "irqchip-bot for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip: renesas-rzg2l: Fix logic to
 clear TINT interrupt source
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230918122411.237635-2-biju.das.jz@bp.renesas.com>
References: <20230918122411.237635-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <169554787327.27769.4173063850512079064.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     9b8df572ba3f4e544366196820a719a40774433e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/9b8df572ba3f4e544366196820a719a40774433e
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Mon, 18 Sep 2023 13:24:09 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 24 Sep 2023 10:18:19 +01:00

irqchip: renesas-rzg2l: Fix logic to clear TINT interrupt source

The logic to clear the TINT interrupt source in rzg2l_irqc_irq_disable()
is wrong as the mask is correct only for LSB on the TSSR register.
This issue is found when testing with two TINT interrupt sources. So fix
the logic for all TINTs by using the macro TSSEL_SHIFT() to multiply
tssr_offset with 8.

Fixes: 3fed09559cd8 ("irqchip: Add RZ/G2L IA55 Interrupt Controller driver")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230918122411.237635-2-biju.das.jz@bp.renesas.com
---
 drivers/irqchip/irq-renesas-rzg2l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 4bbfa2b..2cee547 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -118,7 +118,7 @@ static void rzg2l_irqc_irq_disable(struct irq_data *d)
 
 		raw_spin_lock(&priv->lock);
 		reg = readl_relaxed(priv->base + TSSR(tssr_index));
-		reg &= ~(TSSEL_MASK << tssr_offset);
+		reg &= ~(TSSEL_MASK << TSSEL_SHIFT(tssr_offset));
 		writel_relaxed(reg, priv->base + TSSR(tssr_index));
 		raw_spin_unlock(&priv->lock);
 	}
