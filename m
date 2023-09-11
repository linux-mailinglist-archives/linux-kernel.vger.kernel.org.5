Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B326179B3E3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353976AbjIKVvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241233AbjIKPEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:04:40 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7F4125;
        Mon, 11 Sep 2023 08:04:36 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bf5bf33bcdso69839651fa.0;
        Mon, 11 Sep 2023 08:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694444674; x=1695049474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODyJnPcImRel5P1Ykm7VeqTt2o5yZaj1e00zNOQ+VYI=;
        b=jDTNWxnkzcAeY/owuW+uO9QvNSQWxH4c3F36r0JmCT1aKrTNzxjGFMq++xA5z/HrNA
         o1JQI1NYGdK/iusaAkcXduScL+aA31goghVhzpGWNx9M417wZ2MJ3011UHRqi7Fb9qQd
         XtRd8OC98uzlcR5RLb95Ox12ve1oCbUA9SSbHIZd9iXifGbgQDThTVqHdyMtYr+Dt00s
         xptt/XMpXd2cCpySHFZsr8YUdgi7n1EeL0rMTSaFieuoAQgZ5lL9hdKwAaZbXRjThpg7
         jVqR4IHUZ2mpFhhFPxAxdnhb9leE3pWXMqJKLqo0XKG8RR1GN6Yseam7gn43WqWCaG+T
         mLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694444674; x=1695049474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODyJnPcImRel5P1Ykm7VeqTt2o5yZaj1e00zNOQ+VYI=;
        b=UT7I5DEdJ58K5OxlfXp9ICY19mlOR4neo6onBePrL2+kkfG+HcQRJeBY8hYxliIPMs
         e832Wj9rqczTLQbxFyuE1q5RuhkPXR45J6wHY6ouUIEDOSTSwYcuSHXryKAeDfL3+J2S
         1FInj8DGTK4kB0unHFZbt3ee48TKScQ/pVEZAeaetXwcIzXRVK0fMHn4OsH02T2ut53n
         s+8lyZAwiXCWA/DEXWiMt8YlZk4txCMCAXvJvg6KLxmP7pFEBS1XCgFz8wXxu/ckayXO
         Lx/C6+I+qSXXzqR0kVuTl8VhPr7dGnHbNK4RFR9V+pGnYmf/7fq5VCBhD80uqzunrCwm
         WT4A==
X-Gm-Message-State: AOJu0Yzz4tslInHruEsXZdrFYTJQaZH6ey0EPpj7jFtq+ONIucZ7aNeT
        UTPtE68U/FSHZUFrSv4Wk1I=
X-Google-Smtp-Source: AGHT+IF9ImvK5dW/GQLmY/Bl6WL9W44EGZzNuF3w6dcH5dzQKdEZgs4EZk2VmEgketwPJBzPBOxNDQ==
X-Received: by 2002:a2e:9609:0:b0:2bc:fd50:573a with SMTP id v9-20020a2e9609000000b002bcfd50573amr8796822ljh.6.1694444674200;
        Mon, 11 Sep 2023 08:04:34 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id z19-20020a170906715300b00992e14af9b9sm5426153ejj.134.2023.09.11.08.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:04:33 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     longqi <longqi90@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Allwinner sunXi SoC support" 
        <linux-sunxi@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fixes the pin settings of two LEDs on board nanopi neo plus2
Date:   Mon, 11 Sep 2023 17:04:34 +0200
Message-ID: <1862064.tdWV9SEqCh@jernej-laptop>
In-Reply-To: <20230911155418.330e2334@donnerap.manchester.arm.com>
References: <20230911140959.2046340-1-longqi90@gmail.com>
 <20230911155418.330e2334@donnerap.manchester.arm.com>
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

Dne ponedeljek, 11. september 2023 ob 16:54:18 CEST je Andre Przywara 
napisal(a):
> On Mon, 11 Sep 2023 22:09:59 +0800
> longqi <longqi90@gmail.com> wrote:
> 
> Hi,
> 
> please add a few lines here saying why you fix this: it looks like the red
> LED wasn't working at all, because of the wrong GPIO, and the colours were
> actually swapped? This would be good to know for everyone reading this
> patch.

Additionally, add "Fixes" tag, since it's a bug in DT.

In any case, go through
https://www.kernel.org/doc/html/latest/process/submitting-patches.html
so your patch will be correctly formatted.

Best regards,
Jernej

> 
> In general this is a good catch, so thanks for sending this!
> 
> More below:
> > Signed-off-by: longqi <longqi90@gmail.com>
> > ---
> > 
> >  .../boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
> > b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts index
> > 4c3921ac236c..0cb7a07ab1de 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
> > @@ -26,14 +26,15 @@ leds {
> > 
> >  		compatible = "gpio-leds";
> >  		
> >  		led-0 {
> > 
> > -			label = "nanopi:green:pwr";
> > -			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
> > -			default-state = "on";
> > +			label = "nanopi:red:pwr";
> 
> label is now a deprecated property. That's fine for existing DTs, but I
> guess touching this node means you should update this, by using "function"
> and "color", as described in:
> Documentation/devicetree/bindings/leds/common.yaml
> 
> > +			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>; /* 
PL10 */
> > +			linux,default-trigger = "default-on";
> > 
> >  		};
> >  		
> >  		led-1 {
> > 
> > -			label = "nanopi:red:status";
> > -			gpios = <&pio 0 20 GPIO_ACTIVE_HIGH>;
> > +			label = "nanopi:green:status";
> 
> Same thing with label here, please use "function" and "color".
> 
> > +			gpios = <&pio 0 10 GPIO_ACTIVE_HIGH>; /* 
PA10 */
> > +			linux,default-trigger = "heartbeat";
> 
> I don't think we assign default triggers for LED merely labelled "status",
> as people might have different use cases for this. For instance I'd find
> a USB or eMMC trigger more useful. So you can just drop that line.
> 
> Cheers,
> Andre




