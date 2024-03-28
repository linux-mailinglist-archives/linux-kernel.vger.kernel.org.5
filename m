Return-Path: <linux-kernel+bounces-122890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D310388FF0C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EACF2934AE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147BE7D084;
	Thu, 28 Mar 2024 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="x1AejCY/"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12E36AC0;
	Thu, 28 Mar 2024 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629084; cv=none; b=RKR+Xug5e/9es2W6QNyeeHsehQPZwTHp2LQShbIwVPcRWK8uyDA0InRQZIZMTC7KnfAxw5EYXQTQWkRHCLZM3lOEfeZP02k8Vp/pHUhe5O59NcVy7EXcrz4bL1g4SOnhMG40pVg5e5N9N4M2lafKdOG+FLrbL8CRKils+mifdIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629084; c=relaxed/simple;
	bh=olEwNUHU8Es3c7i2wR9R6RW1M4yAYUSI1YmaXDThgXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9x+p+li/xQfB7Eqa8U7AChvMBDeJpBMSrBwete+j3eH6wKBeuXHdV9FAF/d0TDSZddp5XzYH6vZFrvOQKTHwDE9j46a34o+c58lkzLRnWJx6Q8R5cWBOKtmbA7b9d099oEjv1TIIi1OJg9gwEtceAlJlEm2CYwgezLIQmRZ0aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=x1AejCY/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3K9+fUzqHNKuVE49NIFsoNm4LPPEQ0miuf9p4SueIoU=; b=x1AejCY/iaLYOJuSBK+K6mDmGy
	3nrU15a5Xb1JTEFBw+IyKQSC9dXWPEbMI11Ae06rP1xpvhcE8iCcirSx2K179rTSvZX04wRY39yLd
	eyUvLXo/8HJCLV/7giSH+Os3nJ/UNUgWaaZJwLhhG5TzqGBaKX6+ahVDD8flBV9P9Mb4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rpouQ-00BUms-VV; Thu, 28 Mar 2024 13:31:06 +0100
Date: Thu, 28 Mar 2024 13:31:06 +0100
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
Subject: Re: [PATCH net-next v6 11/17] dt-bindings: net: pse-pd: Add another
 way of describing several PSE PIs
Message-ID: <2d325acb-fc35-4ca3-80f2-ac88359578fd@lunn.ch>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
 <20240326-feature_poe-v6-11-c1011b6ea1cb@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-feature_poe-v6-11-c1011b6ea1cb@bootlin.com>

> +          pairsets:
> +            $ref: /schemas/types.yaml#/definitions/phandle-array
> +            description:
> +              List of phandles, each pointing to the power supply for the
> +              corresponding pairset named in 'pairset-names'. This property
> +              aligns with IEEE 802.3-2022, Section 33.2.3 and 145.2.4.
> +              PSE Pinout Alternatives (as per IEEE 802.3-2022 Table 145\u20133)
> +              |-----------|---------------|---------------|---------------|---------------|
> +              | Conductor | Alternative A | Alternative A | Alternative B | Alternative B |
> +              |           |    (MDI-X)    |     (MDI)     |      (X)      |      (S)      |
> +              |-----------|---------------|---------------|---------------|---------------|
> +              | 1         | Negative VPSE | Positive VPSE | \u2014             | \u2014             |
> +              | 2         | Negative VPSE | Positive VPSE | \u2014             | \u2014             |
> +              | 3         | Positive VPSE | Negative VPSE | \u2014             | \u2014             |
> +              | 4         | \u2014             | \u2014             | Negative VPSE | Positive VPSE |
> +              | 5         | \u2014             | \u2014             | Negative VPSE | Positive VPSE |
> +              | 6         | Positive VPSE | Negative VPSE | \u2014             | \u2014             |
> +              | 7         | \u2014             | \u2014             | Positive VPSE | Negative VPSE |
> +              | 8         | \u2014             | \u2014             | Positive VPSE | Negative VPSE |

Is it possible to avoid \u encoding? Ideally this documentation should
be understandable without having to render it using a toolset. I just
want to use less(1).

Or is this a email problem? Has something converted your UTF-8 file to
this \u notation?

     Andrew

