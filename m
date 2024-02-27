Return-Path: <linux-kernel+bounces-83859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72815869F69
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6D8283FDD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B04C50A73;
	Tue, 27 Feb 2024 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQfCeqYa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D0F50271
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709059739; cv=none; b=F1YWe6Axx11h2u1+qiR4+xnQkrOkHNKKr0JgPBVNJN79ehHCDh+/2UJWHBgXPuic9G1TvvqqWJflBYyNWdYeFWs5DzXC5WN/GdvBaIJKnc4/Yj09onoLdtCF3JHSLH+dSOXGTGcJwQ/DuXe46iMEanEN+QcONsPhoqfofMdndqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709059739; c=relaxed/simple;
	bh=3bZUA0mL+b5Ms2RdOItLD/BcXnPrmdEm8B0J9fdbpro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmIv6SKT4uF9zCnBxKRnBAUpcWzpxbj1yQXo96voo7UZDVHe3KUhss4p+jFfT9dzPEL5CHzwb7sas3AZiFqow1yPeDc6vlXjpVXqQL6r7HJOIZlcwHly6iBixkb6P0TlmZu4dLUzRBPbfczG2brS+2L20PpymYNpwN6d2AHiHPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQfCeqYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A742C433C7;
	Tue, 27 Feb 2024 18:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709059739;
	bh=3bZUA0mL+b5Ms2RdOItLD/BcXnPrmdEm8B0J9fdbpro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tQfCeqYal5q1ALky8inZXZXX8AxgIO96wdUR0M2z3O0ev720Vtt8aoVETZ6CZS+h8
	 sxnDorXrg+c4E3Mzp2KVs8Deu6OHA0Xzzm2Vo//3oCNDovwj7NMXp5t5kDShnrb/uh
	 RomFQQ4oiW1kumVYVHVEKlgUqxkxnQ2f91bdhNbdPpS9epECSpRjZcjYvCmDKA5DOl
	 xLNQhaMDwFpx9Bd5SiQR2FRroM6jYcOQMVU6zUybdX20+qLYI0+DjfCx7ayFta6iZq
	 0CFXb/A59MtJRRLjXjq8lB08vtaSUN7khXLuneo1/efVjlzh9duveIFJtjhSxZmZ0T
	 IxbE33UdY6+cw==
Date: Tue, 27 Feb 2024 18:48:54 +0000
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>, Evan Green <evan@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	linux-riscv@lists.infradead.org, Charles Lohr <lohr85@gmail.com>
Subject: Re: [PATCH v4 2/2] riscv: Set unalignment speed at compile time
Message-ID: <20240227-citable-scanning-1fd48c96b758@spud>
References: <20240216-disable_misaligned_probe_config-v4-0-dc01e581c0ac@rivosinc.com>
 <20240216-disable_misaligned_probe_config-v4-2-dc01e581c0ac@rivosinc.com>
 <20240227-condone-impeach-9469dffc6b47@wendy>
 <Zd4nMa+x28omuhiF@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="A7lTG7rB6ssaDl7T"
Content-Disposition: inline
In-Reply-To: <Zd4nMa+x28omuhiF@ghost>


--A7lTG7rB6ssaDl7T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 10:17:21AM -0800, Charlie Jenkins wrote:
> On Tue, Feb 27, 2024 at 11:39:25AM +0000, Conor Dooley wrote:
> > On Fri, Feb 16, 2024 at 12:33:19PM -0800, Charlie Jenkins wrote:

> > > +config RISCV_EMULATED_UNALIGNED_ACCESS
> > > +	bool "Assume the CPU expects emulated unaligned memory accesses"
> > > +	depends on NONPORTABLE
> >=20
> > This is portable too, right?
>=20
> I guess so? I think I would prefer to have the probing being the only
> portable option.

I dunno, I think there could be value to someone in always emulating
this in the kernel and I don't think that should relegate them to the
naughty step, given it can work everywhere.


> > > +config RISCV_SLOW_UNALIGNED_ACCESS
> > > +	bool "Assume the CPU supports slow unaligned memory accesses"
> > > +	depends on NONPORTABLE
> > > +	help
> > > +	  Assume that the CPU supports slow unaligned memory accesses. When
> > > +	  enabled, this option improves the performance of the kernel on su=
ch
> > > +	  CPUs.
> >=20
> > Does it? Are you sure that generating unaligned accesses on systems
> > where they are slow is a performance increase?
> > That said, I don't really see this option actually doing anything other
> > than setting the value for hwprobe, so I don't actually know what the
> > effect of this option actually is on the kernel's performance.
> >=20
> > Generally I would like to suggest a change from "CPU" to "system" here,
> > since the slow cases that exist are mostly because the unaligned access
> > is actually emulated in firmware.
>=20
> It would be ideal if "emulated" was used for any case of emulated
> accesses (firmware or in the kernel).  Doing emulated accesses will be
> orders of magnitude slower than a processor that "slowly" handles the
> accesses.
>=20
> So even if the processor performs a "slow" access, it could still be
> beneficial for the kernel to do the misaligned access rather than manual
> do the alignment.

