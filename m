Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4897BCE39
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 13:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344727AbjJHLhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 07:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjJHLhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 07:37:52 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8772CEB
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 04:37:50 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-405524e6768so35348655e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 04:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696765069; x=1697369869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dhou/iQjgPMNfD8wPNvACa70iSwou2YDuR+hhlISzLw=;
        b=pW4BbnoRSgUasJg7OfVMFf1yXsHBY4jTNB02M/M8VuznXbh8MkVLgpix86IkSG48W2
         ceOVYbbi3RxQgT+WOHLmwtTgYenPkHU2VtRAyd7r2+ggf844Li8YxGEt0vwDYErMwWRc
         ERBCsz2g0cfp3o2SIdyCAvsFkS0yHNr0qkoCExOT0TcZV2F46pgN6b57QWydQ2E1lZ2H
         PPZ8FFwOCi3WSm9CJRC5VOPSGI7nxBCaxZ97/UMjyOPFPiyDUkkN1ttgsItbJP5KazL5
         PzlXR4v+5PtUjx1oKtC2kob95heO/vn+cyud0pRbja8IVj7Zychg4Y72cxLvn833cG0Q
         aoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696765069; x=1697369869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dhou/iQjgPMNfD8wPNvACa70iSwou2YDuR+hhlISzLw=;
        b=O5W9CcZeBApVmwc9QNUxhwv9h+kw4A7PspTlmcqhQee18/PrAjRVmCgJay3oNMaPuO
         ks+n0JTi52GDgTM5VO+mxxy5oGi6KJR0euHldhSl3ATHPWhC9VsoOqdIVSCZqGjEKDTC
         luf+wXMfL9bcTxVuJDBozRkFeiD3YNivAbgKwZ3ODedKUNWMPyYRW9MfDlzPTT9bb8/c
         HYWK3EU7N2ndMQRo6YwDpxudpa5YJsYywqE17yJkjOj9APRTqeOJUzIQOkTxwKJLZuGU
         mjKWVhP+AZEg9uwc9qC1B8wxAjtzVBzqhgcX8b3AHQTQWWAhnUGJrFOMZlSy6xUUM4bk
         pTqQ==
X-Gm-Message-State: AOJu0Yz2vxp3CHRWMvlgQrQPZuKCH6eWeslcwXE4+tm/GToqUXRTM4DM
        W2t6rmDM7DfC6yvnFoaW6KDvxQ==
X-Google-Smtp-Source: AGHT+IHfU/4FonXooH8mQh6VhiaLNCGIy3nUcvXfhakX0VtM/Y+M17cRdFlbYAwKC6lTVuO4vitI/Q==
X-Received: by 2002:a05:600c:2113:b0:401:73b2:f043 with SMTP id u19-20020a05600c211300b0040173b2f043mr12078730wml.1.1696765068892;
        Sun, 08 Oct 2023 04:37:48 -0700 (PDT)
Received: from krzk-bin.. (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id m10-20020a7bce0a000000b00405953973c3sm10577942wmc.6.2023.10.08.04.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 04:37:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] pinctrl: samsung: Annotate struct exynos_muxed_weint_data with __counted_by
Date:   Sun,  8 Oct 2023 13:37:45 +0200
Message-Id: <169676506007.13281.4277310481310428464.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006201707.work.405-kees@kernel.org>
References: <20231006201707.work.405-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Fri, 06 Oct 2023 13:17:07 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct
> exynos_muxed_weint_data. Additionally, since the element count member
> must be set before accessing the annotated flexible array member, move
> its initialization earlier.
> 
> [...]

Applied, thanks!

[1/1] pinctrl: samsung: Annotate struct exynos_muxed_weint_data with __counted_by
      https://git.kernel.org/pinctrl/samsung/c/4e1e21117e7e1275477ba80e634c769a511249bd

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
