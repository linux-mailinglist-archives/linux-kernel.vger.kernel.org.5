Return-Path: <linux-kernel+bounces-98207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F12877676
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 12:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93C71C209F4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 11:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25603208A1;
	Sun, 10 Mar 2024 11:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C18pgkBj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BF916FF29;
	Sun, 10 Mar 2024 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710071373; cv=none; b=pC2/G/u78DfXnvpMY8h2SBpHrZ2LE4JTPfhOkU1KL/wtft1aNOpFWbnfRmCMAfveDWrcEzydE8NGMZ5po8azD275Cg+QIvmgZk6iEX1qZ2rXVDLS99+mKQZQaLNDKjfNtHrJEjGigIamoApzxjxsYox59t8HjLIW8xzKq4cuzDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710071373; c=relaxed/simple;
	bh=1CPSPWKfeTpBYcxj9JbHIwE+z04fdAne8Tv5luZAwpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kB5gAaBvSaPAbSwaoA7+0Wr1OPqGKFnVFNjWLkrODuNRQ1Pa8lGq14+WBf4hfFWUaQX7HWt7s/pNmxcMrs3tk6fTjHfv632AWYXQEGO7sjLKhIZxyZ9Tt9xDedmWIIrLb/NPmhFd1pY+9yu/GirpKVXy6/6ijL+AOoMWK17EzuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C18pgkBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A43BC433F1;
	Sun, 10 Mar 2024 11:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710071372;
	bh=1CPSPWKfeTpBYcxj9JbHIwE+z04fdAne8Tv5luZAwpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C18pgkBj8LXSm//I0XvH6iAbf756bJH0LSvcReVJTVxVvAXIK9f5MZuXNSSAikDjC
	 s2jfOFZD5AcXZB8b3tEh2Nr/jyHASQKL7jvRGJJ+pxOD3erV8PeRQ3GhlP8+iciZPg
	 250V1xpXiFWOg+PIiQ9lNaVBQmwNSftjCH2eGA7H2cw1akYg1hEKI+yHD2u5l3lB23
	 dfCqU/DqEOECio8k3g+1NiKLVv49KKzA2XortL1gRKG5IkCHfefJcKeCJCDLGrj77I
	 RI7hV+L2zkImi5kX1yjQZEyzLnroXc6hgKHR+xP+WuLBNe/CG6sV0OltIcBcZbtIve
	 4EMpvHHJmhdKQ==
Date: Sun, 10 Mar 2024 11:49:28 +0000
From: Simon Horman <horms@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] net: dsa: realtek: add LED drivers for
 rtl8366rb
Message-ID: <20240310114928.GB1623@kernel.org>
References: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
 <20240310-realtek-led-v1-4-4d9813ce938e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240310-realtek-led-v1-4-4d9813ce938e@gmail.com>

On Sun, Mar 10, 2024 at 01:52:01AM -0300, Luiz Angelo Daros de Luca wrote:
> This commit introduces LED drivers for rtl8366rb, enabling LEDs to be
> described in the device tree using the same format as qca8k. Each port
> can configure up to 4 LEDs.
> 
> If all LEDs in a group use the default state "keep", they will use the
> default behavior after a reset. Changing the brightness of one LED,
> either manually or by a trigger, will disable the default hardware
> trigger and switch the entire LED group to manually controlled LEDs.
> Once in this mode, there is no way to revert to hardware-controlled LEDs
> (except by resetting the switch).
> 
> Software triggers function as expected with manually controlled LEDs.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/net/dsa/realtek/rtl8366rb.c | 270 ++++++++++++++++++++++++++++++++----

..

> +static int rtl8366rb_setup_led(struct realtek_priv *priv, struct dsa_port *dp,
> +			       struct fwnode_handle *led_fwnode)
> +{
> +	struct rtl8366rb *rb = priv->chip_data;
> +	struct led_init_data init_data = { };
> +	struct rtl8366rb_led *led;
> +	enum led_default_state state;
> +	u32 led_group;
> +	int ret;

nit: Please consider using reverse xmas tree - longest line to shortest -
     for local variables in networking code.

..

> +static int rtl8366rb_setup_leds(struct realtek_priv *priv)
> +{
> +	struct device_node *leds_np, *led_np;
> +	struct dsa_switch *ds = &priv->ds;
> +	struct dsa_port *dp;
> +	int ret;
> +
> +	dsa_switch_for_each_port(dp, ds) {
> +		if (!dp->dn)
> +			continue;
> +
> +		leds_np = of_get_child_by_name(dp->dn, "leds");
> +		if (!leds_np) {
> +			dev_dbg(priv->dev, "No leds defined for port %d",
> +				dp->index);
> +			continue;
> +		}
> +
> +		for_each_child_of_node(leds_np, led_np) {
> +			ret = rtl8366rb_setup_led(priv, dp,
> +						  of_fwnode_handle(led_np));
> +			if (ret) {
> +				of_node_put(led_np);

FWIIW, Coccinelle complans about "probable double put" here.
But it looks correct to me as it's only called when breaking out of
the loop, when it is required AFAIK.

> +				break;
> +			}
> +		}
> +
> +		of_node_put(leds_np);
> +		if (ret)

I'm unsure if this can happen. But if for_each_child_of_node()
iterates zero times then ret may be uninitialised here.

Flagged by Smatch.

> +			return ret;
> +	}
> +	return 0;
> +}

..

