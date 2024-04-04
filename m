Return-Path: <linux-kernel+bounces-132184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F05689910A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FEEB1F2376B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE7913C3F4;
	Thu,  4 Apr 2024 22:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bkoPPZ18"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6A113C3DF;
	Thu,  4 Apr 2024 22:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712268724; cv=none; b=pFTeAewWbJLvQFFbRfW1zZjZU2kfvDsLvDby5n7tkswcQ3c1ouCzLg8oLJpB3yOPHKC9E6b2KLdZ/bAfZn7WoyRPRPCmCXZwMNaV4Oigy/BviPqeudZpBgKf1085RwnWOe1qnGjlEnGQTZ2LoVw+vXxfYI8EJ14m0upoGa9WgxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712268724; c=relaxed/simple;
	bh=ZnX7DwugUfNwNH8YtGd8Qbbpcv7XYT2KMkbjx+Yt7A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tx+O+C3TEZNEzw6NLLf7YFu37iyDGDW6rlzQCgPWEZP7lBCCm5kveM9rvqLZ9u+/KZb3yzCzuGXXzlUHMHs7i6jfwOlFUOmhOhplOhwiw8+Lcsgg0UEw9z62xwuO+PsQa61WUb5io47trEs1RazoNaxQBFYuplPaXhjZ3umgnJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bkoPPZ18; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wF0piU5Bum94a3TqN990DQ0BqoHBjzdesA2kdLohbls=; b=bkoPPZ18rFow9S+p4VD+hwtV2c
	YVv56WUHqp6UcY66ae4Dn6BK5G9irkN6ghn1J6HIqLwS3LnBQqgPffUdTBq/WKN1+7jCYATloR0sN
	nVN6msTrATYeYkkIIwA0RksBq4AGmKC6LjfhH2lDj3VBNzech5rpNWHrbYAZL44x+yqw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rsVJ0-00CDmV-A9; Fri, 05 Apr 2024 00:11:34 +0200
Date: Fri, 5 Apr 2024 00:11:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Joseph Huang <joseph.huang.2024@gmail.com>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH RFC net-next 00/10] MC Flood disable and snooping
Message-ID: <630c37d6-b1c6-466b-8d00-fdc84585d5e7@lunn.ch>
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <f5512e7b-b572-4444-9d56-1eed9bbcda6b@lunn.ch>
 <4c28d59e-0c4f-462c-8a1c-d4bd72e25115@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c28d59e-0c4f-462c-8a1c-d4bd72e25115@gmail.com>

On Thu, Apr 04, 2024 at 05:35:41PM -0400, Joseph Huang wrote:
> Hi Andrew,
> 
> On 4/2/2024 8:43 AM, Andrew Lunn wrote:
> > On Mon, Apr 01, 2024 at 08:10:59PM -0400, Joseph Huang wrote:
> > > There is a use case where one would like to enable multicast snooping
> > > on a bridge but disable multicast flooding on all bridge ports so that
> > > registered multicast traffic will only reach the intended recipients and
> > > unregistered multicast traffic will be dropped. However, with existing
> > > bridge ports' mcast_flood flag implementation, it doesn't work as desired.
> > > 
> > > This patchset aims to make multicast snooping work even when multicast
> > > flooding is disabled on the bridge ports, without changing the semantic of
> > > the mcast_flood flag too much. Patches 1 to 4 attempt to address this issue.
> > > 
> > > Also, in a network where more than one multicast snooping capable bridges
> > > are interconnected without multicast routers being present, multicast
> > > snooping fails if:
> > > 
> > >   1. The source is not directly attached to the Querier
> > >   2. The listener is beyond the mrouter port of the bridge where the
> > >      source is directly attached
> > >   3. A hardware offloading switch is involved
> > 
> > I've not studied the details here, but that last point makes me think
> > the offload driver is broken. There should not be any difference
> > between software bridging and hardware bridging. The whole idea is
> > that you take what Linux can do in software and accelerate it by
> > offloading to hardware. Doing acceleration should not change the
> > behaviour.
> > 
> 
> In patch 10 I gave a little more detail about the fix, but basically this is
> what happened.
> 
> Assuming we have a soft bridge like the following:
> 
>             bp1 +------------+
>   Querier <---- |   bridge   |
>                 +------------+
>                bp2 |      | bp3
>                    |      |
>                    v      v
>             MC Source    MC Listener
> 
> Here bp1 is the mrouter port, bp2 is connected to the multicast source, and
> bp3 is connected to the multicast listener who wishes to receive multicast
> traffic for that group.
> 
> After some Query/Report exchange, the snooping code in the bridge is going
> to learn about the Listener from bp3, and is going to create an MDB group
> which includes bp3 as the sole member. When the bridge receives a multicast
> packet for that group from bp2, the bridge will do a look up to find the
> members of that group (in this case, bp3) and forward the packet to every
> single member in that group. At the same time, the bridge will also forward
> the packet to every mrouter port so that listeners beyond mrouter ports can
> receive that multicast packet as well.
> 
> Now consider the same scenario, but with a hardware-offloaded switch:
> 
>                 +------------+
>                 |   bridge   |
>                 +------------+
>                       ^
>                       |
>                       | p6 (Host CPU port)
>          p1/bp1 +------------+
>   Querier <---- |     sw     |
>                 +------------+
>             p2/bp2 |      | p3/bp3
>                    |      |
>                    v      v
>             MC Source    MC Listener
> 
> Same Query/Report exchange, same MDB group, except that this time around the
> MDB group will be offloaded to the switch as well. So in the switch's ATU we
> will now have an entry for the multicast group and with p3 being the only
> member of that ATU. When the multicast packet arrives at the switch from p2,
> the switch will do an ATU lookup, and forward the packet to p3 only. This
> means that the Host CPU (p6) will not get a copy of the packet, and so the
> soft bridge will not have the opportunity to forward that packet to the
> mrouter port. This is what patch 10 attempts to address.
> 
> One possible solution of course is to add p6 to every MDB group, however
> that's probably not very desirable. Besides, it will be more efficient if
> the packet is forwarded to the mrouter port by the switch in hardware (i.e.,
> offload mrouter forwarding), vs. being forwarded in the bridge by software.

Thanks for the explanation. So i think the key part which you said
above is:

  At the same time, the bridge will also forward the packet to every
  mrouter port so that listeners beyond mrouter ports can receive that
  multicast packet as well.

How does the bridge know about the mrouter port? It seems like the
bridge needs to pass that information down to the switch. Is the
mrouter itself performing a join on the group when it has members of
the group on the other side of it?

	Andrew

