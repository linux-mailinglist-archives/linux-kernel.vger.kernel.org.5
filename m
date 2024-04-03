Return-Path: <linux-kernel+bounces-130089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EBB8973F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE1D1C21A92
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3317214A0B5;
	Wed,  3 Apr 2024 15:28:09 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A486148FE8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158088; cv=none; b=RzQld4vmF0pqtRcXZFUTIgzpmUVr8ntYWv2cNYEoz/eF8rzZVYFmGHb8uhaWMc0Rau96o1ujg1sdFtpB1eDKdmsQyyB7qPC4afyEVK8zNqCCynF8NqAhXz68De7bG4R6RzKyJbSQSgY9XLOZvfVLK+xF87+Wwroas1/xTo0RqwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158088; c=relaxed/simple;
	bh=GmbD26WMynLhI5PkWa2+VgAcWtdokHdMIyR0DsUfccc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRthQAqt7FgPdD6nxdRINlnjd4MH41kh1/nWFNkOQne3dLOYtEJj80Lk9UD9iF3HEd3tjHu51c6SyPyvUdUk6ZutdUJFPeoFHXVS6CbxqbUbjwZ6amtPimORdZjWAWbQGufmw2qc2xzsquPGjgigEKoTzkiOll7xCM2+h2PysLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rs2WX-0006iQ-Tz; Wed, 03 Apr 2024 17:27:37 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rs2WV-00ACng-OF; Wed, 03 Apr 2024 17:27:35 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rs2WV-00CU00-22;
	Wed, 03 Apr 2024 17:27:35 +0200
Date: Wed, 3 Apr 2024 17:27:35 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Rob Herring <robh@kernel.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v6 11/17] dt-bindings: net: pse-pd: Add another
 way of describing several PSE PIs
Message-ID: <Zg11Z1kJ42eLhabK@pengutronix.de>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
 <20240326-feature_poe-v6-11-c1011b6ea1cb@bootlin.com>
 <20240402132637.GA3744978-robh@kernel.org>
 <ZgworgDAXXOpf3QV@pengutronix.de>
 <20240403144448.GB3508225-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240403144448.GB3508225-robh@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2024 at 09:44:48AM -0500, Rob Herring wrote:
> On Tue, Apr 02, 2024 at 05:47:58PM +0200, Oleksij Rempel wrote:
> > On Tue, Apr 02, 2024 at 08:26:37AM -0500, Rob Herring wrote:
> > > > +          pairsets:
> > > > +            $ref: /schemas/types.yaml#/definitions/phandle-array
> > > > +            description:
> > > > +              List of phandles, each pointing to the power supply for the
> > > > +              corresponding pairset named in 'pairset-names'. This property
> > > > +              aligns with IEEE 802.3-2022, Section 33.2.3 and 145.2.4.
> > > > +              PSE Pinout Alternatives (as per IEEE 802.3-2022 Table 145\u20133)
> > > > +              |-----------|---------------|---------------|---------------|---------------|
> > > > +              | Conductor | Alternative A | Alternative A | Alternative B | Alternative B |
> > > > +              |           |    (MDI-X)    |     (MDI)     |      (X)      |      (S)      |
> > > > +              |-----------|---------------|---------------|---------------|---------------|
> > > > +              | 1         | Negative VPSE | Positive VPSE | \u2014             | \u2014             |
> > > > +              | 2         | Negative VPSE | Positive VPSE | \u2014             | \u2014             |
> > > > +              | 3         | Positive VPSE | Negative VPSE | \u2014             | \u2014             |
> > > > +              | 4         | \u2014             | \u2014             | Negative VPSE | Positive VPSE |
> > > > +              | 5         | \u2014             | \u2014             | Negative VPSE | Positive VPSE |
> > > > +              | 6         | Positive VPSE | Negative VPSE | \u2014             | \u2014             |
> > > > +              | 7         | \u2014             | \u2014             | Positive VPSE | Negative VPSE |
> > > > +              | 8         | \u2014             | \u2014             | Positive VPSE | Negative VPSE |
> > > > +            minItems: 1
> > > > +            maxItems: 2
> > > 
> > > "pairsets" does not follow the normal design pattern of foos, foo-names, 
> > > and #foo-cells. You could add #foo-cells I suppose, but what would cells 
> > > convey? I don't think it's a good fit for what you need.
> > > 
> > > The other oddity is the number of entries and the names are fixed. That 
> > > is usually defined per consumer. 
> > > 
> > > As each entry is just a power rail, why can't the regulator binding be 
> > > used here?
> > 
> > I'm not against describing it consequent with regulator till the wire
> > end, but right now I have no idea how it should be described by using
> > regulator bindings. There are maximum 2 rails going in to PSE PI on one
> > side and 4 rails with at least 5 combinations supported by standard on
> > other side. Instead of inventing anything new, I suggested to describe
> > supported output combinations by using IEEE 802.3 standard.
> 
> There's 4 combinations above, what's the 5th combination? SPE?

The 5th combination is PoE4 where two rails are supplying power at same
time.

First 4 variants for PoE: one or two positive rails are attached (but
only one is used at same time) to pairs 1-2 or 3-4, or 5-6, or 7-8. Or
support all of combinations if some advanced PSE PI is present. PSE PI
is kind of MUX for regulators.

One more variant in case of PoE4: two positive rail are attached at same
time, one to 1-2, second to 5-6. May be one more variant with opposite
polarity, this will be the 6th combination.

> Seems to me you just describe the 2 rails going to the connector and 
> then describe all the variations the connector supports. The PSE 
> (h/w) has little to do with which variations are supported, right?

No. In case of mutli-channel PSE, it needs to know if channels are
attached to one port or to different ports. PSE is not only responsible
to enable the power, it runs classification of devices attached to the
port, so it will decide, which rail should be enabled.

> For example, MDI-X vs. MDI support is determined by the PHY, right?

Yes and No. Until PSE do not start supplying power, PHY will not be able to
start communication with the remote PHY, so it will not be able to
detect MDI/X configuration.

Polarity configuration is important for user space or user to get
information about supported pin configuration and if possible,
change the configuration.

> Or it has to be supported by both the PHY and PSE?

In most cases PSE and PHY work independently from each other, they just
share same port. Potential exception are:
- in case data line should not be shared with power lines, we need to
  know what pins are used for power, this information would help to
  provide PHY configuration.
- in case PHY autoneg signals disturb PoE classification, we need to
  coordinate PHY and PSE states.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

