Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7AF7F0310
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 22:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjKRVxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 16:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKRVxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 16:53:39 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFC0EA;
        Sat, 18 Nov 2023 13:53:35 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53e70b0a218so4510658a12.2;
        Sat, 18 Nov 2023 13:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700344414; x=1700949214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wtt/oFJ6mp4pvc5MxO64v8GI8P+1Sx5CjrqoYf23NVA=;
        b=cbBFKT7BmXU4GV/bgV/otEe6mlIKW00Xpzq/9Kfvpsbg6GNKTeB6bchq/K/9YDhnHk
         OL4dN4PULZYtx40aKcOAAvaVXFOgphjqtXxjUiw3vPeUGI9cLndDSAFi5yq3glP8KLge
         dIfmyZox6mGBRRu7/TvGfn2rDieZNl+RHHWt9Td2ewtFGw6YlVGDPVEmd8fp3AXHZoHM
         x4iXA0eJxCGcr0j1i3KLaULqL/wr+PAYNFk6mR+mbMUNgonm04Vo3FXExKQIk2srVxxW
         JxxlIaYEgMWa2o7lRrbU2E0LClgl8iq/hlbDJJuT1eSQ3ceBwviygECZoJiw/6y0WLGx
         v2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700344414; x=1700949214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wtt/oFJ6mp4pvc5MxO64v8GI8P+1Sx5CjrqoYf23NVA=;
        b=C2YWyeG3nhCqM9QqlTj/3YBc6xvjRVvc0uRFOzDtgFb81MqTEFLDZ61MX6eiEC2TtP
         QPaW+BrfgT/xi0cDYGuq27deL7agPKikC6rWz0n4Ny+a8VBv8YzVOgiMp741IE9RBqQR
         e6L5M7tHLRlPM04Tila8cMKwGLLJrjDsZ3hVPMnEattFio8eERUOUuJcHhzZMd+jNNqi
         +p6zAiEBjfzofhLPvS9OLqj7an3J/Ysn6UkIqEjszNeGbF6uPJoFj6+wCFE8j84Mlr3q
         F/nq+u4aEH+q1TRID/GjKyzfgr3VNA+GxnwvCJM5haoLCPrq7mvq8zJlTjYnqMQRW9XN
         IwEw==
X-Gm-Message-State: AOJu0Yz5xiWoR3mbqKEDv2vCQsChbyDaXJRfPCKt4byBVMvfQuPXkvvq
        i/pp3oujiIUu6jQ/J9ZfY81j2IOVnMk=
X-Google-Smtp-Source: AGHT+IEsj8NvVPt+C+yDrHzdKUUesSpB0lSD7yp/W/7z0ksNKCl2sWrmAL563BNLNRtvG/DBVkqbfw==
X-Received: by 2002:a17:907:7401:b0:9bf:60f9:9b7c with SMTP id gj1-20020a170907740100b009bf60f99b7cmr1955872ejc.62.1700344413958;
        Sat, 18 Nov 2023 13:53:33 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id ca3-20020a170906a3c300b009fc42f37970sm296837ejb.171.2023.11.18.13.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 13:53:33 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chukun Pan <amadeus@jmu.edu.cn>
Cc:     Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH v2 1/1] arm64: dts: allwinner: h616: update emac for Orange Pi
 Zero 3
Date:   Sat, 18 Nov 2023 22:53:32 +0100
Message-ID: <2303336.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <20231029074009.7820-2-amadeus@jmu.edu.cn>
References: <20231029074009.7820-1-amadeus@jmu.edu.cn>
 <20231029074009.7820-2-amadeus@jmu.edu.cn>
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

Dne nedelja, 29. oktober 2023 ob 08:40:09 CET je Chukun Pan napisal(a):
> The current emac setting is not suitable for Orange Pi Zero 3,
> move it back to Orange Pi Zero 2 DT. Also update phy mode and
> delay values for emac on Orange Pi Zero 3.
> With these changes, Ethernet now looks stable.
> 
> Fixes: 322bf103204b ("arm64: dts: allwinner: h616: Split Orange Pi Zero 2 DT")
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi | 3 ---
>  arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts | 3 +++
>  arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts | 2 ++
>  3 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi
> index 15290e6892fc..fc7315b94406 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi
> @@ -68,10 +68,7 @@ &ehci1 {
>  &emac0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&ext_rgmii_pins>;
> -	phy-mode = "rgmii";
>  	phy-handle = <&ext_rgmii_phy>;
> -	allwinner,rx-delay-ps = <3100>;
> -	allwinner,tx-delay-ps = <700>;
>  	status = "okay";
>  };
>  
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> index d83852e72f06..b5d713926a34 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> @@ -13,6 +13,9 @@ / {
>  };
>  
>  &emac0 {
> +	allwinner,rx-delay-ps = <3100>;
> +	allwinner,tx-delay-ps = <700>;
> +	phy-mode = "rgmii";
>  	phy-supply = <&reg_dcdce>;
>  };
>  
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
> index 00fe28caac93..b3b1b8692125 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
> @@ -13,6 +13,8 @@ / {
>  };
>  
>  &emac0 {
> +	allwinner,tx-delay-ps = <700>;
> +	phy-mode = "rgmii-rxid";
>  	phy-supply = <&reg_dldo1>;
>  };
>  
> 




