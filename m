Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C880E804D8F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbjLEJWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbjLEJWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:22:38 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34597CE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:22:44 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c0a0d068bso20239545e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 01:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701768162; x=1702372962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJh8YfrYN4aMg7OwYeFzWAOVUVx0rMNzMAodPuvKkaY=;
        b=tlTfOHi0sv822V6yfJDh0mWZG5PQHDpLLhbcUjESBS1oIbaL/g3nDzmMqTCgmnc3v1
         QR4PFL89lG5IWJxLa0NOQ52jFgvS5UWGKlY0S0YYue1Zo823qOmN/4yCRuViGKbFDUVw
         7zrT0wmrfAwqUEbeaL/F8GMg020vFn7PtVyES4twas9J6w5FVQlxSiJ5tG7bAjtUICVU
         IYcSTIUq4tZQ71FS4Gh1V/WjQXerHZZDTiuWHpAuSiVn4vYkUCiIKFGy3qwm5ThAFL9y
         cA8M8NRAH/LMqO2l3PhylYo7dJepnprAoRjlrxP3waXf8I+U/rpNXrGJx7RT4GfISw24
         KnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701768162; x=1702372962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJh8YfrYN4aMg7OwYeFzWAOVUVx0rMNzMAodPuvKkaY=;
        b=Qb3P7XUMkwL7IT5go5EqDjf3AVSFV909ASmaL50yk9JkWcl+TXKYfyNCXpIoNWjFqC
         pPyi5rD2P5jniQJgyXfbIMwX2qIpDkNj2UTvkon+xTkJBVcY6p9Y65L6JwKSpSPe6aQN
         29s/TF0LtfMtSPiN8jEL1Cko9ZoP3AiZiLQgxTSyMjTqZL9XebcsRWC2BlJlsW2IOSFM
         miaxZZxS2r15SSLaZWnw7yhBuhoyV0JiIVoRO4c5bEGRTdycON0+F8JI6rvVEXoRK8cx
         8tHd8MrjMuu52ToFGcEXmAgLU/7c9D6erATtbIJl4/tdAhFQrCNXC7p0vwk0taeRs/nU
         8eDg==
X-Gm-Message-State: AOJu0YxDjCR+XoFtkBcez0lGuQMOVGSLVJDtTbtGMquhm7zJzGtxmDCT
        9Qq29yKve6Pxk0JvlTOqNZWenA==
X-Google-Smtp-Source: AGHT+IEQb3rHaV3TPRV3lXtPvhHPSOgrz+olhZYbewsa9RJkFJDQq9Qj+DmR1Dk9Y8Zn/uJ/on8Fug==
X-Received: by 2002:a05:600c:6026:b0:40c:87d:a27 with SMTP id az38-20020a05600c602600b0040c087d0a27mr2244281wmb.101.1701768162784;
        Tue, 05 Dec 2023 01:22:42 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c4eca00b0040596352951sm21692287wmq.5.2023.12.05.01.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 01:22:42 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-fsd@tesla.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/6] dt-bindings: serial: samsung: add specific compatible for Tesla FSD
Date:   Tue,  5 Dec 2023 10:22:26 +0100
Message-Id: <20231205092229.19135-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205092229.19135-1-krzysztof.kozlowski@linaro.org>
References: <20231205092229.19135-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tesla FSD is a derivative of Samsung Exynos SoC, thus just like the
others it reuses several devices from older designs.  Historically we
kept the old (block's) compatible only.  This works fine and there is no
bug here, however guidelines expressed in
Documentation/devicetree/bindings/writing-bindings.rst state that:
1. Compatibles should be specific.
2. We should add new compatibles in case of bugs or features.

Add Tesla FSD compatible specific to be used with an existing fallback.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

I propose to take the patch through Samsung SoC (me). See cover letter
for explanation.
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index e32c1b462836..4b6fc82c2edf 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -29,6 +29,7 @@ properties:
       - items:
           - enum:
               - samsung,exynos7-uart
+              - tesla,fsd-uart
           - const: samsung,exynos4210-uart
       - items:
           - enum:
-- 
2.34.1

