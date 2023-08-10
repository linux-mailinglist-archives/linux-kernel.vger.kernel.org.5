Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79ABE77754E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbjHJKCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbjHJKC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:02:29 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965654491
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:00:38 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe5c0e58c0so6655465e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691661627; x=1692266427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EJpAe1JQRQzLr4HpWXO5enRMUdenJgniTKPQuT4aMag=;
        b=o2Xu3N8gsBKbsUqsqPOXA90TMKTtooEE7vy7ZbyqxPNFgdRjzYSFaAJfNIzfu9fb3G
         uwi1FMmAHBaxrClDBQKIiW19XCbK/z9Ct5iVUJT1IQmgR1hQbFTm90SFm6FjlUnIqoY0
         OY/ZpgkJPiqTqLwu0lA99ZB0NXyEGI7YEfGay/HSXJo0Z3g7u1ghsjthdKEAYJQjqVf9
         UqPWePVhZ1WqT0ofoLzCOBcj+Jv7VntvDl36Hj3eOyA8+WJIqqkD0ro7TPEXBc2v4vWT
         AUJhC4uBq1gmhf8T6LyjTJ5Drh3gT4rtJzsCLFGXcIA0IWcLSjZt/XZibqPUdJUGj3tY
         ZgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691661627; x=1692266427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJpAe1JQRQzLr4HpWXO5enRMUdenJgniTKPQuT4aMag=;
        b=ZzaZQjkz+YV8OCtPvi0fMM9Qn2CJJjM+U44e1NAVS+N/PJF2YOXezRt7Mt0PXO/AIK
         BlVayPeKPAI3TDXj8eFGs8uz8mynjMuemMyD0PNLjBZGYSJF/gzDV+8W1kJn5KmQsG74
         uvMm5IVysCfvclmVM4rnk0oo4DyA3YWcA8LKl6eU4Ez0eaZPstpn9p6JrU+Cj2IEOcPz
         VwZxJHAXUO96FridQ1Ss4FBvZr4B4/hUJ8terGKmQ4EawAfINBT0jr+cwF4HE4o8yo5c
         QfwujL0giHTHh+6CA0/wPPboL2QLphnoUguEEFGVW6OdiG75bRaQGxq1VcqCaYefoL4M
         30hA==
X-Gm-Message-State: AOJu0YxmNUdAF/8KBLnS6L42QoyQLYXXIgOhtgv8e0VSyz3rpLRMsvBJ
        gJRq8Sm29Wf/1HrzKafRke2tyA==
X-Google-Smtp-Source: AGHT+IHxqMT31Sy/C+YwIQaVLuwACdfzqMWxRxpt+agaXRC3ydv+UIu51hWX4dWN7D0RnMHVf8X0Eg==
X-Received: by 2002:a05:600c:204e:b0:3fb:e643:1225 with SMTP id p14-20020a05600c204e00b003fbe6431225mr1448299wmg.13.1691661627238;
        Thu, 10 Aug 2023 03:00:27 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id f2-20020a7bcd02000000b003fe210d8e84sm4569498wmj.5.2023.08.10.03.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:00:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-crypto@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH] crypto: exynos - fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 12:00:23 +0200
Message-Id: <20230810100023.123557-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

'type' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  exynos-rng.c:280:14: error: cast to smaller integer type 'enum exynos_prng_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/crypto/exynos-rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/exynos-rng.c b/drivers/crypto/exynos-rng.c
index cbd8ca6e52ee..b1df66be9adc 100644
--- a/drivers/crypto/exynos-rng.c
+++ b/drivers/crypto/exynos-rng.c
@@ -277,7 +277,7 @@ static int exynos_rng_probe(struct platform_device *pdev)
 	if (!rng)
 		return -ENOMEM;
 
-	rng->type = (enum exynos_prng_type)of_device_get_match_data(&pdev->dev);
+	rng->type = (uintptr_t)of_device_get_match_data(&pdev->dev);
 
 	mutex_init(&rng->lock);
 
-- 
2.34.1

