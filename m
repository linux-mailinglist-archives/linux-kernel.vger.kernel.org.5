Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFAF785947
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbjHWN3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbjHWN2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:28:55 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A662910FE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bed101b70so729144966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692797284; x=1693402084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2ufyMbSr52063L2gnL8kN/obI1LGUR1mTFo5Z71Gt0=;
        b=N06xPpl2fewFwRWB3yPKLJt2fw1/MEAd8OxSE2gRXXl5RWJDH5i4DYA/5Be5Tjl96N
         oyzCYIf3ZGVum/M6CGFcE1/XO8oa9GYYOKqbCjp4QpUSCFpHfqg15l2WrMHYGkFVJ2K8
         ZZy3MRcnOMo+okdvNov2D3E7hGBrk67+woE2/5w7eAketsjErSDiuZx1de7r1Ox6IjLd
         GaFXJm1//Y1UXkPB74UZfQBUs0gyQvbLXgiOcVKCScdJU+yT633Z7l5dmelhDfD4UMcD
         aloYNWyV8f+1iR3rFck6WzmODsnJcBL6XsoxAZ6luzdwBRKtqYfGYEs5YS89ja9u8xCb
         iOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797284; x=1693402084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2ufyMbSr52063L2gnL8kN/obI1LGUR1mTFo5Z71Gt0=;
        b=XHB46NwZs9nbPAAGALcjaxEMe6A9yEMqPgHRgChpqWPQvqOm0QNN5D+hczldb/d9oc
         6z0KBjGGqo/db9qhNADubFGG5YYmdgKxtKS1BiiUESr3fe7W71pYYdUAxXcHJb5ZmFpC
         asoYV8ZgUwSU/MC7gK+InpBh3/mP3ivivSqZhT50rxSma3hUqSLb8UN56cXKmwEc4cSN
         w+9acq3RQsZa4XTtH+dpGwVEXf92aPO6ZX1Nl+kPLmvMXkR5PzloBKrxs+aOfFAcrRgC
         1m0U5IsVXmtPYf4e8DdkGBq4aEt1oRJIN2y6gK/APp1P2xdleUcTWQQQZNKPQQzRN8sF
         rdFw==
X-Gm-Message-State: AOJu0YxelwP1CE7LEawc4T2wbbo6/uJdWx0Ja4SudJ4nydepmqCNo4Gz
        Uz8dAVkTGkE0y5Pn9vRcCcK8ew==
X-Google-Smtp-Source: AGHT+IEB65l929oMx9K7fGucp6fg+ToNz+ZBTvsakPP84CCJ41sJwchyVr5r7b8CUB1QX81cacLhJQ==
X-Received: by 2002:a17:906:30d9:b0:9a1:bd1d:61b2 with SMTP id b25-20020a17090630d900b009a1bd1d61b2mr3448321ejb.56.1692797284107;
        Wed, 23 Aug 2023 06:28:04 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b009a168ab6ee2sm8918202ejr.164.2023.08.23.06.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:28:02 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 08/22] nvmem: qfprom: do some cleanup
Date:   Wed, 23 Aug 2023 14:27:30 +0100
Message-Id: <20230823132744.350618-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
References: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2187; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=VN/j7cSPzZ02QfLeVe45BQJ/nji0HFNASPsmKb6l3PI=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBk5glHnxti1ISzadVFeqs8Ksrdbn4TB9KNBbKMb XYjpur5hHaJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZOYJRwAKCRB6of1ZxzRV N1P3B/0bD2uxE5VxuBKgIoiiNVKGokN40mJc5kBhjVuGWGbDNeBf/9RjX0OUPyNEuYM53xBS0zj fLKheuuVlR4YryPxQ5jx1Bf3szlUl5tmUvrUsGTStJSCJSHh+1KkHWP3O1EJsGRnCpzUmthma9l GEhS5lReWP7Q3U/OVCuJMN/uUVe9wuWkbjZLJgpb9kB6b9cNQbSrWx/djSVgyi/GtT2t45riMkb r4IVJNORp7285CqOvY3ZsnHyscWSv8MOyEV1UR9iB+kF2Inofn+/8jp6rlBhezfUbYuXB6W8enI HIGLbFNUNzACgdxrMwpzaJtTzCyvD+AKYvSgtjRXhLyj+h2A
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank.li@vivo.com>

Use devm_platform_ioremap_resource() and
devm_platform_get_and_ioremap_resource() to simplify code.
BTW convert to use dev_err_probe() instead of open it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/qfprom.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index c1e893c8a247..14814cba2dd6 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -374,8 +374,7 @@ static int qfprom_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* The corrected section is always provided */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->qfpcorrected = devm_ioremap_resource(dev, res);
+	priv->qfpcorrected = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(priv->qfpcorrected))
 		return PTR_ERR(priv->qfpcorrected);
 
@@ -402,12 +401,10 @@ static int qfprom_probe(struct platform_device *pdev)
 		priv->qfpraw = devm_ioremap_resource(dev, res);
 		if (IS_ERR(priv->qfpraw))
 			return PTR_ERR(priv->qfpraw);
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-		priv->qfpconf = devm_ioremap_resource(dev, res);
+		priv->qfpconf = devm_platform_ioremap_resource(pdev, 2);
 		if (IS_ERR(priv->qfpconf))
 			return PTR_ERR(priv->qfpconf);
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
-		priv->qfpsecurity = devm_ioremap_resource(dev, res);
+		priv->qfpsecurity = devm_platform_ioremap_resource(pdev, 3);
 		if (IS_ERR(priv->qfpsecurity))
 			return PTR_ERR(priv->qfpsecurity);
 
@@ -427,12 +424,8 @@ static int qfprom_probe(struct platform_device *pdev)
 			return PTR_ERR(priv->vcc);
 
 		priv->secclk = devm_clk_get(dev, "core");
-		if (IS_ERR(priv->secclk)) {
-			ret = PTR_ERR(priv->secclk);
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "Error getting clock: %d\n", ret);
-			return ret;
-		}
+		if (IS_ERR(priv->secclk))
+			return dev_err_probe(dev, PTR_ERR(priv->secclk), "Error getting clock\n");
 
 		/* Only enable writing if we have SoC data. */
 		if (priv->soc_data)
-- 
2.25.1

