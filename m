Return-Path: <linux-kernel+bounces-30299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269F7831CCA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8246BB22C41
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D3228DA4;
	Thu, 18 Jan 2024 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpYiSM7L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DFD2554A;
	Thu, 18 Jan 2024 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705592968; cv=none; b=SsCfAYVWNfvVTcOtIZRHSMc31CW9c63So+Z9TRbuy1p5snGdy/aCUWFMOF96SrCO8DXd/n/W16ScZnPqU/biWTY0JNqE2dDom82euX3uoJ6Fd4q0AgsDH0Wt9vpe4XUYi35pn3Vjkm+Y5dmnMvSz3vNmcmlI1CX9wMcPODQ0ZiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705592968; c=relaxed/simple;
	bh=nJVOqOIFQLFIG1XFDqf8IhmlkhMFmW/3etJVOY+0M+A=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=kK4wPg49hUSHlZg9zlv9vfrsEmSOZQ6XIr7tpc0TMog1s+2jwUerR5DpcpaSmcJ4rINDgVxF14bdHwCNggHk5v3s1u4QTW0OJbb1VEvIANG2o0a+0EQb7cu9zPkToQ5zXcm8ULrvWHvlen6rLZzaJlOXXS9ncx+fvBI1ItntC/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpYiSM7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B6BC433C7;
	Thu, 18 Jan 2024 15:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705592967;
	bh=nJVOqOIFQLFIG1XFDqf8IhmlkhMFmW/3etJVOY+0M+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OpYiSM7LnbMKYZ/xM2ne4yN+OEp8lDymBAwogZ7ixHmybIOElFhzSpUX5lhLUvR/E
	 NLbrsils21ig9zfMqUG9ywCY5AQwzGfql41mIgM+VSOOC2E4LRsTWdNVgJwK1SRu5+
	 h+vfxeq6WSYafLE5mkl7x4dyemtD6oEQ8jT6ik3VQ/9IQ75i2M+O2Z7ppIkmSZq4rN
	 EgOqabg0RbdDbfJlfDUVc3UWdbv29UJvLiJtvVIwHaXGLDdocM8VvvVLxKy3RCfE0Y
	 tiO/NrwnDsCDsLRE7yLXR03aUetujexIMJUP/4b7tL4YbY/APwCsTrewHNLQ4rR5f+
	 M2t7k0VaQfW1Q==
Date: Thu, 18 Jan 2024 15:49:21 +0000
From: Conor Dooley <conor@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, rust-for-linux@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v1 0/2] RISC-V: enable rust
Message-ID: <20240118-implode-delirium-eefdd86e170e@spud>
References: <20230307102441.94417-1-conor.dooley@microchip.com>
 <20230608-dispatch-sneer-aa09bd7b2eb8@wendy>
 <CANiq72nnph7LS1fLRtHz8NJ91PWXPaUnm0EuoV3wrbvK398AnA@mail.gmail.com>
 <20230608-spiritism-gonad-5f5aff4c3a24@wendy>
 <20240117-swiftly-parasail-618d62972d6e@spud>
 <CANiq72mVKCOAuK4Qe+8AHmpkFwyJsVfx8AqB7ccGi3DYpSSWcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1HW3FZOlVDIsEuAs"
Content-Disposition: inline
In-Reply-To: <CANiq72mVKCOAuK4Qe+8AHmpkFwyJsVfx8AqB7ccGi3DYpSSWcw@mail.gmail.com>


--1HW3FZOlVDIsEuAs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 07:23:17PM +0100, Miguel Ojeda wrote:
> On Wed, Jan 17, 2024 at 12:31=E2=80=AFPM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > 6.6 came and went, and I have been busy dealing with the other
> > responsibilities I mentioned and have not had a chance to look here.
> > I rebased this today and things still work as they did when I submitted
> > this version, but things have gotten muddier on the LLVM side of things,
> > as more recent versions have added yet more extension support.
>=20
> Sounds fun :)
>=20
> > My inclination at this point is to engage in a bit of LARPing as an
> > ostrich, and sorta ignore these concerns initially. Specifically, I'd
> > like to drop the idea of having the gcc support, and restrict to LLVM=
=3D1.
>=20
> Yeah, if `LLVM=3D1` works, then I would suggest going ahead with that.
>=20
> (Now that `rustc_codegen_gcc` is here, we will move to that and forget
> about mixed compiler builds, but we still have to handle `bindgen`
> flags until we have an alternative for that)

The bit that worries me most is bindgen, and in particular detecting the
version of libclang used. I mentioned to Nathan or Nick about needing a
buildtime test for the version of LIBCLANG being used.
I'm less worried about this for LLVM=3D1 builds, since while I think it is
possible to provide a LIBCLANG path to the build system, I suspect that
for LLVM=3D1 builds it's almost always going to match the LLVM toolchain
in use.

> > When it comes to asymmetrical extension support between the C and Rust
> > toolchains, I'm think we deal with that as we do for the C toolchains,
> > sort issues out as-and-when they arrive rather than punt this again.
>=20
> Sounds good, thanks a lot!

I'll do another rebase and resend after the merge window closes I
suppose :)

--1HW3FZOlVDIsEuAs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZalIgQAKCRB4tDGHoIJi
0h8eAQDfKI2cOYM7xH8dDl7IUQsHvHxvlTx+Fc/ul6I5u85oZwEA3NdLO8SEdOI/
0oVhy3L0n3OWLZBkAkoN6rTjPQhddgQ=
=atSn
-----END PGP SIGNATURE-----

--1HW3FZOlVDIsEuAs--

