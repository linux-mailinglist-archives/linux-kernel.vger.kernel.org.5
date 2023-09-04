Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DF9791E37
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 22:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238059AbjIDU1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 16:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjIDU1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 16:27:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B800180;
        Mon,  4 Sep 2023 13:27:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B0B10CE0ED4;
        Mon,  4 Sep 2023 20:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5269C433C8;
        Mon,  4 Sep 2023 20:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693859261;
        bh=l8Y47sXdP/bvNkepe16cCkpD9a5zrqCD9yTCiw2cN9c=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=Uqxh+maKogeqLxODvZhJfBUcQYMKUDx9ALWdoQ0Soj+TL2TD53AemhFk1KICDm6pO
         WNC9a0wpeGHN179H7SU0E143VaRA0FgjuRm42XIssNdRxPiueDY8lpA+AkjEKHtUO0
         lDurEx0z12/EwYWacsE7MReKwESKXqg2s6o8+EJ2w7wYA2dMM9VYH6D262VvbXJa66
         A15wArsVNkhgU5BrjPvGSwY7/VKgdN2rsAaZpmZV3mWx8UNR+1AH0/qVZALGFhG4vQ
         9SPZR6uQDAA15S1lN/KKOf8YxGDK8xoy3PQ083JLjvXw6fnDuwTAq9md9i+uIRHYoB
         8E3vrTWgMsb7Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 04 Sep 2023 23:27:38 +0300
Message-Id: <CVAEZSZ3NX4J.27BMCXZKSOB16@suppilovahvero>
Cc:     <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v5 02/13] selftests/sgx: Fix uninitialized pointer
 dereferences in encl_get_entry
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>, <kai.huang@intel.com>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230831134144.22686-1-jo.vanbulck@cs.kuleuven.be>
 <20230831134144.22686-3-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230831134144.22686-3-jo.vanbulck@cs.kuleuven.be>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Aug 31, 2023 at 4:41 PM EEST, Jo Van Bulck wrote:
> Ensure sym_tab and sym_names are zero-initialized and add an early-out
> condition in the unlikely (erroneous) case that the enclave ELF file woul=
d
> not contain a symbol table.
>
> This addresses -Werror=3Dmaybe-uninitialized compiler warnings for gcc -O=
2.
>
> Fixes: 33c5aac3bf32 ("selftests/sgx: Test complete changing of page type =
flow")
> Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
> ---
>  tools/testing/selftests/sgx/load.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests=
/sgx/load.c
> index 94bdeac1cf04..c9f658e44de6 100644
> --- a/tools/testing/selftests/sgx/load.c
> +++ b/tools/testing/selftests/sgx/load.c
> @@ -136,11 +136,11 @@ static bool encl_ioc_add_pages(struct encl *encl, s=
truct encl_segment *seg)
>   */
>  uint64_t encl_get_entry(struct encl *encl, const char *symbol)
>  {
> +	Elf64_Sym *symtab =3D NULL;
> +	char *sym_names =3D NULL;
>  	Elf64_Shdr *sections;
> -	Elf64_Sym *symtab;
>  	Elf64_Ehdr *ehdr;
> -	char *sym_names;
> -	int num_sym;
> +	int num_sym =3D 0;
>  	int i;
> =20
>  	ehdr =3D encl->bin;
> @@ -161,6 +161,9 @@ uint64_t encl_get_entry(struct encl *encl, const char=
 *symbol)
>  		}
>  	}
> =20
> +	if (!symtab || !sym_names)
> +		return 0;
> +
>  	for (i =3D 0; i < num_sym; i++) {
>  		Elf64_Sym *sym =3D &symtab[i];
> =20
> --=20
> 2.25.1

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
