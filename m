Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C9675852A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjGRSyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGRSy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:54:29 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CA4199
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:54:16 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fbbfaacfc1so9943898e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689706454; x=1692298454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvHXXC5n1uZ0AxYD49mZD4I5ePIf6P0IGN301whWC4Y=;
        b=YCw2FxaQe0fS746f3Zg6kyy0mPHJFPcxQCuz3iBYO6KWAVJR8biEfK+xTD235L54HY
         y5UnQ8yOUM13/lODRTtZGLicYIbcAnbgvQJA6rWXGC5Af/eIhkuTMF1C2uOe2wBKktDh
         L4FiJm8+ZJPPFgRaqOP06mdrXOqnezk06nq3DpdjCfdFO9kKkuNB1FNg6GuPwil7+Ft4
         emC3DdI9a1DWGEmVYUR7XNE4IJMTpdd9q11l0uTDp/t5kQaglbLVgV3K/2s4ayH1BP/1
         UfymOZncKXJJp79doaeRDjUEKhK/ayHBPYK2GqLwY82fU3Mtxh5mU3DTxmc8wVmFLdoN
         Qj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689706454; x=1692298454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NvHXXC5n1uZ0AxYD49mZD4I5ePIf6P0IGN301whWC4Y=;
        b=bU6Uc7B/9z6rAiCt1LBUVD+GVAuu+GPXkDLwTPlAYGchfhiKjayyl3piv2H4SnS9M3
         WgQvMJ3IMX4wm5aLmrhe9xMxCpxhCUHMdyXMahvo8PH0ejXbHUk1Bo2NHaMNaFOVYc4n
         /rDxzDqyANRUVLY3BRhQuID7Hjdy2SvRijO5A3Fj48KEc05ThKEwfIC+RGXkvhOu+CpA
         ZzPBUswqbwZTY05jjnqj1oo76WF3c/hpFrHDpU5+KGO12EmM1NHO51cyAxMm7o3dTUWs
         wg3zF687b3pD9zl2m7COJHcGm9mGWTgV6Llz3mDIDEFsknYfThQVqpiUTc+hCW3VQZn1
         hN6Q==
X-Gm-Message-State: ABy/qLbuFKqWZGXdnw5T3p9JLbzHNglg4YqJVfm085peHLLxueXwXi9v
        q33ZWDMSlrFSyC8uEgXqo1xdmg==
X-Google-Smtp-Source: APBJJlEmJtRDRmErj1dWjqW5H0FvmW0qCWd77Rraj/v2e0/CrlF8S9Qa+VC3Pmb+EFFauDws5ZkCFA==
X-Received: by 2002:a05:6512:1320:b0:4f8:7803:64e6 with SMTP id x32-20020a056512132000b004f8780364e6mr10007681lfu.41.1689706454522;
        Tue, 18 Jul 2023 11:54:14 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id z11-20020aa7cf8b000000b0051df13f1d8fsm1608611edx.71.2023.07.18.11.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 11:54:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michal Simek <michal.simek@amd.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] memory: Explicitly include correct DT includes
Date:   Tue, 18 Jul 2023 20:53:55 +0200
Message-Id: <168970643388.118933.13930948330074254710.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714174717.4059518-1-robh@kernel.org>
References: <20230714174717.4059518-1-robh@kernel.org>
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


On Fri, 14 Jul 2023 11:47:16 -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> [...]

Applied, thanks!

[1/1] memory: Explicitly include correct DT includes
      https://git.kernel.org/krzk/linux-mem-ctrl/c/0b7fd1fa7a048b444b56f9d217c5917aa255d5a5

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
