Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A22754967
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 16:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjGOOhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 10:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjGOOh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 10:37:26 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E85BA
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:37:24 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fdb3f66fd6so613977e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689431843; x=1692023843;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZHiNhlcnBcV/12CBhpoH4NhL4fdNzTRpHhX759efoE=;
        b=BsY8MQ0xvz96CZJKR/sx45m0/u2jh9C3oJWJLlgU3qjeOWlNVuW6zlX4hr9GmoQgki
         3XEaHj5F+wy8RhpKBHkM7pUBm3k4watAYcITYdzE7shshGHzHItKBULY3LzIlGTo3cYe
         VVpDEXzYvIj2sD4wNaP7yPqCreFJWx5iHOuuzYSU8UyJie4KR/9fgB1x4+Az8MvtOzOE
         n0kJzzNjt5CSOJ6yMovlqIEXkD8wSeBWqPyL684SgmxMyC3n0Bv/uYOhP6oUFaiFbfdN
         jRXc6sD/qWXDPR43xjVnA0CIfqHLHQLy/kTIIo0W2gA683TsLHcQ3bJlACCRw/lf3REz
         JIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689431843; x=1692023843;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZHiNhlcnBcV/12CBhpoH4NhL4fdNzTRpHhX759efoE=;
        b=e+AvjkRw1WvfBrKdhRPadZujS7LA1rddM/TDatRZuEGFCvfFpwijpyu2wmCCrPRG4u
         zFVw0jHUTMItJDV1djft59YEjCfMZwu65I5acs34qU+mKQw4bZwIznjRD48vrUWp+s4Z
         p0vwMXDe+63jZzN0sHZOvIKGaW2vOr0Afwkm1azt0FaPtPmwh6gdJoGql42waNYO2IB1
         yw+T6IrdwFA1YaRnmGhCXRCDVSes/QFcIX0HnY4RsPBtg90u80GQjCO/ZkoDrsVTRzAv
         /ORUBMRGIwL1qbFk0VHHJ2/MPoTOtYQWO1md61wvs1Y6SXGyC2pWQr0M5jke6gOlgTew
         UYCg==
X-Gm-Message-State: ABy/qLbsf9Hdtx6nvAJslIkvy1Ro+SOKGxT2mDtdnuY9Ls4XMH0E6MOk
        l7n0JG03JfzneR84/YtCGR5FnA==
X-Google-Smtp-Source: APBJJlF9vTYb38fDN2cl5WXmv3evgsk3uBu/K0a+eFf9xPi1G9rQcU3ZmIisL82IgPPGt0KdLoJFvg==
X-Received: by 2002:a05:6512:1047:b0:4f8:70b0:eec6 with SMTP id c7-20020a056512104700b004f870b0eec6mr6186944lfb.28.1689431842878;
        Sat, 15 Jul 2023 07:37:22 -0700 (PDT)
Received: from [192.168.1.101] (abxi167.neoplus.adsl.tpnet.pl. [83.9.2.167])
        by smtp.gmail.com with ESMTPSA id 27-20020ac2483b000000b004f858249932sm1927732lft.90.2023.07.15.07.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 07:37:22 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 15 Jul 2023 16:37:12 +0200
Subject: [PATCH v3 2/2] irqchip: irq-qcom-mpm: Support passing a slice of
 SRAM as reg space
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230328-topic-msgram_mpm-v3-2-2c72f27b4706@linaro.org>
References: <20230328-topic-msgram_mpm-v3-0-2c72f27b4706@linaro.org>
In-Reply-To: <20230328-topic-msgram_mpm-v3-0-2c72f27b4706@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689431838; l=2751;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=yQx/+qerpXC0l+cy+Ejk8gpdBKyKLvnTn9FYud1Txtk=;
 b=szGuRyKgIllLGEGjGUWBYEelsIFHCREhm0PjQzBAVd4lOmpKRU1A29kDL5kw7XOvz7H87kCpy
 ZfQpQPJiHweDDXeQ1mH32MHmq7iNL/jUgQelWRHvrMIhOv8xPEJZKxD
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/irqchip/irq-qcom-mpm.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
index d30614661eea..ee5f39a4a42a 100644
--- a/drivers/irqchip/irq-qcom-mpm.c
+++ b/drivers/irqchip/irq-qcom-mpm.c
@@ -14,6 +14,7 @@
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_device.h>
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
 
@@ -374,9 +377,21 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
 
 	raw_spin_lock_init(&priv->lock);
 
-	priv->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
+	/* If we have a handle to an RPM message ram partition, use it. */
+	msgram_np = of_parse_phandle(np, "qcom,rpm-msg-ram", 0);
+	if (msgram_np) {
+		ret = of_address_to_resource(msgram_np, 0, &res);
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
2.41.0

