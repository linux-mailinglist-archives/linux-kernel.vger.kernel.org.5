Return-Path: <linux-kernel+bounces-143797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F9E8A3D90
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82A11F212BF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD514CDE7;
	Sat, 13 Apr 2024 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9VaNt4z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4CD482D7;
	Sat, 13 Apr 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713023810; cv=none; b=SReE9wopxCcI5of/R5oHvS9xy3KQh1VadfpT+EOCLSuHDdpzXJ8Mdw5XUDJJ9Vs9Le/SiK+69jnbmfnGXWsne/F60CX8gfqLNyfyzNQ3c2QTzQmeRDr+oB+DNcj2l3L5hzjZRDTEC8s9HftSTcR+KrGl5AN9UbT+7Saq4IgKU4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713023810; c=relaxed/simple;
	bh=Eqn8o/vQ2xD/zqTQkwHC++iNh3PooxhBNtrftfC+J5s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3tixWyvmKZ2RMlEhKHr9IHT4RvumUU0XYkPV2qlEMTNh1k5Tz/J0pNRLGdHZ+bfkkypgfgKv6CVcfeUpa1DzdLwRM4dQwqxD0gY5ossRHjRhJ2M29nysXO3yV6aFdj5VToTrZI+DdUQ9SP/MiQRBeIu1nbrdDScPgntgLTXPmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9VaNt4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EF3C113CE;
	Sat, 13 Apr 2024 15:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713023810;
	bh=Eqn8o/vQ2xD/zqTQkwHC++iNh3PooxhBNtrftfC+J5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t9VaNt4z8a4ZX4PXDsL4J68nc8hmUkGHSkkoO82ambhCahfQAx8d2CPPzzkMDZOuc
	 S7nC76zVY7lsUvIeWeXGDLn321EA9DwSsgKDnK06amybws3NaOEFxhNmQqqYpdhJ4Q
	 2ZVAlhCkorRuuJqrazvw2zeFDgmI5y2XVx2IL1kJ6jdEoYbhyqMCpwff6h2hFa6QoF
	 cwQxDmgkc6vEJogu/O2ZfTZBifHjiYW5O2EKDnXS3EkGd1H+6rpq7SXquNfV9TAeHX
	 7cYWVFVUqh0XK7aId+wGa6Jv97teuBzGwVid+UWkbxSmyUKQgilSuXt5U+fwY5VDKp
	 mIiXpo3zw9wiQ==
Date: Sat, 13 Apr 2024 16:56:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Markus Burri <markus.burri@mt.com>, linux-kernel@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org, Nuno Sa
 <nuno.sa@analog.com>
Subject: Re: [PATCH v1] iio: adc: ad_sigma_delta: Clear pending interrupts
 before enable
Message-ID: <20240413165636.4fa8eb60@jic23-huawei>
In-Reply-To: <b6c6700d924916dd09afd2878321a7c87b8e922d.camel@gmail.com>
References: <20240404175126.110208-1-markus.burri@mt.com>
	<20240406171728.16170b48@jic23-huawei>
	<b6c6700d924916dd09afd2878321a7c87b8e922d.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 08 Apr 2024 10:31:21 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sat, 2024-04-06 at 17:17 +0100, Jonathan Cameron wrote:
> > On Thu,=C2=A0 4 Apr 2024 19:51:26 +0200
> > Markus Burri <markus.burri@mt.com> wrote:
> >=20
> > Hi Markus,
> >=20
> >  =20
> > > For device will enable and disable irq contiously like AD7195,
> > > it use DOUT/RDY pin for both SPI transfer and data ready.
> > > It will disable irq during SPI transfer, and re-eanble irq after SPI
> > > transfer.
> > > That may cause irq status bit set to 1 during spi transfer. =20
> >=20
> > Superficially that sounds like it might be an irq driver bug to me...
> > Or just possibly an irq chip doing lazy disabling? =20
>=20
> Yes, this sounds odd as we are already explicitly disabling lazy disablin=
g:
>=20
> https://elixir.bootlin.com/linux/latest/source/drivers/iio/adc/ad_sigma_d=
elta.c#L589

Markus, can you confirm you are running no a kernel with that line present?
Maybe this is just an old kernel not having the fix?

>=20
> >  =20
> > >=20
> > > When the active condition has been detected, the corresponding bit
> > > remains set until cleared by software. Status flags are cleared
> > > by writing a 1 to the corresponding bit position.
> > >=20
> > > Signed-off-by: Markus Burri <markus.burri@mt.com> =20
> >=20
> > I'll need an appropriate ADI ack for this one.
> >  =20
>=20
> Yeah, I wanted to reply to this one Friday but then completely forgot. I =
can't
> really ack this one. I would need some insights from someone with more co=
re IRQ
> knowledge. But...
>=20
> > It seems highly unusual to be calling a generic irqchip related functio=
n in a
> > driver (there are no other such users).=C2=A0 So this seems unlikely to=
 be
> > the right fix for this particular problem.
> >  =20
>=20
> Yes, and this (I think) would not even fix (if a fix is needed) this for =
all
> irqchips which to me already sounds not the way to go.
>=20
> - Nuno S=C3=A1
> >  =20


