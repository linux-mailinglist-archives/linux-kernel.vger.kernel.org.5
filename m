Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AABD7AB02D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjIVLEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbjIVLEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:04:34 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58002FB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 04:04:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qjdxK-0003K1-KQ; Fri, 22 Sep 2023 13:04:18 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qjdxJ-0088vQ-Ar; Fri, 22 Sep 2023 13:04:17 +0200
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qjdxJ-00Awlj-3I; Fri, 22 Sep 2023 13:04:17 +0200
Date:   Fri, 22 Sep 2023 13:04:17 +0200
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
Message-ID: <20230922110417.GV637806@pengutronix.de>
References: <20230904115816.1237684-1-s.hauer@pengutronix.de>
 <20230904115816.1237684-2-s.hauer@pengutronix.de>
 <CACRpkdYxRdToUM3JcEeNK_K87D5WDzzSLvVEbtqqdQEhz3k_Ow@mail.gmail.com>
 <CAGb2v65G-8EECNjqnpKCxqAD5nATAb0S7AA_WMiGXYOR1avrvg@mail.gmail.com>
 <20230913065843.GF637806@pengutronix.de>
 <CAGETcx8rO=aykjb6=5k0wpOyscqokNwSL6w-AHnodY7pNXyzGQ@mail.gmail.com>
 <20230915065120.GQ637806@pengutronix.de>
 <CAGETcx-stUfkVmkwGhj7iBWfCRsY5uZ=CxJdX9pPY6OO6oGUhg@mail.gmail.com>
 <20230921135756.GT637806@pengutronix.de>
 <CAGETcx8Ora87tbjVek-2WZW1QqHp+uB63r4w73ekBByPUDdTpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx8Ora87tbjVek-2WZW1QqHp+uB63r4w73ekBByPUDdTpw@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 01:49:21PM -0700, Saravana Kannan wrote:
