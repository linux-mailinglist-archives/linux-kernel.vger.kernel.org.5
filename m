Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BCA75B594
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjGTR1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjGTR1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:27:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20212CC;
        Thu, 20 Jul 2023 10:27:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A61A361B8F;
        Thu, 20 Jul 2023 17:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1B3C433C7;
        Thu, 20 Jul 2023 17:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689874040;
        bh=JK8s04faeXLdLKyaYrVKEX5OBE+3m3Gn+wU3x0gnq7w=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=Jk0zsYMr8cSZ1m/gN9/eV5vapOcfyIgIDEJl6YF/tYrc+jXQd9yx3Jf8CQOR0KglK
         qLWeEMBmhVYpzhaIUuBhbB0ddxob+V0lzfMW9fipqQQ84YizjyHqfecbO8dhckXxtm
         n9n2hpR9zAe3ZmIezD1UXBrIbABmqliU1ssOnBfhvydRp8mqq9fRiTUjiBj44z+Acp
         wDAeaMiDytm3UOIc0Jfk+YtjUQ2ZErBr1BdPVi3Um3chUQjJfQRD3tX4nDvsl+/8RB
         4HUqTiVCjLt+YjACUn0b6rpIhmANgTtvyXdZL3TBd+JLVpFoZnJwdn9XQpZ7LobySo
         YAAsYLWCDwdUg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 20 Jul 2023 20:27:15 +0300
Message-Id: <CU76CMOCVA8N.PM4O08WT1DZA@suppilovahvero>
Cc:     <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 1/4] selftests/sgx: Harden test enclave ABI
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230719142500.13623-1-jo.vanbulck@cs.kuleuven.be>
 <20230719142500.13623-2-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230719142500.13623-2-jo.vanbulck@cs.kuleuven.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Jul 19, 2023 at 5:24 PM EEST, Jo Van Bulck wrote:
> The System V x86-64 ABI used by the C compiler defines certain low-level
> CPU configuration registers to be set to expected values upon function
> entry. However, SGX enclaves cannot expect the untrusted caller to respec=
t
> these ABI conventions. Therefore, adhere to SGX runtime best practices by
> sanitizing RFLAGS.DF=3D0 before transitioning to C code. Additionally
> sanitize RFLAGS.AC=3D0 to protect against known #AC-fault side channels f=
or
> unaligned memory accesses.
>
> Note that the test enclave does currently not use any floating-point
> instructions (-mno-sse). Hence, keep the code simple by _not_ using XRSTO=
R
> to cleanse extended x87/SSE state.
>
> Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
> ---
>  tools/testing/selftests/sgx/Makefile          |  2 +-
>  tools/testing/selftests/sgx/main.c            | 21 +++++++++++++++++++
>  .../selftests/sgx/test_encl_bootstrap.S       | 12 +++++++++++
>  3 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftes=
ts/sgx/Makefile
> index 50aab6b57..c2a13bc6e 100644
> --- a/tools/testing/selftests/sgx/Makefile
> +++ b/tools/testing/selftests/sgx/Makefile
> @@ -14,7 +14,7 @@ endif
>  INCLUDES :=3D -I$(top_srcdir)/tools/include
>  HOST_CFLAGS :=3D -Wall -Werror -g $(INCLUDES) -fPIC -z noexecstack
>  ENCL_CFLAGS :=3D -Wall -Werror -static -nostdlib -nostartfiles -fPIC \
> -	       -fno-stack-protector -mrdrnd $(INCLUDES)
> +	       -fno-stack-protector -mrdrnd -mno-sse $(INCLUDES)
> =20
>  TEST_CUSTOM_PROGS :=3D $(OUTPUT)/test_sgx
>  TEST_FILES :=3D $(OUTPUT)/test_encl.elf
> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests=
/sgx/main.c
> index 9820b3809..d3c7a39f4 100644
> --- a/tools/testing/selftests/sgx/main.c
> +++ b/tools/testing/selftests/sgx/main.c
> @@ -307,6 +307,27 @@ TEST_F(enclave, unclobbered_vdso)
>  	EXPECT_EQ(self->run.user_data, 0);
>  }
> =20

Since the amount of tests is increasing over time, I'd put here:

/*
 * Explanation what the test does and why it exists.
 */
> +TEST_F(enclave, poison_args)
> +{
> +	struct encl_op_header nop_op;
> +	uint64_t flags =3D -1;
> +
> +	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metad=
ata));
> +
> +	memset(&self->run, 0, sizeof(self->run));
> +	self->run.tcs =3D self->encl.encl_base;
> +
> +	/* attempt ABI register poisoning */
> +	nop_op.type =3D ENCL_OP_NOP;
> +	asm("std\n\t");
> +	EXPECT_EQ(ENCL_CALL(&nop_op, &self->run, false), 0);
> +	asm("pushfq\n\t"		\
> +	    "popq %0\n\t"		\
> +	    : "=3Dm"(flags) : : );
> +	EXPECT_EEXIT(&self->run);
> +	EXPECT_EQ(flags & 0x40400, 0);
> +}
> +
>  /*
>   * A section metric is concatenated in a way that @low bits 12-31 define=
 the
>   * bits 12-31 of the metric and @high bits 0-19 define the bits 32-51 of=
 the
> diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/te=
sting/selftests/sgx/test_encl_bootstrap.S
> index 03ae0f57e..3b69fea61 100644
> --- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
> +++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
> @@ -57,6 +57,18 @@ encl_entry_core:
>  	push	%rcx # push the address after EENTER
>  	push	%rbx # push the enclave base address
> =20
> +	# Sanitize CPU state: x86-64 ABI requires RFLAGS.DF=3D0 on function
> +	# entry, and we additionally clear RFLAGS.AC to prevent #AC-fault side
> +	# channels.
> +	# NOTE: Real-world enclave runtimes should also cleanse extended CPU
> +	# state (i.e., x87 FPU and SSE/AVX/...) configuration registers,
> +	# preferably using XRSTOR. This is _not_ done below to simplify the
> +	# test enclave, which does not use any floating-point instructions.
> +	cld
> +	pushfq
> +	andq $~0x40000, (%rsp)
> +	popfq
> +
>  	call	encl_body
> =20
>  	pop	%rbx # pop the enclave base address
> --=20
> 2.34.1


BR, Jarkko
