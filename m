Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8228D783D93
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbjHVKIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbjHVKIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:08:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E116718B;
        Tue, 22 Aug 2023 03:08:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E97661EA9;
        Tue, 22 Aug 2023 10:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52D4C433C9;
        Tue, 22 Aug 2023 10:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692698927;
        bh=31R96I3P54cnARbiyGkbYK6u+UzSnC6bAhE/aCVtR0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c0FKpA0IJW/PIPu2dV0IIm0gLP2eleNsCujH1ZcTmxXy9IvitGtQwub05L5YF53mT
         Ihfhma/xW6es6k0gEdZtP6PxdIfU4TGuEHdCplA7Fv3s7zeOZFbNMZfLAhdy5u08ky
         OgTlqUeCzztz1NldyIJWEv90xvclLMKEPuQk61baifl0qJdUunI/KjFq9hypZuWd7I
         gt0nWxAdoedqxzRK8Bs2H582z2D/sQtOLOwCfPeN9nTtpUXbKTQJ5/owYUlNwCwu50
         gzrPdgL3O4LBVkuMnxrKSC5P1buqR9jgB87QCBhD5IAQsGvPkHZ8ZSObMoXi8e9GqW
         lNzf3nMn+j4uw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 22 Aug 2023 13:08:44 +0300
Message-Id: <CUYZOUUWNA2G.29721KK0K22HI@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>, <kai.huang@intel.com>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v3 3/9] selftests/sgx: Handle relocations in test
 enclave
X-Mailer: aerc 0.14.0
References: <20230819094332.8535-1-jo.vanbulck@cs.kuleuven.be>
 <20230819094332.8535-4-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230819094332.8535-4-jo.vanbulck@cs.kuleuven.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Aug 19, 2023 at 12:43 PM EEST, Jo Van Bulck wrote:
> Static-pie binaries normally include a startup routine to perform any ELF
> relocations from .rela.dyn. Since the enclave loading process is differen=
t
> and glibc is not included, do the necessary relocation for encl_op_array
> entries manually at runtime relative to the enclave base to ensure correc=
t
> function pointers.
>
> Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
> ---
>  tools/testing/selftests/sgx/test_encl.c   | 49 ++++++++++++++++-------
>  tools/testing/selftests/sgx/test_encl.lds |  2 +
>  2 files changed, 36 insertions(+), 15 deletions(-)
>
> diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/self=
tests/sgx/test_encl.c
> index c0d639729..7633fb7cb 100644
> --- a/tools/testing/selftests/sgx/test_encl.c
> +++ b/tools/testing/selftests/sgx/test_encl.c
> @@ -119,21 +119,40 @@ static void do_encl_op_nop(void *_op)
> =20
>  }
> =20
> +/*
> + * Symbol placed at the start of the enclave image by the linker script.
> + * Declare this extern symbol with visibility "hidden" to ensure the
> + * compiler does not access it through the GOT.
> + */
> +extern const uint8_t __attribute__((visibility("hidden"))) __encl_base;
> +static const uint64_t encl_base =3D (uint64_t)&__encl_base;
> +
> +typedef void (*encl_op_t)(void *);
> +const encl_op_t encl_op_array[ENCL_OP_MAX] =3D {
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
> -	struct encl_op_header *op =3D (struct encl_op_header *)rdi;
> -
> -	if (op->type < ENCL_OP_MAX)
> -		(*encl_op_array[op->type])(op);
> +	struct encl_op_header *header =3D (struct encl_op_header *)rdi;
> +	encl_op_t op;
> +
> +	if (header->type >=3D ENCL_OP_MAX)
> +		return;
> +
> +	/*
> +	 * "encl_base" needs to be added, as this call site *cannot be*
> +	 * made rip-relative by the compiler, or fixed up by any other
> +	 * possible means.
> +	 */
> +	op =3D encl_base + encl_op_array[header->type];
> +
> +	(*op)(header);
>  }
> diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/se=
lftests/sgx/test_encl.lds
> index 62d37160f..b86c86060 100644
> --- a/tools/testing/selftests/sgx/test_encl.lds
> +++ b/tools/testing/selftests/sgx/test_encl.lds
> @@ -32,6 +32,8 @@ SECTIONS
>  		*(.note*)
>  		*(.debug*)
>  		*(.eh_frame*)
> +		*(.dyn*)
> +		*(.gnu.hash)
>  	}
>  }
> =20
> --=20
> 2.25.1

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
