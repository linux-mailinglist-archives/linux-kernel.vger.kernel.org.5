Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44197854A1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbjHWJwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjHWJtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:49:20 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ED52D64
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 02:42:23 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe24dd8898so51061365e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 02:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692783742; x=1693388542;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6xEw9ngDptyOdadthiYT40FXRYRZ6Nnj3rDSAIMjQKY=;
        b=hWC0e4Akpk++Kg9bZRtwSeMb3gWlfVurnWpYlytxNcvZkzrsKgJsBJYeZtX1l7TFSr
         cZbNrJOXYAqbJTW/xx8aylVgTOpK4PfoFUjSLNtblyjvrKoISMW2tPuRpFPSsITlSQhD
         Xu6oDp5wPbdkyMsPRg4sS4rtEb9JrjszhgjfNOroE4bnq4mXGBvjxq8rJLPoK0SNfU+S
         59ckrLqBW1dI4udr8X4OqtuJJFU6q3YsaGmtzVawtkRT+mVQCEy7Mk3x7ZmOEyHGlxhH
         JWKjbfzRUCQsLs+xZVJJuTwQewadGws/OtFuLWB/srOq/slzL0Ue/pk4TK/hQzRCkmF4
         kzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692783742; x=1693388542;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6xEw9ngDptyOdadthiYT40FXRYRZ6Nnj3rDSAIMjQKY=;
        b=iHB7FF4fX9nmZtvI3ju5uac5R4gXSWja9T2sw+tlosKR9Rr2UnjJElvYJ3atRpYrbQ
         X05MeqabwDubdcglMDnuwwuoj/AZgIAHTax07Xv+QWMUkl2Dn2B+QksDa8ZXl8ebNf/K
         pH8VkR+D1+X36h4Jh6HoqWpg71SVpc7Ck/rYrWYvW5cMjyPv9rmnm+LyPTJ6BHI551/0
         Fu6YneqzRnC+Qi7q/K56Yqcjd1fMnr3rcRJJWLlHhWVi57erqy7aXhhhJWkPmP91iz0E
         moRjfC3egTfh4ecQyoIIHmueXBp/Uu4KRAs+Sj0mp7oV0ZYHj4MaAWFTek17jYCcRjO6
         ARvA==
X-Gm-Message-State: AOJu0YyaHLgEgJFwf0oVeEqL+bm90Sf09+KhcCY8PFUTTdRIzNjNeBMk
        nhHqdSluYdArzvD3hamjl5FeNQ==
X-Google-Smtp-Source: AGHT+IHt/Mc+XqwbWxhEJFH51asW/YC/gFnEQrJz/eN9iUGCaJAAfwdwiAhYkhPncL/lJddPauFCbg==
X-Received: by 2002:a05:600c:2296:b0:3fd:2e6b:10c8 with SMTP id 22-20020a05600c229600b003fd2e6b10c8mr9562048wmf.23.1692783742263;
        Wed, 23 Aug 2023 02:42:22 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id f2-20020a7bc8c2000000b003fbc30825fbsm15474332wml.39.2023.08.23.02.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 02:42:21 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 23 Aug 2023 11:42:19 +0200
