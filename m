Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D48977815E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbjHJTW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbjHJTWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:22:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F37D271B;
        Thu, 10 Aug 2023 12:22:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24122667A7;
        Thu, 10 Aug 2023 19:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D88BC433C7;
        Thu, 10 Aug 2023 19:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691695372;
        bh=dhTR1cm0y7gQkGL+lHdVn7y+6t2d6bOkcH+/YxZYwWU=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=Ly7InVCU01Xc0iAQJfPte+c4RhhgsHumYGWNPfpSL0S3eDnqG39sQllTjEbbkaZiH
         aHUmm8ygMFp54WJh40EjJHTMtfTB5Y2CFu0Aqb3Diu9SgcuW4pVeYoTy2VYscZWUIb
         jrs7us2Mu7T3l9z6KlmVX9+iRppjUeZJIHIhSH7Rdy9WKV1QjeXwe4Lz27S1uGgmN5
         8vSROuPlwd7Z//A3ntlCCLFGA6/qfuJGonUlLSLkTm5R81wNxLe0y/C3Sg4i6n62qs
         cXqL+f4gAWgjPa+lrhXoSqrrvDFB//0VYJi0u/XZLvtWOj/bKVWIWSWR82IjbAYgGM
         rctr2C897iEqA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 22:22:47 +0300
Message-Id: <CUP3YJ000CVB.1DGFMB8XHFOSW@suppilovahvero>
Cc:     <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 2/8] selftests/sgx: Produce static-pie executable for
 test enclave
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>, <kai.huang@intel.com>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230808193145.8860-1-jo.vanbulck@cs.kuleuven.be>
 <20230808193145.8860-3-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230808193145.8860-3-jo.vanbulck@cs.kuleuven.be>
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
> The current combination of -static and -fPIC creates a static executable
> with position-dependent addresses for global variables. Use -static-pie
> and -fPIE to create a proper static position independent executable that
> can be loaded at any address without a dynamic linker.
>
> Link: https://lore.kernel.org/all/f9c24d89-ed72-7d9e-c650-050d722c6b04@cs=
.kuleuven.be/
> Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
> ---
>  tools/testing/selftests/sgx/Makefile              |  2 +-
>  tools/testing/selftests/sgx/test_encl.lds         |  1 +
>  tools/testing/selftests/sgx/test_encl_bootstrap.S | 12 ++++++------
>  3 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftes=
ts/sgx/Makefile
> index 50aab6b57da3..1d6315a2e5f5 100644
> --- a/tools/testing/selftests/sgx/Makefile
> +++ b/tools/testing/selftests/sgx/Makefile
> @@ -13,7 +13,7 @@ endif
> =20
>  INCLUDES :=3D -I$(top_srcdir)/tools/include
>  HOST_CFLAGS :=3D -Wall -Werror -g $(INCLUDES) -fPIC -z noexecstack
> -ENCL_CFLAGS :=3D -Wall -Werror -static -nostdlib -nostartfiles -fPIC \
> +ENCL_CFLAGS :=3D -Wall -Werror -static-pie -nostdlib -nostartfiles -fPIE=
 \
>  	       -fno-stack-protector -mrdrnd $(INCLUDES)
> =20
>  TEST_CUSTOM_PROGS :=3D $(OUTPUT)/test_sgx
> diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/se=
lftests/sgx/test_encl.lds
> index a1ec64f7d91f..ca659db2a534 100644
> --- a/tools/testing/selftests/sgx/test_encl.lds
> +++ b/tools/testing/selftests/sgx/test_encl.lds
> @@ -10,6 +10,7 @@ PHDRS
>  SECTIONS
>  {
>  	. =3D 0;
> +        __enclave_base =3D .;
>  	.tcs : {
>  		*(.tcs*)
>  	} : tcs
> diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/te=
sting/selftests/sgx/test_encl_bootstrap.S
> index 03ae0f57e29d..c91743f14312 100644
> --- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
> +++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
> @@ -42,9 +42,12 @@
>  encl_entry:
>  	# RBX contains the base address for TCS, which is the first address
>  	# inside the enclave for TCS #1 and one page into the enclave for
> -	# TCS #2. By adding the value of encl_stack to it, we get
> -	# the absolute address for the stack.
> -	lea	(encl_stack)(%rbx), %rax
> +	# TCS #2. First make it relative by substracting __enclave_base and
> +	# then add the address of encl_stack to get the address for the stack.
> +	lea __enclave_base(%rip), %rax
> +	sub %rax, %rbx
> +	lea encl_stack(%rip), %rax
> +	add %rbx, %rax
>  	jmp encl_entry_core
>  encl_dyn_entry:
>  	# Entry point for dynamically created TCS page expected to follow
> @@ -55,12 +58,9 @@ encl_entry_core:
>  	push	%rax
> =20
>  	push	%rcx # push the address after EENTER
> -	push	%rbx # push the enclave base address
> =20
>  	call	encl_body
> =20
> -	pop	%rbx # pop the enclave base address
> -
>  	/* Clear volatile GPRs, except RAX (EEXIT function). */
>  	xor     %rcx, %rcx
>  	xor     %rdx, %rdx
> --=20
> 2.34.1

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
