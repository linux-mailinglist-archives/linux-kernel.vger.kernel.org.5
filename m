Return-Path: <linux-kernel+bounces-83833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D393869F06
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05441F2CA37
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC1B14830F;
	Tue, 27 Feb 2024 18:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bA1hRpnB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81DD25757;
	Tue, 27 Feb 2024 18:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058252; cv=none; b=J6eSSz70P07fRKcRGOq8n2fckHfVqXAR1dPfhIXmDi/kntChZmZ9NRG5GAfT74qiwO1ZXU9mrYATh5Up/7yctP6WPmOyRKQJ7NW1wEEjrXYffWABvFcZy+rDl9ZhCpo60OWplYSrY8L2T1Q5l1jGECy2xZpFytACTM1k+dBQl6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058252; c=relaxed/simple;
	bh=cDF3mXGEW5pin9U2a6M5esBI1SUIsMfuCrh97q573Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+g9buXC7WK7xCPErO9vGORkIPqZplmJJFgbvw1nBRmaU/rSUW3Trcf6TCXkV6J4Pca/+OpcTjF4evBc2NBBn4A0sRfirtWDxpjpinomPX7s2pS8+Cu96L5zXgcbRtQ63j706r7YGpY1AYYQBtWVXyNzCUEOwUXGKEDutrYhupM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bA1hRpnB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB4AC433C7;
	Tue, 27 Feb 2024 18:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709058252;
	bh=cDF3mXGEW5pin9U2a6M5esBI1SUIsMfuCrh97q573Lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bA1hRpnBJ3qCAhZXhUlSgF8QuX7KuxIqPL/kQnsGozEYJ3SfUi3/yApOT+QLPA9za
	 TfYOGP9Y5Tdu6SlJ2yCBjSfLsFjYjme/PQZZWNfQL4Ftut0SpK2HDdBMKzEy/whZa3
	 PDuoNZxsv34B9Z3u49bMxr8csHUfS4SqVGjk+EIbSwWHUUSV+usGwyALtb7SV1jh15
	 IUspdokrAhaTrbwRawkGlPhjLjv/t2/LxG5tO3WdDSJZytnWzupKbQ62WzUPDh8R4Q
	 W9med3/S8RjdcL5uAJc3GyqPEtV/XmdMn5xZmVah/XRnwckx/iIUNTvyVa14sK0/9H
	 QIQp6amHKLdMQ==
Date: Tue, 27 Feb 2024 18:24:06 +0000
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
Subject: Re: [PATCH v2 2/3] scripts: generate_rust_target: enable building on
 RISC-V
Message-ID: <20240227-aside-limeade-497fb182a5bd@spud>
References: <20240223-employee-pessimism-03ba0b58db6b@spud>
 <CANiq72ngEZskjH0f=8+cJuQsFTK227bGCxe5G0STMHuPbZYnXg@mail.gmail.com>
 <20240227-resolved-deceit-4a59a6af5b71@wendy>
 <CANiq72mwM+4Oh-H5WmRoqQ_nE1w-eJ1wn-nEwS=BR9JRwzxMMQ@mail.gmail.com>
 <20240227-glove-underwire-f562a56cf2c7@wendy>
 <CANiq72=f03_bw9B8ww8UxHkVyP2F7ZPyvC+KWCyhO3Nk1yqdaw@mail.gmail.com>
 <20240227-swarm-serpent-2010b255f68a@wendy>
 <CANiq72=69uBBhKMrw5P8K6eDHPiwAw_Oj8g1aYcywEYhhUG8OA@mail.gmail.com>
 <20240227-timothy-jailbreak-01a9c29f3607@spud>
 <CANiq72kQ8===wFLQNCR-XAo9KdtPr44UKvyi2074J88vh3kvyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D1EopDYvcEeT6CSG"
Content-Disposition: inline
In-Reply-To: <CANiq72kQ8===wFLQNCR-XAo9KdtPr44UKvyi2074J88vh3kvyg@mail.gmail.com>


--D1EopDYvcEeT6CSG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 07:11:17PM +0100, Miguel Ojeda wrote:
> On Tue, Feb 27, 2024 at 6:48=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:

> For instance, to disable the compressed instructions, from what I can
> tell, the flag I mentioned seems to work, so that is fine.

To me, using flags is a good fit given that's what we do elsewhere,
and there won't be a mix of stuff that is done conditionally in a
script and conditionally in a Makefile.

> However,
> for something like tweaking the data layout for `n64` instead of
> `n32:64`, I am not aware of a way to do so via a flag (but I see newer
> LLVM uses `n32:64`, so that may be the better one anyway:
> https://godbolt.org/z/Eh4cfdeMr).

Yeah, I had looked at the blame for the targets earlier today and
noticed that it had been changed. Sadly rustc's commit is lacking
any justification whatsoever for the change, so I was not going to
really comment on that until I had looked.

> So it all depends on whether you are happy with what the flags
> approach already give you.
>=20
> I hope that clarifies a bit!

Ye, thanks. I'll give it a go when I have a bit of time this week.

--D1EopDYvcEeT6CSG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd4oxgAKCRB4tDGHoIJi
0tm5AQDR5I+m1Asy6DGQhAa4NBVf8TGEm4mWhvmKqUunPVp7UAD/Uv/pYmT+0Zzr
j8fw2SaUOY4F5yKafkbQHmmA9iYdZQQ=
=qBac
-----END PGP SIGNATURE-----

--D1EopDYvcEeT6CSG--

