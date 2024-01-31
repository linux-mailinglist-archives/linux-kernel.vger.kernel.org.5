Return-Path: <linux-kernel+bounces-47108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8980844960
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 136C4B267A8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0238839846;
	Wed, 31 Jan 2024 21:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CziRsmJy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E7038F99;
	Wed, 31 Jan 2024 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735124; cv=none; b=DkopPCelmfG67lbPgcb9fGxMy73IToNHv2hsNtQ5rWFoc9BlrWYSvN1w9j+pGNXE1m2m9ajbVsFFC3OgdjjNmBGy6bLsKSQnNS9rtf68qmRfbrTyQIcfoj+1GNHmVukr94xqNQR+dUmV/4VOri+TYQz7TcTNZExUtQxsbyNqb+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735124; c=relaxed/simple;
	bh=yukPKmdntsPO4Ptb2DlkD/3xKIWm/qqaGhw8mXHzQ54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6q8bAU5lxkqmSP2b2JmUg6sTMz/OrqpGRcyMaiHJ6D3Vuw87hkhaPK9j2LoJtGTrHoUU60qPMAxxMS7SKBmC1HVwVwx5jQazqwed3fgfRAPpq4YBVhvhQ+tGXkTqLB9ZFbJY8tfzAoXVnN86SRXzr2AmBGpnKZqSOSzoUN5C2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CziRsmJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAFAC433F1;
	Wed, 31 Jan 2024 21:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706735124;
	bh=yukPKmdntsPO4Ptb2DlkD/3xKIWm/qqaGhw8mXHzQ54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CziRsmJyID4G5tTQ3KfLzL1hg9YFWD2bhHV8DG9sxdIPnhGjP4qvHfsj+o5psIEPB
	 6RSO6rfLh4NIQmRcTDc28X2LOmlMCdBOP/40fb4D38g+TH1GfZFrT5+PwoIK0oKJyL
	 2nSlVa9aa+DW/h5+NTulmMXanojHXGp8PLgpLOb5DmqFNFyzJA58cc5b17L1tGRV9G
	 nZSJyRNFSyUfZExgZuLaEL0mTyiM1AaWHaxWKNJCSXyiLgTIcWY0bd52cEHYlnGHp0
	 /YJwh6BduzmDqIZBArUytbI+nt6+4zEKF4C4RsgRE1OCVmyH3YoUkEj933nwpXxrQ/
	 UtKcyRMeqlN2w==
Date: Wed, 31 Jan 2024 15:05:21 -0600
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: Add TI DP83640
Message-ID: <20240131210521.GA2289883-robh@kernel.org>
References: <20240130085935.33722-1-bastien.curutchet@bootlin.com>
 <20240130085935.33722-2-bastien.curutchet@bootlin.com>
 <20240130-impulsive-widow-9142a069b7fd@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130-impulsive-widow-9142a069b7fd@spud>

On Tue, Jan 30, 2024 at 05:56:37PM +0000, Conor Dooley wrote:
> Hey,
> 
> On Tue, Jan 30, 2024 at 09:59:34AM +0100, Bastien Curutchet wrote:
> > +description: |
> > +  The DP83640 Precision PHYTER device delivers the highest level of precision
> 
> This is not a marketing document.
> 
> > +  clock synchronization for real time industrial connectivity based on the
> > +  IEEE 1588 standard. The DP83640 has deterministic, low latency and allows
> > +  choice of microcontroller with no hardware customization required
> > +
> > +  This device interfaces directly to the MAC layer through the
> > +  IEEE 802.3 Standard Media Independent Interface (MII), or Reduced MII (RMII).
> > +
> > +  Specifications about the Ethernet PHY can be found at:
> > +    https://www.ti.com/lit/gpn/dp83640
> > +
> > +properties:
> > +  reg:
> > +    maxItems: 1
> > +
> > +  ti,clk-output:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1]
> > +    description: |
> > +      If present, enables or disables the CLK_OUT pin.
> > +      CLK_OUT pin disabling can also be strapped. If the strap pin is not set
> > +      correctly or not set at all then this can be used to configure it.
> > +       - 0     = CLK_OUT pin disabled
> > +       - 1     = CLK_OUT pin enabled
> > +       - unset = Configured by straps
> 
> If you are providing a clock, why is there no clock-controller property
> here? I don't think the 3-way nature of this property is needed, if you
> make this a "real" clock controller.
> 
> > +  ti,fiber-mode:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1]
> > +    description: |
> > +      If present, enables or disables the FX Fiber Mode.
> > +      Fiber mode support can also be strapped. If the strap pin is not set
> > +      correctly or not set at all then this can be used to configure it.
> > +       - 0     = FX Fiber Mode disabled
> > +       - 1     = FX Fiber Mode enabled
> > +       - unset = Configured by straps
> 
> I don't like these properties that map meanings onto numbers. We can
> have enums of strings in bindings that allow you to use something more
> meaningful than "0" or "1".

Tristate properties are fairly common pattern where we need 
on/off/default. I've thought about making it a type. I don't think we 
need defines for it.

Rob

