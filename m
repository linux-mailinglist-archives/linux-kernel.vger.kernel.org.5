Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F017E5B86
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjKHQlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKHQlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:41:05 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2311BFA;
        Wed,  8 Nov 2023 08:41:03 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1f03db0a410so4207061fac.1;
        Wed, 08 Nov 2023 08:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699461663; x=1700066463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsTKu+sClNoAUTcjNBMPlmIKhwCgTQjzIODuh++4wnE=;
        b=qKDgigQpfdd8s28hBiynox6K47lApGEOXZ4Kna1rZ7Z3HY53kXaSIbZN6IeExXpaV0
         sM5C0EDPgQNnTDStnemT4panO+Ye0R+kbWjMFfuQBgbNQQ0vs9Hq/G09BHyJ6zS+T+eL
         HALOJM3w/cLMG0gdFu4/Q/ytPCg9x7Ptv+uRCR30EZxX4Za7zuOpAcU/hgpI1DO+ZDo3
         Wx28pJr6ryDfei49ZSoXa/qxalvRf9zJpbwUbrdXP8ajFINBoD9Zt5YUc0xXQ6fRLNCg
         D8NilXBA/04CQxyNq/jMtWY1qTkv0+Sk9lHgrDea3EybbBQrfuXUBc6Ojupo+ZvQFHX8
         hJoA==
X-Gm-Message-State: AOJu0YwXP+ksu7sQfggfQW7Lcf3KhnZ/iDYDQfT3zlqNNwDnF9OTh0jt
        Be4rw8GBhUcJl2jUmUXdfw==
X-Google-Smtp-Source: AGHT+IFFx+edjIiqB4NK4vBfw8uz7RXBCMyNr1QjwNEmq3uoI7shn3K1VLDSF/eIjsJcWTRm2NjLdQ==
X-Received: by 2002:a05:6870:1290:b0:1f0:36b6:ef26 with SMTP id 16-20020a056870129000b001f036b6ef26mr2036560oal.46.1699461662736;
        Wed, 08 Nov 2023 08:41:02 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u21-20020a056870441500b001ea689d8969sm360210oah.48.2023.11.08.08.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 08:41:02 -0800 (PST)
Received: (nullmailer pid 2363957 invoked by uid 1000);
        Wed, 08 Nov 2023 16:41:00 -0000
Date:   Wed, 8 Nov 2023 10:41:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Hector Martin <marcan@marcan.st>, Chen-Yu Tsai <wens@csie.org>,
        Marc Zyngier <maz@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Jamie Iles <jamie@jamieiles.com>, asahi@lists.linux.dev,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-watchdog@vger.kernel.org,
        Julius Werner <jwerner@chromium.org>,
        Sven Peter <sven@svenpeter.dev>,
        Justin Chen <justinpopo6@gmail.com>,
        Evan Benn <evanbenn@chromium.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        linux-arm-kernel@lists.infradead.org,
        Guenter Roeck <linux@roeck-us.net>,
        Baruch Siach <baruch@tkos.co.il>,
        =?UTF-8?B?77+9ZWNraQ==?= <rafal@milecki.pl>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: re-order entries to match
 coding convention
Message-ID: <169946166004.2363897.10078496065927254544.robh@kernel.org>
References: <20231105184154.43700-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231105184154.43700-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 05 Nov 2023 19:41:53 +0100, Krzysztof Kozlowski wrote:
> The Devicetree bindings coding convention, as used in most of the files
> and expressed in Documentation/devicetree/bindings/example-schema.yaml,
> expects:
> 1. "allOf:" block just before "properties:" (or after "required:" for
>    more complex cases),
> 2. additionalProperties/unevaluatedProperties at the end of the file,
>    just before the examples section.
> 
> Re-order few schemas to match the convention to avoid repeating review
> comments for new patches using existing code as template.  No functional
> changes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/watchdog/allwinner,sun4i-a10-wdt.yaml     |  6 +++---
>  .../bindings/watchdog/alphascale,asm9260-wdt.yaml      |  6 +++---
>  .../devicetree/bindings/watchdog/apple,wdt.yaml        |  6 +++---
>  .../devicetree/bindings/watchdog/arm-smc-wdt.yaml      |  6 +++---
>  .../devicetree/bindings/watchdog/brcm,bcm7038-wdt.yaml | 10 +++++-----
>  .../devicetree/bindings/watchdog/cnxt,cx92755-wdt.yaml |  6 +++---
>  .../devicetree/bindings/watchdog/maxim,max63xx.yaml    |  8 ++++----
>  .../devicetree/bindings/watchdog/snps,dw-wdt.yaml      | 10 +++++-----
>  8 files changed, 29 insertions(+), 29 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

