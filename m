Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212967A59E0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 08:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjISGU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 02:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjISGUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:20:20 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AFA102
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 23:20:13 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38J6JRoS033901;
        Tue, 19 Sep 2023 01:19:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695104367;
        bh=wadIVfqlESM5a6EiU3NriwgWYc8PERb8uL3hTdC3S5g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FMl3t6ngf0FZAd+pVId+Gp1u1NVeHn4rEhBJC/Jxb1GHCe8Nf1jHd2HnOW4ZyHXEK
         nyAZt1QTAJ+f0XzqnLAq1VDs4AOaN1dD0OcBvEftli/qWkUj695ilOvtLbJNBfDxUc
         AQwNciqmvWLJ30RElTNCLiYQeAPHOoGb1oGt2I3g=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38J6JQ1l023687
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Sep 2023 01:19:26 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 01:19:26 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 01:19:26 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38J6JQpt084815;
        Tue, 19 Sep 2023 01:19:26 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.199])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 38J6JPOU016522;
        Tue, 19 Sep 2023 01:19:26 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Suman Anna <s-anna@ti.com>,
        David Lechner <david@lechnology.com>,
        Roger Quadros <rogerq@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <srk@ti.com>, <danishanwar@ti.com>,
        <r-gunasekaran@ti.com>, <vigneshr@ti.com>
Subject: [PATCH 3/3] irqchip/irq-pruss-intc: Fix processing of IEP interrupts
Date:   Tue, 19 Sep 2023 11:49:00 +0530
Message-ID: <20230919061900.369300-4-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919061900.369300-1-danishanwar@ti.com>
References: <20230919061900.369300-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

It was discovered that IEP capture/compare IRQs (event #7 on all SoCs
and event #56 on K3 SoCs) are always triggered twice when PPS is
generated and CMP hit event detected by IEP.

An example of the problem is:
  pruss_intc_irq_handler
   generic_handle_irq
    handle_level_irq
      mask_ack_irq -> IRQ 7 masked and asked in INTC,
                      but it's not yet cleared on HW level
      handle_irq_event()
        <threaded on RT>
           icss_iep_cap_cmp_handler() -> IRQ 7 is actually processed in HW
        irq_finalize_oneshot()
         unmask_irq()
           pruss_intc_irq_unmask() -> IRQ 7 status is still observed as set

The solution is to actually ack these IRQs from pruss_intc_irq_unmask()
after the IRQ source is cleared in HW.

No public errata available for this yet.

Fixes: 04e2d1e06978 ("irqchip/irq-pruss-intc: Add a PRUSS irqchip driver for PRUSS interrupts")

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/irqchip/irq-pruss-intc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-intc.c
index 3cf684ede564..9907847dbda8 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -70,6 +70,8 @@
 #define MAX_PRU_SYS_EVENTS 160
 #define MAX_PRU_CHANNELS 20
 
+#define MAX_PRU_INT_EVENTS	64
+
 /**
  * struct pruss_intc_map_record - keeps track of actual mapping state
  * @value: The currently mapped value (channel or host)
@@ -85,10 +87,13 @@ struct pruss_intc_map_record {
  * @num_system_events: number of input system events handled by the PRUSS INTC
  * @num_host_events: number of host events (which is equal to number of
  *		     channels) supported by the PRUSS INTC
+ * @quirky_events: bitmask of events that need quirky IRQ handling (limited to
+ *		   (internal sources only for now, so 64 bits suffice)
  */
 struct pruss_intc_match_data {
 	u8 num_system_events;
 	u8 num_host_events;
+	u64 quirky_events;
 };
 
 /**
@@ -304,6 +309,10 @@ static void pruss_intc_irq_ack(struct irq_data *data)
 	struct pruss_intc *intc = irq_data_get_irq_chip_data(data);
 	unsigned int hwirq = data->hwirq;
 
+	if (hwirq < MAX_PRU_INT_EVENTS &&
+	    intc->soc_config->quirky_events & BIT_ULL(hwirq))
+		return;
+
 	pruss_intc_write_reg(intc, PRU_INTC_SICR, hwirq);
 }
 
@@ -320,6 +329,9 @@ static void pruss_intc_irq_unmask(struct irq_data *data)
 	struct pruss_intc *intc = irq_data_get_irq_chip_data(data);
 	unsigned int hwirq = data->hwirq;
 
+	if (hwirq < MAX_PRU_INT_EVENTS &&
+	    intc->soc_config->quirky_events & BIT_ULL(hwirq))
+		pruss_intc_write_reg(intc, PRU_INTC_SICR, hwirq);
 	pruss_intc_write_reg(intc, PRU_INTC_EISR, hwirq);
 }
 
@@ -644,11 +656,13 @@ static int pruss_intc_remove(struct platform_device *pdev)
 static const struct pruss_intc_match_data pruss_intc_data = {
 	.num_system_events = 64,
 	.num_host_events = 10,
+	.quirky_events = BIT_ULL(7), /* IEP capture/compare event */
 };
 
 static const struct pruss_intc_match_data icssg_intc_data = {
 	.num_system_events = 160,
 	.num_host_events = 20,
+	.quirky_events = BIT_ULL(7) | BIT_ULL(56), /* IEP{0,1} capture/compare events */
 };
 
 static const struct of_device_id pruss_intc_of_match[] = {
-- 
2.34.1

