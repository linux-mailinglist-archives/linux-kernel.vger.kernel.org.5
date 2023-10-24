Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC7C7D4E55
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbjJXK4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjJXKz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:55:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93F06D7A;
        Tue, 24 Oct 2023 03:55:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D0DE2F4;
        Tue, 24 Oct 2023 03:56:36 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E12D63F64C;
        Tue, 24 Oct 2023 03:55:53 -0700 (PDT)
Date:   Tue, 24 Oct 2023 11:55:48 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Rob Herring <robh@kernel.org>, sudeep.holla@arm.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Oleksii_Moisieiev@epam.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [RFC v2 5/5] dt-bindings: gpio: Add bindings for pinctrl based
 generic gpio driver
Message-ID: <ZTeitAqfwyse9Vkj@pluto>
References: <20231005025843.508689-1-takahiro.akashi@linaro.org>
 <20231005025843.508689-6-takahiro.akashi@linaro.org>
 <20231006132346.GA3426353-robh@kernel.org>
 <CACRpkdaLsfSBEG-h9ZNT2_Lm8tW8AZO7tedDVNeuZoQAqSkyjw@mail.gmail.com>
 <ZSTgTC4cFFpofYAk@octopus>
 <CACRpkdYD6pkccYoy90AfzV3KT7oYkBPD2_4ZW-AXzT1eUVpchA@mail.gmail.com>
 <ZS3yK/f12Mxw9rXe@octopus>
 <CACRpkdarDrVkPmyDawhZ+H94S4F=dtDSDVuKegi-eNfQNDY3rg@mail.gmail.com>
 <ZTduWx7CH1ifI5Uc@octopus>
 <CACRpkdba=echR=rZYKVbROfaOp4mzjTQ9RphHFyzqSNgE1jZqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdba=echR=rZYKVbROfaOp4mzjTQ9RphHFyzqSNgE1jZqg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 11:40:00AM +0200, Linus Walleij wrote:
> Hi Takahiro,
> 

Hi,

> On Tue, Oct 24, 2023 at 9:12 AM AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> 
> > > I think it is better of the pin controller just parse and add any
> > > subdevices (GPIO or other) using of_platform_default_populate()
> > > (just grep for this function and you will see how many device
> > > drivers use that).
> >
> > IICU, then, we will have to add a "compatible" to pinctrl node
> > to make of_platform_default_populate() work as expected. That is:
> >
> > scmi {
> >     ...
> >     protocol@19 {
> >         compatible = "simple-bus"; // <- added
> 
> Hm right, but you could also use
> of_platform_populate(np, NULL, NULL, dev);
> 
> Then the compatible match is of no concern.
> 
> Sorry for my lack of attention to details :/
> 
> If you want to restrict the population to a few select compatibles
> (maybe only "pin-control-gpio") then you can do
> that with
> 
> const struct of_device_id of_scmi_protocol_19_match_table[] = {
>         { .compatible = "pin-control-gpio", },
>         {}
> };
> of_platform_populate(np, of_scmi_protocol_19_match_table, NULL, dev);
> 
> > Is this what you meant?
> > In this case, however, "protocol@19" has a mixture of sub-nodes,
> > most are pinconf definitions which are the properties of the pin
> > controller, while "scmi_gpio" is a separate device.
> 
> That looks good to me, it makes sense to have the GPIO as a subnode
> here and mandate it with a compatible to match.
> 
> > The code will work, but is it sane from DT binding pov?
> 
> Let's let the DT people jump in on that.
> 
> > > Instead just call gpiochip_add_pin_range() directly in Linux
> > > after adding the pin controller and gpio_chip.
> > > C.f. drivers/pinctrl/pinctrl-sx150x.c for an example of a driver
> > > doing this. In this case the SX150X is hot-plugged (on a slow
> > > bus) so it needs to figure out all ranges at runtime anyway.
> >
> > Are you suggesting implementing a custom function for parsing "gpio-ranges"
> > and calling it in pin_control_gpio_probe() instead of a generic helper?
> 
> The generic helper will always be attempted but if there are
> no ranges in the device tree, it will just continue without adding
> any ranges. I suggest putting *no* ranges into the device tree.
> 
> > Or do you want to always map all the pin controller's pins to
> > gpio pins as sx150x does?
> 
> I think since the SCMI firmware knows about the available line
> and pins etc, it makes sense that the driver comes up with the
> applicable ranges on its own (derived from the information froms
> the SCMI firmware) and add them, instead of trying to put that
> information into the device tree at all. Just omit it, and make your
> own ranges, and add them in the Linux driver with
> gpiochip_add_pin_range() without involving DT at all when defining
> the ranges.
> 
> I'm sorry if I'm unclear sometimes.

...a maybe dumb question from my side, BUT does the SCMI Pinctrl carry
enough information as it stands for the driver to derive autonomously
and efficently the possible/applicable gpio ranges ?

Are they (GPIOs) all the remaining unassociated pins ?
If this is the case note that the SCMI Pinctrl lets you query the
associations in groups or functions and this is generally now done
only lazily on-demand when specific pins/groups/funcs are requested
by the parsed DT confs: IOW, in order to derive GPIOs from the set
of unassociated ones, you will have to at first add some new full-lookup
pinctrl_ops to query upfront all existing associations (avoiding, at will,
the lazy querying adopted now) and then singling-out the non-associated
ones from the lists of all possible group/funcs associations.

Moreover, should we allow anyway the optional possibility to forcibly
restrict the available gpios from the DT, or we can just assume that
those un-available (map out as above) wont just be exposed by the
SCMI server ?

..again sorry if I am missing something crucial here and just talking
non-sense but I have limited familiarity with Pinctrl/GPIOs usage.

Thanks
Cristian
