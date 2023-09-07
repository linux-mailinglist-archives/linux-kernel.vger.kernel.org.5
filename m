Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4593F79778D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbjIGQ1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236774AbjIGQ0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:26:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC2E61B5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:22:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F35CC433BA;
        Thu,  7 Sep 2023 09:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694080080;
        bh=ioGfmHzP2GjyiqSrlbgIeRZSwKKtv0WFrj6DT7aSlks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mLg+V3E9qaY9ombLvd77WkJ4/u93T3ZxXYPB4JdXuB2oOzxLDlNH9me5cEiN8IEDD
         hgdcdLXevKfMKThzJM3m0rYD9+Ykd5RhvO6XkbmVQ3PBaJKr+e5VHPHJVgj8FSMtqh
         seudiFFp8FoptyZa7+75TrW0fR3Kqzi4Ddu8I1Pv3m8x4haMO+ce/alSOsvuWix0vn
         mlfkBLMWtqfw88o/g6UpO5As/0Hq8PDu2TIysni9GCEfqpMNA7Pz7fB9XBNw3RoHgl
         6XBIZDE/7Ok4eCoxfG8mDSQELRd/uBlK54ZtotPlOlmfTPFBkJiRSwLAkPjdhKXxBt
         IpVH2dLHk7Dpg==
Date:   Thu, 7 Sep 2023 10:47:55 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v2 3/5] riscv: Vector checksum header
Message-ID: <20230907-c23868a1016a17299a470120@fedora>
References: <20230905-optimize_checksum-v2-0-ccd658db743b@rivosinc.com>
 <20230905-optimize_checksum-v2-3-ccd658db743b@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yWEbZ60EvanaedV2"
Content-Disposition: inline
In-Reply-To: <20230905-optimize_checksum-v2-3-ccd658db743b@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yWEbZ60EvanaedV2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 05, 2023 at 09:46:52PM -0700, Charlie Jenkins wrote:
> Vector code is written in assembly rather than using the GCC vector
> instrinsics because they did not provide optimal code. Vector
> instrinsic types are still used so the inline assembly can
> appropriately select vector registers. However, this code cannot be
> merged yet because it is currently not possible to use vector
> instrinsics in the kernel because vector support needs to be directly
> enabled by assembly.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/include/asm/checksum.h | 87 +++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 87 insertions(+)
>=20
> diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/c=
hecksum.h
> index 3f9d5a202e95..1d6c23cd1221 100644
> --- a/arch/riscv/include/asm/checksum.h
> +++ b/arch/riscv/include/asm/checksum.h
> @@ -10,6 +10,10 @@
>  #include <linux/in6.h>
>  #include <linux/uaccess.h>
> =20
> +#ifdef CONFIG_RISCV_ISA_V
> +#include <riscv_vector.h>
> +#endif
> +
>  #ifdef CONFIG_32BIT
>  typedef unsigned int csum_t;
>  #else
> @@ -43,6 +47,89 @@ static inline __sum16 csum_fold(__wsum sum)
>   */
>  static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
>  {
> +#ifdef CONFIG_RISCV_ISA_V
> +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> +		/*
> +		 * Vector is likely available when the kernel is compiled with
> +		 * vector support, so nop when vector is available and jump when
> +		 * vector is not available.
> +		 */
> +		asm_volatile_goto(ALTERNATIVE("j %l[no_vector]", "nop", 0,
> +					      RISCV_ISA_EXT_v, 1)
> +				  :
> +				  :
> +				  :
> +				  : no_vector);
> +	} else {
> +		if (!__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_v))
> +			goto no_vector;
> +	}

Silly question maybe, but is this complexity required?
If you were to go and do
	if (!has_vector())
		goto no_vector
is there any meaningful difference difference in performance?


