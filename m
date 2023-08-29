Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38EB78C128
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbjH2JVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbjH2JV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:21:29 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071AC1AB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:21:22 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4ffa248263cso6530156e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693300881; x=1693905681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yca/ZYJGx07+FCrBNIkkSjzoj2b252pPrpTHmFj8f54=;
        b=KsCcAWCUHBwwGlPlg5zJUy8q22LdZMgafzx16QZQROXaACkd5kMb6y6E78b8RaLrA7
         RQ974LBc/z8EomzMSKUAwplMiUJKPlwrhUo7ntf9wK5b7nhnV1muK2FYSJxoOUWpb0jt
         l6Z7bPsePO3cw/rNcdpuvZmMMHkEv+QJlbORkrFE8H3wRPO6hUrsFhAWYnndPxZlK5rH
         rNMFTsN0yiH3eSepa9yXcKj/V4MYHl28W5js6LLS3IbzHImcz1tGRuWWbE5/TveK1xtI
         C5baDRwfYzCheaCgvxiZm8B+zcAO1RjbnAyjXwA1NPEeeXUDoMpNlWHjFMN0e9YV+Viq
         lMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693300881; x=1693905681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yca/ZYJGx07+FCrBNIkkSjzoj2b252pPrpTHmFj8f54=;
        b=NJzaZbf8rON/uQN9YOcgjZHyq51jihXrzahTJ+4Ga8m/dgovZGxno08vgsp5lN3ASm
         RGDrjv9nFtK7v5TGqcetK0wqmWrb9nrQ+8R7u6rJY9ABWX6PF6QnQlTENp1Oyl6UMvT1
         52e6l8GoJbxelgCRdLfEaDV5qx4Vtp6vJ6rQKiMpp8M5HBfliXn4AWeMnqBi6Qv4qrLE
         C8TO+ozluc26SVzZGCFgTkPPod6Xn8hnXKR9hQUtWFqf58ogXwCpDtQx7BK+mfwpoYl3
         ED9g+p4A4x+aNrJgDDdB0N3YSK15Ob0rrJn+GJB215svIZ3B/kES8PxNU8vIkTw1o7J3
         Qmgw==
X-Gm-Message-State: AOJu0Yx6wPWSwTpW+L78BWSvzEiaLJT4UWmFDZWDcemwuPQj5rTaFhCS
        6XhyNHo+/rFjdUeOkCZWd0AtxQ==
X-Google-Smtp-Source: AGHT+IE4iAMgg4o5ES1+kJ7xBEBcXOKzX3DOtHHRPij+Pm8nri+JDmOWY42QvxC6nCPXIaxuD0jpSQ==
X-Received: by 2002:a19:6451:0:b0:4fe:a2c:24b0 with SMTP id b17-20020a196451000000b004fe0a2c24b0mr17594079lfj.26.1693300881126;
        Tue, 29 Aug 2023 02:21:21 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id u20-20020ac24c34000000b004f858249932sm1884158lfq.90.2023.08.29.02.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 02:21:20 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 1/2] irqchip/qcom-pdc: Add support for v3.2 HW
Date:   Tue, 29 Aug 2023 12:21:18 +0300
Message-Id: <20230829092119.1017194-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829092119.1017194-1-dmitry.baryshkov@linaro.org>
References: <20230829092119.1017194-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <neil.armstrong@linaro.org>

Starting from HW version 3.2 the IRQ_ENABLE bit has moved to the
IRQ_i_CFG register and requires a change of the driver to avoid
writing into an undefined register address.

