Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB96772533
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjHGNNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjHGNNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:13:08 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC6C10FE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:13:05 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-317f1c480eeso321347f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 06:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691413984; x=1692018784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiXOG4vhE2jwuThX92Y67MrIjgQpotVRhoEdfPPU/2s=;
        b=UJfvJt5AU+IWVBtlv78t+VTZeFaFm00LqJqWR6xVo2ENDxmCWPoNpDsLUjcv+1pevw
         w8N1ygAfMf1wUreBI0q5hYIpPFbnj0xcsFLV/hR/9CsUZiHntmTPIa0AsycPVzGqf6oM
         72pp2uoiuXa7/jvaq3N9pgijqiVWgRBNDKUQyeiwk4aejKIR6N5Sq32SKfjwJyKrAhSJ
         +kSW12teQ1KrwbZZVGReE1tZ3pdcFx1MlbaMggxbFhSaOk/WIOXEO62sM1gmdGWEoXxx
         KFSzaBQe9gSvN+VFZioCg50Y1flr8gKMBc4GsR21Bj3kCjDA4OSrVmydpmxlMawYF7R9
         acPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691413984; x=1692018784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DiXOG4vhE2jwuThX92Y67MrIjgQpotVRhoEdfPPU/2s=;
        b=IYr26rJxeb/qP9WlzXRwStchFw50rvQgFtipUQTVraKxckBnpWDDfTtkMzTKEl2f2i
         KbsswidUIILzLYNcl1kKr1KC2JhXmzBd45BjKUvwDlTIi+EZElQ4xJh1lLJgoiXIAjj4
         nPix6c2v1HcxZPCusi7vN1qcflTcrCuqKxQ5KssARwtWp93Ox4C53VAyE3qHbOYxTo4O
         QuSKxlk+KPrazlQ/UaJ4Vkyoph08On63l+pu4Dy3znA2kun1lB+u/5vhIsz+FtOf+Bfe
         mvJ/65AA0dO3//hNkyJE6OjsgBbSjuW8yUKb1AJevwo8jk7+z1AwiPj+s8a108sbqp7L
         E1SQ==
X-Gm-Message-State: AOJu0Yyb1eaSh6G47WDYR6j9MbqqhK2s2eCzJgWbRJxAVugWwTtH6kGP
        8KBz0xOF1JFFU4rboEmBVfQ/6w==
X-Google-Smtp-Source: AGHT+IFXmkHi/GyFHO/Dj22/JaKLB4zDYDFzdrLabGBvKpZLyAuPYzzGT1BWtYB6OUccvHdm2ZcjbQ==
X-Received: by 2002:a05:6000:10a:b0:317:5b99:d3d7 with SMTP id o10-20020a056000010a00b003175b99d3d7mr5036961wrx.34.1691413984192;
        Mon, 07 Aug 2023 06:13:04 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d4489000000b0031411b7087dsm10618428wrq.20.2023.08.07.06.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:13:03 -0700 (PDT)
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
Subject: [PATCH v2 3/3] media: exynos4-is: fimc-is: replace duplicate pmu node with phandle
Date:   Mon,  7 Aug 2023 15:12:56 +0200
Message-Id: <20230807131256.254243-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807131256.254243-1-krzysztof.kozlowski@linaro.org>
References: <20230807131256.254243-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Changes in v2:
1. Use IOMEM_ERR_PTR (Hans)
---
 .../platform/samsung/exynos4-is/fimc-is.c     | 33 ++++++++++++++-----
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-is.c b/drivers/media/platform/samsung/exynos4-is/fimc-is.c
index 530a148fe4d3..c995b1226ca3 100644
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
+			return IOMEM_ERR_PTR(-ENODEV);
+	}
+
+	regs = of_iomap(node, 0);
+	of_node_put(node);
+	if (!regs)
+		return IOMEM_ERR_PTR(-ENOMEM);
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

