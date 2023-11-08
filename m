Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E6E7E53AD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344336AbjKHKoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344370AbjKHKoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:44:02 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBF41BD4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:44:00 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4083f61322fso48635165e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 02:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699440239; x=1700045039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAjfTJh92uvbCJqXeCi670gcjaUuY+h2OqROwS33rLc=;
        b=hY5KIDh5hsZxVwhLfTKBUVrVz5npia1F21b068Tw9AAURGCX1u2TucQihDQyEphwKq
         6vowusYI3F+q704E+HkI2qSiF/C7Ky6UDmQ3G4BsFMN5YxySiQLixsz2Oa3LMqP0H5tl
         kDNboMWeFGBl6YPByRE/aNR7U2s6Fsz3SVxb/r7ZRugVlhUHjEcmTynBagwLFvMnjofc
         5hFMHeOMRNnbIDcuMMEI4iB/y2DyynOl72Eku3KNTht8vXj36o2akDp49SCYe8jp0kfi
         24kG+NIhCsuaVDRZtNI8lo3UQAypL72itK0eqJc0UTpUXEfJPLTKsTH9/dIC0uYlMDmX
         DPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699440239; x=1700045039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAjfTJh92uvbCJqXeCi670gcjaUuY+h2OqROwS33rLc=;
        b=g/NCvmxZ1WRtfoSOH3/NmxWRORgu7GHZ1+nx9W7Pv0GSWcUxBPmMJ/0UF4EY6tmDex
         WzZsttohfmgUemQ30AIapxxizigkRUsq02tt1vFi9jfKCkauVh6KP0BFh1I4gnQr6W+t
         IXYqvv43kIL068lP79G0wsqc9oBkW4QEHbkwFGKUuEqIWz02uiaRRiV8GPPVKXhDgKx/
         DcG7+HaubNJ7ZZC+y563yDTlYqQfTDNcCgKk+qdlZWp5YLeRJHhI9mQUfsu/0qZaRPlV
         rDdihvhj/+Y3xSpJswNb3Kpsxicabw766Tus0WHHmAqIuQJSF4EmiLEUeq9lxxwcbAO4
         FlDA==
X-Gm-Message-State: AOJu0YwSQJtbGZcXgi0dAhBaX2M3Bz6uMtMsrjEW/upCFGN3Ufgf9P7c
        /pAnzvMWMdOZUBvuyfVK3JtqRA==
X-Google-Smtp-Source: AGHT+IHIdIU7uiCUR0CHcHyVefUtJ+PHqY1ijnjV387qyUxWKGaH50797907TE+JsncllGcRuZSEtA==
X-Received: by 2002:a05:600c:3104:b0:406:3fda:962c with SMTP id g4-20020a05600c310400b004063fda962cmr1471144wmo.31.1699440238661;
        Wed, 08 Nov 2023 02:43:58 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id fj12-20020a05600c0c8c00b004094c5d92bdsm19377377wmb.31.2023.11.08.02.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 02:43:58 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 01/17] dt-bindings: hwinfo: samsung,exynos-chipid: add specific compatibles for existing SoC
Date:   Wed,  8 Nov 2023 11:43:27 +0100
Message-Id: <20231108104343.24192-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108104343.24192-1-krzysztof.kozlowski@linaro.org>
References: <20231108104343.24192-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samsung Exynos SoC reuses several devices from older designs, thus
historically we kept the old (block's) compatible only.  This works fine
and there is no bug here, however guidelines expressed in
Documentation/devicetree/bindings/writing-bindings.rst state that:
1. Compatibles should be specific.
2. We should add new compatibles in case of bugs or features.

Add compatibles specific to each SoC in front of all old-SoC-like
compatibles.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

I propose to take the patch through Samsung SoC (me). See cover letter
for explanation.
---
 .../bindings/hwinfo/samsung,exynos-chipid.yaml  | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml b/Documentation/devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml
index 95cbdcb56efe..45f3d468db7c 100644
--- a/Documentation/devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml
+++ b/Documentation/devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml
@@ -11,9 +11,20 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - samsung,exynos4210-chipid
-      - samsung,exynos850-chipid
+    oneOf:
+      - enum:
+          - samsung,exynos4210-chipid
+          - samsung,exynos850-chipid
+      - items:
+          - enum:
+              - samsung,exynos5433-chipid
+              - samsung,exynos7-chipid
+          - const: samsung,exynos4210-chipid
+      - items:
+          - enum:
+              - samsung,exynos7885-chipid
+              - samsung,exynosautov9-chipid
+          - const: samsung,exynos850-chipid
 
   reg:
     maxItems: 1
-- 
2.34.1

