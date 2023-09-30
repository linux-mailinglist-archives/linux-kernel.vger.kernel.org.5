Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239647B3FA3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 11:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjI3JOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 05:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjI3JOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 05:14:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6995FBF
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 02:14:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABD2C433C8;
        Sat, 30 Sep 2023 09:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696065279;
        bh=26DZrEFmmX7RPrQtrMeeSVZD6kM5LM3HQlhgRqueXPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aMA4lonEOQcec+Y8U5X5uNPY9wy9SAqm8cvrp3N/D9OQuPojEY5CMrfbFvlHeVuIC
         kDJXYuyKlcCJ09Q6e+/O4OtuyfcTo3Sdchh8MdtED0rM3RfnGVy1IgVcio5HfJ8pRQ
         EEbw7emfAhc93brMUsc/bz40LDdaLvuafpZpjP7FHA6d7lAzfGBCLvpgUUjgwTsk+u
         Ju35FdtKswl6b5xzXTQmORx5HMH2sR3mIPpCxm4NCR+LFC2jLXEFVkXC6tKoVe1LPE
         A2MGxiwjheZxsMF6x/TIR9bzxlK+Jx6iRe/Fctnsi4P+OrFZuAm5lzLHxG/o9vZijG
         0OIkeo9dbixxw==
Date:   Sat, 30 Sep 2023 10:14:34 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes 2/2] riscv: Fix set_huge_pte_at() for NAPOT
 mappings when a swap entry is set
Message-ID: <20230930-unnoticed-slacked-0bf5696cc265@spud>
References: <20230928151846.8229-1-alexghiti@rivosinc.com>
 <20230928151846.8229-3-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5QYzZhHNu7GI5bSx"
Content-Disposition: inline
In-Reply-To: <20230928151846.8229-3-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5QYzZhHNu7GI5bSx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 05:18:46PM +0200, Alexandre Ghiti wrote:
> We used to determine the number of page table entries to set for a NAPOT
> hugepage by using the pte value which actually fails when the pte to set =
is
> a swap entry.
>=20
> So take advantage of a recent fix for arm64 reported in [1] which
> introduces the size of the mapping as an argument of set_huge_pte_at(): we
> can then use this size to compute the number of page table entries to set
> for a NAPOT region.
>=20
> Fixes: 82a1a1f3bfb6 ("riscv: mm: support Svnapot in hugetlb page")
> Reported-by: Ryan Roberts <ryan.roberts@arm.com>
> Closes: https://lore.kernel.org/linux-arm-kernel/20230922115804.2043771-1=
-ryan.roberts@arm.com/ [1]
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Breaks the build. Your $subject marks this for -fixes, but this will not
build there, as it relies on content that's not yet in that branch.
AFAICT, you're going to have to resend this with akpm on CC, as the
dependency is in his tree...

Thanks,
Conor.

> ---
>  arch/riscv/mm/hugetlbpage.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
> index e4a2ace92dbe..b52f0210481f 100644
> --- a/arch/riscv/mm/hugetlbpage.c
> +++ b/arch/riscv/mm/hugetlbpage.c
> @@ -183,15 +183,22 @@ void set_huge_pte_at(struct mm_struct *mm,
>  		     pte_t pte,
>  		     unsigned long sz)
>  {
> +	unsigned long hugepage_shift;
>  	int i, pte_num;
> =20
> -	if (!pte_napot(pte)) {
> -		set_pte_at(mm, addr, ptep, pte);
> -		return;
> -	}
> +	if (sz >=3D PGDIR_SIZE)
> +		hugepage_shift =3D PGDIR_SHIFT;
> +	else if (sz >=3D P4D_SIZE)
> +		hugepage_shift =3D P4D_SHIFT;
> +	else if (sz >=3D PUD_SIZE)
> +		hugepage_shift =3D PUD_SHIFT;
> +	else if (sz >=3D PMD_SIZE)
> +		hugepage_shift =3D PMD_SHIFT;
> +	else
> +		hugepage_shift =3D PAGE_SHIFT;
> =20
> -	pte_num =3D napot_pte_num(napot_cont_order(pte));
> -	for (i =3D 0; i < pte_num; i++, ptep++, addr +=3D PAGE_SIZE)
> +	pte_num =3D sz >> hugepage_shift;
> +	for (i =3D 0; i < pte_num; i++, ptep++, addr +=3D (1 << hugepage_shift))
>  		set_pte_at(mm, addr, ptep, pte);
>  }
> =20
> --=20
> 2.39.2
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--5QYzZhHNu7GI5bSx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRfm+gAKCRB4tDGHoIJi
0m0zAP91gvh8xVeSCkLcZbXEq+3qnMduthZnz3KibSQU6EOWGQD/ZuPEswXNV4uy
bVcB6Egf+5E3mB3MeG1hbuQ6lvtluQ0=
=1QHA
-----END PGP SIGNATURE-----

--5QYzZhHNu7GI5bSx--
