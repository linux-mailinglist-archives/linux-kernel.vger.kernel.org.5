Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA30380C1FD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 08:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbjLKHgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 02:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjLKHgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 02:36:18 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F258ED9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 23:36:24 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-33330a5617fso4376069f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 23:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702280183; x=1702884983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YHBWFSpjhw0+JPItFiuftFwl12od6x19Q3Kp1H3E6I=;
        b=BLCdW7efF2tjpduz+TWYaE9woLpNDYKcrX2wH+l9JJAYZ/rdYKH2CPjyRTJl6TYke/
         eM7OwIYX7IVqwmND0ZRtX8cBrvrVaBcv5h41sto8GK/d5UfLXLmc3qt5EiUf+bd550jm
         DVT/DpRY+IJRagODb2tGkGJSWqHTx731HO+KmJERi+aebPqiaEOAUOyFuWunzVrZJeCb
         YdwxJBWfW8lqcNqSr3LkPQCU297oQSFteHAByRHCdQe41TetOBSTrWNJCBIPqjmnh04D
         v7tL/J0yE8sCu2kUzCjr/GQtHSXIlfigyY61o71goOldx8JaH+kIsTViHDY3V3nEINcV
         mBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702280183; x=1702884983;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YHBWFSpjhw0+JPItFiuftFwl12od6x19Q3Kp1H3E6I=;
        b=GztGDEPMvY3Owwx1Y32BWARhGxS85JKncSQjwpWYExgecbRlI5BsLupbKoJ6zZ8O0O
         X6u42dBIrRdkbMd9OyWcD30j2fdAvQYvTwSHPPQudg9A//7cmXX+Xjo5HhZE9x+DjjmT
         ++3hhi0YJ/UwfzoHxEpvpuwf//DowClrqavRtFIth1Wpgb/Kn/l0ST3ldcc74T+DLyPJ
         cZPcTHZTKVaGXLsgdv95nzmJ1LMlbEo2EDsKpOtNWs9UXq36nXqHVZTPBdjL2j2VHivo
         o2L4a1gRSoZldhK0QE19/UhBY+tnIf/LiX5ADTatevpw3YOUmrE6OTy6YgAxlvfQHA3v
         66AA==
X-Gm-Message-State: AOJu0Yx5zLLDQF2BV6vmNStTdngRS9FqX+PQ8TSwcIqY9wUCYZWM0zc1
        ncLa9tYm4bvgdOcL9i5QkfXb+g==
X-Google-Smtp-Source: AGHT+IHK1+dJ3/6VbSmAjUHE3obgzLfsu3H2LPctpshzkB4sycS+dJ6werIvZjF7MuQxeZLkp64tiw==
X-Received: by 2002:a05:600c:2289:b0:40c:317b:79f0 with SMTP id 9-20020a05600c228900b0040c317b79f0mr2120989wmf.140.1702280183340;
        Sun, 10 Dec 2023 23:36:23 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id s10-20020a05600c45ca00b0040c3dcc36e6sm7700311wmo.47.2023.12.10.23.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 23:36:22 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231210133915.42112-1-krzysztof.kozlowski@linaro.org>
References: <20231210133915.42112-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: pinctrl: samsung: correct ExynosAutov920
 wake-up compatibles
Message-Id: <170228018218.6375.7978493220422861783.b4-ty@linaro.org>
Date:   Mon, 11 Dec 2023 08:36:22 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 10 Dec 2023 14:39:15 +0100, Krzysztof Kozlowski wrote:
> ExynosAutov920 SoC wake-up pin controller has different register layout
> than Exynos7, thus it should not be marked as compatible.  Neither DTS
> nor Linux driver was merged yet, so the change does not impact ABI.
> 
> 

Applied, thanks!

[1/1] dt-bindings: pinctrl: samsung: correct ExynosAutov920 wake-up compatibles
      https://git.kernel.org/pinctrl/samsung/c/e1564d6f93496bcea3a6b2110eb54cc08f2aca72

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

