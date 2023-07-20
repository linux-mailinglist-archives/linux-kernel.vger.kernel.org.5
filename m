Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BD775B59F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjGTRaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGTRaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:30:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7ED1BB;
        Thu, 20 Jul 2023 10:30:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ED60619D3;
        Thu, 20 Jul 2023 17:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528B7C433C7;
        Thu, 20 Jul 2023 17:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689874198;
        bh=89yA+qHMd8sAMy/jvkyrwSt1wRpatnT6dIOnEoXYtLY=;
        h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
        b=a3ljgeH+Bb2rKSQDCCrONYR7bkFPIUv8mZS6qjaMs9/droT5X1J5SBhkK8SjedOOt
         AEH24KWPGMFNyDeQNqHIybHiC7U6CaDtPU8evu/pH+9cm95Wh64El1JiRR4DE+7eaM
         w/D66XtnALtIRru+1+rgUgiVNzbw8npiDQ5pXUaKowfRPWo8xAH7ZQk1auQrvlC8gq
         J3gj9lddG5Wol3ATQm3Gyfy7a3+83nmrMZSZ7OYE+qnX1Z+olYfc144v630om+Oa95
         CzwhiWK9JygSDta1bHcJwEfXcNZO/eIOPp0VJ4r57kIfNaq4MynozrhB2WP4vQhaxb
         cPRkNJxYON7Mw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 20 Jul 2023 20:29:54 +0300
Message-Id: <CU76ENNUAMHF.15D3KJY99C50@suppilovahvero>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 2/4] selftests/sgx: Store base address and size in test
 enclave
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.14.0
References: <20230719142500.13623-1-jo.vanbulck@cs.kuleuven.be>
 <20230719142500.13623-3-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230719142500.13623-3-jo.vanbulck@cs.kuleuven.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Jul 19, 2023 at 5:24 PM EEST, Jo Van Bulck wrote:
> Make the test enclave aware of its protected virtual address range to all=
ow
> untrusted pointer argument range checks.
>
> Add a linker symbol for __enclave_base at the start of the enclave binary=
.
> Similar to real-world enclave runtimes, rely on the untrusted loader to
> fill in __enclave_size (measured as part of MRENCLAVE), as the final size
> of the enclave image is determined during loading.
>
> Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
> ---
>  tools/testing/selftests/sgx/load.c            |  3 +-
>  tools/testing/selftests/sgx/main.c            | 29 +++++++++++++++++++
>  tools/testing/selftests/sgx/test_encl.lds     |  1 +
>  .../selftests/sgx/test_encl_bootstrap.S       | 17 +++++++++++
>  4 files changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests=
/sgx/load.c
> index 94bdeac1c..968a656a3 100644
> --- a/tools/testing/selftests/sgx/load.c
> +++ b/tools/testing/selftests/sgx/load.c
> @@ -60,7 +60,8 @@ static bool encl_map_bin(const char *path, struct encl =
*encl)
>  		goto err;
>  	}
> =20
> -	bin =3D mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
> +	/* NOTE: map read|write to allow __enclave_size to be filled in */
> +	bin =3D mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd,=
 0);
>  	if (bin =3D=3D MAP_FAILED) {
>  		perror("enclave executable mmap()");
>  		goto err;
> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests=
/sgx/main.c
> index d3c7a39f4..bad963c79 100644
> --- a/tools/testing/selftests/sgx/main.c
> +++ b/tools/testing/selftests/sgx/main.c
> @@ -182,6 +182,7 @@ static bool setup_test_encl(unsigned long heap_size, =
struct encl *encl,
>  	FILE *maps_file;
>  	unsigned int i;
>  	void *addr;
> +	uint64_t encl_size_addr;

Should be the first declaration (reverse xmas tree order).

I'd rename this as encl_end, as the current name is cryptic.

> =20
>  	if (!encl_load("test_encl.elf", encl, heap_size)) {
>  		encl_delete(encl);
> @@ -189,6 +190,16 @@ static bool setup_test_encl(unsigned long heap_size,=
 struct encl *encl,
>  		return false;
>  	}
> =20
> +	/*
> +	 * Fill in the expected symbol location with the final size of the
> +	 * constructed enclave image.
> +	 */
> +	encl_size_addr =3D encl_get_entry(encl, "__enclave_size");
> +	if (encl_size_addr) {
> +		encl_size_addr +=3D (uint64_t) encl->src;
> +		*((uint64_t *) encl_size_addr) =3D encl->encl_size;
> +	}
> +
>  	if (!encl_measure(encl))
>  		goto err;
> =20
> @@ -307,6 +318,24 @@ TEST_F(enclave, unclobbered_vdso)
>  	EXPECT_EQ(self->run.user_data, 0);
>  }
> =20
> +TEST_F(enclave, init_size)
> +{
> +	struct encl_op_get_from_addr get_addr_op;
> +
> +	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metad=
ata));
> +
> +	memset(&self->run, 0, sizeof(self->run));
> +	self->run.tcs =3D self->encl.encl_base;
> +
> +	/* __enclave_size is initialized by loader in measured enclave image */
> +	get_addr_op.value =3D 0;
> +	get_addr_op.addr =3D self->encl.encl_base + encl_get_entry(&self->encl,=
 "__enclave_size");
> +	get_addr_op.header.type =3D ENCL_OP_GET_FROM_ADDRESS;
> +	EXPECT_EQ(ENCL_CALL(&get_addr_op, &self->run, false), 0);
> +	EXPECT_EEXIT(&self->run);
> +	EXPECT_EQ(get_addr_op.value, self->encl.encl_size);
> +}
> +
>  TEST_F(enclave, poison_args)
>  {
>  	struct encl_op_header nop_op;
> diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/se=
lftests/sgx/test_encl.lds
> index a1ec64f7d..ca659db2a 100644
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
> index 3b69fea61..444a075c0 100644
> --- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
> +++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
> @@ -98,6 +98,23 @@ encl_entry_core:
>  	mov	$4, %rax
>  	enclu
> =20
> +	.global get_enclave_base
> +get_enclave_base:
> +	lea __enclave_base(%rip), %rax
> +	ret
> +
> +	.global get_enclave_size
> +get_enclave_size:
> +	mov __enclave_size(%rip), %rax
> +	ret
> +
> +	# The following 8 bytes (measured as part of MRENCLAVE) will be
> +	# filled in by the untrusted loader with the total size of the
> +	# loaded enclave.
> +	.global __enclave_size
> +__enclave_size:
> +	.quad 0x0
> +
>  	.section ".data", "aw"
> =20
>  encl_ssa_tcs1:
> --=20
> 2.34.1


BR, Jarkko
