Return-Path: <linux-kernel+bounces-106085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6B687E8C9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC9C1C213EE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB3637165;
	Mon, 18 Mar 2024 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7tD8aBk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481D3364DA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710762205; cv=none; b=etWorJS7tZI0+d16Lwwe+XNoCBKhzNg9brwKv1voWhGrAx1KqLY1mXjx7J0fMqxlmtNq/M8c1jsVwFNt61D/Qqrj8akHQZZAT7ZMQ1kf3ZVVcxwX6bct8MUemw2amzWG63ptTL8a12G9n+LrwdbZcuUIZ4YBj+KlAmGK4ygkg8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710762205; c=relaxed/simple;
	bh=ZsO4ooKDwdPE4ERQ9+2PIQXx/LGHduxb5TJ1B/MU2Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLVYDLNDy1wrOAEBbkVq6qnYbqtc1OqKk3bxVRmN1jYnHN3+B8FVTXvQ6D5R0Dy2YgojieLPfqQ4ZW7Ea3NN0OqaTihOypLuoepDA9Mq7gc6PhTuTrNRsKAfx8cxImL9UMoxAcJd7BFK4eVKulFF4B2AuQoJFp3897ePPoplbts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7tD8aBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D0AC433C7;
	Mon, 18 Mar 2024 11:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710762204;
	bh=ZsO4ooKDwdPE4ERQ9+2PIQXx/LGHduxb5TJ1B/MU2Qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P7tD8aBkYmkcn98syHRmR19xYz7HgMnNXj6Wj0l3OjZxygxoK6vOMexw8lBZnOy9G
	 G62JnltORFDDjIAF/ZoV58cK+eBnuZ72MBJVghHAiCQ7PEcrgUmjJtlRLPPOxqWa+v
	 7YNDbgRelu4td3ixtpOyO2Q4cbxMToVU+0RRpXeHEunSEutUYT7M4FgJpzhbEA3Lz2
	 OjYwAjbG7XVCcQA0fjJHyBuvhDuV+djliciXr+ESTEYd/Ijt6C+on947a7IhHdWhN+
	 CqKC8MRnqrd/HdPtEmIPzqvXjd3NuaY4Crg9Pse+bH8qrdrbYNNFp3afN95UfvpDIq
	 FdK2BX/aVeZjg==
Date: Mon, 18 Mar 2024 11:43:19 +0000
From: Conor Dooley <conor@kernel.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Atish Patra <atishp@atishpatra.org>,
	Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Qingfang Deng <qingfang.deng@siflower.com.cn>
Subject: Re: [PATCH v2] perf: RISC-V: fix IRQ detection on T-Head C908
Message-ID: <20240318-spoilage-drastic-d58a16c8b9f3@spud>
References: <20240318100241.267857-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ji7VlNa0+B9+NsUi"
Content-Disposition: inline
In-Reply-To: <20240318100241.267857-1-dqfext@gmail.com>


--ji7VlNa0+B9+NsUi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 06:02:40PM +0800, Qingfang Deng wrote:
> From: Qingfang Deng <qingfang.deng@siflower.com.cn>
>=20
> T-Head C908 has the same IRQ num and CSR as previous C9xx cores, but
> reports non-zero marchid and mimpid. Add the check for C908 ID.
>=20
> Fixes: 65e9fb081877 ("drivers/perf: riscv_pmu_sbi: add support for PMU va=
riant on T-Head C9xx cores")
> Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
> ---
> v2: add C908 ID check

If you read the replies to v1 in full, you would see I objected there to
this approach and made suggestions as to how I would like it done:
https://lore.kernel.org/linux-riscv/IA1PR20MB4953CEBE4CB6AC7238849353BB282@=
IA1PR20MB4953.namprd20.prod.outlook.com/

I don't want to see an expansion of these ID checks.

Thanks,
Conor.
>=20
>  arch/riscv/errata/thead/errata.c       | 5 +++--
>  arch/riscv/include/asm/vendorid_list.h | 2 ++
>  drivers/perf/riscv_pmu_sbi.c           | 6 ++++--
>  3 files changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/e=
rrata.c
> index b1c410bbc1ae..da3b34866d8f 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -125,8 +125,9 @@ static bool errata_probe_pmu(unsigned int stage,
>  	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_PMU))
>  		return false;
> =20
> -	/* target-c9xx cores report arch_id and impid as 0 */
> -	if (arch_id !=3D 0 || impid !=3D 0)
> +	/* Early c9xx cores report arch_id and impid as 0 */
> +	if (!((arch_id =3D=3D 0 && impid =3D=3D 0) ||
> +	      (arch_id =3D=3D THEAD_C908_ARCH_ID && impid =3D=3D THEAD_C908_IMP=
_ID)))
>  		return false;
> =20
>  	if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT)
> diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/=
asm/vendorid_list.h
> index 2f2bb0c84f9a..57b3de510d38 100644
> --- a/arch/riscv/include/asm/vendorid_list.h
> +++ b/arch/riscv/include/asm/vendorid_list.h
> @@ -8,5 +8,7 @@
>  #define ANDES_VENDOR_ID		0x31e
>  #define SIFIVE_VENDOR_ID	0x489
>  #define THEAD_VENDOR_ID		0x5b7
> +#define  THEAD_C908_ARCH_ID	0x8000000009140d00
> +#define  THEAD_C908_IMP_ID	0x8a000
> =20
>  #endif
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index bbd6fe021b3a..34d8689982de 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -833,8 +833,10 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu,=
 struct platform_device *pde
>  		riscv_pmu_use_irq =3D true;
>  	} else if (IS_ENABLED(CONFIG_ERRATA_THEAD_PMU) &&
>  		   riscv_cached_mvendorid(0) =3D=3D THEAD_VENDOR_ID &&
> -		   riscv_cached_marchid(0) =3D=3D 0 &&
> -		   riscv_cached_mimpid(0) =3D=3D 0) {
> +		   ((riscv_cached_marchid(0) =3D=3D 0 &&
> +		     riscv_cached_mimpid(0) =3D=3D 0) ||
> +		    (riscv_cached_marchid(0) =3D=3D THEAD_C908_ARCH_ID &&
> +		     riscv_cached_mimpid(0) =3D=3D THEAD_C908_IMP_ID))) {
>  		riscv_pmu_irq_num =3D THEAD_C9XX_RV_IRQ_PMU;
>  		riscv_pmu_use_irq =3D true;
>  	} else if (riscv_isa_extension_available(NULL, XANDESPMU) &&
> --=20
> 2.34.1
>=20
>=20

--ji7VlNa0+B9+NsUi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfgo1wAKCRB4tDGHoIJi
0rEaAQDKUky9LX6dqR7EomEioJbyQIe8qlZhpz+Ik+MYkuLzvwD/cjp4nP0ALNBb
riWgQLQSodPaZRnnTJtbjk2WoMH6Igw=
=LZNq
-----END PGP SIGNATURE-----

--ji7VlNa0+B9+NsUi--

