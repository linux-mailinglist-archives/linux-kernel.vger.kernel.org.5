Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31717B623D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239303AbjJCHKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjJCHKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:10:35 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FAAD9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 00:10:31 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-405417465aaso5878635e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 00:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696317030; x=1696921830; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IywbLeV1JE7fISvBp0m3U1FAV92P00oRfMvIqcDu3Zk=;
        b=NDRZbtOFImeypJzEHKgLysE/Mm5OXE5ASOeMXAR9FTQMjw+QABp0daEnPOF30ifgV9
         jjxS1wHbei3ItQiH1xMehMNItTmHOUc8ACh6UKhVdkGI+K3ierhY6b8l0QGfVRTEEKDN
         woi7q2r+NRM9TSrMq5PqFl9axML7Mk6I4CPMg43idlB1S+siRMUH8HMmRnYuE7Fn8hjb
         6NfCO66QNeawAYM0bX8M/RpZqT4v0EXiQvV050giH3YDn5RS+sh3gkxyxThw0Q4SxwSS
         ZqV4+5lpRhPJzLd04jqz0E5gSI6kCG369pfjOL/ppSSTBe18LMMIh4CpeFEwa1sm3LKp
         S39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696317030; x=1696921830;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IywbLeV1JE7fISvBp0m3U1FAV92P00oRfMvIqcDu3Zk=;
        b=dtaLTDVYn5iJSWMcPMVJdYcjX3v7e4DjqynnSSTg/ZZVD2uF0tEBogF8P1nCiz/Fo6
         9YqGV/aQEjQMRB1neIliZu88IJcHSkhveZP0jw3xEHxk3ge9Pnj77tQvP+aZDnadwWUE
         e8V08woFKHBnkoRGMWwx66Rg0znDDDb2IY1NU+hzVEJLe188JgJTQTX0PjnflOR/hmRy
         Da87H67LlbXx5OhMs2rGTiBPOF1rn45+9VEaDp5xsvyKseeX7xl+i2COFtBCz034Qa76
         cIYsjXyR9k3nz+ezx4SfSVmJMly2FoSFGWhIRdBg80A+aCLr/wQOq4uG4pXXUBr+5Aed
         6xIw==
X-Gm-Message-State: AOJu0Yw3EhqxQ98KLNNo2YENPFAguizmhQS9S9aFImTcOdv0xTEM1RbS
        s94HJLfeHKNqrP/QyFMyWYtEbw==
X-Google-Smtp-Source: AGHT+IGY906kVJig/V12DoguZU16BgJDEgJZd0/1sIm1JRgE9n6IDBV9mUI6yYIO1gKCbMz5JbDaHQ==
X-Received: by 2002:a7b:c397:0:b0:3fe:3004:1ffd with SMTP id s23-20020a7bc397000000b003fe30041ffdmr11865022wmj.4.1696317029901;
        Tue, 03 Oct 2023 00:10:29 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id k2-20020a05600c1c8200b004065d72ab19sm8746652wms.0.2023.10.03.00.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 00:10:29 -0700 (PDT)
From:   neil.armstrong@linaro.org
Date:   Tue, 03 Oct 2023 09:10:21 +0200
Subject: [PATCH v4 3/5] crypto: qcom-rng - Add hw_random interface support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231003-topic-sm8550-rng-v4-3-255e4d0ba08e@linaro.org>
References: <20231003-topic-sm8550-rng-v4-0-255e4d0ba08e@linaro.org>
In-Reply-To: <20231003-topic-sm8550-rng-v4-0-255e4d0ba08e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Om Prakash Singh <quic_omprsing@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4714;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ZtCB6lsbxvSa3eirhPxOyVDi+suZRyTxM+5dgiifh+4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlG75gVaZ0azfyvKpaRHykx/cbFhLJvTna1PxaHvVH
 KswlclGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZRu+YAAKCRB33NvayMhJ0VM1D/
 4mimcU9Z6SAgY6DGnzoJNlEKrYbNRd+OEe0okGp5QrZRA23McBeGRwI+ru3UdnIsX9pRZIc3cH0RBv
 hkOFSvMx3mXP9DjmBvrRt8yCZoMcfEm6Wn8ReWrZWdBP9AqzS6ObSgefpzfx/zNLDfir8iw2rvkl1i
 IanVFhLGc9EI0tbgUgALxhKVbr863iV7wThCJrk6czDf+MlSRbpXFIqECg5PhcSySF1Fm9Dq+c4PcF
 VU373UHytW98QUEGx4a8k5y8zvKS0YGc0JuW6aIJcds2mI9zdc7FkYnadIcGwgH8YEZFrR+8frnrRL
 qVjVvXsjAB86yto5r0qI7M/42LXj4KiKu9pcY4HpepPy07SEIrLTV1Cx4SFBSDvoRtOZZH43IZr/9V
 g3H36x4pNTqpWWSVx7es4Ty/01NMWzoIXOR+7MxDJGtX/QPZ6dwEdehUyjdV5UfVv47etadam9M6SQ
 rRZ7Qmyilz3CwBQ08lzL171Q1WDWvd8Jl+qn8jIAGruyQx4dL1L7etqGX6+FPciq0nK9aqTx1pqjLr
 +aw1AoCi1MrmO1kuGjLnG3hpazI39ltYcZp9WYYmXP/jGC+5kGB1H0rIDoxm9IWOWg9+wdFXkN1ET6
 /S3UzwesxpSxordgNtrV3TcD/WjE1qJS8e1TUMzEWgPzQJP95CQ+cA4FqMJw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Om Prakash Singh <quic_omprsing@quicinc.com>

