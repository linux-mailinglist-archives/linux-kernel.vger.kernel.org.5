Return-Path: <linux-kernel+bounces-130126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8E6897465
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8B028C01E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1625B14A4FC;
	Wed,  3 Apr 2024 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrBcFKXl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A9C14A4C4;
	Wed,  3 Apr 2024 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159366; cv=none; b=qFdGVQdI9kSmLF2Kjh++Jdz/Rb6Cuku0jUKvqmrA6/vn59JRCbINt3ls+FolCQ+1kcAt754r/ItSzhuxhyb0ETgPRuZqBAq7VO0kfkc4MROd+Zx+dzBSdCYBjACnc2kHtBMbQ848CoQddaizbCx8VQtB3TP6sKyNFptlvwDZXis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159366; c=relaxed/simple;
	bh=k6dyOhfFQIf9vQIFCpUxUQulSUGcvn1uNJXKGOMIMvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHHKtQuljTjbhvI2HP7ur6xxR7/k4iYzq6uJZK8bhbD6OLLfDPVHtKaYyF1FppGZynkaj5rmIdqIbsZ6nK27UdBTa4VyE0sCH6FDE/MRpeFE0qtoseUaKbT1ARyxen4BuTLWOAKXfwHZoRiKiVlFVO6KDFoxUJdxwUJfUWcCn5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrBcFKXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DC8C43390;
	Wed,  3 Apr 2024 15:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712159366;
	bh=k6dyOhfFQIf9vQIFCpUxUQulSUGcvn1uNJXKGOMIMvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hrBcFKXlV84WvwdXTJ1EywXpIa7TCT7pO8gOx7ssARAppf6BJDhk9Z8sOK7hS9kZr
	 0ZuW/ZJBRc2RSTi6YMprbytvzjZr2bfZj2k6RpMbi1RgY0CvqLuhiBUlvP3kXoAitd
	 CHOu1mU9LXMxEvBJoeAzXpWK1zYYnUfDYeMFvgXnDHWFhHUT4hcjCDwThkmlG89/g5
	 oxJBYofJBMdMkil2p3ADRNxhWBahluV1wuhQnqt0pQAIv3F3Jzp3evB3oyhWOMPVX7
	 oRLgYSr0FJyH7V7o5mr4nvMyAFdotIUfUpQUXMEtrzMJ47A2EJWRnU+g9QQWyXkjXK
	 HgjnL2E/3Fsmg==
Date: Wed, 3 Apr 2024 16:49:21 +0100
From: Simon Horman <horms@kernel.org>
To: Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH RFC net-next 09/10] net: dsa: mv88e6xxx: Enable mc flood
 for mrouter port
Message-ID: <20240403154921.GN26556@kernel.org>
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <20240402001137.2980589-10-Joseph.Huang@garmin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402001137.2980589-10-Joseph.Huang@garmin.com>

On Mon, Apr 01, 2024 at 08:11:08PM -0400, Joseph Huang wrote:
> When a port turns into an mrouter port, enable multicast flooding
> on that port even if multicast flooding is disabled by user config. This
> is necessary so that in a distributed system, the multicast packets
> can be forwarded to the Querier when the multicast source is attached
> to a Non-Querier bridge.
> 
> Consider the following scenario:
> 
>                  +--------------------+
>                  |                    |
>                  |      Snooping      |    +------------+
>                  |      Bridge 1      |----| Listener 1 |
>                  |     (Querier)      |    +------------+
>                  |                    |
>                  +--------------------+
>                            |
>                            |
>                  +--------------------+
>                  |    | mrouter |     |
> +-----------+    |    +---------+     |
> | MC Source |----|      Snooping      |
> +-----------|    |      Bridge 2      |
>                  |    (Non-Querier)   |
>                  +--------------------+
> 
> In this scenario, Listener 1 will never receive multicast traffic
> from MC Source if multicast flooding is disabled on the mrouter port on
> Snooping Bridge 2.
> 
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>

..

> @@ -6849,11 +6864,28 @@ static int mv88e6xxx_port_bridge_flags(struct dsa_switch *ds, int port,
>  
>  	if (flags.mask & BR_MCAST_FLOOD) {
>  		bool multicast = !!(flags.val & BR_MCAST_FLOOD);
> +		struct mv88e6xxx_bridge *mv_bridge;
> +		struct mv88e6xxx_port *p;
> +		bool mrouter;
>  
> -		err = chip->info->ops->port_set_mcast_flood(chip, port,
> -							    multicast);
> -		if (err)
> -			goto out;
> +		mv_bridge = mv88e6xxx_bridge_by_port(chip, port);
> +		if (!mv_bridge)
> +			return -EINVAL;

I think that mv88e6xxx_reg_unlock(chip) is needed here.
So perhaps (completely untested!):

		if (!mv_bridge) {
			err = -EINVAL;
			goto out;
		}

Flagged by Smatch

> +
> +		p = &chip->ports[port];
> +		mrouter = !!(mv_bridge->mrouter_ports & BIT(port));
> +
> +		if (!mrouter) {
> +			err = chip->info->ops->port_set_mcast_flood(chip, port,
> +								    multicast);
> +			if (err)
> +				goto out;
> +		}
> +
> +		if (multicast)
> +			p->flags |= MV88E6XXX_PORT_FLAG_MC_FLOOD;
> +		else
> +			p->flags &= ~MV88E6XXX_PORT_FLAG_MC_FLOOD;
>  	}
>  
>  	if (flags.mask & BR_BCAST_FLOOD) {
> @@ -6883,6 +6915,51 @@ static int mv88e6xxx_port_bridge_flags(struct dsa_switch *ds, int port,
>  	return err;
>  }
>  
> +static int mv88e6xxx_port_mrouter(struct dsa_switch *ds, int port,
> +				  bool mrouter,
> +				  struct netlink_ext_ack *extack)
> +{
> +	struct mv88e6xxx_chip *chip = ds->priv;
> +	struct mv88e6xxx_bridge *mv_bridge;
> +	struct mv88e6xxx_port *p;
> +	bool old_mrouter;
> +	bool mc_flood;
> +	int err;
> +
> +	if (!chip->info->ops->port_set_mcast_flood)
> +		return -EOPNOTSUPP;
> +
> +	mv_bridge = mv88e6xxx_bridge_by_port(chip, port);
> +	if (!mv_bridge)
> +		return -EINVAL;
> +
> +	old_mrouter = !!(mv_bridge->mrouter_ports & BIT(port));
> +	if (mrouter == old_mrouter)
> +		return 0;
> +
> +	p = &chip->ports[port];
> +	mc_flood = !!(p->flags & MV88E6XXX_PORT_FLAG_MC_FLOOD);
> +
> +	mv88e6xxx_reg_lock(chip);
> +
> +	if (!mc_flood) {
> +		err = chip->info->ops->port_set_mcast_flood(chip, port,
> +							    mrouter);
> +		if (err)
> +			goto out;
> +	}
> +
> +	if (mrouter)
> +		mv_bridge->mrouter_ports |= BIT(port);
> +	else
> +		mv_bridge->mrouter_ports &= ~BIT(port);
> +
> +out:
> +	mv88e6xxx_reg_unlock(chip);

If mc_flood is true then err is uninitialised here.

Flagged by clang-17 W=1 build, and Smatch.

> +
> +	return err;
> +}
> +
>  static bool mv88e6xxx_lag_can_offload(struct dsa_switch *ds,
>  				      struct dsa_lag lag,
>  				      struct netdev_lag_upper_info *info,

..

