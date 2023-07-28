Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B268E7675F9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjG1TEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjG1TEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:04:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4302DE48;
        Fri, 28 Jul 2023 12:03:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C955B621D3;
        Fri, 28 Jul 2023 19:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4333EC433C8;
        Fri, 28 Jul 2023 19:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690571038;
        bh=QDZem+8qSvLdha9A8EUPTt8gEUNGutbkwgAOj23ovTM=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=GJQoWRumkBMBvO7UDy1MEYZQM6/6RznlmFmv7b5/ISTssCIf48a8qQHmNgZI6tttu
         8u7y/NCA3UogGIZWaPsykIatfbNAbmPv2/JbaqiVGjhQ98ZUY+zPvqmo3g0yFs8rMA
         4VoeJSdcMR1TaFgvL9+O7AojVqCFYHBvKu+r0qYUFK1nBKufhjkQ6f7A5XklGn1T1x
         afzDNTltM0lEvqNhhaw9Si6FyCN2KUzlKVypgZxpmzZHAB6eqv/qhlUIbUophGZhxF
         riIThAE5ZReusRZs7qF4m442mmhy+pH0qLGaINAEEGYo5qQRPhj+rqMlklIT+yNB1V
         gDrnp5T3atMDA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 19:03:55 +0000
Message-Id: <CUE1EZWZ2B1V.3RB2KB8Q2A52W@seitikki>
Cc:     <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 1/5] selftests/sgx: Fix uninitialized pointer
 dereference in error path.
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230724165832.15797-1-jo.vanbulck@cs.kuleuven.be>
 <20230724165832.15797-2-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230724165832.15797-2-jo.vanbulck@cs.kuleuven.be>
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
> Ensure ctx is zero-initialized, such that the encl_measure function will
> not call EVP_MD_CTX_destroy with an uninitialized ctx pointer in case of =
an
> early error during key generation.
>
> Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
> ---
>  tools/testing/selftests/sgx/sigstruct.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/self=
tests/sgx/sigstruct.c
> index a07896a46364..dd1fdab90e26 100644
> --- a/tools/testing/selftests/sgx/sigstruct.c
> +++ b/tools/testing/selftests/sgx/sigstruct.c
> @@ -318,9 +318,9 @@ bool encl_measure(struct encl *encl)
>  	struct sgx_sigstruct *sigstruct =3D &encl->sigstruct;
>  	struct sgx_sigstruct_payload payload;
>  	uint8_t digest[SHA256_DIGEST_LENGTH];
> +	EVP_MD_CTX *ctx =3D NULL;
>  	unsigned int siglen;
>  	RSA *key =3D NULL;
> -	EVP_MD_CTX *ctx;
>  	int i;
> =20
>  	memset(sigstruct, 0, sizeof(*sigstruct));
> --=20
> 2.34.1

Add a fixes tag. In other words, find the commit ID that caused the issue
and add the output of the following to this patch before your sob:

git --no-pager log --format=3D'Fixes: %h ("%s")' --abbrev=3D12 -1 <commit I=
D>;

BR, Jarkko
