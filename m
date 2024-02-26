Return-Path: <linux-kernel+bounces-82347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C864868315
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93FC28905A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB162131E2B;
	Mon, 26 Feb 2024 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DItVn8Fz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0A2131E44
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983005; cv=none; b=j2Lu7sO6qw5p4yg1DyeZDjm6kuVUgvBqeYrAosc1ZBNwZAyzdDt+K4gEXqVzlNfhGBs1pv5N/MCc6YKpZ6ZL97ZKbzP9k7LLdVQdLkoNgrhKyNkCdZ6C5GgLN9POcXSLB2ncjujl7jPMd/B/a6l8uDs3ZDKhS24TsNtgmKhVVec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983005; c=relaxed/simple;
	bh=zjn4FAEggIcuF3yKsLZHJqmJCdDBGnSpMPbFVggTO3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXeeXoxUxy75/5puuDfDH3zfCnpM9LKJ6TWBIyAk7Iyxy2gl4g5b6xjDGPrTrIGTXlB/4JXrCLhXQa6D93TPuX9Oy5SjRhqDbzPum07l3/poHaJ7xl2iRa+ktnr8Iquloy/U4F503dBLVer3PXnORiyEfMzcpJvfd1LOy0UrZTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DItVn8Fz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51282C433F1;
	Mon, 26 Feb 2024 21:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708983005;
	bh=zjn4FAEggIcuF3yKsLZHJqmJCdDBGnSpMPbFVggTO3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DItVn8FzrzmNOghOMNojZv1uKdkDrHaNOjPUSbdrFyk9RGrqvJpYljlQEb1YwYPHq
	 mGpH26IyFXbI8Ejwq+3VKEB+SjnIE5q5AjBUiUZJaAyphPyM8em7Q2gFdhXvYgoVbm
	 N2nkA1sfeWI1mBHNCq6RE6KW1w8izhS6NmXmiKC6N1yr+MSk08/ARMZOtrnWuKAHZK
	 zaT7ACH/FKu4FjFP1NespKDQ4zFigtHVQVYFI7nxIDDDyZNtD/PewlcCmuGwtYB5Qp
	 8FpRak7ynTOBnnCfgZo3Z6THMS9eQOnlyr7VVOwvXRRaeCaArtf/W6iSrWeBoeAb6Q
	 81IEiB8G9Oskw==
Date: Mon, 26 Feb 2024 21:29:59 +0000
From: Conor Dooley <conor@kernel.org>
To: Charles Lohr <lohr85@gmail.com>
Cc: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH] riscv: deprecate CONFIG_MMU=n
Message-ID: <20240226-jolt-earwig-91c7b0eb868f@spud>
References: <20240226140649.293254-1-cleger@rivosinc.com>
 <40dee2c1-ff24-40b2-a13c-6934139ba869@sifive.com>
 <ea356036-5a0b-47ea-aafb-f9813cc6ec9b@rivosinc.com>
 <20240226-pajamas-okay-51e16426b0f5@spud>
 <CAGu26P_v9FjYq9Bncvfd-dBhdHQevvN3HpO1nqjA2hYFCpG7hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r/gcDu4EFBEr9fnP"
Content-Disposition: inline
In-Reply-To: <CAGu26P_v9FjYq9Bncvfd-dBhdHQevvN3HpO1nqjA2hYFCpG7hg@mail.gmail.com>


--r/gcDu4EFBEr9fnP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 11:00:41AM -0800, Charles Lohr wrote:
> WOAH! Please DO NOT deprecate NOMMU. I use the NOMMU build constantly
> and NOMMU Linux on RISC-V is the avenue used by many FPGA soft cores
> for Linux, as well as some limited systems.
>=20
> I get new copies of the kernel when there are releases and test them
> frequently to make sure everything is still working as expected.

That is great - it is good to know that people are actively testing.
I was aware that a lot of the soft core folks did run nommu kernels (and
I know some do use XIP also) but everything I ever saw was running on
old kernels (5.x).

> On Mon, Feb 26, 2024 at 8:03=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Mon, Feb 26, 2024 at 04:25:24PM +0100, Cl=C3=A9ment L=C3=A9ger wrote:
> > > I guess I could also mark XIP as deprecated.
> >
> > I'm not so sure, people recently added XIP support to QEMU (and sent
> > kernel fixes in December). XIP is also not nearly as much of a problem
> > to support, there's far less that it does differently, the main barrier
> > was the inability to test it which is no longer the case.
> > That said, XIP is gonna kill itself off I feel as it does not support
> > runtime patching and therefore is extremely limited on extensions, given
> > we use alternatives for all of that (although I suppose if someone has a
> > usecase they could make nasty macros worse and implement a compiletime
> > switch in the alternatives too).

> For us we just don't care about XIP. I mean if someone did push it
> through to fruition, I'd also test and use it, but I urge you please
> do not deprecate this.

XIP does work. What I was talking about here was supporting something
"fancier" than rv{32,64}imafdc.

> While it's sometimes needed a bit of a
> creative build to get everything working, I've never needed to patch
> anything in the kernel beyond patching in a custom console for serial
> output.
>=20
> I am happy to discuss the possibility of me and or one of the other
> RISC-V soft (FPGA) core people stepping up to try to be more active,
> but so far we've just been very well serviced by the current NOMMU
> Linux setup.

Most of the issues aren't with nommu actually working, it is the extra
effort in development as it has to be accounted for. I would estimate
that 2/3 of the build issues I report on this list are nommu. The
best thing that you can do to ensure support for things you use is:
a) scream when someone wants to remove it
b) actively let people know you're using it

Seems like you're doing a) but maybe getting someone that provides
Tested-bys whenever you test the releases would be good.

Cheers,
Conor.


--r/gcDu4EFBEr9fnP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd0C1wAKCRB4tDGHoIJi
0u/MAQCeW2ubw3mJ60qwhWI9XYdVEt3d//hBXTomA1zTo7JPogEAjynbFf7kHRRo
t6KM+bwe0KkDGAzlO9lor7hooH2m2A8=
=JHXN
-----END PGP SIGNATURE-----

--r/gcDu4EFBEr9fnP--

