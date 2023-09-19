Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D5E7A59E1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 08:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjISGUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 02:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjISGUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:20:24 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE19D115
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 23:20:17 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38J6JD5A064094;
        Tue, 19 Sep 2023 01:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695104353;
        bh=hL/KqLIG8BIFncfFDEz7NdaJGF5Cr6osXSN12l6/8SY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nYJNTNyCtnQaa8An+owhQqEU573deaH1xUH1p37KgLdgtduffGjRwCmiJ0wKzfU7a
         ekOJWrpLJtLTZKpj/cie7T7Pt261WxeTUP6UCugsl8hS7yKHhvnWG0jjWWMwqzRU/C
         pG8YMfJx1iwb5AklVFWESGrl+b4aqO9G77vBAlVk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38J6JDPX076483
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Sep 2023 01:19:13 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 01:19:13 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 01:19:13 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38J6JD62084665;
        Tue, 19 Sep 2023 01:19:13 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.199])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 38J6JCEq016496;
        Tue, 19 Sep 2023 01:19:12 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Suman Anna <s-anna@ti.com>,
        David Lechner <david@lechnology.com>,
        Roger Quadros <rogerq@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <srk@ti.com>, <danishanwar@ti.com>,
        <r-gunasekaran@ti.com>, <vigneshr@ti.com>
Subject: [PATCH 1/3] irqchip/irq-pruss-intc: Fix enabling of intc events
Date:   Tue, 19 Sep 2023 11:48:58 +0530
Message-ID: <20230919061900.369300-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919061900.369300-1-danishanwar@ti.com>
References: <20230919061900.369300-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

PRUSS INTC events are enabled by default once IRQ events are mapped to
channel:host pair. This may cause issues with undesirable IRQs triggering
even before a PRU IRQ is requested which are silently processed by
pruss_intc_irq_handler().

Fix it by masking all events by default except those which are routed to
various PRU cores (Host IRQs 0, 1; 10 through 19 on K3 SoCs), and any
other reserved IRQs routed to other processors. The unmasking of IRQs is
the responsibility of Linux IRQ core when IRQ is actually requested.

Fixes: 04e2d1e06978 ("irqchip/irq-pruss-intc: Add a PRUSS irqchip driver for PRUSS interrupts")

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/irqchip/irq-pruss-intc.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-intc.c
index 0f64ecb9b1f4..7415817d4c6c 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -101,6 +101,7 @@ struct pruss_intc_match_data {
  * @soc_config: cached PRUSS INTC IP configuration data
  * @dev: PRUSS INTC device pointer
  * @lock: mutex to serialize interrupts mapping
+ * @irqs_reserved: bit-mask of reserved host interrupts
  */
 struct pruss_intc {
 	struct pruss_intc_map_record event_channel[MAX_PRU_SYS_EVENTS];
@@ -111,6 +112,7 @@ struct pruss_intc {
 	const struct pruss_intc_match_data *soc_config;
 	struct device *dev;
 	struct mutex lock; /* PRUSS INTC lock */
+	u8 irqs_reserved;
 };
 
 /**
@@ -178,6 +180,7 @@ static void pruss_intc_update_hmr(struct pruss_intc *intc, u8 ch, u8 host)
 static void pruss_intc_map(struct pruss_intc *intc, unsigned long hwirq)
 {
 	struct device *dev = intc->dev;
+	bool enable_hwirq = false;
 	u8 ch, host, reg_idx;
 	u32 val;
 
@@ -187,6 +190,9 @@ static void pruss_intc_map(struct pruss_intc *intc, unsigned long hwirq)
 
 	ch = intc->event_channel[hwirq].value;
 	host = intc->channel_host[ch].value;
+	enable_hwirq = (host < FIRST_PRU_HOST_INT ||
+			host >= FIRST_PRU_HOST_INT + MAX_NUM_HOST_IRQS ||
+			intc->irqs_reserved & BIT(host - FIRST_PRU_HOST_INT));
 
 	pruss_intc_update_cmr(intc, hwirq, ch);
 
@@ -194,8 +200,10 @@ static void pruss_intc_map(struct pruss_intc *intc, unsigned long hwirq)
 	val = BIT(hwirq  % 32);
 
 	/* clear and enable system event */
-	pruss_intc_write_reg(intc, PRU_INTC_ESR(reg_idx), val);
 	pruss_intc_write_reg(intc, PRU_INTC_SECR(reg_idx), val);
+	/* unmask only events going to various PRU and other cores by default */
+	if (enable_hwirq)
+		pruss_intc_write_reg(intc, PRU_INTC_ESR(reg_idx), val);
 
 	if (++intc->channel_host[ch].ref_count == 1) {
 		pruss_intc_update_hmr(intc, ch, host);
@@ -204,7 +212,8 @@ static void pruss_intc_map(struct pruss_intc *intc, unsigned long hwirq)
 		pruss_intc_write_reg(intc, PRU_INTC_HIEISR, host);
 	}
 
-	dev_dbg(dev, "mapped system_event = %lu channel = %d host = %d",
+	dev_dbg(dev, "mapped%s system_event = %lu channel = %d host = %d",
+		enable_hwirq ? " and enabled" : "",
 		hwirq, ch, host);
 
 	mutex_unlock(&intc->lock);
@@ -268,11 +277,14 @@ static void pruss_intc_init(struct pruss_intc *intc)
 
 	/*
 	 * configure polarity (SIPR register) to active high and
-	 * type (SITR register) to level interrupt for all system events
+	 * type (SITR register) to level interrupt for all system events,
+	 * and disable and clear all the system events
 	 */
 	for (i = 0; i < num_event_type_regs; i++) {
 		pruss_intc_write_reg(intc, PRU_INTC_SIPR(i), 0xffffffff);
 		pruss_intc_write_reg(intc, PRU_INTC_SITR(i), 0);
+		pruss_intc_write_reg(intc, PRU_INTC_ECR(i), 0xffffffff);
+		pruss_intc_write_reg(intc, PRU_INTC_SECR(i), 0xffffffff);
 	}
 
 	/* clear all interrupt channel map registers, 4 events per register */
@@ -521,7 +533,7 @@ static int pruss_intc_probe(struct platform_device *pdev)
 	struct pruss_intc *intc;
 	struct pruss_host_irq_data *host_data;
 	int i, irq, ret;
-	u8 max_system_events, irqs_reserved = 0;
+	u8 max_system_events;
 
 	data = of_device_get_match_data(dev);
 	if (!data)
@@ -542,7 +554,7 @@ static int pruss_intc_probe(struct platform_device *pdev)
 		return PTR_ERR(intc->base);
 
 	ret = of_property_read_u8(dev->of_node, "ti,irqs-reserved",
-				  &irqs_reserved);
+				  &intc->irqs_reserved);
 
 	/*
 	 * The irqs-reserved is used only for some SoC's therefore not having
@@ -561,7 +573,7 @@ static int pruss_intc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	for (i = 0; i < MAX_NUM_HOST_IRQS; i++) {
-		if (irqs_reserved & BIT(i))
+		if (intc->irqs_reserved & BIT(i))
 			continue;
 
 		irq = platform_get_irq_byname(pdev, irq_names[i]);
-- 
2.34.1

