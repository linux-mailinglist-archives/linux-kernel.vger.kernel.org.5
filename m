Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E7A7C6FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378198AbjJLNxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbjJLNxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:53:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A156CCC
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:53:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E23C433C8;
        Thu, 12 Oct 2023 13:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697118828;
        bh=hP9GqwZqyjIq4sKb42+P7KV2OLLkworUneW0yBornWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fvefx2oK536ZNorGowLTjMkKHk2k3yD9e2kpZwo98AvIYEICRLyCPhIf29nkwrpnR
         ZC1i49ZWSBiYvFJ6/0ZYzU2S54KamB0f4SPMskphVOyPBAKN1A8JDu9KO6PCvtdNlt
         yi2zEb8UTUN79+m3xChbh9GSF4N6oaacZPEK7g9Aq598ePdJvTpyYagwocC/1dmPcP
         Sc3PNT9OrPQdxGs9Kt52rILdq/kGPe13MzRPepu6K+/E4dXqcS13xR/hQp+CfY6ry3
         ROD92oxWCLQLu0iowzxF2o5ZsYov+jtFX7+XpSrOA+vVuoJ/Q3v4k2mx9YftGYdc4n
         NQBummIA63znw==
Date:   Thu, 12 Oct 2023 14:53:43 +0100
From:   Conor Dooley <conor@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>
Subject: Re: [PATCH v1 01/13] riscv: fatorize hwprobe ISA extension reporting
Message-ID: <20231012-matriarch-lunar-819c1d2d7996@spud>
References: <20231011111438.909552-1-cleger@rivosinc.com>
 <20231011111438.909552-2-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xH+tnDUwNUWsuXSn"
Content-Disposition: inline
In-Reply-To: <20231011111438.909552-2-cleger@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xH+tnDUwNUWsuXSn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Drew,

On Wed, Oct 11, 2023 at 01:14:26PM +0200, Cl=E9ment L=E9ger wrote:
> Factorize ISA extension reporting by using a macro rather than
> copy/pasting extension names. This will allow adding new extensions more
> easily.
>=20
> Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>
> ---
>  arch/riscv/kernel/sys_riscv.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index 473159b5f303..5ce593ce07a4 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -145,20 +145,18 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *=
pair,
>  	for_each_cpu(cpu, cpus) {

We were gonna add a comment here about when it is and is not safe to use
riscv_isa_extension_available() IIRC. Did that ever end up in a patch?

>  		struct riscv_isainfo *isainfo =3D &hart_isa[cpu];
> =20
> -		if (riscv_isa_extension_available(isainfo->isa, ZBA))
> -			pair->value |=3D RISCV_HWPROBE_EXT_ZBA;
> -		else
> -			missing |=3D RISCV_HWPROBE_EXT_ZBA;
> -
> -		if (riscv_isa_extension_available(isainfo->isa, ZBB))
> -			pair->value |=3D RISCV_HWPROBE_EXT_ZBB;
> -		else
> -			missing |=3D RISCV_HWPROBE_EXT_ZBB;
> -
> -		if (riscv_isa_extension_available(isainfo->isa, ZBS))
> -			pair->value |=3D RISCV_HWPROBE_EXT_ZBS;
> -		else
> -			missing |=3D RISCV_HWPROBE_EXT_ZBS;
> +#define CHECK_ISA_EXT(__ext)							\
> +		do {								\
> +			if (riscv_isa_extension_available(isainfo->isa, __ext))	\
> +				pair->value |=3D RISCV_HWPROBE_EXT_##__ext;	\
> +			else							\
> +				missing |=3D RISCV_HWPROBE_EXT_##__ext;		\
> +		} while (false)							\
> +
> +		CHECK_ISA_EXT(ZBA);
> +		CHECK_ISA_EXT(ZBB);
> +		CHECK_ISA_EXT(ZBS);
> +#undef CHECK_ISA_EXT
>  	}
> =20
>  	/* Now turn off reporting features if any CPU is missing it. */
> --=20
> 2.42.0
>=20

--xH+tnDUwNUWsuXSn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSf6ZwAKCRB4tDGHoIJi
0m+/AP9ncEcT+S7hTOAm1/bJAmNgKIbBFzM/wJ3YY5BPw5CNKgEA2hrCjToDKu8e
AHSxLFlyN1+JaoW5jsDmgdNiEDjzPwc=
=IToO
-----END PGP SIGNATURE-----

--xH+tnDUwNUWsuXSn--
