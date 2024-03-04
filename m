Return-Path: <linux-kernel+bounces-90686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D8087035F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71AB91F25D50
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF9F3FB01;
	Mon,  4 Mar 2024 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BlDLhXa7"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEA63F9C3;
	Mon,  4 Mar 2024 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709560427; cv=none; b=MNY5rqruXzmBZ3ro7R69GhOtD63RaO9XdqB1Vx03Kpyzh3LN0k6SmUGP3n6eq4tk8ruicYBYrlpxwLKevHL3+m7DShPc6feNET/7zcmOm9OClbGAEHS9d9E01bTNVog7FaqXP1TDyHjfWizvv0IlM52qJ9nrabn9bd/aPGYlwn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709560427; c=relaxed/simple;
	bh=c027nQXo6duzC3sChLkEYD+sefZ/bqJ5BjPU+eIda6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P13QWWoqYTvxxRgtOVUhUmTKW1yVvyEF3PIWLvqOZgrfGIbSmUotwvB9Y68evEhsiVPZxHHKwaql2E3rmpeNOAe9gU4UKsvnPdNNekJATD5FmjUA49fqkt3n1nilIEfTHvZU3XS068a3Qsu7IHGAS7sVKVcpX18QdBYZrIB3NDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BlDLhXa7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GrzTZEtZxWdDNRIjLiasY3q5ubsmD0i5rvI/Q95SnuI=; b=BlDLhXa70PeAxAiugcSnp0h4xR
	05PZfZoSo/Zsk/Zr8GodcFkqaEqOehJStj+zh55wqWw5Ymb23Gi5XbvlxmjE5ebu6ZrCS/Xz2/fvm
	vUT18KLPrHbEGyMmdnC+Vl3IkqSyUKKXw20LhwEFHQLGJB3siSpZ/w7hSNFmF6UU+xIg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rh8lO-009KSk-Nc; Mon, 04 Mar 2024 14:53:54 +0100
Date: Mon, 4 Mar 2024 14:53:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
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
	Frank Rowand <frowand.list@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v5 13/17] net: pse-pd: Use regulator framework
 within PSE framework
Message-ID: <290c516e-6cf7-4db2-9b32-c9dc7200fe73@lunn.ch>
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
 <20240227-feature_poe-v5-13-28f0aa48246d@bootlin.com>
 <ZeObuKHkPN3tiWz_@pengutronix.de>
 <20240304102708.5bb5d95c@kmaincent-XPS-13-7390>
 <84b300c7-8295-424b-9117-c604fb4cd73e@lunn.ch>
 <ZeXO_NhXZQajGZPr@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeXO_NhXZQajGZPr@pengutronix.de>

On Mon, Mar 04, 2024 at 02:39:08PM +0100, Oleksij Rempel wrote:
> On Mon, Mar 04, 2024 at 02:32:50PM +0100, Andrew Lunn wrote:
> > > > > +	psec = dev_find_pse_control(&phy->mdio.dev);
> > > > > +	if (IS_ERR(psec)) {
> > > > > +		rc = PTR_ERR(psec);
> > > > > +		goto unregister_phy;
> > > > > +	}
> > > > > +  
> > > > 
> > > > I do not think it is a good idea to make PSE controller depend on
> > > > phy->mdio.dev. The only reason why we have fwnode_find_pse_control()
> > > > here was the missing port abstraction.
> > > 
> > > I totally agree that having port abstraction would be more convenient.
> > > Maxime Chevallier is currently working on this and will post it after his
> > > multi-phy series get merged.
> > > Meanwhile, we still need a device pointer for getting the regulator. The
> > > phy->mdio.dev is the only one I can think of as a regulator consumer.
> > > Another idea?
> > 
> > Sorry, i've not been keeping up...
> > 
> > Doesn't the device tree binding determine this? Where is the consumer
> > in the tree?
> 
> The real consumer is outside of the system.

The device on the other end of the cable?

> Withing the system, it would be the RJ45 port, but we have no
> abstraction for ports so far.

A Linux regulator is generally used in a producer/consumer pair. If
there is no consumer device, why have a producer? What is going to use
the consumer API?

When we have a port representor, do we expect it to have active
elements? Something which will consume this regulator?

	  Andrew