Get the HW version from registers and set the IRQ_ENABLE bit to the
correct register depending on the HW version.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
[DB: fix crash on sm8150 DTs which listed short PDC region]
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/irqchip/qcom-pdc.c | 73 ++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 14 deletions(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index a32c0d28d038..f9f44b494b1d 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -22,9 +22,22 @@
 
 #define PDC_MAX_GPIO_IRQS	256
 
+/* Valid only on HW version < 3.2 */
 #define IRQ_ENABLE_BANK		0x10
 #define IRQ_i_CFG		0x110
 
+/* Valid only on HW version >= 3.2 */
+#define IRQ_i_CFG_IRQ_ENABLE	3
+
+#define IRQ_i_CFG_TYPE_MASK	GENMASK(2, 0)
+
+#define PDC_VERSION		0x1000
+
+/* Notable PDC versions */
+enum {
+	PDC_VERSION_3_2	= 0x30200,
+};
+
 struct pdc_pin_region {
 	u32 pin_base;
 	u32 parent_base;
@@ -37,6 +50,7 @@ static DEFINE_RAW_SPINLOCK(pdc_lock);
 static void __iomem *pdc_base;
 static struct pdc_pin_region *pdc_region;
 static int pdc_region_cnt;
+static unsigned int pdc_version;
 
 static void pdc_reg_write(int reg, u32 i, u32 val)
 {
@@ -53,15 +67,22 @@ static void pdc_enable_intr(struct irq_data *d, bool on)
 	int pin_out = d->hwirq;
 	unsigned long enable;
 	unsigned long flags;
-	u32 index, mask;
-
-	index = pin_out / 32;
-	mask = pin_out % 32;
 
 	raw_spin_lock_irqsave(&pdc_lock, flags);
-	enable = pdc_reg_read(IRQ_ENABLE_BANK, index);
-	__assign_bit(mask, &enable, on);
-	pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
+	if (pdc_version < PDC_VERSION_3_2) {
+		u32 index, mask;
+
+		index = pin_out / 32;
+		mask = pin_out % 32;
+
+		enable = pdc_reg_read(IRQ_ENABLE_BANK, index);
+		__assign_bit(mask, &enable, on);
+		pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
+	} else {
+		enable = pdc_reg_read(IRQ_i_CFG, pin_out);
+		__assign_bit(IRQ_i_CFG_IRQ_ENABLE, &enable, on);
+		pdc_reg_write(IRQ_i_CFG, pin_out, enable);
+	}
 	raw_spin_unlock_irqrestore(&pdc_lock, flags);
 }
 
@@ -142,6 +163,7 @@ static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
 	}
 
 	old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
+	pdc_type |= (old_pdc_type & ~IRQ_i_CFG_TYPE_MASK);
 	pdc_reg_write(IRQ_i_CFG, d->hwirq, pdc_type);
 
 	ret = irq_chip_set_type_parent(d, type);
@@ -246,7 +268,7 @@ static const struct irq_domain_ops qcom_pdc_ops = {
 static int pdc_setup_pin_mapping(struct device_node *np)
 {
 	int ret, n, i;
-	u32 irq_index, reg_index, val;
+	unsigned long val;
 
 	n = of_property_count_elems_of_size(np, "qcom,pdc-ranges", sizeof(u32));
 	if (n <= 0 || n % 3)
@@ -277,28 +299,51 @@ static int pdc_setup_pin_mapping(struct device_node *np)
 			return ret;
 
 		for (i = 0; i < pdc_region[n].cnt; i++) {
-			reg_index = (i + pdc_region[n].pin_base) >> 5;
-			irq_index = (i + pdc_region[n].pin_base) & 0x1f;
-			val = pdc_reg_read(IRQ_ENABLE_BANK, reg_index);
-			val &= ~BIT(irq_index);
-			pdc_reg_write(IRQ_ENABLE_BANK, reg_index, val);
+			if (pdc_version < PDC_VERSION_3_2) {
+				u32 irq_index, reg_index;
+
+				reg_index = (i + pdc_region[n].pin_base) >> 5;
+				irq_index = (i + pdc_region[n].pin_base) & 0x1f;
+				val = pdc_reg_read(IRQ_ENABLE_BANK, reg_index);
+				__assign_bit(irq_index, &val, 0);
+				pdc_reg_write(IRQ_ENABLE_BANK, reg_index, val);
+			} else {
+				u32 irq;
+
+				irq = i + pdc_region[n].pin_base;
+				val = pdc_reg_read(IRQ_i_CFG, irq);
+				__assign_bit(IRQ_i_CFG_IRQ_ENABLE, &val,  0);
+				pdc_reg_write(IRQ_i_CFG, irq, val);
+			}
 		}
 	}
 
 	return 0;
 }
 
+#define QCOM_PDC_SIZE 0x30000
+
 static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
 {
 	struct irq_domain *parent_domain, *pdc_domain;
+	struct resource res;
+	resource_size_t res_size;
 	int ret;
 
-	pdc_base = of_iomap(node, 0);
+	/* compat with old sm8150 DT which had very small region for PDC */
+	if (of_address_to_resource(node, 0, &res))
+		return -EINVAL;
+
+	res_size = max_t(resource_size_t, resource_size(&res), QCOM_PDC_SIZE);
+
+	pdc_base = ioremap(res.start, res_size);
 	if (!pdc_base) {
 		pr_err("%pOF: unable to map PDC registers\n", node);
 		return -ENXIO;
 	}
 
+	pdc_version = pdc_reg_read(PDC_VERSION, 0);
+
 	parent_domain = irq_find_host(parent);
 	if (!parent_domain) {
 		pr_err("%pOF: unable to find PDC's parent domain\n", node);
-- 
2.39.2

