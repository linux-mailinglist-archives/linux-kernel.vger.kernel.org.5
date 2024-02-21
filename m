Return-Path: <linux-kernel+bounces-75438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C2485E8AE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301E21C23405
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F646126F27;
	Wed, 21 Feb 2024 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUChUiHS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613131EB26;
	Wed, 21 Feb 2024 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708545648; cv=none; b=fCSl5PdcCT3UjgfYVLoKXoBOOGw/1WqFAnUWBuG90VYob0bRWnRQaZynhy5GLVMUhg2XI6SMAmAZEiqC2qIUKo02sfg8SdHBrgdSbj+diswGdXOcRraJnkbNLaw3d5GNn+f4sdanA8SdCh+j2V3f3NiGXD874ifbUP5RznIFXZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708545648; c=relaxed/simple;
	bh=qcA+UO/4y3+iSG1ZjNhr7mI/EtGsyTLxSjE9iOG6zXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ry93mLRhZrH9lm2GRn8PoqYVRroRCc7z6A+ZQvlK8sniXIScJ94zF9FMhwVEfZcGw1fggrjb0Vfw7YYsOfQprdZAzPXortVWIinNGpXBI4BCzPGwsm04BUXvz5UlcYIhAwmhgLOnLaVOse/3GilovAxRfDjxAjkR5EkRHZ/TffM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUChUiHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D984C433F1;
	Wed, 21 Feb 2024 20:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708545647;
	bh=qcA+UO/4y3+iSG1ZjNhr7mI/EtGsyTLxSjE9iOG6zXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aUChUiHS1R3gt7+GTv1JP80f+HdLJiQpHdQe45D2elRvVGZjdtCdeump+fk2gYyH2
	 CWXwNqq3GsYuWbpDHsdxX+MmV5Nz10HlnxX5TUSsBwzStx5p7ttz5guYp+V4vUqwGY
	 /tOXdB5wK07+dNBsNljJIChgL172hrKedj4SUXxWq3kkdeA9W4XhhZKOUnzhTGFfKH
	 NC3I10ne4TAFA5w2Tyu4Z0DXU4oshQmZu+cImmcFBbaOUfaSqLQbTpcC745oVzTDrq
	 w3q63yfDQ3CdyQYijRnzuzsj/sK+gOFkga8nrZotLytHdw+jxtD+qkF9113e//q2SB
	 DMhi853JKfijg==
Date: Wed, 21 Feb 2024 20:00:40 +0000
From: Conor Dooley <conor@kernel.org>
To: Ceclan Dumitru <mitrutzceclan@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, linus.walleij@linaro.org,
	brgl@bgdev.pl, andy@kernel.org, linux-gpio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <michael@walle.cc>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu <chiaen_wu@richtek.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Haibo Chen <haibo.chen@nxp.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 1/3] dt-bindings: adc: add AD7173
Message-ID: <20240221-grief-situated-575ce257f6ff@spud>
References: <20240220094344.17556-1-mitrutzceclan@gmail.com>
 <CAMknhBEZ7Y1Yx=wJGnfvYWGKPLas3pbCyY+sN8vrBzdkYO-A4w@mail.gmail.com>
 <0fa819d1-2a0f-4243-8e5f-a098528278c3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Gq3jLFI+SugAYTYF"
Content-Disposition: inline
In-Reply-To: <0fa819d1-2a0f-4243-8e5f-a098528278c3@gmail.com>


--Gq3jLFI+SugAYTYF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> +
> >> +      diff-channels:
> >> +        items:
> >> +          minimum: 0
> >> +          maximum: 31
> >> +
> >=20
> > Are we missing `bipolar: true` here? (since we have
> > unevaluatedProperties: false)
> >=20
>=20
> No, since we are referencing the adc schema "$ref: adc.yaml"
> Which contains:
> """
>   bipolar:
>=20
>     $ref: /schemas/types.yaml#/definitions/flag
>=20
>     description: If provided, the channel is to be used in bipolar mode.
> """

FWIW, the difference here is whether or not the binding for the device
contains "additionalProperties: false" or "unevaluatedProperties: false".
The former requires "bipolar: true", the latter does not.

Cheers,
Conor.

--Gq3jLFI+SugAYTYF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdZWaAAKCRB4tDGHoIJi
0h0tAQC4eO1DowojEvVagFKPsHMUGG8afYTYGfkExi7A6fMnhAEAjWIamj131REA
D7r8rgqBpDk+FKzG6L4DcLAG3X2LMAU=
=rUvt
-----END PGP SIGNATURE-----

--Gq3jLFI+SugAYTYF--

