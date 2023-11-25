Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D8D7F8C8C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 17:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjKYQuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 11:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjKYQuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 11:50:17 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8FCAA;
        Sat, 25 Nov 2023 08:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=qDrMZoJgPuorTOeOShLAAzI7/GxpWs/Y4O/DPqFLxBM=; b=PWoDYCafbAUSdVULNpIWQ24Wmd
        oDGhE67ZDkbL8VSibIyKsjVwSgemiCTE6w/TQRsPpFiy4k+odfppobwNAkOiRBBV31TbgYqJ0uTpO
        EMxlDzEBwi6R9N6c1GJkLF3bNk106KvANzWGiNiSUG5TcyrMkY5/TzXvF9Js6t16OU28=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r6vr8-001CHy-Pr; Sat, 25 Nov 2023 17:50:10 +0100
Date:   Sat, 25 Nov 2023 17:50:10 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sagar Cheluvegowda <quic_scheluve@quicinc.com>
Subject: Re: [PATCH net-next] net: phy: mdio_device: Reset device only when
 necessary
Message-ID: <37250e69-93f4-422f-bb4f-55a1d2238dcd@lunn.ch>
References: <20231121-net-phy-reset-once-v1-1-37c960b6336c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121-net-phy-reset-once-v1-1-37c960b6336c@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 04:10:37PM -0600, Andrew Halaney wrote:
> Currently the phy reset sequence is as shown below for a
> devicetree described mdio phy on boot:
> 
> 1. Assert the phy_device's reset as part of registering
> 2. Deassert the phy_device's reset as part of registering
> 3. Deassert the phy_device's reset as part of phy_probe
> 4. Deassert the phy_device's reset as part of phy_hw_init
> 
> The extra two deasserts include waiting the deassert delay afterwards,
> which is adding unnecessary delay.
> 
> Here's some snipped tracing output using the following command line
> params "trace_event=gpio:* trace_options=stacktrace" illustrating
> the reset handling and where its coming from:
> 
>     /* Assert */
>        systemd-udevd-283     [002] .....     6.780434: gpio_value: 544 set 0
>        systemd-udevd-283     [002] .....     6.783849: <stack trace>
>      => gpiod_set_raw_value_commit
>      => gpiod_set_value_nocheck
>      => gpiod_set_value_cansleep
>      => mdio_device_reset
>      => mdiobus_register_device
>      => phy_device_register
>      => fwnode_mdiobus_phy_device_register
>      => fwnode_mdiobus_register_phy
>      => __of_mdiobus_register
>      => stmmac_mdio_register
>      => stmmac_dvr_probe
>      => stmmac_pltfr_probe
>      => devm_stmmac_pltfr_probe
>      => qcom_ethqos_probe
>      => platform_probe
> 
>     /* Deassert */
>        systemd-udevd-283     [002] .....     6.802480: gpio_value: 544 set 1
>        systemd-udevd-283     [002] .....     6.805886: <stack trace>
>      => gpiod_set_raw_value_commit
>      => gpiod_set_value_nocheck
>      => gpiod_set_value_cansleep
>      => mdio_device_reset
>      => phy_device_register
>      => fwnode_mdiobus_phy_device_register
>      => fwnode_mdiobus_register_phy
>      => __of_mdiobus_register
>      => stmmac_mdio_register
>      => stmmac_dvr_probe
>      => stmmac_pltfr_probe
>      => devm_stmmac_pltfr_probe
>      => qcom_ethqos_probe
>      => platform_probe
> 
>     /* Deassert */
>        systemd-udevd-283     [002] .....     6.882601: gpio_value: 544 set 1
>        systemd-udevd-283     [002] .....     6.886014: <stack trace>
>      => gpiod_set_raw_value_commit
>      => gpiod_set_value_nocheck
>      => gpiod_set_value_cansleep
>      => mdio_device_reset
>      => phy_probe
>      => really_probe
>      => __driver_probe_device
>      => driver_probe_device
>      => __device_attach_driver
>      => bus_for_each_drv
>      => __device_attach
>      => device_initial_probe
>      => bus_probe_device
>      => device_add
>      => phy_device_register
>      => fwnode_mdiobus_phy_device_register
>      => fwnode_mdiobus_register_phy
>      => __of_mdiobus_register
>      => stmmac_mdio_register
>      => stmmac_dvr_probe
>      => stmmac_pltfr_probe
>      => devm_stmmac_pltfr_probe
>      => qcom_ethqos_probe
>      => platform_probe
> 
>     /* Deassert */
>       NetworkManager-477     [000] .....     7.023144: gpio_value: 544 set 1
>       NetworkManager-477     [000] .....     7.026596: <stack trace>
>      => gpiod_set_raw_value_commit
>      => gpiod_set_value_nocheck
>      => gpiod_set_value_cansleep
>      => mdio_device_reset
>      => phy_init_hw
>      => phy_attach_direct
>      => phylink_fwnode_phy_connect
>      => __stmmac_open
>      => stmmac_open
> 
> There's a lot of paths where the device is getting its reset
> asserted and deasserted. Let's track the state and only actually
> do the assert/deassert when it changes.

This only talks about GPIOs. There is also support for a linux reset
controller. It is getting turned on/off as many times. You should
mention this.

Now, lets compare the GPIO and the reset controller:

static int mdiobus_register_gpiod(struct mdio_device *mdiodev)
{
        /* Deassert the optional reset signal */
        mdiodev->reset_gpio = gpiod_get_optional(&mdiodev->dev,
                                                 "reset", GPIOD_OUT_LOW);
        if (IS_ERR(mdiodev->reset_gpio))
                return PTR_ERR(mdiodev->reset_gpio);

        if (mdiodev->reset_gpio)
                gpiod_set_consumer_name(mdiodev->reset_gpio, "PHY reset");

        return 0;
}

static int mdiobus_register_reset(struct mdio_device *mdiodev)
{
        struct reset_control *reset;

        reset = reset_control_get_optional_exclusive(&mdiodev->dev, "phy");
        if (IS_ERR(reset))
                return PTR_ERR(reset);

        mdiodev->reset_ctrl = reset;

        return 0;
}

For the GPIO controller, its clear what state it is in, because the
get call sets it to GPIOD_OUT_LOW. The reset controller however does
not have a clear state, we just get a reference to it.

But:

in mdiobus_register_device() we have:

                err = mdiobus_register_reset(mdiodev);
                if (err)
                        return err;

                /* Assert the reset signal */
                mdio_device_reset(mdiodev, 1);

suggesting the reset controller might have the opposite state to the
GPIO?

> diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
> index 044828d081d2..d2b9e62edaaa 100644
> --- a/drivers/net/phy/mdio_device.c
> +++ b/drivers/net/phy/mdio_device.c
> @@ -122,6 +122,9 @@ void mdio_device_reset(struct mdio_device *mdiodev, int value)
>  	if (!mdiodev->reset_gpio && !mdiodev->reset_ctrl)
>  		return;
>  
> +	if (mdiodev->reset_state == value)
> +		return;
> +

mdiodev is set to all 0 at creation time, and the GPIO is also set to
LOW when we get it. However, what about the reset controller?

I think it would be better to initialize reset_state to -1, indicating
we have no idea what the state is, and always perform the first reset
to ensure we are into a know state for both GPIO and the reset
controller.

	Andrew
