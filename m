Return-Path: <linux-kernel+bounces-46705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A39B84432F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 952CBB2B057
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEB91272A3;
	Wed, 31 Jan 2024 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wi/NQaKl"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737FE84A37;
	Wed, 31 Jan 2024 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706714674; cv=none; b=Fmm41+4VoiHr0TZi0nRIHYc7bRVf94SFZjqMdre4qY3hTXCLNmJTF58JJAvSc+VVpz9lvZ9n1kQPeMR7oQQA+kgmTjkap9eSDSd6W1oBUP7FUklv4pKPMzT9qEf9joIFEWW+D1I2hxEFPRToR/Hh8rl61blI83+67JAKFjI53gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706714674; c=relaxed/simple;
	bh=xd07+qfEcTAQ1XsBWozYKpSIFzXSl4J0kIa3tQzgXuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzLhml5K0lDldT0swv4IQYEaJzr4A0qsWAw5auKHpBpvi8xnCwcz5tfKqkt36CuxRzn8ORyrHZNTeiqUOOkDWvWtKZXrfR2NbyNzEnNiNl+Sk+w76Yk5JoL7y4X1wW9SiTVglh0Guly+nS0Pu8+rFDq7YbBZ5/8qm5hJVttm+kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wi/NQaKl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=he57mHO7qgtjoGiELu02HX3gNksEqY+LcAal9M+A9Vc=; b=wi/NQaKlSZTAxWmkPaEmnkF6Li
	uK/JYrOPRbgOSjg6m5og8IOQ7xFQpzmv3hVpAwPd9mLp/6ANw9+GLb5ICZfMoLPXFWTA9vsYeQsaT
	4kEg3RjpUNDvT/yV7ZV7Clxj3vwnXyZ1fGECCP+MH/4McdTrroRwFT3wuG3btgpfNhT0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVCRt-006asP-Lm; Wed, 31 Jan 2024 16:24:25 +0100
Date: Wed, 31 Jan 2024 16:24:25 +0100
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
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: dsa: Add KSZ8567
 switch support
Message-ID: <edc91145-52b4-4aa7-8ae7-d09466ba2dd3@lunn.ch>
References: <20240130083419.135763-1-dev@pschenker.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130083419.135763-1-dev@pschenker.ch>

On Tue, Jan 30, 2024 at 09:34:18AM +0100, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@impulsing.ch>
> 
> This commit adds the dt-binding for KSZ8567, a robust 7-port
> Ethernet switch. The KSZ8567 features two RGMII/MII/RMII interfaces,
> each capable of gigabit speeds, complemented by five 10/100 Mbps
> MAC/PHYs.
> 
> This binding is necessary to set specific capabilities for this switch
> chip that are necessary due to the ksz dsa driver only accepting
> specific chip ids.
> The KSZ8567 is very similar to KSZ9567 however only containing 100 Mbps
> phys on its downstream ports.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

