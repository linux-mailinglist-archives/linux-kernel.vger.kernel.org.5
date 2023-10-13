Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7807C8D42
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 20:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjJMSpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 14:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMSps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 14:45:48 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5939DBE;
        Fri, 13 Oct 2023 11:45:43 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so27816015e9.0;
        Fri, 13 Oct 2023 11:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697222742; x=1697827542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nS/B/9nUlLmw6S4KsFUi4nqKiJBJFKciQh4FDxh+L/s=;
        b=VWCNBmGeZethL9drvaz2BFBuuHeshfVwQWIyDsom5kSEDWjXymqfdEHMBwuZfpEZPv
         PzRTAlF0tGzixcs8G4qVDkafWDPQrQT/rTF60rqR6FFGAOzdvwtJg5cCD8ERtlmgjKDK
         HlQnjHEYmFlX0WNmfQLVLqaaN6J84SqF6qgDq4OPt/wj0rlKIUEoH1STdfBzDBJxkXup
         UAz/FmHq2hJw1WqS2GOk9MwSZpRNhs6Dx3NnQbAs4KW7R6Z2/Z1zEb6xYI9AyWSko1KU
         OIVQbn1lRxI/aChFNk8BbAE8ioCrnV0NVyfPVPzZrrO4iYZEgaTHDvlI4ghV2M4mezcZ
         3GPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697222742; x=1697827542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nS/B/9nUlLmw6S4KsFUi4nqKiJBJFKciQh4FDxh+L/s=;
        b=ZLJd+9pQvY6RmB1kIzsATuTOlhXvz7ipXRkcCGQaBHOq8RMhCEkhNDuilTkn2PvgI/
         kiYhLXD9QACXA9cwG1ZPCpRq4vHNaMydRH43bKn4GYUsiFgtocKYJiE/FrcG80A6/H0b
         efh0tgfQodFp0LIi4rC7DdmJrqIbOnW5lea4VZnJIwdQVH5pNT6r2IoNxNH53CG6x1No
         s035GjOn3uG8+amOWwH3LMCUK5ZoBXcBd73ndA1bJgHgQnXyfMrFMovmnGC1b97B84eN
         DLShrZiU++nw9p/L6XaUao0Lt2tov2HaFp+H002VzbS8jSaDG9Tzae3fH94lgwNWvYRU
         oiyQ==
X-Gm-Message-State: AOJu0YzAeJNieQY3F4lVi1qbQtqY89OxJf2QcXlXR794XgwvNknyjXOH
        2ttDH8VrPNyOvwjTy3l36SH8KWu/c3Vn9g==
X-Google-Smtp-Source: AGHT+IHcbqPBjzX48zCFbc2YsOP+a2i9HmTRCmgyTQhV4W9XaKQNyEHu+7HzI1xt2rz8SXlqw5MDaQ==
X-Received: by 2002:a7b:cb8c:0:b0:406:517f:ac71 with SMTP id m12-20020a7bcb8c000000b00406517fac71mr24094789wmi.29.1697222741548;
        Fri, 13 Oct 2023 11:45:41 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id e16-20020a05600c4e5000b004068495910csm840969wmq.23.2023.10.13.11.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 11:45:40 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>,
        Chukun Pan <amadeus@jmu.edu.cn>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: h616: update emac properties for
 Orange Pi Zero 3
Date:   Fri, 13 Oct 2023 20:45:38 +0200
Message-ID: <3254946.aeNJFYEL58@jernej-laptop>
In-Reply-To: <20231010153812.2869633-2-amadeus@jmu.edu.cn>
References: <20231010153812.2869633-1-amadeus@jmu.edu.cn>
 <20231010153812.2869633-2-amadeus@jmu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne torek, 10. oktober 2023 ob 17:38:12 CEST je Chukun Pan napisal(a):
> Add the correct delay value to emac. Also add missing mdio
> properties for the YT8531 PHY (clock output required).
> With these changes, Ethernet now looks stable.

This is also a fix, so it would also deserve Fixes tag. In fact, please merge
previous and this patch into one. After all, you are fixing only one thing -
ethernet on OrangePi Zero 3 board.

Can you also explain how did you figure out that additional PHY properties
are needed? At first glance, based on description of motorcomm,keep-pll-enabled,
it's not immediately clear why it should be needed. Same goes for second
property.

1800 ps delay basically means that rgmii is not correct type and rgmii-rxid
should be used instead. Indeed, schematic confirms that's the case. With that,
allwinner,rx-delay-ps can be 0 and thus ommited from DT file.

Since there is many differences, I suggest that you remove whole emac0
node from common DTSI file and put specific ones to each board. It will
be less confusing that way.

Best regards,
Jernej

> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
> index 00fe28caac93..02c7836b624a 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
> @@ -13,10 +13,14 @@ / {
>  };
>  
>  &emac0 {
> +	allwinner,rx-delay-ps = <1800>;
> +	allwinner,tx-delay-ps = <700>;
>  	phy-supply = <&reg_dldo1>;
>  };
>  
>  &ext_rgmii_phy {
> +	motorcomm,keep-pll-enabled;
> +	motorcomm,auto-sleep-disabled;
>  	motorcomm,clk-out-frequency-hz = <125000000>;
>  };
>  
> 




