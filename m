Return-Path: <linux-kernel+bounces-119283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE3288C692
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E011F664E3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9DC13C9A1;
	Tue, 26 Mar 2024 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OCyyPqD9"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4389B13C3F1;
	Tue, 26 Mar 2024 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466056; cv=none; b=fOGgWUok/nPt5Aqfl8xMrTWuihjzA5VN6DrdhBys4/hU2APWK99wszLiwyqU245wKDChFSBOzJQXOdSIGVUFTTTaIImo/GzlCUHi0x5CZafm8C8xRU5j+zaC2H16QYokZ1Pj46PiQ5OfeG27xVpfJgQkFqU+2D7ssNwU2wUFaNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466056; c=relaxed/simple;
	bh=AzZ+0V/7UCP04kyacfJaJZkcxE/dAHgDXOr2CADnkio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TB5+o/yXcZ0oGkGY+i9UHjidR1el7JEWf5whS4Ee73t97R2FuAUCBJDM+DWP0HdsSqaXgIOkSfunlPRyx0+m6Zx4U5zaziuf7JuVsA4f4pccj57CtUbdX0Y/ipo3IYJ9CrU6Z+Tn/AMQXz9muAlhJ4QRJY6MgDpoiroXLu7sCKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OCyyPqD9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3vWUrAA8SZ0bCLZDcJmAKQ5MfnH0TVI2Dv0Fp0kU2eA=; b=OCyyPqD9Qte/rxh7EbEj7wBpWD
	M0PVTxm3eD6v7qzfKYO1ZitDxFc7DSO1niSFC2uJ0tQx3oceXcrn9xDW/qsw0wUXosyACH5xid1hR
	z9AYNND2tXKNbwipMrvM1OSixeP96D746fZZMa9FgTBYgQWojfiPftbBwIXV0KQIdMUA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rp8Uw-00BIGs-R1; Tue, 26 Mar 2024 16:13:58 +0100
Date: Tue, 26 Mar 2024 16:13:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christophe ROULLIER <christophe.roullier@foss.st.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: net: add phy-supply property for
 stm32
Message-ID: <838d8e91-9b82-4185-8827-055fcaea8fcc@lunn.ch>
References: <20240326125849.226765-1-christophe.roullier@foss.st.com>
 <20240326125849.226765-2-christophe.roullier@foss.st.com>
 <0e14ad5d-3c25-40ab-981a-fbc4e245fc94@lunn.ch>
 <a19b20ae-d12a-47c8-9d1f-482a84924e6c@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a19b20ae-d12a-47c8-9d1f-482a84924e6c@foss.st.com>

On Tue, Mar 26, 2024 at 03:41:13PM +0100, Christophe ROULLIER wrote:
> 
> On 3/26/24 14:58, Andrew Lunn wrote:
> > On Tue, Mar 26, 2024 at 01:58:48PM +0100, Christophe Roullier wrote:
> > > Phandle to a regulator that provides power to the PHY. This
> > > regulator will be managed during the PHY power on/off sequence.
> > > 
> > > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> > > ---
> > >   Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> > > index fc8c96b08d7dc..80937b28fa046 100644
> > > --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> > > +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> > > @@ -82,6 +82,9 @@ properties:
> > >         Should be phandle/offset pair. The phandle to the syscon node which
> > >         encompases the glue register, and the offset of the control register
> > > +  phy-supply:
> > > +    description: PHY regulator
> > ~/linux/drivers/net/ethernet/stmicro/stmmac$ grep regulator_get *
> > dwmac-rk.c:	bsp_priv->regulator = devm_regulator_get(dev, "phy");
> > dwmac-sun8i.c:	gmac->regulator = devm_regulator_get_optional(dev, "phy");
> > dwmac-sunxi.c:	gmac->regulator = devm_regulator_get_optional(dev, "phy");
> > 
> > Maybe i'm missing something, but i don't see an actual implementation
> > of this binding?
> > 
> > 	Andrew
> 
> Hi Andrew,
> 
> You are right, my next step is to upstream support of Ethernet MP13 glue and
> some update like Phy regulator support

Then please make this binding patch part of the series which
implements the binding. They go together.

	Andrew

