Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBA7791E52
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 22:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbjIDUjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 16:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238397AbjIDUjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 16:39:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A225A189;
        Mon,  4 Sep 2023 13:39:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D13CBCE0FA7;
        Mon,  4 Sep 2023 20:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0142FC433C8;
        Mon,  4 Sep 2023 20:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693859981;
        bh=zPaqKpM+SsKtBuEbfCiSwFhpRPRduq4YIgnqM5TRD2k=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=tM6qw72QqY56VaXuHpX3mfZ7P8Ie82OoTTfA9ejm6n5frIhnxyyvpT8VvdUexwBI8
         k0QY9FLScvOELtxuxFNihAeTqgQm7H1BvTY/aLPu1VcR4NTP7eJR7mjoOviMoGvzdK
         iBoLhRvzRQigYZDahEqayElBJb+0V28dYlVJy3l4QeF2V/f4tAZgsWNVyBcLaOn+dd
         7A0UUAcvj6moDLrK/15lX++s4CkqzOWyqgOyUQ5olVXWCGq0xlRdrPiN/9aw08h8gL
         uo3LoVuNdsES9v2K3O/itynvE9DOQW9dGblMGGo624iRdZXTZu4fjcVrXYLrP6pqNi
         e3FuAgKryEp+g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 04 Sep 2023 23:39:37 +0300
Message-Id: <CVAF8ZE299H1.UFFIVHH8YCM8@suppilovahvero>
Cc:     <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v5 13/13] selftests/sgx: Remove incomplete ABI
 sanitization code in test enclave
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>, <kai.huang@intel.com>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230831134144.22686-1-jo.vanbulck@cs.kuleuven.be>
 <20230831134144.22686-14-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230831134144.22686-14-jo.vanbulck@cs.kuleuven.be>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Aug 31, 2023 at 4:41 PM EEST, Jo Van Bulck wrote:
> As the selftest enclave is *not* intended for production, simplify the
> code by not initializing CPU configuration registers as expected by the
> ABI on enclave entry or cleansing caller-save registers on enclave exit.
>
> Link: https://lore.kernel.org/all/da0cfb1e-e347-f7f2-ac72-aec0ee0d867d@in=
tel.com/
> Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
> ---
>  .../testing/selftests/sgx/test_encl_bootstrap.S  | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
>
> diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/te=
sting/selftests/sgx/test_encl_bootstrap.S
> index 28fe5d2ac0af..d8c4ac94e032 100644
> --- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
> +++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
> @@ -59,21 +59,11 @@ encl_entry_core:
> =20
>  	push	%rcx # push the address after EENTER
> =20
> +	# NOTE: as the selftest enclave is *not* intended for production,
> +	# simplify the code by not initializing ABI registers on entry or
> +	# cleansing caller-save registers on exit.
>  	call	encl_body
> =20
> -	/* Clear volatile GPRs, except RAX (EEXIT function). */
> -	xor     %rcx, %rcx
> -	xor     %rdx, %rdx
> -	xor     %rdi, %rdi
> -	xor     %rsi, %rsi
> -	xor     %r8, %r8
> -	xor     %r9, %r9
> -	xor     %r10, %r10
> -	xor     %r11, %r11
> -
> -	# Reset status flags.
> -	add     %rdx, %rdx # OF =3D SF =3D AF =3D CF =3D 0; ZF =3D PF =3D 1
> -
>  	# Prepare EEXIT target by popping the address of the instruction after
>  	# EENTER to RBX.
>  	pop	%rbx
> --=20
> 2.25.1

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