Add hw_random interface support in qcom-rng driver as new IP block
in Qualcomm SoC has inbuilt NIST SP800 90B compliant entropic source
to generate true random number.

Keeping current rng_alg interface as well for random number generation
using Kernel Crypto API.

Signed-off-by: Om Prakash Singh <quic_omprsing@quicinc.com>
Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/crypto/qcom-rng.c | 65 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
index 825a729f205e..8b506abb934c 100644
--- a/drivers/crypto/qcom-rng.c
+++ b/drivers/crypto/qcom-rng.c
@@ -7,6 +7,7 @@
 #include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/crypto.h>
+#include <linux/hw_random.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
@@ -28,17 +29,25 @@
 
 #define WORD_SZ			4
 
+#define QCOM_TRNG_QUALITY	1024
+
 struct qcom_rng {
 	struct mutex lock;
 	void __iomem *base;
 	struct clk *clk;
-	unsigned int skip_init;
+	struct hwrng hwrng;
+	struct qcom_rng_of_data *of_data;
 };
 
 struct qcom_rng_ctx {
 	struct qcom_rng *rng;
 };
 
+struct qcom_rng_of_data {
+	bool skip_init;
+	bool hwrng_support;
+};
+
 static struct qcom_rng *qcom_rng_dev;
 
 static int qcom_rng_read(struct qcom_rng *rng, u8 *data, unsigned int max)
@@ -66,11 +75,11 @@ static int qcom_rng_read(struct qcom_rng *rng, u8 *data, unsigned int max)
 		} else {
 			/* copy only remaining bytes */
 			memcpy(data, &val, max - currsize);
-			break;
+			currsize = max;
 		}
 	} while (currsize < max);
 
-	return 0;
+	return currsize;
 }
 
 static int qcom_rng_generate(struct crypto_rng *tfm,
@@ -92,6 +101,9 @@ static int qcom_rng_generate(struct crypto_rng *tfm,
 	mutex_unlock(&rng->lock);
 	clk_disable_unprepare(rng->clk);
 
+	if (ret >= 0)
+		ret = 0;
+
 	return ret;
 }
 
@@ -101,6 +113,13 @@ static int qcom_rng_seed(struct crypto_rng *tfm, const u8 *seed,
 	return 0;
 }
 
+static int qcom_hwrng_read(struct hwrng *hwrng, void *data, size_t max, bool wait)
+{
+	struct qcom_rng *qrng = container_of(hwrng, struct qcom_rng, hwrng);
+
+	return qcom_rng_read(qrng, data, max);
+}
+
 static int qcom_rng_enable(struct qcom_rng *rng)
 {
 	u32 val;
@@ -136,7 +155,7 @@ static int qcom_rng_init(struct crypto_tfm *tfm)
 
 	ctx->rng = qcom_rng_dev;
 
-	if (!ctx->rng->skip_init)
+	if (!ctx->rng->of_data->skip_init)
 		return qcom_rng_enable(ctx->rng);
 
 	return 0;
@@ -177,15 +196,31 @@ static int qcom_rng_probe(struct platform_device *pdev)
 	if (IS_ERR(rng->clk))
 		return PTR_ERR(rng->clk);
 
-	rng->skip_init = (unsigned long)device_get_match_data(&pdev->dev);
+	rng->of_data = (struct qcom_rng_of_data *)of_device_get_match_data(&pdev->dev);
 
 	qcom_rng_dev = rng;
 	ret = crypto_register_rng(&qcom_rng_alg);
 	if (ret) {
 		dev_err(&pdev->dev, "Register crypto rng failed: %d\n", ret);
 		qcom_rng_dev = NULL;
+		return ret;
+	}
+
+	if (rng->of_data->hwrng_support) {
+		rng->hwrng.name = "qcom_hwrng";
+		rng->hwrng.read = qcom_hwrng_read;
+		rng->hwrng.quality = QCOM_TRNG_QUALITY;
+		ret = devm_hwrng_register(&pdev->dev, &rng->hwrng);
+		if (ret) {
+			dev_err(&pdev->dev, "Register hwrng failed: %d\n", ret);
+			qcom_rng_dev = NULL;
+			goto fail;
+		}
 	}
 
+	return ret;
+fail:
+	crypto_unregister_rng(&qcom_rng_alg);
 	return ret;
 }
 
@@ -198,6 +233,21 @@ static int qcom_rng_remove(struct platform_device *pdev)
 	return 0;
 }
 
+struct qcom_rng_of_data qcom_prng_of_data = {
+	.skip_init = false,
+	.hwrng_support = false,
+};
+
+struct qcom_rng_of_data qcom_prng_ee_of_data = {
+	.skip_init = true,
+	.hwrng_support = false,
+};
+
+struct qcom_rng_of_data qcom_trng_of_data = {
+	.skip_init = true,
+	.hwrng_support = true,
+};
+
 static const struct acpi_device_id __maybe_unused qcom_rng_acpi_match[] = {
 	{ .id = "QCOM8160", .driver_data = 1 },
 	{}
@@ -205,8 +255,9 @@ static const struct acpi_device_id __maybe_unused qcom_rng_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, qcom_rng_acpi_match);
 
 static const struct of_device_id __maybe_unused qcom_rng_of_match[] = {
-	{ .compatible = "qcom,prng", .data = (void *)0},
-	{ .compatible = "qcom,prng-ee", .data = (void *)1},
+	{ .compatible = "qcom,prng", .data = &qcom_prng_of_data },
+	{ .compatible = "qcom,prng-ee", .data = &qcom_prng_ee_of_data },
+	{ .compatible = "qcom,trng", .data = &qcom_trng_of_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_rng_of_match);

-- 
2.34.1

