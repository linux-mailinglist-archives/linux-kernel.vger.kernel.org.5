Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAB38110BB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378813AbjLMMF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378805AbjLMMFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:05:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F230010A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:05:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E06C433C8;
        Wed, 13 Dec 2023 12:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702469129;
        bh=x3oRn837VPa7bmsGIuv/KDiEKRYzL03PVgV7p67+CHQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fWPgbClHGcESgcgFfFV+nPKAvUcJrVYgQMbLkRIDX0gfSxTIDFSGWlL8xs4t5oKtA
         X/3ua3ilSEnI4z88sykJ8WIfvy5Pwe/R4a8bNdOLqDgdyNekuNnN2nAE1F74HC1mx5
         sRlUS3AJu/vhcNQmOgVKZ69M4RDN3K4Klr5bSFAUNTpjJrHS8RTmgernGm57gBNAB5
         11s9TcnXYquMdLUYnr74m0Fwgo8Qc6icP/3t6rCZu8MPR3FNLkw5CUG4xYlWzGc0Rh
         DvRqB4Mf81N9VMBM8mKb8LCucLwnOwze1rgp4Sfy3P3FyWGLivKdHWM/NKbiGGwyad
         1zZU9O9iA0pWQ==
Date:   Wed, 13 Dec 2023 13:05:21 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Li Zetao <lizetao1@huawei.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: trigger: netdev: display only supported link
 speed attribute
Message-ID: <20231213130521.11513e0a@dellmb>
In-Reply-To: <20231209150724.25565-1-ansuelsmth@gmail.com>
References: <20231209150724.25565-1-ansuelsmth@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 Dec 2023 16:07:24 +0100
Christian Marangi <ansuelsmth@gmail.com> wrote:

> With the addition of more link speed mode to the netdev trigger, it was
> pointed out that there may be a problem with bloating the attribute list
> with modes that won't ever be supported by the trigger as the attached
> device name doesn't support them.
> 
> To clear and address this problem, change the logic where these
> additional trigger modes are added.
> 
> Since the netdev trigger REQUIRE a device name to be set, attach to the
> device name change function additional logic to parse the supported link
> speed modes using ethtool APIs and add only the supported link speed
> modes attribute.
> 
> This only apply to the link speed modes and every other mode is still
> provided by default.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/leds/trigger/ledtrig-netdev.c | 56 +++++++++++++++++++++++----
>  1 file changed, 49 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
> index 09e75fd9f2bc..ce84808e231c 100644
> --- a/drivers/leds/trigger/ledtrig-netdev.c
> +++ b/drivers/leds/trigger/ledtrig-netdev.c
> @@ -61,6 +61,8 @@ struct led_netdev_data {
>  	bool hw_control;
>  };
>  
> +static int add_link_speed_attr(struct led_netdev_data *trigger_data);
> +
>  static void set_baseline_state(struct led_netdev_data *trigger_data)
>  {
>  	int current_brightness;
> @@ -262,8 +264,10 @@ static int set_device_name(struct led_netdev_data *trigger_data,
>  	trigger_data->carrier_link_up = false;
>  	trigger_data->link_speed = SPEED_UNKNOWN;
>  	trigger_data->duplex = DUPLEX_UNKNOWN;
> -	if (trigger_data->net_dev)
> +	if (trigger_data->net_dev) {
>  		get_device_state(trigger_data);
> +		add_link_speed_attr(trigger_data);
> +	}
>  
>  	trigger_data->last_activity = 0;
>  
> @@ -396,6 +400,50 @@ DEFINE_NETDEV_TRIGGER(full_duplex, TRIGGER_NETDEV_FULL_DUPLEX);
>  DEFINE_NETDEV_TRIGGER(tx, TRIGGER_NETDEV_TX);
>  DEFINE_NETDEV_TRIGGER(rx, TRIGGER_NETDEV_RX);
>  
> +static int add_link_speed_attr(struct led_netdev_data *trigger_data)
> +{
> +	struct led_classdev *led_cdev = trigger_data->led_cdev;
> +	struct device *dev = led_cdev->dev;
> +	struct ethtool_link_ksettings cmd;
> +	int ret;
> +
> +	/* First remove any entry previously added */
> +	device_remove_file(dev, &dev_attr_link_10);
> +	device_remove_file(dev, &dev_attr_link_100);
> +	device_remove_file(dev, &dev_attr_link_1000);
> +	device_remove_file(dev, &dev_attr_link_2500);
> +	device_remove_file(dev, &dev_attr_link_5000);
> +	device_remove_file(dev, &dev_attr_link_10000);

Noooooo!

> +	ret = __ethtool_get_link_ksettings(trigger_data->net_dev, &cmd);
> +	if (ret)
> +		return ret;
> +
> +	/* Add only supported entry */
> +	if (test_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, cmd.link_modes.supported) ||
> +	    test_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, cmd.link_modes.supported))
> +		device_create_file(dev, &dev_attr_link_10);
> +
> +	if (test_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, cmd.link_modes.supported) ||
> +	    test_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, cmd.link_modes.supported))
> +		device_create_file(dev, &dev_attr_link_100);
> +
> +	if (test_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, cmd.link_modes.supported) ||
> +	    test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, cmd.link_modes.supported))
> +		device_create_file(dev, &dev_attr_link_1000);
> +
> +	if (test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, cmd.link_modes.supported))
> +		device_create_file(dev, &dev_attr_link_2500);
> +
> +	if (test_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, cmd.link_modes.supported))
> +		device_create_file(dev, &dev_attr_link_5000);
> +
> +	if (test_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, cmd.link_modes.supported))
> +		device_create_file(dev, &dev_attr_link_10000);
> +
> +	return 0;
> +}

This should be done via the is_visible sysfs attribute_group method.

Also documentation for the link_* files should be changed so that it
says that the files are present only if those speeds are available.

Marek
