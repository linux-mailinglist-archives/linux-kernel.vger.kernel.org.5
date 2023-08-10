Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09E2778129
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjHJTQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbjHJTQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:16:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B25270F;
        Thu, 10 Aug 2023 12:16:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AECF60C4B;
        Thu, 10 Aug 2023 19:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D641BC433C9;
        Thu, 10 Aug 2023 19:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691694980;
        bh=1k6TJyWRLtDzHhwBlCReLePuc3yfqmcB2KjYwvfQAhQ=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=Lhttd1uxQx+EFpY1Ox4DYMMwyvncaMqbgfvP0OuEcu5RigivqQwSng5QOVqn3yqGf
         stQIeLVdblIp+BXYh6f0KKnF6/GMWIVHWuqj7OoZXRFIYdijCP27HqcScrEHdz6r6S
         42vERmFQ4FqqorMRpudM69u+6EGdSUvVMQB7qU1NWgf83nZ8Ga5+tEdRaBjHuodmB6
         3B3gnr7rnwnt0cexPyI/XhyywpaCP0rxXrqHsaPHR0Q8I/8n+ixNguAxPik930Fpo7
         FB8hrBChjx6BzcrHvXpaNh4hD3V+St759OYe7jktR06oy1denZzQ+2zDguIjNJjJbu
         M3OiqROq2g3Jg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 22:15:58 +0300
Message-Id: <CUP3TB4H4634.2DQVS1LU9TW89@suppilovahvero>
Cc:     <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 1/8] selftests/sgx: Fix uninitialized pointer
 dereference in error path
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>, <kai.huang@intel.com>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230808193145.8860-1-jo.vanbulck@cs.kuleuven.be>
 <20230808193145.8860-2-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230808193145.8860-2-jo.vanbulck@cs.kuleuven.be>
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
> Ensure ctx is zero-initialized, such that the encl_measure function will
> not call EVP_MD_CTX_destroy with an uninitialized ctx pointer in case of =
an
> early error during key generation.
>
> Fixes: 2adcba79e69d ("selftests/x86: Add a selftest for SGX")
> Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
> ---
>  tools/testing/selftests/sgx/sigstruct.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/self=
tests/sgx/sigstruct.c
> index a07896a46364..d73b29becf5b 100644
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
> @@ -384,7 +384,8 @@ bool encl_measure(struct encl *encl)
>  	return true;
> =20
>  err:
> -	EVP_MD_CTX_destroy(ctx);
> +	if (ctx)
> +		EVP_MD_CTX_destroy(ctx);
>  	RSA_free(key);
>  	return false;
>  }
> --=20
> 2.34.1

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
