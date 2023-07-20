Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7987F75B5AA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjGTRce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjGTRcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:32:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2831984;
        Thu, 20 Jul 2023 10:32:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7461161B56;
        Thu, 20 Jul 2023 17:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469C8C433C8;
        Thu, 20 Jul 2023 17:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689874347;
        bh=Wj8JiI3R3z6w+gZmBUKNxEMNDRTRpXYIZR24v9bE5dA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cp/8frgCIkHYmnLlZK3uA2TFdPn/b1b+nJQ3RQ53/Iflx2iNq6iGTZeyXiT6/cg4C
         fO2sLtJVoGaV41vJDKRgUAXtcQP2/fyc9rHquccWnA+Nv3TdQUdhoJUVKRCcTjefJP
         ssH68pS8ZeC4MSCeGMR9G8Dr6BqJqnBan+nXqv/XK8vYi79MsPj0l/gzXJcKkIio92
         X4CtKOM3633FevUyrUPSR/UbjeQPwNxS+p6p15yFlksyF/omjxrnp+jdzF0uRiFu/i
         Mk2W5YJw3Ldn9I7BixjfGaEkOzXayLWJqC004mD3Ge4sC3Ffye184uko5Rsqf6o5Ck
         RVqkXIuQzUnNg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 20 Jul 2023 20:32:23 +0300
Message-Id: <CU76GKAGAGRG.22Y5TDTJ86WJR@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 3/4] selftests/sgx: Harden test enclave API
X-Mailer: aerc 0.14.0
References: <20230719142500.13623-1-jo.vanbulck@cs.kuleuven.be>
 <20230719142500.13623-4-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230719142500.13623-4-jo.vanbulck@cs.kuleuven.be>
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
> Adhere to enclave programming best practices and prevent confused-deputy
> attacks on the test enclave by validating that untrusted pointer argument=
s
> do not fall inside the protected enclave range.
>
> Note that the test enclave deliberately allows arbitrary reads/writes in
> enclave memory through the get_from_addr/put_to_addr operations for
> explicit testing purposes. Hence, only allow remaining unchecked pointer
> dereferences in these functions.
>
> Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
> ---
>  tools/testing/selftests/sgx/main.c      |   5 +
>  tools/testing/selftests/sgx/test_encl.c | 161 ++++++++++++++++++------
>  2 files changed, 128 insertions(+), 38 deletions(-)
>
> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests=
/sgx/main.c
> index bad963c79..8d60f8dcd 100644
> --- a/tools/testing/selftests/sgx/main.c
> +++ b/tools/testing/selftests/sgx/main.c
> @@ -355,6 +355,11 @@ TEST_F(enclave, poison_args)
>  	    : "=3Dm"(flags) : : );
>  	EXPECT_EEXIT(&self->run);
>  	EXPECT_EQ(flags & 0x40400, 0);
> +
> +	/* attempt API pointer poisoning */
> +	EXPECT_EQ(ENCL_CALL(self->encl.encl_base + self->encl.encl_size - 1, &s=
elf->run, false), 0);
> +	EXPECT_EQ((&self->run)->function, ERESUME);
> +	EXPECT_EQ((&self->run)->exception_vector, 6 /* expect ud2 */);
>  }
> =20
>  /*
> diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/self=
tests/sgx/test_encl.c
> index c0d639729..5531f5d48 100644
> --- a/tools/testing/selftests/sgx/test_encl.c
> +++ b/tools/testing/selftests/sgx/test_encl.c
> @@ -16,37 +16,55 @@ enum sgx_enclu_function {
>  	EMODPE =3D 0x6,
>  };
> =20
> -static void do_encl_emodpe(void *_op)
> +uint64_t get_enclave_base(void);
> +uint64_t get_enclave_size(void);
> +
> +static int is_outside_enclave(void *addr, size_t len)
>  {
> -	struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo)) =3D {0=
};
> -	struct encl_op_emodpe *op =3D _op;
> +	/* need cast since void pointer arithmetics are undefined in C */
> +	size_t start =3D (size_t) addr;
> +	size_t end =3D start + len - 1;
> +	size_t enclave_end =3D get_enclave_base() + get_enclave_size();
> =20
> -	secinfo.flags =3D op->flags;
> +	/* check for integer overflow with untrusted length */
> +	if (start > end)
> +		return 0;
> =20
> -	asm volatile(".byte 0x0f, 0x01, 0xd7"
> -				:
> -				: "a" (EMODPE),
> -				  "b" (&secinfo),
> -				  "c" (op->epc_addr));
> +	return (start > enclave_end || end < get_enclave_base());
>  }
> =20
> -static void do_encl_eaccept(void *_op)
> +static int is_inside_enclave(void *addr, size_t len)
>  {
> -	struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo)) =3D {0=
};
> -	struct encl_op_eaccept *op =3D _op;
> -	int rax;
> +	/* need cast since void pointer arithmetics are undefined in C */
> +	size_t start =3D (size_t) addr;
> +	size_t end =3D start + len - 1;
> +	size_t enclave_end =3D get_enclave_base() + get_enclave_size();
> =20
> -	secinfo.flags =3D op->flags;
> +	/* check for integer overflow with untrusted length */
> +	if (start > end)
> +		return 0;
> =20
> -	asm volatile(".byte 0x0f, 0x01, 0xd7"
> -				: "=3Da" (rax)
> -				: "a" (EACCEPT),
> -				  "b" (&secinfo),
> -				  "c" (op->epc_addr));
> -
> -	op->ret =3D rax;
> +	return (start >=3D get_enclave_base() && end <=3D enclave_end);
>  }
> =20
> +#define PANIC()								\
> +	asm("ud2\n\t")
> +
> +#define SAFE_COPY_STRUCT(u_arg, t_cp)					\

