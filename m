Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1517BF21D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 07:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376922AbjJJFOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 01:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344471AbjJJFOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 01:14:45 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35D7A9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 22:14:42 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6a4ff9d7e86so351495b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 22:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696914882; x=1697519682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQhFnAIsenhwSznaxFHDKOg/ZsGnf5ZuY98Fxq45IkU=;
        b=ok652WnKTnG7RvB9k2L6OF1mO6beOBVFoLqB4RCpSnRNt55Q3veMZ44txBh5Exr7WE
         +YGr/kelHSXiQtoEmUV7cvG9jnY/AEoRp7clyzRGLSFdsEZGqc6ZC6GkyNUfJhHIWMZB
         Bs5a0XEW3/nVTrDsG4+Vgnv9NPXmO8Rvgt+qJWutIPZy1sCcnNz017v6vca1v7lLsGWR
         Gy1wVZZq5+xNRiSxcvyxgAYpVVAousAqQL5m4sn/o2K+AEwVG741XK5jPnR79m1iEijf
         GNT2V4f5SNfRvSwZ14EcdvBvbOu8r2eV9OWChsQaS/ZKyRnRxxETQr9LJdYEuHvIihb8
         ikTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696914882; x=1697519682;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lQhFnAIsenhwSznaxFHDKOg/ZsGnf5ZuY98Fxq45IkU=;
        b=M0OGn2FCbxxKrfF2hJS9hCUycx0BEc/madBGSzKbHr5utuXfBJVCoN1ESf6rJyWj1I
         0y+SX8BoDDcL3qe3ESiPAAS2ORaQazXKGZmok1JwayeMLnjf12+ftd9F+df9xBT3dvE+
         LcphSw6/WxCpsAiCpLz1CPQXU2ZdfYApY1poFJrRGcBmiUgaEfALnJuIyCGMYCZdbM8F
         6m6joBxsx1OdLOYFtt7MdF3H0u1MmJ/DfkB5DxZyODpCoF1IUtq61zfVPbcDBd06Cgrr
         wEFX5OP685bJMuce3EKMQ/1oimCoJtEq19Xs6Pe3uIXI9MksCN8wQmbshjy0nEN3PZdZ
         Aeyg==
X-Gm-Message-State: AOJu0YzJ8BQxmBh/MCZOuitR0q7IWCjLYq8B8Iu5Zy1ayfTtu1Ay8NTc
        Lj8ZKTuVlfWD8CouPIZKhX1dWQ==
X-Google-Smtp-Source: AGHT+IHaDM+YNCNE4eJtZUKYwuSPOdk4MvZD+JiNAp5tSoamQIDjMvlQP3IbKsJSsbElOx6id1n8pA==
X-Received: by 2002:a05:6a00:1d94:b0:690:d314:38d with SMTP id z20-20020a056a001d9400b00690d314038dmr19656361pfw.1.1696914881956;
        Mon, 09 Oct 2023 22:14:41 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:d26f:f61a:9867:e809])
        by smtp.gmail.com with ESMTPSA id a21-20020a62bd15000000b00693498a846esm7249060pff.80.2023.10.09.22.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 22:14:41 -0700 (PDT)
Date:   Tue, 10 Oct 2023 14:14:37 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, sudeep.holla@arm.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Oleksii_Moisieiev@epam.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [RFC v2 5/5] dt-bindings: gpio: Add bindings for pinctrl based
 generic gpio driver
Message-ID: <ZSTdvROVzJU5FRAZ@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, sudeep.holla@arm.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Oleksii_Moisieiev@epam.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20231005025843.508689-1-takahiro.akashi@linaro.org>
 <20231005025843.508689-6-takahiro.akashi@linaro.org>
 <20231006132346.GA3426353-robh@kernel.org>
 <CACRpkdaLsfSBEG-h9ZNT2_Lm8tW8AZO7tedDVNeuZoQAqSkyjw@mail.gmail.com>
 <ZSPDILYZkxvTnQia@e120937-lin>
 <CACRpkdY=eza0TuBRDb_cWk9LM2qNQg76rZSgWa-RP4TYLL=Ppw@mail.gmail.com>
 <ZSQXXW1NRiCpsENu@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSQXXW1NRiCpsENu@e120937-lin>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 04:08:13PM +0100, Cristian Marussi wrote:
> On Mon, Oct 09, 2023 at 03:13:24PM +0200, Linus Walleij wrote:
> > On Mon, Oct 9, 2023 at 11:08???AM Cristian Marussi
> > <cristian.marussi@arm.com> wrote:
> > 
> > > > > +    gpio0: gpio@0 {
> > > > > +        compatible = "pin-control-gpio";
> > > > > +        gpio-controller;
> > > > > +        #gpio-cells = <2>;
> > > > > +        gpio-ranges = <&scmi_pinctrl 0 10 5>,
> > > > > +                      <&scmi_pinctrl 5 0 0>;
> > > > > +        gpio-ranges-group-names = "",
> > > > > +                                  "pinmux_gpio";
> > > > > +    };
> > > >
> > >
> > > Assuming the above &scmi_pinctrl refers to the protocol node as we
> > > usually do,
> > 
> > No it does not, it is a three-layer cake.
> > 
> > scmi <-> scmi_pinctrl <-> scmi_gpio
> > 
> > it refers to the scmi_pinctrl node.
> > 
> 
> Thanks, this explains a lot.
> Cristian

Just in case, 

    gpio-ranges = <&scmi_pinctrl 0 10 5>;

means that SCMI *pin* range [10..(10+5-1)] are mapped to this driver's
gpio range [0..(5-1)]. So any consumer driver can access a gpio pin
as:
    foo-gpios = <&gpio0 3>;

will refer to gpio pin#3 that is actually SCMI's 13.

    gpio-ranges = <&scmi_pinctrl 5 0 0>;
    gpio-ranges-group-names = "pinmux_gpio";

means that SCMI *group*, "pinmux_gpio", are mapped to this driver's
gpio range which starts with 5. If "pinmux_gpio" indicates SCMI *pin*
range [20..24],

    baa-gpios = <&gpio0 7>;
will refer to gpio pin#7 that is actually SCMI's 22 (=20 + (7-5)).

This way, we (consumer drivers) don't care what is the underlying pin
controller.

-Takahiro Akashi

> 
> > There is no SCMI GPIO protocol, instead SCMI is using the
> > operations already available in the pin controller to exercise
> > GPIO. Generic pin control has operations to drive lines for
> > example, and Takahiro is adding the ability for a generic pin
> > controller to also read a line.
> 
> 
> > 
> > Yours,
> > Linus Walleij
