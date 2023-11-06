Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0497E1C47
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjKFIcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjKFIcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:32:43 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CF1BB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:32:39 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4083ac51d8aso32191355e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 00:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699259558; x=1699864358; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxlJw5UNV+rlgblcRjV4UgoJ4/zH+BZUAC88c6BgYGE=;
        b=UJzHza1cH+40NgqtjEP8bjny5/4Fs7S0MF4DzjTrcxYAWPwaCBhBDu1t/Q5hTyuYOn
         poTOOYZKyLjzk5/iTg4FoPZhyf4tlME9CDXnAEaoZ8e+lPL/bWOMJMHDqnGit9puhJmr
         khmF3X8jZSxTXUeo2eTfEjE0RYw5GVrUZzIasXO2GQku3XoRMVgX+GCbI2XqQ5UhxIJg
         eyR9s+ZCG1Hw2uLN2lXv5HTRfmzdznWm+bUdshZ0wVkI3lYvnTHDGHJXj0EQp+vqS3q5
         l/xIQVUAuhqD2SW4IvkMMzYLJ31K3ezONgoq2crdUjtM+FntWYEjWu/q8YwDWI3jEMo8
         ox8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699259558; x=1699864358;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxlJw5UNV+rlgblcRjV4UgoJ4/zH+BZUAC88c6BgYGE=;
        b=hhlAKXr7k09p7f9QJ1nzHGPft0/2nOZR2ziuyC1Lu4vkr6qI68ppNAS+CsXTEUxBm0
         Kq2drGdee2iW6vh6GSkOB8FyJnCIF1polCRIGL76RwDOGhNFWuS/HYPgJhuX7XPT4Agw
         +pG075xKRBvj8xzLM416PqQlARjhaFD3XLahYCbOH7Yw25sSjV36f2iJsQuyftVDG2DV
         W34y6NqgMHWz+0XhXwVC7A2QvQiiT0stYD5rET9t/Fb+VQgEf9h4zz/2XiyWbI7fRWtD
         sK20dkdKawZbPh6J8mZPUQp40fsD5v+vAyebf9X5LkVXYWnB2Sgb8MJgCYJHa+Ey0dkY
         8Atg==
X-Gm-Message-State: AOJu0YzS86RDMUomDQuEbBaLJnZWKPDB29VQVG0zh7AmbDX6ZhhTjYyS
        OpWB/drHqmmzYXWW11ARyL2QCA==
X-Google-Smtp-Source: AGHT+IHlhPDfHYoCblgJBJbZcgWsZFBtXRbsSfkMGUHQRsG91BMRDxDkpZ5ahdzrZi/51qQLLukiPA==
X-Received: by 2002:a05:600c:3502:b0:407:8e85:899f with SMTP id h2-20020a05600c350200b004078e85899fmr23326543wmq.16.1699259558292;
        Mon, 06 Nov 2023 00:32:38 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c020c00b004063ea92492sm11405241wmi.22.2023.11.06.00.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 00:32:37 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 06 Nov 2023 09:32:31 +0100
Subject: [PATCH v3 2/3] pinctrl: qcom: handle intr_target_reg
 wakeup_present/enable bits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-topic-sm8650-upstream-tlmm-v3-2-0e179c368933@linaro.org>
References: <20231106-topic-sm8650-upstream-tlmm-v3-0-0e179c368933@linaro.org>
In-Reply-To: <20231106-topic-sm8650-upstream-tlmm-v3-0-0e179c368933@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4470;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=nXfUF7+mDQza/JlKoXvW/NLuYwJxWqbFi2iOF/Gxevs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlSKSimT7GG484UX6Wh2GpNvex8PjVZoaqDMtzT7um
 G2151QeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZUikogAKCRB33NvayMhJ0URtD/
 9ko49hqyeYNN5ZKyMSVujrqeUSMsVvwErOvuRcsjKN/wA9E58Tt/5W2nPKH9fayw61ATYlGj96K0k0
 +KZWhRhXgUZ/1xsh4zJNc7/XwRkKXbXPWSH0RMTFvMcfbXBMlGZQs25++fHxvEJADIJkaG308rYpgY
 gaA8P/1HMehZuxNQpo3apSXdAi0MV3RRxh6t659STmvReUlo6ySWZwKfbaCpGmrFyy4/MPRRfx1zR1
 +m0exeDjPZIagjAGpdd3BTg+dKkY7ADm+RSuGD3MjRWs9lGi0Ciql67EKAxkOk5fMH/Wy2C/atJ8eM
 eN/nZDbOiKYOpaL6595yQaKT37Tj6tVFLhqgIUNMFLzPif4Q3s1eqMCbIj0zNFnkiEzPLX6oNH8hiA
 d0nhdNjo95t9BzcHNA71Wal/wTkZNsKL6+2VSpivTnEeM35jw532KnkIaHgAQUvtDyjriR69IgRf5U
 wasuJ9YeHsM69tKbm5cd2xxZHrKXYLk0jAyXAQkfV+mhtEtzSo/Q0uNIr79bvRuiTPyT/z7Wj6xE+s
 Jf6wsUy6GEwapYw7Sio0SG1fitni3FEq4rFhftai3Ojrv61xgkZO/F+vIJynpC32loSQ08yFMkG5wG
 m7Xj1goTjbB7Z5zQeDjgwSgnQBEHi1c+/BFYVSjrP5E9X4Bo3qqKSdf/opHg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New platforms uses a new set of bits to control the wakeirq
