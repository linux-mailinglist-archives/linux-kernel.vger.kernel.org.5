Return-Path: <linux-kernel+bounces-110404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5728885EC7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30CA6B25203
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE0B1350DA;
	Thu, 21 Mar 2024 16:43:51 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F421350CD
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039431; cv=none; b=tkDaz2AIMs0VTPLbOh+KnWDxta5BAGuNci04AUR0rPx/UGi9B1NkmPPcrXkuFYkQMJINA7KzdKyCN2FdMoTaukJETbBmnLTSrrGzr1pR9NXvaCe8WY/zy3UHL46jjtXhadnxeHVZwMO88dnabzaXmhD/4AaochgeTRwsFR7vngk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039431; c=relaxed/simple;
	bh=0vV3Rd8QELxZSI2XAgAt3t5uJdcz1UaglyduRhRIYBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ce5QibvyTIfAxjylhx4PgUOVtQwcVwcct09DD3ZYVQ/V8EI7jxpZ6hHJch2rJGPhbo1pBgJoH9KND4Z4ljbA4BH2bjDmwftgidaTcanETm3GsIhzsgpjHgNfGHQlSNszjM/R8hUIqX7BqeVPMq2a7bHyHRF84NG5+oKtXeLOfHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rnLVc-0000CG-Lb; Thu, 21 Mar 2024 17:43:16 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rnLVa-007ghN-T2; Thu, 21 Mar 2024 17:43:14 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rnLVa-00A8G2-2X;
	Thu, 21 Mar 2024 17:43:14 +0100
Date: Thu, 21 Mar 2024 17:43:14 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v5 13/17] net: pse-pd: Use regulator framework
 within PSE framework
Message-ID: <ZfxjosqPMo0ECBmx@pengutronix.de>
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
 <20240227-feature_poe-v5-13-28f0aa48246d@bootlin.com>
 <ZeObuKHkPN3tiWz_@pengutronix.de>
 <20240304102708.5bb5d95c@kmaincent-XPS-13-7390>
 <ZeWi90H-B4XeSkFs@pengutronix.de>
 <20240321171524.0b04bfcc@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240321171524.0b04bfcc@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2024 at 05:15:24PM +0100, Kory Maincent wrote:
> Hello Oleksij,
> 
> On Mon, 4 Mar 2024 11:31:19 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > >    
> > > > Should be tested, but if, instead of "vin-supply", we will use
> > > > "pse-supply" it will make most part of pse_regulator.c obsolete.  
> > > 
> > > Don't know, if it is done at the pse-pi node level it may not break
> > > pse_regulator.c. Not sure about it.  
> > 
> > me too. Before your patch set, the regulator topology for PoDL PSE was
> > following:
> > power-source
> >   fixed-regulator
> >      PoDL_PSE-consumer
> > 
> > Now it will be:
> > power-source
> >   fixed-regulator
> >      PoDL_PSE-consumer
> >        PSE-PI-provider
> >          PSE-PI-consumer
> > 
> > By porting porting PSE framework to regulator, probably it make sense to
> > remove two levels of regulators?
> > power-source
> >   fixed-regulator
> >      PSE-PI-consumer
> 
> Sorry, I forgot to reply about this.
> This is specific to pse_regulator driver. Could we tackle this change in another
> patch series when the current patch series got applied?
> Also I don't have the hardware to test it.

ACK, no problem.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

