Return-Path: <linux-kernel+bounces-17900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3548254C4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A027BB23433
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503F42D7B2;
	Fri,  5 Jan 2024 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ojvNlEJU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6208F2D7A5;
	Fri,  5 Jan 2024 14:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rklPmY2oZQIe1/iyTtTeOXrMgE6gpCxUrRBRrMqDWCA=; b=ojvNlEJUAzcy09PNuju1puc+rZ
	FDqIXr+mkS1hKfFa6t7/eyoSfhcV/N1OA8UMWFO9uCx5YB9ups0RC7gAu2qFM3Fl9yrRksuDsNbxm
	i3cog/82lX+9LYC6dlbY+/Up2NkFPiqzYt+D7N4dKzESJt2TobqSdivVe4V6Q13jBpgY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rLkkt-004SRu-09; Fri, 05 Jan 2024 15:00:59 +0100
Date: Fri, 5 Jan 2024 15:00:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Stefan Eichenberger <eichest@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: marvell-88q2xxx: add driver for the Marvell
 88Q2220 PHY
Message-ID: <c7b1b220-4a76-4cc0-b68d-cec5977ebadb@lunn.ch>
References: <20231216221151.GA143483@debian>
 <28cc73bf-ed6d-49d8-b80b-4fbf5fa0442f@lunn.ch>
 <20231217111538.GA3591@debian>
 <ZX78ucHcNyEatXLD@eichest-laptop>
 <20231218090932.GA4319@debian>
 <ZYAqxPZHICtZO15O@eichest-laptop>
 <20231219081117.GA3479@debian>
 <ZYFfzei3SJSts5E/@eichest-laptop>
 <5d545a9b-feda-4908-8f74-9218806451c1@lunn.ch>
 <20240105124221.GA30964@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105124221.GA30964@debian>

On Fri, Jan 05, 2024 at 01:42:21PM +0100, Dimitri Fedrau wrote:
> Am Tue, Dec 19, 2023 at 04:57:50PM +0100 schrieb Andrew Lunn:
> > > I am not sure that it will be accepted by the maintainers if you use a
> > > lot of registers that are not documented.
> > 
> > Sometimes there is no choice, there is no documentation except the
> > vendor crap driver which we try to clean up as much as possible, but
> > we still end up with lots of magic numbers.
> >
> 
> Hi Andrew, hi Stefan,
> 
> tried to reduce the init sequence. This worked for me:
> 
> static int mv88q222x_config_init(struct phy_device *phydev)
> {
> 	int ret;
> 
> 	/* send_s detection threshold, slave and master */
> 	ret = phy_write_mmd(phydev, MDIO_MMD_AN, 0x8032, 0x2020);
> 	if (ret < 0)
> 		return ret;
> 
> 	ret = phy_write_mmd(phydev, MDIO_MMD_AN, 0x8031, 0xa28);
> 	if (ret < 0)
> 		return ret;
> 
> 	ret = phy_write_mmd(phydev, MDIO_MMD_AN, 0x8031, 0xc28);
> 	if (ret < 0)
> 		return ret;
> 
> 	ret = phy_write_mmd(phydev, MDIO_MMD_PCS, 0xffe4, 0xc);
> 	if (ret < 0)
> 		return ret;
> 
> 	return mv88q2xxx_config_init(phydev);
> }
> 
> The four register writes were required to make the PHY work in 1000Mbit forced
> mode. When using autonegotiation or 100Mbit forced mode they weren't needed.
> It was enough to write them once in mv88q222x_config_init as you can
> see. Thanks Stefan for the hint with the first three register writes, it
> helped a lot.

Hi Dimitri

Do we need to reduce the init sequence? Since this is all undocumented
magic which nobody understands, it would be safer to just keep with
the Marvell vendor crap code dump. Unless we really do need to change
it.

	Andrew

