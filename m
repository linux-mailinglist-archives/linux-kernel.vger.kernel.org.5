Return-Path: <linux-kernel+bounces-45064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA77842B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2131C2538E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB8A15697D;
	Tue, 30 Jan 2024 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8j0BtX5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4306151CC4;
	Tue, 30 Jan 2024 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706637404; cv=none; b=tBiqcvqNjttQ89WR8+05K3//HciE1F3OISQQuimiQpiP8MUdcyJAHNVgEWe/SFIS7ULMCKazEtSa7dvi3FEXRYWfy3H9KN+7kzcELSHnOlVr5YGs029gKt9F4JzuMU7z+thiSXZ1mX1bd4313L8JEbJTdxNUULNTSDBm0YgfLrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706637404; c=relaxed/simple;
	bh=Yb/9/lIzuxOAl9LlxJ374p+pZ3mV2yczBgo+ljHDeKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SV6joVV8p6ZmKVCgiKzwoUodDrsvC26JyzCHUQFKrdZS4fnfcxKHQk4sWEB99Kbtj9kM9RMGukUvCEt/VLrld8UHlJz4PPPSNEkE/5A6D343m/3TwpMe+rqyO/6XQWC4RYnKm8Taiq0XIIGEja7/sCzPyzCBvInGBlT0/FeZOJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8j0BtX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213FDC433F1;
	Tue, 30 Jan 2024 17:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706637403;
	bh=Yb/9/lIzuxOAl9LlxJ374p+pZ3mV2yczBgo+ljHDeKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p8j0BtX5Ynuq9zhz1R1Jsk79RG7Ky6/WW0lNaSGJ5412sUUM30tUeQcFaqWTZsvUP
	 pDUK56hdOmF1huF/uLh4VEn1YdBlLGGsCZMxhjItgfeC9j2Ivt9MSMcEh/wSGlx9mm
	 AAhFS/PSndmNl2f19w6ZEYwmmbNiRdGHabYj04on/IcUZpidIXeAFLN1pnBLeJTpb8
	 mCTgDCIktuAXwgI+ZfMFNezKxN8uSqHAnEPmoA35zMvGjgb2d4CcsxiVLEGs8VlWWk
	 CMG6blBzxWOgVKyJbC8x+2ecvhEqgJXE/YMOmyNUDjEbLmgvYqi+eY32uZ8869uscO
	 8PtjDa4L4Vuzg==
Date: Tue, 30 Jan 2024 17:56:37 +0000
From: Conor Dooley <conor@kernel.org>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <20240130-impulsive-widow-9142a069b7fd@spud>
References: <20240130085935.33722-1-bastien.curutchet@bootlin.com>
 <20240130085935.33722-2-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y5GnecSt1OF2hlII"
Content-Disposition: inline
In-Reply-To: <20240130085935.33722-2-bastien.curutchet@bootlin.com>


--Y5GnecSt1OF2hlII
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey,

On Tue, Jan 30, 2024 at 09:59:34AM +0100, Bastien Curutchet wrote:
> +description: |
> +  The DP83640 Precision PHYTER device delivers the highest level of precision

This is not a marketing document.

> +  clock synchronization for real time industrial connectivity based on the
> +  IEEE 1588 standard. The DP83640 has deterministic, low latency and allows
> +  choice of microcontroller with no hardware customization required
> +
> +  This device interfaces directly to the MAC layer through the
> +  IEEE 802.3 Standard Media Independent Interface (MII), or Reduced MII (RMII).
> +
> +  Specifications about the Ethernet PHY can be found at:
> +    https://www.ti.com/lit/gpn/dp83640
> +
> +properties:
> +  reg:
> +    maxItems: 1
> +
> +  ti,clk-output:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +    description: |
> +      If present, enables or disables the CLK_OUT pin.
> +      CLK_OUT pin disabling can also be strapped. If the strap pin is not set
> +      correctly or not set at all then this can be used to configure it.
> +       - 0     = CLK_OUT pin disabled
> +       - 1     = CLK_OUT pin enabled
> +       - unset = Configured by straps

If you are providing a clock, why is there no clock-controller property
here? I don't think the 3-way nature of this property is needed, if you
make this a "real" clock controller.

> +  ti,fiber-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +    description: |
> +      If present, enables or disables the FX Fiber Mode.
> +      Fiber mode support can also be strapped. If the strap pin is not set
> +      correctly or not set at all then this can be used to configure it.
> +       - 0     = FX Fiber Mode disabled
> +       - 1     = FX Fiber Mode enabled
> +       - unset = Configured by straps

I don't like these properties that map meanings onto numbers. We can
have enums of strings in bindings that allow you to use something more
meaningful than "0" or "1".

Cheers,
Conor.


--Y5GnecSt1OF2hlII
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbk4VQAKCRB4tDGHoIJi
0sc9AP9/5gdJl8glaf7X/USWmsQy+VhIxi9nZrUhkpklLAx09gEAs00QJHIiHRDu
j51c3BLSHaUypla7gPW7LWlopEKQeAs=
=Zij8
-----END PGP SIGNATURE-----

--Y5GnecSt1OF2hlII--

