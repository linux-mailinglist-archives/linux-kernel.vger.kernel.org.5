Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF4B7ACBBE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 21:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjIXTyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 15:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjIXTyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 15:54:46 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2503483;
        Sun, 24 Sep 2023 12:54:40 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so14341523a12.1;
        Sun, 24 Sep 2023 12:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695585278; x=1696190078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBJ4eW5WukCsQ+DoRqfNvvhyVgTkVqFsDx/NRH21ELQ=;
        b=QVB+NXhIbP0N0g1CE8h7Dh4OB0Z3orSYrfN6VXSAZkPvV+ILann2hxcV2kpGx/XeTo
         s5YRAUq9VSV0r9A2yZtnGPb+nhO0oZ9ye3ZmbMVwAp6bGPRDbrYEZ6fLyAovr9PZ8EWJ
         NsnUbE4bQ3wSvsASeHfx3Odzb6cL6X612Mo8+UaLdD3AXljcW1y6FIC7K3WXoxk9/BZW
         NUsFSF/PQgLSlFuqRMDLT/7zuZ4oE5fwBg0ebX7TL2MkECRgSMTlfO+qvSsqKd1Bzdgg
         AqvKr2288z5qnC455pZZokkkkUw7UCbpS/FfF7Q9SVAAx0wwyk0SkUFO286+g3Kyeqeu
         bmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695585278; x=1696190078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBJ4eW5WukCsQ+DoRqfNvvhyVgTkVqFsDx/NRH21ELQ=;
        b=QVy8ICXOXjftgJqDkvlaXFAVq7jFhgv3kis80Vj0Pn3vFpomIikFlqg20yLHEj0xN+
         /MQawMdggZfKr4vgc1CwNeCupKZH2Jj6xZ+Tnl5cva3RzVBs9bqGewGXH1j4q9+B0OrQ
         LgyGldo/edAlL3RP1ZRWNWQovC0/X67VSfLz9v18iBEMN9oxUirS7JXUM+HMQAhj8dkv
         bHSh8ANmxUl8irBu7jSjBpq933Q0QUJ+vvqSqriiBO7hSyQtXh+AU7+39a4QlcJK10RC
         xSOcPCE4DUx173pw6iTPooe1X0ecFMT1ycn5sgOoIa7iVDVS/ULj5RS1zlRC9jXQpNfn
         P3Xg==
X-Gm-Message-State: AOJu0Yy17K2dMRtnVU3vYfWzTfKdkQSNrnCSXoCqRzmZrPCM+E+fuVIk
        CvGSSUO1ILndnY+uKhK+rO4=
X-Google-Smtp-Source: AGHT+IEg4Ffl4e4EwIXj2zJUO5/CRFwkOyfOlyWF1+MbH0y3nxE8C2jfCFV30MbtEJIi+L7O2OTFSQ==
X-Received: by 2002:a05:6402:274b:b0:525:4d74:be8c with SMTP id z11-20020a056402274b00b005254d74be8cmr12848115edd.14.1695585277637;
        Sun, 24 Sep 2023 12:54:37 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id x13-20020aa7d38d000000b0052fe12a864esm4653293edq.57.2023.09.24.12.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 12:54:37 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] riscv: dts: allwinner: remove address-cells from intc node
Date:   Sun, 24 Sep 2023 21:54:36 +0200
Message-ID: <10341211.nUPlyArG6x@jernej-laptop>
In-Reply-To: <20230916-saddling-dastardly-8cf6d1263c24@spud>
References: <20230916-saddling-dastardly-8cf6d1263c24@spud>
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

Dne sobota, 16. september 2023 ob 11:14:00 CEST je Conor Dooley napisal(a):
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> A recent submission [1] from Rob has added additionalProperties: false
> to the interrupt-controller child node of RISC-V cpus, highlighting that
> the D1 DT has been incorrectly using #address-cells since its
> introduction. It has no child nodes, so #address-cells is not needed.
> Remove it.
> 
> Fixes: 077e5f4f5528 ("riscv: dts: allwinner: Add the D1/D1s SoC devicetree")
> Link: https://patchwork.kernel.org/project/linux-riscv/patch/20230915201946.4184468-1-robh@kernel.org/ [1]
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Applied, thanks!

Best regards,
Jernej

> ---
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> CC: Chen-Yu Tsai <wens@csie.org>
> CC: Jernej Skrabec <jernej.skrabec@gmail.com>
> CC: Samuel Holland <samuel@sholland.org>
> CC: devicetree@vger.kernel.org
> CC: linux-riscv@lists.infradead.org
> CC: linux-sunxi@lists.linux.dev
> CC: linux-kernel@vger.kernel.org
> ---
>  arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> index 8275630af977..b8684312593e 100644
> --- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> @@ -30,7 +30,6 @@ cpu0: cpu@0 {
>  			cpu0_intc: interrupt-controller {
>  				compatible = "riscv,cpu-intc";
>  				interrupt-controller;
> -				#address-cells = <0>;
>  				#interrupt-cells = <1>;
>  			};
>  		};
> 




