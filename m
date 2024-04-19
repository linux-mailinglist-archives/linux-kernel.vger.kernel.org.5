Return-Path: <linux-kernel+bounces-151351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2A38AAD50
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7901F1F21F7C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A8080029;
	Fri, 19 Apr 2024 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOJiKRH/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597E3537FC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713524830; cv=none; b=XsKQoPCbKasJ8JB+kC27vaTlNIlSV7sDsjmboDzWYxGsUo0cvG/mlYHCBNknpzbwUvMRO3+F3m56vgLOlAADy1kr75ZmNWvaqfltbRBjsBXtfZTBt8ps7h2nVz9MWVhjuPIrlBxmz2xJPY4YCQ+qpBEFCQlGhheA3EKg2m7IPuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713524830; c=relaxed/simple;
	bh=mSXR23jlHV5BHfSPWs++D8AqjLUnBZW6KvQt4xvDWn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xmew7o6KC0NmLKW9z9U2TYx/2WimhzYJBkKK3sxPMV7kSIDJLrh6QhN2S6ZeFdPtXwoeWoCrrUByxZOPGobHRriuuI4Z7gWAt/gp1iVXV2wIFVD8f0YGfyq8F/Ksh7O98mwwHTMd0QCiU1JRoP5r/oFmmqvQ2klXZeS26kjkIS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOJiKRH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F72C072AA;
	Fri, 19 Apr 2024 11:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713524829;
	bh=mSXR23jlHV5BHfSPWs++D8AqjLUnBZW6KvQt4xvDWn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BOJiKRH/i1llOBMc2CMgBDL3F3E/3VccV26cTv1L6cZFWS1mAsts0JddOoI8RtZJ/
	 sFvJ8WAMS62lPPwqJPfXeiIs1B2uDfRZ0aUi6NIF194jTM4e62zjho7c08+ogwB9nP
	 3rwG02HkzCiWv4icSHaTCSg5v8DFarZSz6xIG8YdrTDxgSrxdZCYvSyYpJ/k4zx0AB
	 dEIDMCp3o3SuO1QXCbrm73nAbabvTHZ5l7GSQxUbWYk1HNqOMLLGJ15CBcIEhu1apr
	 KHc8F9HpJx5aicTAnc7MvjJWrNS4KQ5QGaTgUpxwniej0/XCP+1CNeez4SZSr44gKC
	 5YkLwbpYH5mnA==
Date: Fri, 19 Apr 2024 12:06:59 +0100
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
Message-ID: <20240419-excretory-dwarf-ba817cc725ea@spud>
References: <20240418-stable-railway-7cce07e1e440@spud>
 <20240419-ea2b867f6bde90e711464c95@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xXxXh+HAbGw7IqI4"
Content-Disposition: inline
In-Reply-To: <20240419-ea2b867f6bde90e711464c95@orel>


--xXxXh+HAbGw7IqI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 01:01:52PM +0200, Andrew Jones wrote:
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 6d64888134ba..c3a7793b0a7c 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -503,8 +503,8 @@ config RISCV_ISA_SVNAPOT
> >  	depends on RISCV_ALTERNATIVE
> >  	default y
> >  	help
> > -	  Allow kernel to detect the Svnapot ISA-extension dynamically at boot
> > -	  time and enable its usage.
> > +	  Add support for the Svnapot ISA-extension when it is detected by
> > +	  the kernel at boot.
>=20
> I'm not sure we need the 'by the kernel', since I guess that's implied by
> being in a Kconfig help text, but either way is fine by me.

I think we do, given some of the options are required for userspace to
use it and others are not. Distinguishing between them doesn't cos us
more than a few characters so I think it is worthwhile.


> > @@ -686,7 +687,8 @@ config FPU
> >  	default y
> >  	help
> >  	  Say N here if you want to disable all floating-point related proced=
ure
> > -	  in the kernel.
> > +	  in the kernel. Without this option enabled, neither the kernel nor
> > +	  userspace may use floating-point procedures.
> > =20
> >  	  If you don't know what to do here, say Y.
> >
>=20
> Zicboz could also use some clarification, right? Or is the fact that
> RISCV_ISA_ZICBOZ enables the use in both the kernel and userspace the
> reason "Enable the use of the Zicboz extension (cbo.zero instruction)
> when available." looks sufficient? Maybe Zicboz should follow the
> "Say N here if..." pattern of V and FPU?

Yeah, I think I just overlooked Zicboz. If the kernel option is needed
for userspace to use it then yeah, it should follow the same wording as
V/FPU.

--xXxXh+HAbGw7IqI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiJQUwAKCRB4tDGHoIJi
0rtbAP9iMXxB8DrBGngeQXmuQC3Wu502D171FBM8vEvzq+o1VQD7BWq3wCFfhv3g
/BYUFiY+cP49HKDaH0fQQzqtPLw5IQ0=
=xrDK
-----END PGP SIGNATURE-----

--xXxXh+HAbGw7IqI4--

