Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D35C7773F4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbjHJJOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbjHJJN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:13:58 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B4235BE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:13:22 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so819075a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691658801; x=1692263601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g3SpD5yxs/exW7oqYDwh6NeT5Hd31MRlZzqVBk8xwU8=;
        b=D4wxknROpd8rYS825uf312+KYogA9ZDVqxH9TibWxJxmTZJ5j8iG47lwgyvoR8H1tc
         Q3m15P8P2+lfhcFyAyjk/1NE6W32I9+COf/UbrQ4lwwa+VqWxFfwlvde/UKZqI5o7rRv
         wsyEKqRZhupBg4Qg0Gfp+yPO53U1ZFHOJWKZ2pjE3uT+GRpzuPwLPV+TNqxqiSyMNfOQ
         apDmXv+SmiridApSDYDwwh6LNbizRROmBeJWuM9hJtVX6OZE38IJbZJ+g7NNLC7dFTtA
         WtLQnwyYmrD8rlTOz1wlz4BKy52xwMdwtj3Fuxc3jvT5Z8uDvzv+BV8elKyPD+PRKipq
         n5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691658801; x=1692263601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g3SpD5yxs/exW7oqYDwh6NeT5Hd31MRlZzqVBk8xwU8=;
        b=dLQJc3OuJsqdw3YRpUoZahJQgEkUUB8lXaMeUUedWawfuL2OE8IMCO2NVnJVV+azYc
         dwkdZ0MSveZl3cAvLjsv02wJp/RNt7i5TwRWUZPCT5TzLNEENw6w5niZVRt89R0B1Vtb
         FOK5zDUQziFL/KAJPzPNQyc/M9/dc/YqjaOjqO3OhRe2mE2ViRZFYr9u/67DVu48oaMV
         DKqcA4Fk9UMIxbSQztBPfIUAaudesugLLIqhppYeDitFwiJntkEAeI9zGWSg+USdAeYb
         qxfE2UNYwd011/pwVSZf6FpDurrhjRo3i2sA59XcLITS5yAg8IgcqYNd+73ft1LG07YR
         /+FQ==
X-Gm-Message-State: AOJu0YyowU5y3/nAXo7XwYi0n4z2Ozl5WlKZZafrsI0H6GkpiWP/bLFg
        I3c7vmL/jiDEej/Ln4iplyD4RA==
X-Google-Smtp-Source: AGHT+IEAg+m9R2DlQPa4LDbgsuO3OxpClGBb4Zy/Wi4GmUdfNIwkALvNZ+bxZDFUMnc+zmgzgZgiZQ==
X-Received: by 2002:a17:906:cc54:b0:99c:a23b:b4f5 with SMTP id mm20-20020a170906cc5400b0099ca23bb4f5mr1499184ejb.53.1691658801041;
        Thu, 10 Aug 2023 02:13:21 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id a18-20020a170906469200b00993150e5325sm653868ejr.60.2023.08.10.02.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:13:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH net-next] thermal: samsung: fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:13:18 +0200
Message-Id: <20230810091318.70261-1-krzysztof.kozlowski@linaro.org>
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

'soc' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  exynos_tmu.c:890:14: error: cast to smaller integer type 'enum soc_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/thermal/samsung/exynos_tmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 58f4d8f7a3fd..e5bc2c82010f 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -887,7 +887,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		return -EADDRNOTAVAIL;
 	}
 
-	data->soc = (enum soc_type)of_device_get_match_data(&pdev->dev);
+	data->soc = (uintptr_t)of_device_get_match_data(&pdev->dev);
 
 	switch (data->soc) {
 	case SOC_ARCH_EXYNOS4210:
-- 
2.34.1

