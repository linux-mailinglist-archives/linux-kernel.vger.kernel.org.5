Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD5280DF2B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345077AbjLKWvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLKWvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:51:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C328C2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:51:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8466DC433C8;
        Mon, 11 Dec 2023 22:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702335068;
        bh=1CCbYByQIoadE0Uqf+KApKn4LZFBzrE7oNUkmsRIU6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aKyFYFp7TmGl8P5u1cOH6e1xl0twZ/fGEwcbqiBlg+eu26ORfM8M5fUCw1B3zVKbC
         BibBHwVGke8ZxpIUuqtOU/hv5CiZ98o9L9un7oxm3l+k3SKDzspADXq3SKuiRIdciu
         6iNKRQLi2yJxAsz0sLVFQHrKizQIvEclvjfJEq+ZYZvMi6adbQ3Hb8VBhBOIOX71Gj
         wscoNoMiOTxH6qQ3kFcoulQj6Rso+RzvT792sjeFp/Dv0l3H+rpKX3fncXEM0WkL8r
         umtVd2NfTO/NF8SYYGXon7pb3b93iTUWK2QW7IcP3lIOAyg0ey+aLLqgpJwTVC+Qec
         u/l3UbwNUFUvw==
Date:   Mon, 11 Dec 2023 22:51:04 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        syzbot+afb726d49f84c8d95ee1@syzkaller.appspotmail.com
Subject: Re: [PATCH -fixes] riscv: Fix wrong usage of lm_alias() when
 splitting a huge linear mapping
Message-ID: <20231211-deviancy-uncooked-6a24328f6200@spud>
References: <20231211141929.74027-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3GQRIqzq/daVXmBi"
Content-Disposition: inline
In-Reply-To: <20231211141929.74027-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3GQRIqzq/daVXmBi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 03:19:29PM +0100, Alexandre Ghiti wrote:
> lm_alias() can only be used on kernel mappings since it explicitly uses
> __pa_symbol(), so simply fix this by checking where the address belongs
> to before.
>=20
> Fixes: 311cd2f6e253 ("riscv: Fix set_memory_XX() and set_direct_map_XX() =
by splitting huge linear mappings")
> Reported-by: syzbot+afb726d49f84c8d95ee1@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-riscv/000000000000620dd0060c02c5e1@=
google.com/
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

=2E./arch/riscv/mm/pageattr.c:311:14: warning: variable 'ret' is used unini=
tialized whenever '&&' condition is false [-Wsometimes-uninitialized]

> ---
>  arch/riscv/mm/pageattr.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> index fc5fc4f785c4..f5f8aa1d38d6 100644
> --- a/arch/riscv/mm/pageattr.c
> +++ b/arch/riscv/mm/pageattr.c
> @@ -304,9 +304,16 @@ static int __set_memory(unsigned long addr, int nump=
ages, pgprot_t set_mask,
>  			if (ret)
>  				goto unlock;
>  		}
> -	} else if (is_kernel_mapping(start) || is_linear_mapping(start)) {
> -		lm_start =3D (unsigned long)lm_alias(start);
> -		lm_end =3D (unsigned long)lm_alias(end);
> +	} else {
> +		if (is_kernel_mapping(start)) {
> +			lm_start =3D (unsigned long)lm_alias(start);
> +			lm_end =3D (unsigned long)lm_alias(end);
> +		} else if (is_linear_mapping(start)) {
> +			lm_start =3D start;
> +			lm_end =3D end;
> +		} else {
> +			goto unlock;
> +		}
> =20
>  		ret =3D split_linear_mapping(lm_start, lm_end);
>  		if (ret)
> --=20
> 2.39.2
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--3GQRIqzq/daVXmBi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXeSWAAKCRB4tDGHoIJi
0sVlAP0T5/oaW6j/LkQ397MBYUvh8Eco7FXATW3thQaTZIN6qgD/XGQBW9AY5sDC
2YwV/oLkT6RTgaar8D58YdjsAjmF+g0=
=g9/e
-----END PGP SIGNATURE-----

--3GQRIqzq/daVXmBi--
