Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0AE7A1672
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 08:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjIOGvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 02:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjIOGvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 02:51:36 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EA32707
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 23:51:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qh2fg-0006XC-V7; Fri, 15 Sep 2023 08:51:20 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qh2fg-006TUD-5a; Fri, 15 Sep 2023 08:51:20 +0200
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qh2fg-007DWU-2j; Fri, 15 Sep 2023 08:51:20 +0200
Date:   Fri, 15 Sep 2023 08:51:20 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        kernel@pengutronix.de,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/3] pinctrl: rockchip: add support for io-domain
 dependency
Message-ID: <20230915065120.GQ637806@pengutronix.de>
References: <20230904115816.1237684-1-s.hauer@pengutronix.de>
 <20230904115816.1237684-2-s.hauer@pengutronix.de>
 <CACRpkdYxRdToUM3JcEeNK_K87D5WDzzSLvVEbtqqdQEhz3k_Ow@mail.gmail.com>
 <CAGb2v65G-8EECNjqnpKCxqAD5nATAb0S7AA_WMiGXYOR1avrvg@mail.gmail.com>
 <20230913065843.GF637806@pengutronix.de>
 <CAGETcx8rO=aykjb6=5k0wpOyscqokNwSL6w-AHnodY7pNXyzGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx8rO=aykjb6=5k0wpOyscqokNwSL6w-AHnodY7pNXyzGQ@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 01:48:12PM -0700, Saravana Kannan wrote:
> On Tue, Sep 12, 2023 at 11:58 PM Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >
> > On Wed, Sep 13, 2023 at 12:37:54PM +0800, Chen-Yu Tsai wrote:
> > > On Tue, Sep 12, 2023 at 4:07 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > >
> > > > Top posting to bring Saravana Kannan into this discussion.
> > > >
> > > > This looks like a big hack to me, Saravana has been working
> > > > tirelessly to make the device tree probe order "sort itself out"
> > > > and I am pretty sure this issue needs to be fixed at the DT
> > > > core level and not in a driver.
> > >
> > > We could merge all the IO domain stuff into the pinctrl node/driver,
> > > like is done for Allwinner? Maybe that would simplify things a bit?
> >
> > I thought about this as well. On Rockchip the pinctrl driver and the IO
> > domain driver even work on the same register space, so putting these
> > into a single node/driver would even feel more natural than what we have
> > now.
> 
> Then we should try to do this and fix any issues blocking us.
> 
> > However, with that the pinctrl node would get the supplies that the IO
> > domain node now has and we would never get into the probe of the pinctrl
> > driver due to the circular dependencies.
> 
> From a fw_devlink perspective, the circular dependency shouldn't be a
> problem. It's smart enough to recognize all cycle possibilities (since
> 6.3) and not enforce ordering between nodes in a cycle.
> 
> So, this is really only a matter of pinctrl not trying to do
> regulator_get() in its probe function. You need to do the
> regulator_get() when the pins that depend on the io-domain are
> requested. And if the regulator isn't ready yet, return -EPROBE_DEFER?

That's basically what my series does already, I return -EPROBE_DEFER
from the pinctrl driver when a pin is requested and the IO domain is not
yet ready.

> 
> Is there something that prevents us from doing that?

No. We could do that, but it wouldn't buy us anthing. I am glad to hear
that fw_devlink can break the circular dependencies. With this we could
add the supplies to the pinctrl node and the pinctrl driver would still
be probed.

With the IO domain supplies added to the pinctrl node our binding would
be cleaner, but still we would have to defer probe of many requested
pins until finally the I2C driver providing access to the PMIC comes
along. We also still need a "Do not defer probe for these pins" property
in the pingrp needed for the I2C driver.

I would consider this being a way to cleanup the bindings, but not a
solution at DT core level that Linus was aiming at.

> 
> > >
> > > IIRC on Allwinner SoCs the PMIC pins don't have a separate power rail,
> > > or if they do they almost certainly use the default I/O rail that is
> > > always on, and so we omit it to work around the dependency cycle.
> >
> > I looked into sun50i as an example. This one has two pinctrl nodes, pio
> > and r_pio. Only the former has supplies whereas the latter, where the
> > PMIC is connected to, has (found in sun50i-a64-pinephone.dtsi):
> >
> > &r_pio {
> >         /*
> >          * FIXME: We can't add that supply for now since it would
> >          * create a circular dependency between pinctrl, the regulator
> >          * and the RSB Bus.
> >          *
> >          * vcc-pl-supply = <&reg_aldo2>;
> >          */
> > };
> >
> > At least it show me that I am not the first one who has this problem ;)
> >
> > We could add the supplies to the pingroup subnodes of the pinctrl driver
> > to avoid that, but as Saravana already menioned, that would feel like
> > overkill.
> 
> So my comment yesterday was that it'd be an overkill to make every
> struct pin_desc into a device. But if you can split that rockchip
> pinctrl into two devices, that should be okay and definitely not an
> overkill.
> 
> Maybe something like:
> 
> pinctrl {
>     compatible = "rockchip,rk3568-pinctrl";
>     i2c0 {
>                 /omit-if-no-ref/
>                 i2c0_xfer: i2c0-xfer {
>                         rockchip,pins =
>                                 /* i2c0_scl */
>                                 <0 RK_PB1 1 &pcfg_pull_none_smt>,
>                                 /* i2c0_sda */
>                                 <0 RK_PB2 1 &pcfg_pull_none_smt>;
>                 };
>     }
>     ...
>     ...
>     pinctrl-io {
>         compatible = "rockchip,rk3568-pinctrl-io";
>         pmuio1-supply = <&vcc3v3_pmu>;
>         cam {
>             ....
>         }
>         ....
>         ....
> }
> 
> So pinctrl will probe successfully and add it's child device
> pinctrl-io. i2c0 will probe once pinctrl is available. Then eventually
> the regulator will probe. And after all that, pinctrl-io would probe.
> 
> This has no cycles and IMHO represents the hardware accurately. You
> have a pinctrl block and there's a sub component of it (pinctrl-io)
> that works differently and has additional dependencies.
> 
> Any thoughts on this?

By making the IO domain device a child node of the pinctrl node we
wouldn't need a phandle from the pinctrl node to the IO domain node
anymore, but apart from that the approach is equivalent to what we have
already.

Given that fw_devlink allows us to add the supplies directly to the
pinctrl node, I would prefer doing that. But as said, it doesn't solve
the problem.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
