Return-Path: <linux-kernel+bounces-79753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6649D862640
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969791C21293
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2786A47A55;
	Sat, 24 Feb 2024 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkpaewT3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED341EB34;
	Sat, 24 Feb 2024 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708794445; cv=none; b=QxuJMrsavDoYK44ZePvnaJ2/vsvVwb9Wxd3ySVnECQwCaxQe+mJeSpPawE3koipvp7UACpP8ZTh5af97HNCWFehDKB07B7JF4Q/Wicji7+lcBLhQKNogS8N5puhN12tUsgnVJMLrJVWd7g5P7f9Xscjt8/l/jtHdYw7LxdGLLUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708794445; c=relaxed/simple;
	bh=eeYrfwWrvmfry0lGfIaaBnx0Xj+7Z5pHDan2aTVa8+I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPKPFySMYMXYrdcB69Bxd3jALU0K+p7HVcGaziAUsAGyxLDm0vgXzCdRs/o0uF9Nf3Ia8YKEqPBwhfKjfs8Ufl2Un/BBxa418m3C08ht8TuatrLLgaj5aH5+zHu5ukdXgPIwyJ/NMKtDW4i7qT9AwjIyGkRyy2qg0sRGr8R7Cns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkpaewT3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB6AC433C7;
	Sat, 24 Feb 2024 17:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708794445;
	bh=eeYrfwWrvmfry0lGfIaaBnx0Xj+7Z5pHDan2aTVa8+I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JkpaewT3OUJ2LYRrRKYiGZ62iq7pxMqURkDolTc8o17I5DbxGHgwjDdelaWrH8vl/
	 kuV9Wo0qgEbkhCqha8x9VLGMIVSIc4Khw4EbtBIA22UpAC/yFONVr2VZsASAfnpu0I
	 dcXPBkoB1dMMYQyM0MX5MSrkauZ6O15TEN8VWm+7ZLzvZfzF528+bsMD8wP/gw//m2
	 ywxBIDwnexfQjxp9Lj++wdsHvHC1itGK99Nf2Lc49E9/qFhS/RtirkaV1kJX8Lm5qr
	 a9LDQNN8mYIPytlJ8erMO26DLQpgzXAF5hTSzXiC1HPz4JP9v7P+24wKg2pcEbe5wz
	 XAQYY05pGaXng==
Date: Sat, 24 Feb 2024 17:07:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ceclan Dumitru <mitrutzceclan@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, linus.walleij@linaro.org,
 brgl@bgdev.pl, andy@kernel.org, linux-gpio@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Walle <michael@walle.cc>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu
 <chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Leonard
 =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>, Mike Looijmans
 <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Ceclan Dumitru <dumitru.ceclan@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 1/3] dt-bindings: adc: add AD7173
Message-ID: <20240224170707.4ffcec19@jic23-huawei>
In-Reply-To: <0fa819d1-2a0f-4243-8e5f-a098528278c3@gmail.com>
References: <20240220094344.17556-1-mitrutzceclan@gmail.com>
	<CAMknhBEZ7Y1Yx=wJGnfvYWGKPLas3pbCyY+sN8vrBzdkYO-A4w@mail.gmail.com>
	<0fa819d1-2a0f-4243-8e5f-a098528278c3@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Feb 2024 10:29:30 +0200
Ceclan Dumitru <mitrutzceclan@gmail.com> wrote:

> On 2/20/24 22:54, David Lechner wrote:
> > On Tue, Feb 20, 2024 at 3:43=E2=80=AFAM Dumitru Ceclan <mitrutzceclan@g=
mail.com> wrote: =20
>=20
> ...
>=20
> >> +  clocks:
> >> +    maxItems: 1
> >> +    description: | =20
> >=20
> > Don't need `|` here.
> >  =20
> The description contains ": ". Without '|' yaml syntax considers the
> whole string before ':' as another attribute
>=20
> >> +      Optional external clock source. Can include one clock source: e=
xternal
> >> +      clock or external crystal.
> >> + =20
>=20
> ...
>=20
> >> +
> >> +      diff-channels:
> >> +        items:
> >> +          minimum: 0
> >> +          maximum: 31
> >> + =20
> >=20
> > Are we missing `bipolar: true` here? (since we have
> > unevaluatedProperties: false)
> >  =20
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
>=20
>=20
> ...
>=20
> >> +
> >> +required:
> >> +  - compatible
> >> +  - reg =20
> >=20
> > Aren't the various power supplies supposed to be required?
> >=20
> > - avdd-supply
> > - avdd2-supply
> > - iovdd-supply =20
>=20
> From my point of view, if someone uses a single supply (avdd =3D=3D avdd2=
 =3D=3D
> iovdd), and uses only the internal reference then the supplies should
> not necessarily be required.

Convention is that anything that represent a voltage on a pin that
is needed for operation should be required.  Key here is the difference
from optional supplies where the driver does something different.
vref is a good example of this. The ones above are always needed I
think.

Obviously they may all say the same thing if they are connected
externally.




