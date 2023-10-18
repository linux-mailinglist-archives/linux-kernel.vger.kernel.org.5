Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5327CDF0C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbjJROQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjJROPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:15:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CAF212C;
        Wed, 18 Oct 2023 07:13:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2139EC43391;
        Wed, 18 Oct 2023 14:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638428;
        bh=4TpKUHbeJhydNfeTrWYik6Eg3Dy0qNg/mrIhNU3pthk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PJj+95CiCpKMwDNmB3N2QhB1MEptus1bGhcbvVg6dy4DuZE43KXCSakC1ukF59Xc0
         paLifneUXdcfY7NecgZyMWM7tpcJtsBpPuMhPyFLFAX1qKfcUHGF6sAHf3zMkbBgVl
         vILzSd7jZXzuPPGtnYQuakFHIVeVbx64JgsA4LEdmJATTaWHDKcBbo1J04fxrTNnk9
         V5XsijgCpSHNjMlrg7c7XUcrXhdSqkRc3n7CHSMZKExfRuSBmp7eIb3L9gdcYEptt8
         C0JnKRa77YhsF703Lpudjf+USurhqYOiK6hbJ9VYQXcuvFcaOL3URjQJ4L/Yv4Zgy8
         My9/xcJn0Q+pQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Dmitry Dunaev <dunaev@tecon.ru>, Marc Zyngier <maz@kernel.org>,
        Sasha Levin <sashal@kernel.org>, tglx@linutronix.de,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 11/19] irqchip/riscv-intc: Mark all INTC nodes as initialized
Date:   Wed, 18 Oct 2023 10:13:13 -0400
Message-Id: <20231018141323.1334898-11-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141323.1334898-1-sashal@kernel.org>
References: <20231018141323.1334898-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.58
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anup Patel <apatel@ventanamicro.com>

[ Upstream commit e13cd66bd821be417c498a34928652db4ac6b436 ]

The RISC-V INTC local interrupts are per-HART (or per-CPU) so we
create INTC IRQ domain only for the INTC node belonging to the boot
HART. This means only the boot HART INTC node will be marked as
initialized and other INTC nodes won't be marked which results
downstream interrupt controllers (such as PLIC, IMSIC and APLIC
direct-mode) not being probed due to missing device suppliers.

To address this issue, we mark all INTC node for which we don't
create IRQ domain as initialized.

Reported-by: Dmitry Dunaev <dunaev@tecon.ru>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230926102801.1591126-1-dunaev@tecon.ru
Link: https://lore.kernel.org/r/20231003044403.1974628-4-apatel@ventanamicro.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-riscv-intc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 499e5f81b3fe3..4b66850978e6e 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -110,8 +110,16 @@ static int __init riscv_intc_init(struct device_node *node,
 	 * for each INTC DT node. We only need to do INTC initialization
 	 * for the INTC DT node belonging to boot CPU (or boot HART).
 	 */
-	if (riscv_hartid_to_cpuid(hartid) != smp_processor_id())
+	if (riscv_hartid_to_cpuid(hartid) != smp_processor_id()) {
+		/*
+		 * The INTC nodes of each CPU are suppliers for downstream
+		 * interrupt controllers (such as PLIC, IMSIC and APLIC
+		 * direct-mode) so we should mark an INTC node as initialized
+		 * if we are not creating IRQ domain for it.
+		 */
+		fwnode_dev_initialized(of_fwnode_handle(node), true);
 		return 0;
+	}
 
 	intc_domain = irq_domain_add_linear(node, BITS_PER_LONG,
 					    &riscv_intc_domain_ops, NULL);
-- 
2.40.1

