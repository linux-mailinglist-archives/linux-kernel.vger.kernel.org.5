Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAD280C231
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 08:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjLKHmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 02:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbjLKHmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 02:42:10 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DC911F
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 23:42:12 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c9efa1ab7fso50211341fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 23:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702280530; x=1702885330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wKKZxDmRdHJfZg5vgJP9rGg6SAla387qKCYSstr8Kc=;
        b=YaKMIsdStTqdVebCXALV2nhdJ97QevgAtygQN8L9JsR+Pu2XoqY/X02wIQRPWH8XgK
         2oDFTKvGfewKBmLUCPlqysMZGhHHSAc28RQDvf+7rIO5OLKaozy37D/6HUoBiKRy5Y04
         X2D5C37EkVUc4uiGg+vZ+LwIB3POVK3LFrcNjg4gZqkVhkPpiKOWsh8KYXU41dWk9+qV
         HGV1OrsCSCEKFvXYjQUMH+FcQvNcccgys17xFyL8HUi/PplSnA+oHgSmzsFhuWDFJoKc
         agn2lY7SfhYvkVQnoDBe+9qByueHW+AeLmKmNiPezN6szQA0wsn0aLHF+asx9q4NYjI0
         5U6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702280530; x=1702885330;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wKKZxDmRdHJfZg5vgJP9rGg6SAla387qKCYSstr8Kc=;
        b=SB6nTt1Jb2p2+NEFu/y094tqmDfX7KDhuSytGORgmXrgVWnMJ1Pwz7jTYCAnULujNh
         YLmO9zUWOCtyEfwqbjlI3KHlfVyGum2pZGaQdnbe29N0mVL7UbyY8WBz2ZVdtq55P78k
         to8H+XIiB8x28hDq0I5cyWLkOGiH0KWg8FKQL7q8Y8n/EDnCDLtKEyogEOnd4HiA9MQ8
         Sw23kYtObwt8c92RHc5iMCUf5NQO1p/eya2UOxFgY+nDmoYGvGstk6odeAB4+qxpKKcU
         M2vUzVc9xYYA0WgTjbcpReToTkTfH97ZWDdZwyhAOQcf/AFFxz7eFhtVEm2VNuXQyiUG
         p2ug==
X-Gm-Message-State: AOJu0YxwwZ8PuRz1zu7OFJR5oVGMBZxq/YZgx3EZ1uVZoxe+w0hvW0CD
        +rmzh+UMoYjKSBF4fVQEeQJr2A==
X-Google-Smtp-Source: AGHT+IHrYWva0hhXwHNZ3bFsYGJLX8JxJFGhEdf2mByN3FJTQFZBPEd4cfcnGG/i7DGktj7oYGPqaA==
X-Received: by 2002:a2e:711:0:b0:2cc:1e7b:3612 with SMTP id 17-20020a2e0711000000b002cc1e7b3612mr329330ljh.65.1702280530479;
        Sun, 10 Dec 2023 23:42:10 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id s30-20020a05651c201e00b002ca0217f327sm1116269ljo.65.2023.12.10.23.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 23:42:09 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20231208074527.50840-2-jaewon02.kim@samsung.com>
References: <20231208074527.50840-1-jaewon02.kim@samsung.com>
 <CGME20231208075020epcas2p25f18d225f91f185085078461b290cb19@epcas2p2.samsung.com>
 <20231208074527.50840-2-jaewon02.kim@samsung.com>
Subject: Re: (subset) [PATCH v3 1/4] arm64: dts: exynos: add initial
 support for exynosautov920 SoC
Message-Id: <170228052808.12030.1188300498236704832.b4-ty@linaro.org>
Date:   Mon, 11 Dec 2023 08:42:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 08 Dec 2023 16:45:24 +0900, Jaewon Kim wrote:
> Samsung ExynosAutov920 is ARMv8-based automotive-oriented SoC.
> It has AE(Automotive Enhanced) IPs for safety.
>  * Cortex-A78AE 10-cores
>  * GIC-600AE
> 
> This is minimal support for ExynosAutov920 SoC.
>  * Enumerate all pinctrl nodes
>  * Enable Chip-Id
>  * Serial0 for console
>  * PWM
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: exynos: add initial support for exynosautov920 SoC
      https://git.kernel.org/krzk/linux/c/c96dab1993d247b7b05ba2fdef8f185cbbd5454e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

