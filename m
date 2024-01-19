Return-Path: <linux-kernel+bounces-31171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C295E832A13
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79645283F35
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D85524BA;
	Fri, 19 Jan 2024 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HUz7klK6"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D93C4F1F5;
	Fri, 19 Jan 2024 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705669643; cv=none; b=R/E7qK3ClSuJnmkK6Z3bEgAF0P0fNQ4xhLO3mDnlBXin3M/ssHegiRjBT2Z2VowkaJJZtx2KenrJp6y11vmRmCFrgrbHI3psJAKexNonIEB5OIIWe7XIPEST7p2mB70SjsVzAfDeMjOS6TNymBSArVOBAKxN0LyYISRz07E0SkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705669643; c=relaxed/simple;
	bh=kO/kgFk+pCRzTkAUtMoYWZs6f8duDTJeIKjeZZqGzAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5/HAa6jQMi5YbPpxbBGTkdnzdmga171Y+wp0gEVOs7TV3Be6FQcWB6nykD4Kc7qJhB1+CEUC7hwNdtcTzvI3jEte0M/xCSF0O5EGOckBhuUiOaCbm7mwarega7ns7ccdbqMUxD58wQx1fu6viQvrJ3BimeqslRN1fv7Gornof4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HUz7klK6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gfNpdWS77kPbZpDPWIKUcioA/sdtAqPn9TD06jokSFM=; b=HUz7klK6f9YMLOFn8aVhwsoE5X
	Djl1Xen3icTXUgV2iM+4HNic1Bx0C9Mj0Z1mHBN23WLWLrVG7+2EgHpTbRkwSORWCA+geVvKRvdc3
	qjyV8ZWJZBnx3pdjfkIyYpKnpvhbXHA4hGR/lEv+4A9OsS52v0LZepO2uwcW3wH0135o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rQoaR-005YeW-76; Fri, 19 Jan 2024 14:07:07 +0100
Date: Fri, 19 Jan 2024 14:07:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, Divya.Koppera@microchip.com,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net v2 2/2] net: micrel: Fix set/get PHC time for lan8814
Message-ID: <74772857-670e-4c9b-a6f8-2b59c3e20bcb@lunn.ch>
References: <20240118085916.1204354-1-horatiu.vultur@microchip.com>
 <20240118085916.1204354-3-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118085916.1204354-3-horatiu.vultur@microchip.com>

On Thu, Jan 18, 2024 at 09:59:16AM +0100, Horatiu Vultur wrote:
> When setting or getting PHC time, the higher bits of the second time (>32
> bits) they were ignored. Meaning that setting some time in the future like
> year 2150, it was failing to set this.
> 
> The issue can be reproduced like this:
> 
>  # phc_ctl /dev/ptp1 set 10000000000
>  phc_ctl[118.619]: set clock time to 4294967295.000000000 or Sun Feb  7 06:28:15 2106
> 
>  # phc_ctl /dev/ptp1 get
>  phc_ctl[120.858]: clock time is 1.238620924 or Thu Jan  1 00:00:01 1970
> 
> Fixes: ece19502834d ("net: phy: micrel: 1588 support for LAN8814 phy")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reviewed-by: Divya Koppera <divya.koppera@microchip.com>

When submitted to net-next:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

