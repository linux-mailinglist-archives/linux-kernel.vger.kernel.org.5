Return-Path: <linux-kernel+bounces-59524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9A684F857
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A4AE1C2134D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C6C6EB62;
	Fri,  9 Feb 2024 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e84l+KMQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A48428DB5;
	Fri,  9 Feb 2024 15:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707491909; cv=none; b=kJXb+Qj7hi3HXh1ufU21FemQ1XmJhhN6d4cXmN2Rv+eRH4APi4UuqPcxu0kAChIeEYcDpfHXuLFFNKB7spBVg3kMw9zoiZxHa1AVoEBaXD4cB+HyeYeCOgV7wg2UZ2HvMAQcUwKh5/pBwOqgRVjNsRNUeb+HEGRDeHnwHIMc3AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707491909; c=relaxed/simple;
	bh=qsEohGDlLb5D6DJLRfIDcQFTUfVGUCeWwneA1f1Lcq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubTD3azCk5eIuj9NlqJuXyrm92XFOkteMJZnfHgSlP4JNZGcjuWtxGEKZXTyBS7OW6wfmoEC2G9033okqqHJcDrVJ3hP3pl1SSBMaBLnFdwJ4bAkaDOEuhD1MPHFSeQN6+MIbLpV3/RlckTdNA9nBapIgrMTnqu6v1ZzZO/63Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e84l+KMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC62C433C7;
	Fri,  9 Feb 2024 15:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707491909;
	bh=qsEohGDlLb5D6DJLRfIDcQFTUfVGUCeWwneA1f1Lcq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e84l+KMQC9NBIrXYUXkAX7vePQw7RIDj6eTwmZptCjhNJwjV09bzS+TA3v7x9PL20
	 VhodEm4/wktAFiIgm9a0Ra/aI1NWfBYhhq7P1/fi46rVq77YvPNytX7FAEQ8m0lyCm
	 fml3Tbe7OJ8/V1Ra234KnVF7h3kaOPCd1711Om/tOp4U55fqoqGt/ufvIbi3AZBGw+
	 J2lVHp1hUcBU1gdYyXZNQpVwHo+35aORpEAmhMb9KfvO1zawHyxiePWJq7HWV+M905
	 Xs/SkkoiCxY3ymG5k5HDgbZnkOD+nlzBseccKvsANiMS1td65W/KsfOYnQSJRl/iNp
	 Qauf5rYHZVmDQ==
Date: Fri, 9 Feb 2024 15:18:22 +0000
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
	llvm@lists.linux.dev, Matthew Maurer <mmaurer@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v1 0/2] RISC-V: enable rust
Message-ID: <20240209-rage-keg-1b2982cd17d9@spud>
References: <20240117-swiftly-parasail-618d62972d6e@spud>
 <CANiq72mVKCOAuK4Qe+8AHmpkFwyJsVfx8AqB7ccGi3DYpSSWcw@mail.gmail.com>
 <20240118-implode-delirium-eefdd86e170e@spud>
 <CANiq72nx1s_nyvPW86jL7eiOxROr18LfOJqNtw8L42CP+gkhRg@mail.gmail.com>
 <20240125-bucked-payroll-47f82077b262@wendy>
 <CANiq72k7n0aZrifRRU08N8qLkNe+2EZwijZy5sM7M56n2xYHgQ@mail.gmail.com>
 <20240125-lazy-thrower-744aacc6632a@wendy>
 <CANiq72kb+_utZrYHtoKZQtQazikmkjpVUHpTBcaANizduMF5QQ@mail.gmail.com>
 <20240126-eccentric-jaywalker-3560e2151a92@spud>
 <CANiq72nu2NXUWYanHZd5EXgX4P_v673EWn6SCRW60Es9naraQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CHccunpyRzIcwl0N"
Content-Disposition: inline
In-Reply-To: <CANiq72nu2NXUWYanHZd5EXgX4P_v673EWn6SCRW60Es9naraQQ@mail.gmail.com>


--CHccunpyRzIcwl0N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2024 at 02:46:38PM +0100, Miguel Ojeda wrote:
> On Fri, Jan 26, 2024 at 11:01=E2=80=AFPM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > Is that even needed? We already have ARCH_SUPPORTS_CFI_CLANG and AFAIU
> > rust supports it if clang does, so a second option is superfluous?
>=20
> From a quick look, I don't see it enabled in any RISC-V built-in
> target in `rustc` yet.
>=20
> It may also still be the case that KCFI needs some tweaks for, say,
> RISC-V, before the flag actually works, i.e. we couldn't just test the
> flag in that case -- Ramon: how likely is it that RISC-V would work if
> KCFI works for aarch64 and x86_64?

Well, there's been no reply here. I'll do sa you suggested and add a=20
depends on !CFI_CLANG to RUST.

Cheers,
Conor.


--CHccunpyRzIcwl0N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcZCPgAKCRB4tDGHoIJi
0v5zAQCzZ7t4RKWWhpbT+/YlhCexHgJAtD+HTzNc09+i1Ph0HwEAhd/NiiTHdmkJ
LbqEznQmgueGJZpHS5dLO20wBGVAUgA=
=q5/s
-----END PGP SIGNATURE-----

--CHccunpyRzIcwl0N--

