Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7BF804D84
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbjLEJWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjLEJWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:22:32 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB71C9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:22:38 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c039e9719so34045185e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 01:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701768156; x=1702372956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3C3srF3D8XYNvvxDZciqMxRHu1Pp1JgH8p2QBUBIXkw=;
        b=LbYbJvKCyoR0fX5rvZXjbtu4Ybw/+a5FWhP1PP6BbHfKYbo5BNkewJ+hgygNuMbbfb
         /qMnER1RBlOQZrXr+KCsjIxu5BJOdE6ohdZDTv84hM1FRbKSPCf0sB/cDoB4gae9pBow
         P05/prW4TiUa6aQci9KMzvPu+MxruHziMYlf7TLGh/oFUGnRgaEDSHpQfwDvBSlee2/X
         SG7jSv7QkvV14QuPqcEC+sufy2rkeeb52uBzur/jTGQVDJiEPB4OT6fEJJqtApV2QPMd
         cupxxeuzX2AnkuogDC6qeh8KNyvRHVfpKLagAxtExy//vrFEowHSEaWJ6zzG2qt82ege
         pvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701768156; x=1702372956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3C3srF3D8XYNvvxDZciqMxRHu1Pp1JgH8p2QBUBIXkw=;
        b=knHtO0KEPEvifPUWX7PgM0LDo9K0cin4S3uTpZ6AYmCokkNXkZaO/IYqOrOdcla9St
         36xIS0T7ku8sREi2XT4DADN68VrgrOGyDJC/v9u6uwgnP4U/S8v9soM+7kbXt52shQCP
         gZIpCjd8INiG9cTaTsY63pm0EkHtDSNkxh5IumiqwUNm/KarYC/FjpiPM276zGtc65ZO
         FYG0DRa8aM7+ENNEkU5HIO4dEbxVaJcdn9GfgwX6NsVemeaIvR3np0gVO2mD4JdmOpMM
         kvLL2/N6h0FfAof8T4syvqwSUYuJK7g04xpAPTiyJr83DEc4dj7c++VNBXyplvAonFhg
         3b2g==
X-Gm-Message-State: AOJu0YzpumNnUfOtRTjbsD2B0iL0PfO1/dQaMkV5o4L4mXKu8ZUtBFNq
        a+S8wcsWVRATyBNNRWKtEtNjng==
X-Google-Smtp-Source: AGHT+IHl1sh2a9wDuPh2SdUnHcBKEzFK7tAktSyin1IN1vDeUa5puQnLRQ3RBX1u+xjKvk6Sg4pviQ==
X-Received: by 2002:a05:600c:1d83:b0:40b:5e21:ec3e with SMTP id p3-20020a05600c1d8300b0040b5e21ec3emr277886wms.112.1701768156506;
        Tue, 05 Dec 2023 01:22:36 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c4eca00b0040596352951sm21692287wmq.5.2023.12.05.01.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 01:22:36 -0800 (PST)
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
Subject: [PATCH 0/6] dt-bindings: samsung: continued - add specific compatibles for Tesla FSD Hi,
Date:   Tue,  5 Dec 2023 10:22:23 +0100
Message-Id: <20231205092229.19135-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Merging
=======
I propose to take entire patchset through my tree (Samsung SoC), because:
1. I already took similar work this cycle:
   https://lore.kernel.org/all/169997520487.6747.17671551558724027958.b4-ty@linaro.org/
2. Two new SoCs are coming (Google GS101 and ExynosAutov920) and they might
   touch the same lines.  It is reasonable for me to take the bindings for the new
   SoCs, to have clean `make dtbs_check` on the new DTS.
3. Having it together helps me to have clean `make dtbs_check` within my tree
   on the existing DTS.
4. No drivers are affected by this change.

If folks agree, please kindly Ack the patches.

Description
===========
See:
https://lore.kernel.org/all/20231108104343.24192-1-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof

Krzysztof Kozlowski (6):
  dt-bindings: i2c: exynos5: add specific compatible for Tesla FSD
  dt-bindings: pwm: samsung: add specific compatible for Tesla FSD
  dt-bindings: serial: samsung: add specific compatible for Tesla FSD
  dt-bindings: samsung: exynos-pmu: add specific compatible for Tesla
    FSD
  dt-bindings: watchdog: samsung: add specific compatible for Tesla FSD
  arm64: dts: fsd: add specific compatibles for Tesla FSD

 .../devicetree/bindings/i2c/i2c-exynos5.yaml  |  1 +
 .../devicetree/bindings/pwm/pwm-samsung.yaml  |  1 +
 .../bindings/serial/samsung_uart.yaml         |  1 +
 .../bindings/soc/samsung/exynos-pmu.yaml      |  1 +
 .../bindings/watchdog/samsung-wdt.yaml        | 21 +++++++-----
 arch/arm64/boot/dts/tesla/fsd.dtsi            | 32 +++++++++----------
 6 files changed, 33 insertions(+), 24 deletions(-)

-- 
2.34.1

