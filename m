Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A303C7E82F7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345810AbjKJTeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjKJTdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:33:47 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B92153A886;
        Fri, 10 Nov 2023 07:24:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D18AC12FC;
        Fri, 10 Nov 2023 07:25:00 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 694FC3F6C4;
        Fri, 10 Nov 2023 07:24:14 -0800 (PST)
Date:   Fri, 10 Nov 2023 15:24:04 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Takahiro Akashi <takahiro.akashi@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [RFC v5 5/5] dt-bindings: firmware: arm,scmi: Add support for
 pinctrl protocol
Message-ID: <ZU5LFC23JaEidEGZ@pluto>
References: <cover.1698353854.git.oleksii_moisieiev@epam.com>
 <e9285b4377242e4d888391be987cbb99caf8c573.1698353854.git.oleksii_moisieiev@epam.com>
 <CACRpkdYW-xmejyOo9H9XSkcabvYgBqPvpjppvNe_RF6RLxyxKA@mail.gmail.com>
 <ZU2AP7leDcIZIN+b@octopus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZU2AP7leDcIZIN+b@octopus>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 09:58:39AM +0900, Takahiro Akashi wrote:
> Hi Arm folks,
> 

> Do you have any comment?
> I expect that you have had some assumption when you defined
> SCMI pinctrl protocol specification.
>

[CC Souvik]

@Souvik for context see:
https://lore.kernel.org/all/CACRpkdZ4GborirSpa3GK_PwMgCvY0ePEmZO+CwnLcP6nAdieow@mail.gmail.com/

Hi,

I am not sure what is the full story here, BUT the spec was mainly aimed
at supporting PINCTRL in SCMI with the idea to then, later on, base GPIO
on top of it, "easily" building on the PINCTRL spec features in the future
with a separate series from the one Oleksii is working on...but it like
seems the future is already here and maybe we have discovered something
to be clarified...

Souvik/Oleksii can tell you better what were (if any) further assumptions
related to GPIO on top on SCMI/PINCTRL, but the aim of this series was
always to be just the basic Generic Pinctrl support when dealing with an
SCMI server backend.

Regarding the current Pinctrl series by Oleksii, I would also notice that,
indeed, some "non-spec-dictated" naming assumptions are ALREADY present
somehow, because, currently, the spec and the pinctrl SCMI protocol layer
speak/refer about pins/groups/functions, as usual, only in terms of numeric
identifiers/IDs (with an associated name of course), while the pinctrl
driver (thanks to the Linux pictrl subsystem layer) describes and refers
anything in the DT in terms of names: so all of this really works only
because the names used in the DT happen to match the names reported by
the backend server.

My test DT uses just what Oleksii exemplified in the cover letter:

	pinctrl_i2c2: i2c2 {
		groups = "i2c2_a", "i2c2_b";
                function = "i2c2";
        };

	pinctrl_mdio: pins_mdio {
		groups = "avb_mdio";
                drive-strength = <24>;
        };

        keys_pins: keys {
		pins = "GP_5_17", "GP_5_20", "GP_5_22", "GP_2_1";
                bias-pull-up;
        };


with a dummmy test driver referring to it, so as to trigger the drivers
core to initialize the pinctrl stuff.

But all of this works just because, in the example of my emulated setup,
my fake server exposes resources that are exactly named just as how the
above DT expects pins/functions/pins to be named, because this is how
the Generic Pinctrl subsystem in Linux is supposed to work, right ?

The difference is that the names, in the case of pinctrl-scmi, are not
hardcoded in the specific pin-controller driver BUT are provided dynamically
by the SCMI server at runtime.

And this is just a naming convention, between the Linux picntrl subsys AND
the SCMI server, that allows the Linux Pinctrl subsys to map, under-hood,
names to type/IDs as expected by the SCMI protocol layer (and by the spec):
so when you will define and describe a real platform with a DT, you will
will have to provide your name references, knowing that the shipped platform
SCMI fw will advertise exactly the same (or a superset of them)

As such, personally, I would find reasonable to use, equally, some
conventional function name like 'gpio' to advertise and configure groups
of pins as being used as GPIOs.

Maybe, though, both of these expected naming comventions should be
explicitly stated in the spec: indeed if you look at some Sensor protocol
extensions added in v3.0, in 4.7.2.5.1 "Sensor Axis Descriptors"
regarding naming we say:

"It is recommended that the name ends with ‘_’
followed by the axis of the sensor in uppercase. For
example, the name for the x-axis of a triaxial
accelerometer could be “acc_X” or “_X”."

...so maybe some similar remarks could be added here.

Souvik is really the one who can have a say about the opportunity (or
not) of these kind of explicit advised naming conventions on the spec,
so I have CCed him.
 
> On Mon, Nov 06, 2023 at 02:12:36PM +0100, Linus Walleij wrote:
> > On Fri, Oct 27, 2023 at 8:28???AM Oleksii Moisieiev
> > <Oleksii_Moisieiev@epam.com> wrote:
> > 
> > > +                keys_pins: keys-pins {
> > > +                    pins = "GP_5_17", "GP_5_20", "GP_5_22", "GP_2_1";
> > > +                    bias-pull-up;
> > > +                };
> > 
> > This is kind of interesting and relates to my question about naming groups and
> > functions of GPIO pins.
> > 
> > Here we see four pins suspiciously named "GP_*" which I read as
> > "generic purpose"
> > and they are not muxed to *any* function, yes pulled up.
> > 
> > I would have expected something like:
> > 
> > keys_pins: keys-pins {
> >   groups = "GP_5_17_grp", "GP_5_20_grp", "GP_5_22_grp", "GP_2_1_grp";
> >   function = "gpio";
> >   pins = "GP_5_17", "GP_5_20", "GP_5_22", "GP_2_1";
> >   bias-pull-up;
> > };
> > 
> > I hope this illustrates what I see as a problem in not designing in
> > GPIO as an explicit
> > function, I get the impression that these pins are GPIO because it is hardware
> > default.
> 
> If you want to stick to "explicit", we may rather introduce a pre-defined
> sub-node name, "gpio", in a device tree binding, i.e.
> 
>   protocol@19 { // pinctrl protocol
>       ... // other pinmux nodes
> 
>       scmi_gpio: gpio { // "gpio" is a fixed name
>           keys-pins {
>               pins = "GP_5_17", "GP_5_20", "GP_5_22", "GP_2_1";
>               bias-pull-up;
>               // possibly input or output
>           };
>           input-pins {
>               groups = "some group"; // any name
>               input-mode;
>           }
>           output-pins {
>               pins = "foo1", "foo2"; // any name
>               output-mode;
>           }
>       }
>   }
>

I suppose your proposal of a specially named "gpio" node would be
another way, BUT it would also mean describing something in the DT that
could be discoverable dynamically querying the server (while making the
above assumptions about conventions).

Thanks,
Cristian
