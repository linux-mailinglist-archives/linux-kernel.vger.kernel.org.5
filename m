Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7284380EF12
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376905AbjLLOoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376853AbjLLOoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:44:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECC7F2;
        Tue, 12 Dec 2023 06:44:22 -0800 (PST)
Date:   Tue, 12 Dec 2023 14:44:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702392260;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CPE1TxfztaCUJ8c67Q6iVKgI7+m5XFqGsRpjgNaFBhA=;
        b=xDbofv7U9/y5e8vJo4YOLZCjgvvbFtG7caAFnqU75p5RKA5mF+PwCU1MDEDuM7fscadzzj
        9+/DZxnDIShhPLRnsBrrVrn5oNlDb/aq9Uv3xEMzid/i+QbV3rRR4HW/ezVFmZB2zgvmrh
        E/6ZulsnB6Aa7hNS+P3gbjbD4cq33bHnAtW3Ik5Lb01sq80gCodYuw0Shl8zOnm2FpVpiJ
        DGlVBeD1JgpsmQ/r05rQ3kPsy9240XVre3K2zgUvNkUnLemzvnhVyvFFF2EhHPIpyuEB5D
        nkHqmOBgdNyElLcmPFLKSxnFB7kxGMY9Tndr3ehGv8ECGXBbVIB1JAJ2kiNM5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702392260;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CPE1TxfztaCUJ8c67Q6iVKgI7+m5XFqGsRpjgNaFBhA=;
        b=2Rd3tXeUE92TOmpW1kpuroJHZnX0y+X76NRkhS3g76aSIYvXIS2fm7AEX3xaEbmcwDVRTZ
        hjILWrI8Ez/5JEBA==
From:   "tip-bot2 for Konrad Dybcio" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/qcom-mpm: Support passing a slice of SRAM as
 reg space
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20230328-topic-msgram_mpm-v7-2-6ee2bfeaac2c@linaro.org>
References: <20230328-topic-msgram_mpm-v7-2-6ee2bfeaac2c@linaro.org>
MIME-Version: 1.0
Message-ID: <170239225978.398.6776352456083979765.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     221b110d87c2d3ea113ad784b2c6505726a3e157
Gitweb:        https://git.kernel.org/tip/221b110d87c2d3ea113ad784b2c6505726a3e157
Author:        Konrad Dybcio <konrad.dybcio@linaro.org>
AuthorDate:    Mon, 27 Nov 2023 16:52:13 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Dec 2023 15:40:42 +01:00

irqchip/qcom-mpm: Support passing a slice of SRAM as reg space

The MPM hardware is accessible from the ARM CPUs through a shared memory
region (RPM MSG RAM) which is also concurrently accessed by other kinds of
cores on the system like modem, ADSP etc.

Modeling this relation in a (somewhat) sane manner in the device tree
requires to

  - either present the MPM as a child of said memory region, which
    makes little sense, as a mapped memory carveout is not a bus.

  - define nodes which bleed their register spaces into one another

  - or passing their slice of the MSG RAM through a property

Go with the third option and add a way to map a region passed through the
"qcom,rpm-msg-ram" property as register space for the MPM interrupt
controller.

The current way of using 'reg' is preserved for backwards compatibility
reasons.

[ tglx: Massaged changelog ]

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
Link: https://lore.kernel.org/r/20230328-topic-msgram_mpm-v7-2-6ee2bfeaac2c@linaro.org

---
 drivers/irqchip/irq-qcom-mpm.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
index 7124565..cda5838 100644
--- a/drivers/irqchip/irq-qcom-mpm.c
+++ b/drivers/irqchip/irq-qcom-mpm.c
@@ -14,6 +14,7 @@
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
@@ -322,8 +323,10 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
 	struct device *dev = &pdev->dev;
 	struct irq_domain *parent_domain;
 	struct generic_pm_domain *genpd;
+	struct device_node *msgram_np;
 	struct qcom_mpm_priv *priv;
 	unsigned int pin_cnt;
+	struct resource res;
 	int i, irq;
 	int ret;
 
@@ -374,9 +377,26 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
 
 	raw_spin_lock_init(&priv->lock);
 
-	priv->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
+	/* If we have a handle to an RPM message ram partition, use it. */
+	msgram_np = of_parse_phandle(np, "qcom,rpm-msg-ram", 0);
+	if (msgram_np) {
+		ret = of_address_to_resource(msgram_np, 0, &res);
+		if (ret) {
+			of_node_put(msgram_np);
+			return ret;
+		}
+
+		/* Don't use devm_ioremap_resource, as we're accessing a shared region. */
+		priv->base = devm_ioremap(dev, res.start, resource_size(&res));
+		of_node_put(msgram_np);
+		if (IS_ERR(priv->base))
+			return PTR_ERR(priv->base);
+	} else {
+		/* Otherwise, fall back to simple MMIO. */
+		priv->base = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(priv->base))
+			return PTR_ERR(priv->base);
+	}
 
 	for (i = 0; i < priv->reg_stride; i++) {
 		qcom_mpm_write(priv, MPM_REG_ENABLE, i, 0);
