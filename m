Return-Path: <linux-kernel+bounces-156771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7F38B07F1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095641F23A82
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148FF15A481;
	Wed, 24 Apr 2024 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TghPvxAu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EA2159903
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713956497; cv=none; b=BXZ+zp6Mn6c8TseGcYLlT9KIogPE4LQyZ2e7Ktyeyof7YxkCQpxV7PYMl+X1gUN8FYrp3s/5WMHJPFf+i1xkApeWx57y2KiUuYSKO1IE8DVa18v3ct15kPdSk73Hv8wQUu69Lb9gwRRsRT8rjQLygXWQFMqrAtDy1Nq7GQErieU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713956497; c=relaxed/simple;
	bh=Y8jauGU3H3pOStMZXtgLIEEBN0hMmdEL/BE2y9DDKbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlaRsAvEB0FLCSzI7FQC1HKbCvf6ErOgwrW30/20VR70vPeWXxCEVfrYQmyeEZV6uKyQrjSGb5ULzbgAt0ThYVlNwMWGJ0FGMGUw5G4OfnSjnClz6e3rLc0G9U18ATUmn1HSNTbZr1k5Yp/7qobkWyfrKuieXgnY+rQyr8lj0Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TghPvxAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD79C113CE;
	Wed, 24 Apr 2024 11:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713956496;
	bh=Y8jauGU3H3pOStMZXtgLIEEBN0hMmdEL/BE2y9DDKbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TghPvxAunIE5BH1bdxf67i9THqqTIfuap3goT7PqxxbcxZL+BeMotTFeFwBKZ8T7s
	 GEmDRNOUuTJ42au0O8UezKWsMfx/SWmdZAPo03sgnjOAuFvdpnHAzw9pPVN+nEvuhg
	 SzUp0p9j1oUQHvIw260ICdQZC0Jlp46SUortUgdNW4cteqXyPTrm6eVAsYenmt+wlq
	 JtFvfTmFjdMXKZZWPdRTS4zteiRhcWKBrT6c1f1oOxkHTUmxbij90+2Aume5mmzu84
	 x0DW5nk58N6siOEXRZ/UR5D1k4nN7mcsu+cJyLURc03zbQTq7zjzJf1zEUTWAoK41z
	 xHKeu50hqtWXw==
Date: Wed, 24 Apr 2024 12:01:33 +0100
From: Conor Dooley <conor@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] clocksource/drivers/timer-clint: Add option to
 use CSR instead of mtime
Message-ID: <20240424-ivory-undefined-0c96bd289c36@spud>
References: <20240406112159.1634-1-jszhang@kernel.org>
 <20240406112159.1634-3-jszhang@kernel.org>
 <20240409-krypton-employed-b2e0e1b46ddf@spud>
 <ZhVVPB0qD4pBna51@xhacker>
 <ZhZqNbbUyPhVzekO@xhacker>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h1r6PhpT3M2gVcJm"
Content-Disposition: inline
In-Reply-To: <ZhZqNbbUyPhVzekO@xhacker>


--h1r6PhpT3M2gVcJm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 06:30:13PM +0800, Jisheng Zhang wrote:
> On Tue, Apr 09, 2024 at 10:48:33PM +0800, Jisheng Zhang wrote:
> > On Tue, Apr 09, 2024 at 03:26:18PM +0100, Conor Dooley wrote:
> > > On Sat, Apr 06, 2024 at 07:21:58PM +0800, Jisheng Zhang wrote:
> > > > As pointed out by commit ca7810aecdba ("lib: utils/timer: mtimer: a=
dd a
> > > > quirk for lacking mtime register") of opensbi:
> > > >=20
> > > > "T-Head developers surely have a different understanding of time CS=
R and
> > > > CLINT's mtime register with SiFive ones, that they did not implement
> > > > the mtime register at all -- as shown in openC906 source code, their
> > > > time CSR value is just exposed at the top of their processor IP blo=
ck
> > > > and expects an external continous counter, which makes it not
> > > > overrideable, and thus mtime register is not implemented, even not =
for
> > > > reading. However, if CLINTEE is not enabled in T-Head's MXSTATUS
> > > > extended CSR, these systems still rely on the mtimecmp registers to
> > > > generate timer interrupts. This makes it necessary to implement T-H=
ead
> > > > C9xx CLINT support in OpenSBI MTIMER driver, which skips implementi=
ng
> > > > reading mtime register and falls back to default code that reads ti=
me
> > > > CSR."
> > > >=20
> > > > To use the clint in RISCV-M NOMMU env on Milkv Duo little core, we
> > > > need to fall back to read time CSR instead of mtime register. Add t=
he
> > > > option for this purpose.
> > > >=20
> > > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > >=20
> > > > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kcon=
fig
> > > > index 34faa0320ece..7bbdbf2f96a8 100644
> > > > --- a/drivers/clocksource/Kconfig
> > > > +++ b/drivers/clocksource/Kconfig
> > > > @@ -650,6 +650,15 @@ config CLINT_TIMER
> > > >  	  This option enables the CLINT timer for RISC-V systems.  The CL=
INT
> > > >  	  driver is usually used for NoMMU RISC-V systems.
> > > > =20
> > > > +config CLINT_USE_CSR_INSTEADOF_MTIME
> > > > +	bool "Use TIME CSR instead of the mtime register"
> > > > +	depends on CLINT_TIMER
> > > > +	help
> > > > +	  Use TIME CSR instead of mtime register. Enable this option if
> > > > +	  prefer TIME CSR over MTIME register, or if the implementation
> > > > +	  doesn't implement the mtime register in CLINT, so fall back on
> > > > +	  TIME CSR.
> > >=20
> > > This, as a Kconfig option, seems a bit strange to me. We know at runt=
ime
> > > if we are on a T-Head device without the mtime register and should be
> > > able decide to use the CSR implementation dynamically in that case,
> > > right?
> >=20
> > Dynamically decision can be done in clocksource/clockevnt:
> > I can patch clint_clocksource.read to point to different clint_rdtime()
> > implementation.
> >=20
> > But clint timer is also used in NOMMU RISCV-M's get_cycles(), this
> > can't be dynamically chosen w/o an ugly "if (is_c900)"
> > check, and I'm not sure whether this check in get_cycles() will
> > introduce non-trival overhead or not. Or use code patching technology
> > here?
>=20
> Hi,
>=20
> After some tests, I think will go with code patching path, I.E use
> static_branch in get_cycles(). New version is under cooking.

Whoops, sorry for the delay getting back to you - been busier than I
would like of late. Patching sounds good to me if your testing went
well.

--h1r6PhpT3M2gVcJm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZijmjAAKCRB4tDGHoIJi
0lW7AP9ELlOwlUcv5ji1DJE0FSqDfjyy0OOh7tUjreEqkrMykgEA298NQRO9jsRF
Eqs54vfBUEEhkTfzEU9Wf+8F7mdOSwU=
=99xV
-----END PGP SIGNATURE-----

--h1r6PhpT3M2gVcJm--

