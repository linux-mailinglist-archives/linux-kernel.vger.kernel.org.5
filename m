Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B41775DC2A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjGVLzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjGVLzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:55:07 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0243B35AD
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:54:50 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fc0aecf107so22174865e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690026889; x=1690631689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjYyx1DOBe25+JK0YNsnvu9lLSFEE0N2YMpAouIlyww=;
        b=C+TT7ZqGhAhjvW9XCQGZwb2gl5+vD14Jy8uq2oZSlz1LmbGcRH4HVqlRbJ7yx0vi+L
         d3o47Mw6VkqltdTx5xSm7yZqpyGvkPkvtkzk1Dno6M81vIm00sagL8OyBwyYLsjQOspI
         ZNiqhohXFXHwovf6TVkd1eBhJwA9S4qKMD6xnO+YWT9XRKQjrVO5XJhpJh52U1rHV9fN
         DCNc8tnmfzNRtHx6GJ1VQ88vcIFKoAeRz6zI5lam2axHjBH1G8DOvwNv/cy/MVRLfsyK
         hNn2ufh72RwpLDpiZxjWMpv5Iw+tt0uacRFE/0reEUBByjLI+/Zplq/mdFgbCHWUeiWl
         IbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690026889; x=1690631689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TjYyx1DOBe25+JK0YNsnvu9lLSFEE0N2YMpAouIlyww=;
        b=f/l0d832akPFasJjXfK/YqrZVtKllmkg2niGGgbRLclJMl0sda4gmxsf4iWFo8HIz6
         /J+7exa7/5oHzDIB4GpndrduoQBktwkcyWNUV9XkAlopD9xARyjsuNadIfLhuue5X0aa
         4OWStVbP4SQhHBK0/g/+TB989YoTgZ9xKZ3vyc/m2b7WTgXTIIQs1jXPJcmbEu0ho0H+
         Mg6uYHtU7RtZerOhh1AlEUDuvM8gSEE6hMfOcDuEEQh5ZbcosYXs3WRRHIZpeFmIKGqY
         NlGeCSpYNpDZPmv8GW1MmzwZKUdom6ewlkvxYRPFbWl2ftqwvnEMj47zu83+t0bdnVL1
         RCzA==
X-Gm-Message-State: ABy/qLbtF/ngrZfEgX/pGxk07BIpooW30K+3m6W/aTlrgnIMNp5B9Hqn
        Tc7JOYtP8IjVVbNkLcb2yLXKag==
X-Google-Smtp-Source: APBJJlEY3agtFHJh4XCfK/uXpCdvf1iQR+GPgbF18fSP6kHTWhHUnR54yznZ7cTxiGoOGLpivrEACg==
X-Received: by 2002:adf:f848:0:b0:317:18a8:5fa1 with SMTP id d8-20020adff848000000b0031718a85fa1mr2615312wrq.69.1690026889447;
        Sat, 22 Jul 2023 04:54:49 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id o8-20020adfeac8000000b003143b7449ffsm6726496wrn.25.2023.07.22.04.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 04:54:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] media: exynos4-is: fimc-is: replace duplicate pmu node with phandle
Date:   Sat, 22 Jul 2023 13:54:41 +0200
Message-Id: <20230722115441.139628-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722115441.139628-1-krzysztof.kozlowski@linaro.org>
References: <20230722115441.139628-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devicetree for the FIMC IS camera included duplicated PMU node as its
child like:

  soc@0 {
    system-controller@10020000 { ... }; // Real PMU

    camera@11800000 {
      fimc-is@12000000 {
        // FIMC IS camera node
        pmu@10020000 {
          reg = <0x10020000 0x3000>; // Fake PMU node
        };
      };
    };
  };

This is not a correct representation of the hardware.  Mapping the PMU
(Power Management Unit) IO memory should be via syscon-like phandle
(samsung,pmu-syscon, already used for other drivers), not by duplicating
"pmu" Devicetree node inside the FIMC IS.  Backward compatibility is
preserved.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../platform/samsung/exynos4-is/fimc-is.c     | 33 ++++++++++++++-----
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-is.c b/drivers/media/platform/samsung/exynos4-is/fimc-is.c
index 530a148fe4d3..c4c191771093 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-is.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-is.c
@@ -767,12 +767,32 @@ static void fimc_is_debugfs_create(struct fimc_is *is)
 static int fimc_is_runtime_resume(struct device *dev);
 static int fimc_is_runtime_suspend(struct device *dev);
 
+static void __iomem *fimc_is_get_pmu_regs(struct device *dev)
+{
+	struct device_node *node;
+	void __iomem *regs;
+
+	node = of_parse_phandle(dev->of_node, "samsung,pmu-syscon", 0);
+	if (!node) {
+		dev_warn(dev, "Finding PMU node via deprecated method, update your DTB\n");
+		node = of_get_child_by_name(dev->of_node, "pmu");
+		if (!node)
+			return ERR_PTR(-ENODEV);
+	}
+
+	regs = of_iomap(node, 0);
+	of_node_put(node);
+	if (!regs)
+		return ERR_PTR(-ENOMEM);
+
+	return regs;
+}
+
 static int fimc_is_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct fimc_is *is;
 	struct resource res;
-	struct device_node *node;
 	int ret;
 
 	is = devm_kzalloc(&pdev->dev, sizeof(*is), GFP_KERNEL);
@@ -794,14 +814,9 @@ static int fimc_is_probe(struct platform_device *pdev)
 	if (IS_ERR(is->regs))
 		return PTR_ERR(is->regs);
 
-	node = of_get_child_by_name(dev->of_node, "pmu");
-	if (!node)
-		return -ENODEV;
-
-	is->pmu_regs = of_iomap(node, 0);
-	of_node_put(node);
-	if (!is->pmu_regs)
-		return -ENOMEM;
+	is->pmu_regs = fimc_is_get_pmu_regs(dev);
+	if (IS_ERR(is->pmu_regs))
+		return PTR_ERR(is->pmu_regs);
 
 	is->irq = irq_of_parse_and_map(dev->of_node, 0);
 	if (!is->irq) {
-- 
2.34.1

