Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFD1785942
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbjHWN2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbjHWN2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:28:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF0D173A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:00 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98377c5d53eso713622966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692797278; x=1693402078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hV84AQgFKUheaBdQhNV6C2FJYqe1CoPa5VcMWpQTne8=;
        b=dU1xWY8XiV3kQCunygYQyJ2SNeQpyYgERqogJCdb7wq4MCLnf+zfSnaNYaCliL0i1E
         qTml6lX2XM678e3SS0AgjOyPQNrDPrDOSpRpXhkMpEe69+XvNaEmhWau2Zf8ZymlXbGW
         aBmeSarQ2TNI2Nq7k1UKbnqbE2HI1h2Ek3fFNVRB+xBmv9bcMPx0FC9Ru/X/kYfMVtei
         BYVAHor+yAmOk6P69UppS5S/DzQl4S+B+akGICtbV8pGgJD9LnNnHQQcrNl9Xu6LH90h
         2xU5L2Xl9EBeg3bXX4Av3mWOQg9rQzeGQBoklofa25p6m/C1B9gs5KRY8zGec9m37vOf
         wZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797278; x=1693402078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hV84AQgFKUheaBdQhNV6C2FJYqe1CoPa5VcMWpQTne8=;
        b=heiSst9njdva/7Js6JhIB1pcdaXl7ote8kkpCLk4ClPNGUzovBV+HcS09tLXDsbvTn
         4Wr8UAhuRN2jBaJjndmJnqN83pICMn1sU4mRFWNr74stSVPv+x0ouJMg46pTIvaxtxjc
         Mvyep0Ma3ewf4e1q1rqq8L5GplhysKv/IgAQCMA5JnaFfagnR3LBhvr4ttSdId9RLnIX
         +aFr8nitKMJXyk8erVJCNgz65lShZRheg370yUu2mGqna0v5GUhc1hO47+d1zI18rWDt
         iuY4i1ETfmomQXGlz03E1l2X1MqFkUYIHP8ixYlC/cRzf8zj+hZ2u/7MioWSWWAuuoY8
         lG5A==
X-Gm-Message-State: AOJu0Yy33/8+crJcwBBHBVD6CHs/grvlP+sMoMZl1LC+X2n+XFGXjqT1
        vnw9GlvbC6lLH0+5lBNuUUofwg==
X-Google-Smtp-Source: AGHT+IHwFkGJZAUkv9ki/uXDjXe8I1e8oQsE9+VS/mUkNfHV5VRP5n4w470VpBHqTSOvkQ41xKCgiA==
X-Received: by 2002:a17:906:1ba9:b0:9a1:680e:8c54 with SMTP id r9-20020a1709061ba900b009a1680e8c54mr9675850ejg.71.1692797277984;
        Wed, 23 Aug 2023 06:27:57 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b009a168ab6ee2sm8918202ejr.164.2023.08.23.06.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:27:57 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 03/22] nvmem: brcm_nvram: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 23 Aug 2023 14:27:25 +0100
Message-Id: <20230823132744.350618-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
References: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=930; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=RvTYAkHR8Qr8QtAOWbJ4oOb7G6futc0pVpKPM1Znc8Q=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBk5glDV3es72N4LTqhAHRMYKmCWn2hIq/v0O6rb FLE+To0TYyJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZOYJQwAKCRB6of1ZxzRV N+1iB/4mp/hfkMlc/snAX0v8IkQoYOCn5N4q1DA2kyiMMLj2dA9WSPSfeJn6FgvRXnZdMaqn6mI ZEsd5QT5YOm5/4B//Sm1Xg0NJfzjdfaJmupa0d7b4yRsSSmY62P2qTe8Z4UkbGPnVuwPFIc0Hzw vahPXkjbYm+mBqfBBvZdXq/xhsT4043MjSY+6XFz4+snOT0dqlR31pGWnC3XAOub7fM5yFDzc74 2QWYsCA2AxBba7w2FLi0FkWg138Kr9JKpNqpWeaQCDh5WVdYsxaoEjlDkWFDqMCTu7NqWrPh+v+ ENM4hh+a190XW+S1VaRkiUtNy+eggR74+M41mRkiCuE41yvt
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank.li@vivo.com>

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/brcm_nvram.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index 4567c597c87f..9737104f3b76 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -159,8 +159,7 @@ static int brcm_nvram_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	priv->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(dev, res);
+	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-- 
2.25.1