> On Thu, Sep 21, 2023 at 6:57 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >
> > On Wed, Sep 20, 2023 at 03:00:28PM -0700, Saravana Kannan wrote:
> > > On Thu, Sep 14, 2023 at 11:51 PM Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > > >
> > > > On Wed, Sep 13, 2023 at 01:48:12PM -0700, Saravana Kannan wrote:
> > > > > On Tue, Sep 12, 2023 at 11:58 PM Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > > > > >
> > > > > > On Wed, Sep 13, 2023 at 12:37:54PM +0800, Chen-Yu Tsai wrote:
> > > > > > > On Tue, Sep 12, 2023 at 4:07 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > > > > > >
> > > > > > > > Top posting to bring Saravana Kannan into this discussion.
> > > > > > > >
> > > > > > > > This looks like a big hack to me, Saravana has been working
> > > > > > > > tirelessly to make the device tree probe order "sort itself out"
> > > > > > > > and I am pretty sure this issue needs to be fixed at the DT
> > > > > > > > core level and not in a driver.
> > > > > > >
> > > > > > > We could merge all the IO domain stuff into the pinctrl node/driver,
> > > > > > > like is done for Allwinner? Maybe that would simplify things a bit?
> > > > > >
> > > > > > I thought about this as well. On Rockchip the pinctrl driver and the IO
> > > > > > domain driver even work on the same register space, so putting these
> > > > > > into a single node/driver would even feel more natural than what we have
> > > > > > now.
> > > > >
> > > > > Then we should try to do this and fix any issues blocking us.
> > > > >
> > > > > > However, with that the pinctrl node would get the supplies that the IO
> > > > > > domain node now has and we would never get into the probe of the pinctrl
> > > > > > driver due to the circular dependencies.
> > > > >
> > > > > From a fw_devlink perspective, the circular dependency shouldn't be a
> > > > > problem. It's smart enough to recognize all cycle possibilities (since
> > > > > 6.3) and not enforce ordering between nodes in a cycle.
> > > > >
> > > > > So, this is really only a matter of pinctrl not trying to do
> > > > > regulator_get() in its probe function. You need to do the
> > > > > regulator_get() when the pins that depend on the io-domain are
> > > > > requested. And if the regulator isn't ready yet, return -EPROBE_DEFER?
> > > >
> > > > That's basically what my series does already, I return -EPROBE_DEFER
> > > > from the pinctrl driver when a pin is requested and the IO domain is not
> > > > yet ready.
> > > >
> > > > >
> > > > > Is there something that prevents us from doing that?
> > > >
> > > > No. We could do that, but it wouldn't buy us anthing. I am glad to hear
> > > > that fw_devlink can break the circular dependencies. With this we could
> > > > add the supplies to the pinctrl node and the pinctrl driver would still
> > > > be probed.
> > > >
> > > > With the IO domain supplies added to the pinctrl node our binding would
> > > > be cleaner, but still we would have to defer probe of many requested
> > > > pins until finally the I2C driver providing access to the PMIC comes
> > > > along. We also still need a "Do not defer probe for these pins" property
> > > > in the pingrp needed for the I2C driver.
> > >
> > > Sorry about the slow reply. Been a bit busy.
> > >
> > > Oh, this is not true though. With the example binding I gave,
> > > fw_devlink will automatically defer the probe of devices that depend
> > > on pins that need an iodomain/regulator.
> > >
> > > pinctrl {
> > >     compatible = "rockchip,rk3568-pinctrl";
> > >     i2c0 {
> > >                 /omit-if-no-ref/
> > >                 i2c0_xfer: i2c0-xfer {
> > >                         rockchip,pins =
> > >                                 /* i2c0_scl */
> > >                                 <0 RK_PB1 1 &pcfg_pull_none_smt>,
> > >                                 /* i2c0_sda */
> > >                                 <0 RK_PB2 1 &pcfg_pull_none_smt>;
> > >                 };
> > >     }
> > >     ...
> > >     ...
> > >     pinctrl-io {
> > >         compatible = "rockchip,rk3568-pinctrl-io";
> > >         pmuio1-supply = <&vcc3v3_pmu>;
> > >         cam {
> > >             ....
> > >         }
> > >         ....
> > >         ....
> > > }
> > >
> > > consumerA {
> > >    pinctrl-0 = <&cam>;
> > > }
> > >
> > > With this model above, there are no cycles anymore.
> >
> > The cycles are gone because you skipped the problematic case in your
> > example.
> >
> > Replace consumerA in your example with the I2C node providing access to
> > the PMIC which provides &vcc3v3_pmu and then you have the cycles back.
> 
> When you are talking about the I2C node that's the bus master for the
> PMIC providing the supply, wouldn't it be dependent on "i2c0_xfer"?
> And not "cam"?
> 
> Otherwise there's a cyclic functional dependency in hardware that can
> never be met? Because in that case, your changes would end up
> deferring the I2C device probe too.

Yes, that's exactly the problem. There is a functional dependency in
hardware. This can only be resolved by assuming the hardware is already
correctly configured to access the PMIC.

> 
> I'm basically asking to split out the pins that need IO domain to work
> into a new subnode "pinctrl-io" of the main "pinctrl" device node.
> 
> > The I2C master device needs the IO domain which needs a regulator
> > provided by a client on the very same I2C master. The cycles are
> > actually there in hardware, you can't define them away ;)
> 
> Right, there can be a cyclic connection dependency in hardware and you
> can't define them away. But clearly the I2C master doesn't need the IO
> domain to work for the I2C to be initialized, right?

No, not right. The I2C master indeed does need the IO domain to be
correctly configured and the IO domain can only be configured correctly
when we know the voltage the PMIC supplies to the IO domain.

> Otherwise, how
> can the I2C hardware be initialized? It doesn't matter what OS we
> have, that hardware can't work. So, what am I missing? We are clearly
> not on the same page on some details.

This works by configuring the IO domain with static values in the
bootloader which knows the reset default PMIC voltage.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