any reason not to use static inline function?

> +	do {								\
> +		/* 1. check if the argument lies entirely outside */	\
> +		if (!is_outside_enclave((void *)u_arg, sizeof(*t_cp)))	\
> +			PANIC();					\
> +		/* 2. copy the argument inside to prevent TOCTOU */	\
> +		memcpy(t_cp, u_arg, sizeof(*t_cp));			\
> +	} while (0)
> +
> +#define ASSERT_INSIDE_ENCLAVE(u_arg, size)				\

"

> +	do {								\
> +		if (!is_inside_enclave(((void *)(u_arg)), size))	\
> +			PANIC();					\
> +	} while (0)
> +
>  static void *memcpy(void *dest, const void *src, size_t n)
>  {
>  	size_t i;
> @@ -67,18 +85,62 @@ static void *memset(void *dest, int c, size_t n)
>  	return dest;
>  }
> =20
> +static void do_encl_emodpe(void *_op)
> +{
> +	struct encl_op_emodpe op;
> +	struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo)) =3D {0=
};
> +
> +	SAFE_COPY_STRUCT(_op, &op);
> +	ASSERT_INSIDE_ENCLAVE(op.epc_addr, PAGE_SIZE);
> +
> +	secinfo.flags =3D op.flags;
> +
> +	asm volatile(".byte 0x0f, 0x01, 0xd7"
> +				:
> +				: "a" (EMODPE),
> +				  "b" (&secinfo),
> +				  "c" (op.epc_addr));
> +}
> +
> +static void do_encl_eaccept(void *_op)
> +{
> +	struct encl_op_eaccept op;
> +	struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo)) =3D {0=
};
> +	int rax;
> +
> +	SAFE_COPY_STRUCT(_op, &op);
> +	ASSERT_INSIDE_ENCLAVE(op.epc_addr, PAGE_SIZE);
> +
> +	secinfo.flags =3D op.flags;
> +
> +	asm volatile(".byte 0x0f, 0x01, 0xd7"
> +				: "=3Da" (rax)
> +				: "a" (EACCEPT),
> +				  "b" (&secinfo),
> +				  "c" (op.epc_addr));
> +
> +	op.ret =3D rax;
> +	memcpy(_op, &op, sizeof(op));
> +}
> +
>  static void do_encl_init_tcs_page(void *_op)
>  {
> -	struct encl_op_init_tcs_page *op =3D _op;
> -	void *tcs =3D (void *)op->tcs_page;
> +	struct encl_op_init_tcs_page op;
> +	void *tcs;
>  	uint32_t val_32;
> =20
> +	SAFE_COPY_STRUCT(_op, &op);
> +	tcs =3D (void *)op.tcs_page;
> +	ASSERT_INSIDE_ENCLAVE(tcs, PAGE_SIZE);
> +	ASSERT_INSIDE_ENCLAVE(get_enclave_base() + op.ssa, PAGE_SIZE);
> +	ASSERT_INSIDE_ENCLAVE(get_enclave_base() + op.entry, 1);
> +
>  	memset(tcs, 0, 16);			/* STATE and FLAGS */
> -	memcpy(tcs + 16, &op->ssa, 8);		/* OSSA */
> +	memcpy(tcs + 16, &op.ssa, 8);		/* OSSA */
>  	memset(tcs + 24, 0, 4);			/* CSSA */
>  	val_32 =3D 1;
>  	memcpy(tcs + 28, &val_32, 4);		/* NSSA */
> -	memcpy(tcs + 32, &op->entry, 8);	/* OENTRY */
> +	memcpy(tcs + 32, &op.entry, 8);		/* OENTRY */
>  	memset(tcs + 40, 0, 24);		/* AEP, OFSBASE, OGSBASE */
>  	val_32 =3D 0xFFFFFFFF;
>  	memcpy(tcs + 64, &val_32, 4);		/* FSLIMIT */
> @@ -86,32 +148,54 @@ static void do_encl_init_tcs_page(void *_op)
>  	memset(tcs + 72, 0, 4024);		/* Reserved */
>  }
> =20
> -static void do_encl_op_put_to_buf(void *op)
> +static void do_encl_op_put_to_buf(void *_op)
>  {
> -	struct encl_op_put_to_buf *op2 =3D op;
> +	struct encl_op_get_from_buf op;
> +
> +	SAFE_COPY_STRUCT(_op, &op);
> =20
> -	memcpy(&encl_buffer[0], &op2->value, 8);
> +	memcpy(&encl_buffer[0], &op.value, 8);
> +	memcpy(_op, &op, sizeof(op));
>  }
> =20
> -static void do_encl_op_get_from_buf(void *op)
> +static void do_encl_op_get_from_buf(void *_op)
>  {
> -	struct encl_op_get_from_buf *op2 =3D op;
> +	struct encl_op_get_from_buf op;
> =20
> -	memcpy(&op2->value, &encl_buffer[0], 8);
> +	SAFE_COPY_STRUCT(_op, &op);
> +
> +	memcpy(&op.value, &encl_buffer[0], 8);
> +	memcpy(_op, &op, sizeof(op));
>  }
> =20
>  static void do_encl_op_put_to_addr(void *_op)
>  {
> -	struct encl_op_put_to_addr *op =3D _op;
> +	struct encl_op_put_to_addr op;
> +
> +	SAFE_COPY_STRUCT(_op, &op);
> =20
> -	memcpy((void *)op->addr, &op->value, 8);
> +	/*
> +	 * NOTE: not checking is_outside_enclave(op.addr, 8) here
> +	 * deliberately allows arbitrary writes to enclave memory for
> +	 * testing purposes.
> +	 */
> +	memcpy((void *)op.addr, &op.value, 8);
> +	memcpy(_op, &op, sizeof(op));
>  }
> =20
>  static void do_encl_op_get_from_addr(void *_op)
>  {
> -	struct encl_op_get_from_addr *op =3D _op;
> +	struct encl_op_get_from_addr op;
> +
> +	SAFE_COPY_STRUCT(_op, &op);
> =20
> -	memcpy(&op->value, (void *)op->addr, 8);
> +	/*
> +	 * NOTE: not checking is_outside_enclave(op.addr, 8) here
> +	 * deliberately allows arbitrary reads from enclave memory for
> +	 * testing purposes.
> +	 */
> +	memcpy(&op.value, (void *)op.addr, 8);
> +	memcpy(_op, &op, sizeof(op));
>  }
> =20
>  static void do_encl_op_nop(void *_op)
> @@ -131,9 +215,10 @@ void encl_body(void *rdi,  void *rsi)
>  		do_encl_emodpe,
>  		do_encl_init_tcs_page,
>  	};
> +	struct encl_op_header op;
> =20
> -	struct encl_op_header *op =3D (struct encl_op_header *)rdi;
> +	SAFE_COPY_STRUCT(rdi, &op);
> =20
> -	if (op->type < ENCL_OP_MAX)
> -		(*encl_op_array[op->type])(op);
> +	if (op.type < ENCL_OP_MAX)
> +		(*encl_op_array[op.type])(rdi);
>  }
> --=20
> 2.34.1

BR, Jarkko
