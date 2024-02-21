Return-Path: <linux-kernel+bounces-74923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EC185E016
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA671F24E40
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FAF80C06;
	Wed, 21 Feb 2024 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ED+Is0Rs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713017FBBE;
	Wed, 21 Feb 2024 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526498; cv=none; b=JwjPJxwegBMNv2hbVjuCq9GrxJhLjr++06qlJ6UfH26N16EhvB4JmEy1saoY5M8TTUpoSHSY7zxwHQhgz49lXSnWmbDi7Mzn/YKOmK+B01zly6nEkfl5E9Y21MRed+QDDj/C8Dh/UJriYIJVUw79p9qDauybDonyDtQtRmGZd8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526498; c=relaxed/simple;
	bh=LMvwRVWrGpntZKffwPjxzABB0GbvgGzy15uoz5ce5Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkhP6ia6rA3vTKCvmREOd6z+HZPnCudA2g2827wvEpcFGS2uwk5yPmTkUCDY9KzWO/K1njzKJeZxnfZiR0AoulB4/35aHougV3DHwsjGwGGr4lowWvX6cCf8yUzeSuTAgBcZKH3SRIksWKs4ELQYqydX300ManRJOF1ace3joos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ED+Is0Rs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F34BC43399;
	Wed, 21 Feb 2024 14:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708526498;
	bh=LMvwRVWrGpntZKffwPjxzABB0GbvgGzy15uoz5ce5Ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ED+Is0RsdeVe2u1XRn9CptJaFKbYvAoA7zlpphH6RpmngRFblgD0fcKmbWmWRw+9R
	 duuhOW191XM9FtLrmaayiakgjT+3nAHjaQldSiZwQkh+cKNrVAlNHy9qqp8nzN3y+s
	 OcQm7CbEJNg5qelau0b6Ac6FSN4XjhYP5E+UhNBrfCu7/XqFFv1E+r1S02F/w4YvK9
	 tS9WwvcDbrhuwqJTsltEGwo7mmmO0c6s1+Vdojn1SWXnM/06GMXfZXGNVUaGw33/2u
	 LauqDeHtD4tNOLfxsEezzvnOBJJI6C9IYochwhRRUIDmeflWyKyZGnk20lZBAK3iRF
	 E5wLxaGuUwsew==
Date: Wed, 21 Feb 2024 07:41:35 -0700
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
Subject: Re: [PATCH net-next v4 14/17] dt-bindings: net: pse-pd: Add bindings
 for PD692x0 PSE controller
Message-ID: <20240221144135.GB2779189-robh@kernel.org>
References: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
 <20240215-feature_poe-v4-14-35bb4c23266c@bootlin.com>
 <ZdCjJcPbbBGYVtuo@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZdCjJcPbbBGYVtuo@pengutronix.de>

On Sat, Feb 17, 2024 at 01:14:29PM +0100, Oleksij Rempel wrote:
> On Thu, Feb 15, 2024 at 05:02:55PM +0100, Kory Maincent wrote:
> > Add the PD692x0 I2C Power Sourcing Equipment controller device tree
> > bindings documentation.
> > 
> > This patch is sponsored by Dent Project <dentproject@linuxfoundation.org>.
> > 
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> ...
> > +        pse_pis {
> > +          #address-cells = <1>;
> > +          #size-cells = <0>;
> > +
> > +          pse_pi0: pse_pi@0 {
> > +            reg = <0>;
> > +            #pse-cells = <0>;
> > +            pairset-names = "alternative-a", "alternative-b";
> > +            pairsets = <&phys0>, <&phys1>;
> > +          };
> > +          pse_pi1: pse_pi@1 {
> > +            reg = <1>;
> > +            #pse-cells = <0>;
> > +            pairset-names = "alternative-a";
> > +            pairsets = <&phys2>;
> 
> According to latest discussions, PSE PI nodes will need some
> additional, board specific, information:
> - this controller do not implements polarity switching, we need to know
>   what polarity is implemented on this board. The 802.3 spec provide not
>   really consistent names for polarity configurations:
>   - Alternative A MDI-X
>   - Alternative A MDI
>   - Alternative B X
>   - Alternative B S
>   The board may implement one of polarity configurations per alternative
>   or have additional helpers to switch them without using PSE
>   controller.
>   Even if specification explicitly say:
>   "The PD shall be implemented to be insensitive to the polarity of the power
>    supply and shall be able to operate per the PD Mode A column and the PD
>    Mode B column in Table 33–13"
>   it is possible to find reports like this:
>   https://community.ui.com/questions/M5-cant-take-reversed-power-polarity-/d834d9a8-579d-4f08-80b1-623806cc5070
> 
>   Probably this kind of property is a good fit:
>   polarity-supported = "MDI-X", "MDI", "X", "S";

Where does that live? Looks like a property of the consumers defined in 
the provider. Generally, that's not the right way for DT. I'll say it 
again, I think you should be expanding #pse-cells (>1), not getting rid 
of them (==0).

Rob

