Return-Path: <linux-kernel+bounces-129967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2578972C0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 116A9B24516
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6974E56B70;
	Wed,  3 Apr 2024 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPbur/z4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B38D272;
	Wed,  3 Apr 2024 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154705; cv=none; b=WcgeDu01JuQW87Zf06uZGwPxmaf23oyoAVaBLWuyqPeHpQ8NfsxEYXamr+K8wIewyKCaR7UAdXU7e8Zxv1abOmDZ53WlTdF78Ckkh21v91PrFwUvKKYATnLM5zGIImMZ0n9IA3HhuoGu6ycAwTOg5SNiul3y+rOkdgSrVI/DNjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154705; c=relaxed/simple;
	bh=awzNNZdI5HcMDUhEsGuSnb6/bioiSNUyQOEbMy3wFkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8ycIvMxLMziBy9rrifKZIGfa1+n4g7uSVa9ttNWbgsSpsrJo4QcFEFRR0pfdI2h5cO6oWYBbqC1/L9UxDxItmxgT1mlCrCULmzlWaNOXdFqlTfXEXRNYoWSVjHcxdRcJv5or5x/pRwzBsecGo1NWjOqf8nkKS2zcCJMEV43Yjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPbur/z4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE051C433F1;
	Wed,  3 Apr 2024 14:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712154705;
	bh=awzNNZdI5HcMDUhEsGuSnb6/bioiSNUyQOEbMy3wFkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DPbur/z4a1tQGEOZanah0R5lQ40TUPfDY6onBOSULbDggoXDaa6XJlzOl5449fH1H
	 orrjhONQ+tBaJewJdR1NbiPAxAKoKqCihxzjaxJ/c/JSYol0i4gVmPL1G+CETej73T
	 L4CevX5bm3JoMhgDu4BDtPLqBDZgPwgXebq1/f1BUtnv6DLd0qxi6klKbPjjrwcCwD
	 QrqCYWqQOrHfSy+R/gku28usZNMd3AKh87sIhB6tHjjfyVBugCmkGK9/VPrKbpFl6w
	 7YhMetzwM7LnqvGLx479DRvuqF5HrX/B/LQJpVyQTguBkc9YFzpBbWe2QH8OIk+Yyx
	 NNS7WMYUjX6Iw==
Date: Wed, 3 Apr 2024 09:31:42 -0500
From: Rob Herring <robh@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
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
Subject: Re: [PATCH net-next v6 11/17] dt-bindings: net: pse-pd: Add another
 way of describing several PSE PIs
Message-ID: <20240403143142.GA3508225-robh@kernel.org>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
 <20240326-feature_poe-v6-11-c1011b6ea1cb@bootlin.com>
 <20240402132637.GA3744978-robh@kernel.org>
 <20240403111548.30e780b5@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403111548.30e780b5@kmaincent-XPS-13-7390>

On Wed, Apr 03, 2024 at 11:15:48AM +0200, Kory Maincent wrote:
> On Tue, 2 Apr 2024 08:26:37 -0500
> Rob Herring <robh@kernel.org> wrote:
> 
> > > +          pairset-names:
> > > +            $ref: /schemas/types.yaml#/definitions/string-array
> > > +            description:
> > > +              Names of the pairsets as per IEEE 802.3-2022, Section
> > > 145.2.4.
> > > +              Valid values are "alternative-a" and "alternative-b". Each
> > > name  
> > 
> > Don't state constraints in prose which are defined as schema 
> > constraints.
> 
> Ok, I will remove the line.
> 
> > > +          pairsets:
> > > +            $ref: /schemas/types.yaml#/definitions/phandle-array
> > > +            description:
> > > +              List of phandles, each pointing to the power supply for the
> > > +              corresponding pairset named in 'pairset-names'. This property
> > > +              aligns with IEEE 802.3-2022, Section 33.2.3 and 145.2.4.
> > > +              PSE Pinout Alternatives (as per IEEE 802.3-2022 Table
> > > 145\u20133)
> > > +
> > > |-----------|---------------|---------------|---------------|---------------|
> > > +              | Conductor | Alternative A | Alternative A | Alternative B
> > > | Alternative B |
> > > +              |           |    (MDI-X)    |     (MDI)     |      (X)
> > > |      (S)      |
> > > +
> > > |-----------|---------------|---------------|---------------|---------------|
> > > +              | 1         | Negative VPSE | Positive VPSE | \u2014
> > >     | \u2014             |
> > > +              | 2         | Negative VPSE | Positive VPSE | \u2014
> > >     | \u2014             |
> > > +              | 3         | Positive VPSE | Negative VPSE | \u2014
> > >     | \u2014             |
> > > +              | 4         | \u2014             | \u2014             |
> > > Negative VPSE | Positive VPSE |
> > > +              | 5         | \u2014             | \u2014             |
> > > Negative VPSE | Positive VPSE |
> > > +              | 6         | Positive VPSE | Negative VPSE | \u2014
> > >     | \u2014             |
> > > +              | 7         | \u2014             | \u2014             |
> > > Positive VPSE | Negative VPSE |
> > > +              | 8         | \u2014             | \u2014             |
> > > Positive VPSE | Negative VPSE |
> > > +            minItems: 1
> > > +            maxItems: 2  
> > 
> > "pairsets" does not follow the normal design pattern of foos, foo-names, 
> > and #foo-cells. You could add #foo-cells I suppose, but what would cells 
> > convey? I don't think it's a good fit for what you need.
> > 
> > The other oddity is the number of entries and the names are fixed. That 
> > is usually defined per consumer. 
> 
> Theoretically if the RJ45 port binding was supported it would make more sense,
> but in reality it's not feasible as the PSE controller need this information
> in its init process.
> The PSE controller reset all its port to apply a configuration so we can't do
> it when the consumer (RJ45) probe. It would reset the other ports if one
> consumer is probed later in the process.

There is no reason other than convenience that all information some 
driver needs has to be in one node or one hierarchy of nodes. You can 
fetch anything from anywhere in the DT. It does feel like some of this 
belongs in a connector node. We often haven't described connectors in DT 
and stick connector properties in the controller node associated with 
the connector. Then as things get more complicated, it becomes a mess. 


> > As each entry is just a power rail, why can't the regulator binding be 
> > used here?
> 
> Olekisj already answered about it.
> PSE PI is like a regulator but with few different features and more information
> like the pinout and the polarity, so we could not really fully rely on the
> regulator binding style.
> 
> > > +
> > > +          polarity-supported:
> > > +            $ref: /schemas/types.yaml#/definitions/string-array
> > > +            description:
> > > +              Polarity configuration supported by the PSE PI pairsets.
> > > +            minItems: 1
> > > +            maxItems: 4
> > > +            items:
> > > +              enum:
> > > +                - MDI-X
> > > +                - MDI
> > > +                - X
> > > +                - S
> > > +
> > > +          vpwr-supply:
> > > +            description: Regulator power supply for the PSE PI.  
> > 
> > I don't see this being used anywhere.
> 
> Right, I forgot to add it to the PD692x0 and TPS23881 binding example!

But is this really common/generic? I would think input power rails would 
be chip specific.

Rob