delivery to the PDC block.

The intr_wakeup_present_bit indicates if the GPIO supports
wakeirq and intr_wakeup_enable_bit enables wakeirq delivery
to the PDC block.

While the name seems to imply this only enables wakeup events,
it is required to allow interrupts events to the PDC block.

Enable this bit in the irq resource request/free if:
- gpio is in wakeirq map
- has the intr_wakeup_present_bit
- the intr_wakeup_enable_bit is set

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 42 ++++++++++++++++++++++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-msm.h |  5 +++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 395040346d0f..207b41018580 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1196,6 +1196,8 @@ static int msm_gpio_irq_reqres(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
+	const struct msm_pingroup *g = &pctrl->soc->groups[d->hwirq];
+	unsigned long flags;
 	int ret;
 
 	if (!try_module_get(gc->owner))
@@ -1221,6 +1223,28 @@ static int msm_gpio_irq_reqres(struct irq_data *d)
 	 */
 	irq_set_status_flags(d->irq, IRQ_DISABLE_UNLAZY);
 
+	/*
+	 * If the wakeup_enable bit is present and marked as available for the
+	 * requested GPIO, it should be enabled when the GPIO is marked as
+	 * wake irq in order to allow the interrupt event to be transfered to
+	 * the PDC HW.
+	 * While the name implies only the wakeup event, it's also required for
+	 * the interrupt event.
+	 */
+	if (test_bit(d->hwirq, pctrl->skip_wake_irqs) && g->intr_wakeup_present_bit) {
+		u32 intr_cfg;
+
+		raw_spin_lock_irqsave(&pctrl->lock, flags);
+
+		intr_cfg = msm_readl_intr_cfg(pctrl, g);
+		if (intr_cfg & BIT(g->intr_wakeup_present_bit)) {
+			intr_cfg |= BIT(g->intr_wakeup_enable_bit);
+			msm_writel_intr_cfg(intr_cfg, pctrl, g);
+		}
+
+		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+	}
+
 	return 0;
 out:
 	module_put(gc->owner);
@@ -1230,6 +1254,24 @@ static int msm_gpio_irq_reqres(struct irq_data *d)
 static void msm_gpio_irq_relres(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
+	const struct msm_pingroup *g = &pctrl->soc->groups[d->hwirq];
+	unsigned long flags;
+
+	/* Disable the wakeup_enable bit if it has been set in msm_gpio_irq_reqres() */
+	if (test_bit(d->hwirq, pctrl->skip_wake_irqs) && g->intr_wakeup_present_bit) {
+		u32 intr_cfg;
+
+		raw_spin_lock_irqsave(&pctrl->lock, flags);
+
+		intr_cfg = msm_readl_intr_cfg(pctrl, g);
+		if (intr_cfg & BIT(g->intr_wakeup_present_bit)) {
+			intr_cfg &= ~BIT(g->intr_wakeup_enable_bit);
+			msm_writel_intr_cfg(intr_cfg, pctrl, g);
+		}
+
+		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+	}
 
 	gpiochip_unlock_as_irq(gc, d->hwirq);
 	module_put(gc->owner);
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
index 4968d08a384d..63852ed70295 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.h
+++ b/drivers/pinctrl/qcom/pinctrl-msm.h
@@ -58,6 +58,9 @@ struct pinctrl_pin_desc;
  * @intr_enable_bit:      Offset in @intr_cfg_reg for enabling the interrupt for this group.
  * @intr_status_bit:      Offset in @intr_status_reg for reading and acking the interrupt
  *                        status.
+ * @intr_wakeup_present_bit: Offset in @intr_target_reg specifying the GPIO can generate
+ *			  wakeup events.
+ * @intr_wakeup_enable_bit: Offset in @intr_target_reg to enable wakeup events for the GPIO.
  * @intr_target_bit:      Offset in @intr_target_reg for configuring the interrupt routing.
  * @intr_target_width:    Number of bits used for specifying interrupt routing target.
  * @intr_target_kpss_val: Value in @intr_target_bit for specifying that the interrupt from
@@ -100,6 +103,8 @@ struct msm_pingroup {
 	unsigned intr_status_bit:5;
 	unsigned intr_ack_high:1;
 
+	unsigned intr_wakeup_present_bit:5;
+	unsigned intr_wakeup_enable_bit:5;
 	unsigned intr_target_bit:5;
 	unsigned intr_target_width:5;
 	unsigned intr_target_kpss_val:5;

-- 
2.34.1

