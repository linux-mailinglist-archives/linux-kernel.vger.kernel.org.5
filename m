Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B333774913
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjHHTsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjHHTsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:48:09 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DA74D23D;
        Tue,  8 Aug 2023 09:52:30 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9c55e0fbeso91203741fa.2;
        Tue, 08 Aug 2023 09:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691513547; x=1692118347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4GZEtgKcvcc8+oIk59W0NrrRnhk8BlCIE1dNVvTtSjk=;
        b=aQV+jZ4uj/9HDShaRtKJhaVlG7NDnXkPWz+5lh6k1U7V6YXP1LZqKDACAZ7Cw1JIbG
         5AfiSMw21R8XHEKo7X2cGGS/K19ButihYopcdNFxz6ljc+NV2mdK7zGDnPjoRt6BlDt7
         6vaz7SkwtSO1aAObyjlVm59tIWenREC7iNdhIo26RQwlnIZVXRWuxNHoXS1ya3d2aMaJ
         /m48WuwDvpJBQ71gYH0PFFHRs6eHO3LXiBjgJyTxla7YwtsC3uNhuaZ8nRrjGgiDVejP
         Rn1TUvMIlKz1684Br0Cf0zYIFaMdZK8MV2FAaniS8Un7AEThLj9Z1g1X0WHIrAPtmic9
         pnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513547; x=1692118347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GZEtgKcvcc8+oIk59W0NrrRnhk8BlCIE1dNVvTtSjk=;
        b=dPE8QAveMYZVppEz0OD81mFvCeb8byv7CpG/3MNrP3FNXvZnv9z20o7gthb27JeaxL
         4kAR9JZrEjfTL11eorpD+UzCJcnhAUlBjWopAmHv+DhF+TJsRwoKZ/gupFAhpQG9dnev
         wPHIeEeNVnpf5fGV7OZ4DHw++LQRMkC9d/g/dvNGr2hkUcG7hlYOoPr3v3Wu1iGZcq47
         U4xU5f0JegVcFxE39qr6LdRH33S8eE8F9yyVtUeMMOKa/V9s88+l7xge17549sqgqyy9
         LpHTcCVEv/WPMr/0k+JSKxPh/g4me2b8kmQs4XKwLij+eqNmgN1fL+WTDwL5LHbz6ci3
         xW7g==
X-Gm-Message-State: AOJu0Yzw3y5Btl8aB9BNQoJO8klJEN/r4IKTVbAi/dq3cLdnEX75WnfL
        J7lP8OUzIioHzZwkVU1tvfd6ulgvor+tu2+p
X-Google-Smtp-Source: AGHT+IFYYU0MR/Zcqb6+J48CUkgoJvTqm8kc0Jcx/tngfuJAbIwWw7yERBewTaL/SuluU9Sy9QSbtA==
X-Received: by 2002:aa7:cd5a:0:b0:523:363e:f6e3 with SMTP id v26-20020aa7cd5a000000b00523363ef6e3mr5195385edw.15.1691487332516;
        Tue, 08 Aug 2023 02:35:32 -0700 (PDT)
Received: from skbuf ([188.27.184.201])
        by smtp.gmail.com with ESMTPSA id i22-20020a50fc16000000b005232e637c24sm3676212edr.84.2023.08.08.02.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 02:35:32 -0700 (PDT)
Date:   Tue, 8 Aug 2023 12:35:29 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Daniel Golle <daniel@makrotopia.org>,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mt7530: improve and relax PHY driver
 dependency
Message-ID: <20230808093529.yeatw7tsecgo6ikx@skbuf>
References: <3ae907b7b60792e36bc5292c2e0bab74f84285e7.1691246642.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ae907b7b60792e36bc5292c2e0bab74f84285e7.1691246642.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2023 at 03:45:36PM +0100, Daniel Golle wrote:
> Different MT7530 variants require different PHY drivers.
> Use 'imply' instead of 'select' to relax the dependency on the PHY
> driver, and choose the appropriate driver.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/dsa/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
> index 3ed5391bb18d6..f8c1d73b251d0 100644
> --- a/drivers/net/dsa/Kconfig
> +++ b/drivers/net/dsa/Kconfig
> @@ -37,7 +37,6 @@ config NET_DSA_LANTIQ_GSWIP
>  config NET_DSA_MT7530
>  	tristate "MediaTek MT7530 and MT7531 Ethernet switch support"
>  	select NET_DSA_TAG_MTK
> -	select MEDIATEK_GE_PHY
>  	imply NET_DSA_MT7530_MDIO
>  	imply NET_DSA_MT7530_MMIO
>  	help
> @@ -49,6 +48,7 @@ config NET_DSA_MT7530
>  config NET_DSA_MT7530_MDIO
>  	tristate "MediaTek MT7530 MDIO interface driver"
>  	depends on NET_DSA_MT7530
> +	imply MEDIATEK_GE_PHY
>  	select PCS_MTK_LYNXI
>  	help
>  	  This enables support for the MediaTek MT7530 and MT7531 switch
> @@ -60,6 +60,7 @@ config NET_DSA_MT7530_MMIO
>  	tristate "MediaTek MT7530 MMIO interface driver"
>  	depends on NET_DSA_MT7530
>  	depends on HAS_IOMEM
> +	imply MEDIATEK_GE_SOC_PHY
>  	help
>  	  This enables support for the built-in Ethernet switch found
>  	  in the MediaTek MT7988 SoC.
> -- 
> 2.41.0

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

But I did a tree-wide search for "imply .*_PHY" and I didn't find any
other usage patterns, so I'm adding all phylib maintainers to make sure
that the practice isn't discouraged. If not, I guess it should be used
more often with internal PHYs for which the driver is known.
