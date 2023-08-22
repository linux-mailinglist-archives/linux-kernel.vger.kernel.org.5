Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6A4783BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjHVIcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjHVIcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:32:07 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF9319C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:32:01 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso40171385e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692693120; x=1693297920;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EXkjIbY5l/9S6/JbVYWUW6L8c/zWvFMNfQTM7FW2Gl0=;
        b=auQW/FQCMtisrEbYEV2z/lH5+M43FTUoKbVgVqCPjNPsCBFxRX+kJMT8f+7p7YnSn6
         YhoWbHoPp7iNTcrvCl9KtiDujApx0ST61HT+ijHJYDg98pUnpOA3TvmjDaHwx4gSlLJz
         TGcwIqu3L7SiKTojH01auXXojcOBNs7f6QBp/L389x5axjVdt35sT0TUTHN4LGPiqelR
         I6ptyuV30dKrhvEv4K+efwfwok0435aUOMAcpyM9mpExpGhxq6Jx1LCTbDJ1TI1B47Dv
         BZ0D3QweQAPvrxJq552HdrIyh2VYDMmd6Y/XNiYLdLvHv6TZXdrWe47qyrpxCIg7Ed6i
         3WjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692693120; x=1693297920;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EXkjIbY5l/9S6/JbVYWUW6L8c/zWvFMNfQTM7FW2Gl0=;
        b=VNEoZ+Gc98+5o3vJ7U6yb2EhnzSYA95JK3VtVBWhFK5znyjRpDz1Gi2jMKSe+TBE1I
         L/CFjvZAbfrE67uP5Us5bAAxz4jPEI/wZEsBno0rdk3rBhmcSkTchHCXT8xk7rtNkpDv
         LHozckJvWKn8UqiPZhdDx/mm/Raz/RXlBBPvrSXGmSt9/kkOy2e8rxL+ZoTlMovYlEVD
         aPyyNXXSOkzcr9Vv4/Dp/RstKAUXkOLy0IA37a5z87/dIQ6AzOAY72EskDHbiuwMbKmw
         GqdUW7DheIG0FrawncGcPL7eypCPy1WQpq+sJX1eiy5kfT6UglwLLliDla/G6lhu9WCx
         nWWw==
X-Gm-Message-State: AOJu0YyrzuCKocB+WbRQft877/Tp0l61pkSJXa2uh8rSqJNJqe8yHwnM
        OvIKY+wsAGdea71jTP2ASu5vbA==
X-Google-Smtp-Source: AGHT+IHjCRoDZ+EcAOkMdv8PaVR5ge08aE3QDDzwpZVeqqw67yyog7U6uINC3s1jz5xDT0MfKn8hiw==
X-Received: by 2002:a1c:7508:0:b0:3fe:dd91:b5b6 with SMTP id o8-20020a1c7508000000b003fedd91b5b6mr6896662wmc.25.1692693119690;
        Tue, 22 Aug 2023 01:31:59 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id o17-20020a05600c379100b003fe26244858sm13855279wmr.46.2023.08.22.01.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 01:31:59 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 22 Aug 2023 10:31:53 +0200
