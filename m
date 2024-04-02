Return-Path: <linux-kernel+bounces-127964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82848953BC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54B2DB28CF9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9094E83CC2;
	Tue,  2 Apr 2024 12:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OJdKj1HK"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84A383CAE;
	Tue,  2 Apr 2024 12:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061816; cv=none; b=kBypFGljyevGnu+XgKYBHAGWfudQdRGr9UXLO570eaW+hnfVx2U1NGYcqKeTGlyYA8L2hTzEIs57XGuqnCb2HpPSfKxZDbMO3C0j5A8DRV1JtMsTGDdzdUFbYrFs5rVyNiPgp6GU57D6gCG3i3xA30z0UuSSCDrdgEP+dbPBw+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061816; c=relaxed/simple;
	bh=VivqYiAwv696fYdSTkay9yA82RmxUJhfYOOKNR/4Gpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFvngTrpqUbYTyhtNhcNjeoycnWap/imHVT7kEsBdW3VpZLLDXEoWfI0F4D1sMKVqW2ClmgBqWIT67dsrLiBmL197IksJ5H1x6GpqnYvTLs+1QJrqUKMmGqV1DbNTbtRAA9krH+6t2OyGt1FN95jGftipcwhZwXRgHNNm3AgYMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OJdKj1HK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=L4Tuu8ZWoWyYde4nc1r0Y5vT8GQqfazueKk7eTauMNw=; b=OJdKj1HK2b+4ih9vRCqOLZN9/j
	gWWsJWKEDHg0zfAMlDQJLb7clmLVLoGKkBhq9CPauel69cSaAls5eLpquO7KdsaUxnTwu8NKM3A2c
	+1fpdbMMWfxl4hV2pk70614bEmt2Cvj0pDd6ZqyylkYQ6Xm+OC9Jcon18MP8IESv2JNQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rrdTy-00BwGD-LJ; Tue, 02 Apr 2024 14:43:18 +0200
Date: Tue, 2 Apr 2024 14:43:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH RFC net-next 00/10] MC Flood disable and snooping
Message-ID: <f5512e7b-b572-4444-9d56-1eed9bbcda6b@lunn.ch>
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402001137.2980589-1-Joseph.Huang@garmin.com>

On Mon, Apr 01, 2024 at 08:10:59PM -0400, Joseph Huang wrote:
> There is a use case where one would like to enable multicast snooping
> on a bridge but disable multicast flooding on all bridge ports so that
> registered multicast traffic will only reach the intended recipients and
> unregistered multicast traffic will be dropped. However, with existing
> bridge ports' mcast_flood flag implementation, it doesn't work as desired.
> 
> This patchset aims to make multicast snooping work even when multicast
> flooding is disabled on the bridge ports, without changing the semantic of
> the mcast_flood flag too much. Patches 1 to 4 attempt to address this issue.
> 
> Also, in a network where more than one multicast snooping capable bridges
> are interconnected without multicast routers being present, multicast
> snooping fails if:
> 
>   1. The source is not directly attached to the Querier
>   2. The listener is beyond the mrouter port of the bridge where the
>      source is directly attached
>   3. A hardware offloading switch is involved

I've not studied the details here, but that last point makes me think
the offload driver is broken. There should not be any difference
between software bridging and hardware bridging. The whole idea is
that you take what Linux can do in software and accelerate it by
offloading to hardware. Doing acceleration should not change the
behaviour.

> The patches were developed against 5.15, and forward-ported to 6.8.
> Tests were done on a Pi 4B + Marvell 6393X Eval board with a single
> switch chip with no VLAN.

So what is the mv88e6xxx driver doing wrong?

	Andrew


