Return-Path: <linux-kernel+bounces-32492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D48835C55
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0FE1C21BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427861B268;
	Mon, 22 Jan 2024 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQwxwU+v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAF7E555
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705910971; cv=none; b=c6dTSenOHn+T+h7Ay9Qc8EnhkeptkO12aVe2FJOUsnxwOZYsg17xwNyjG09oGZC8OH1xaSqJa1y24Aj50wc50/gGXGUbxmTQX0TfaF3YfX/C92UUaofAU76CbuDmHouM3OQSzo2p+yBJ6Uqn7VLj3ewUlm5FT+ZRNEwsHS2So3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705910971; c=relaxed/simple;
	bh=q6N2S4dWueEuclJ8E7L26oiHyMGXczNOp+gddKDOx9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibXMeUlB9q2VfVObHNwEZIYh4bIxzcIv6tMPVO49gX30gF7moHxOgufEa30lgNOSKyAO3lxHscyAFilUGKFxG1jT79Imz33hCtbBvuzxIyLefYG/E8z2wiVChr4tPWnMU0+GUHdem9ZOhxD9OblSlFU+W+blo60uYUdQSQXOK7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQwxwU+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46ECC433C7;
	Mon, 22 Jan 2024 08:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705910971;
	bh=q6N2S4dWueEuclJ8E7L26oiHyMGXczNOp+gddKDOx9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VQwxwU+vfDjLbSU1pEELnZbWyhZivnj2YFtITx2Ph6e4lrgAhmLM3Lx/XOolSx8A0
	 UGT4x+ZtfUkMpKNh2IKRHr1vF4Z7gAy4MvR33XUKHDqP0ZG9RNRteB3xsGvXZbibtr
	 FCpWt715R9JQtZl46kCSTtM1eQH7PjWes2RViD4Hq6FluEN8xLH2Z24qV9yHx97Su1
	 ujUc5kcb1tu6uwmlgncujoKbRoV/lXICRAKwSeFN6KyD4Um3Jdea9aGfvT6f2/XG8F
	 IXSyV1Pm2UdRGMWIix6bjKYtw/LPZ7FFfqngJ6efMfWFTBFo4JPfi+ucYwceYsAzWA
	 dnUopJWNtWqkA==
Date: Mon, 22 Jan 2024 08:09:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	conor.dooley@microchip.com, robh@kernel.org, sudeep.holla@arm.com,
	pierre.gondois@arm.com, suagrfillet@gmail.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: cacheinfo: add init_cache_level()
Message-ID: <20240122-boxcar-conical-c728a709aa5c@spud>
References: <20240122013510.55788-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s5pIAgEeErdJqyzj"
Content-Disposition: inline
In-Reply-To: <20240122013510.55788-1-cuiyunhui@bytedance.com>


--s5pIAgEeErdJqyzj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 09:35:10AM +0800, Yunhui Cui wrote:
> When cacheinfo_sysfs_init() is executed, the general weak function
> init_cache_level() returns -ENOENT, causing failure to add the "cache"
> node to /sys/devices/system/cpu/cpux/. Implement the init_cache_level()
> function on RISC-V to fix it.

If you recall correctly, I asked you to explain how to reproduce this
when you sent the patch.

Thanks,
Conor.

>=20
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/kernel/cacheinfo.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> index 09e9b88110d1..be9169a38bac 100644
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -71,6 +71,12 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
>  	this_leaf->type =3D type;
>  }
> =20
> +int init_cache_level(unsigned int cpu)
> +{
> +	/* The topology has been parsed by acpi or dt, return true. */
> +	return 0;
> +}
> +
>  int populate_cache_leaves(unsigned int cpu)
>  {
>  	struct cpu_cacheinfo *this_cpu_ci =3D get_cpu_cacheinfo(cpu);
> --=20
> 2.20.1
>=20
>=20

--s5pIAgEeErdJqyzj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa4itgAKCRB4tDGHoIJi
0kJ9AQCc5GLsmpKQsR1KPqMJPZa55KlWp4yEsTQ+aFc/ANtDPQD/U9CecBvAjmFQ
vXmJGKkZmi6e0YeekCbYJxQ179WMWAU=
=EYgi
-----END PGP SIGNATURE-----

--s5pIAgEeErdJqyzj--

