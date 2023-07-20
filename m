Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAE675B74F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjGTTA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjGTTAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:00:23 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30311996
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:00:21 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fddd4e942eso1501430e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689879620; x=1690484420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQomNpUaX8uEuBKLwEgdMw8BMnEp+ihhGySSLvfuPvQ=;
        b=FX36kePffn8oO/SylinhQV1prpyYkkLn9n2P8LG0ylZBgKM3nAkDCr2A3WA8E8tsvS
         EkBwldvEyv7aUsH0n2fJ/4BfNbMgKXrawRNMUYZlEV1FfuERM4sdYzweYiaDYkyJIhcn
         tuHSiH2gbTl+vZ62o1YwSsCwrWmogoiPU5qetOHYW1Pnfdd6WTY4bS8taVa60ulpA5Aw
         neIqhOMvInzdr86rRkxMiDpTy4gz22OfTFWKaZQu7tYQxBQbpVYJgUnuRmdCMvjiuvZm
         DQqwaP/IhEBTa6+XMOx00eIFoVwFFjoTcQx7y/p05H7QWXvMKsqf8hnGk0kR1YofGPVY
         APhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689879620; x=1690484420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQomNpUaX8uEuBKLwEgdMw8BMnEp+ihhGySSLvfuPvQ=;
        b=jlLU8pqEAbLPXvtgVVGxsmlHK6UsgnaLzJ1y7pDoo3A8fd37pJiy9VqaAecafVEHD9
         nLt2PYuAMzPPJK1fZaIhHjYfpZ8JU09UaUNepZm8mFGUiApEfVsrgDfeyaqj3/L5JeXx
         /9wgBP0yIJQOE+JT8gS3VaRSN5OrjvpyGKWdjeGZq18Mr/xXEcjK+Y2uvmqVmZvALyTC
         cq/wzOhAnFHvKgio8S8BF+WcddLQRROlwv0uF7deCxe7gx8I+PzVbhtQvj4xJNUKU1av
         zWQyoR+e+K5NZ2JkNmSQmcs1jyplwcLmnZWhqzstuy3HPNVLAcm3h0Vz1HqqX+nPVh4A
         jJEQ==
X-Gm-Message-State: ABy/qLZk5NUjfGh+2U3bcUA4N9n1sAk1RqpIyv9IMhtux4nFY1QHZt4K
        9EldLBpVQqpC1eRCvU24zJetPg==
X-Google-Smtp-Source: APBJJlHNK5A0jQzfJn/iSThb8HvAs7//k63YuMJ5ypEXy0+a4A09R0hYl+8G2OlfcGYXLF756Zzz2g==
X-Received: by 2002:a05:6512:5d0:b0:4fb:90c6:c31a with SMTP id o16-20020a05651205d000b004fb90c6c31amr2096440lfo.14.1689879620147;
        Thu, 20 Jul 2023 12:00:20 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id s22-20020aa7d796000000b0051e2a5d9290sm1104842edq.77.2023.07.20.12.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 12:00:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Russell King <linux@armlinux.org.uk>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: s5pv210: Explicitly include correct DT includes
Date:   Thu, 20 Jul 2023 21:00:15 +0200
Message-Id: <168987960900.215967.3313655352230014454.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720172751.2918776-1-robh@kernel.org>
References: <20230720172751.2918776-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Jul 2023 11:27:51 -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it was merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> [...]

Applied, thanks!

[1/1] ARM: s5pv210: Explicitly include correct DT includes
      https://git.kernel.org/krzk/linux/c/3027df7e739c4f3768690bc59f022a0af8e6712c

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
