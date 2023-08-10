Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C29C777527
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbjHJJ72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbjHJJ67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:58:59 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBD7120
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:58:58 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe1a17f983so5895965e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691661537; x=1692266337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulC0rUCgM79VoK8ODBpFngeO7joEM2mXw44qcZoQUFU=;
        b=NQbGCh+TQMHjAbZGfILAsXjghrFOWpO++Oo0JbNQNJ07f9cnL+UKwEmYRcJk6tUbv0
         TKaX6/yXLKmPPKHLTD1EwK8K0WmK7bhQRRWmsr6ZzrKmBL0HaEnOQVgNiqyrujcFvbeO
         I9jyUbzqCpvru8gPhT91Oo0Tdkt1eZLrbKDZEJKfayS/D0iYN7pMhH6JMYfIKo5U5+HT
         nnJT2ut4yzHE1MN3Nycb6qwWOe9Voz2KNqZ/YrrSoarHwHaCuF/3+mHklOkWnpeZfzJa
         oWP/6FmEsH0+M4BM4nDkPBBLjIqHTwVXB/LfD70mg/k9dIjnvEUMMldV7Ik46ZvJfZFt
         c5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691661537; x=1692266337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulC0rUCgM79VoK8ODBpFngeO7joEM2mXw44qcZoQUFU=;
        b=YeOCWsO6Rk8d/7YpLLkGi411DwK8JxkpJw1hWFAnE/TZ7pOO0D7dqggRF6DMBKO4ii
         Ot31gvIirQS9C4eFWyFmoacBa5EGSBpx9j9t8qDE0qWUX8vKJviOjgPw9iHybl0P8WZ1
         DckZNZgYWuo83Ac70hrm36rvKamMrZlw9mZvU/SYb0Omh3TzQ8JBRygacfOqSMTIfetj
         lCyvtbz5eNSw457zXv0ZcmHF88B2QsgUUJjc2vOHLHzv2MJsFF/6YSzIQA0JECRgZIpg
         Of2QqIMv2b0KJBj9Hyjrx4Ui4U6HTX/A9gkK1w+UKAg8NRUTehIRDsHgjjA/ajPzb0Di
         sjVw==
X-Gm-Message-State: AOJu0YxvcK31Yae4n8LWesszx82x+EXsdipDlDidvla0BJh5A1zfRMfh
        0BbWhLytDo/mzwNExYKL+XxxvA==
X-Google-Smtp-Source: AGHT+IFj2aXstTHIer9E4PGTHLUE0TVA00q0pkg/2yS1aXKJ/NorUjW8QJokHx3v8suWkFHQtlG+EQ==
X-Received: by 2002:a5d:4908:0:b0:317:61de:abb5 with SMTP id x8-20020a5d4908000000b0031761deabb5mr1653955wrq.69.1691661537197;
        Thu, 10 Aug 2023 02:58:57 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id p1-20020adfcc81000000b003179b3fd837sm1621372wrj.33.2023.08.10.02.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:58:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        patches@opensource.cirrus.com
Cc:     Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 4/9] mfd: hi6421-pmic: Fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:58:44 +0200
Message-Id: <20230810095849.123321-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810095849.123321-1-krzysztof.kozlowski@linaro.org>
References: <20230810095849.123321-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'type' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  hi6421-pmic-core.c:62:9: error: cast to smaller integer type 'enum hi6421_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mfd/hi6421-pmic-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/hi6421-pmic-core.c b/drivers/mfd/hi6421-pmic-core.c
index cb5cf4a81c06..a6a890537a1e 100644
--- a/drivers/mfd/hi6421-pmic-core.c
+++ b/drivers/mfd/hi6421-pmic-core.c
@@ -59,7 +59,7 @@ static int hi6421_pmic_probe(struct platform_device *pdev)
 	id = of_match_device(of_hi6421_pmic_match, &pdev->dev);
 	if (!id)
 		return -EINVAL;
-	type = (enum hi6421_type)id->data;
+	type = (uintptr_t)id->data;
 
 	pmic = devm_kzalloc(&pdev->dev, sizeof(*pmic), GFP_KERNEL);
 	if (!pmic)
-- 
2.34.1

