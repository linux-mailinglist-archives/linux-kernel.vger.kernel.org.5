Return-Path: <linux-kernel+bounces-88527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C48E286E2E4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2FE1F259ED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C9B6EF0B;
	Fri,  1 Mar 2024 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VEsMCUKB"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB765F84C;
	Fri,  1 Mar 2024 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709301619; cv=none; b=HDXnAXBHMPghVPaXnPaFR2qmc0Z9acSWPhh5FBsZVUumPPakh7gEfA/gbo3fwmkyVKGorScUMDe2xViIqSVLGbUn26cJJRs3/T1T3VBFRw8WbVMaJIe8IE78i5JO0hjKDmcJ1qS5wc9fv5MlaeWu8SB2GO45c/qWW3/SB0zSr6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709301619; c=relaxed/simple;
	bh=Uwm4z9If+tkCUKr8I6N3lywyOJRH6O9UKwPft2Dlxs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwmd8loJ1F06dRDhlAGbCNdRv9cmnFi6BKSJbPk30kw5I3rxmfesGu48n9Leptavgs4TjfN3xmU1oLr4RH/rACC79ut5lh5/cdVfY7KDCtUIl4q+Ne0KWP+HSYpk8EaVdi7l6LG/w5e+fbzLrdMFFVE3AzR3Xf18kKVj/fart9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VEsMCUKB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lt7udYsocuVhKxHFS4ifPlstkCMspm0P7cqn/fPP8AU=; b=VEsMCUKB+WhD2pxB/+erGT/mHN
	IvTI5J2+LH0v2cRGGXVk3E051GWncATp6v5s1ZgNynJhqXaclaud3WIfIXV3KToDE+hUv85jfqDVB
	02zFW4w4eQX7GMzCAufwskR/ZUX5OruKoN96GbOzTrJx3nW5b2acVijbV6uBqpzLgBU4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rg3R0-0098kj-Tr; Fri, 01 Mar 2024 15:00:22 +0100
Date: Fri, 1 Mar 2024 15:00:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com, christophercordahi@nanometrics.ca
Subject: Re: [PATCH v2 6/6] net: phy: DP83640: Add fiber mode
 enabling/disabling from device tree
Message-ID: <7d70e512-ce6f-43ca-b297-fd3397469276@lunn.ch>
References: <20240227093945.21525-1-bastien.curutchet@bootlin.com>
 <20240227093945.21525-7-bastien.curutchet@bootlin.com>
 <a9c2144a-f26b-4a71-b808-ce3a94f1264d@lunn.ch>
 <c1b17410-b403-4c3a-9c00-de8f2b2b2fa7@bootlin.com>
 <c6840f8f-7d9c-49e8-b689-2af04605b99c@lunn.ch>
 <20240301113703.102bbad0@device-28.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301113703.102bbad0@device-28.home>

> All in all, do you think that defaulting to copper and leaving users an
> option to implement "ti,fiber-mode" is an acceptable risk to take ?

Yes, lets do that. But try to make it easy to revert the change if
anybody complains about a regression.

	Andrew

