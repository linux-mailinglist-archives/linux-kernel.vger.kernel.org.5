Return-Path: <linux-kernel+bounces-700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E11B28144D3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 812DCB22BFE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316D718AEE;
	Fri, 15 Dec 2023 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nD+pv1RB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A2D18C01;
	Fri, 15 Dec 2023 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yvoaT28TBKL7llm28i1pYRM9G1xSj4Pn2SV2L7ge1gk=; b=nD+pv1RBbRaWEzppDZW/619dGm
	/j/JYI9TfPHHmtAEzy0p3k/xR63lbCZhhxpxWyYTQRmUHWANtYXlpJnR0ajGnQMzkKLEeENonNDAc
	bJmMsTWIboD5CaWe3dkYyvTGKrt56scMA/pzCgyrO5WZEhOsMpiS54lliAF7QRYVq8p0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rE4lu-0030Qk-7h; Fri, 15 Dec 2023 10:46:18 +0100
Date: Fri, 15 Dec 2023 10:46:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Paolo Abeni <pabeni@redhat.com>, Daniel Golle <daniel@makrotopia.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: skip LED triggers on PHYs on SFP modules
Message-ID: <37a66b85-3980-4553-8447-d040404bbc11@lunn.ch>
References: <102a9dce38bdf00215735d04cd4704458273ad9c.1702339354.git.daniel@makrotopia.org>
 <20231212153512.67a7a35b@device.home>
 <ec909d14-e571-4a50-926d-fbef4f4f9e0a@lunn.ch>
 <ZXnNYJer0JrJxOsl@shell.armlinux.org.uk>
 <ZXn_id6-XWYr2Seo@makrotopia.org>
 <6dd8d8b62d6db979d6c2197a4091ebc768e6610a.camel@redhat.com>
 <ZXsyt+msigtNiLN9@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXsyt+msigtNiLN9@shell.armlinux.org.uk>

> I disagree with that - analysing the locking and coming up with a fix
> is likely going to be a lengthy affair, meanwhile the mainline kernel
> will deadlock on this. This patch prevents that deadlock at the
> expense of removing the LED triggers for the PHY-on-SFP which I don't
> think is a big deal considering the age of the PHY-based LED triggers.
> 
> So I personally would prefer this patch to be merged while a
> different solution (that we have little idea at this point what it
> would look like) is sought.

So, if i'm reading this patch correctly, it only affects PHYs within
SFPs.

The discussion went off on a tangent and also talked about media
converter PHYs, but from my reading of this patch, they are unaffected
by this patch. Do they however also suffer from this deadlock? Anybody
tested that?

     Andrew

