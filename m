Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C557675FE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjG1TFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjG1TFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:05:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC023AB9;
        Fri, 28 Jul 2023 12:05:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E7AC60DBF;
        Fri, 28 Jul 2023 19:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18682C433C8;
        Fri, 28 Jul 2023 19:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690571114;
        bh=NOrmYpm1QEHIxl4IFEiJqqOZZmvrRL5KU1UZDzTeWIs=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=iTq6JGem2POKnmSuU/f7ii2+u7Ql0MhHbjVc+6wE35RCfTydq3b6fkFqI2qDEFE6q
         DU1mByA/3LZmM2PZNMOEqycESmnkUVTGq7HaTNRZCdpMgbIcwTmaa31ny/XaopoOU0
         ZXpyIq6uE+awKlg7uSTDl+bTbJiB1RwXfNqIoPqhnHd0Lzoay4Qc9v0oP6Xh/5+sjU
         TMWWnVoJt9crdcd5+1GKToOserLScqeMWyYsn8YRhB1jp55X5NlIhp6TO12Fxo1qqd
         oyaHlcrS/UTMWZ6XcKWjoDFR3i/Pg6L4tKt2WruAijt6iV5cvfoirmeWSEd4XsPkS0
         bKxhmJ1LpsrfA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 19:05:12 +0000
Message-Id: <CUE1FZAK9NCU.3QTCUB3OBJMK8@seitikki>
Cc:     <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 2/5] selftests/sgx: Fix function pointer relocation in
 test enclave.
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230724165832.15797-1-jo.vanbulck@cs.kuleuven.be>
 <20230724165832.15797-3-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230724165832.15797-3-jo.vanbulck@cs.kuleuven.be>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jul 24, 2023 at 4:58 PM UTC, Jo Van Bulck wrote:
> Relocate encl_op_array entries at runtime relative to the enclave base to
> ensure correct function pointer when compiling the test enclave with -Os.
>
> Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
> ---
>  tools/testing/selftests/sgx/test_encl.c           | 6 ++++--
>  tools/testing/selftests/sgx/test_encl.lds         | 1 +
>  tools/testing/selftests/sgx/test_encl_bootstrap.S | 5 +++++
>  3 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/self=
tests/sgx/test_encl.c
> index c0d6397295e3..4e31a6c3d673 100644
> --- a/tools/testing/selftests/sgx/test_encl.c
> +++ b/tools/testing/selftests/sgx/test_encl.c
> @@ -119,9 +119,11 @@ static void do_encl_op_nop(void *_op)
> =20
>  }
> =20
> +uint64_t get_enclave_base(void);
> +
>  void encl_body(void *rdi,  void *rsi)
>  {
> -	const void (*encl_op_array[ENCL_OP_MAX])(void *) =3D {
> +	static void (*encl_op_array[ENCL_OP_MAX])(void *) =3D {
>  		do_encl_op_put_to_buf,
>  		do_encl_op_get_from_buf,
>  		do_encl_op_put_to_addr,
> @@ -135,5 +137,5 @@ void encl_body(void *rdi,  void *rsi)
>  	struct encl_op_header *op =3D (struct encl_op_header *)rdi;
> =20
>  	if (op->type < ENCL_OP_MAX)
> -		(*encl_op_array[op->type])(op);
> +		(*(get_enclave_base() + encl_op_array[op->type]))(op);
>  }
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
> index 03ae0f57e29d..6126dbd7ad1c 100644
> --- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
> +++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
> @@ -86,6 +86,11 @@ encl_entry_core:
>  	mov	$4, %rax
>  	enclu
> =20
> +	.global get_enclave_base
> +get_enclave_base:
> +	lea __enclave_base(%rip), %rax
> +	ret
> +
>  	.section ".data", "aw"
> =20
>  encl_ssa_tcs1:
> --=20
> 2.34.1

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
