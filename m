Return-Path: <linux-kernel+bounces-91173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC29B870AA1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A811F2169B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A7A7993C;
	Mon,  4 Mar 2024 19:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDxjiYkf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7E362147;
	Mon,  4 Mar 2024 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580339; cv=none; b=q16d9s85mOHhuym79IiRy1GLTyjWWuKK4868lnxjIO9YYzWo1Re0m+6qUop9Ce1DBwAYp1oHuaMgsQsD4zTw/i7k4hCMWRhassiRamv1uZXFXlY3pux+9ltGmW0xa6An+tkTA5F+bABunUHdvHreP4JbKhiEQQPA3M4UR2cFhzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580339; c=relaxed/simple;
	bh=TQEI4fsDJ0e19ccZz539tCalZXKMnkbsWxcJRNdU3Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWWLuyrwAF3z74a6UdWX2m/kHzQ63x3KHWD8WFmNAj0T6ucxNo7vH4OJGIydDs1XcbYVHfDVd8f8JkMl2oxrA0tFmm6wPhbaN1b57Raxb9l7yKBalkXQb95DKaWbBqmOCO1UKZeZPl0rreVDUTTKL9xCUhM8asPfggIP2o4u+es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDxjiYkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E3CC433F1;
	Mon,  4 Mar 2024 19:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709580339;
	bh=TQEI4fsDJ0e19ccZz539tCalZXKMnkbsWxcJRNdU3Og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nDxjiYkftdBnZehm3S/nKGeBbfWTnaqhE6e3uOwnxNrq9za8z5TC48/MTo4fXtwFb
	 gn86mmJqM/tQvXZ5Uf0jPUd+5Zqbx42IdbGCFLR0PG2ClafRNNUUYwWLhiafGER0Id
	 4lLDpEkWIHMfD0Xtt/Vtsvn9DVPJUnhPqulpJ6KWGwGqmghhQEL60+tK6wNsqHrLVN
	 6sPgpRQRHShdWA904eWh2ig9+w8EuWLWuEDcMMsjXav/2wcy+dpgsDjIppMayQckt2
	 7kGvYMEGenl0PIflJwxLFYaWHn1H74bceAys/i3QXtabp+yAoipHB6aOCKJjTiZ7tC
	 +/ifj9vB+xI8w==
Date: Mon, 4 Mar 2024 19:25:33 +0000
From: Conor Dooley <conor@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrea Parri <andrea@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [PATCH v3 1/2] riscv: Remove superfluous smp_mb()
Message-ID: <20240304-aptly-surely-ab9ea7d82337@spud>
References: <20240229121056.203419-1-alexghiti@rivosinc.com>
 <20240229121056.203419-2-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="73cKyHnDQwSzGFtc"
Content-Disposition: inline
In-Reply-To: <20240229121056.203419-2-alexghiti@rivosinc.com>


--73cKyHnDQwSzGFtc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 01:10:55PM +0100, Alexandre Ghiti wrote:
> This memory barrier is not needed and not documented so simply remove
> it.

This looks like it should be patch 2 in the series, not patch 1, as it
is cleanup rather than a fix that needs backporting.

>=20
> Suggested-by: Andrea Parri <andrea@rivosinc.com>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>  arch/riscv/kernel/patch.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 37e87fdcf6a0..0b5c16dfe3f4 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -239,7 +239,6 @@ static int patch_text_cb(void *data)
>  	} else {
>  		while (atomic_read(&patch->cpu_count) <=3D num_online_cpus())
>  			cpu_relax();
> -		smp_mb();
>  	}
> =20
>  	return ret;
> --=20
> 2.39.2
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--73cKyHnDQwSzGFtc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeYgLQAKCRB4tDGHoIJi
0gaoAQCyP9yuVqUn4rjvYnIqJ1Xvj9PmeOgG/Al0kAgSlncR0gD9GGCx6whb1QsB
8vwe/vUWWh01dW6RJJpmg5c4rIRlvw0=
=uoct
-----END PGP SIGNATURE-----

--73cKyHnDQwSzGFtc--

