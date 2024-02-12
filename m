Return-Path: <linux-kernel+bounces-62344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E931851EBF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79A62838DF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEE947A67;
	Mon, 12 Feb 2024 20:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERoYmQ4j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285C41EB58;
	Mon, 12 Feb 2024 20:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707770280; cv=none; b=fhHKtbtppvNJT+BddZik0b2HzwJYgiEPug/XlHLvynYyXB+Ub5NklFJGO4QIyCJZ3/AA3fK8tHU7xQdK4iXEcIFq/IFCcglPV/9ovBVQr9b9AsEXjrr3lvC6V4DZZ6nmO0988h9BFOVpCvIzZwaNLlrYcfKi+9oGJF7zQwRHfsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707770280; c=relaxed/simple;
	bh=Fpc0F+qyMdb3ioJ2lc0gnHuRhUOcZrHYZrPqSExGyO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0tK/JHwLy0AxC8F5DOVyRVwMDSea3lVtsYg90i0U9km8VtDGX1KSFGStiQpoKcEjRfIaN2wlBwmgMHiLwPsfi8elnEbxChg747ajpPHpbjm1JOyTU9E9ZYa+mPsgf7/cS3pcwNlP4qn4gU6a5BJX9n52F4O4/MnMPyx18Yn9dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERoYmQ4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680E0C433C7;
	Mon, 12 Feb 2024 20:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707770279;
	bh=Fpc0F+qyMdb3ioJ2lc0gnHuRhUOcZrHYZrPqSExGyO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ERoYmQ4jogZzX3jGbXTPFUvQKZxZNyUDWD1L2SOQZHWtQ7IFM5lc9jiHFaHnsMIXX
	 FuaeoD3/gDRGSXA6Q0aG0m0mRh3347oJzaYWzkY2HfQuua1xc53rOETQSs9Vmn58Fd
	 rlAXeBece75Z0pCccGm6xTU/O3OCAnzS5JiJohr90Dm1DK5RWh46KFxwjnQxh4izeu
	 HSQOyL3bfOQ6/W3mqm1GuWLJUhB2EiNdWsxcrXqRmkbSgZBU1l7wRHclc3D9vN1pDk
	 azNptHEvsIBkkmmNalf8ik6jEbP/rpO/lgIQeQSrxowuNPYZiAq6webhKmgLTFpTrE
	 YoKwiqot/WBWg==
Date: Mon, 12 Feb 2024 20:37:53 +0000
From: Conor Dooley <conor@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Ramon de C Valle <rcvalle@google.com>, Trevor Gross <tmgross@umich.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
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
	llvm@lists.linux.dev, Matthew Maurer <mmaurer@google.com>,
	Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v1 0/2] RISC-V: enable rust
Message-ID: <20240212-outdoors-french-a40d57e38c71@spud>
References: <CANiq72k7n0aZrifRRU08N8qLkNe+2EZwijZy5sM7M56n2xYHgQ@mail.gmail.com>
 <20240125-lazy-thrower-744aacc6632a@wendy>
 <CANiq72kb+_utZrYHtoKZQtQazikmkjpVUHpTBcaANizduMF5QQ@mail.gmail.com>
 <20240126-eccentric-jaywalker-3560e2151a92@spud>
 <CANiq72nu2NXUWYanHZd5EXgX4P_v673EWn6SCRW60Es9naraQQ@mail.gmail.com>
 <20240209-rage-keg-1b2982cd17d9@spud>
 <CALNs47sRqAbE=u3=_ciO2oge7Afz-6GBBhW+BwcLRET-TsuxTg@mail.gmail.com>
 <CAOcBZORDaHHH3jTL3GO7OsDubhhyQE0Uy2uAjJpiRzrKBgqaOw@mail.gmail.com>
 <CANiq72=VBFvB9O9c84YxpBBftpfNnnXx-+Xes0h8h6rN3EN5pA@mail.gmail.com>
 <20240212-demotion-blitz-1c9ab85dbc73@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7thX9cC6woknPGKe"
Content-Disposition: inline
In-Reply-To: <20240212-demotion-blitz-1c9ab85dbc73@spud>


--7thX9cC6woknPGKe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 08:17:31PM +0000, Conor Dooley wrote:
> On Mon, Feb 12, 2024 at 08:11:21PM +0100, Miguel Ojeda wrote:
> > On Mon, Feb 12, 2024 at 8:02=E2=80=AFPM Ramon de C Valle <rcvalle@googl=
e.com> wrote:
> > >
> > > Sorry for the late reply. Sami might be the best person to answer thi=
s, but KCFI (not CFI) tests are lowered by passes that are architecture spe=
cific (see https://reviews.llvm.org/D119296), so we'd need to add support f=
or RISC-V. There is no additional work required in the Rust compiler beside=
s enabling it for the new target.
> >=20
> > Thanks a lot Ramon!
> >=20
> > Then for RISC-V let's go for the `depends on` for the moment, and we
> > can remove when the support lands for RISC-V (ideally when someone has
> > managed to boot it at least under some configuration).
>=20
> If all you want is a boot under some configuration, that's not
> difficult. After all, I found the original issue by booting a kernel
> with CFI_CLANG enabled on the C side...

Also, regardless of depends on on RISC-V, things will still be broken
on arm64 and x86_64, since KCFI is not enabled in rustc there either?

> > There is no additional work required in the Rust compiler besides enabl=
ing it for the new target.
>=20
> This is not super clear though, it says "in the Rust compiler", not "in
> the kernel's buildsystem".

I realise I was not clear either. What I meant was that this talks about
rustc and not kbuild, so what is meant by "the new target" is not clear.
Do arm64 and x86_64 have functional support, so adding RISC-V in rustc
is needed, or did you mean for the new target in the kernel?



--7thX9cC6woknPGKe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcqBoQAKCRB4tDGHoIJi
0iGKAP97UKgRmbxcqgRIJWahLsNbdWqhmMMWsoa78Iykcp7gmQD+JtaSuLVZzvRC
7MFMT30bfndJIV8nNlMBmx4+XtVlHw8=
=gsZ6
-----END PGP SIGNATURE-----

--7thX9cC6woknPGKe--

