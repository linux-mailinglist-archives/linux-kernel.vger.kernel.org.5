Return-Path: <linux-kernel+bounces-131773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C71898BA7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC9529263E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96C712AAEC;
	Thu,  4 Apr 2024 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8G5JjnF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1312224DE;
	Thu,  4 Apr 2024 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712246112; cv=none; b=uQf1v/I5MWWIDPO5YurNpZvUN6lUa7Wa2zsSnwkdG21xBqclXMZpydkHgGvpVgWY4wLNGpNran1oW2g0ZO0+Cpw8HsUqj4XRgOhwCoSAIpwt8YmRR+QWTf2ElNdZPVp97Vr+D0atq+2f64gMOpLK9bpGVSgT9uiED069bviMvGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712246112; c=relaxed/simple;
	bh=QCZhhAi2IfI/C1X4OG5OteKxlexOeyNRa+UFstr4Z1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyX61uykcNBYRjngxfDbghZzza0TVjtNABPAWNyDehNaztPP4VJUBIBgi4samT6JvThtQoMArBi0zLOMN5MtOJA1LSx47ar0xA+xyhVGM+iwYUV0XfjpCBwPDdKXkL3nS+2bfg9+JCdPaNaUt3GkT1b0JKtU+iFsdqkLTq9aThk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8G5JjnF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D92DC433F1;
	Thu,  4 Apr 2024 15:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712246111;
	bh=QCZhhAi2IfI/C1X4OG5OteKxlexOeyNRa+UFstr4Z1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j8G5JjnFYhpyVd72/vt+yRhHZsfCsxia00x2zFU1pfRCqMt4j3zxPLko4lL+6iIdN
	 CRHrX26+60Jam3GIxjzzr79h8wGLgLsH+WON+CUZ7nRl7P3vC7U+n8Twmy3h0zie6B
	 e9npyR2HcW7Ip06hHliSt9JUqCVGUNrisOrUHi3Y4yRov3BTHa6fGM3TqhoJ0esdSX
	 5bW0LsQt2IbsZ+9r4naRbvOohbSxR2XUJBjmPzZ4jcjbh9L7AkPTt8/2lroWXyfPc4
	 CdLXJv75z2r3azPbxbE7G34ErS4zKLkaG5eZSac3JJn5fLvD/ZlQRm5vxTSCUfIDap
	 Gv13d+AGP2Wwg==
Date: Thu, 4 Apr 2024 16:55:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Matthew Maurer <mmaurer@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <keescook@chromium.org>,
	Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
	Ramon de C Valle <rcvalle@google.com>
Subject: Re: [PATCH v3] rust: make mutually exclusive with CFI_CLANG
Message-ID: <20240404-valid-sixtieth-9b8fa0f3ad7e@spud>
References: <20240404-providing-emporium-e652e359c711@spud>
 <CANiq72m9YAu=dr1=WMSHOqfpszj4S6OkMEQ05vqbv_zKO5pOsg@mail.gmail.com>
 <CAGSQo024u1gHJgzsO38Xg3c4or+JupoPABQx_+0BLEpPg0cOEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ywt68H1Qj7pbb+ly"
Content-Disposition: inline
In-Reply-To: <CAGSQo024u1gHJgzsO38Xg3c4or+JupoPABQx_+0BLEpPg0cOEA@mail.gmail.com>


--ywt68H1Qj7pbb+ly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 04, 2024 at 08:25:11AM -0700, Matthew Maurer wrote:
> >
> > Cc'ing Matthew & Ramon as well so that they are aware and in case they
> > want to comment.

Ah crap, I knew I forgot to CC someone from the last conversation,
thanks Miguel.

> This patch is fine by me - the last patch needed for KCFI to be
> functional in Rust just landed upstream last night, so we should
> revisit this (in the form of enabling it) once we move to
> `rustc-1.79.0` or later.

That's great news, thanks for working on it :)

--ywt68H1Qj7pbb+ly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZg7NWQAKCRB4tDGHoIJi
0q8YAQD58we+6Ow/LjNjeDbYjbV+gc/42O61F+M6UlffcXE9MAD/fGp5kccAaKmb
/RxEeaa3gQh5m7NgNUiwxZS1/cHnnQY=
=jQb5
-----END PGP SIGNATURE-----

--ywt68H1Qj7pbb+ly--

