Return-Path: <linux-kernel+bounces-151647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 672028AB188
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF751C229A1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12E312F586;
	Fri, 19 Apr 2024 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gnw9arBD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F7112F376
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539841; cv=none; b=TQ1Jtg/qXEHSgtsdrTpynzp3B5c4S4DKIyka8whiTWp9AL57r+IfOhIP2AjAfB0B3h7tq6DsiE8RDw0FQg0FxuQ3EQmzbQxLlsjhCRCYCaWAO5j8qreM/hMWqFV5g013aHQYwEYKT+aSBxxxLzw6JMA+gxblRVWpHJG0shIESvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539841; c=relaxed/simple;
	bh=SnnWaQWmaH4Y1VcI2/IotnKQLBlBuYV8WwApJhdtqlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=au8qLNaCs+uFr0e3KK+4gYHJLg/lC3vPlX1xwWiKRYqo3RP/FMVpK9wT3n8UraZFQlxWVZSZTCAR07l0xDsq0qrgM3pKRyWZjtLJzEL3Qp1R/YWvjbgdul5+9vLIV30abcSpXM3QFYzzOGxcsln9xMLAMbMW99Xd7n9tYa9+hiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gnw9arBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C9AC072AA;
	Fri, 19 Apr 2024 15:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713539840;
	bh=SnnWaQWmaH4Y1VcI2/IotnKQLBlBuYV8WwApJhdtqlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gnw9arBDC1Ax9q3qDwIFKZPM7ohNDDCmNKcEpQhpKM9noHzBL7xpGSlnA9IvzjkCu
	 b1GhvfQUEzuCO3tg/BHf4/nTJJHa1fNuUlwQHYNKbHwXqpN6YRztnuKt/A8gGItRGt
	 WP+kABU8cjBW3PujW3pfRqt66K4ML2tSW4bnXIkhnBQbsl1AI5by2qnTXa85cPYq+G
	 iKCHgYZBtqr+UjEJSfOoX0qxAkIwDC1klRDewFBoU2PVngUIIxJC/rTp5A88rz9KXA
	 VrWmuCDeqhuwtEl+hmbiaqy/4gHmEnUJp7cC/gJilF1cp/RWKSDUlsz/SOPKiI7Vea
	 RqJwdHIIaLuLg==
Date: Fri, 19 Apr 2024 16:17:10 +0100
From: Conor Dooley <conor@kernel.org>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Pu Lehui <pulehui@huaweicloud.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] RISC-V: clarify what some RISCV_ISA* config options do
Message-ID: <20240419-recount-blip-29e45e4d4cec@spud>
References: <20240418-stable-railway-7cce07e1e440@spud>
 <20240419-ea2b867f6bde90e711464c95@orel>
 <20240419-excretory-dwarf-ba817cc725ea@spud>
 <20240419-b5dbe7b133a749afdc0af416@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FX/POwus9dap633f"
Content-Disposition: inline
In-Reply-To: <20240419-b5dbe7b133a749afdc0af416@orel>


--FX/POwus9dap633f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 04:05:34PM +0200, Andrew Jones wrote:
> On Fri, Apr 19, 2024 at 12:06:59PM +0100, Conor Dooley wrote:
> > On Fri, Apr 19, 2024 at 01:01:52PM +0200, Andrew Jones wrote:
> > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > index 6d64888134ba..c3a7793b0a7c 100644
> > > > --- a/arch/riscv/Kconfig
> > > > +++ b/arch/riscv/Kconfig
> > > > @@ -503,8 +503,8 @@ config RISCV_ISA_SVNAPOT
> > > >  	depends on RISCV_ALTERNATIVE
> > > >  	default y
> > > >  	help
> > > > -	  Allow kernel to detect the Svnapot ISA-extension dynamically at=
 boot
