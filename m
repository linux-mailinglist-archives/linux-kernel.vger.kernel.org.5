Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D1E792696
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347947AbjIEQSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354656AbjIENTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:19:38 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4F9A8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 06:19:34 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-401c90ed2ecso25351035e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 06:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693919973; x=1694524773; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bFm9u9Hv8OXtmo1dt6895te05YHWjgyt8hUFfQteBkM=;
        b=pnxaFouqpfiziTfXFG3tRwZQd4V/WqC53Fyvw1hSI0B5P+j7LRDHFLQLFvTvlYQLYt
         DFbjCaLa9krs5F0InpwDrgHKdWLta69jk/X+gIIWiZgMbP26q4o5EXX4boWP3lU9ATIH
         fDEtq20zZCiUfqftgOHrMAgpuLMkc5JcpMRCqpW3KK9ju2i7+u6nnFo24MKbZDy4MTNc
         SXvdpDn/TXJu3yT+qBWCWNrNK6ipciIybg5G1J7N5i/zNPImj5JKbZpaAC2YObP1dGJp
         cri/jHck031tTSDEAKmPHvGoLRfz3wlbe1u9jMYKB4j/D7fdtcsCMjesiqFJPbh/lTur
         y6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693919973; x=1694524773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFm9u9Hv8OXtmo1dt6895te05YHWjgyt8hUFfQteBkM=;
        b=FV7d2BV3U7x+6KKWH1bZL6uFXn2oVYRsik20XfqWvZGEeAzw7PeMkw3dpQZbm3Uyjq
         0vMii+NGDpiaNhKvH+nv6hR/i4JLfyZLL94d+ux7VKMPmxQRPDcbywS6MjDUhLXNgU0S
         Agwse0d9H4D9dPnUDY8i6tiAnOFZkAr504wgmxXqzwRjnFSE3AzUjTP7tSI7+IcRJ711
         sb8s+cZmYC21/aDLvvNm3xpTDZLaZhuwYg1GTYVw0lp1aQCCbtC14gtrcTYPeioYym3G
         4PwFl9g7rXtlDS2BHP9lbUgZvh8acdwbK+WJjWh9udK1B5Tm80nTRjfoI6MGMO+P00Wr
         Q6lw==
X-Gm-Message-State: AOJu0YxBw8YmGNW/HnZ7q4DJkRIKGabj1+I93qGOq9Hxd9YwVrlhvVjD
        Ni8NW+AqKuKcqpHR53Nh+dA3cg==
X-Google-Smtp-Source: AGHT+IGaTTmq61riWGp0vPVsuMCfeiJKrzSrLmTheAu3n7MlWHOGXyiQ47dOJKaZ6qK8czU/Tzg3qQ==
X-Received: by 2002:a05:600c:2488:b0:401:b7e0:a43c with SMTP id 8-20020a05600c248800b00401b7e0a43cmr9243576wms.24.1693919973243;
        Tue, 05 Sep 2023 06:19:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id s5-20020a7bc385000000b003fe61c33df5sm20131063wmj.3.2023.09.05.06.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 06:19:31 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 05 Sep 2023 15:19:25 +0200
Subject: [PATCH v4 1/2] irqchip/qcom-pdc: Add support for v3.2 HW
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230905-topic-sm8x50-upstream-pdc-ver-v4-1-fc633c7df84b@linaro.org>
References: <20230905-topic-sm8x50-upstream-pdc-ver-v4-0-fc633c7df84b@linaro.org>
In-Reply-To: <20230905-topic-sm8x50-upstream-pdc-ver-v4-0-fc633c7df84b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4743;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=wnDNCH+ru23Wpd8TKpiBit3B5o5d0Wx8xlwy9+8+3Gw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk9yrgNg+cfIFo/J+FTvHE4HFk0iGFE1RE0vIua1ht
 TMRDBtCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZPcq4AAKCRB33NvayMhJ0cs8EA
 Cae2tLgmbJvARb5Bg3exVjlCOVEuilOne6bsM85/3gC/wNl8RLY1EYDGkSBr88gmhZmuKRSUNfAsIa
 scr5Cl5gI7/HXPwhyq9KWOjq6R6R1EvQWPDplZh2pTKUJf7hAM+fhHbw3aD30Q/e6lkMtPQIQ51rHj
 vcCvhW9zsJIRG1tduVnXYsgFcuqsdNTrVUfRTeWt1iXOzDtDPeyF9x1tdk2eyeLSPpjInPKsKZicuf
 Qf1ywzrjnpNRHjzNPKwMwNCBwnZJxfdHQNI8+TpxkI9CIdjcPMwVHvrnoQNPs4ns/GO1QdS2YuXqwi
 XoDJt2SHZoYgGn96rKUlaTwwYDgJyvlQ8mo/hIxogJxlKEZoy+MIouux8UOKYyXTpRpV4YjupfRivJ
 CQr6RU8PCbyex2gp0bHP3MhATXu8aH2PskkR+CBmzDkCakNVrkZtD73XAHKad1g47iEJ3QYHgCoPnM
 GPl2K4UB6Q8Hqf2FWMRANRf+0FQOt8VvWXcHx4LscB+S42qb3upMmToCe4QmKoBaHtVyo8UJ3M8u3v
 Ce/qzScTw21iIknmL7F+C65ptLVlQEE09rEBScoRS6eZf8PafxF7uSV217vsQTA4zjBZb/DqTC5g0I
 FB6Ai8vSuVlppeefKT9lTBz6ZC1OOjkRAwx2LbFVVpbUKdEXRg/HKskZmpeA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Maulik Shah <quic_mkshah@quicinc.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/irqchip/qcom-pdc.c | 69 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index d96916cf6a41..827371726ad1 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -23,9 +23,20 @@
 
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
@@ -38,6 +49,7 @@ static DEFINE_RAW_SPINLOCK(pdc_lock);
 static void __iomem *pdc_base;
 static struct pdc_pin_region *pdc_region;
 static int pdc_region_cnt;
+static unsigned int pdc_version;
 
 static void pdc_reg_write(int reg, u32 i, u32 val)
 {
@@ -49,20 +61,32 @@ static u32 pdc_reg_read(int reg, u32 i)
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
 
@@ -143,6 +167,7 @@ static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
 	}
 
 	old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
+	pdc_type |= (old_pdc_type & ~IRQ_i_CFG_TYPE_MASK);
 	pdc_reg_write(IRQ_i_CFG, d->hwirq, pdc_type);
 
 	ret = irq_chip_set_type_parent(d, type);
@@ -247,7 +272,6 @@ static const struct irq_domain_ops qcom_pdc_ops = {
 static int pdc_setup_pin_mapping(struct device_node *np)
 {
 	int ret, n, i;
-	u32 irq_index, reg_index, val;
 
 	n = of_property_count_elems_of_size(np, "qcom,pdc-ranges", sizeof(u32));
 	if (n <= 0 || n % 3)
@@ -277,29 +301,38 @@ static int pdc_setup_pin_mapping(struct device_node *np)
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

