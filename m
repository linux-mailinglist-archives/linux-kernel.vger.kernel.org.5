Return-Path: <linux-kernel+bounces-67023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB7D856503
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AFA0B2910E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD1C131E5F;
	Thu, 15 Feb 2024 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ooptoa1b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B789212E1C4;
	Thu, 15 Feb 2024 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005094; cv=none; b=Uy/3anNjglQE8Wg1VxyHkwA8h6xrSbkm/AiWeUMlOydwak1yzxufC4VIzic3kRQKrSUzNoGt/gZ100nLdJOjwvYtjwawmRktjiz7BiN3ulG3HA2eCTwoTAQ3yMggjjItwXxWRFO5oYh2kONcYP+TrOb+pi/DJSWyVBaOif5SLNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005094; c=relaxed/simple;
	bh=3SvHROmvHaZOwf+5dxZxpWNMBRQ7DAeUJ0WpRa4dXEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q81knbPJfqxox/mAtLXWirAcVpJD6NbYsdFJHN2SrwQ1Rcj09e+QeMmS28K4McVCNmvgiOwBPbcjcwBPr+/JUwejVDXwX/UEy9ttnxxRJRW/wPamW7bKwi5LjRriHZhJgbFj/JtzxghxrSBagri/JZiM+PN9M0kvIS2fjZLbazs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ooptoa1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFA0C433F1;
	Thu, 15 Feb 2024 13:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708005094;
	bh=3SvHROmvHaZOwf+5dxZxpWNMBRQ7DAeUJ0WpRa4dXEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ooptoa1bOq/CzSvBCKFZgqMZ83F+3bmF4wZ8J0bvVfYsl6VMFE15EtSQzQXk5mADK
	 8XtrSdYoIDInjtEkTLLxSuh2sl5aqWjGxyelX/X7g1h+MAdpDwsROW9yndLIOhmi4V
	 sZigkUkhsDfYM99QvGuc5Z0IHpDngYBXKMdY2uJFb69Kl4R4YNZGqLaIg9nwJ5u1zA
	 w/wzy2c/wyz2lBGitmnrNAV4L90Qy8sTDRtdSkhP9AiwcLjgyi7b9Sx5NjSzL96Fhd
	 9KHklfx447Zb7CEeNUV3Dc6Uvr/ncPI0a3QK31S9o0UqYFRVdVYd1ToOpkBAr6otmP
	 jkJLHWAUqrxaQ==
Date: Thu, 15 Feb 2024 07:51:30 -0600
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v3 10/17] dt-bindings: net: pse-pd: Add another
 way of describing several PSE PIs
Message-ID: <20240215135130.GA4139246-robh@kernel.org>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
 <20240208-feature_poe-v3-10-531d2674469e@bootlin.com>
 <20240209144349.GA3678044-robh@kernel.org>
 <20240214141310.119364c4@kmaincent-XPS-13-7390>
 <20240214164150.5be591d0@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240214164150.5be591d0@kmaincent-XPS-13-7390>

On Wed, Feb 14, 2024 at 04:41:50PM +0100, Köry Maincent wrote:
> On Wed, 14 Feb 2024 14:13:10 +0100
> Köry Maincent <kory.maincent@bootlin.com> wrote:
> 
> > Hello Rob,
> > 
> > Thanks for your review!
> > 
> > On Fri, 9 Feb 2024 14:43:49 +0000
> > Rob Herring <robh@kernel.org> wrote:
> > 
> > > On Thu, Feb 08, 2024 at 02:08:47PM +0100, Kory Maincent wrote:  
> > > > Before hand we set "#pse-cell" to 1 to define a PSE controller with    
> > > 
> > > #pse-cells
> > >   
> > > > several PIs (Power Interface). The drawback of this was that we could not
> > > > have any information on the PI except its number.    
> > > 
> > > Then increase it to what you need. The whole point of #foo-cells is that 
> > > it is variable depending on what the provider needs. 
> > >   
> > > > Add support for pse_pis and pse_pi node to be able to have more
> > > > information on the PI like the number of pairset used and the pairset
> > > > pinout.    
> > > 
> > > Please explain the problem you are trying to solve, not your solution. I 
> > > don't understand what the problem is to provide any useful suggestions 
> > > on the design.  
> > 
> > Please see Oleksij's reply.
> > Thank you Oleksij, for the documentation!!
> > 
> > > > 
> > > > Sponsored-by: Dent Project <dentproject@linuxfoundation.org>    
> > > 
> > > Is this a recognized tag? First I've seen it.  
> > 
> > This is not a standard tag but it has been used several times in the past.
> 
> Not so much used indeed:
> $ git log --grep="Sponsored" | grep Sponsored     
>     Sponsored by:  The FreeBSD Foundation
>     Sponsored by:  The FreeBSD Foundation
>     Sponsored by:  The FreeBSD Foundation
>     Sponsored by:  The FreeBSD Foundation
>     Sponsored-by: Google Chromium project
>     Sponsored: Google ChromeOS
>     Sponsored: Google ChromeOS
> 
> Is it ok to keep it?

IMO, its use should be documented like other tags, or it should not be 
used. Just write a sentence to the same effect.

Rob


