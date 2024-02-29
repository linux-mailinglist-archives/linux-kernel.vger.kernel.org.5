Return-Path: <linux-kernel+bounces-86864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE4B86CBE7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F32FB2205A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D769D137760;
	Thu, 29 Feb 2024 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6fF6Hks"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EF513774E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709218065; cv=none; b=QxCCMP3rMBAoTCsCEA/an5lPjT3opffw2R6mmAELHJPoCiR+4MHYAS0e3+5jcoOwVtPX/BT/zyAcHcrXjaIvl8vEMr1fuvmYfJrlXi/NFi7Qa4QNryRSpm39YmXnJsr2KqRph9VUAaQJ7mOijcg64pTgTS3LMfX2aSkGrOGuJAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709218065; c=relaxed/simple;
	bh=jh4m+J4zq3Gu+gnq/+2As4uXbPdMVPKk+9KMHCLN9zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fo32E1SPPy2itfm5LzGj9jLSmBTIuMPei8FEAAlP0VNiWO5SkHWL4QPzrtzmM4zBpiyPGzdryQdJ2MPXmt1VyXDlNq/C0T6hJ2f12lw2ZOdfCbKSQ+PqRw6HowHspiIfCUsjoCs66DawQDtBE9//ebnDmClqo1RvpopBT2UAhUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6fF6Hks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC8AC433F1;
	Thu, 29 Feb 2024 14:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709218064;
	bh=jh4m+J4zq3Gu+gnq/+2As4uXbPdMVPKk+9KMHCLN9zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j6fF6HksNrTtgooDxky8LzQyR6jZlbe/EdbD3aH6D6I7XV4bb9Sv9zPhTPjka6vof
	 CiSLDXBq8dHl/RLR5o6+My7r9cPIOSt7GcwEUwHRCgWgjLzueBEuUc3dd18Q5Xbtap
	 xGNPlkm3HUApv9sz/yFFZ43TU/yVrivoLd+vqZnFdEY9twKJg6iMeJyqMvkJgy/6Ag
	 T9yK+Q2XHTE+zaC8RL7jPf1qREopuyGsQa9am6UesgWWx7oi+fyUFo1NVgAAkBm5j2
	 jHO/CoVTJ/ZhAi1jxEymKIW94KRytmGa3p4POWy77HnxQg7SEwImA+VSW6ICsUXYIl
	 DJ0EDqQK5rGCQ==
Date: Thu, 29 Feb 2024 14:47:39 +0000
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Charles Lohr <lohr85@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] riscv: Set unaligned access speed at compile time
Message-ID: <20240229-ship-frail-52cd06745fc2@spud>
References: <20240227-disable_misaligned_probe_config-v5-0-b6853846e27a@rivosinc.com>
 <20240227-disable_misaligned_probe_config-v5-2-b6853846e27a@rivosinc.com>
 <20240228-denote-subscribe-9832cddbd307@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g9ScbAqWRYzLUy4l"
Content-Disposition: inline
In-Reply-To: <20240228-denote-subscribe-9832cddbd307@spud>


--g9ScbAqWRYzLUy4l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Clement,

On Wed, Feb 28, 2024 at 10:43:20AM +0000, Conor Dooley wrote:
> > @@ -413,7 +411,9 @@ int handle_misaligned_load(struct pt_regs *regs)
> > =20
> >  	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
> > =20
> > +#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>=20
> if (IS_ENABLED()), no?
> But perhaps more interestingly - why is this being set here at all?
> My understanding of the emulated stuff was that if the in-kernel
> emulation was enabled, it would be used unless the CPU itself supported
> fast accesses.

> I would expect this to be advertised to userspace once
> the system has booted, not set the first time that a cpu emulates an
> access,
> I feel like I need to take a look at how this has been implemented, I
> never really looked too closely at it and how it is enabled does not
> match my expectations.

I did look at this more closely and I understand why this is being done.
In the vast majority of situations I think it is going to work perfectly
fine, since that first access is going to be during the boot time
probing.
=2E
> >  	*this_cpu_ptr(&misaligned_access_speed) =3D RISCV_HWPROBE_MISALIGNED_=
EMULATED;
> > +#endif
> > =20
> >  	if (!unaligned_enabled)
> >  		return -1;

This is in the diff, so I am commenting here. Firstly, why does this
return -1 and not a regular negative errno?

Secondly, this looks pretty suspect to me - if the sysctl is used to
disable the emulation things like hwprobe will still report that access
is emulated if during boot it was enabled.
I think that if this condition is hit, we actually need to change the
per-cpu variable to set the alignment to unsupported, given the
emulation will (at present & if my understanding is correct) only be
enabled when there's not underlying support for unaligned accesses.

Thoughts?

Cheers,
Conor.

--g9ScbAqWRYzLUy4l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeCY9QAKCRB4tDGHoIJi
0iavAQCKIPyb10Y8b3+7ZYXeg6e+2o/56nXBEM1MzBoN3u1bqgEAgblW8u6KNYrj
CdDilNguaeoiA2W9aHSsGlJRULWc7Qg=
=V4Ha
-----END PGP SIGNATURE-----

--g9ScbAqWRYzLUy4l--

