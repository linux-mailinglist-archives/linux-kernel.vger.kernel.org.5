Return-Path: <linux-kernel+bounces-149175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5798A8CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9001C21881
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E918038F82;
	Wed, 17 Apr 2024 20:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="l7qkf56V"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65457171A1;
	Wed, 17 Apr 2024 20:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713385406; cv=none; b=dCSMld3mp9F9LTt2hkl9ju/n1Oo6f4fOzNF/AgqAnpoKWB3w+Tn8/nCmxc6ovkyY/rQpLs45oz+5neMRy2ppwtuxF7hrf9B3bFk2g4hAJfy6UJZ8oVL7OJnZLA7MBsSiTv/2oVqCaDGvZw6Tv6lsAPZpCWiQ2a2Y9jPXrRjyLbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713385406; c=relaxed/simple;
	bh=YK1LJ7V7n6YU6T4BYHDIXWISYQIofcn9Vug8OWzrD/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kV/6pOLrSDMpQN7xeWVpQLMHT/43faazig/nU8BkQxpTdlfPsrwp22KvnlYwkvq3xByFDq1RXvxM+k/KyJkwF1Cj8w28QfVrQN77M1/hSD5iyl9+u+03cw4Jk352yZ7smJhpfjj8BH4gZn77KDPfoU+Gx9o62m3GV0TMsb6FsnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=l7qkf56V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=heCx5Vxu+tju1CQvxfg2RJDT1aim0ThgpvJAHCHewkQ=; b=l7qkf56V7BsGBIxY9V8DlIkiwv
	HKzTvHiZ3IR/UjgKfBgUcgt5wuK3C9vahLEMRO3lFXQd12JPokoSD72OtMgyoKSCroINAaAsZI0NZ
	W/z/BQTDBeJuxBN398eLm6vkhaeh1BwzthRlG7gJz1ZrkUpSLlTBWyRmc+esYvk56H8I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rxBoB-00DHPd-Q3; Wed, 17 Apr 2024 22:23:07 +0200
Date: Wed, 17 Apr 2024 22:23:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v1 2/4] net: phy: micrel: lan8841: set default
 PTP latency values
Message-ID: <b44a4aee-f76f-4472-9b5c-343a09ed0d33@lunn.ch>
References: <20240417164316.1755299-1-o.rempel@pengutronix.de>
 <20240417164316.1755299-3-o.rempel@pengutronix.de>
 <c8e3f5d0-832b-4ab1-a65f-52f983ff110a@lunn.ch>
 <ZiAtREiqPuvXkB4S@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiAtREiqPuvXkB4S@pengutronix.de>

> > What affect does this have on systems which have already applied
> > adjustments in user space to correct for this? Will this cause
> > regressions for such systems?
> 
> Yes.
> 
> > I know Richard has rejected changes like this in the past.
> 
> In this case I would need to extend the ethtool interface. The driver
> should provide recommended values and the user space can optionally
> read them and optionally write them to the HW.

I suggest you go read older messages from Richard. It was a discussion
with Microchip about one of their PHYs.

	Andrew

