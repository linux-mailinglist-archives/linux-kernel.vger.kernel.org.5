Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEE276BF44
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjHAV1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjHAV11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:27:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302532D76;
        Tue,  1 Aug 2023 14:26:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 030CA61725;
        Tue,  1 Aug 2023 21:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858F0C433C7;
        Tue,  1 Aug 2023 21:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690925215;
        bh=U7dgv/gPFnq41YcNLCjZJ9Dek6jtsS7j5lqt4+JbTiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sYVMYqI8ku7coxbeBTKK7hRfA49OR3QLOgz6i72/RP6nrl7MfBnFv6cjkTK7/dIRx
         lpHMfk9kxqV/4xq2+UakllZn2qdNG5ahkPcfwgRQAoBX60hsfahMPAIALjrvKLQ340
         jxNlBjsxcB3B33nfe5QPyf+n+bOJY/ub1Rfg+CHeFCPRFnRDo5UsfSgkIbcy6mGJHI
         9ffkJGjiwTP0hmX/0pJqSWstflSzihGHj/J5XiOgNgHMdV5ZSYSIonOAyRVYjIqKc2
         bRh8TL824Wr5qQhYEH6G+jYsUnV6T5pMWxLZQnAOdgcH/aIPyi1l3VozOx2GV8z9HG
         nWooAjahUjFEg==
Date:   Tue, 1 Aug 2023 22:26:51 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] RISC-V: cpu: refactor deprecated strncpy
Message-ID: <20230801-tinsel-parcel-aa034d07aeb6@spud>
References: <20230801-arch-riscv-kernel-v1-1-2b3f2dc0bc61@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YnHqtxQiKmZEKon/"
Content-Disposition: inline
In-Reply-To: <20230801-arch-riscv-kernel-v1-1-2b3f2dc0bc61@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YnHqtxQiKmZEKon/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Justin,

On Tue, Aug 01, 2023 at 09:14:56PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
>=20
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ the case for `strncpy`!
>=20
> The `sv_type` buffer is declared with a size of 16 which is then
> followed by some `strncpy` calls to populate the buffer with one of:
> "sv32", "sv57", "sv48", "sv39" or "none". Hard-coding the max length as 5=
 is
> error-prone and involves counting the number of characters (and
> hopefully not forgetting to count the NUL-byte) in the raw string.

What is error prone about it when there are only 4 characters possible?

> Using a pre-determined max length in combination with `strscpy` provides
> a cleaner, less error-prone as well as a less ambiguous implementation.
> `strscpy` guarantees that it's destination buffer is NUL-terminated even
> if it's source argument exceeds the max length as defined by the third

Wrong its ;)

> argument.
>=20
> To be clear, there is no bug (i think?) in the current implementation
> but the current hard-coded values in combination with using a deprecated
> interface make this a worthwhile change, IMO.
>=20
> [1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nu=
l-terminated-strings
> [2]: manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html

This link is broken, it should be
https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html

Also, in the future, please use the form

Link: <url> [ref]

so

Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.htm=
l [1]

and so on.

> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  arch/riscv/kernel/cpu.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index a2fc952318e9..1c576e4ec171 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -17,6 +17,8 @@
>  #include <asm/smp.h>
>  #include <asm/pgtable.h>
> =20
> +#define SV_TYPE_MAX_LENGTH 16
> +
>  /*
>   * Returns the hart ID of the given device tree node, or -ENODEV if the =
node
>   * isn't an enabled and valid RISC-V hart node.
> @@ -271,21 +273,21 @@ static void print_isa(struct seq_file *f, const cha=
r *isa)
> =20
>  static void print_mmu(struct seq_file *f)
>  {
> -	char sv_type[16];
> +	char sv_type[SV_TYPE_MAX_LENGTH];
> =20
>  #ifdef CONFIG_MMU
>  #if defined(CONFIG_32BIT)
> -	strncpy(sv_type, "sv32", 5);
> +	strscpy(sv_type, "sv32", SV_TYPE_MAX_LENGTH);
>  #elif defined(CONFIG_64BIT)
>  	if (pgtable_l5_enabled)
> -		strncpy(sv_type, "sv57", 5);
> +		strscpy(sv_type, "sv57", SV_TYPE_MAX_LENGTH);
>  	else if (pgtable_l4_enabled)
> -		strncpy(sv_type, "sv48", 5);
> +		strscpy(sv_type, "sv48", SV_TYPE_MAX_LENGTH);
>  	else
> -		strncpy(sv_type, "sv39", 5);
> +		strscpy(sv_type, "sv39", SV_TYPE_MAX_LENGTH);
>  #endif
>  #else
> -	strncpy(sv_type, "none", 5);
> +	strscpy(sv_type, "none", SV_TYPE_MAX_LENGTH);
>  #endif /* CONFIG_MMU */
>  	seq_printf(f, "mmu\t\t: %s\n", sv_type);
>  }

This all seems rather horrible, we should probably clean it up, but that
is nothing to do with your patch. To be clear, I am also not requesting a
resubmission for the commit message nitpickery.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--YnHqtxQiKmZEKon/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMl4mwAKCRB4tDGHoIJi
0pVoAQDmQjneDXMF/O2Z8naa/wVqe4BsEZNuH50zc6EEaEGVugEAoYPeFRvmv4Sk
/xr+fzJ+L6ng3taifnrp/hJz1yzc+wI=
=S5Oo
-----END PGP SIGNATURE-----

--YnHqtxQiKmZEKon/--
