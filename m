Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAAC79D5BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbjILQFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236583AbjILQFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:05:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8215310F4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:05:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC93C433C9;
        Tue, 12 Sep 2023 16:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694534703;
        bh=V/1P+uTkR8Y9g1C/QHoT7Uh+1sU48lnS8kVD/6SqiCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NmXTqIGpIwYO31/9VBlYWASYynSAFUM+Ty8dKyuTb9B2Y3tjsTjZYDJWGvYjris1o
         8c4IlC2f3R6fzW/wUjndVss/3BF0QyvvvB+Xrwp6ku5ngJFBXa0BhK3l9e2ZbH7zRk
         0C7ee/mvNbYmnUmRBFAvtJzKCn3sh+RABt+x2UWAhbfsMGnW2JyQLIzosDpbw9taeQ
         ea6GXM89MTdJqMsMm0FVJyW16Vy06Y0ubKAVBtx96+IKvSqUolY2cACs7RVW+9Ol4Q
         fJwuClsvs7Sm//NAAGPt34Drmyj/PqCJPSg/Sr4fLqQ4VpyMQVY5gVD084O2wJduYn
         1AMZ9Y4xlv38A==
Date:   Tue, 12 Sep 2023 17:04:59 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: don't probe unaligned access speed if already done
Message-ID: <20230912-shakiness-denture-69165e10017b@spud>
References: <20230912154040.3306-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Pjl3/Zy2tSNUUoky"
Content-Disposition: inline
In-Reply-To: <20230912154040.3306-1-jszhang@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pjl3/Zy2tSNUUoky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 11:40:40PM +0800, Jisheng Zhang wrote:
> If misaligned_access_speed percpu var isn't so called "HWPROBE
> MISALIGNED UNKNOWN", it means the probe has happened(this is possible
> for example, hotplug off then hotplug on one cpu), and the percpu var
> has been set, don't probe again in this case.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Presumably this should grow a
Fixes: 584ea6564bca ("RISC-V: Probe for unaligned access speed")
on application.
Patch seems fine to me,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  arch/riscv/kernel/cpufeature.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 1cfbba65d11a..e12cd22755c7 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -568,6 +568,10 @@ void check_unaligned_access(int cpu)
>  	void *src;
>  	long speed =3D RISCV_HWPROBE_MISALIGNED_SLOW;
> =20
> +	/* We are already set since the last check */
> +	if (per_cpu(misaligned_access_speed, cpu) !=3D RISCV_HWPROBE_MISALIGNED=
_UNKNOWN)
> +		return;
> +
>  	page =3D alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_SIZE));
>  	if (!page) {
>  		pr_warn("Can't alloc pages to measure memcpy performance");
> --=20
> 2.40.1
>=20

--Pjl3/Zy2tSNUUoky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQCMKwAKCRB4tDGHoIJi
0u2AAQDJXOTr4V+Guyy1WrFy+wQZS9QXv/enoUWBKD8RMS/HQwD9FkWGDjRftaQq
WyroihCwFRCqRRdB5Bq1/KLYbw2ScQs=
=w02h
-----END PGP SIGNATURE-----

--Pjl3/Zy2tSNUUoky--
