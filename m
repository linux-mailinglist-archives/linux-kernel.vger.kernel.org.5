Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3177D74CB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjJYTvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjJYTv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:51:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF219C4;
        Wed, 25 Oct 2023 12:51:26 -0700 (PDT)
Date:   Wed, 25 Oct 2023 19:51:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698263484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MOyEPsS1aamKfmJDRVQS6sjzRNlmifn7UPI8xWBiJVc=;
        b=kfrs8AdjC01v+JaEqPHXoMgn9J/hwKBjV4y50kFE6O3D99mXD6+taNrInnAgx/YjSzpBf/
        RuatY4ktrwnjMWxuzDdH/NXRa83NmybE2QmT2bmOf4eBYLtQA7FKeUPo6u05vhlP9TSpgF
        PPbBSAXUsW4Bmc3R1G9SbKHvG82cYR7TJmMu3iYfMTF8bcqRCLqvTSuIR9RuN/PIXMfnTm
        2fYMwF2WwM5eYi8ptUViEoMw4wDGKVUpXKPm9k3N3cOrvrtm+DocqIhnu9CMrKHqcm9bzE
        yNGIL/o9uJsbatIAbOV806TYRcfFuTcs+rO1qCZidWQZ4s7qrl8SMPD1ITtvww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698263484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MOyEPsS1aamKfmJDRVQS6sjzRNlmifn7UPI8xWBiJVc=;
        b=YJuJ+FYnaqoRTvb7oquodrziLNacUc5xWYrW0GPH0cMLLtMQVI5J+gxeD4DSFhJ+/es/x+
        cBitRXtXpmIAqIAg==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v3-its: Don't override quirk settings
 with default values
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dominic Rath <dominic.rath@ibv-augsburg.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231024084831.GA3788@JADEVM-DRA>
References: <20231024084831.GA3788@JADEVM-DRA>
MIME-Version: 1.0
Message-ID: <169826348318.3135.13818857870075312568.tip-bot2@tip-bot2>
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

Commit-ID:     f199bf5bf84c19a4f488a39d7d694ab10787de35
Gitweb:        https://git.kernel.org/tip/f199bf5bf84c19a4f488a39d7d694ab10787de35
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 24 Oct 2023 15:34:31 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 25 Oct 2023 21:44:49 +02:00

irqchip/gic-v3-its: Don't override quirk settings with default values

When splitting the allocation of the ITS node from its configuration,
some of the default settings were kept in the latter instead of
being moved to the former.

This has the side effect of negating some of the quirk detections that
have happened in between, amongst which the dreaded Synquacer hack
(that also affect Dominic's TI platform).

Move the initialisation of these fields early, so that they can again be
overriden by the Synquacer quirk.

Fixes: 9585a495ac93 ("irqchip/gic-v3-its: Split allocation from initialisation of its_node")
Reported by: Dominic Rath <dominic.rath@ibv-augsburg.net>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Dominic Rath <dominic.rath@ibv-augsburg.net>
Link: https://lore.kernel.org/r/20231024084831.GA3788@JADEVM-DRA
Link: https://lore.kernel.org/r/20231024143431.2144579-1-maz@kernel.org

---
 drivers/irqchip/irq-gic-v3-its.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 75a2dd5..a8c89df 100644
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