Right. But, at least from a probing perspective, SLOW is what gets
selected when firmware emulates the unaligned access so to userspace
seeing slow means that the performance could be horrifically bad:

|     rzfive:
|         cpu0: Ratio of byte access time to unaligned word access is
| 1.05, unaligned accesses are fast
|=20
|     icicle:
|=20
|         cpu1: Ratio of byte access time to unaligned word access is
| 0.00, unaligned accesses are slow
|         cpu2: Ratio of byte access time to unaligned word access is
| 0.00, unaligned accesses are slow
|         cpu3: Ratio of byte access time to unaligned word access is
| 0.00, unaligned accesses are slow
|=20
|         cpu0: Ratio of byte access time to unaligned word access is
| 0.00, unaligned accesses are slow
|=20
|     k210:
|=20
|         cpu1: Ratio of byte access time to unaligned word access is
| 0.02, unaligned accesses are slow
|         cpu0: Ratio of byte access time to unaligned word access is
| 0.02, unaligned accesses are slow
|=20
|     starlight:
|=20
|         cpu1: Ratio of byte access time to unaligned word access is
| 0.01, unaligned accesses are slow
|         cpu0: Ratio of byte access time to unaligned word access is
| 0.02, unaligned accesses are slow
|=20
|     vexriscv/orangecrab:
|=20
|         cpu0: Ratio of byte access time to unaligned word access is
| 0.00, unaligned accesses are slow
 https://lore.kernel.org/all/CAMuHMdVtXGjP8VFMiv-7OMFz1XvfU1cz=3DFw4jL3fcp4=
wO1etzQ@mail.gmail.com/

> Currently there is no place that takes into account this "slow" option
> but I wanted to leave it open for future optimizations.

I don't think you can really do much optimisation if you detect that it
is slow, and since this option is analogous to detecting slow I dunno if
you can do anything here either? This option really just seems to me to
mean "don't do any optimisations for unaligned being fast but also don't
emulate it in the kernel".

> > > However, the kernel will run much more slowly, or will not be
> > > +	  able to run at all, on CPUs that do not support unaligned memory
> > > +	  accesses.
> > > +
> > >  config RISCV_EFFICIENT_UNALIGNED_ACCESS
> > >  	bool "Assume the CPU supports fast unaligned memory accesses"
> > >  	depends on NONPORTABLE
> > >  	select DCACHE_WORD_ACCESS if MMU
> > >  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
> > >  	help
> > > -	  Say Y here if you want the kernel to assume that the CPU supports
> > > -	  efficient unaligned memory accesses.  When enabled, this option
> > > -	  improves the performance of the kernel on such CPUs.  However, the
> > > -	  kernel will run much more slowly, or will not be able to run at a=
ll,
> > > -	  on CPUs that do not support efficient unaligned memory accesses.
> > > +	  Assume that the CPU supports fast unaligned memory accesses. When
> > > +	  enabled, this option improves the performance of the kernel on su=
ch
> > > +	  CPUs.  However, the kernel will run much more slowly, or will not=
 be
> > > +	  able to run at all, on CPUs that do not support efficient unalign=
ed
> > > +	  memory accesses.
> > > +
> > > +config RISCV_UNSUPPORTED_UNALIGNED_ACCESS
> >=20
> > This option needs to be removed. The uabi states that unaligned access
> > is supported in userspace, if the cpu or firmware does not implement
> > unaligned access then the kernel must emulate it.
>=20
> Should it removed from hwprobe as well then?

No, I actually suggested that it be documented etc. Originally
"UNSUPPORTED" was "UNKNOWN" and nothing more than the default value but
I suggested that it be documented since that would allow a system that
did not have the same uabi problem to use all the same defines.
Technically it is possible for unaligned access to be unsupported, if
you have a kernel that does not have the emulator but does have the
hwprobe stuff supported. I think there was about a 6 month period where
this was the case, so combine that with firmware that does not do the
emulation and unaligned accesses are unsupported.

Cheers,
Conor.

--A7lTG7rB6ssaDl7T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd4ulgAKCRB4tDGHoIJi
0kuJAP9MYXtRJnS8kVEPM3J3GBXPiW1BrtrqVqpMeqaykH3O9AEAp8BCDPdp8oIV
kh1+j1M36s5fTlWCuPBx975g86gHVwk=
=Gp5I
-----END PGP SIGNATURE-----

--A7lTG7rB6ssaDl7T--

