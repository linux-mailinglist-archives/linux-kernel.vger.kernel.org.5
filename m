Return-Path: <linux-kernel+bounces-107582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F9987FE8E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 782B2B24C5B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315758003F;
	Tue, 19 Mar 2024 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UKVanCcP"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AA63FBB9;
	Tue, 19 Mar 2024 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710854443; cv=none; b=d+a5JXoRcFfZLeusUwT8ntX+mm+0r+56YpfSehI4gw/Ksmo/dQ8ys+uLn7iXxVptQ2kiRMVIRAK8gDJ9PyQJa27H6zsnafvyTLuAVd2drQasDBscZHjsR/oLjCJLmu1kUwXnCTsVIF+iJfUhpxHZ+ERvsmlojeFStJaB1mCyHx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710854443; c=relaxed/simple;
	bh=FemAc31BQ+DmZdYMlelYJ4mSsfx8fmVsMXsdKwdnMz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNzgIvLGtbj4jgdqcqiQDwoxW+AEkkNs/DKgWN0WlLEsoaucSWH5M0biz5KNw82X0Q2cPG3eEuZX8e6FwRWBVUEONFJ/WcW0Fy8WiVc0GYeiCdBpR1TyBJQW2xCjbNk4KqHw6OeC5I1G6ZW/XScvJHG7DhEpo3RhXtcIFBcG8IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UKVanCcP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7cAXqVc8Nka7FmbxtID42guGYvW+jJ8a0zPwO5ce+Sg=; b=UKVanCcP0WPq++0fEsxSFuMwcy
	Jzw404z7EM7LyIlX1opm+8q9cASch8QROkawDA3qIhNOjWKpRmReOdGE3rAOBoYEE/msAB2py70Zg
	ZGaTy7yzsWTdsfmLDy+qv1Xqf8/I28DIEAmLn/x/v4TOUy4Ofsy/2XUo4nNKJ7cY3k2Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rmZOH-00Ahp1-Cz; Tue, 19 Mar 2024 14:20:29 +0100
Date: Tue, 19 Mar 2024 14:20:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban.Veerasooran@microchip.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Horatiu.Vultur@microchip.com,
	ruanjinjie@huawei.com, Steen.Hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v3 09/12] net: ethernet: oa_tc6: implement
 receive path to receive rx ethernet frames
Message-ID: <5b1e7439-a41f-426a-8bf1-9a5b20b44019@lunn.ch>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-10-Parthiban.Veerasooran@microchip.com>
 <49f8b067-4e56-4e8f-97e0-bac314619b82@lunn.ch>
 <cd971029-c1f3-40b0-b940-4d48e03b9f55@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd971029-c1f3-40b0-b940-4d48e03b9f55@microchip.com>

On Tue, Mar 19, 2024 at 12:54:34PM +0000, Parthiban.Veerasooran@microchip.com wrote:
> Hi Andrew,
> 
> On 08/03/24 5:44 am, Andrew Lunn wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> >> +static int oa_tc6_allocate_rx_skb(struct oa_tc6 *tc6)
> >> +{
> >> +     tc6->rx_skb = netdev_alloc_skb(tc6->netdev, tc6->netdev->mtu + ETH_HLEN +
> >> +                                    ETH_FCS_LEN + NET_IP_ALIGN);
> >> +     if (!tc6->rx_skb) {
> >> +             tc6->netdev->stats.rx_dropped++;
> >> +             netdev_err(tc6->netdev, "Out of memory for rx'd frame");
> > 
> > If that happens, it is not something which will fix itself quickly. So
> > you are likely to spam the logs. The counter on its own is probably
> > enough.
> Ok, then don't we need to convey this info in the dmesg to the user. For 
> that shall we use net_err_ratelimited() instead of netdev_err()? Or we 
> don't need any print at all?

I would not print anything at all.

	Andrew

