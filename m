Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB238777605
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjHJKjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbjHJKjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:39:11 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF1C2115
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:39:09 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9b904bb04so12381031fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691663948; x=1692268748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LE5HgK/rmOOcUMyFbPo2FN+e7FctifYK6zOjgKT3LSs=;
        b=g10IMHnJ+fZFZ1dfJ5J3AL7iR1tbfBL7Jl2QHu4kvr4HkDB8XIel0BNUGj5D4xep3m
         wptZ4Q4S5j2v9tT6dnWVP2O6Uanht3RByki4mYlb29jx0la608eSd/BjvYV/obGMIZhH
         rinjmQySqDYW5j81/F3PZ0mNjSxJMuixpZ1pqAVTyrV3/ppiVhcwE6bzTs9nEheNOdNH
         HzH7+YmsLS63xji+mO3mkLBc4ZX28NJp1qXOevuwa1d5wahKE90p+R37Ypwi0SGWXI2H
         viEJbbqvLh87DS0KaPQcvHq9foZ0gRgTdZnsEhF1kSZSFIk/pmHdgDKlh9EyWVxXQRQc
         8LWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691663948; x=1692268748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LE5HgK/rmOOcUMyFbPo2FN+e7FctifYK6zOjgKT3LSs=;
        b=AEuon+wVz9t9drf4AfJPN1+Q4dZfpnw0fth9zTfJcBSQ7WTbgINtrpxDlzVPGCOk9H
         S7cFwX+ckNIW/+T++/3SLoXykSQthRRLlAJ2Of2CgzCEY6I/IZu51IFx5jgAUlpaKlTN
         HQYkSPUZnJ3Tg+lWXl2cng7g0bNwRfZBoxNbum13lObH+WIZmoe31c1H/ab4azfFkCkr
         8BTHQ8HSpkIbGO4xzCxz/aU6C1tfxZttRnm0MMuNNfWETBKO00kIsP+rjUB8RAqHpZee
         H2SC8rO6RKdkIEyg2fPFhnj8uq8VTJhecZgFQn8WBijmQ6YLTSTV/xgaE+jcPeLQe7UV
         kwVw==
X-Gm-Message-State: AOJu0Yxo0PwUw4Aq/RL3oOm358Tcuwq6VBV+WWK5l50kwNoRs73YVc9a
        6DVElK3aYehrdDvF4/gUV/MVzg==
X-Google-Smtp-Source: AGHT+IHioxh6ty/gJLegWCk8bgABdEYE5FHXi7z0uwbf+dChlaEeI6p677vKiBzREvHPOuq8G3JQIQ==
X-Received: by 2002:a2e:b60a:0:b0:2b9:c8fb:8df6 with SMTP id r10-20020a2eb60a000000b002b9c8fb8df6mr1527466ljn.33.1691663948155;
        Thu, 10 Aug 2023 03:39:08 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id g11-20020a170906868b00b0099bca8b9a31sm742180ejx.100.2023.08.10.03.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:39:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] rtc: jz4740: fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 12:39:01 +0200
Message-Id: <20230810103902.151145-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810103902.151145-1-krzysztof.kozlowski@linaro.org>
References: <20230810103902.151145-1-krzysztof.kozlowski@linaro.org>
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

  rtc-jz4740.c:352:14: error: cast to smaller integer type 'enum jz4740_rtc_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/rtc/rtc-jz4740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 36453b008139..84e0b3bfa71f 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -349,7 +349,7 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 	if (!rtc)
 		return -ENOMEM;
 
-	rtc->type = (enum jz4740_rtc_type)device_get_match_data(dev);
+	rtc->type = (uintptr_t)device_get_match_data(dev);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-- 
2.34.1

