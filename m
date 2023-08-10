Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E0F77822E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbjHJUcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbjHJUcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:32:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799472D44;
        Thu, 10 Aug 2023 13:32:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0913D63521;
        Thu, 10 Aug 2023 20:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0C6C433C8;
        Thu, 10 Aug 2023 20:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691699541;
        bh=o+b08IggmBC0Q46+DH/TNZUWh52Eq5/sczGv7ydJn8Y=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=lYB6Ngh9IgxhMRc090T5m0BVwBG+VepIbwPecT9T8CH+9joDT+JOqUR4pfjNowdhf
         68E955C6qrkoSKLUb2uksZIsLgNcyif9K4I21DwFcmY/TeP6LaP8QtIe+4zCnfpo5U
         qQHGJZq7eZol+u4kT+SefU8LslkxArGkl6MV3EBOwiS2myi5IH6QrYbLS891WyFmHA
         rIgR+hDwTl/bZ90QN41TGRXnNWU0/jadNjFQHSTrAAMzqC9hz+rnw5EKHKQHx6BdOi
         cMT9+imturf6C/1gZ/6/mB0lKBlUaIXhnr0jy6c6HWfbbLwGF4OcCwGS9zSquz+UTL
         e9H3YNxHLyxJg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 23:32:14 +0300
Message-Id: <CUP5FP8OHD3I.2MUE3TTRVNRTQ@suppilovahvero>
Subject: Re: [PATCH 3/8] selftests/sgx: Handle relocations in test enclave
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>, <kai.huang@intel.com>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     <dave.hansen@linux.intel.com>
X-Mailer: aerc 0.14.0
References: <20230808193145.8860-1-jo.vanbulck@cs.kuleuven.be>
 <20230808193145.8860-4-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230808193145.8860-4-jo.vanbulck@cs.kuleuven.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Aug 8, 2023 at 10:31 PM EEST, Jo Van Bulck wrote:
> Static-pie binaries normally include a startup routine to perform any ELF
> relocations from .rela.dyn. Since the enclave loading process is differen=
t
> and glibc is not included, do the necessary relocation for encl_op_array
> entries manually at runtime relative to the enclave base to ensure correc=
t
> function pointers.
>
> Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>

What happens if I only apply 1/8 and 2/8 from this patch set?

I'm just wondering why there is no mention of "-static-pie" here.

> ---
>  tools/testing/selftests/sgx/test_encl.c   | 35 +++++++++++++++--------
>  tools/testing/selftests/sgx/test_encl.lds |  3 ++
>  2 files changed, 26 insertions(+), 12 deletions(-)
>
> diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/self=
tests/sgx/test_encl.c
> index c0d6397295e3..c71dfbadd2d9 100644
> --- a/tools/testing/selftests/sgx/test_encl.c
> +++ b/tools/testing/selftests/sgx/test_encl.c
> @@ -119,21 +119,32 @@ static void do_encl_op_nop(void *_op)
> =20
>  }
> =20
> +/*
> + * Symbol placed at the start of the enclave image by the linker script.
> + * Declare this extern symbol with visibility "hidden" to ensure the
> + * compiler does not access it through the GOT.
> + */
> +extern uint8_t __attribute__((visibility("hidden"))) __enclave_base;

I'd rename this as __encl_base to be consistent with other naming here.

You could also declare for convenience and clarity:

	static const uint64_t encl_base =3D (uint64_t)&__encl_base;

> +
> +void (*encl_op_array[ENCL_OP_MAX])(void *) =3D {
> +	do_encl_op_put_to_buf,
> +	do_encl_op_get_from_buf,
> +	do_encl_op_put_to_addr,
> +	do_encl_op_get_from_addr,
> +	do_encl_op_nop,
> +	do_encl_eaccept,
> +	do_encl_emodpe,
> +	do_encl_init_tcs_page,
> +};
> +

Why you need to drop "const"? The array is not dynamically updated, i.e.
there's no reason to move it away from rodata section. If this was
kernel code, such modification would be considered as a regression.

I would also consider cleaning this up a bit further, while you are
refactoring anyway, and declare a typedef:

	typedef void (*encl_op_t)(void *);

	const encl_op_t encl_op_array[ENCL_OP_MAX] =3D {

>  void encl_body(void *rdi,  void *rsi)
>  {
> -	const void (*encl_op_array[ENCL_OP_MAX])(void *) =3D {
> -		do_encl_op_put_to_buf,
> -		do_encl_op_get_from_buf,
> -		do_encl_op_put_to_addr,
> -		do_encl_op_get_from_addr,
> -		do_encl_op_nop,
> -		do_encl_eaccept,
> -		do_encl_emodpe,
> -		do_encl_init_tcs_page,
> -	};
> -
>  	struct encl_op_header *op =3D (struct encl_op_header *)rdi;
> =20
> +	/*
> +	 * Manually rebase the loaded function pointer as enclaves cannot
> +	 * rely on startup routines to perform static pie relocations.
> +	 */

This comment is not very useful. I'd consider dropping it.

>  	if (op->type < ENCL_OP_MAX)
> -		(*encl_op_array[op->type])(op);
> +		(*(((uint64_t) &__enclave_base) + encl_op_array[op->type]))(op);
                              ~
			      should not have white space here (coding style)

This would be cleaner IMHO:

void encl_body(void *rdi,  void *rsi)
{
	struct encl_op_header *header =3D (struct encl_op_header *)rdi;
	encl_op_t op;
=09
	if (header->type >=3D ENCL_OP_MAX)
		return;

	/*=20
	 * "encl_base" needs to be added, as this call site *cannot be*
	 * made rip-relative by the compiler, or fixed up by any other
	 * possible means.
	 */
	op =3D encl_base + encl_op_array[header->type];

	(*op)(header);
}

>  }
> diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/se=
lftests/sgx/test_encl.lds
> index ca659db2a534..73d9c8bbe7de 100644
> --- a/tools/testing/selftests/sgx/test_encl.lds
> +++ b/tools/testing/selftests/sgx/test_encl.lds
> @@ -32,6 +32,9 @@ SECTIONS
>  		*(.note*)
>  		*(.debug*)
>  		*(.eh_frame*)
> +		/* Dynamic symbol table not supported in enclaves */

I'd drop this comment.

> +		*(.dyn*)
> +		*(.gnu.hash)
>  	}
>  }
> =20
> --=20
> 2.34.1

BR, Jarkko
