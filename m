Return-Path: <linux-kernel+bounces-133049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D09899E0D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2651F22E91
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824BB16D4CB;
	Fri,  5 Apr 2024 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PYVjk4eo"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E42516D309;
	Fri,  5 Apr 2024 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712322607; cv=none; b=TG0yfOWj5UpDlhuy6eaLbJiQfUinO3rOvWS2R9iWa98OGn9n7xJssucg+w3hQ63KsWKHINOjc47gWE0UwfgKFGQ4TX2v8jvQWvR1krZVKOKEybKvdzajrJPa547yWSb4YrpHagUSb5ebUHd4BHtSuBhSgd1x7+FZLtvn4z9o3uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712322607; c=relaxed/simple;
	bh=5P62dgtJCBrTs4Iej822GldmeGtfHwFj6F1jakBcg0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fx8mrg+ocT1FbmJd2Qv2eakfBfAa7wW6MdZWL/u2wN3Ow4ucyD7QYsXt5Ud0nKvnjuLPsMsjqZ1HAVznAxzDNrkzj96mu/NRLlo5UBAsEmBRFcQIZL8cYF1MjvuUafmlimFb85KzkPy5HOxFgQXXGUZ6FaMZUksyWVPwoEa8Jfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PYVjk4eo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kl6Yrw/d6rxXv43u6n8i8uN5SsjBxSsc1BcC9x0beuM=; b=PYVjk4eoECX6ZMhDjD3ZOj2+4+
	QzD1DWiL61A9tcI/a8bveg+8xbSkdBix+9Q3TedvAhNlUbALXKzpLgi7PoF3tSVeHF0tu6a96a2qO
	KEK9rzx0ykFT/cvzwVFVhNGpT+dRuOF6YLtDHrizgcuILI4MBzB5Ba3IzHwlbjYSLI6U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rsjKE-00CIwP-0y; Fri, 05 Apr 2024 15:09:46 +0200
Date: Fri, 5 Apr 2024 15:09:46 +0200
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
Message-ID: <4511d7cc-d7c0-4095-8a37-b2eefffb0ca2@lunn.ch>
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <f5512e7b-b572-4444-9d56-1eed9bbcda6b@lunn.ch>
 <4c28d59e-0c4f-462c-8a1c-d4bd72e25115@gmail.com>
 <630c37d6-b1c6-466b-8d00-fdc84585d5e7@lunn.ch>
 <2c3cddda-7ac6-4fc2-b1fa-775c048259e1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c3cddda-7ac6-4fc2-b1fa-775c048259e1@gmail.com>

> > Thanks for the explanation. So i think the key part which you said
> > above is:
> > 
> >    At the same time, the bridge will also forward the packet to every
> >    mrouter port so that listeners beyond mrouter ports can receive that
> >    multicast packet as well.
> > 
> > How does the bridge know about the mrouter port? It seems like the
> 
> The bridge learns about the existence of the Querier by the reception of
> Queries. The bridge will mark the port which it received Queries from as the
> mrouter port.
> 
> > bridge needs to pass that information down to the switch. Is the
> 
> The bridge does pass that information down to switchdev. Patch 5 adds DSA
> handling of that event as well. Patches 9 and 10 adds the support in the
> mv88e6xxx driver.

I've not been looking at the details too much for this patchset. It
does however seem that some parts are controversial, and others just
seem like a bug fix. Does it make sense to split this into two
patchsets?

	Andrew

