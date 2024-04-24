Return-Path: <linux-kernel+bounces-156747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32ED98B07A0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F891F234FE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA8B159584;
	Wed, 24 Apr 2024 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qn5tlYpf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036D941C63
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 10:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955669; cv=none; b=MmQfO1ha8WUDnWY1I1PBQD0rvA4D0gmoR+LDpNojU2u8Hv7j9kYH7W39xQUbGKFCxg+rlRQq6E1im/qr2JGJdyCSPQr8OcIlNLrxRET4b4pf+Q5PvfVnKme/MXnhuMP160s87xbQnZYVI2qiqx//hoRvsoYEA/O/stWgoeczQeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955669; c=relaxed/simple;
	bh=Es+BLiCAY4cW/MeeZ/D/X2HEXZPjviuh/l6QAzLU2PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WseyC8H1PAHTycqB+uMBMyeS5GixX44RGQErMnKl2MtN17/L4cfO/bXY/P6de7u5on8cZHtznVA2bxUqwHqtPmuLlIf7yQ1zWISXBn/FKsY2ATp7bQNPSDOmPho+akUocz6U3FgI+VeEzk3oJQ6MiC5CvUYVGEcjvB9mexSibdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qn5tlYpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62473C113CE;
	Wed, 24 Apr 2024 10:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713955668;
	bh=Es+BLiCAY4cW/MeeZ/D/X2HEXZPjviuh/l6QAzLU2PY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qn5tlYpfbEmImm04g9ins0hFSOHkz+yFWGzZr+QtYeABdX8xBxfg4fqfZW2OKV1Bq
	 kIjCDrVCY+wVlQ/QL6VkLb4MilbJDezOeUNprqzO+6N0nOb5qm48lNua0efGwjIgw6
	 oWcy/zie6KHj0pDOTkdVONfuiu882YcaKWpTvYa0dF6Td4+FgKTOc58x6pSjI0Lp3m
	 JpKj2XLjPJd+VSjtMKA744jyk/zuL7R7qsyErtlgavEq2RGYhjFqUvKe6GAa31noac
	 87dUTQfNevj85bruXkfmlYpqpuC/jTAf4CfbwkcaE9V+95iZ6a8w/T4e5pQrrz1pe3
	 ueIh9nTKdx1/w==
Date: Wed, 24 Apr 2024 11:47:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] riscv: Simplify text patching loops
Message-ID: <20240424-gallows-resilient-c46a69705a0c@spud>
References: <20240327160520.791322-1-samuel.holland@sifive.com>
 <20240327160520.791322-5-samuel.holland@sifive.com>
 <20240424-cranial-punch-27b38726d3f7@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="URBwmoCtPsB1XCmP"
Content-Disposition: inline
In-Reply-To: <20240424-cranial-punch-27b38726d3f7@spud>


--URBwmoCtPsB1XCmP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 11:44:17AM +0100, Conor Dooley wrote:
> On Wed, Mar 27, 2024 at 09:04:43AM -0700, Samuel Holland wrote:
> > This reduces the number of variables and makes the code easier to parse.
> >=20
> > Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> > ---
> >=20
> > Changes in v2:
> >  - Further simplify patch_insn_set()/patch_insn_write() loop conditions
> >  - Use min() instead of min_t() since both sides are unsigned long
> >=20
> >  arch/riscv/kernel/patch.c | 37 +++++++++++++++++++++----------------
> >  1 file changed, 21 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> > index 9a1bce1adf5a..0d1700d1934c 100644
> > --- a/arch/riscv/kernel/patch.c
> > +++ b/arch/riscv/kernel/patch.c
> > @@ -155,22 +155,24 @@ NOKPROBE_SYMBOL(__patch_insn_write);
> > =20
> >  static int patch_insn_set(void *addr, u8 c, size_t len)
> >  {
> > -	size_t patched =3D 0;
> >  	size_t size;
> > -	int ret =3D 0;
> > =20
> >  	/*
> >  	 * __patch_insn_set() can only work on 2 pages at a time so call it i=
n a
> >  	 * loop with len <=3D 2 * PAGE_SIZE.
> >  	 */
> > -	while (patched < len && !ret) {
> > -		size =3D min_t(size_t, PAGE_SIZE * 2 - offset_in_page(addr + patched=
), len - patched);
> > -		ret =3D __patch_insn_set(addr + patched, c, size);
> > -
> > -		patched +=3D size;
> >  	}
> > =20
> > -	return ret;
> >  }
>=20
> Weren't these actively wrong before, if a non-ultimate
> __patch_insn_set() failed we'd just ignore the error?

nvm, failure to read on my part..

--URBwmoCtPsB1XCmP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZijjUQAKCRB4tDGHoIJi
0jnJAQCZwXvp86ggmW7AzqfFnAHTSRh+t/KIM9IcxGmWgbhAcAEAj4HjXN/D/hkC
9nYTOHV+Z6/tFGPZAWLP52FWBbJNXgo=
=qkLZ
-----END PGP SIGNATURE-----

--URBwmoCtPsB1XCmP--

