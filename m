Return-Path: <linux-kernel+bounces-160553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508118B3F11
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99B79B242D3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CBE16F296;
	Fri, 26 Apr 2024 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="s0SGDObx"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCFC16D9DC;
	Fri, 26 Apr 2024 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714155243; cv=none; b=aPebWb/bgZbmSuGeSmSsAmOpxJ415juiVGZPzBabBL2nylL1REoPlN+Bd5VudCYjRPCFgTK9AkICsrUYH4J4mI+LVdGJO7bZhBpXZe5LKGrQXGllsxvtvOID+avmqg0HQEtkiD5yhSVvIk5OFydKrB4qI4DoOuCpikY8CIvR1f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714155243; c=relaxed/simple;
	bh=aQjaL5v7EZ8Z8sheHSuTK0i8DbEog35lMqyjMZuJSH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGNV+Nfog7NNTKlyPolKD+u1SZrGhwPBa5ppUlutxAV8q4A2pbiGfDUuKYRmXrqcVjg+2CYa0YczhmT1iZ3vFYuKGF0l7V3dwUzlJBuq4KS2nbb1M01mrDqqjTNx89SQYXnc8n2gXvLhZ/VGQTZ8cHh25FpXyfxuv66OE/acww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=s0SGDObx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Z0WylHOBJi80XW5YVifjTqADU8U9Hi2JH9CbGlTpRYM=; b=s0SGDObxH6/3Xck4YBOF4zBOOG
	fnpQUiVzrD846i2Wd6hb/iY8DDkplyuhIvX1OkoiBceOFTtt9ppqHNI47PrIkylMuaDy2/00rK467
	KlBoZS9/H4jRdhfmLworvUxCa5Lg8o0ZoCedMMz1SQY4z0M+7x9vZd8JQqo8D0U+bNIQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s0Q4k-00E62L-4W; Fri, 26 Apr 2024 20:13:34 +0200
Date: Fri, 26 Apr 2024 20:13:34 +0200
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
Subject: Re: [PATCH net-next v4 09/12] net: ethernet: oa_tc6: implement
 receive path to receive rx ethernet frames
Message-ID: <669541fd-abc5-4461-a92f-af5a09c1e1e6@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-10-Parthiban.Veerasooran@microchip.com>
 <574fec4d-5a23-490a-ba12-c40432ebe4b8@lunn.ch>
 <6e529720-3caa-4dc4-b9be-bc6674806ba5@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e529720-3caa-4dc4-b9be-bc6674806ba5@microchip.com>

On Fri, Apr 26, 2024 at 01:45:20PM +0000, Parthiban.Veerasooran@microchip.com wrote:
> Hi Andrew,
> 
> On 24/04/24 5:38 am, Andrew Lunn wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> >> +static int oa_tc6_allocate_rx_skb(struct oa_tc6 *tc6)
> >> +{
> >> +     tc6->rx_skb = netdev_alloc_skb(tc6->netdev, tc6->netdev->mtu + ETH_HLEN +
> >> +                                    ETH_FCS_LEN + NET_IP_ALIGN);
> >> +     if (!tc6->rx_skb) {
> >> +             tc6->netdev->stats.rx_dropped++;
> >> +             return -ENOMEM;
> >> +     }
> >> +     skb_reserve(tc6->rx_skb, NET_IP_ALIGN);
> > 
> > I think you can use netdev_alloc_skb_ip_align() here.
> Ah OK, then do you mean we can rewrite the function 
> oa_tc6_allocate_rx_skb() as below?
> 
> static int oa_tc6_allocate_rx_skb(struct oa_tc6 *tc6)
> {
> 	tc6->rx_skb = netdev_alloc_skb_ip_align(tc6->netdev, tc6->netdev->mtu + 
> ETH_HLEN + ETH_FCS_LEN);
> 	if (tc6->rx_skb)
> 		return 0;
> 
> 	tc6->netdev->stats.rx_dropped++;
> 	return -ENOMEM;
> }

Looks about right. But i did say 'I think', meaning i'm not too sure
about this.

I generally don't review code actually moving packets around. It is
what developers focus on, test heavily, and so is generally O.K. It is
the code around the edges which often needs improvements prompted by
review, ethtool, PHY handling, statistics.

	Andrew

