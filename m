Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0A379D562
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbjILPyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236479AbjILPyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:54:37 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A696E1706;
        Tue, 12 Sep 2023 08:54:33 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so770352166b.3;
        Tue, 12 Sep 2023 08:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694534072; x=1695138872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8oHJ2ujiJlxAUemtJ2j3LYJnlvFVhGLWaN0VZa8yeI=;
        b=RlB6X2zirA0oI8U3HcXWIj3UnBMl48p957j/OSDDMUoXXIAAD3ZByT4WtN3hXD6YUj
         OiB+YjrmWuSKbGXZ2UJSUVUMdHufQYBhWDMI2FZNRYLPnDba1W8+I9kj2Wx84FFPMDOF
         xEo5Yc8UVaf6UaRDCWNMt4fVcOfQg0DlVfgn2niUsL43G8ZXCQu6P4ezXLXQPVANo7RH
         ugXEa7GhPsfDdSNjbJF25Z/2njh/gOGg9dEUyxuEBrZ8efQPtoos2E14P4z96qGZnZr/
         /uvIBublO7xRAM8B7BZWkmPyXTGSgzO82p5E40xSkWlWs3GTVOmSSX0GHimJNLB7A4Xc
         9REg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694534072; x=1695138872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8oHJ2ujiJlxAUemtJ2j3LYJnlvFVhGLWaN0VZa8yeI=;
        b=NMcWYGgVviqRwiVLtESx62VNG6DeE/ZeQn0SwdWyI5/BblpfHK/3IxHylMuMrsyBII
         vnp+T71CupjF0a1j/vqj2Yi6ksCxJ+GK+9//E+nsSgxa+KSt9ceGIU+mJgILCL0cIGMy
         nEdxvZtKSTq5eCC0BALMdWsg+0dOwUNP3Fh5+XJ+kMyLd/eBvbAoky9iWhTAsKC8NPAO
         W50p+JVnh6xCNsVMivVgsrYcDz8xatGYmeyp1Q+TLcDvfn7WRu7wY9m1dHEy0koP+I10
         OmLQWvVR0wFxpPZ7iC5MJy/73uRvkb7/Ry4FvtPlYPRO4zixz8KzUdPbwnMCZM23VvD4
         yKMg==
X-Gm-Message-State: AOJu0YyAQ27PyE+ZWhJfY7WA1e4DoW6FvUCM+PXG/g0JBeuRKH7nXNo0
        pAfFF/p0XJCoU6vzPSsb6jI=
X-Google-Smtp-Source: AGHT+IEEM/bk4nQRqipf1BKh7nG712N1GnvGVrUcH4eqH2pGf0pFfIu2q7I8cr4PaxHXmrgjqYI4VA==
X-Received: by 2002:a17:906:2101:b0:9a1:6318:4d39 with SMTP id 1-20020a170906210100b009a163184d39mr11291101ejt.29.1694534072102;
        Tue, 12 Sep 2023 08:54:32 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id lf28-20020a170907175c00b0099bcf1c07c6sm7032766ejc.138.2023.09.12.08.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 08:54:31 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Martin Botka <martin.botka@somainline.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin@biqu3d.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rogerio Goncalves <rogerlz@gmail.com>,
        Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH v6 4/4] arm64: dts: allwinner: h616: Add BigTreeTech Pi support
Date:   Tue, 12 Sep 2023 17:54:30 +0200
Message-ID: <1769061.VLH7GnMWUR@jernej-laptop>
In-Reply-To: <20230912-b4-cb1-v6-4-bb11238f3a9c@somainline.org>
References: <20230912-b4-cb1-v6-0-bb11238f3a9c@somainline.org>
 <20230912-b4-cb1-v6-4-bb11238f3a9c@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 12. september 2023 ob 13:20:50 CEST je Martin Botka napisal(a):
> From: Martin Botka <martin@biqu3d.com>
> 
> The BigTreeTech Pi is an H616 based board based on CB1.
> Just in Rpi format board.
> 
> It features the same internals as BTT CB1 but adds:
>     - Fan port
>     - IR receiver
>     - ADXL345 Accelerometer connector via SPI
>     - 24V DC power supply via terminal plugs
>     - USB to CAN module connector (External Module)
> 
> List of currently working things is same as BTT CB1 but also:
>     - IR receiver
>     - ADXL345 connector
> 
> Signed-off-by: Martin Botka <martin@biqu3d.com>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  arch/arm64/boot/dts/allwinner/Makefile             |  1 +
>  .../dts/allwinner/sun50i-h616-bigtreetech-pi.dts   | 63
> ++++++++++++++++++++++ 2 files changed, 64 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile
> b/arch/arm64/boot/dts/allwinner/Makefile index 42e525b9d4b9..3aca6787a167
> 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -39,6 +39,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
> dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-cb1-manta.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-pi.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h618-orangepi-zero3.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts new file
> mode 100644
> index 000000000000..832f08b2b260
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2023 Martin Botka <martin@biqu3d.com>.
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h616-bigtreetech-cb1.dtsi"
> +
> +/ {
> +	model = "BigTreeTech Pi";
> +	compatible = "bigtreetech,pi", "allwinner,sun50i-h616";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&ehci0 {
> +	status = "okay";
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +&ehci2 {
> +	status = "okay";
> +};
> +
> +&ehci3 {
> +	status = "okay";
> +};
> +
> +&ir {
> +	status = "okay";
> +};
> +
> +&ohci0 {
> +	status = "okay";
> +};
> +
> +&ohci1 {
> +	status = "okay";
> +};
> +
> +&ohci2 {
> +	status = "okay";
> +};
> +
> +&ohci3 {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_ph_pins>;
> +	status = "okay";
> +};




