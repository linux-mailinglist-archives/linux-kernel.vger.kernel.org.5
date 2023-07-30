Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1238076891F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 00:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjG3Was (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 18:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjG3Waq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 18:30:46 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DC910E9;
        Sun, 30 Jul 2023 15:30:44 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-317716a4622so3599121f8f.1;
        Sun, 30 Jul 2023 15:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690756243; x=1691361043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gel3Fe0n25TUws0Hk9Qd0MUUJAa6WDx17jjyONCSFYw=;
        b=mWiBPv+dmsQZhbaLCfWQxgfy10UsWYdTTx1NN4VSLkepwadA05OqGDb32V6/5+FtD6
         Dl1y2FLquhOJs9mF5RkaoODP3PxnpVmBF7XU4bvoqCCoAccf+f1dk7h5h+7WlsIRh5Xr
         zLejcg+HXTF7del6cv16A9NDcn4PMiprf+m250AP04Jiab3U1eBaqSLv7/8EspuTInvs
         MCLsh8STYfbLIyqjXQj1Rex2L3RcgakqCgbA9n47+4RCF1ilH6GvN1rO8ZnPNJbHDx/+
         LUDW8RbaJ7f2RmDwr3581Do1OXJVuRaWoG0Es7+6JTu7CvwbVfYn8cEpmJPRY5SD1H2I
         iRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690756243; x=1691361043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gel3Fe0n25TUws0Hk9Qd0MUUJAa6WDx17jjyONCSFYw=;
        b=Dcg4HCi6d2aomttIsIt+kgde4OvF9gxOgg44hoGFOxwcHvs0uf9ICyT18qqbuzmien
         8Lm+L2DSufKzC91qo+IIGzezx0EA+ut/rA4aYWOE4aEX2FWDGUMAZc8RR5TZQVf1ATYC
         wP1VvFAgdsnmkomdBRguWa6vPMXe3ftSASisRMoPIcS/BnbU3c6h0VcCHyt9EVF4sgRo
         qVUq8Znj5mFEWMcxXPqUXjjwPCKPZijBay5+sO5NQbCWUXAHokSmIyCvqe4BFIWfhGLE
         6CrW0PHHUbalGM3K75ujjeF9vp8rNBBImsqSRUMmVs42ld2aZTrxEk2Z4wTos9640Fko
         N3IQ==
X-Gm-Message-State: ABy/qLY2saY3pQUG7QBN2mLKk6aknvWfwl8ST5cFNB0v6LuoiXKHIC21
        hChWsuLn9cWZsII6OsbgZmk7CfPq9Z/mBV23
X-Google-Smtp-Source: APBJJlFXiQpqspdOBp7EzGDoS/QjTssDdL+zkH+BSXifpt+9Tx+StGhiesv1d9FzlyBMIIudJbBf4g==
X-Received: by 2002:a5d:43c3:0:b0:30f:af19:81f3 with SMTP id v3-20020a5d43c3000000b0030faf1981f3mr4712223wrr.41.1690756243005;
        Sun, 30 Jul 2023 15:30:43 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id w4-20020adfec44000000b00317614b6a5dsm11125160wrn.50.2023.07.30.15.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 15:30:42 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-spi@vger.kernel.org, Maksim Kiselev <bigunclemax@gmail.com>
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Mark Brown <broonie@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] riscv: dts: allwinner: d1: Add QSPI pins node for pinmux
 PC port
Date:   Mon, 31 Jul 2023 00:30:39 +0200
Message-ID: <10311404.nUPlyArG6x@jernej-laptop>
In-Reply-To: <20230624131632.2972546-4-bigunclemax@gmail.com>
References: <20230624131632.2972546-1-bigunclemax@gmail.com>
 <20230624131632.2972546-4-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 24. junij 2023 ob 15:16:24 CEST je Maksim Kiselev napisal(a):
> Add pinmux node that describes pins on PC port which required for
> QSPI mode.
> 
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> ---
>  arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi index
> 1bb1e5cae602..9f754dd03d85 100644
> --- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> @@ -131,6 +131,13 @@ uart3_pb_pins: uart3-pb-pins {
>  				pins = "PB6", "PB7";
>  				function = "uart3";
>  			};
> +
> +			/omit-if-no-ref/
> +			qspi0_pc_pins: qspi0-pc-pins {
> +				pins = "PC2", "PC3", "PC4", "PC5", 
"PC6",
> +				       "PC7";
> +				function = "spi0";
> +			};

Sorry for late review, but it seems I'm missing something. D1 manual says 
those are pins for ordinary SPI, with HOLD and WP signals. Can they be 
repurposed for quad SPI?

Best regards,
Jernej


>  		};
> 
>  		ccu: clock-controller@2001000 {