> > > > -	  time and enable its usage.
> > > > +	  Add support for the Svnapot ISA-extension when it is detected by
> > > > +	  the kernel at boot.
> > >=20
> > > I'm not sure we need the 'by the kernel', since I guess that's implie=
d by
> > > being in a Kconfig help text, but either way is fine by me.
> >=20
> > I think we do, given some of the options are required for userspace to
> > use it and others are not. Distinguishing between them doesn't cos us
> > more than a few characters so I think it is worthwhile.
>=20
> I agree we should ensure 'support in the kernel' type of text is present,
> but here we're saying 'detected by the kernel' which I was thinking was
> implied since this is kernel code. Maybe we should just add the 'the
> kernel' text to where the support is rather than where the detection is?

Sure, that makes sense to me. We could go for "Say y here to add support
for the Foobar ISA extension for foobarisation in the kernel when it is
detected at boot" and in the cases where userspace depends on the option
too we could additionally say "When this option is disabled, neither the
kernel nor userspace may use Foobar". So Svnapot could become

	  Say y here to add support for the Svnapot (Naturally Aligned Power of
	  Two Pages) ISA extension in the kernel when it is detected at boot.

	  The Svnapot extension is used to mark contiguous PTEs as a range
	  of contiguous virtual-to-physical translations for a naturally
	  aligned power-of-2 (NAPOT) granularity larger than the base 4KB page
	  size. When HUGETLBFS is also selected this option unconditionally
	  allocates some memory for each NAPOT page size supported by the kernel.
	  When optimizing for low memory consumption and for platforms without
	  the Svnapot extension, it may be better to say N here.


And vector would be

	  Say y here to add support for the Vector extension when it is
	  detected at boot. When this option is disabled, neither the
	  kernel nor userspace may use vector.

	  If you don't know what to do here, say Y.

The other thing is the "Say y here" stuff. I find it to be a little
weird to be honest - these are all default enable I don't think "Say y"
makes sense, but writing inverted descriptions feels wrong. Maybe the
solution is just s/Say y here to a/A/, which many of these extensions
already do?

> I assumed it was left off of the 'Add support' because Svnapot is for
> S-mode.

So part of my rationale for being over-eager in re-wording is that I
know people just copy-paste these config options and it's easy to miss.

>=20
> >=20
> >=20
> > > > @@ -686,7 +687,8 @@ config FPU
> > > >  	default y
> > > >  	help
> > > >  	  Say N here if you want to disable all floating-point related pr=
ocedure
> > > > -	  in the kernel.
> > > > +	  in the kernel. Without this option enabled, neither the kernel =
nor
> > > > +	  userspace may use floating-point procedures.
> > > > =20
> > > >  	  If you don't know what to do here, say Y.
> > > >
> > >=20
> > > Zicboz could also use some clarification, right? Or is the fact that
> > > RISCV_ISA_ZICBOZ enables the use in both the kernel and userspace the
> > > reason "Enable the use of the Zicboz extension (cbo.zero instruction)
> > > when available." looks sufficient? Maybe Zicboz should follow the
> > > "Say N here if..." pattern of V and FPU?
> >=20
> > Yeah, I think I just overlooked Zicboz. If the kernel option is needed
> > for userspace to use it then yeah, it should follow the same wording as
> > V/FPU.
>=20
> Actually, never mind. I was thinking we only set the envcfg when this
> config was selected, but that's not true. We'll set it whenever the
> extension is present with or without this config. So I guess it can
> follow Zicbom's pattern.

I'm regretting trying to change these options sorta minimially -
Zicbom's
	   Add support for the Zicbom extension (Cache Block Management
	   Operations) and enable its use in the kernel when it is detected
	   at boot.
is better worded than the Svnapot one purely cos of what it looked like
before the patch. I think for v2 I'll re-write them all to look pretty
similar in terms of their opening paragraph.

--FX/POwus9dap633f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiKK9gAKCRB4tDGHoIJi
0pKdAQCtBkg+TOzWadLEO2l5cjF4wenvVWIAKOTb3pKMsegkGAD9GPIjBrjSwOG8
cmbH1NA9NhtkHkirOf+tGRwod+W+yw0=
=Izji
-----END PGP SIGNATURE-----

--FX/POwus9dap633f--

