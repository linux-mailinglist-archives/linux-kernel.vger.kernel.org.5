Return-Path: <linux-kernel+bounces-40122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9693B83DA98
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370F11F21059
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63BA1B810;
	Fri, 26 Jan 2024 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4jIEQT8Y"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16F01B7F9;
	Fri, 26 Jan 2024 13:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706274960; cv=none; b=t/4uly3gUmErHY+3hePjs5nIasG4U3y10pQeOYQiyOXcMzuweG6FT9fdt1Y1u8KKCDO/qyS98mP8yHQGtZndC0q3SWdk02zpan9M2a42VKG9AiCsqVmahMP/6JWX3jNqSH9x6D3fMs1a85DrQ+6rf3f/sXiF+6jMRG+/d5bqmoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706274960; c=relaxed/simple;
	bh=FGY+lD+y60lvRkLTTesPfWuaivVUyv7pYO/2UAczccA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TH6WWTKh1+LVvazY9wPif5HvmyDRqAen9ypaY0uljRII0ysC4Wk9USRDsxTgN2i/xpny93V0lgTr5dfCjJ1soRVwU8vPIGe5U2sRAtGaJlVCdgcpZdmF11flVv0HX3Hi6KooH8kEbjMh6Gs8wkOAKaP17e/6wGfkfm9w0cTcNOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4jIEQT8Y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=50z3iua35YdHF3I4F9KF6AiAKfWmqunUUJx8CeyD42I=; b=4jIEQT8Y909onTWoy8B8fayYei
	/1O+LlSWYYQgibr7K/vjXYCTR0szYmjhB/dEQOVyysqtaDy3RIY93Am++wBoL7QyCLHOWmfw9N62W
	HcPVV/KiX3odBWaQkRjIx4YlAWtux1XRbQ7Lu+EDpMqbns4mpneZewmbWX7hv/ncYPlI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rTM3X-006AmJ-5i; Fri, 26 Jan 2024 14:15:39 +0100
Date: Fri, 26 Jan 2024 14:15:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Divya Koppera <divya.koppera@microchip.com>
Subject: Re: [PATCH net-next] net: micrel: Fix set/get PHC time for lan8814
Message-ID: <a962b46c-343d-411b-9152-514b35aa4f00@lunn.ch>
References: <20240126073042.1845153-1-horatiu.vultur@microchip.com>
 <8da0a157-6a09-4d82-ad36-7428fdb27f9b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8da0a157-6a09-4d82-ad36-7428fdb27f9b@linux.dev>

> > +	*sec |= lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_SEC_MID);
> 
> lanphy_read_page_reg returns int, but only 16 bits have meanings here.
> Is it safe to assume that other 16 bits will be zeros always?

Yes. __phy_read() should only return a negative error code, or a value
which fits in a u16. If any of the top bits are set, its a bug in the
MDIO driver which needs finding and fixing.

     Andrew

