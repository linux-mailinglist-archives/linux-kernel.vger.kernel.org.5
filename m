Return-Path: <linux-kernel+bounces-18045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4D18257B4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC844B25ADF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949572E848;
	Fri,  5 Jan 2024 16:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fxdrKolL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410602E65C;
	Fri,  5 Jan 2024 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2PJNl5+Gl+iRmL/gIIMhvsZ8RRxrDqPlWh22o0RuKZQ=; b=fxdrKolLwJ+pRMYOJidHMvOyyd
	1wd02QNnKBLcU1cqMBuIeAmr+KEci/t1t1lxYykvyCwUazmLobQvNxwksBT2Rwm4tQziU0e+5p6t7
	JuRXUjvL8ysCzT9+YM+6em9MzfqF2rMIqITCFiMoZOp/wWyztWiBaiypM2vf1Tln/CdQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rLmij-004T48-3r; Fri, 05 Jan 2024 17:06:53 +0100
Date: Fri, 5 Jan 2024 17:06:53 +0100
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
Message-ID: <ca76b515-9659-4fed-8a1a-402923b72868@lunn.ch>
References: <20231217111538.GA3591@debian>
 <ZX78ucHcNyEatXLD@eichest-laptop>
 <20231218090932.GA4319@debian>
 <ZYAqxPZHICtZO15O@eichest-laptop>
 <20231219081117.GA3479@debian>
 <ZYFfzei3SJSts5E/@eichest-laptop>
 <5d545a9b-feda-4908-8f74-9218806451c1@lunn.ch>
 <20240105124221.GA30964@debian>
 <c7b1b220-4a76-4cc0-b68d-cec5977ebadb@lunn.ch>
 <20240105154351.GA39937@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105154351.GA39937@debian>

> Hi Andrew,
> 
> > Do we need to reduce the init sequence? Since this is all undocumented
> > magic which nobody understands, it would be safer to just keep with
> > the Marvell vendor crap code dump. Unless we really do need to change
> > it.
> >
> You are right, it would be safer to use the vendor code. But when
> looking at the vendor code, the init sequence changed a lot from rev. B0
> to rev. B1 of the PHY. There are some additional register writes, but
> mostly the order of the register writes changed. I don't know if this is
> going to be worse in the future. Maintaining different revisions will
> probably take some effort or at least result in bloated code. We probably
> don't need all of the init sequence. I'm not sure how to deal with it,
> keeping the init sequence at a minimum is probably a good idea.

Is the revision in the lower nibble of the ID register? We can handle
them as different PHYs, each gets its own init code, and share what
can be shared in helper functions.

	Andrew

