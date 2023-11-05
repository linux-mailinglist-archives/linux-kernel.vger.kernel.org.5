Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB3F7E15E5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 19:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjKESmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 13:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjKESmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 13:42:06 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA5CE1
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 10:42:04 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4084e49a5e5so33392165e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 10:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699209722; x=1699814522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5p4QFuKK4zDjK7JmREfNGLdO3brtt0j7Hb6QAgVUrUA=;
        b=OIhvOYboV1EiTNo823HwkLD07VFpY/fKWC2In1TCyLOts0+BKCKCnlHdYm2sR62XRl
         pxzx46OdYvL/Zel35k6R14gX6j8EAgk+mhhUFm5WW28W5hDlYe/HWeYohaPqosWYxxDa
         iyXzhD/LOT75vbi/7z24LMOsJA5WwdK2i6qj2GAEiU5EweqEqa2NalZrbuP2buf6euYH
         riVUfUUwZL3y3NQ2PIc1aeFeKqBzaPmazBXJl3ApPo2mdtn1PzirY9SSrAXt05jA6yd5
         04x1l6F3hGYJYOpP3I4ZI8OjP2pH4hb8nuGf0KOZnoE4l35ai8UpNy05T3nwCGz8DiE7
         Z6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699209722; x=1699814522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5p4QFuKK4zDjK7JmREfNGLdO3brtt0j7Hb6QAgVUrUA=;
        b=JlRPQqXxh0vpuYwcc4MBPdGpvvNBxriK7hURANYfc5YgX1e1tOuOGg1hRE5DjqcNoA
         fCupdeZkmaVOjhyWbatJeXIjyS6hdTOookCpyq8dv4RancblkXXkgkkPtiGd45vonawU
         EsMEE8c9X3j8xxRSjT/g3k1h2d98WRKdDc3d9c2Xb4UXe0U3bbzWKExX5vCeVtbVYOUI
         TYJ31cKdD17ZW7dZAsVQDBjcEdsf51rfRV4lkgqIWR/hNHyfFQoJOvd80GjzfB86YtIk
         r1sRrNDdkLUXrE2K8ORJvaPdLvlO1mko4XjdpypSUoZ/2VmPEN/JsxsxZoX9NQiMKjhJ
         mt5Q==
X-Gm-Message-State: AOJu0YzOtW4tt07GBMmCIduhzQ5C6d0aN0Uepr6Mu78EHVnLYYSBRVKY
        UTR75SBbPIQOYbKpIgQUTKOcdg==
X-Google-Smtp-Source: AGHT+IFSpmafwOZq0U7CWe+nXmQRtHQOLcDbi+JWbFPNcxG5YLhYbhIL0Wd8ASmATcTAoMtu5NK/OQ==
X-Received: by 2002:a05:6000:18a9:b0:32f:a5af:99ca with SMTP id b9-20020a05600018a900b0032fa5af99camr11998596wri.69.1699209722530;
        Sun, 05 Nov 2023 10:42:02 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d44d1000000b00326b8a0e817sm7370111wrr.84.2023.11.05.10.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 10:42:02 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Julius Werner <jwerner@chromium.org>,
        Evan Benn <evanbenn@chromium.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Maxime Ripard <mripard@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Justin Chen <justinpopo6@gmail.com>,
        =?UTF-8?q?=82ecki?= <rafal@milecki.pl>,
        Baruch Siach <baruch@tkos.co.il>,
        Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jamie Iles <jamie@jamieiles.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dt-bindings: watchdog: intel,keembay: reference common watchdog schema
Date:   Sun,  5 Nov 2023 19:41:54 +0100
Message-Id: <20231105184154.43700-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231105184154.43700-1-krzysztof.kozlowski@linaro.org>
References: <20231105184154.43700-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reference common watchdog.yaml schema to allow "timeout-sec" property
and enforce proper device node name.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/watchdog/intel,keembay-wdt.yaml      | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/intel,keembay-wdt.yaml b/Documentation/devicetree/bindings/watchdog/intel,keembay-wdt.yaml
index 1437ff8a122f..8231dde2bfa6 100644
--- a/Documentation/devicetree/bindings/watchdog/intel,keembay-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/intel,keembay-wdt.yaml
@@ -9,6 +9,9 @@ title: Intel Keem Bay SoC non-secure Watchdog Timer
 maintainers:
   - Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
 
+allOf:
+  - $ref: watchdog.yaml#
+
 properties:
   compatible:
     enum:
@@ -37,7 +40,7 @@ required:
   - interrupt-names
   - clocks
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

