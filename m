Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE1A7860EE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 21:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238382AbjHWTqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 15:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238404AbjHWTqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 15:46:18 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DEF10E0;
        Wed, 23 Aug 2023 12:46:13 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c1d03e124so759009666b.2;
        Wed, 23 Aug 2023 12:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692819972; x=1693424772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jD19Ogt/378xzKnnKi8H8LKoWiQ2oQFwsnEJWVrMQT4=;
        b=dxeLTk2ARZSXdeYEhXELdB44i6PDv2vX2GhArJkVAL3LGAiH+qEpmj6XN2vHZ1NiLF
         ZGV7pCrHPqFO695ivFzOYu53/J+K5eDgc79a57+MHBO67Wu8flbFDf+6TXtloK9c6mzR
         1DApHMhP28GpZogE1a4LQy4vIn0RY8q6Q4nKrND/yvpUvJTGuRTI0fWRJWm88fRhg1qW
         ctza45Kch6HvJ9azauTyAgwBfVUOgEr6u38j7H/HspIkwZyjhjGBfXAeKLFmK0znzU9a
         1Nkql3koCTbWelEW7TpIj9Mw+SuDm3ReFIRdN14AUoq0jDK+lGynHFktzlzlxAZ+gU54
         gRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692819972; x=1693424772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jD19Ogt/378xzKnnKi8H8LKoWiQ2oQFwsnEJWVrMQT4=;
        b=AvidfIdtKooj5mvUV+o60GFzNDw8Rx3AhxP+msty6uYtsQQySpZs0o5/4Gqk/UsPzh
         1VxrnH0LpP7aBOwh63xrkYTzcvYytC0InyxuTTKV0mDpnN5qHD3vvtg90OHbLGne+tkK
         dGdIeS8kThhr5l7RxlMeHTnwxWMt9m0wtgUPAg3TH5Od60HmxVevWdImFWl1Mccuf+U5
         RQ5txPNvtTiAzDTyPj/gTcJkuYKNjBaKCKI8LWvj30FVlQIL5TyJvRIxUyA4KIEukNsT
         9SjYxcbOWZ0a5jZZkTS37LaZzQOoGgHyKOjDJU8doSuUxMcuS3kSYeEazRYhT6Wnr/hA
         Qxng==
X-Gm-Message-State: AOJu0YxOLNqNstm/2KrsRWo/f3aFO4c+PcRS+MHPWqoqNE1p2t3FaT8/
        8CcuNQrZkvk1xzdcovuXSXA=
X-Google-Smtp-Source: AGHT+IHtlZ2xQ51Ya04k4xszCEQvbd9z325dchvkcHgj0VjX26Sv5ima9GKPoE5IuL0rsAdsTlUCXw==
X-Received: by 2002:a17:906:25d:b0:9a1:bcf9:4f99 with SMTP id 29-20020a170906025d00b009a1bcf94f99mr3891626ejl.36.1692819972018;
        Wed, 23 Aug 2023 12:46:12 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id p23-20020a170906141700b009931a3adf64sm10216051ejc.17.2023.08.23.12.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 12:46:11 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: h5/h6: Drop spurious 'clock-latency-ns'
 properties
Date:   Wed, 23 Aug 2023 21:46:10 +0200
Message-ID: <3755420.kQq0lBPeGt@jernej-laptop>
In-Reply-To: <20230823193239.2758505-1-robh@kernel.org>
References: <20230823193239.2758505-1-robh@kernel.org>
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

Dne sreda, 23. avgust 2023 ob 21:32:27 CEST je Rob Herring napisal(a):
> 'clock-latency-ns' is not a valid property for CPU nodes. It belongs in
> OPP table (which has it). Drop them from the CPU nodes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 4 ----
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 4 ----
>  2 files changed, 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi index
> a56fae761a1f..939f1c0a5eaa 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> @@ -16,7 +16,6 @@ cpu0: cpu@0 {
>  			reg = <0>;
>  			enable-method = "psci";
>  			clocks = <&ccu CLK_CPUX>;
> -			clock-latency-ns = <244144>; /* 8 32k 
periods */
>  			#cooling-cells = <2>;
>  		};
> 
> @@ -26,7 +25,6 @@ cpu1: cpu@1 {
>  			reg = <1>;
>  			enable-method = "psci";
>  			clocks = <&ccu CLK_CPUX>;
> -			clock-latency-ns = <244144>; /* 8 32k 
periods */
>  			#cooling-cells = <2>;
>  		};
> 
> @@ -36,7 +34,6 @@ cpu2: cpu@2 {
>  			reg = <2>;
>  			enable-method = "psci";
>  			clocks = <&ccu CLK_CPUX>;
> -			clock-latency-ns = <244144>; /* 8 32k 
periods */
>  			#cooling-cells = <2>;
>  		};
> 
> @@ -46,7 +43,6 @@ cpu3: cpu@3 {
>  			reg = <3>;
>  			enable-method = "psci";
>  			clocks = <&ccu CLK_CPUX>;
> -			clock-latency-ns = <244144>; /* 8 32k 
periods */
>  			#cooling-cells = <2>;
>  		};
>  	};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi index
> ca1d287a0a01..3b56beed6fee 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -27,7 +27,6 @@ cpu0: cpu@0 {
>  			reg = <0>;
>  			enable-method = "psci";
>  			clocks = <&ccu CLK_CPUX>;
> -			clock-latency-ns = <244144>; /* 8 32k 
periods */
>  			#cooling-cells = <2>;
>  		};
> 
> @@ -37,7 +36,6 @@ cpu1: cpu@1 {
>  			reg = <1>;
>  			enable-method = "psci";
>  			clocks = <&ccu CLK_CPUX>;
> -			clock-latency-ns = <244144>; /* 8 32k 
periods */
>  			#cooling-cells = <2>;
>  		};
> 
> @@ -47,7 +45,6 @@ cpu2: cpu@2 {
>  			reg = <2>;
>  			enable-method = "psci";
>  			clocks = <&ccu CLK_CPUX>;
> -			clock-latency-ns = <244144>; /* 8 32k 
periods */
>  			#cooling-cells = <2>;
>  		};
> 
> @@ -57,7 +54,6 @@ cpu3: cpu@3 {
>  			reg = <3>;
>  			enable-method = "psci";
>  			clocks = <&ccu CLK_CPUX>;
> -			clock-latency-ns = <244144>; /* 8 32k 
periods */
>  			#cooling-cells = <2>;
>  		};
>  	};




