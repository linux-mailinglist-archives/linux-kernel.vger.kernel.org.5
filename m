Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2E37A59DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 08:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjISGUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 02:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjISGUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:20:20 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F74116
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 23:20:14 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38J6JKXj053098;
        Tue, 19 Sep 2023 01:19:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695104360;
        bh=kjJjjSfeg0swCjLTob8J1m6srCuAwipbvS7J0HjoRsg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WhDTbRVHDNOUA1Ds1pNZSDMzirVJ1TW41r4AYaxiafp0UpYH4tOy7vwS3rZQszT5i
         6FnqFmelTwuGkU6wYCopQtlVuEoYNhMyolegza7bB76Qwy+ahBfb32wFdKFjj5Am/n
         u+1f17ZX7MOhRvuewU4XzVxG4SCUjPQcThlQuCpo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38J6JKUT111826
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Sep 2023 01:19:20 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 01:19:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 01:19:19 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38J6JJkp084736;
        Tue, 19 Sep 2023 01:19:19 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.199])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 38J6JJG4016513;
        Tue, 19 Sep 2023 01:19:19 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Suman Anna <s-anna@ti.com>,
        David Lechner <david@lechnology.com>,
        Roger Quadros <rogerq@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <srk@ti.com>, <danishanwar@ti.com>,
        <r-gunasekaran@ti.com>, <vigneshr@ti.com>
Subject: [PATCH 2/3] irqchip/irq-pruss-intc: Fix listed IRQ type in /proc/interrupts
Date:   Tue, 19 Sep 2023 11:48:59 +0530
Message-ID: <20230919061900.369300-3-danishanwar@ti.com>
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

From: Grygorii Strashko <grygorii.strashko@ti.com>

The PRUSS INTC driver doesn't have .irq_set_type() callback implemented and
supports only IRQ_TYPE_LEVEL_HIGH. This resulted in the IRQ properties not
being updated properly and the PRUSS INTC IRQs were listed incorrectly in
/proc/interrupts as Edge.

Example:
  218:          0  4b220000.interrupt-controller  26 Edge      pru10

Fix this by adding a simple .irq_set_type() implementation which checks the
requested IRQ triggering type.

Fixes: 04e2d1e06978 ("irqchip/irq-pruss-intc: Add a PRUSS irqchip driver for PRUSS interrupts")

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/irqchip/irq-pruss-intc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-intc.c
index 7415817d4c6c..3cf684ede564 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -373,6 +373,14 @@ static int pruss_intc_irq_set_irqchip_state(struct irq_data *data,
 	return 0;
 }
 
+static int pruss_intc_irq_irq_set_type(struct irq_data *data, unsigned int type)
+{
+	if (type != IRQ_TYPE_LEVEL_HIGH)
+		return -EINVAL;
+
+	return 0;
+}
+
 static struct irq_chip pruss_irqchip = {
 	.name			= "pruss-intc",
 	.irq_ack		= pruss_intc_irq_ack,
@@ -382,6 +390,7 @@ static struct irq_chip pruss_irqchip = {
 	.irq_release_resources	= pruss_intc_irq_relres,
 	.irq_get_irqchip_state	= pruss_intc_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= pruss_intc_irq_set_irqchip_state,
+	.irq_set_type		= pruss_intc_irq_irq_set_type,
 };
 
 static int pruss_intc_validate_mapping(struct pruss_intc *intc, int event,
-- 
2.34.1

