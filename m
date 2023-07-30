Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169A076892D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 00:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjG3WrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 18:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjG3WrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 18:47:23 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79FAAB;
        Sun, 30 Jul 2023 15:47:22 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so45354345e9.2;
        Sun, 30 Jul 2023 15:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690757241; x=1691362041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nn/YS1vmiQY8qJ3o3Iu5t377DFn8tJLv5hlAgdngATI=;
        b=EJ7Y/7SUErrk8Sz1k2UNNRDf/1WA8lVzktv1RE0w0DvCvcYdIgw8447LG7kNToN8uu
         /zjNviu7QpKXQFfiCTUH7F/WuLt4r1s7y1hnOOUbXJzn/FkeAaiXmIVuvACECkivGoAa
         HUXOi9sDw6nV715vLF4TPGavctjQ45nTJQ7cw0LCMOAfVFW7fjHAUeXGhk2OJ7A0xUbZ
         tiGckM7OaU+0bP3gLoGOGAp3za+KBBP5kQJMWzP4do3Jf5Um3uPgP2bfmJPQHleDX2b3
         cgLNtqZwqmAKLwBkdG0IRrGIds0i1WQ5db+4xOzdxLOAEEbt449a0ZdUjoBsLhtn5bpA
         AP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690757241; x=1691362041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nn/YS1vmiQY8qJ3o3Iu5t377DFn8tJLv5hlAgdngATI=;
        b=UR/8TqdMi2YUAlu0gqyqDGifkvd9JnLZIBAtcMZD6oGR50m5WIsvZiJ7nHQAQ6IRq2
         MjO5cosdGRL9OgMh4y44xemL+ghtZBB9OAuXSuvbg6wDyCZBwvPu7zKLSBIyju5UQUSE
         pk8Maj5R9Rt78Uk/530r+X04t1jDBLyS6xkaVcfOvvrn5jcA/N+jDw/CvXL4Dn+z4kgN
         sSfxuLRL/I5ZIQb4gfRDEoOKictnknehZQ7IkKgKi9mNUx1yUvJUU56m71BP1qt0Rsx9
         8vokyl567cSLVfTcyxxCLuDN0SwYjz/Bphx1J7bSypAWSFWfzuivN/tLoevLVWpCwQzq
         vBQA==
X-Gm-Message-State: ABy/qLaG7W3Co5nU72JzOQrm2JtF39Kku/HsEner44Q3lfJbKVpgpekU
        ob+vYKbm3WWQPNdiAHGf7eQ=
X-Google-Smtp-Source: APBJJlEs7FmEW6uHsm7c/7UKGIUKbZfoVqCU1+8JIvTl0l8N1Ghi1Zm14ejT/MDuxwAvQGv3FCP0/w==
X-Received: by 2002:a05:600c:acc:b0:3fd:30cb:18bd with SMTP id c12-20020a05600c0acc00b003fd30cb18bdmr7703035wmr.15.1690757240708;
        Sun, 30 Jul 2023 15:47:20 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id x17-20020a05600c21d100b003fbca05faa9sm9674900wmj.24.2023.07.30.15.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 15:47:20 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: sunxi: Explicitly include correct DT includes
Date:   Mon, 31 Jul 2023 00:47:19 +0200
Message-ID: <7549938.EvYhyI6sBW@jernej-laptop>
In-Reply-To: <20230714175152.4068286-1-robh@kernel.org>
References: <20230714175152.4068286-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 14. julij 2023 ob 19:51:51 CEST je Rob Herring napisal(a):
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/soc/sunxi/sun20i-ppu.c | 2 +-

Sorry, ppu driver was moved. Please rebase on top of:

git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git 
genpd_create_dir

Best regards,
Jernej

>  drivers/soc/sunxi/sunxi_sram.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/sunxi/sun20i-ppu.c b/drivers/soc/sunxi/sun20i-ppu.c
> index 98cb41d36560..8700f9dd5f75 100644
> --- a/drivers/soc/sunxi/sun20i-ppu.c
> +++ b/drivers/soc/sunxi/sun20i-ppu.c
> @@ -5,7 +5,7 @@
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/reset.h>
> diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
> index 4c4864cd2342..4458b2e0562b 100644
> --- a/drivers/soc/sunxi/sunxi_sram.c
> +++ b/drivers/soc/sunxi/sunxi_sram.c
> @@ -15,7 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>




