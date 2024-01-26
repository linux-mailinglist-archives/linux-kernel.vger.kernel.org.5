Return-Path: <linux-kernel+bounces-40709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A2783E46E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A45A282D49
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CAA25631;
	Fri, 26 Jan 2024 22:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlPwJWfo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD3225565;
	Fri, 26 Jan 2024 22:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306462; cv=none; b=kK8USXuXYRB5sklUffIEAsciGU77LLlhrDCW4UMwoq+Arld4YtyImrtrxvYi5HweXvx0D0OoYzHWKcf4qZ0bQMK4lwm57S9p4xeyRtdvE+XKADH8Fg8HekQw7PR2w+apaFwNZim0JW8gkMiD9xXfRH1/Avj6sIrUh0QgKD+qbAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306462; c=relaxed/simple;
	bh=riut/XdpDrQsrASptwkcJlb0by07DshnWcYF/bs/29E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3aRVzdcIlxFobGlhmajK4zM2nPsrIk+k2rr+RQiQPi+hrhJJRMMG21Q/0U6OiNx5fn9oc5y/0jYWc2b2pmG8YJvljvYlrTxdBUHD5y3ARE5OQZfwjiRznUXSsPaOhoSCxa8BICYdqk2aIpPkL6Kk1h24jsYEA339cLIIATEqCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlPwJWfo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A277C433F1;
	Fri, 26 Jan 2024 22:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706306461;
	bh=riut/XdpDrQsrASptwkcJlb0by07DshnWcYF/bs/29E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OlPwJWfoQ84jFCtOj2ECYPqtGlVcOuXS54UDiCUCWepQHkwb5HGmWUV/Ub+2dO/fp
	 y+jta1jG5WkFNa2JWgNBsRLG5ckfkgjYx2R74XPMNjzICsSq+PFWZa2mdaNXOgFvSU
	 c85/qaqET/+epqfZKhSqfsmsuJpSThFPdO4cXU+TPvpN5yodPcjGQch8oG9sPS4uK/
	 ZRyy7ypuVoD4l3gNX87Hif2mtnSOhNm4BTcHDg/2DG1uV/vwTCZMKkTpMSfoNpGYPb
	 xTYXppk54qRxer6vaAQ2EGumfgjJIJeVpm7H1jkwivnBVY99YBEGid3YrSi65wWgoB
	 oDvdwrsn3nW6w==
Date: Fri, 26 Jan 2024 22:00:55 +0000
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
Message-ID: <20240126-eccentric-jaywalker-3560e2151a92@spud>
References: <CANiq72nnph7LS1fLRtHz8NJ91PWXPaUnm0EuoV3wrbvK398AnA@mail.gmail.com>
 <20230608-spiritism-gonad-5f5aff4c3a24@wendy>
 <20240117-swiftly-parasail-618d62972d6e@spud>
 <CANiq72mVKCOAuK4Qe+8AHmpkFwyJsVfx8AqB7ccGi3DYpSSWcw@mail.gmail.com>
 <20240118-implode-delirium-eefdd86e170e@spud>
 <CANiq72nx1s_nyvPW86jL7eiOxROr18LfOJqNtw8L42CP+gkhRg@mail.gmail.com>
 <20240125-bucked-payroll-47f82077b262@wendy>
 <CANiq72k7n0aZrifRRU08N8qLkNe+2EZwijZy5sM7M56n2xYHgQ@mail.gmail.com>
 <20240125-lazy-thrower-744aacc6632a@wendy>
 <CANiq72kb+_utZrYHtoKZQtQazikmkjpVUHpTBcaANizduMF5QQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VpYZYsPh7ooFZbB5"
Content-Disposition: inline
In-Reply-To: <CANiq72kb+_utZrYHtoKZQtQazikmkjpVUHpTBcaANizduMF5QQ@mail.gmail.com>


--VpYZYsPh7ooFZbB5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 10:00:02PM +0100, Miguel Ojeda wrote:
> On Thu, Jan 25, 2024 at 2:46=E2=80=AFPM Conor Dooley <conor.dooley@microc=
hip.com> wrote:
> >
> > Ah, thanks for the direct link :)
>=20
> My pleasure!
>=20
> > Actually, thinking about it for a moment - if only a single compiler
> > version is supported (the minimum, right?) then you could just add the
>=20
> Yeah, the minimum listed in `scripts/min-tool-version.sh` and in
> `Documentation/process/changes.rst`. It also happens to be the maximum
> too, until we can relax that.
>=20
> > -Zsanitizer=3Dkcfi flag whenever CFI_CLANG and RUST are both set.
>=20
> Since the flag goes to the Rust compiler, `RUST` would be always
> enabled, so the flag would only need to be added when `CFI_CLANG=3Dy`,
> no?

Sure.

> Or what do you mean?

Oh I was probably just getting myself mixed up between what the Kconfig
and Makefile stuff would look like. dw :)

> > I'm not sure if that is a better option though. It's a choice between
> > CFI_CLANG being disabled if the check is not updated when the toolchain
> > is bumped versus being enabled for C and not for RUST. I think I prefer
> > the former though, tracking down the cause of the latter I would rather
> > not wish on a user.
> >
> > I vote for having the check, even if it can only ever be true at the
> > moment.
>=20
> Since we only support a single version, we don't need `rc-option`
> tests until we start supporting several versions (which is why other
> tests like that do not exist so far).
>=20
> In my previous message I thought you meant using the flag to test for
> arch/target support or similar. That would be fine, but we can also do
> the usual `ARCH_SUPPORTS_CFI_RUST` here, I would assume.

Is that even needed? We already have ARCH_SUPPORTS_CFI_CLANG and AFAIU
rust supports it if clang does, so a second option is superfluous?

> Now, during the version bump to a stable flag, if we happen to forget
> to update the flag name, it would be a build error, so it should be
> easily spotted and fixed.

I'm reading back what I wrote, and I must have been trying to get out
the door or something because none of it really makes that much sense.
Of course an unknown option should be detectable at build time and not
be a silent breakage. Maybe I should have written the patch for this
before sending the mail rather than writing the mail based on what was
in my head.

> What we may want to add, though, to avoid the confusion you mention
> meanwhile, is just a `depends on !CFI_CLANG` for `RUST`, like for the
> other requirements we have there (which are things that should
> eventually go away). Then they can remove that when the `-Z` flag is
> deemed ready to be used. But perhaps let's see what Ramon et al. say.

I don't really mind either way. Whatever of the two that you guys want
that prevents broken kernels works for me!

> By the way, concerning the tracking issue, since you mentioned it: it
> has a list of PRs, but not fixes, there is a "known issues" link
> there. On top of that, we are "shifted in time" w.r.t. the latest
> status in the compiler, since we use stable versions of the compiler.

Yah, I was linking it to point out that the stuff is unlikely to be
usable any time soon, since it is not complete in the most recent
toolchain.

Cheers,
Conor.

--VpYZYsPh7ooFZbB5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbQrlwAKCRB4tDGHoIJi
0meeAP9z4Z4UXLa6YN4nCic4/a2cKXvc99l+GFebDHGuZJIHpwD/W1lM4CxjLlBg
W60C8W8UTeABvw1N16NPnnOeE8KteQI=
=jaxq
-----END PGP SIGNATURE-----

--VpYZYsPh7ooFZbB5--

