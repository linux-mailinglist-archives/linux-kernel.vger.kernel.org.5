Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E047FA544
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbjK0Pwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbjK0Pw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:52:28 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9979FD59
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:52:34 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a04196fc957so640501566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701100353; x=1701705153; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nr05hrGkuwY0DK8aGF98uretWKGuiZWVGVkXoVNznFQ=;
        b=hEJ9T6vlLFeLoKzEN9giyFjhRxFnttJoX9wqPfCkc4i35yb9e0C34LSYvT1XwY1CP8
         /Qch3PeMq6QYMqgCvqxPfDaFirpq+p6pQq+1RjYwAsWRC0qjf3YJ2VWlpsu1ULe4TXsV
         gdy7OJANGa+7/iggFyg8oq18s6WLgmSp2meivvwUtfSVKWHCOrOY1/kpOIqDTr1bgfRB
         HiAMH3JWEnBKqYr0exaDmLyhWCzWpV67G7tZBQ4e2EYTj0SN7R5mMGfdEA0Zs/ViKSuG
         H7YAGfgGXxEJRmNPGp4peaJah6PlQNTQQ2jXNFbMrBjkE168vpzJypSVEKf5mvzY+WFz
         L0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701100353; x=1701705153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nr05hrGkuwY0DK8aGF98uretWKGuiZWVGVkXoVNznFQ=;
        b=v7k/29jxCK4HvsLLQuxukfLLMXo/f7f0cVI/UqXlCwr5DtRyqPHZirpsQWOs40Z2Xt
         LWw1WGSBAIujlmz2Aq0LDLt+9wer7FeY48ND4aJrY+ooDFC3PuJyKqLoVswnGduGWoYO
         Prl/vgdBVcb1DBbg/2VATNjo21B8+MU3HCbHX+rUcENme2e93ZO2GojH1vJfBl+3JzXZ
         CxffgYa+RVLZxwE+sFgOLf5UNyy74DXq9P+MiSWM/i5iG0cz6Y2gGWTfQWVt9XHO4l1b
         dLAX3JGRnzyaJA6JqjtpeZ8leN2nlgsc86aC8WeAf+n0+mrwxNO+oluEPMK+1kaceZtG
         JnIQ==
X-Gm-Message-State: AOJu0YziRLY6rRgOO906NaF1ZFU08qTZliN0oz/Ki8xtfEbO+m0GJfSb
        LYF2k5jGy8VN2awsQauEto1/Lw==
X-Google-Smtp-Source: AGHT+IEkZqbakDX6RaUQMrgNoB1fjuVjSjnDF0xLT5VTu9acxiYeOJPI7DIGLRk8T+aAMsn2tYqiwQ==
X-Received: by 2002:a17:906:66c1:b0:9ff:77c2:e67f with SMTP id k1-20020a17090666c100b009ff77c2e67fmr8380126ejp.33.1701100353110;
        Mon, 27 Nov 2023 07:52:33 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id mb22-20020a170906eb1600b009fc0c42098csm5855150ejb.173.2023.11.27.07.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:52:32 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 27 Nov 2023 16:52:13 +0100
Subject: [PATCH v7 2/2] irqchip: irq-qcom-mpm: Support passing a slice of
 SRAM as reg space
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230328-topic-msgram_mpm-v7-2-6ee2bfeaac2c@linaro.org>
References: <20230328-topic-msgram_mpm-v7-0-6ee2bfeaac2c@linaro.org>
In-Reply-To: <20230328-topic-msgram_mpm-v7-0-6ee2bfeaac2c@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701100347; l=2888;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=xv+mWCEly/nIv85AR5MmmU/wkLvnOBn7Ei5h/U9JNy0=;
 b=d0wDKn96S5wPzxqpjV9SfTtHRQKUGg0oVkzShzFNVW58PHwEZQNEFHHiBEflYbkWgBSJY96Bo
 dermZgeioXjBYae0UzHuHrS04+dp0cFDYzidoyvkZUuBtBTXjCOdJO1
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MPM hardware is accessible to us from the ARM CPUs through a shared
memory region (RPM MSG RAM) that's also concurrently accessed by other
kinds of cores on the system (like modem, ADSP etc.). Modeling this
relation in a (somewhat) sane manner in the device tree basically
requires us to either present the MPM as a child of said memory region
(which makes little sense, as a mapped memory carveout is not a bus),
define nodes which bleed their register spaces into one another, or
passing their slice of the MSG RAM through some kind of a property.

Go with the third option and add a way to map a region passed through
the "qcom,rpm-msg-ram" property as our register space.

The current way of using 'reg' is preserved for ABI reasons.

Acked-by: Shawn Guo <shawn.guo@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/irqchip/irq-qcom-mpm.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
index 7124565234a5..cda5838d2232 100644
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

-- 
2.43.0

