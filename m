Return-Path: <linux-kernel+bounces-50212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1BE8475E6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0355EB2EA82
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C74014C58B;
	Fri,  2 Feb 2024 17:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CFz4Mlp0"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93AF7CF04;
	Fri,  2 Feb 2024 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893728; cv=none; b=ga281wioI9vu573/Nt9PAhzIiKINVI7A65CUUgegMBB7GzF80P7dVF0mEv10+eqQGtMWZdp7i76VEAtGaeVMEGp5t7D/xRcTyeIiwh82OeZY/Yv3scNnbv61KIlxnoHD7ihsd12r0MFWmIJ/7PZVHpJMhIFUQDy7uoq2T/C335g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893728; c=relaxed/simple;
	bh=BrNCrKllmegxbiAtsW/MTJ3MKAd683ma6biQRAVn/0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E03Cve86pEjKkme9z3pF9h9RXkXy4EkNGLfE936/USbebbw7ez1S8H7vsQpzTMv4U+0viqa56//pp5yWFUfXvoq93Pm2XyZWEk6CUlR2EXtqePj451TihCWt+GLwZcauajh274UnBd+aKAAmRhlttib5pSbYPqArw4OeiHis9ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CFz4Mlp0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xBboSvhnv3xL8BrH5HURwKtLYk60Bcq74cRcWVNCjGA=; b=CFz4Mlp0R2QPm1LuWWqEYlmurt
	KeWk7Kt7lKCnxpdSMNegCUdYuSC/VCvVSOVEDRUyvBdHD4kewt1/dYHYjXjkO5nHnnK5AJKqTkGDS
	iR7UPigbinAu9DR0uPCzF4g6xje7RLtPWdjpPJHs5up1TcRwd2bdLY7qppGtrgrEITAs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVx1l-006pRv-U3; Fri, 02 Feb 2024 18:08:33 +0100
Date: Fri, 2 Feb 2024 18:08:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Rowand <frowand.list@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v5 9/9] net: phy: qca807x: add support for
 configurable LED
Message-ID: <8bbff46a-f316-49b7-82f8-44dbdd452b0d@lunn.ch>
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-10-ansuelsmth@gmail.com>
 <46085abf-8e82-4fd9-95b8-95cbfde6e5c2@lunn.ch>
 <65bd1af9.df0a0220.c0618.9f8d@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65bd1af9.df0a0220.c0618.9f8d@mx.google.com>

On Fri, Feb 02, 2024 at 05:40:21PM +0100, Christian Marangi wrote:
> On Fri, Feb 02, 2024 at 02:43:37AM +0100, Andrew Lunn wrote:
> > > +
> > > +			phydev->drv->led_brightness_set = NULL;
> > > +			phydev->drv->led_blink_set = NULL;
> > > +			phydev->drv->led_hw_is_supported = NULL;
> > > +			phydev->drv->led_hw_control_set = NULL;
> > > +			phydev->drv->led_hw_control_get = NULL;
> > 
> > I don't see how that works. You have multiple PHYs using this
> > driver. Some might have LEDs, some might have GPOs. But if you modify
> > the driver structure like this, you prevent all PHYs from having LEDs,
> > and maybe cause a Opps if a PHY device has already registered its
> > LEDs?
> >
> 
> God you are right! Off-topic but given the effects this may cause, why
> the thing is not const?

I would like it to be, but its not easy. There are fields in the
driver structure that phylib needs to modify. e.g. mdiodrv.driver gets
passed to the driver core when registering the driver, and it modifies
it. mdiodrv.flags is also manipulated. So we cannot make the whole
structure const.

	Andrew

