Return-Path: <linux-kernel+bounces-46706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A97844323
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D5B8B28376
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA891272C7;
	Wed, 31 Jan 2024 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GWPN8KJX"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B919284A37;
	Wed, 31 Jan 2024 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706714705; cv=none; b=K6lpTf/T48ZbMR9cw06DDBGSN4O17V4y6NlHSBURSWR1N10UuNHWBq432NcTJyE7Naxhadzeplti8/O94ZMb7QRWNfiuM2jo+Kzgggr5bpOjczgWYxTRfyQCNTt7wFs0084/vpOATir+mN3GKNEPXySBCUWYSJIwgTQF4qAQ27Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706714705; c=relaxed/simple;
	bh=MtRBXZr5k32nOE9Qas4rtjCWPfrH2zWl5vI7S8oqx5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzpR2qP+hzrvEyQBtV0HfvtJxznB6QwIqUVxfCAR8BX4F7MTQDFUGXjo0ffWjD1+vlo0CeBUOE1RYgr1NFmZPxYMFZ2PmawDj2JG1SF8tBNEJ01wYsj0G/BMUWLqLbExIwuNOlsfeGWA0VskZWglQEa9t3+D5Eg8YlRTVpuU7BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GWPN8KJX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mkVGhFu9mst6Xyh2YFf6+frAEntMbiBQT+dMt+VUt+c=; b=GWPN8KJXBbfkU3fbBZjhzyt3fQ
	tdwXBlqBD9Tm/3qeMdp2SbO5LE2FQzqHelFxmrVR+9vkay+HQCz3AnZrypw18yfevoklry8oLFEdL
	ePYiTXlq0YnSzfp8mTbk6MVqkIWchpmQWYhtX4yj5ArQi2PTeOi2foJTyea3fxhIunps=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVCSR-006at3-FR; Wed, 31 Jan 2024 16:24:59 +0100
Date: Wed, 31 Jan 2024 16:24:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Philippe Schenker <dev@pschenker.ch>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Florian Fainelli <f.fainelli@gmail.com>,
	stefan.portmann@impulsing.ch, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Philippe Schenker <philippe.schenker@impulsing.ch>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Subject: Re: [PATCH net-next v3 2/2] net: dsa: Add KSZ8567 switch support
Message-ID: <95c07f38-f4db-42dc-905d-eca03fb1c208@lunn.ch>
References: <20240130083419.135763-1-dev@pschenker.ch>
 <20240130083419.135763-2-dev@pschenker.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130083419.135763-2-dev@pschenker.ch>

On Tue, Jan 30, 2024 at 09:34:19AM +0100, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@impulsing.ch>
> 
> This commit introduces support for the KSZ8567, a robust 7-port
> Ethernet switch. The KSZ8567 features two RGMII/MII/RMII interfaces,
> each capable of gigabit speeds, complemented by five 10/100 Mbps
> MAC/PHYs.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
> Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

