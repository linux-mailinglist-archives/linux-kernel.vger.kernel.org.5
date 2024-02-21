Return-Path: <linux-kernel+bounces-74968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8321485E091
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388361F21D7E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5CD80BE1;
	Wed, 21 Feb 2024 15:07:01 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A873480058
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528021; cv=none; b=K8di/snzJL5AnRSwNP3Sc8g7zdxt032FeaT3oJaD998tWN/dM5XiTMoBpIWUXxiZr6AqEE8Cohix/u949id+opDT+YzF5Gep9ldzd+RBG25AMIt3TuTtjyLWKdfIdWaatU9fFqG0yiaYXMh3y9+tnwhvbJZFxi3R+3KMo6jJVk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528021; c=relaxed/simple;
	bh=VKs5SC9Um/6jmiJHZEARbnapbryfD+Cwve6zqW4sFCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDh59ZJn0MXy2lKNaVzw4N26zXipBsXcQqFSsk3kvXeBKokQxAm3ZgCiddX0mSDp3bOASzFurBm/vX9ymmY9684zRNptkNf/QfUfnecXrVL6GBhw5GxlrAZEgA/P0zoQ14Hepsty7Pu2pHZTOlDJmfX/YwwKgwwBhqhGSFNJ2Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rcoB2-0005mi-2V; Wed, 21 Feb 2024 16:06:28 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rcoAz-0023lz-EZ; Wed, 21 Feb 2024 16:06:25 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rcoAz-001Ke2-15;
	Wed, 21 Feb 2024 16:06:25 +0100
Date: Wed, 21 Feb 2024 16:06:25 +0100
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
Subject: Re: [PATCH net-next v4 14/17] dt-bindings: net: pse-pd: Add bindings
 for PD692x0 PSE controller
Message-ID: <ZdYRccm7-TXcRp_v@pengutronix.de>
References: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
 <20240215-feature_poe-v4-14-35bb4c23266c@bootlin.com>
 <ZdCjJcPbbBGYVtuo@pengutronix.de>
 <20240221144135.GB2779189-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240221144135.GB2779189-robh@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2024 at 07:41:35AM -0700, Rob Herring wrote:
> On Sat, Feb 17, 2024 at 01:14:29PM +0100, Oleksij Rempel wrote:
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
> Where does that live? Looks like a property of the consumers defined in 
> the provider. Generally, that's not the right way for DT. 

This is property of PSE PI (Power Interface)

                                             Ethernet PHY --\
PSE (provider) ----> PSE PI (consumer of multiple PSE's) ----> Physial port


PSE - provides power lines.
PSE PI - switches (or not) power lines in different configurations. This
is different part of the board/system. PSE PI can have combination or
one of following configurations: "MDI-X", "MDI", "X", "S";
This is not something what PSE actually do. PSE PI and PSE are described
in IEEE802.3 specification.

> I'll say it 
> again, I think you should be expanding #pse-cells (>1), not getting rid 
> of them (==0).

Did you took time to read my last explanation? Sorry for making it long
description, this topic is a bit complex.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

