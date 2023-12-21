Return-Path: <linux-kernel+bounces-8094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9D481B21A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2A91F23192
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4E24EB56;
	Thu, 21 Dec 2023 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKDXin5u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45B04EB46;
	Thu, 21 Dec 2023 09:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FCAC433C8;
	Thu, 21 Dec 2023 09:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703149734;
	bh=88oXhSF+rhYZhelTwKokwU9Sbkk5HFBCZH6RBQhsahE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KKDXin5uKJfHVSo00Yhg3t600TDjhpdItjPoL0EVfoTSpZPXB9Vo972PfXAywWqFH
	 NqaStISp+YaFogwMrYandG+hphmkNidpX9gKCRBqTaMzhNd6MMCRVxIQWbhhmgSyJD
	 Ve0/+c6YAH/0WUmiVDBqALl/a/0jmaqDB4Zxt5lhGcqW0p7eboNb6qeXPdB5W38JPt
	 MlSgyMmk+1s1cWskfjzIFTu1UfMJofdKR+3fn0jNESEdOHj6M+Y8E/9etuGBSEoJ66
	 ZjqCklbWH3cBtKjJibBpg5GeQyVT5ZxZ+feWO5l6UQlcWK7Y+Vz3HZ5PXTvwizDpeI
	 ztRLBITWJAxIw==
Date: Thu, 21 Dec 2023 10:08:48 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Daniel Golle
 <daniel@makrotopia.org>, "David S. Miller" <davem@davemloft.net>, Li Zetao
 <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org
Subject: Re: [PATCH v5 1/2] leds: trigger: netdev: display only supported
 link speed attribute
Message-ID: <20231221100848.4a7da2df@dellmb>
In-Reply-To: <20231220224827.27667-1-ansuelsmth@gmail.com>
References: <20231220224827.27667-1-ansuelsmth@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 23:48:26 +0100
Christian Marangi <ansuelsmth@gmail.com> wrote:

> With the addition of more link speed mode to the netdev trigger, it was
> pointed out that there may be a problem with bloating the attribute list
> with modes that won't ever be supported by the trigger as the attached
> device name doesn't support them.
> 
> To clear and address this problem, change the logic where these
> additional trigger modes are listed.
> 
> Since the netdev trigger REQUIRE a device name to be set, attach to the
> device name change function additional logic to parse the supported link
> speed modes using ethtool APIs and show only the supported link speed
> modes attribute.
> 
> Link speed attribute are refreshed on device_name set and on
> NETDEV_CHANGE events.
> 
> This only apply to the link speed modes and every other mode is still
> provided by default.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Took a while but I found a way to not use phy_speeds.
> 
> Saddly that is way too specific to PHYs and we can't add PHYLIB as
> a dependency for leds.
> 
> I instead found a handy way to keep everything to ethtool, it's a bit
> worse optimization wise but does the same work. (the perf penality
> is really minimal as we only parse supported speeds and it's difficult
> to have a device that have tons of speeds modes)
> 
> Changes v5:
> - Add macro to make code less ugly
> Changes v4:
> - Rework to use an alternative to phy_speeds API
> Changes v3:
> - Use phy_speeds API to parse the ethtool mask
> Changes v2:
> - Use is_visibile instead of removing/adding attr
> 
>  drivers/leds/trigger/ledtrig-netdev.c | 88 +++++++++++++++++++++++++--
>  1 file changed, 82 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
> index bd68da15c723..f0f946747ff5 100644
> --- a/drivers/leds/trigger/ledtrig-netdev.c
> +++ b/drivers/leds/trigger/ledtrig-netdev.c
> @@ -18,10 +18,12 @@
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/leds.h>
> +#include <linux/linkmode.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
>  #include <linux/mutex.h>
> +#include <linux/phy.h>
>  #include <linux/rtnetlink.h>
>  #include <linux/timer.h>
>  #include "../leds.h"
> @@ -55,12 +57,15 @@ struct led_netdev_data {
>  
>  	unsigned long mode;
>  	int link_speed;
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported_link_modes);
>  	u8 duplex;
>  
>  	bool carrier_link_up;
>  	bool hw_control;
>  };
>  
> +static const struct attribute_group netdev_trig_link_speed_attrs_group;
> +
>  static void set_baseline_state(struct led_netdev_data *trigger_data)
>  {
>  	int current_brightness;
> @@ -208,13 +213,19 @@ static void get_device_state(struct led_netdev_data *trigger_data)
>  	struct ethtool_link_ksettings cmd;
>  
>  	trigger_data->carrier_link_up = netif_carrier_ok(trigger_data->net_dev);
> -	if (!trigger_data->carrier_link_up)
> +
> +	if (__ethtool_get_link_ksettings(trigger_data->net_dev, &cmd))
>  		return;
>  
> -	if (!__ethtool_get_link_ksettings(trigger_data->net_dev, &cmd)) {
> +	if (trigger_data->carrier_link_up) {
>  		trigger_data->link_speed = cmd.base.speed;
>  		trigger_data->duplex = cmd.base.duplex;
>  	}
> +
> +	/* Have a local copy of the link speed supported to not rtnl lock every time

                                                         ^ to avoid

> +	 * Modes are refreshed on any change event to handle mode changes

           ^ capital letter but not beginning of sentence

If you change these two, you can add my R-b tag to both patches.


I am also wondering if this sysfs ABI could be extended for multi-color
LEDs.

For example:
  echo green >link_1000
  echo yellow >link_100

Or something like that. But that is a completely different discussion.

