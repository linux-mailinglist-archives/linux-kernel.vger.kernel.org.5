Return-Path: <linux-kernel+bounces-52886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 145D2849DD6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A8F285117
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A4D2CCB4;
	Mon,  5 Feb 2024 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TnzMcBJ1"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4032C84C;
	Mon,  5 Feb 2024 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146437; cv=none; b=BH5aPoY/cpDReaF6NaokJ8PqLMUPBPlPNR53VDhucFHo2XIIL2BpmQkkT/JT4CPNkObJ/iTJKzt4hkEnktOUEu1E4DMB+baH0X5/xCc5lNJ8Bwhzgc79uPfIUzp/d+uZ2fwlkTpqaAVGIbtikTKoWUQxTWmDDbawWDU8MM7vXcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146437; c=relaxed/simple;
	bh=hpLodnPFTzGDmybN3BEWyUWqwYKKEqaVJLjW6ZG61sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRUuobislM3FIyyDhaPy7IkF4L5SscKaHz86uide0zABHMc6Z3SlFqY2G52gZAkWNAq5IXmTzXUqzAph58rCCUloczPou6x57HfrY5ceJrCA5ZiC05Hoh+oiKkLo2BNqSAKEUoPLvADcOeVT8P0CE32MYpfNDvmfm1P72m6uhvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TnzMcBJ1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ybapUfqzuvYYWTklz2FUq3Tu24rh2dOO9XsrfWbS7YY=; b=TnzMcBJ1FcNgRR3WOsGVIUTGQu
	wsTRA8QaiF3Yhfo9HyugD5whR5g6esiNWH5+KDEozZKCZ7J1/JsCrMUsapyy1dEIyOdmSavTUyahV
	V2MhL+OCk+UUdgoMUmyOu+aY0nwZczlEyP2G8VylzZjzxrVxzqZDKgwr8/gZXQ3+5jcc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rX0lg-0072dB-IZ; Mon, 05 Feb 2024 16:20:20 +0100
Date: Mon, 5 Feb 2024 16:20:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David <david@davidv.dev>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: make driver settling time configurable
Message-ID: <580001e3-17ef-4f24-8fd8-bc14110e874e@lunn.ch>
References: <20240205114609.440597-1-david@davidv.dev>
 <1e08910b-8ae2-4985-8423-45a1a823cefc@lunn.ch>
 <bfbad418-f8c6-4cdf-97b5-5c13044539e8@davidv.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfbad418-f8c6-4cdf-97b5-5c13044539e8@davidv.dev>

On Mon, Feb 05, 2024 at 03:31:38PM +0100, David wrote:
> On 2/5/24 15:06, Andrew Lunn wrote:
> > On Mon, Feb 05, 2024 at 12:44:40PM +0100, David Ventura wrote:
> > > During IP auto configuration, some drivers apparently need to wait a
> > > certain length of time to settle; as this is not true for all drivers,
> > > make this length of time configurable.
> > Do you see this problem with multiple drivers, or just one in
> > particular. To me this seems like a driver bug, and you are just
> > papering over the cracks.
> > 
> > 	Andrew
> I don't know of any drivers that may need to wait -- I noticed
> this code path being hit when building a minimal kernel that only
> had a virtio network device.
> At least for the virtio device, the wait is unnecessary and bloats
> the time to boot a minimal kernel from 15ms to 33ms.

Looking at the code, a delay has been here a long time, since before
git. However, 2011 the delay was changes from 1 second to 10ms. There
was a discussion about this at the time:

https://lore.kernel.org/netdev/1305696161-18277-1-git-send-email-micha@neli.hopto.org/t/

It was said that ARP and DHCP retries should recover any system where
the first transmit/receive gets lost with the change from 1s to 10ms.

Maybe after 12 years, its time to try a default of 0ms? I would
suggest that is a second patch, which is easy to revert if it all goes
horribly wrong.

	 Andrew

