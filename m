Return-Path: <linux-kernel+bounces-83767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A963869E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A681F2359E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4064EB43;
	Tue, 27 Feb 2024 17:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZ+VsAOE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221E34D9EF;
	Tue, 27 Feb 2024 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056100; cv=none; b=RRiCaSH0bMQMbe4ztVhugTj5S4PG/g5SnVybl/bQORaTTAJZwwE6raxr99rrM14oBl7YlVQT+SLBsAfifvkyoXbBXqENsIVmN6eAVafrWkeEQwQHmSMeKypCtqtYpHQm68lanZvRy1/fIw/6PrEbQy5D46mVB8Hn543OyiXHOJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056100; c=relaxed/simple;
	bh=vqVV7Q6iDsLx5qklxPAuR/oFiUFjZboKbfskVrbCEvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Di0ozncJHQ7+KsCm228yA6IgSoKkKlW1oCrlJut1HOeoEC7jQfLrtg9q197o2nVTVUs7uha/VGbrz+YoqIJhFQwXA06C5tLgsMtu4mvEZd8aiDdmLCihdnB9B3DweF11W+A3uD9kuPB8Gd/QMitbiFuH9DttQ/Pa+cdZtFhxvaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZ+VsAOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1006FC433F1;
	Tue, 27 Feb 2024 17:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709056099;
	bh=vqVV7Q6iDsLx5qklxPAuR/oFiUFjZboKbfskVrbCEvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FZ+VsAOEHbkx5hOfvTbD//Vs8qW6bN16Q/HHv4tMM0fDkjodurawCRBW7cFonQzEs
	 IFkNXUgqBaNE2rJeh04+ts+m+MO9JVPbAGbOASIT4TbJe96Vx+qjC7lYvm3WaaA67j
	 +uZ+t80GhRYUGt5PDIT/OLk/bUMJP3xDg4QkIetzvG7XbHL+l21S2uMLivrsG3wQYn
	 hvDmGquiGDG+YA1fFY+OftJwsZxsj8xpc5Geez8EH7PtAJ1D4GAio5XcJaVNOJYYqw
	 IPFwJp2AtMxz3vvtU5fGjjsIusPWbTcwFlPuGIg/paBCSpw3FYh8owFaln8YtOvSXb
	 5YfLDv+0KKh0Q==
Date: Tue, 27 Feb 2024 17:48:13 +0000
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
Message-ID: <20240227-timothy-jailbreak-01a9c29f3607@spud>
References: <20240223-leverage-walmart-5424542cd8bd@spud>
 <20240223-employee-pessimism-03ba0b58db6b@spud>
 <CANiq72ngEZskjH0f=8+cJuQsFTK227bGCxe5G0STMHuPbZYnXg@mail.gmail.com>
 <20240227-resolved-deceit-4a59a6af5b71@wendy>
 <CANiq72mwM+4Oh-H5WmRoqQ_nE1w-eJ1wn-nEwS=BR9JRwzxMMQ@mail.gmail.com>
 <20240227-glove-underwire-f562a56cf2c7@wendy>
 <CANiq72=f03_bw9B8ww8UxHkVyP2F7ZPyvC+KWCyhO3Nk1yqdaw@mail.gmail.com>
 <20240227-swarm-serpent-2010b255f68a@wendy>
 <CANiq72=69uBBhKMrw5P8K6eDHPiwAw_Oj8g1aYcywEYhhUG8OA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HLwnto9vtQo8Qlhz"
Content-Disposition: inline
In-Reply-To: <CANiq72=69uBBhKMrw5P8K6eDHPiwAw_Oj8g1aYcywEYhhUG8OA@mail.gmail.com>


--HLwnto9vtQo8Qlhz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 27, 2024 at 03:47:29PM +0100, Miguel Ojeda wrote:

> Did you try `-Ctarget-feature=-c`? i.e. as far as I know, you can
> disable target features even if they are enabled from the built-in.

No, I didn't actually try anything. Between trying to test the kcfi
stuff on arm64 and the other work I was doing today I did not have a
chance to actually play with that yet. It comes down to you though I
suppose - would you rather have generate_rust_target enable the
compressed instructions depending on the config option or have the
Makefile disable it if compressed instructions are not enabled and use
a builtin target?

--HLwnto9vtQo8Qlhz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd4gXQAKCRB4tDGHoIJi
0qMjAP0QH2pw1S7rVHMB//QCHRoc1Q1qUwE8y0pNpZHyVjD8OQD/ekogh4n6204O
zUuaAfehnQuM33Z8WdSbEvMGxwhNhw8=
=jIbt
-----END PGP SIGNATURE-----

--HLwnto9vtQo8Qlhz--