> +
> +	vuint64m1_t prev_buffer;
> +	vuint32m1_t curr_buffer;
> +	unsigned int vl;
> +#ifdef CONFIG_32_BIT
> +	csum_t high_result, low_result;
> +
> +	riscv_v_enable();
> +	asm(".option push						\n\
> +	.option arch, +v						\n\
> +	vsetivli x0, 1, e64, ta, ma					\n\
> +	vmv.v.i %[prev_buffer], 0					\n\
> +	1:								\n\
> +	vsetvli %[vl], %[ihl], e32, m1, ta, ma				\n\
> +	vle32.v %[curr_buffer], (%[iph])				\n\
> +	vwredsumu.vs %[prev_buffer], %[curr_buffer], %[prev_buffer]	\n\
> +	sub %[ihl], %[ihl], %[vl]					\n\
> +	slli %[vl], %[vl], 2						\n\

Also, could you please try to align the operands for asm stuff?
It makes quite a difference to readability.

Thanks,
Conor.

> +	add %[iph], %[vl], %[iph]					\n\
> +	# If not all of iph could fit into vector reg, do another sum	\n\
> +	bne %[ihl], zero, 1b						\n\
> +	vsetivli x0, 1, e64, m1, ta, ma					\n\
> +	vmv.x.s %[low_result], %[prev_buffer]				\n\
> +	addi %[vl], x0, 32						\n\
> +	vsrl.vx %[prev_buffer], %[prev_buffer], %[vl]			\n\
> +	vmv.x.s %[high_result], %[prev_buffer]				\n\
> +	.option pop"
> +	: [vl] "=3D&r" (vl), [prev_buffer] "=3D&vd" (prev_buffer),
> +		[curr_buffer] "=3D&vd" (curr_buffer),
> +		[high_result] "=3D&r" (high_result),
> +		[low_result] "=3D&r" (low_result)
> +	: [iph] "r" (iph), [ihl] "r" (ihl));
> +	riscv_v_disable();
> +
> +	high_result +=3D low_result;
> +	high_result +=3D high_result < low_result;
> +#else // !CONFIG_32_BIT
> +	csum_t result;
> +
> +	riscv_v_enable();
> +	asm(".option push						\n\
> +	.option arch, +v						\n\
> +	vsetivli x0, 1, e64, ta, ma					\n\
> +	vmv.v.i %[prev_buffer], 0					\n\
> +	1:								\n\
> +	# Setup 32-bit sum of iph					\n\
> +	vsetvli %[vl], %[ihl], e32, m1, ta, ma				\n\
> +	vle32.v %[curr_buffer], (%[iph])				\n\
> +	# Sum each 32-bit segment of iph that can fit into a vector reg	\n\
> +	vwredsumu.vs %[prev_buffer], %[curr_buffer], %[prev_buffer]     \n\
> +	subw %[ihl], %[ihl], %[vl]					\n\
> +	slli %[vl], %[vl], 2						\n\
> +	addw %[iph], %[vl], %[iph]					\n\
> +	# If not all of iph could fit into vector reg, do another sum	\n\
> +	bne %[ihl], zero, 1b						\n\
> +	vsetvli x0, x0, e64, m1, ta, ma					\n\
> +	vmv.x.s %[result], %[prev_buffer]				\n\
> +	.option pop"
> +	: [vl] "=3D&r" (vl), [prev_buffer] "=3D&vd" (prev_buffer),
> +		[curr_buffer] "=3D&vd" (curr_buffer), [result] "=3D&r" (result)
> +	: [iph] "r" (iph), [ihl] "r" (ihl));
> +	riscv_v_disable();
> +#endif // !CONFIG_32_BIT
> +no_vector:
> +#endif // !CONFIG_RISCV_ISA_V
> +
>  	csum_t csum =3D 0;
>  	int pos =3D 0;
> =20
>=20
> --=20
> 2.42.0
>=20

--yWEbZ60EvanaedV2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZPmcSwAKCRB4tDGHoIJi
0vRZAP0ZzhCs5vuiNpTlPt5BMdF0YNy9cfs2lZWKaag7QXHn7wEA4ERG47/qqF3a
avJy0xAtqa0LYQnJFnR6V2NQdmXA0gg=
=XGt0
-----END PGP SIGNATURE-----

--yWEbZ60EvanaedV2--
