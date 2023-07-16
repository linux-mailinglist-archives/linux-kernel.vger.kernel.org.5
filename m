Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169B9754F0D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 16:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjGPOo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 10:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjGPOoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 10:44:55 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A2CFA;
        Sun, 16 Jul 2023 07:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=SVZM4PFndxxCcq66T7tUspDKRLmLt+kbA9O41zp70/o=; b=oGDUJcA4aEU6/rxu5VxEYiuq4Z
        QeF7R8Cy24XDCcxbvD+5MahvthcCdw0eFFVBWBjalgoZ03jiQr4QKLyicPSb6jk4TWOMR2nUrgh8H
        r01JYDQ2KDY53FH1ldTxyeHoc+N6gnMxp6iPiNNyjNILD5F0CZNTKeLjyFGqT22w6RiY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qL2zI-001U0x-2c; Sun, 16 Jul 2023 16:44:40 +0200
Date:   Sun, 16 Jul 2023 16:44:40 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexandru Ardelean <alex@shruggie.ro>
Cc:     Rob Herring <robh@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
        olteanv@gmail.com, marius.muresan@mxt.ro
Subject: Re: [PATCH v2 2/2] dt-bindings: net: phy: vsc8531: document
 'vsc8531,clkout-freq-mhz' property
Message-ID: <7fa2d457-4ae9-42f5-be73-80549aae558c@lunn.ch>
References: <20230713202123.231445-1-alex@shruggie.ro>
 <20230713202123.231445-2-alex@shruggie.ro>
 <20230714172444.GA4003281-robh@kernel.org>
 <CAH3L5Qoj+sue=QnR2Lp12x3Hz2t2BNnarZHJiqxL3Gtf6M=bsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH3L5Qoj+sue=QnR2Lp12x3Hz2t2BNnarZHJiqxL3Gtf6M=bsA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So, there's the adin.c PHY driver which has a similar functionality
> with the adin_config_clk_out().
> Something in the micrel.c PHY driver (with
> micrel,rmii-reference-clock-select-25-mhz); hopefully I did not
> misread the code about that one.
> And the at803x.c PHY driver has a 'qca,clk-out-frequency' property too.
> 
> Now with the mscc.c driver, there is a common-ality that could use a framework.
> 
> @Rob are you suggesting something like registering a clock provider
> (somewhere in the PHY framework) and let the PHY drivers use it?
> Usually, these clock signals (once enabled on startup), don't get
> turned off; but I've worked mostly on reference designs; somewhere
> down the line some people get different requirements.
> These clocks get connected back to the MAC (usually), and are usually
> like a "fixed-clock" driver.

They are not necessarily fixed clocks. The clock you are adding here
has three frequencies. Two frequencies is common for PHY devices. So
you need to use something more than clk-fixed-rate.c. Also, mostly
PHYs allows the clock to be gated.

> In our case, turning off the clock would be needed if the PHY
> negotiates a non-gigabit link; i.e 100 or 10 Mbps; in that case, the
> CLKOUT signal is not needed and it can be turned off.

Who does not need it? The PHY, or the MAC? If it is the MAC, it should
really be the MAC driver which uses the common clock API to turn it
off. Just watch out for deadlocks with phydev->lock.

> Maybe start out with a hook in 'struct phy_driver'?
> Like "int (*config_clk_out)(struct phy_device *dev);" or something?
> And underneath, this delegates to the CLK framework?

Yes, have phy_device.c implement that registration/unregister of the
clock, deal with locking, and call into the PHY driver to actually
manipulate the clock. You missed the requested frequency in the
function prototype. I would also call it refclk. Three is sometimes
confusion about the different clocks.

Traditionally, clk_enable() can be called in atomic context, but that
is not allowed with phylib, it always assume thread context. I don't
know if the clock framework has some helpers for that, but i also
don't see there being a real need for MAC to enable the clock in
atomic context.

	Andrew
