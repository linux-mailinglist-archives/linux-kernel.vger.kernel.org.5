Return-Path: <linux-kernel+bounces-53134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AF384A11A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D4F1C21F78
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E30A44C8A;
	Mon,  5 Feb 2024 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARFN7smw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8387F446D7
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154933; cv=none; b=ESW8VDzxokmAQ4WS8SVGEkT9I7BatO5zMnhV6BdSnEhlgrDXZaYSVL2CJPytwHAUMGUhzNlm2YvlgEBmGEUMsF9fQ8RcRnhMNYtuLJpOo6nAxpCGF9IZo9h1YcSsDPDTO1BA0VTt3PimPU1zGSRFKh4m3cvRMHkv0v9fyODkIqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154933; c=relaxed/simple;
	bh=DzJpzqa6HKjeBMkDi3252zL6zF4x9+HiippWvWe6ZT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3N2CAH1w0Dc2HFUM8XGKJDmu0WGsZlnWVzTvJTDh0WVQy9lvMcrhRn9XIJO+tYZqArqs/Wf+7yJ7qlQljT9CZ86UU+kE9ODiaMqxljH68rEOz9zRjgtS3fcwc47qmxTANv4uIh5piEbAIR+/AH7mw3HzpJ/gHvlVmGuq5quEYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARFN7smw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCC8C433F1;
	Mon,  5 Feb 2024 17:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707154933;
	bh=DzJpzqa6HKjeBMkDi3252zL6zF4x9+HiippWvWe6ZT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ARFN7smwTE4fB0CjHhchc3CGJqDVRjeV7WowYO7gJ8Mr7D4N0C+oJWK9zbGqlW9RZ
	 H0liApFKIFynLGIP0unGxVFTPgygJZBLiJgiVyhX79K7XxrbgfZDVCheG/2IY6JNY1
	 Q6PLPBhwSZopyo5C3nQA5imofe6iIlryOffOfo/M7R7mFR2tlqpYY0XyhTe/csCbLF
	 yuDHke39RfEk9/GyGjt3Z/hpa7wgHEea/Wnd0RsbRSqrOF3iYUuWlX7Rd4MmpLW91I
	 wiA0pTfQLFeVggH0jgGzhUdsZckkGcuCLZ3A+55adHTHIGQDLsBWFnhRXSYmI/LWA0
	 eJ7WSWjURHnpg==
Date: Mon, 5 Feb 2024 17:41:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] arm64/sve: Lower the maximum allocation for the SVE
 ptrace regset
Message-ID: <ZcEd2zU/JpeIwn5f@finisterre.sirena.org.uk>
References: <20240203-arm64-sve-ptrace-regset-size-v1-1-2c3ba1386b9e@kernel.org>
 <ZcEW3y0IlEctOYBA@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yAjH7uxAxmBLvyQW"
Content-Disposition: inline
In-Reply-To: <ZcEW3y0IlEctOYBA@e133380.arm.com>
X-Cookie: You might have mail.


--yAjH7uxAxmBLvyQW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 05:11:59PM +0000, Dave Martin wrote:
> On Sat, Feb 03, 2024 at 12:16:49PM +0000, Mark Brown wrote:

> > We could also teach the ptrace core about runtime discoverable regset s=
izes
> > but that would be a more invasive change and this is being observed in
> > practical systems.

> This is not hard at all: see
> 27e64b4be4b8 ("regset: Add support for dynamically sized regsets")=20

> But since this is precisely what was ripped out, I guess adding it back
> may be controversial (?)

Also just that people might want to backport and while it's not super
*hard* I tend to prefer to do something as minimal as possible as a fix,
the less we do the less the chances that we mess up.

> > We should probably also use the actual architectural limit for the
> > bitmasks we use in the VL enumeration code, though that's both a little
> > bit more involved and less immediately a problem.

> Since these masks are 64 bytes each and rarely accessed, it seemed
> pointless complexity to make them resizeable...

I was suggesting making them use the architectural maximum rather than
making them dynamic.

> > +#define ARCH_SVE_VQ_MAX 16
> >  #define SME_VQ_MAX	16

> Ack, though part of the reason for not doing this was to discourage
> people from allocating statically sized buffers in general.

I was going to do a patch adding a comment to the header noting that
this is not actually the architectural maximum since at present it's
a bit of a landmine, people who have some idea of the architecture
likely have a rough idea what sort of allocation size is needed for the
maximum SVE state and are likely to not double check the value provided
(I think that's what happened with the refactoring to remove the dynamic
sizing).  A comment in the header is still very missable but it'd be
something.

> If the kernel is now juggling two #defines for the maximum vector size,
> this feels like it may seed bitrot...

Ideally we'd just not have the existing define externally but it's there
and it's been used.

--yAjH7uxAxmBLvyQW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXBHdoACgkQJNaLcl1U
h9BE2Qf/S7RezjxPYcWKj6gx3SobiowUdZgpA/cBYjCbutcf3sOYR6Bx6JKXsCK3
OOmL2N8GdxIUtay3VgDpxhvxxeW9yPGuUa5Uqji6/txY9utyBOUB4LIXw4/FCPHc
3hGc1pncwGgM4mKkNQEL/XVxPiiEfRo5WwlNB537Izk1p5+HoOvmX7r07421QKqG
oiFPoQXCPCux0hYG4o7wWoWIoXoppg2EZj1+Y7lWJo7xT7OpVwh/Eic2qCtZzdxC
O+qb4UzgJFSPzXbfCaHzRdabhnHtxxUO/TIOL/LMDpT8M1wvjDry357u0aDRF92Y
mM3RhJrBZ9BffUkjABtEBryY6w7Ltw==
=Y4Cv
-----END PGP SIGNATURE-----

--yAjH7uxAxmBLvyQW--

