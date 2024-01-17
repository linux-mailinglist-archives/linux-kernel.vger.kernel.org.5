Return-Path: <linux-kernel+bounces-28913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576B483048E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07671287DDE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7B31DFCA;
	Wed, 17 Jan 2024 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3Pxe78I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62805C8DE;
	Wed, 17 Jan 2024 11:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705491062; cv=none; b=Lh1MAbk6ZM7Eq/kfmMVc2b4lF/uX9KP/NvKlSQ850c95wcjE54czu/aFBseDD2c6PWzVmNlxq7s3Wl8T9TNLNtVK3QOJ5kZiwwwfGQCIDlfW5I1tnOs0mg3/njR+X5DwmX0IT1ohqfgVJLnOgrlYpBRukcNtVKit1BgYvG1D1to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705491062; c=relaxed/simple;
	bh=W+4VwuyRcYhhV7162/K5rb8MKqw/7UZiD1PRcLyA8Fk=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=CFz9E5y4ta0rMRMuO9nEyllEZ8m4Q+EDrKIUSwQTkhsqcYsRqMLAkc2dRz4DHlnkDzj8XcBnplrjt1+jjwuMWAa+7xTDjCpsXPCs1t50QOLC0N+ispSV68RL9Wipf09lwB+yd/QJaRkVx5xrrGFPT4W2kox6qxHTXJdjqe15Vwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3Pxe78I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F35EC433C7;
	Wed, 17 Jan 2024 11:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705491061;
	bh=W+4VwuyRcYhhV7162/K5rb8MKqw/7UZiD1PRcLyA8Fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X3Pxe78INo0ZCxa0lyRMprtUGrriYUvVYuWXJfV4Oc+VoL0I4bLN36FsDknC7YnGX
	 +rIH5fU+7Xfk9MdPjHYyIyExjHbZGbrnE7eaGXQdwkKx77v0kRDw8Ghm02gyv/XBJr
	 KLppLKaA8MUHaFryoz9AAu6hw7Neuu4lkx5NKwdfOhjkMcd24mMNPgAOau0UhFhzYk
	 kola7qJeQyTTS8bNAsC1n+ODNhmHi0enOkVATQDzN4q92kd2X7VkA1pQ6wog4c0XO5
	 uBWCf94jaO4uJO3B9VibzFxdnxGV0WbcOWze50rPEraEgYtshEDUerZWOy6Scfs1Zx
	 8u15hC/eTFf9g==
Date: Wed, 17 Jan 2024 11:30:56 +0000
From: Conor Dooley <conor@kernel.org>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
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
Message-ID: <20240117-swiftly-parasail-618d62972d6e@spud>
References: <20230307102441.94417-1-conor.dooley@microchip.com>
 <20230608-dispatch-sneer-aa09bd7b2eb8@wendy>
 <CANiq72nnph7LS1fLRtHz8NJ91PWXPaUnm0EuoV3wrbvK398AnA@mail.gmail.com>
 <20230608-spiritism-gonad-5f5aff4c3a24@wendy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6PVvLnZRvsd/2E7w"
Content-Disposition: inline
In-Reply-To: <20230608-spiritism-gonad-5f5aff4c3a24@wendy>


--6PVvLnZRvsd/2E7w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Palmer, Miguel, Nathan, etc

On Thu, Jun 08, 2023 at 01:28:06PM +0100, Conor Dooley wrote:
> On Thu, Jun 08, 2023 at 01:52:47PM +0200, Miguel Ojeda wrote:
> > On Thu, Jun 8, 2023 at 9:01=E2=80=AFAM Conor Dooley <conor.dooley@micro=
chip.com> wrote:
> > >
> > > I do intend revisting this, probably after the min. version for rust
> > > gets bumped, I've just been really busy with other work the last week=
s.
> >=20
> > Thanks Conor! That would be great. We are increasing the minimum
> > version after the merge window to Rust 1.70.0 (assuming no unexpected
> > issues).
>=20
> Right, so probably I won't resubmit anything until after v6.6 then,
> as it won't be in the RISC-V tree until then, by the sounds of your
> timeline.
> Gives me plenty of time to try and unravel the mess of libclang versions
> and what extensions are supported by each tool. Not like I am devoid of
> other things that need to be done!

6.6 came and went, and I have been busy dealing with the other
responsibilities I mentioned and have not had a chance to look here.
I rebased this today and things still work as they did when I submitted
this version, but things have gotten muddier on the LLVM side of things,
as more recent versions have added yet more extension support.

My inclination at this point is to engage in a bit of LARPing as an
ostrich, and sorta ignore these concerns initially. Specifically, I'd
like to drop the idea of having the gcc support, and restrict to LLVM=3D1.
When it comes to asymmetrical extension support between the C and Rust
toolchains, I'm think we deal with that as we do for the C toolchains,
sort issues out as-and-when they arrive rather than punt this again.

Thoughts?

--6PVvLnZRvsd/2E7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZae6bwAKCRB4tDGHoIJi
0gSBAQDo38W6PTOrInEpd47uC6oQIYUvHH1KsraF+Ue8d+OddAD/RgFhSo1LMWe7
a3i/SbsjnIVdYUqCgcwThIIhp9U8bwA=
=271/
-----END PGP SIGNATURE-----

--6PVvLnZRvsd/2E7w--

