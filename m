Return-Path: <linux-kernel+bounces-65466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35D6854D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251BA1C28A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2815FB94;
	Wed, 14 Feb 2024 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvqkGmDf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9076024D;
	Wed, 14 Feb 2024 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926102; cv=none; b=IXbfysFMRzNJeRuHDJXIKMpAk6XzbC1dmwcwZIfsgqS5G+giRtWyEeFsyQl6T0pao5o4lyZ55yF++5E0OvKyspZXJD2R9une2fZmF6c/RI33mz3mrNQY9advbRI3y31xmBWdcaVG07MWiQfFo5tWd1WVLsk+XMCVzH1aDqqQrbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926102; c=relaxed/simple;
	bh=I5QmVlSxsPE/Gk4+HnD06ucKGeusZCkAT0pMy1rJFdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nE+vTZTAV5yH8Eu85rN2Ncr/q3GZ5T9WXQA8shFZeYM5Afm6ZRip4fttGIkraKbn0VzY9yWBzSEKP/wF/SfE5pNvVV9WbESeXMG9XgxT7HtEg8sPDQSm9dw6SCsxh9UUAYyEZDc/gIvE5SQa5KmrmR7/CJOBhEBv7amR/7ngjwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvqkGmDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00213C43399;
	Wed, 14 Feb 2024 15:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707926102;
	bh=I5QmVlSxsPE/Gk4+HnD06ucKGeusZCkAT0pMy1rJFdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lvqkGmDfiWK0/udDnfCBRaDRe2kArttC6QTkDsM1BxGHPZTBnbzWYTP4veP3ZargP
	 aa80u28eGTmb3HYZ6oGtKR65HcpjxycM1VMzPS4fYFTC0EbeI+rblhYH5Pxe8kkoTk
	 piWqBbRlZ3WUN8Ur08uVW+pleZvBCYBuFxtDvJH0kTxKRxdrLHSaweAq9p/Ya8HFOM
	 sD0nomU3aUbzp3g/hO/j9ABxNQ+PevDhv8jT7tFPC+GjPBI0HImRZV6jPzw3axLIAC
	 CzUwM/eHkXlHKHd9XW1i4L3SQ30mWBeGeaEFgIOQeI9Ks+AjSmvK9B5bf7NlwGMfJr
	 fmbaBGfW564vw==
Date: Wed, 14 Feb 2024 15:54:57 +0000
From: Conor Dooley <conor@kernel.org>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Greg KH <gregkh@linuxfoundation.org>,
	jirislaby@kernel.org, Atish Patra <atishp@rivosinc.com>,
	ajones@ventanamicro.com, apatel@ventanamicro.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Emil Renner Berthing <kernel@esmil.dk>
Subject: Re: [PATCH] tty: hvc: Don't enable the RISC-V SBI console by default
Message-ID: <20240214-impound-gumdrop-230d0725f5ce@spud>
References: <20240214153429.16484-2-palmer@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZpSavjsIcxHJ5llO"
Content-Disposition: inline
In-Reply-To: <20240214153429.16484-2-palmer@rivosinc.com>


--ZpSavjsIcxHJ5llO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 07:34:30AM -0800, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
>=20
> The new SBI console has the same problem as the old one: there's only
> one shared backing hardware and no synchronization, so the two drivers
> end up stepping on each other.  This was the same issue the old SBI-0.1
> console drivers had, but that was disabled by default when SBI-0.1 was.
>=20
> So just mark the new driver as nonportable.
>=20
> Reported-by: Emil Renner Berthing <kernel@esmil.dk>
> Fixes: 88ead68e764c ("tty: Add SBI debug console support to HVC SBI drive=
r")
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

As was brought up when we covered this earlier today, if you're going to
probe a driver based on an ecall, the same hardware should not remain
enabled in the DT passed to the kernel.
If you want to enable this driver in a multiplatform kernel alongside
"real" drivers, then the solution is simple, firmware needs implementation
needs to patch the DT and, at least, mark the uart as reserved if it is
using it to provide the debug console. Marking this nonportable so that
people only walk into this with their eyes open seems like a reasonable
action to me.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  drivers/tty/hvc/Kconfig | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
> index 6e05c5c7bca1..c2a4e88b328f 100644
> --- a/drivers/tty/hvc/Kconfig
> +++ b/drivers/tty/hvc/Kconfig
> @@ -108,13 +108,15 @@ config HVC_DCC_SERIALIZE_SMP
> =20
>  config HVC_RISCV_SBI
>  	bool "RISC-V SBI console support"
> -	depends on RISCV_SBI
> +	depends on RISCV_SBI && NONPORTABLE
>  	select HVC_DRIVER
>  	help
>  	  This enables support for console output via RISC-V SBI calls, which
> -	  is normally used only during boot to output printk.
> +	  is normally used only during boot to output printk.  This driver
> +	  conflicts with real console drivers and should not be enabled on
> +	  systems that directly access the console.
> =20
> -	  If you don't know what do to here, say Y.
> +	  If you don't know what do to here, say N.
> =20
>  config HVCS
>  	tristate "IBM Hypervisor Virtual Console Server support"
> --=20
> 2.43.0
>=20
>=20

--ZpSavjsIcxHJ5llO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcziUQAKCRB4tDGHoIJi
0ha2AP4h37dfZJEi2Ma4Nfwx6PGVD0xADFSNtFYCxflzdgLW7AD+OawAfKCLrXnJ
5fR1lKUHo+712HP3zmc1aJ6D2m0LTg8=
=3+DZ
-----END PGP SIGNATURE-----

--ZpSavjsIcxHJ5llO--

