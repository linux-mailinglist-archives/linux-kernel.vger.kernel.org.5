Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093FE7CBC02
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbjJQHIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbjJQHId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:08:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B7893
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:08:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45D9C433C7;
        Tue, 17 Oct 2023 07:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697526510;
        bh=KyBU6dt3CYdf3enQHahqiAZWcsaI56HgRKHkTWUgbgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nFkzCvI+aRqCWBg3782OqkE7/IaOGSk+bwDUQMjHApV9+XqtBI+W1GuuOAaHkAVS9
         rHyN3swWPE0c1nObG2eOnK4aao0b58IYHChYgkrAAVLKzW9OXoWxb12K3f9CxIqJbY
         ejJKxQjITsFEuAlfmzKg32UwA1QHKUZHBWZJMuGYGck9oHiSvLZBlsFoTkAiLisxFf
         gyS3I5bWfW8he/eLTKNtVknma2uYsX80Tbcl7AvTkjmxrvC4SFRPcDmEeeCabL3sNz
         TG7mMP3skXidcJisMhmmzqcs1lRpnPRuD6PNRH4NnLIaEF05fiXee+EXl09bObY60/
         MZ6pVIOwI8CtA==
Date:   Tue, 17 Oct 2023 08:08:26 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v3 1/2] riscv: Add remaining module relocations
Message-ID: <20231017-heaviness-husked-f3b81d5ecdfb@spud>
References: <20231016-module_relocations-v3-0-a667fd6071e9@rivosinc.com>
 <20231016-module_relocations-v3-1-a667fd6071e9@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wrP/R5I4xDPUBiaw"
Content-Disposition: inline
In-Reply-To: <20231016-module_relocations-v3-1-a667fd6071e9@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wrP/R5I4xDPUBiaw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 10:36:09AM -0700, Charlie Jenkins wrote:
> Add all final module relocations and add error logs explaining the ones
> that are not supported.

In the patchwork automation's clang/llvm allmodconfig:
 ../arch/riscv/kernel/tests/module_test/test_uleb128.S:18:17: error: unknow=
n relocation name
 ../arch/riscv/kernel/tests/module_test/test_uleb128.S:19:17: error: unknow=
n relocation name

(llvm-17 iirc)

Cheers,
Conor.

