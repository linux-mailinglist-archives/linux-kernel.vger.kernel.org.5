Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC79D7F6CFD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjKXHlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKXHlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:41:12 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024AED5E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 23:41:18 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9fffa4c4f43so223454966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 23:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700811676; x=1701416476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fe7LFiAVDzLRSxjoOCH/kO6LIkOeWYMi0jJKMHO+M30=;
        b=EFeVVzcaKgPj8Wuw/qGbs778MDt/hrO/YETUFBa4H5Fk+0XzKiVNaYrsiUTqEW+02n
         DqcBSZzHjwjhDnHdf7sNM4nStGbvzhX/3WVW1EM1CL3WzdT8pQTB81Bq9VEpRx0SaqTa
         reDp4PArRiYAdTyIMLdpzeDIbm+9fFviTRRBjMc43OrR3RndiW5ZtoNbNMiLNhO4Z9Mo
         hgSXxeNO84eImfHF5sSRZsDz76uw9y8E6CuXBcyAEjlym/psA+pkpmofkiIRqozgWcyf
         FkJYFkTorbEwXjXuGRLhN+0ArWxMkJaSVf3j3eSJtnuxXiZz3PrOOvojK8A0werprcyn
         Pb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700811676; x=1701416476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fe7LFiAVDzLRSxjoOCH/kO6LIkOeWYMi0jJKMHO+M30=;
        b=NouWmrzj0ehLmi5NlIz+MHqjfNLNUqnaDonmYGRFlY9+BAG9R5l8dYWElwv/W++nnu
         qiwUPDKvc6Nda2ANBKEIsOz7yTFfNXIotVkc3yc/rEoDjP7Pdd6Hswjskb5aVHWbgWr9
         32AluRe0/wWUoVTVzceR1zYJao0Uj0lAFCBQ4pHbVxyBB+8cJGez348yxNcIJTdPKOLg
         yrkbgJQJZ8e4DyyV9inJxp6LyWgevvtbsUN60o2MyyeGzpOj736cOL1/hxXPlZq+pRKU
         Tgv/+DkWHZ3SDDCvV3yqvhYAjUcbHPi8a5tvPrhHVQQrAj04akOne55bJ/ZeOObsnARm
         SDUg==
X-Gm-Message-State: AOJu0Yz+TKGW+mKnizAUuTp1Sw7l9OV6ixcuIthJt5YgiZaYMCedTeKW
        58D1LOLZhJabgf3KyefZTsCYBA==
X-Google-Smtp-Source: AGHT+IHDrv06ivxtPgRXd+8inYekMaQKkAUnYCK1Xa+l7J5VfhociYD92/EJid18MCVCbwbs/iMh6Q==
X-Received: by 2002:a17:907:740a:b0:9e5:d618:d6c1 with SMTP id gj10-20020a170907740a00b009e5d618d6c1mr1110958ejc.19.1700811676466;
        Thu, 23 Nov 2023 23:41:16 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id hk15-20020a170906c9cf00b009fef7d22c98sm1736585ejb.35.2023.11.23.23.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 23:41:15 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Peter Griffin <peter.griffin@linaro.org>,
        semen.protsenko@linaro.org, Jaewon Kim <jaewon02.kim@samsung.com>
Subject: Re: (subset) [PATCH 1/3] dt-bindings: pinctrl: samsung: use Exynos7 fallbacks for newer wake-up controllers
Date:   Fri, 24 Nov 2023 08:41:13 +0100
Message-Id: <170081167113.4921.3456428823798140178.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122200407.423264-1-krzysztof.kozlowski@linaro.org>
References: <20231122200407.423264-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 Nov 2023 21:04:05 +0100, Krzysztof Kozlowski wrote:
> Older ARM8 SoCs like Exynos5433, Exynos7 and Exynos7885 have the pin
> controller with wake-up interrupts muxed, thus the wake-up interrupt
> controller device node has interrupts property, while its pin banks
> might not (because they are muxed by the wake-up controller).
> 
> Newer SoCs like Exynos850 and ExynosAutov9 do not used muxed wake-up
> interrupts:
> 1. Wake-up interrupt controller device node has no interrupts,
> 2. Its pin banks have interrupts (since there is no muxing).
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: pinctrl: samsung: use Exynos7 fallbacks for newer wake-up controllers
      https://git.kernel.org/pinctrl/samsung/c/904140fa45533f6d05071e24492013da16c46b7f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
