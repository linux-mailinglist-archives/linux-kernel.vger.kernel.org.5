Return-Path: <linux-kernel+bounces-70105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECC6859320
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 23:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1743AB21205
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 22:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F154880043;
	Sat, 17 Feb 2024 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="c6TUOfad"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C7E7CF0D;
	Sat, 17 Feb 2024 22:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708207820; cv=none; b=kF06D0hdMoE8dS5krrpg9tqhkFXDpPH72KPxQoZSWXYgCRasNfT2tAE2ZiI1xo3Xoc2mXzhOSIwTFvQYnvhiMs234afh540+P+BvCOr7vFM+qcNz1Dg3d4Isr87/t3HY64X61U2PK8E4MWpH8yu2IbBdvHr9dlT4L3z/OEnAUoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708207820; c=relaxed/simple;
	bh=mYKwzXe2ZRGlF20vDTg03J91yT8nqSlhzoN8Ylq1xjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMTwvWUAlrwm7iTaWOTSGiinBjgFnBqdB8QG6D6E+y4dBLmt0MFPkDDMa9oMdC2Rhj5xvAIy7dc5o1VtC2ZjdDkLeKVycpz2aWgT+kYvlLkqfo1ZBChlWckJNTSqbBZslQj4/oPtBfp+sKM9+06PdisfN1KpByjXFhnEkwGi+pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=c6TUOfad; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dBMEFj+vUqAqgSWaC9a7/Khmdxlt5g8WjS7g/9NczGU=; b=c6TUOfadK4NqEjqMqSb5/Ek+Gq
	CSL/AFvP1Zq8sMM+xK7J2+sqWrkksPZNvHspX8F9efTEIbztyWQz+li5nMENrtD09dqVHeJWQ04Rz
	ssNHCK2YCkMFw5ibUxERy7+Cj8czdLNeGHVtpgVtXS4Lemr7UrpjeJW9UD5U3D8sXrKc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rbSsp-0085e9-VR; Sat, 17 Feb 2024 23:10:07 +0100
Date: Sat, 17 Feb 2024 23:10:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v8 04/13] net: Change the API of PHY default
 timestamp to MAC
Message-ID: <9e2ce7a0-e938-4f5f-aae9-cfee3a066628@lunn.ch>
References: <20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com>
 <20240216-feature_ptp_netnext-v8-4-510f42f444fb@bootlin.com>
 <87jzn4gtlv.fsf@nvidia.com>
 <b8926fe5-81ef-40ea-9e87-5e84b368b745@lunn.ch>
 <87o7cebx9z.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7cebx9z.fsf@nvidia.com>

> > Could you give some examples? It seems odd to me, the application
> > wants a less accurate timestamp?
> >
> > Is it more about overheads? A MAC timestamp might be less costly than
> > a PHY timestamp?
> 
> It's a combination of both though I think primarily about line rate.
> This point is somewhat carried over from the previous discussions on
> this patch series in the last revision.

Sorry, i've not been keeping up with the discussion. That could also
mean whatever i say below is total nonsense!

> I assume the device in question
> here cannot timestamp at the PHY at a high rate.
> 
>   https://lore.kernel.org/netdev/20231120093723.4d88fb2a@kernel.org/
> 
> >
> > Or is the application not actually doing PTP, it does not care about
> > the time of the packet on the wire, but it is more about media access
> > control? Maybe the applications you are talking about are misusing the
> > PTP API for something its not intended?
> 
> So hardware timestamping is not a PTP specific API or application right?

Well, we have drivers/ptp. The IOCTL numbers are all PTP_XXXX. It
seems like the subsystem started life in order to support PTP. It is
not unusual for a subsystem to gain extra capabilities, and maybe PTP
timestamps can be used in a more general way than the PTP
protocol.

> It's purely a socket option that is not tied to PTP (unless I am missing
> something here).
> 
>   https://docs.kernel.org/networking/timestamping.html#timestamp-generation
> 
> So you could use this information for other applications like congestion
> control where you do not want to limit the line rate using the PHY
> timestamping mechanism.

I think the key API point here is, you need to separate PTP stamping
from other sorts of stamping. PTP stamping generally works better at
the lowest point. So PTP stamping could be PHY stamping. If the PHY
does not support PTP, or its implementation is poor, PTP stamping can
be performed at the MAC. There are plenty of MACs which support that.
So we need an API to configure where PTP stamping is performed.

I expect the socket option is more generic. It is more about, give me
a time stamp at a specific point in the stack. It is probably not
being used by PTP, it could be used for flow control, etc. We probably
need an API to configure that SOF_TIMESTAMPING_RX_HARDWARE actually
means. It could be the PHY time stamp, maybe the MAC timestamp. Same
for SOF_TIMESTAMPING_TX_HARDWARE, it could be the MAC, could be the
PHY. But whatever they mean, i expect they are separate PTP.

> In mlx5, we only steering PTP traffic to our PHY timestamping mechanism
> through a traffic matching logic.
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h?id=a6e0cb150c514efba4aaba4069927de43d80bb59#n71
> 
> This is because we do not want to PHY/port timestamp timing related
> applications such as congestion control. I think it makes sense for
> specialized timestamping applications to instead use the ethtool ioctl
> to reconfigure using the PHY timestamps if the device is capable of PHY
> timestamping. (So have the change be in userspace application tools like
> linuxptp where precise but low <relative> rate timestamp information is
> ideal).

I would expect linuxptp is only interested in the PTP timestamp. It
might be interested where the stamp is coming from, PHY or MAC, but it
probably does not care too much, it just assumes the time stamp is
good for PTP. But i would expect linuxptp has no interest in what the
generic socket options are doing.

    Andrew