Subject: [PATCH v2] irqchip/qcom-pdc: add support for v3.2 HW
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230822-topic-sm8x50-upstream-pdc-ver-v2-1-3035b8d388f7@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHhy5GQC/43NQQ6CMBCF4auQrh3DVBBw5T0MC2wHmERoM8UGQ
 7i7lRO4/N7if5sKJExB3bJNCUUO7OYEfcqUGbt5IGCbrHSuL3mtERbn2UCY6rXM4e3DItRN4K2
 BSAKIhaFnURISqdTwQj2vR//RJo8cFief4y7ib/23HBEQrrbqC2ubssLm/uK5E3d2Mqh23/cvy
 u4dgcsAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4837;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=M4zq4I72Pu/EzMN12jPssnMJXZPkFWprZ1H2q2KPwNo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk5HJ+068sWmCY5L/BpcHVyg0+SfbP/XPChR/d93S/
 MVnqfZGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZORyfgAKCRB33NvayMhJ0R7pD/
 9+GTBFw6qHbNRmVibfPsXzIxFdLr2Jt03wMzja2+DrVLmKHszqBz4N8c5kDIXFsVFwTFRKZre6JA8c
 RMhjqEScQWaUOLsnIth0iEzKJWLxxAImoFdiEd0T4G8URWFbLvPvTGroOItIoKJV3mShhPC1zIMkmf
 p1WtIornR+je8tHunOPuDP2eTq82mi1tTSll5yBO3XZLxL0f2iIDez58TPCIrZGd1i6Ufp64hoP5Ug
 kdl84l4n7nVVLssA2i1llG2CrrCCRtLUmqbh3j7HFyL6MDDJGYo+d318EKMaLL00XhiAyEJgXIaQeE
 ymZpyx1KNawRkhBra0Fb4Aoyjkq1zNE4jtzdfps9YQiVuwrD3jNfbaxy+xCOE0EW48dpCkiOkgc93H
 qirMyI6UynWgdaGQ2PnOU5LYyfCduMG4FKvthho2igs14RT4D/fO+/EKcN9rZwROupnUQ9pmLzsCIT
 bQ+Sopsrv4zH3FvOwWMCVY8pfspoCaOG6i5xBRWNRO4f3a4/BWbEy0SqDQJSXZFXCm9MTaDRga0enc
 pJmucKMXpZZsRBPgEgwdQZzqQVBdbD47py47VYrz3l8vr+IxtvIrCL3ayJgSPNZfvniagISMvHZi6q
 siF+M2inuLYYgf/cF4sb7NqbpvmBwsJlaV53rSIvJfsVwewWY3Js+87Ww45g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Changed IRQ_ENABLE handling based on Maulik's comments
- Link to v1: https://lore.kernel.org/r/20230821-topic-sm8x50-upstream-pdc-ver-v1-1-6d7f4dd95719@linaro.org
---
 drivers/irqchip/qcom-pdc.c | 73 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index d96916cf6a41..010a499ecd88 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -23,9 +23,22 @@
 
 #define PDC_MAX_GPIO_IRQS	256
 
+/* Valid only on HW version < 3.2 */
 #define IRQ_ENABLE_BANK		0x10
 #define IRQ_i_CFG		0x110
 
+/* Valid only on HW version >= 3.2 */
+#define IRQ_i_CFG_IRQ_ENABLE	BIT(3)
+
+#define IRQ_i_CFG_TYPE_MASK    GENMASK(2, 0)
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
 
@@ -142,8 +163,17 @@ static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
 		return -EINVAL;
 	}
 
-	old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
-	pdc_reg_write(IRQ_i_CFG, d->hwirq, pdc_type);
+	if (pdc_version < PDC_VERSION_3_2) {
+		old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
+		pdc_reg_write(IRQ_i_CFG, d->hwirq, pdc_type);
+	} else {
+		u32 val;
+
+		val = pdc_reg_read(IRQ_i_CFG, d->hwirq);
+		old_pdc_type = val & IRQ_i_CFG_TYPE_MASK;
+		pdc_reg_write(IRQ_i_CFG, d->hwirq,
+			      pdc_type | (val & IRQ_i_CFG_IRQ_ENABLE));
+	}
 
 	ret = irq_chip_set_type_parent(d, type);
 	if (ret)
@@ -247,7 +277,7 @@ static const struct irq_domain_ops qcom_pdc_ops = {
 static int pdc_setup_pin_mapping(struct device_node *np)
 {
 	int ret, n, i;
-	u32 irq_index, reg_index, val;
+	u32 val;
 
 	n = of_property_count_elems_of_size(np, "qcom,pdc-ranges", sizeof(u32));
 	if (n <= 0 || n % 3)
@@ -278,11 +308,22 @@ static int pdc_setup_pin_mapping(struct device_node *np)
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
+				val &= ~BIT(irq_index);
+				pdc_reg_write(IRQ_ENABLE_BANK, reg_index, val);
+			} else {
+				u32 irq;
+
+				irq = i + pdc_region[n].pin_base;
+				val = pdc_reg_read(IRQ_i_CFG, irq);
+				val &= ~IRQ_i_CFG_IRQ_ENABLE;
+				pdc_reg_write(IRQ_i_CFG, irq, val);
+			}
 		}
 	}
 
@@ -300,6 +341,8 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
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

