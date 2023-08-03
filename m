Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6360176F454
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 22:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjHCUyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 16:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjHCUyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 16:54:21 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0671D19AA;
        Thu,  3 Aug 2023 13:54:12 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-317b31203c7so1299806f8f.2;
        Thu, 03 Aug 2023 13:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691096050; x=1691700850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gf1shgUQGecS6+2Jrf1Rltefiiin3z+1dw5kwESQLOE=;
        b=I6Svwboa/Lf/XyjqjzLySQ9kXd+YTlRJ8bqidzr0kT/mN0bm9TJmPdDtGmjQcXnC0g
         zBQcpCDi35SqsW4FPFXJHJj1RZUVxAG9y3+pn5FcNg+hMxFImMO4JlkCc7O3h49ok1V8
         G/20JB9KiEbch9eu2VgRw53YLAthzMbfB9hN0mvkNqWW9kQrPE/hV2NIulEL5VRoAnXS
         evmwhdHh7JDKmSF6Y/M4AdK9qWhx3PFjZO4y4hKiuXkoQ6gxswG6Axdus7k3PRoWYMTP
         4D7au3z7X+c80V1G7thDEkn34K/tsUprsXm94oz75+/9csJ5cy2vfl5U+fW7nNy78IwX
         KCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691096050; x=1691700850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gf1shgUQGecS6+2Jrf1Rltefiiin3z+1dw5kwESQLOE=;
        b=QAyDwqr+tXCiilyIAWRVUNmIv0+wqItguYNVWJr7elyyodeagEjx61BZmSuQ7lWtQz
         2rY7zNyGEZQuSIFBNegl2/EizZ6d9ZNx/xXIqAT6VbDZHsHTSb/z3d1uCCUhyhFDB++t
         B51RCI5iY6ooIq7q47cM1skPxVOGdY8FFBY+CQKLg9l7/Tgi44a4JCJyWp3XyS1ZkUAC
         hob5Aakt9xDi/ZKV1/rtiAgJ5gIMkQVSSMc98uojBSxIIQ1ZdNYMHRqq9YE32W/+xwy9
         Ygw6aKZmVRx+rf3Cci1oYmnt+o2TOH8VvqRnkZ7zwljJhYNz5OHbZSWE3uDrLTvG6+kC
         aDKw==
X-Gm-Message-State: ABy/qLYUJh6afTbtPJf/Z2K0SGiqJIkqjDTNYBoM3/40eS/t8GBzXl+h
        KtliQ9RGix1xix+iVuL7vio=
X-Google-Smtp-Source: APBJJlFSz8tLD3zPBalpC68JbS4T65s5zlyPapVF+FrzONfDahN32ei4XWvdQHLX7eTvk9Ddujpkrg==
X-Received: by 2002:adf:e105:0:b0:314:11f3:ca94 with SMTP id t5-20020adfe105000000b0031411f3ca94mr8109045wrz.41.1691096050225;
        Thu, 03 Aug 2023 13:54:10 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id d6-20020adff2c6000000b003172510d19dsm743046wrp.73.2023.08.03.13.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 13:54:09 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@lists.linux.dev, John Watts <contact@jookia.org>
Cc:     John Watts <contact@jookia.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: allwinner: d1: Specify default CAN pins
Date:   Thu, 03 Aug 2023 22:54:08 +0200
Message-ID: <2151031.irdbgypaU6@jernej-laptop>
In-Reply-To: <20230731023701.2581713-1-contact@jookia.org>
References: <20230731023701.2581713-1-contact@jookia.org>
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

Dne ponedeljek, 31. julij 2023 ob 04:36:59 CEST je John Watts napisal(a):
> There are only one set of CAN pins available on these chips.
> Specify these as the default to avoid redundancy in board device trees.
> 
> Signed-off-by: John Watts <contact@jookia.org>
> ---
>  arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi index
> 4086c0cc0f9d..b27c3fc13b0d 100644
> --- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> @@ -898,6 +898,8 @@ can0: can@2504000 {
>  			interrupts = <SOC_PERIPHERAL_IRQ(21) 
IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&ccu CLK_BUS_CAN0>;
>  			resets = <&ccu RST_BUS_CAN0>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&can0_pins>;
>  			status = "disabled";
>  		};
> 
> @@ -907,6 +909,8 @@ can1: can@2504400 {
>  			interrupts = <SOC_PERIPHERAL_IRQ(22) 
IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&ccu CLK_BUS_CAN1>;
>  			resets = <&ccu RST_BUS_CAN1>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&can1_pins>;
>  			status = "disabled";
>  		};
>  	};




