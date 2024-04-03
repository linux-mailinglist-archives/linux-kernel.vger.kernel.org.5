Return-Path: <linux-kernel+bounces-129990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB97A8972F4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8376FB26AD7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DA914901F;
	Wed,  3 Apr 2024 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KL/hqdY7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C4213A40B;
	Wed,  3 Apr 2024 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155491; cv=none; b=pyl4H+oKIkETLVhvfPHQXTHDvlTyeaK7hDJqNbeSuy6PbgtHx7ePwWhbN90zaOoKuHKKn58bXTtPviTDDDhyboPzKOIUiCDyDoQlUkXhX4u2flb7d3TvBs54nJz1w0p//whaCBSIvhdBwdSYvsn45mspvx6B9NLHxBiqIuFOyNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155491; c=relaxed/simple;
	bh=/bUWFCezkgyy5S4CuqWiKnU6VWsOo2TS23X0CcIeO3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snzGs1MsU2T+2K3LeLjEUM5reRHwVsbK+h2Fj8OWU1bcmw/gqjys+OkVjkXeRed5oePx5fXrPUOBCgJ0Mq7FoIxAHllgylXXOxstAcP6AnFXvGfGdbgE1q6A/XNrW39UcLH97sV613FC4e8BoJ2fjcMWfn1GShck1XVP5MmEUzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KL/hqdY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD74C43390;
	Wed,  3 Apr 2024 14:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712155490;
	bh=/bUWFCezkgyy5S4CuqWiKnU6VWsOo2TS23X0CcIeO3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KL/hqdY7g7A3rt3L64YGc6y7NTX5V8jEgRH7IAkb8JOPoYIVE5QOrXyy0d/eqhXw9
	 vY4wymhn3lErTVlrTnXatW6LuhTFrVc37KKda09EL13L58Ihpz0i36/j1CDth4MoRn
	 rQNJJvgojQa3hyCq/7MTOiyksIwuFCX/KjEhX0aXwK4rswWATSChfDtanxwrBYF3gC
	 Zp/K7R7J/Dc/83hOszq7jPMoIhVgdNoqzvBdYaDbknJP7SGf1VJEkxR3hjLQmZ35hZ
	 AlRbfVhB7SyO/JkEnmBQbn7Wl+WzxvFtKRBNG1aRrQy2S6TndM+I0M3swW1nbA595R
	 U/Oh06gBLL9ZQ==
Date: Wed, 3 Apr 2024 09:44:48 -0500
From: Rob Herring <robh@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
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
Message-ID: <20240403144448.GB3508225-robh@kernel.org>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
 <20240326-feature_poe-v6-11-c1011b6ea1cb@bootlin.com>
 <20240402132637.GA3744978-robh@kernel.org>
 <ZgworgDAXXOpf3QV@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgworgDAXXOpf3QV@pengutronix.de>

On Tue, Apr 02, 2024 at 05:47:58PM +0200, Oleksij Rempel wrote:
> On Tue, Apr 02, 2024 at 08:26:37AM -0500, Rob Herring wrote:
> > > +          pairsets:
> > > +            $ref: /schemas/types.yaml#/definitions/phandle-array
> > > +            description:
> > > +              List of phandles, each pointing to the power supply for the
> > > +              corresponding pairset named in 'pairset-names'. This property
> > > +              aligns with IEEE 802.3-2022, Section 33.2.3 and 145.2.4.
> > > +              PSE Pinout Alternatives (as per IEEE 802.3-2022 Table 145\u20133)
> > > +              |-----------|---------------|---------------|---------------|---------------|
> > > +              | Conductor | Alternative A | Alternative A | Alternative B | Alternative B |
> > > +              |           |    (MDI-X)    |     (MDI)     |      (X)      |      (S)      |
> > > +              |-----------|---------------|---------------|---------------|---------------|
> > > +              | 1         | Negative VPSE | Positive VPSE | \u2014             | \u2014             |
> > > +              | 2         | Negative VPSE | Positive VPSE | \u2014             | \u2014             |
> > > +              | 3         | Positive VPSE | Negative VPSE | \u2014             | \u2014             |
> > > +              | 4         | \u2014             | \u2014             | Negative VPSE | Positive VPSE |
> > > +              | 5         | \u2014             | \u2014             | Negative VPSE | Positive VPSE |
> > > +              | 6         | Positive VPSE | Negative VPSE | \u2014             | \u2014             |
> > > +              | 7         | \u2014             | \u2014             | Positive VPSE | Negative VPSE |
> > > +              | 8         | \u2014             | \u2014             | Positive VPSE | Negative VPSE |
> > > +            minItems: 1
> > > +            maxItems: 2
> > 
> > "pairsets" does not follow the normal design pattern of foos, foo-names, 
> > and #foo-cells. You could add #foo-cells I suppose, but what would cells 
> > convey? I don't think it's a good fit for what you need.
> > 
> > The other oddity is the number of entries and the names are fixed. That 
> > is usually defined per consumer. 
> > 
> > As each entry is just a power rail, why can't the regulator binding be 
> > used here?
> 
> I'm not against describing it consequent with regulator till the wire
> end, but right now I have no idea how it should be described by using
> regulator bindings. There are maximum 2 rails going in to PSE PI on one
> side and 4 rails with at least 5 combinations supported by standard on
> other side. Instead of inventing anything new, I suggested to describe
> supported output combinations by using IEEE 802.3 standard.

There's 4 combinations above, what's the 5th combination? SPE?

Seems to me you just describe the 2 rails going to the connector and 
then describe all the variations the connector supports. The PSE 
(h/w) has little to do with which variations are supported, right? 
For example, MDI-X vs. MDI support is determined by the PHY, right? Or 
it has to be supported by both the PHY and PSE?

Rob

