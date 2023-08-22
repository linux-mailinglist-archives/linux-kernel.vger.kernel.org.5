Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7760F7846B9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbjHVQQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237563AbjHVQQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:16:31 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935B6187
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:16:29 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3feef504ccbso24062915e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692720988; x=1693325788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRW3uVyacKVMz0n3X0Q3Lp2slVRo4x30QDLpyV/AFPs=;
        b=Pk2F0c9Rrazytsk16HB+LRnddYNJXPCP3yl2gz8VJKPrcoV6Hokw4kg7LsP0acL3jv
         NkRk7hi0k2D3BJ4wwtuhOMOgtVVt7T5vbMvQl7ioykCr8jahINu06Q11xUsFSsMQh0LL
         n18hC646m3ynfxuRFoIBK9US8nxX+G3GBTJ8H3sJLK6aWL1ez5vQEvQOqJ7uwChOS49p
         8tsTrKr1j0Ho3XZr6tEbpJATJtTuMMymD4UI2Dlw5oDyY3kzSYT6ZW1y+SZWgK8nRwT5
         JPMSp7rhv7tiQU/F+3+UIqE/YHYvxhWPSiT5Upgu58oWHUgSsLeqxVSgUI19oBJ4vfnc
         UUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692720988; x=1693325788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRW3uVyacKVMz0n3X0Q3Lp2slVRo4x30QDLpyV/AFPs=;
        b=XuSrQA+ygkdqUmctKcZA9GupiXz4JnTaQEWRb9scVYvrhkQsqI5cN3cwRnW9f7KVxO
         /isDjIXeBlLDuK7LRwdvxnjSFs9Fm9GddAco3p5OteaR6q841bcVlcQOZC/HAb0FuP06
         JSB2/GnrHWoAcgMCL43kmYAPYzbGzUZlDBgBiN8+gbadL0p8eQ9jvHuFNkDCtqXEvS1N
         UabU5GuGQprc0MzQu3omX1pmUiErjv2YVhvrg/VHBumpamgu9hnUv7P532yE1R0fmQjB
         56XZjenjvmBTV8J/1Rh500myNp+YrOYneKt3xvg9nCLH147E8r4kz2GHqhImmZB3g9fN
         s1Ww==
X-Gm-Message-State: AOJu0YwjRcEBsWIcsBVlkaWJu7e8LkSKgDLLNUj6RkCjJ5PkGjU527mC
        WyRZeBUWiuIr1CHmQsd6FioC5Q==
X-Google-Smtp-Source: AGHT+IGE2IthDSXynumdojcQS2kqJagZpGEDWNoRrEyfwvVk1jQZisP5AJpzMBj2Lv+cnfjySip1Uw==
X-Received: by 2002:a1c:7907:0:b0:3fe:1bef:4034 with SMTP id l7-20020a1c7907000000b003fe1bef4034mr8471234wme.37.1692720988108;
        Tue, 22 Aug 2023 09:16:28 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id t23-20020a7bc3d7000000b003fe1fe56202sm16516130wmj.33.2023.08.22.09.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 09:16:27 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v1 1/9] media: qcom: camss: Fix pm_domain_on sequence in probe
Date:   Tue, 22 Aug 2023 17:16:12 +0100
Message-ID: <20230822161620.1915110-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822161620.1915110-1-bryan.odonoghue@linaro.org>
References: <20230822161620.1915110-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to make sure camss_configure_pd() happens before
camss_register_entities() as the vfe_get() path relies on the pointer
provided by camss_configure_pd().

Fix the ordering sequence in probe to ensure the pointers vfe_get() demands
are present by the time camss_register_entities() runs.

In order to facilitate backporting to stable kernels I've moved the
configure_pd() call pretty early on the probe() function so that
irrespective of the existence of the old error handling jump labels this
patch should still apply to -next circa Aug 2023 to v5.13 inclusive.

Fixes: 2f6f8af67203 ("media: camss: Refactor VFE power domain toggling")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index f11dc59135a5a..75991d849b571 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1619,6 +1619,12 @@ static int camss_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_cleanup;
 
+	ret = camss_configure_pd(camss);
+	if (ret < 0) {
+		dev_err(dev, "Failed to configure power domains: %d\n", ret);
+		goto err_cleanup;
+	}
+
 	ret = camss_init_subdevices(camss);
 	if (ret < 0)
 		goto err_cleanup;
@@ -1678,12 +1684,6 @@ static int camss_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = camss_configure_pd(camss);
-	if (ret < 0) {
-		dev_err(dev, "Failed to configure power domains: %d\n", ret);
-		return ret;
-	}
-
 	pm_runtime_enable(dev);
 
 	return 0;
-- 
2.41.0

