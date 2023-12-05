Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F635804D9C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbjLEJWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbjLEJWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:22:40 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7641189
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:22:46 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b595bf5d2so57723715e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 01:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701768165; x=1702372965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiwDzYyRIlGmD4rq+fT3CJuYXFmHWLQt6YDjPACpru8=;
        b=K6PXrMUJ3ZkAE7taR88Jz0kpQ1o2JPlgeeN+x42fvTmHyaJX/VvwiGoCZFX3jhPyU3
         WeMZVGs4CS+qIRXIoFAX5Oxf7YbZq+0t7c52ckWMbHv2c7x/HaNnQ9K1O2cbyzTBVc5d
         EwhRuBhZKUoJEB4yppFNhfQWqdffZQNsi0rEV2jbTUTqzF3zOMKf0FtWEBlldj5ec+6p
         VOYa35a3flg8C611lOrtaQERRK0UWK2buJqOeHlx7Hsg/6S6NGx/IiPd4V5BWpE4mjRx
         P9g7gJMxAYMDjK61DkTUiDlZUKB9YHDT57jX0OP/krnd/sNCHO3njv2NP7upAgJzEW8P
         DzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701768165; x=1702372965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KiwDzYyRIlGmD4rq+fT3CJuYXFmHWLQt6YDjPACpru8=;
        b=avhbgn6p7RkQ9ajTjVZCx5cILoAH6cvTF9q1j1fjY1XdNSD6Jbzgu/NiMiUkHMHhHV
         Cjz0Ocp+Gq3oqxaB/rqwHdGdyyo7kIsYerbqua10slk3pLp6Lplqmw52n00Ifb/fA2j4
         CWVOi01jG8UI/jdFHgB3KReYMntrD1eXCX5GE92KWc63matmxW5ApEUUK9+fcj1/15nN
         JCPU1xfTtay+j6hQwsrEFFhmnCCZ72bq5LuNU83QJhJjlijFNifrNwjBxepBF6N+Dz+X
         6OblYsZBQVron/dzdyepArVPvluNFXiqAKi+YduuoQ6UDDvD1n9a5gnhpVNz7VwIPnNJ
         VcjA==
X-Gm-Message-State: AOJu0Yzmv6ob7rLlUXnKNNrULuHG76xgg00VVWA87byudxqGPfU2L61V
        X7D0XqdCsGdpn+qj3UNWs9Z6+g==
X-Google-Smtp-Source: AGHT+IE6Nv2mMVcB6u6tOx6vUp8cXe2wfi+WLQNn7IelBgGazYOydaEFJMItf1gzh9HaZcGdX6MMMQ==
X-Received: by 2002:a05:600c:524c:b0:40b:5e59:99e0 with SMTP id fc12-20020a05600c524c00b0040b5e5999e0mr182502wmb.256.1701768164973;
        Tue, 05 Dec 2023 01:22:44 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c4eca00b0040596352951sm21692287wmq.5.2023.12.05.01.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 01:22:44 -0800 (PST)
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
Subject: [PATCH 4/6] dt-bindings: samsung: exynos-pmu: add specific compatible for Tesla FSD
Date:   Tue,  5 Dec 2023 10:22:27 +0100
Message-Id: <20231205092229.19135-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205092229.19135-1-krzysztof.kozlowski@linaro.org>
References: <20231205092229.19135-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
 Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
index 28e2cb50d85e..65f77442ff23 100644
--- a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
@@ -53,6 +53,7 @@ properties:
               - samsung,exynos7885-pmu
               - samsung,exynosautov9-pmu
               - samsung,exynosautov920-pmu
+              - tesla,fsd-pmu
           - const: samsung,exynos7-pmu
           - const: syscon
       - items:
-- 
2.34.1

