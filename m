Return-Path: <linux-kernel+bounces-125749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D2F892B9F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 15:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE361B21338
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 14:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FB1383BF;
	Sat, 30 Mar 2024 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AgKIFxWL"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8311C0DEF;
	Sat, 30 Mar 2024 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711810403; cv=none; b=VrO6J8Hi+SBymX6+G5k3Ud8x7blzHf4q7Un8U6HDTfCcAzT4feZ1IAepX0YzqrNRbWaj6sVRlwcJW0hQh2XaqpefkR4Sl2gkocyv4v1p3KRon1liM9mPgLHk8XrtVDkI9/lTyxhV5mKiovFXgO/D2P2uamXtEBKUKCzDezwG5NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711810403; c=relaxed/simple;
	bh=gJx0oB7ZzuoCNKkwsr1UzGLJ3CRfFELmHureG9uOYGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDelDfSdHTx21mIJ0hem715uqMg/JEbBvu+QI/n4j2Dk5mc8GbK+VtSdOJISO50a39BBZcXcTZecoAszKR55fvrHsgPXRjIkkmjNpNVTs/51Np0JtRcq77T52D8q+mY13M2OFNo9qBat6UJf/PFGufjBrguPYjOpPuK3LA1Ni/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AgKIFxWL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=caGVOX2RZ69c4hjscPFCuCKDrFK7z35V6qvgjgO6mvs=; b=AgKIFxWLgU4PMlGPkeuWts4Sdx
	C1uk2GClcr5WI35QPJ/c+zppgblTWKdov5NwQ4Y/rlf4kRO+pXEefeYiuH/9vvqcMMhtsW5bKoOSc
	ptiP23T99yvkYQ4yFYT1LkW6GjFn1aaNnXMQ/2LbdTSWKkldN1777vtFbSTbTQ5A4V60=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rqa4f-00Bj1W-9i; Sat, 30 Mar 2024 15:52:49 +0100
Date: Sat, 30 Mar 2024 15:52:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
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
	Conor Dooley <conor+dt@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v6 17/17] net: pse-pd: Add TI TPS23881 PSE
 controller driver
Message-ID: <8186fea6-c1f4-403b-b717-83c1dd3ad826@lunn.ch>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
 <20240326-feature_poe-v6-17-c1011b6ea1cb@bootlin.com>
 <6bbc6b86-3947-4679-ac0b-fde50129d0f6@lunn.ch>
 <20240329155657.7939ac4b@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329155657.7939ac4b@kmaincent-XPS-13-7390>

On Fri, Mar 29, 2024 at 03:56:57PM +0100, Kory Maincent wrote:
> On Thu, 28 Mar 2024 17:24:17 +0100
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > > +static int tps23881_flash_fw_part(struct i2c_client *client,
> > > +				  const char *fw_name,
> > > +				  const struct tps23881_fw_conf *fw_conf)  
> > 
> > Does the device actually have flash? Or is this just downloading to
> > SRAM?
> 
> It is downloading to SRAM.

So maybe rename these functions.

	Andrew

