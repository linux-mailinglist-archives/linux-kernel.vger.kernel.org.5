Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E52C7977FD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239877AbjIGQix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241331AbjIGQhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:37:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953C86E9F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:22:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2770FC433BF;
        Thu,  7 Sep 2023 09:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694080719;
        bh=hYwpafdI4/gHTlUCpwaQQnjNKzf5vR0+lyBgIWJ9kU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lK0v+PKmVPdgw7D5WBWMOhPWJcd4LMO6B+WBY+X/Ja0UYxSOO/3sa85nRJJTRGGn2
         U7a0ctbaa8aMNHgu0Ho8ixxFFcNTjml61beS0AQXZ2xuSKx3jLBvY0wHI6CzrXR11P
         BJX7jDcoZ+/d45Pa6xNwnZ6LAOWlfKxbW2cBWpFbWeIVlXtMzfU6SUQvQYWsxMNYg9
         SrjloSFC01XIPE1cRsjz3sHJqk4es94CsqYC1XEiUXVFSpulm4iP8yoJwkzmRvW4oq
         4mjaUAGR0S8X5Qq4VDQXGbFB2wegAN0tJ2XCFd3t7aKH+2uTmQvlZvOOYkkGZmhKN3
         9vg0bolhBdXbw==
Date:   Thu, 7 Sep 2023 10:58:33 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v2 3/5] riscv: Vector checksum header
Message-ID: <20230907-6ed9570259e770b6a472ee61@fedora>
References: <20230905-optimize_checksum-v2-0-ccd658db743b@rivosinc.com>
 <20230905-optimize_checksum-v2-3-ccd658db743b@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8Z1xk9Xte91v4ZgH"
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


--8Z1xk9Xte91v4ZgH
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

Also, I don't see that you have addressed previous review comments from
Samuel:
https://lore.kernel.org/linux-riscv/0a8c98bf-46da-e77a-0431-a6c1e224af2e@si=
five.com/

--8Z1xk9Xte91v4ZgH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZPmeyQAKCRB4tDGHoIJi
0puWAP9HrYt4PCeY2P9bcTMRktrEGXFcf6AZsiOqdk6YGi2NDwEAxLxuSROywPKL
er6nTPei+YkmEgwVORjWsLJ3XfNslwY=
=Ua5X
-----END PGP SIGNATURE-----

--8Z1xk9Xte91v4ZgH--
