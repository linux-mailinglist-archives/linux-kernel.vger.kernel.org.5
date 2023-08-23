Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0BC7860BB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 21:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238323AbjHWThZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 15:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238317AbjHWTg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 15:36:58 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F59E5E;
        Wed, 23 Aug 2023 12:36:55 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so91678971fa.1;
        Wed, 23 Aug 2023 12:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692819414; x=1693424214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XseqOE+hrW2j1mbiFEeFoJsIauOkD7dow7NanYEiT8=;
        b=Kft/HoItEBfX/gA5eGlgeAkK7GnSL6fuOyiIN1iL/tsUG4Q/3M1VEkLwg4UTHuglGE
         x3wnrm+/yrsVs0RuFq5y8SsyTt9CduXxGmM2kkq41TC++M2w0mtXmUZ0RlhRLMLdDwyF
         OcAnRIMTRex0rHE5IKq35VzvjzOD2boCrTenHGv5WO2E1fMZNJcvVIWyQb/H+JCRUN3C
         jei7nMhB/7+t+5Sn9vvne0uztfOfdHqaqIXFyVV2SVwBNDkigi5qhWZCCTMO1ExetObK
         KYYTf0w7NITLBszeBLnbsaLwJ8FlxsYUA+bmyMY2UySxaTBBQjMxpercv/15ucIugMUR
         Ti3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692819414; x=1693424214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XseqOE+hrW2j1mbiFEeFoJsIauOkD7dow7NanYEiT8=;
        b=jJ3OMQUz50Ptrx3LuaPRvEWK592ZpKL5qgBBCHW4QyAJSz0DQaaoSWGl7rbg593gHX
         OBSiF+LKD6SnemFe7/VQK99QYHF5uJemU/ktA58ZxVYcOAuc/QXzmaqWokMMx5i1DG1M
         EccIb0A2DHl86uiDYrrustJAX4MAjbjcpncOICYHoFI3dB8qeDP5gvDwTFgwDrmp0rUw
         bQAgP/oGDIE1px7V3dbu0WMXx749HYLq/s9j3y1QoPSIWfsbW4TvU7FbHcPZYO+H4ipF
         zUgT/i4XoKgMD+4axpPaDTtMxbDMmJuBvszhBQ53oLb6SZBk88l6PT+2ig9wC5/L/Fhh
         89aQ==
X-Gm-Message-State: AOJu0Ywc1LQUIRAAE8psLdGytd72HVuh/FzGCK611O0Xo7RI+a//xDOR
        a/84mBd9lLGA7ik+7zPaqPo=
X-Google-Smtp-Source: AGHT+IEag43atiZQRGzFMqHQ4Knh0z6BzGKYlRrJOybchcj/oRn0svYRxmL4xbMLG9fqUNS87csexQ==
X-Received: by 2002:a2e:a201:0:b0:2b5:9d78:213e with SMTP id h1-20020a2ea201000000b002b59d78213emr9825308ljm.22.1692819413752;
        Wed, 23 Aug 2023 12:36:53 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id y6-20020a170906070600b0099cadcf13cesm10074851ejb.66.2023.08.23.12.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 12:36:53 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Jarrah Gosbell <kernel@undef.tools>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Pavel Machek <pavel@ucw.cz>,
        Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc:     Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: Re: [PATCH v2] arm64: dts: pinephone: Add pstore support for PinePhone A64
Date:   Wed, 23 Aug 2023 21:36:51 +0200
Message-ID: <2235209.iZASKD2KPV@jernej-laptop>
In-Reply-To: <20230822092358.309835-1-andrej.skvortzov@gmail.com>
References: <20230821160817.GA2227@bug>
 <20230822092358.309835-1-andrej.skvortzov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

send new revision as standalone e-mail, not as reply to old discussion.

Dne torek, 22. avgust 2023 ob 11:23:58 CEST je Andrey Skvortsov napisal(a):
> This patch reserves some memory in the DTS and sets up a
> pstore device tree node to enable pstore support.
> 
> In general any DRAM address, that isn't overwritten during a boot is
> suitable for pstore.
> 
> Range from 0x40000000 - 0x50000000 is heavily used by u-boot for
> internal use and to load kernel, fdt, fdto, scripts, pxefile and ramdisk
> later in the boot process. Ramdisk start address is 0x4FF00000,
> initramfs for kernel with some hacking features and debug info enabled
> can take more than 100Mb and final address will be around 0x58000000.
> Address 0x61000000 will most likely not overlap with that.

There are other bootloaders as U-Boot, especially on PinePhone. Are you sure 
it works there too? What about U-Boot configuration, will those addresses still 
be used if configuration is changed?

Best regards,
Jernej

> 
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> ---
> 
> Changes in v2:
>  - Update commit description with information about why this base address is
> used.
> 
>  .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi index
> 87847116ab6d..84f9410b0b70 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> @@ -19,6 +19,22 @@ aliases {
>  		serial0 = &uart0;
>  	};
> 
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		pstore_mem: ramoops@61000000 {
> +			compatible = "ramoops";
> +			reg = <0x61000000 0x100000>;
> +			record-size = <0x20000>;
> +			console-size = <0x20000>;
> +			ftrace-size = <0x20000>;
> +			pmsg-size = <0x20000>;
> +			ecc-size = <16>;
> +		};
> +	};
> +
>  	backlight: backlight {
>  		compatible = "pwm-backlight";
>  		pwms = <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;




