Return-Path: <linux-kernel+bounces-137085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AE489DC2F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0927E1C214BF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE741304AF;
	Tue,  9 Apr 2024 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COty79kt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEB312FF9A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672783; cv=none; b=UDmnVj9HTqcrBpZOF93DLl3nOo0nVNZktXiTUeTyLnQW3R9gFEgFlXVfjhEYiXNAZSsBukC5B8nw55CEuxeF/CXwYd7vF+BtZU+1nCK2YAf7NtmhGxuqPxUkqZdeHmdLdPDk9Ov66Y/WYDn6cNPthYBwCMjTSqEGwDc9U3Hod5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672783; c=relaxed/simple;
	bh=XZ5Ck0nfJ0Ggyp+wq5ALEjcfOIvvT0xFKQ9Frag88PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCpvm/D3VHaTPq92BUNRwSsQP4m3AschEi5yCxMsWPrs4HT9V8iKdi5++o6iCRFWiYdB7hTiQIDMqOYY5pehDOF7yF+5tgHQh6kZ+IDNz1zlMaSfkspjM2ksK1TXpf+QgLAb2uWQok7aXn+R3JeP8qYFpH3CDLIa2Xv/AhSPCHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COty79kt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF85CC433C7;
	Tue,  9 Apr 2024 14:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712672782;
	bh=XZ5Ck0nfJ0Ggyp+wq5ALEjcfOIvvT0xFKQ9Frag88PU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=COty79kttqgrA20uwUrzujjlvsp0hHCI+nVtuEfZx6ive5tCPArV2/azRIyCnFvMe
	 x8urPkeTfLUSG0Ny6tLG7k2SgNyG5E1XalwbsBeMVzsKuSFGMEh+z8C98Jcf6A4g5n
	 bCD2ibPQRS6q3CO1Hfff+utuxz8Gy7W0VSjaE4qjvgo4KwuhWktqhEJSq7kpeLExYD
	 bemBoOkDAVEqZiOFNdAiGZYj1M4BbNwo66oZYWLCAxcJYYqOK3n3yVfnFsvccV7y71
	 fw91KEPlVF48um4JQO6cVyFNHorbeQkHmhqEv91HB9beKjS/vFiNpnso/Vw1brU390
	 YD4dB1WTFti7Q==
Date: Tue, 9 Apr 2024 15:26:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] clocksource/drivers/timer-clint: Add option to
 use CSR instead of mtime
Message-ID: <20240409-krypton-employed-b2e0e1b46ddf@spud>
References: <20240406112159.1634-1-jszhang@kernel.org>
 <20240406112159.1634-3-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bvCDlpY1czo324gx"
Content-Disposition: inline
In-Reply-To: <20240406112159.1634-3-jszhang@kernel.org>


--bvCDlpY1czo324gx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 06, 2024 at 07:21:58PM +0800, Jisheng Zhang wrote:
> As pointed out by commit ca7810aecdba ("lib: utils/timer: mtimer: add a
> quirk for lacking mtime register") of opensbi:
>=20
> "T-Head developers surely have a different understanding of time CSR and
> CLINT's mtime register with SiFive ones, that they did not implement
> the mtime register at all -- as shown in openC906 source code, their
> time CSR value is just exposed at the top of their processor IP block
> and expects an external continous counter, which makes it not
> overrideable, and thus mtime register is not implemented, even not for
> reading. However, if CLINTEE is not enabled in T-Head's MXSTATUS
> extended CSR, these systems still rely on the mtimecmp registers to
> generate timer interrupts. This makes it necessary to implement T-Head
> C9xx CLINT support in OpenSBI MTIMER driver, which skips implementing
> reading mtime register and falls back to default code that reads time
> CSR."
>=20
> To use the clint in RISCV-M NOMMU env on Milkv Duo little core, we
> need to fall back to read time CSR instead of mtime register. Add the
> option for this purpose.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 34faa0320ece..7bbdbf2f96a8 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -650,6 +650,15 @@ config CLINT_TIMER
>  	  This option enables the CLINT timer for RISC-V systems.  The CLINT
>  	  driver is usually used for NoMMU RISC-V systems.
> =20
> +config CLINT_USE_CSR_INSTEADOF_MTIME
> +	bool "Use TIME CSR instead of the mtime register"
> +	depends on CLINT_TIMER
> +	help
> +	  Use TIME CSR instead of mtime register. Enable this option if
> +	  prefer TIME CSR over MTIME register, or if the implementation
> +	  doesn't implement the mtime register in CLINT, so fall back on
> +	  TIME CSR.

This, as a Kconfig option, seems a bit strange to me. We know at runtime
if we are on a T-Head device without the mtime register and should be
able decide to use the CSR implementation dynamically in that case,
right?

--bvCDlpY1czo324gx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhVQCgAKCRB4tDGHoIJi
0tR/AP4mG82+NEm1+kAhs2ooDe7PKBIO8/n++HPlnHP8ABuVawD/cc2uB85eshUK
N39p401AWTvQGUxodbiC8LbazhONdgg=
=hDmj
-----END PGP SIGNATURE-----

--bvCDlpY1czo324gx--

