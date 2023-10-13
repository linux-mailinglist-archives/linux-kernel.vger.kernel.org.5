Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628B67C8312
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjJMKb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjJMKbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:31:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAFCC9;
        Fri, 13 Oct 2023 03:31:21 -0700 (PDT)
Date:   Fri, 13 Oct 2023 10:31:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697193079;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eiMqyvH/SAwqIv54YCSZ66WUTpxVNkQwTX5nFDus+DU=;
        b=zSHkVen/LqOYL0LzA0Ua2hZuEg5+qWJocxg2yxTroCy3CREUi19ju1sYaQhFPMuHWrHM9x
        bXhxdsPZIlMO5MFZmoM0SqIr1ZoR/Os8WH3vsDeyBUGUIKNvpomdA8jmyX4mo0EoYGf7f2
        3dTr9baTM4KNtOMT8/KmPJpYgyisyPK3h9MvG34pR9fJWFuGgRH5PZigtRlhuVrbEXO2h0
        ubShTPttufSg/h9h7UOjlExdcyuRc1v1LSJ8qskxHC6j44RTJ33Cb30ZeP673C0GZuY9ea
        ZjCM4Oo+iMEbQwkLW+RxHHLCWkX//rvGMHt0mC2jzOh3ZFY/RH/ldZ0n5QspRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697193079;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eiMqyvH/SAwqIv54YCSZ66WUTpxVNkQwTX5nFDus+DU=;
        b=XRLB4yYJl/5Pmr0qyez3ZPVpFaNXBADMoE2cira/pULVHwKLFCLgRvY5pn1RMEmOeW0T8N
        dzjXxgybMz+AiBCA==
From:   "tip-bot2 for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/renesas-rzg2l: Enhance driver to support
 interrupt affinity setting
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20231011195324.66807-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231011195324.66807-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <169719307895.3135.8684120215424738195.tip-bot2@tip-bot2>
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

Commit-ID:     f881feb180fd0563809b62faa3f7da234e81d42b
Gitweb:        https://git.kernel.org/tip/f881feb180fd0563809b62faa3f7da234e81d42b
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Wed, 11 Oct 2023 20:53:24 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 13 Oct 2023 12:25:31 +02:00

irqchip/renesas-rzg2l: Enhance driver to support interrupt affinity setting

Add support to set the affinity of the IRQC interrupt by implementing
the irq_set_affinity callback via the parent interrupt chip.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20231011195324.66807-1-prabhakar.mahadev-lad.rj@bp.renesas.com

---
 drivers/irqchip/irq-renesas-rzg2l.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 4bbfa2b..e3029dd 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -247,6 +247,7 @@ static const struct irq_chip irqc_chip = {
 	.irq_set_irqchip_state	= irq_chip_set_parent_state,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_type		= rzg2l_irqc_set_type,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
 	.flags			= IRQCHIP_MASK_ON_SUSPEND |
 				  IRQCHIP_SET_TYPE_MASKED |
 				  IRQCHIP_SKIP_SET_WAKE,
