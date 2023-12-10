Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6124080BB22
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 14:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjLJNjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 08:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjLJNjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 08:39:13 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C28E3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 05:39:19 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-55114c073b8so385399a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 05:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702215558; x=1702820358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SxGHOiWgHxymjdsJtkFtmgKrK8IqfIoFz7FXA4eYB1c=;
        b=tfyizqw0F2/z2HfPu2743RC9QHe0G2gPYITGl+HQiF6fKUFod+hw7uMuUNdHfH+/b4
         WfCKFLg0/mxOOTQPUrJCIB0+wlfH6cM3hlCShwlwFGkKrw12WxcBWpZq8BHc1fwlsbVj
         tYfHE5A/I1z8EDINkMMgtZX5HLESdmEbAwzsryhPLtysLrDt1cRp6XlzE/OYjEUTnQgE
         KLg7rnKH+1NULcQGEQwIEN6zv9vQKWCWlY8tjhKReltvTh46rDEheyGJONCWA/Cot+1h
         DuHQF1kjd2PoZSoeyW3IRNOnl+btpQZgNWy3PfAJ30ovL60y7IXmtpQW68Xgq4dGyt0r
         pPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702215558; x=1702820358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SxGHOiWgHxymjdsJtkFtmgKrK8IqfIoFz7FXA4eYB1c=;
        b=u1ZZNbozyOmHxH2P/ZMVWUBVMav9e+io+Sy9oYlNwgBZoELy1rZg/oBEMnk7mIMLa9
         qZN/2g8D5s53POPrfe1B2VaEtVM8ajm2n7iqBJrzpBsOHMQnQ+ELVNngSmuPfR4KhUwI
         8rnm2U10japPjREXD69spGDsrsgGdeADvq5HSJHwZ54r/2s6tS5ow3uXAvZJZrDNr3GJ
         mTsII34uCQKziOXkVvbszFGJfgvuzaec9J+HPwSo7UkjBDN+QZ9Fl/LFOC0OgOfUlGyI
         3cr2IHtwY+cnXJYdP8nDtGDZpzYLFli3A/tq13M2F5joaG+/C5EoQthdM6P6sJNl0oWI
         n9zg==
X-Gm-Message-State: AOJu0YwmY3EtxTPdLe1VkWXXZeGY//0/J7T8tjiBWDOXB5TYg+cK2aYb
        q/bwAClAjhICceh5thHSC0iacvFA//hIudZgvco=
X-Google-Smtp-Source: AGHT+IFw5SzwXuPtqqHqx4JjsH98zOkWwB/gJiXNpta694i4eRZOIUChO/+jUI8egoc8FF90usE4aw==
X-Received: by 2002:a17:907:a0c6:b0:a1a:57fd:3590 with SMTP id hw6-20020a170907a0c600b00a1a57fd3590mr1008153ejc.13.1702215558224;
        Sun, 10 Dec 2023 05:39:18 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id sl9-20020a170906618900b00a1dee0289b4sm3404214ejc.169.2023.12.10.05.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 05:39:17 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pinctrl: samsung: correct ExynosAutov920 wake-up compatibles
Date:   Sun, 10 Dec 2023 14:39:15 +0100
Message-Id: <20231210133915.42112-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

ExynosAutov920 SoC wake-up pin controller has different register layout
than Exynos7, thus it should not be marked as compatible.  Neither DTS
nor Linux driver was merged yet, so the change does not impact ABI.

Cc: Jaewon Kim <jaewon02.kim@samsung.com>
Fixes: 904140fa4553 ("dt-bindings: pinctrl: samsung: use Exynos7 fallbacks for newer wake-up controllers")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Fix for my for-next branch.
---
 .../bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml     | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
index 2bafa867aea2..f64da7f58faa 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
@@ -36,6 +36,7 @@ properties:
           - samsung,s5pv210-wakeup-eint
           - samsung,exynos4210-wakeup-eint
           - samsung,exynos7-wakeup-eint
+          - samsung,exynosautov920-wakeup-eint
       - items:
           - enum:
               - samsung,exynos5433-wakeup-eint
@@ -45,7 +46,6 @@ properties:
       - items:
           - enum:
               - samsung,exynosautov9-wakeup-eint
-              - samsung,exynosautov920-wakeup-eint
           - const: samsung,exynos850-wakeup-eint
           - const: samsung,exynos7-wakeup-eint
 
@@ -112,6 +112,7 @@ allOf:
           contains:
             enum:
               - samsung,exynos850-wakeup-eint
+              - samsung,exynosautov920-wakeup-eint
     then:
       properties:
         interrupts: false
-- 
2.34.1

