Return-Path: <linux-kernel+bounces-72871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D03E185B9E0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EEFE1C225C6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB4165E03;
	Tue, 20 Feb 2024 11:05:46 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F97604A9
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708427146; cv=none; b=Ek4Xnsm2YbDK0yVbaPxkUo92ou4m0reEtVvBPThaWKj4YMCdbqrvZcHpoIKmkXXYTA7LaBUlsCVzO6JOQuOhrN89vbWGFc0rD6zGYXY/EorqGwFyasPVK9R2w2Fb1j0X7tCyzOUHAoDbiL5XyxttyHHNED5RfuFUgsclyjYesBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708427146; c=relaxed/simple;
	bh=Q9mYabNBUcqA8oe9D6+SQAxo2DGjJ2Cx4INUNvT3BdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqA3Bfam5sGZFsWQLBcJqEkZE8v6+89k0fp5lY/GpnQb0AaPbAOyyMWOBDXQcTjbdE1gE8VXOjXk5GpvC7CrqGI7JOPyheJ856jJ5YPTaI/3iiSxgutF2Jk6iSrPDfYGMN30UCRBuNYO2ff2R7Ilsc1NEdg8Jig1CvrvuEr13mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rcNw7-0004Em-QM; Tue, 20 Feb 2024 12:05:19 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rcNw5-001pNw-AE; Tue, 20 Feb 2024 12:05:17 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rcNw5-00HOOn-0e;
	Tue, 20 Feb 2024 12:05:17 +0100
Date: Tue, 20 Feb 2024 12:05:17 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
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
Subject: Re: [PATCH net-next v4 14/17] dt-bindings: net: pse-pd: Add bindings
 for PD692x0 PSE controller
Message-ID: <ZdSHbZl6yGxfbNYD@pengutronix.de>
References: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
 <20240215-feature_poe-v4-14-35bb4c23266c@bootlin.com>
 <ZdCjJcPbbBGYVtuo@pengutronix.de>
 <20240220114029.6b1a445d@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240220114029.6b1a445d@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2024 at 11:40:29AM +0100, Köry Maincent wrote:
> On Sat, 17 Feb 2024 13:14:29 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > On Thu, Feb 15, 2024 at 05:02:55PM +0100, Kory Maincent wrote:
> > > Add the PD692x0 I2C Power Sourcing Equipment controller device tree
> > > bindings documentation.
> > > 
> > > This patch is sponsored by Dent Project <dentproject@linuxfoundation.org>.
> > > 
> > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > > ---  
> > ...
> > > +        pse_pis {
> > > +          #address-cells = <1>;
> > > +          #size-cells = <0>;
> > > +
> > > +          pse_pi0: pse_pi@0 {
> > > +            reg = <0>;
> > > +            #pse-cells = <0>;
> > > +            pairset-names = "alternative-a", "alternative-b";
> > > +            pairsets = <&phys0>, <&phys1>;
> > > +          };
> > > +          pse_pi1: pse_pi@1 {
> > > +            reg = <1>;
> > > +            #pse-cells = <0>;
> > > +            pairset-names = "alternative-a";
> > > +            pairsets = <&phys2>;  
> > 
> > According to latest discussions, PSE PI nodes will need some
> > additional, board specific, information:
> > - this controller do not implements polarity switching, we need to know
> >   what polarity is implemented on this board. The 802.3 spec provide not
> >   really consistent names for polarity configurations:
> >   - Alternative A MDI-X
> >   - Alternative A MDI
> >   - Alternative B X
> >   - Alternative B S
> >   The board may implement one of polarity configurations per alternative
> >   or have additional helpers to switch them without using PSE
> >   controller.
> >   Even if specification explicitly say:
> >   "The PD shall be implemented to be insensitive to the polarity of the power
> >    supply and shall be able to operate per the PD Mode A column and the PD
> >    Mode B column in Table 33–13"
> >   it is possible to find reports like this:
> >   https://community.ui.com/questions/M5-cant-take-reversed-power-polarity-/d834d9a8-579d-4f08-80b1-623806cc5070
> > 
> >   Probably this kind of property is a good fit:
> >   polarity-supported = "MDI-X", "MDI", "X", "S";
> 
> This property should be on the PD side.

Probably. Right now we are on PSE side.

> Isn't it better to name it "polarity-provided" for each PSE PIs binding? What
> do you think?

Yes, this suggestion was directed for PSE PI nodes.

In the PHY world, we use "supported" capabilities for what HW can
actually do and "advertised" for how the HW is configured.

If we use word "provided", i would interpret it as subset of
"supported", which at the end is a user space policy.

Since I'm not native englisch speaker, my feeling can be wrong. So, any
one with stronger opinion may have here other preferences.

> We agreed that it is mainly for ethtool to show the polarity of a PI, right?

We have two kind of information here:
- polarity supported by HW. PSE PI may support more then one.
- actually configured polarity.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

