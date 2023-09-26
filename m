Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E48E7AEA6E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbjIZKd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjIZKdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:33:55 -0400
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Sep 2023 03:33:46 PDT
Received: from mail.tecon.ru (mail.tecon.ru [82.112.190.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3793E9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 03:33:46 -0700 (PDT)
From:   Dmitry Dunaev <dunaev@tecon.ru>
CC:     <dunaich@mail.ru>, Dmitry Dunaev <dunaev@tecon.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH] irqchip/riscv-intc: Mark INTC nodes for secondary CPUs as initialized.
Date:   Tue, 26 Sep 2023 13:28:01 +0300
Message-ID: <20230926102801.1591126-1-dunaev@tecon.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,TO_EQ_FM_DIRECT_MX autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current Linux driver irq-riscv-intc initialize IRQ domain only once,
when init function called on primary hart. In other cases no IRQ domain is
created and no operation on interrupt-controller node is performed.
This is cause of that no common Linux driver can use per-cpu interrupts
mapped to several CPUs because fwnode of secondary cores INTC is not
marked as initialized. This device is always will be marked as deferred.
For example the system with devicetree

    cpu0: cpu@0 {
        cpu0_intc: interrupt-controller {
            interrupt-controller;
            compatible = riscv,cpu-intc;
        };
    };

    cpu1: cpu@1 {
        cpu1_intc: interrupt-controller {
            interrupt-controller;
            compatible = riscv,cpu-intc;
        };
    };

    buserr {
        compatible = riscv,buserr;
        interrupts-extended = <&cpu0_intc 16 &cpu1_intc 16>;
    };

will always report 'buserr' node as deferred without calling any
bus probe function.

This patch will mark all secondary nodes passed to irq-riscv-intc
driver init function as initialized to be able to act as correct
IRQ phandle node.

Signed-off-by: Dmitry Dunaev <dunaev@tecon.ru>
---
 drivers/irqchip/irq-riscv-intc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 4adeee1bc391..c01a4e8d4983 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -155,8 +155,10 @@ static int __init riscv_intc_init(struct device_node *node,
 	 * for each INTC DT node. We only need to do INTC initialization
 	 * for the INTC DT node belonging to boot CPU (or boot HART).
 	 */
-	if (riscv_hartid_to_cpuid(hartid) != smp_processor_id())
+	if (riscv_hartid_to_cpuid(hartid) != smp_processor_id()) {
+		fwnode_dev_initialized(of_node_to_fwnode(node), true);
 		return 0;
+	}
 
 	return riscv_intc_init_common(of_node_to_fwnode(node));
 }
@@ -179,8 +181,10 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 	 * for each INTC. We only do INTC initialization
 	 * for the INTC belonging to the boot CPU (or boot HART).
 	 */
-	if (riscv_hartid_to_cpuid(rintc->hart_id) != smp_processor_id())
+	if (riscv_hartid_to_cpuid(rintc->hart_id) != smp_processor_id()) {
+		fwnode_dev_initialized(of_node_to_fwnode(node), true);
 		return 0;
+	}
 
 	fn = irq_domain_alloc_named_fwnode("RISCV-INTC");
 	if (!fn) {
-- 
2.34.1