Subject: [PATCH v3] irqchip/qcom-pdc: add support for v3.2 HW
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230823-topic-sm8x50-upstream-pdc-ver-v3-1-aa7d9ab862e4@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHrU5WQC/43NvQ6CMBiF4Vsxnf1Mf6gUJ+/DOED7AU2ENi02G
 MK9W5h00vE9w3MWEjFYjORyWEjAZKN1Yw5xPBDd12OHYE1uwikXVHEGk/NWQxzULCk8fZwC1gN
 4oyFhAMYKjU0hkSGSbPiArZ13/3bP3ds4ufDa7xLb1n/lxIDB2ZRtYUwlS1ZdH3asgzu50JGNT
 vyT4784njlBhWyUEUq15Re3rusbNQNp3xoBAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4885;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=pGCvEuAQf4Wtnhnfu01EFnKLE/Dky2D/o9TjIlHw2RY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk5dR8Ta/CGP83KZTnV1mb4sRZtnk7a837bx3oXiit
 81iNXhWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZOXUfAAKCRB33NvayMhJ0QwwD/
 9U1aCRj0wdXVpiISjGFNHY39ygbIw4JS93YyTYdWEVY39iCqaRjTqPFxMtcfysDKJ100rHGWhrcvTt
 DeVmVuSFWFSVrOoxmqrYOBptb0LhOyG4ajhuZYQAS/XOTN37atX1bxIEnKQFgNDIGzKVID+zmNQ1ee
 k5AUbomHSyAMJVu0+93iktLk+EGy89sWuPiGFFAr4SPkFyUcvkU0cvJOS+tN0NDn8cBjSD0DDJuj0z
 Ayy75F/n/KvQzd2wLy7+t5eD/Fq0R55ExuvZup4tAzCiGEQDOR+/RNninsT43KelWgOimPle5p5e3Y
 OzsZgj3KstJntnBCFMmvaDOjFYdnWvO2qMI4hzFp55JOCZ/j1RNCV7n1zyyoMrL6ZSx2Pv/d6nRbnL
 EEAe1POP99UMdjScQhP0dDU1kYRKnApfPp7AhuI4fqzJU3Za3RNzoieR4xHOOno90PqdRhHQXy0QYR
 b8SC2B95hCMO5iMFwKczq77XloEj8XnYXVbux+38/qiupqxiRpS9PuINozyIaDjdbXfGHVu+CYz/R+
 Vrv3Y4M/tA23AWdguOUdZ08F7gH0RXzwS6tmPJ7qeW0IzVGHJQGuL/ugC99Xg9QY7foWd4EFt24WNy
 ecOdOYBBi3N2gUcRJNGJu2JZY5HeyxqESTCsIg/WGkhM70PVYgOYf8FgdsJw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Simplify qcom_pdc_gic_set_type()
- Used __assign_bit in pdc_setup_pin_mapping()
- remove BIT() from IRQ_i_CFG_IRQ_ENABLE to be used with __assign_bit()
- Add Reviewed-by tag
- Link to v2: https://lore.kernel.org/r/20230822-topic-sm8x50-upstream-pdc-ver-v2-1-3035b8d388f7@linaro.org

Changes in v2:
- Changed IRQ_ENABLE handling based on Maulik's comments
- Link to v1: https://lore.kernel.org/r/20230821-topic-sm8x50-upstream-pdc-ver-v1-1-6d7f4dd95719@linaro.org
---
 drivers/irqchip/qcom-pdc.c | 61 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index d96916cf6a41..5f60a23686c9 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -23,9 +23,22 @@
 
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
@@ -38,6 +51,7 @@ static DEFINE_RAW_SPINLOCK(pdc_lock);
 static void __iomem *pdc_base;
 static struct pdc_pin_region *pdc_region;
 static int pdc_region_cnt;
+static unsigned int pdc_version;
 
 static void pdc_reg_write(int reg, u32 i, u32 val)
 {
@@ -54,15 +68,22 @@ static void pdc_enable_intr(struct irq_data *d, bool on)
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
 
@@ -143,6 +164,7 @@ static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
 	}
 
 	old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
+	pdc_type |= (old_pdc_type & ~IRQ_i_CFG_TYPE_MASK);
 	pdc_reg_write(IRQ_i_CFG, d->hwirq, pdc_type);
 
 	ret = irq_chip_set_type_parent(d, type);
@@ -247,7 +269,7 @@ static const struct irq_domain_ops qcom_pdc_ops = {
 static int pdc_setup_pin_mapping(struct device_node *np)
 {
 	int ret, n, i;
-	u32 irq_index, reg_index, val;
+	unsigned long val;
 
 	n = of_property_count_elems_of_size(np, "qcom,pdc-ranges", sizeof(u32));
 	if (n <= 0 || n % 3)
@@ -278,11 +300,22 @@ static int pdc_setup_pin_mapping(struct device_node *np)
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
 
@@ -300,6 +333,8 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
 		return -ENXIO;
 	}
 
+	pdc_version = pdc_reg_read(PDC_VERSION, 0);
+
 	parent_domain = irq_find_host(parent);
 	if (!parent_domain) {
 		pr_err("%pOF: unable to find PDC's parent domain\n", node);

---
base-commit: 47d9bb711707d15b19fad18c8e2b4b027a264a3a
change-id: 20230821-topic-sm8x50-upstream-pdc-ver-114ceb45e1ee

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

