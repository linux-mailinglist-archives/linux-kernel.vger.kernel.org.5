Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153957B2AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 05:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbjI2DoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 23:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjI2DoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 23:44:11 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5E71A4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 20:44:08 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32483535e51so1559681f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 20:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695959047; x=1696563847; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=acVWHIoiv/nOUoM6tOLhOb3p3m5yaBtAYAFv/urNSEs=;
        b=mMIqMjU1z8MTfzpJQKHgqkLfFWSEPEodLrF1NNpMTkppRoBbu4/5P7U2Vj7zwXtASM
         ykL16hQMkTfMG5dYoF1IwhdcASOqETtqZzNdcanjO7gXdYH3KL1elsbOmzCNIyrJEXWR
         38Zet7xf5mZ0nr5+i6GvZ24r8b5wF4um5w2ZJD/kQ8dmBqv9OiaOd2ZmMEOphUhvEM4x
         QYnzjq2vLhp7/JjwA1w1OXoBcR/BZDi627NF0G7MZGDD32P/Ee5roGGuoZE0kIH+4D88
         BoGPaUFiNJmw60sw9IOJQC1/ZGtL3HWM2KHvUgHjZ8gYEjSJVXOGDFZ98YlmpsBotHhz
         qRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695959047; x=1696563847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acVWHIoiv/nOUoM6tOLhOb3p3m5yaBtAYAFv/urNSEs=;
        b=wACkR2YINduyVMDqKGZ1QIpWPyjt1GTTZKjWxiEPLwqHujk2PPYvXi3fNuYH/gcZxQ
         I1Mkvsuc++mzPMmOFMVuOMirFKwCNtv/vioGqT74L+DAZm7Ni8+NTxtKoUC8SarsFwAr
         hudjUWnFj8f5jVvp/N5H9D0g+djT5QpQ2wk6Ibk1X5GL5uVqVrkjDm73JJLA4+Lsf2rp
         z/F7GV9FAvKfWY8WzDHCd82RbVqQnIXHaNH6Fm0L6j026wU84hLHYSP4pwgOY1js8bcU
         8HRiDjyNQZ4Zx8r/YUzlzYNWRU1WYoZ0CoE9USW5By5wIwi34bkD1DW937M6yPulSirm
         dTGA==
X-Gm-Message-State: AOJu0Yxt7N/w2AG5C4TWo0WSF2gu/xiq0Dprc5rMTjdDiXm5M1CnIoEn
        9Wf6N79VvD1gRKTP9F179mh1JA==
X-Google-Smtp-Source: AGHT+IGXle48yuXTwdfLNOY2Q59PeDduwFqrcPVpV9EMUX2zfs+0NgzzIwaJhSELyHobD7wHJb3Y1A==
X-Received: by 2002:a5d:6391:0:b0:313:f4e2:901d with SMTP id p17-20020a5d6391000000b00313f4e2901dmr2558635wru.22.1695959047138;
        Thu, 28 Sep 2023 20:44:07 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id c10-20020a5d4f0a000000b0031f3ad17b2csm20645177wru.52.2023.09.28.20.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 20:44:06 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 29 Sep 2023 05:44:00 +0200
Subject: [PATCH v5 1/2] irqchip/qcom-pdc: Add support for v3.2 HW
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-topic-sm8x50-upstream-pdc-ver-v5-1-800111572104@linaro.org>
References: <20230929-topic-sm8x50-upstream-pdc-ver-v5-0-800111572104@linaro.org>
In-Reply-To: <20230929-topic-sm8x50-upstream-pdc-ver-v5-0-800111572104@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4795;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=6orSRP0NJTZLQP1EFMD8qpi/uGQjJ1PT/4dWzZv/274=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlFkgEM23mKD7GVUZMrhmFIMBFXUVV2ivFJ6gTTTsF
 +QMNTo+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZRZIBAAKCRB33NvayMhJ0ZkEEA
 CAPhgNPTi4z29rCKsy0U3EMHRGmyn9VeZnGTpkNZNNA5Uu/nfHlJLYDenrXZ0P7oMTuwWJ8DbMTMO4
 UqVOut8+GpnWBlWrITpMebrU3rwWApFrf2AR/nO95FQqX9otdLwdTwI7EWEG1yQpt9A6Jk3EqC/gtc
 aa2tYKv22jxx+vORRp/A+hl9v61b3eSMuLrnFKPgGw8HDHXOlJvbU3K8hb0LpVr7Zs1dQiPC5LZe+7
 LG0WTsJsuQtY1yteH/AoQiQFheX2ZWlSfeMbW8iU/cHUQgxk6Q8A0Tvz3HEvqnq+5Hosb6tNV1t0Zs
 IVDesPX+xELVmM11okNRhc/H+Zb81v5kzuAJhO7OYFjM0uFkuqckFDudqn7EbpN8bOpQkZy8L7L+cR
 gEzHvKyixkNRKPGxCgfVeWuZfW2nmC6pXNChv+BU2VfpvWLeINJtfiiRd1uxmkhLiQQKqYGAyj5zJR
 NNAcUswz8qU3C6/wtEkWjn7xFJmdoO9O3ANmxc0bj001uaeLm81hos0upNY7KEmXNI3bIHKIr3tajZ
 Ux7li/fXf1312HvR78GUOnIbLwCZkP8pC0u73aAgAdASxvRgNhZen82Gu3HLQCe8smZR0ou/bd3ZfQ
 HVMBfrQnc6XcARA6/1n3UM9kh0atBbGfCxFRpqJeCo9Onfj8pnsjwK/M6Yiw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting from HW version 3.2 the IRQ_ENABLE bit has moved to the