>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/include/uapi/asm/elf.h |   6 +-
>  arch/riscv/kernel/module.c        | 207 ++++++++++++++++++++++++++++++++=
+-----
>  2 files changed, 187 insertions(+), 26 deletions(-)
>=20
> diff --git a/arch/riscv/include/uapi/asm/elf.h b/arch/riscv/include/uapi/=
asm/elf.h
> index d696d6610231..a9307a1c9ceb 100644
> --- a/arch/riscv/include/uapi/asm/elf.h
> +++ b/arch/riscv/include/uapi/asm/elf.h
> @@ -49,6 +49,7 @@ typedef union __riscv_fp_state elf_fpregset_t;
>  #define R_RISCV_TLS_DTPREL64	9
>  #define R_RISCV_TLS_TPREL32	10
>  #define R_RISCV_TLS_TPREL64	11
> +#define R_RISCV_IRELATIVE	58
> =20
>  /* Relocation types not used by the dynamic linker */
>  #define R_RISCV_BRANCH		16
> @@ -81,7 +82,7 @@ typedef union __riscv_fp_state elf_fpregset_t;
>  #define R_RISCV_ALIGN		43
>  #define R_RISCV_RVC_BRANCH	44
>  #define R_RISCV_RVC_JUMP	45
> -#define R_RISCV_LUI		46
> +#define R_RISCV_RVC_LUI		46
>  #define R_RISCV_GPREL_I		47
>  #define R_RISCV_GPREL_S		48
>  #define R_RISCV_TPREL_I		49
> @@ -93,6 +94,9 @@ typedef union __riscv_fp_state elf_fpregset_t;
>  #define R_RISCV_SET16		55
>  #define R_RISCV_SET32		56
>  #define R_RISCV_32_PCREL	57
> +#define R_RISCV_PLT32		59
> +#define R_RISCV_SET_ULEB128	60
> +#define R_RISCV_SUB_ULEB128	61
> =20
> =20
>  #endif /* _UAPI_ASM_RISCV_ELF_H */
> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> index 7c651d55fcbd..73f47de538d2 100644
> --- a/arch/riscv/kernel/module.c
> +++ b/arch/riscv/kernel/module.c
> @@ -7,6 +7,7 @@
>  #include <linux/elf.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
> +#include <linux/kernel.h>
>  #include <linux/moduleloader.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sizes.h>
> @@ -268,6 +269,12 @@ static int apply_r_riscv_align_rela(struct module *m=
e, u32 *location,
>  	return -EINVAL;
>  }
> =20
> +static int apply_r_riscv_add8_rela(struct module *me, u32 *location, Elf=
_Addr v)
> +{
> +	*(u8 *)location +=3D (u8)v;
> +	return 0;
> +}
> +
>  static int apply_r_riscv_add16_rela(struct module *me, u32 *location,
>  				    Elf_Addr v)
>  {
> @@ -289,6 +296,12 @@ static int apply_r_riscv_add64_rela(struct module *m=
e, u32 *location,
>  	return 0;
>  }
> =20
> +static int apply_r_riscv_sub8_rela(struct module *me, u32 *location, Elf=
_Addr v)
> +{
> +	*(u8 *)location -=3D (u8)v;
> +	return 0;
> +}
> +
>  static int apply_r_riscv_sub16_rela(struct module *me, u32 *location,
>  				    Elf_Addr v)
>  {
> @@ -310,31 +323,149 @@ static int apply_r_riscv_sub64_rela(struct module =
*me, u32 *location,
>  	return 0;
>  }
> =20
> -static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
> -				Elf_Addr v) =3D {
> -	[R_RISCV_32]			=3D apply_r_riscv_32_rela,
> -	[R_RISCV_64]			=3D apply_r_riscv_64_rela,
> -	[R_RISCV_BRANCH]		=3D apply_r_riscv_branch_rela,
> -	[R_RISCV_JAL]			=3D apply_r_riscv_jal_rela,
> -	[R_RISCV_RVC_BRANCH]		=3D apply_r_riscv_rvc_branch_rela,
> -	[R_RISCV_RVC_JUMP]		=3D apply_r_riscv_rvc_jump_rela,
> -	[R_RISCV_PCREL_HI20]		=3D apply_r_riscv_pcrel_hi20_rela,
> -	[R_RISCV_PCREL_LO12_I]		=3D apply_r_riscv_pcrel_lo12_i_rela,
> -	[R_RISCV_PCREL_LO12_S]		=3D apply_r_riscv_pcrel_lo12_s_rela,
> -	[R_RISCV_HI20]			=3D apply_r_riscv_hi20_rela,
> -	[R_RISCV_LO12_I]		=3D apply_r_riscv_lo12_i_rela,
> -	[R_RISCV_LO12_S]		=3D apply_r_riscv_lo12_s_rela,
> -	[R_RISCV_GOT_HI20]		=3D apply_r_riscv_got_hi20_rela,
> -	[R_RISCV_CALL_PLT]		=3D apply_r_riscv_call_plt_rela,
> -	[R_RISCV_CALL]			=3D apply_r_riscv_call_rela,
> -	[R_RISCV_RELAX]			=3D apply_r_riscv_relax_rela,
> -	[R_RISCV_ALIGN]			=3D apply_r_riscv_align_rela,
> -	[R_RISCV_ADD16]			=3D apply_r_riscv_add16_rela,
> -	[R_RISCV_ADD32]			=3D apply_r_riscv_add32_rela,
> -	[R_RISCV_ADD64]			=3D apply_r_riscv_add64_rela,
> -	[R_RISCV_SUB16]			=3D apply_r_riscv_sub16_rela,
> -	[R_RISCV_SUB32]			=3D apply_r_riscv_sub32_rela,
> -	[R_RISCV_SUB64]			=3D apply_r_riscv_sub64_rela,
> +static int dynamic_linking_not_supported(struct module *me, u32 *locatio=
n,
> +					 Elf_Addr v)
> +{
> +	pr_err("%s: Dynamic linking not supported in kernel modules PC =3D %p\n=
",
> +	       me->name, location);
> +	return -EINVAL;
> +}
> +
> +static int tls_not_supported(struct module *me, u32 *location, Elf_Addr =
v)
> +{
> +	pr_err("%s: Thread local storage not supported in kernel modules PC =3D=
 %p\n",
> +	       me->name, location);
> +	return -EINVAL;
> +}
> +
> +static int apply_r_riscv_sub6_rela(struct module *me, u32 *location, Elf=
_Addr v)
> +{
> +	*(u8 *)location -=3D (u8)v & 0x3F;
> +	return 0;
> +}
> +
> +static int apply_r_riscv_set6_rela(struct module *me, u32 *location, Elf=
_Addr v)
> +{
> +	*(u8 *)location =3D (*(u8 *)location & 0xc0) | ((u8)v & 0x3F);
> +	return 0;
> +}
> +
> +static int apply_r_riscv_set8_rela(struct module *me, u32 *location, Elf=
_Addr v)
> +{
> +	*(u8 *)location =3D (u8)v;
> +	return 0;
> +}
> +
> +static int apply_r_riscv_set16_rela(struct module *me, u32 *location,
> +				    Elf_Addr v)
> +{
> +	*(u16 *)location =3D (u16)v;
> +	return 0;
> +}
> +
> +static int apply_r_riscv_set32_rela(struct module *me, u32 *location,
> +				    Elf_Addr v)
> +{
> +	*(u32 *)location =3D (u32)v;
> +	return 0;
> +}
> +
> +static int apply_r_riscv_32_pcrel_rela(struct module *me, u32 *location,
> +				       Elf_Addr v)
> +{
> +	*(u32 *)location =3D (u32)v;
> +	return 0;
> +}
> +
> +static int apply_r_riscv_plt32_rela(struct module *me, u32 *location,
> +				    Elf_Addr v)
> +{
> +	*(u32 *)location =3D (u32)v;
> +	return 0;
> +}
> +
> +static int apply_r_riscv_set_uleb128(struct module *me, u32 *location, E=
lf_Addr v)
> +{
> +	/*
> +	 * Relocation is only performed if R_RISCV_SET_ULEB128 is followed by
> +	 * R_RISCV_SUB_ULEB128 so do computation there
> +	 */
> +	return 0;
> +}
> +
> +static int apply_r_riscv_sub_uleb128(struct module *me, u32 *location, E=
lf_Addr v)
> +{
> +	if (v >=3D 128) {
> +		pr_err("%s: uleb128 must be in [0, 127] (not %ld) at PC =3D %p\n",
> +		       me->name, (unsigned long)v, location);
> +		return -EINVAL;
> +	}
> +
> +	*location =3D v;
> +	return 0;
> +}
> +
> +/*
> + * Relocations defined in the riscv-elf-psabi-doc.
> + * This handles static linking only.
> + */
> +static int (*reloc_handlers_rela[])(struct module *me, u32 *location,
> +				    Elf_Addr v) =3D {
> +	[R_RISCV_32] =3D			apply_r_riscv_32_rela,
> +	[R_RISCV_64] =3D			apply_r_riscv_64_rela,
> +	[R_RISCV_RELATIVE] =3D		dynamic_linking_not_supported,
> +	[R_RISCV_COPY] =3D		dynamic_linking_not_supported,
> +	[R_RISCV_JUMP_SLOT] =3D		dynamic_linking_not_supported,
> +	[R_RISCV_TLS_DTPMOD32] =3D	dynamic_linking_not_supported,
> +	[R_RISCV_TLS_DTPMOD64] =3D	dynamic_linking_not_supported,
> +	[R_RISCV_TLS_DTPREL32] =3D	dynamic_linking_not_supported,
> +	[R_RISCV_TLS_DTPREL64] =3D	dynamic_linking_not_supported,
> +	[R_RISCV_TLS_TPREL32] =3D		dynamic_linking_not_supported,
> +	[R_RISCV_TLS_TPREL64] =3D		dynamic_linking_not_supported,
> +	/* 12-15 undefined */
> +	[R_RISCV_BRANCH] =3D		apply_r_riscv_branch_rela,
> +	[R_RISCV_JAL] =3D			apply_r_riscv_jal_rela,
> +	[R_RISCV_CALL] =3D		apply_r_riscv_call_rela,
> +	[R_RISCV_CALL_PLT] =3D		apply_r_riscv_call_plt_rela,
> +	[R_RISCV_GOT_HI20] =3D		apply_r_riscv_got_hi20_rela,
> +	[R_RISCV_TLS_GOT_HI20] =3D	tls_not_supported,
> +	[R_RISCV_TLS_GD_HI20] =3D		tls_not_supported,
> +	[R_RISCV_PCREL_HI20] =3D		apply_r_riscv_pcrel_hi20_rela,
> +	[R_RISCV_PCREL_LO12_I] =3D	apply_r_riscv_pcrel_lo12_i_rela,
> +	[R_RISCV_PCREL_LO12_S] =3D	apply_r_riscv_pcrel_lo12_s_rela,
> +	[R_RISCV_HI20] =3D		apply_r_riscv_hi20_rela,
> +	[R_RISCV_LO12_I] =3D		apply_r_riscv_lo12_i_rela,
> +	[R_RISCV_LO12_S] =3D		apply_r_riscv_lo12_s_rela,
> +	[R_RISCV_TPREL_HI20] =3D		tls_not_supported,
> +	[R_RISCV_TPREL_LO12_I] =3D	tls_not_supported,
> +	[R_RISCV_TPREL_LO12_S] =3D	tls_not_supported,
> +	[R_RISCV_TPREL_ADD] =3D		tls_not_supported,
> +	[R_RISCV_ADD8] =3D		apply_r_riscv_add8_rela,
> +	[R_RISCV_ADD16] =3D		apply_r_riscv_add16_rela,
> +	[R_RISCV_ADD32] =3D		apply_r_riscv_add32_rela,
> +	[R_RISCV_ADD64] =3D		apply_r_riscv_add64_rela,
> +	[R_RISCV_SUB8] =3D		apply_r_riscv_sub8_rela,
> +	[R_RISCV_SUB16] =3D		apply_r_riscv_sub16_rela,
> +	[R_RISCV_SUB32] =3D		apply_r_riscv_sub32_rela,
> +	[R_RISCV_SUB64] =3D		apply_r_riscv_sub64_rela,
> +	/* 41-42 reserved for future standard use */
> +	[R_RISCV_ALIGN] =3D		apply_r_riscv_align_rela,
> +	[R_RISCV_RVC_BRANCH] =3D		apply_r_riscv_rvc_branch_rela,
> +	[R_RISCV_RVC_JUMP] =3D		apply_r_riscv_rvc_jump_rela,
> +	/* 46-50 reserved for future standard use */
> +	[R_RISCV_RELAX] =3D		apply_r_riscv_relax_rela,
> +	[R_RISCV_SUB6] =3D		apply_r_riscv_sub6_rela,
> +	[R_RISCV_SET6] =3D		apply_r_riscv_set6_rela,
> +	[R_RISCV_SET8] =3D		apply_r_riscv_set8_rela,
> +	[R_RISCV_SET16] =3D		apply_r_riscv_set16_rela,
> +	[R_RISCV_SET32] =3D		apply_r_riscv_set32_rela,
> +	[R_RISCV_32_PCREL] =3D		apply_r_riscv_32_pcrel_rela,
> +	[R_RISCV_IRELATIVE] =3D		dynamic_linking_not_supported,
> +	[R_RISCV_PLT32] =3D		apply_r_riscv_plt32_rela,
> +	[R_RISCV_SET_ULEB128] =3D		apply_r_riscv_set_uleb128,
> +	[R_RISCV_SUB_ULEB128] =3D		apply_r_riscv_sub_uleb128,
> +	/* 62-191 reserved for future standard use */
> +	/* 192-255 nonstandard ABI extensions  */
>  };
> =20
>  int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
> @@ -348,6 +479,10 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char=
 *strtab,
>  	unsigned int i, type;
>  	Elf_Addr v;
>  	int res;
> +	bool uleb128_set_exists =3D false;
> +	u32 *uleb128_set_loc;
> +	unsigned long uleb128_set_sym_val;
> +
> =20
>  	pr_debug("Applying relocate section %u to %u\n", relsec,
>  	       sechdrs[relsec].sh_info);
> @@ -425,6 +560,28 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char=
 *strtab,
>  				  me->name);
>  				return -EINVAL;
>  			}
> +		} else if (type =3D=3D R_RISCV_SET_ULEB128) {
> +			if (uleb128_set_exists) {
> +				pr_err("%s: riscv psABI requires the next ULEB128 relocation to come=
 after a R_RISCV_SET_ULEB128 is an R_RISCV_SUB_ULEB128, not another R_RISCV=
_SET_ULEB128.\n",
> +				       me->name);
> +				return -EINVAL;
> +			}
> +			uleb128_set_exists =3D true;
> +			uleb128_set_loc =3D location;
> +			uleb128_set_sym_val =3D
> +				((Elf_Sym *)sechdrs[symindex].sh_addr +
> +					ELF_RISCV_R_SYM(rel[i].r_info))
> +					->st_value +
> +				rel[i].r_addend;
> +		} else if (type =3D=3D R_RISCV_SUB_ULEB128) {
> +			if (uleb128_set_exists && uleb128_set_loc =3D=3D location) {
> +				/* Calculate set and subtraction */
> +				v =3D uleb128_set_sym_val - v;
> +			} else {
> +				pr_err("%s: R_RISCV_SUB_ULEB128 must always be paired with the first=
 R_RISCV_SET_ULEB128 that comes before it. PC =3D %p\n",
> +				       me->name, location);
> +				return -EINVAL;
> +			}
>  		}
> =20
>  		res =3D handler(me, location, v);
>=20
> --=20
> 2.42.0
>=20

--wrP/R5I4xDPUBiaw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZS4y6gAKCRB4tDGHoIJi
0g/RAP4prTIEikwmfjarUNEQ6nHJtim9Tu3JCem9U9E9/JJXbQEArn/9WuTDuBoE
eprdkrTp9Z5k07NPzsU3VKQnnsLyCg0=
=wjaz
-----END PGP SIGNATURE-----

--wrP/R5I4xDPUBiaw--
