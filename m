Return-Path: <linux-kernel+bounces-62323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2BA851E87
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B022858F0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D778C481D0;
	Mon, 12 Feb 2024 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+i4Kcy8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ABA46549;
	Mon, 12 Feb 2024 20:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707769059; cv=none; b=IgRyXjrQoFsgKzSLPpTq+oRLWHS6HVSvEJZ/TS+2t/vui8XRRkG4RUrnDeU77T9d2HX2dW6bmjMFjY4EAtxC12NzzWomwLQF6zfO+Z2wv/WN+njkUaOwUAfu/nZIdy/L09QNTJvRrbycfWoTBvuTm6CbGtRnnuBqlJVi/w7DtSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707769059; c=relaxed/simple;
	bh=Rj06hafTCiyYS44RXdDjgCx/QrBaExSSWLkRezkp1WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDbGwyJIymzEfE02VKUc4zTuqlclShyg9JqEEZ2JdbCAOK9dpSv0xk8xGAhRcLP+FG8ADhtSbQHgbPFOnJa93tSBfEEE4e9fSdmdeUzpkd/fJtKGJw8SmgY409dwBJvay7bNhUSqrBMiFS7RRRiMwLiReGf+ZG2kpS6AZUxWThk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+i4Kcy8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F75C433F1;
	Mon, 12 Feb 2024 20:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707769058;
	bh=Rj06hafTCiyYS44RXdDjgCx/QrBaExSSWLkRezkp1WA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+i4Kcy8KwTYZaA9DRB9gp/BAdGBVRfD7bKOCgPjeydbfp0mblshUNNi+P5qU3Ntt
	 9lSQdgC9J4E0ZScwHXsFpzj7dBZccyZve+F4ps1bMyLKQ12t2tW1LNjEpB3sgxXsbD
	 tbzqtA+3ken2t/Xtbvn3/2Te6Hr0zJvzXRS2L7fK+nOm8Tey9Q6RN1v42u5lKhQds2
	 /wOuE+NL7eLCzORsTsJK2K9N3BwYIl0lYBmdSgKDtRV5kixXlRSrNM74oKh67oB4zv
	 Io2hsp7zoaX2X1V52Hq6eYNDnecdK/TD3sjwSFVCzThrovySIIQlbv8kfJGJHZDUy4
	 Uvseb6GNI3UbQ==
Date: Mon, 12 Feb 2024 20:17:31 +0000
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
Message-ID: <20240212-demotion-blitz-1c9ab85dbc73@spud>
References: <20240125-bucked-payroll-47f82077b262@wendy>
 <CANiq72k7n0aZrifRRU08N8qLkNe+2EZwijZy5sM7M56n2xYHgQ@mail.gmail.com>
 <20240125-lazy-thrower-744aacc6632a@wendy>
 <CANiq72kb+_utZrYHtoKZQtQazikmkjpVUHpTBcaANizduMF5QQ@mail.gmail.com>
 <20240126-eccentric-jaywalker-3560e2151a92@spud>
 <CANiq72nu2NXUWYanHZd5EXgX4P_v673EWn6SCRW60Es9naraQQ@mail.gmail.com>
 <20240209-rage-keg-1b2982cd17d9@spud>
 <CALNs47sRqAbE=u3=_ciO2oge7Afz-6GBBhW+BwcLRET-TsuxTg@mail.gmail.com>
 <CAOcBZORDaHHH3jTL3GO7OsDubhhyQE0Uy2uAjJpiRzrKBgqaOw@mail.gmail.com>
 <CANiq72=VBFvB9O9c84YxpBBftpfNnnXx-+Xes0h8h6rN3EN5pA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Fnsa84sXGmOTaKtZ"
Content-Disposition: inline
In-Reply-To: <CANiq72=VBFvB9O9c84YxpBBftpfNnnXx-+Xes0h8h6rN3EN5pA@mail.gmail.com>


--Fnsa84sXGmOTaKtZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 08:11:21PM +0100, Miguel Ojeda wrote:
> On Mon, Feb 12, 2024 at 8:02=E2=80=AFPM Ramon de C Valle <rcvalle@google.=
com> wrote:
> >
> > Sorry for the late reply. Sami might be the best person to answer this,=
 but KCFI (not CFI) tests are lowered by passes that are architecture speci=
fic (see https://reviews.llvm.org/D119296), so we'd need to add support for=
 RISC-V. There is no additional work required in the Rust compiler besides =
enabling it for the new target.
>=20
> Thanks a lot Ramon!
>=20
> Then for RISC-V let's go for the `depends on` for the moment, and we
> can remove when the support lands for RISC-V (ideally when someone has
> managed to boot it at least under some configuration).

If all you want is a boot under some configuration, that's not
difficult. After all, I found the original issue by booting a kernel
with CFI_CLANG enabled on the C side...

> There is no additional work required in the Rust compiler besides enablin=
g it for the new target.

This is not super clear though, it says "in the Rust compiler", not "in
the kernel's buildsystem".

--Fnsa84sXGmOTaKtZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcp82wAKCRB4tDGHoIJi
0l0+AQDwAn/aq+Fts6yHPXow2miyTAWD/hM47HfQMPIODOb5ZQD/dkB5CAfEyKfu
rkbwjea4usmgQD4BLThgzp4mlabBVwM=
=ORjx
-----END PGP SIGNATURE-----

--Fnsa84sXGmOTaKtZ--

