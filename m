Return-Path: <linux-kernel+bounces-139876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F028A08C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A81287A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F15713DBAC;
	Thu, 11 Apr 2024 06:48:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF78A13D258
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818097; cv=none; b=SY0O4MHxigmMAOQytUckA6N6U+7KJEv9+6nh16F/nah4gIjQqbcqkkjQdYdKB4YDsO9988lU1wkq4peZOLlN0ZpEqa41YZWfY0gFBmXQoYm4Ozc78lyXkQ8QG8ooC4LXtKXOyGYKBDpxSOe77xm2+jhWZSHv+s9SJD2WpBjjn2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818097; c=relaxed/simple;
	bh=SjfQmFCe8KGFg78GshUQPaGgkawI/DnASuuduYQmQ8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKvgn/aq08P72DF77A2Vo3nAdsueAAslIjNEfNHPMQ6RZrC2GSmr9HU2CTeoMRhlB+/S/C33Fkqv34VrlWHYi9UVS0x9764W5B2qSqRJylmtifnFUvGCeAyvjlWw3YrxHkpiNvPdyYpk+aIub/PdRfD6epAwF+5o7rsOJr7bnYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1ruoEA-00074u-0x; Thu, 11 Apr 2024 08:48:06 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1ruoE8-00BdUI-5L; Thu, 11 Apr 2024 08:48:04 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ruoE8-007cj5-0B;
	Thu, 11 Apr 2024 08:48:04 +0200
Date: Thu, 11 Apr 2024 08:48:04 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>, kernel@pengutronix.de,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v6 5/9] net: dsa: microchip: add support for
 different DCB app configurations
Message-ID: <ZheHpK7egVvszSQF@pengutronix.de>
References: <20240410080556.1241048-1-o.rempel@pengutronix.de>
 <20240410080556.1241048-1-o.rempel@pengutronix.de>
 <20240410080556.1241048-6-o.rempel@pengutronix.de>
 <20240410080556.1241048-6-o.rempel@pengutronix.de>
 <20240410231251.macw4i46jfi57wtc@skbuf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240410231251.macw4i46jfi57wtc@skbuf>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Vladimir,

On Thu, Apr 11, 2024 at 02:12:51AM +0300, Vladimir Oltean wrote:
> > +/**
> > + * ksz_dcb_init - Initializes the DCB configuration for a KSZ switch
> > + * @dev: Pointer to the KSZ switch device structure
> > + *
> > + * This function initializes the DCB configuration for a KSZ switch. The global
> > + * DSCP-to-priority mapping table is initialized.
> > + *
> > + * Return: 0 on success, or a negative error code on failure
> > + */
> > +int ksz_dcb_init(struct ksz_device *dev)
> > +{
> > +	int ret;
> > +
> > +	ret = ksz_init_global_dscp_map(dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> 
> Sorry for not responding to your previous question about this:
> https://lore.kernel.org/netdev/ZfmJ-O8XMT8oO-TS@pengutronix.de/
> Simply put, I had a period with not a lot of free time, even for reading
> emails.

No problem. I'm in continues similar state permanently DoSed by my
children, parents, etc... :) 

> I'm on the fence on whether your solution to the "global DSCP-to-prio
> mapping rather than per-port" problem is the right one.
> 
> We try to avoid baking policies into the kernel, no matter how well
> intended the 802.1Q and IETF RFC8325 recommendations are. They are still
> just recommendations and examples, and a particular use case may want to
> configure things completely differently (or as hinted in the Wi-Fi specific
> RFC8325: maybe the administrator doesn't want to assign the higher
> traffic classes, for network control protocols, by using IP DSCP, and
> doesn't want user flows to request DSCP values that would get access to
> these traffic classes. It can indeed be seen as a security concern).
>
> I empathize with the incovenience of having to map the per-netdev dcbnl
> application priority table API with a piece of hardware where that table
> is shared across all ports. But yet, I don't think it is a strong enough
> justification for us to make an exception and say: "yeah, ok, let's not
> even implement .port_set_dscp_prio() to make the thing configurable, but
> let's bake into the kernel a fixed policy that's good for everyone".
>
> No, I think we _need_ the thing to be configurable, and not try so hard
> with the ieee8021q helpers to hardcode things just right in the kernel.

Yes, I agree with you.

ieee8021q helpers are not the attempt to avoid the work needed to
implement global DSCP configuration. The interface is still needed and
we need to agree on how it should be implemented.

The problem which I try to address with ieee8021q helpers are initial
defaults. KSZ8 and KSZ9 families of switches have different initial
defaults. So, if i need to align defaults for this driver, why not to
provide default which are reusable for every one?

> Have you tried the obvious: "every time there is a change to the global
> DSCP mapping table, push the change into the dcbnl app table of all user
> netdevs, so that the user becomes aware of what happens"? Kernel drivers
> can do that, through direct calls to dcb_ieee_setapp(). DSA does it too,
> to probe the initial QoS configuration of the ports and push it to the
> application priority tables.

Hm... what interface should be used for the global DSCP mapping table?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

