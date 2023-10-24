Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BEF7D5425
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbjJXOe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjJXOex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:34:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EF7C4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:34:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B2AC433C8;
        Tue, 24 Oct 2023 14:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698158091;
        bh=0EcLCqFouJP0hY8CNrI3CsIj9BAxE4T9i5fPItqAv0c=;
        h=From:To:Cc:Subject:Date:From;
        b=TSPUXGwOds8PIYzY2u1wv4dS+kG7ASiDxO6BPzFcICge3VQ2LE+LJ37M/PdrdGI7T
         MIoZY7q1+456RCEme3UQ839oZi5qbfSnJunKgdcHb2zA4tkHOklL2VlYm7DLmeSy3d
         SltmN1Q3N6xrOHFCpGsgXtrIxbrQBTznP4Im5V3PvCPC5+6pfFALAZTnj+8GRp8L3H
         anN1xHdV5VXWBIT2QFich5957eHD3R9D0rL+yW++RO8UkTTu0z5AIIA3/+jzXUCaRX
         zUJwVKqjY0yIxaYQpqdo1PLEsK0lW9UApaZg+ktQ9wmrj7ninWpnhrBHCiaufvcRWL
         P8qyAbc3lkdiQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qvIUb-007Ewh-89;
        Tue, 24 Oct 2023 15:34:49 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lpieralisi@kernel.org, Dominic Rath <dominic.rath@ibv-augsburg.net>
Subject: [PATCH] irqchip/gic-v3-its: Don't override quirk settings with default values
Date:   Tue, 24 Oct 2023 15:34:31 +0100
Message-Id: <20231024143431.2144579-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lpieralisi@kernel.org, dominic.rath@ibv-augsburg.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When splitting the allocation of the ITS node from its configuration,
some of the default settings were kept in the latter instead of
being moved to the former.

This has the side effect of negating some of the quirk detection that
have happened in between, amongst which the dreaded Synquacer hack
(that also affect Dominic's TI platform).

Move the initialisation of these fields early, so that they can
again be overriden by the Synquacer quirk.

Fixes: 9585a495ac93 ("irqchip/gic-v3-its: Split allocation from initialisation of its_node")
Reported by: Dominic Rath <dominic.rath@ibv-augsburg.net>
Tested-by: Dominic Rath <dominic.rath@ibv-augsburg.net>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20231024084831.GA3788@JADEVM-DRA
---

Notes:
    Hi Thomas,
    
    This is an urgent, last-minute fix for a regression that I introduced in -rc6.
    I'd appreciate it if you could send it along to Linus before v6.6 gets released.
    
    Thanks,
    
            M.

 drivers/irqchip/irq-gic-v3-its.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 75a2dd550625..a8c89df1a997 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5112,8 +5112,6 @@ static int __init its_probe_one(struct its_node *its)
 	}
 	its->cmd_base = (void *)page_address(page);
 	its->cmd_write = its->cmd_base;
-	its->get_msi_base = its_irq_get_msi_base;
-	its->msi_domain_flags = IRQ_DOMAIN_FLAG_ISOLATED_MSI;
 
 	err = its_alloc_tables(its);
 	if (err)
@@ -5362,6 +5360,8 @@ static struct its_node __init *its_node_init(struct resource *res,
 	its->typer = gic_read_typer(its_base + GITS_TYPER);
 	its->base = its_base;
 	its->phys_base = res->start;
+	its->get_msi_base = its_irq_get_msi_base;
+	its->msi_domain_flags = IRQ_DOMAIN_FLAG_ISOLATED_MSI;
 
 	its->numa_node = numa_node;
 	its->fwnode_handle = handle;
-- 
2.39.2

