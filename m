Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C5C79E04B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 08:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbjIMG7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 02:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjIMG7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 02:59:04 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD68173E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 23:59:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qgJpl-00010A-4Y; Wed, 13 Sep 2023 08:58:45 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qgJpk-005wdx-9L; Wed, 13 Sep 2023 08:58:44 +0200
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qgJpj-0064HV-L3; Wed, 13 Sep 2023 08:58:43 +0200
Date:   Wed, 13 Sep 2023 08:58:43 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
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
Message-ID: <20230913065843.GF637806@pengutronix.de>
References: <20230904115816.1237684-1-s.hauer@pengutronix.de>
 <20230904115816.1237684-2-s.hauer@pengutronix.de>
 <CACRpkdYxRdToUM3JcEeNK_K87D5WDzzSLvVEbtqqdQEhz3k_Ow@mail.gmail.com>
 <CAGb2v65G-8EECNjqnpKCxqAD5nATAb0S7AA_WMiGXYOR1avrvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v65G-8EECNjqnpKCxqAD5nATAb0S7AA_WMiGXYOR1avrvg@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 12:37:54PM +0800, Chen-Yu Tsai wrote:
> On Tue, Sep 12, 2023 at 4:07 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > Top posting to bring Saravana Kannan into this discussion.
> >
> > This looks like a big hack to me, Saravana has been working
> > tirelessly to make the device tree probe order "sort itself out"
> > and I am pretty sure this issue needs to be fixed at the DT
> > core level and not in a driver.
> 
> We could merge all the IO domain stuff into the pinctrl node/driver,
> like is done for Allwinner? Maybe that would simplify things a bit?

I thought about this as well. On Rockchip the pinctrl driver and the IO
domain driver even work on the same register space, so putting these
into a single node/driver would even feel more natural than what we have
now.
However, with that the pinctrl node would get the supplies that the IO
domain node now has and we would never get into the probe of the pinctrl
driver due to the circular dependencies.

> 
> IIRC on Allwinner SoCs the PMIC pins don't have a separate power rail,
> or if they do they almost certainly use the default I/O rail that is
> always on, and so we omit it to work around the dependency cycle.

I looked into sun50i as an example. This one has two pinctrl nodes, pio
and r_pio. Only the former has supplies whereas the latter, where the
PMIC is connected to, has (found in sun50i-a64-pinephone.dtsi):

&r_pio {
	/*
	 * FIXME: We can't add that supply for now since it would
	 * create a circular dependency between pinctrl, the regulator
	 * and the RSB Bus.
	 *
	 * vcc-pl-supply = <&reg_aldo2>;
	 */
};

At least it show me that I am not the first one who has this problem ;)

We could add the supplies to the pingroup subnodes of the pinctrl driver
to avoid that, but as Saravana already menioned, that would feel like
overkill.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
