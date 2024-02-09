Return-Path: <linux-kernel+bounces-60069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C05F84FF78
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4331F283603
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D877225748;
	Fri,  9 Feb 2024 22:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Iy5YZcwt"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3B618AE4;
	Fri,  9 Feb 2024 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707516732; cv=none; b=suu6MgnvYD9Z3Q0stSP7oFwkNAiVNrwTZC8zcP3mIzjOOijk6y+PIU7o2RtwIGucnBLTuyOo8H5BP1mNjzT6j8f97HKq13sW1UHKbAz1DtQw39yWvKEkoEYEQh3jlOWGmCj8zwxXWbnaP8oA7TAaXIQJ4jbD7pwjjngSfLoP6C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707516732; c=relaxed/simple;
	bh=6oi2fMAr5Pa/CcrOzzWHwIc25Cj/SWFT1BQ4zQmQJ6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8WG24D9QPL+1wMiZdXjX8rKSByKCRLiEudkjDTQGWz5hIfvRGRG0CyBkbwykE5R9TtELhvgmD0WNlk3sRMZMvZaUOKcmR1/ldD+x0aP/SSxaedkCpnZy1hZJzjxnualb4fotK1rms/OUu0CzpvVOVar6svEJ/E4q6OZkr/tF1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Iy5YZcwt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Li/m2CO1iH9ZTlT4q9LrLguLOr9rrO94b5DkDf2WAJI=; b=Iy5YZcwtloEbmqNWDFuCkS/ag3
	xF98DSUvYa6MMxUjuw+qRsat09Hkk+BqMQ7UnKaGDEeqzbrhUui6P9SkgZL2CrojlhmTaRrpzC9GV
	8LqEpO/pTvbnlW/Yby63W7squg0yKMNgfMi8lpinDgd0algbRTmMvP0/g8CDYj2TwTGQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rYZ69-007Q99-PG; Fri, 09 Feb 2024 23:11:53 +0100
Date: Fri, 9 Feb 2024 23:11:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ventura <david@davidv.dev>, Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:NETWORKING [IPv4/IPv6]" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] net: make driver settling time configurable
Message-ID: <7485f0b2-93fe-4c82-95e8-5b0e10f9fa7a@lunn.ch>
References: <20240208093722.246930-1-david@davidv.dev>
 <20240208095358.251381-1-david@davidv.dev>
 <20240209135944.265953be@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209135944.265953be@kernel.org>

On Fri, Feb 09, 2024 at 01:59:44PM -0800, Jakub Kicinski wrote:
> On Thu,  8 Feb 2024 10:52:29 +0100 David Ventura wrote:
> > During IP auto configuration, some drivers apparently need to wait a
> > certain length of time to settle; as this is not true for all drivers,
> > make this length of time configurable.
> 
> Please CC folks who gave you feedback, Andrew's is missing.
> 
> Andrew, what do you think about just removing the wait?
> Or decreasing it to 1ms?
> It feels a little wasteful to be adding uAPI for something
> which as you said is likely papering over ancient bugs. We'll 
> fix the bugs which are still around and the uAPI will stay 
> forever :(

My guess is, the broken drivers are doing setup stuff after they call
netdev_register().

Reducing it to 1ms will probably continue to hide such bugs. So we
could just go with that, and probably not see any regressions. Or we
can decide we really do want to know about broken drivers, and just
remove the delay.

Either way, we don't need a new uAPI.

David, is 1ms too long for you? If we do take the delay out, you are
going to receive some of the flack from regression reports.

      Andrew