IRQ_i_CFG register and requires a change of the driver to avoid
writing into an undefined register address.

Get the HW version from registers and set the IRQ_ENABLE bit to the
correct register depending on the HW version.

Reviewed-by: Maulik Shah <quic_mkshah@quicinc.com>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/irqchip/qcom-pdc.c | 69 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index a32c0d28d038..74b2f124116e 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -22,9 +22,20 @@
 
 #define PDC_MAX_GPIO_IRQS	256
 
+/* Valid only on HW version < 3.2 */
 #define IRQ_ENABLE_BANK		0x10
 #define IRQ_i_CFG		0x110
 
+/* Valid only on HW version >= 3.2 */
+#define IRQ_i_CFG_IRQ_ENABLE	3
+
+#define IRQ_i_CFG_TYPE_MASK	GENMASK(2, 0)
+
+#define PDC_VERSION_REG		0x1000
+
+/* Notable PDC versions */
+#define PDC_VERSION_3_2		0x30200
+
 struct pdc_pin_region {
 	u32 pin_base;
 	u32 parent_base;
@@ -37,6 +48,7 @@ static DEFINE_RAW_SPINLOCK(pdc_lock);
 static void __iomem *pdc_base;
 static struct pdc_pin_region *pdc_region;
 static int pdc_region_cnt;
+static unsigned int pdc_version;
 
 static void pdc_reg_write(int reg, u32 i, u32 val)
 {
@@ -48,20 +60,32 @@ static u32 pdc_reg_read(int reg, u32 i)
 	return readl_relaxed(pdc_base + reg + i * sizeof(u32));
 }
 
-static void pdc_enable_intr(struct irq_data *d, bool on)
+static void __pdc_enable_intr(int pin_out, bool on)
 {
-	int pin_out = d->hwirq;
 	unsigned long enable;
-	unsigned long flags;
-	u32 index, mask;
 
-	index = pin_out / 32;
-	mask = pin_out % 32;
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
+}
+
+static void pdc_enable_intr(struct irq_data *d, bool on)
+{
+	unsigned long flags;
 
 	raw_spin_lock_irqsave(&pdc_lock, flags);
-	enable = pdc_reg_read(IRQ_ENABLE_BANK, index);
-	__assign_bit(mask, &enable, on);
-	pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
+	__pdc_enable_intr(d->hwirq, on);
 	raw_spin_unlock_irqrestore(&pdc_lock, flags);
 }
 
@@ -142,6 +166,7 @@ static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
 	}
 
 	old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
+	pdc_type |= (old_pdc_type & ~IRQ_i_CFG_TYPE_MASK);
 	pdc_reg_write(IRQ_i_CFG, d->hwirq, pdc_type);
 
 	ret = irq_chip_set_type_parent(d, type);
@@ -246,7 +271,6 @@ static const struct irq_domain_ops qcom_pdc_ops = {
 static int pdc_setup_pin_mapping(struct device_node *np)
 {
 	int ret, n, i;
-	u32 irq_index, reg_index, val;
 
 	n = of_property_count_elems_of_size(np, "qcom,pdc-ranges", sizeof(u32));
 	if (n <= 0 || n % 3)
@@ -276,29 +300,38 @@ static int pdc_setup_pin_mapping(struct device_node *np)
 		if (ret)
 			return ret;
 
-		for (i = 0; i < pdc_region[n].cnt; i++) {
-			reg_index = (i + pdc_region[n].pin_base) >> 5;
-			irq_index = (i + pdc_region[n].pin_base) & 0x1f;
-			val = pdc_reg_read(IRQ_ENABLE_BANK, reg_index);
-			val &= ~BIT(irq_index);
-			pdc_reg_write(IRQ_ENABLE_BANK, reg_index, val);
-		}
+		for (i = 0; i < pdc_region[n].cnt; i++)
+			__pdc_enable_intr(i + pdc_region[n].pin_base, 0);
 	}
 
 	return 0;
 }
 
+#define QCOM_PDC_SIZE 0x30000
+
 static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
 {
 	struct irq_domain *parent_domain, *pdc_domain;
+	resource_size_t res_size;
+	struct resource res;
 	int ret;
 
-	pdc_base = of_iomap(node, 0);
+	/* compat with old sm8150 DT which had very small region for PDC */
+	if (of_address_to_resource(node, 0, &res))
+		return -EINVAL;
+
+	res_size = max_t(resource_size_t, resource_size(&res), QCOM_PDC_SIZE);
+	if (res_size > resource_size(&res))
+		pr_warn("%pOF: invalid reg size, please fix DT\n", node);
+
+	pdc_base = ioremap(res.start, res_size);
 	if (!pdc_base) {
 		pr_err("%pOF: unable to map PDC registers\n", node);
 		return -ENXIO;
 	}
 
+	pdc_version = pdc_reg_read(PDC_VERSION_REG, 0);
+
 	parent_domain = irq_find_host(parent);
 	if (!parent_domain) {
 		pr_err("%pOF: unable to find PDC's parent domain\n", node);

-- 
2.34.1

