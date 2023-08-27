Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2C378A10B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 20:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjH0Sgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 14:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjH0Sg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 14:36:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC12C2;
        Sun, 27 Aug 2023 11:36:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28E0661DA5;
        Sun, 27 Aug 2023 18:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D4EC433C8;
        Sun, 27 Aug 2023 18:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693161385;
        bh=9/7K8mHFNrHA5bjly2mZPNdG0JOOeYv37aCrRvkQsrs=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=uUIa9LBn954BwhnSVN1DC3eT0gGD53y5YB1QovnnIaHTIV9Yx+oWab4Q92GJYHMfK
         XqotupDOs/45NnzpXa/Y63BonrU8vrublCnL7r77FlR/84ASxc/e2maRuoHEiQvlOZ
         bPaGz/5tWVFbSJja+pU/wR5FCwLCMiHLYJRoXM5asNbp0BCwKtXSrZC50z1+86AoXW
         GErWkJ3HpvymhLy63GcRxbRfZk7BpFnNYNu2icbHh+GeOxq98pa0/ZKW54bql+QMI+
         Rb0Kwik9+ult3W3FHcsl2hnSl3ht+W1yx9kARMDsSxRQcsHm+k7wAI+NHQ03l3wYeQ
         DVwFxc3Q/FElg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 27 Aug 2023 21:36:22 +0300
Message-Id: <CV3JM96HKCU0.2ZSE4CAS0QV9A@suppilovahvero>
Cc:     <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 10/13] selftests/sgx: Fix uninitialized pointer
 dereferences
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>, <kai.huang@intel.com>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230825133252.9056-1-jo.vanbulck@cs.kuleuven.be>
 <20230825133252.9056-11-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230825133252.9056-11-jo.vanbulck@cs.kuleuven.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Aug 25, 2023 at 4:32 PM EEST, Jo Van Bulck wrote:
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

Bug fixes should be always in the head of the patch set.

BR, Jarkko
