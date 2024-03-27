Return-Path: <linux-kernel+bounces-120713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E9B88DBD3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC48F284A15
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8542152F7B;
	Wed, 27 Mar 2024 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/ZSqiSx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EA63613D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537391; cv=none; b=jsWIQk3TPsLhMTYrsnAVL4jjdcmmkxX8tJXfZcpVdtGEX1TSqgbTOLHPEaw0ONDP9MCohYrSYiPe94JVBX3V0iyhQnfCcOKaYU8/tfxLzk20Ee3qWRntnBP3km0tQAwScVE40dropHd5nkL6pJc95NB+bO6OKMraV/ZjcOt7AjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537391; c=relaxed/simple;
	bh=83yN7WR9Xwjvb0jOzuP+sGmgmZGqwFwG4WGgb1Zeu3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7jwb7rU2pGZbqiWbCAQHUz10/OeHqyG+CXYjTTYKRcUo2QP6583urMGrkrhV/aCqXIn2IjJOjmk5JnhlMoIOTnV3164dtDPv/PaJcQiEdqWpIUWpBu6NVjOr3K/cOHucEJExRBuLbHoQRqusGUO6Ef9KTO9HLcIMst+GBxBTuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/ZSqiSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DEB7C433F1;
	Wed, 27 Mar 2024 11:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711537391;
	bh=83yN7WR9Xwjvb0jOzuP+sGmgmZGqwFwG4WGgb1Zeu3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C/ZSqiSxwGB98SmvStchGG0Fo9/Pc2Sf0N7T8VYGNuwtwIO3dTsJZLCyRAH1adOdc
	 R7r9AdpMT5fWuo2qZ5aHU7tDZt3yCH+ZBXpzlcSgjAazNhRZnCRgLdzRdFfn/EgVRb
	 d7pK0UvdXYvheoKKmkn0OiKgd3OnFyOKeJYDqqR30F757CAIQEC/Rhs6kqWPUMn0vl
	 1uurGhjuSNYQFulfQ2zfxQ7bVxEdZbKqgQxIF0pCd5faKWiCRgbHa09qu3tKdPRqBX
	 YSO5vIndQLR7N7zmvPStdJKrJkgK4tBJEvouVr5R/vjcdWhMzFRVPP+g1hkVcm/JdT
	 hJ292oKkSOKAQ==
Date: Wed, 27 Mar 2024 11:03:06 +0000
From: Conor Dooley <conor@kernel.org>
To: Christoph =?iso-8859-1?Q?M=FCllner?= <christoph.muellner@vrull.eu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Cooper Qu <cooper.qu@linux.alibaba.com>,
	Zhiwei Liu <zhiwei_liu@linux.alibaba.com>,
	Huang Tao <eric.huang@linux.alibaba.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH 2/2] riscv: T-Head: Test availability bit before enabling
 MAEE errata
Message-ID: <20240327-imperfect-washbowl-d95e57cef0ef@spud>
References: <20240327103130.3651950-1-christoph.muellner@vrull.eu>
 <20240327103130.3651950-3-christoph.muellner@vrull.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ztnT3OuJ/y9UCOEL"
Content-Disposition: inline
In-Reply-To: <20240327103130.3651950-3-christoph.muellner@vrull.eu>


--ztnT3OuJ/y9UCOEL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 11:31:30AM +0100, Christoph M=FCllner wrote:
> T-Head's MAEE mechanism (non-compatible equivalent of RVI's Svpbmt)
> is currently assumed for all T-Head harts. However, QEMU recently
> decided to drop acceptance of guests that write reserved bits in PTEs.
> As MAEE uses reserved bits in PTEs and Linux applies the MAEE errata
> for all T-Head harts, this broke the Linux startup on QEMU emulations
> of the C906 emulation.
>=20
> This patch attempts to address this issue by testing the MAEE bit
> in TH_MXSTATUS CSR. As the TH_MXSTATUS CSR is only accessible in M-mode
> this patch depends on M-mode firmware that handles this for us
> transparently.
>=20

> As this patch breaks Linux bootup on all C9xx machines with MAEE,
> which don't have M-mode firmware that handles the access to the
> TH_MXSTATUS CSR, this patch is marked as RFC.

I think this is gonna be unacceptable in its current state given that it
causes problems for every other version of the firmware. Breaking real
systems for the sake of emulation isn't something we can reasonably do.

To make this sort of change acceptable, you're gonna have to add some way
to differentiate between systems that do and do not support reading this
CSR. I think we either a) need to check the version of the SBI
implementation to see if it hits the threshold for supporting this
feature, or b) add a specific SBI call for this so that we can
differentiate between firmware not supporting the function and the
quote-unquote "hardware" not supporting it. I don't really like option a)
as it could grow to several different options (each for a different SBI
implementation) and support for reading the CSR would need to be
unconditional. I have a feeling that I am missing something though,
that'd make it doable without introducing a new call.

Thanks,
Conor.

If only we'd made enabling this be controlled by a specific DT property,
then disabling it in QEMU would be as simple as not setting that
property :(

>=20
> Signed-off-by: Christoph M=FCllner <christoph.muellner@vrull.eu>
> ---
>  arch/riscv/errata/thead/errata.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/e=
rrata.c
> index 8c8a8a4b0421..dd7bf6c62a35 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -19,6 +19,9 @@
>  #include <asm/patch.h>
>  #include <asm/vendorid_list.h>
> =20
> +#define CSR_TH_MXSTATUS		0x7c0
> +#define MXSTATUS_MAEE		_AC(0x200000, UL)
> +
>  static bool errata_probe_maee(unsigned int stage,
>  			      unsigned long arch_id, unsigned long impid)
>  {
> @@ -28,11 +31,14 @@ static bool errata_probe_maee(unsigned int stage,
>  	if (arch_id !=3D 0 || impid !=3D 0)
>  		return false;
> =20
> -	if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT ||
> -	    stage =3D=3D RISCV_ALTERNATIVES_MODULE)
> -		return true;
> +	if (stage !=3D RISCV_ALTERNATIVES_EARLY_BOOT &&
> +	    stage !=3D RISCV_ALTERNATIVES_MODULE)
> +		return false;
> =20
> -	return false;
> +	if (!(csr_read(CSR_TH_MXSTATUS) & MXSTATUS_MAEE))
> +		return false;
> +
> +	return true;
>  }
> =20
>  /*
> --=20
> 2.44.0
>=20

--ztnT3OuJ/y9UCOEL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgP86gAKCRB4tDGHoIJi
0syxAP98Co7XAfFsYfnMnzOgsIfjb+XPHSPmuZTmIeOhn+xvZQEAjP7y2N7JwGPC
u0oOkLDxmwBaDDFykp5t1LWG64W/lQ0=
=e/Gp
-----END PGP SIGNATURE-----

--ztnT3OuJ/y9UCOEL--

