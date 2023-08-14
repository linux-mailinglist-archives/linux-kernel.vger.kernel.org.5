Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E5A77B8A4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjHNM3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjHNM2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:28:50 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E15CC;
        Mon, 14 Aug 2023 05:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1692016123;
        bh=2nm287AjV8yh7BNKPrm5uQTpVz6ChQJ5SjvZrIuBMQk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZcgVO9dyUPOaFIVjqdarUVsFTFqw25XWcNIUy+han/mIpep/0/Lml6HyVvaiZmMSY
         4U99V5iro2xE8D5dtSm9ZhnUwTPk9kcRyJ1sFQnplA4v5Rs6DTpZtreLKJi4oY4THq
         i37A2Rh8smo/tB60k1MJ0GlXhGrBxVtUK+jmJFkz46u9OGnVnOkS/J2j3YfpbtuZAJ
         +iaKoNH6kedLN233cDnA8ESqGeg0uMmMPAyF5aMvkUIJUkuXKPGVMRG1DplYN5USrp
         n85BsYuzl84dCswuc5GkU8Qxo6pTQBSKmMlgTnkzwNbffPcJd1NgZ7l3c470f7KL7e
         izHI/v2U69q7g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPYbZ29WJz4wZn;
        Mon, 14 Aug 2023 22:28:42 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Justin Stitt <justinstitt@google.com>,
        Geoff Levand <geoff@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH RFC 1/3] powerpc/ps3: refactor strncpy usage attempt 1
In-Reply-To: <20230811-strncpy-arch-powerpc-platforms-ps3-v1-1-301052a5663e@google.com>
References: <20230811-strncpy-arch-powerpc-platforms-ps3-v1-0-301052a5663e@google.com>
 <20230811-strncpy-arch-powerpc-platforms-ps3-v1-1-301052a5663e@google.com>
Date:   Mon, 14 Aug 2023 22:28:36 +1000
Message-ID: <87fs4lerkb.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Stitt <justinstitt@google.com> writes:
> This approach simply replicates the implementation of `make_field` which
> means we drop `strncpy` for `memcpy`.
>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  arch/powerpc/platforms/ps3/repository.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
> index 205763061a2d..1abe33fbe529 100644
> --- a/arch/powerpc/platforms/ps3/repository.c
> +++ b/arch/powerpc/platforms/ps3/repository.c
> @@ -73,9 +73,9 @@ static void _dump_node(unsigned int lpar_id, u64 n1, u64 n2, u64 n3, u64 n4,
>  
>  static u64 make_first_field(const char *text, u64 index)
>  {
> -	u64 n;
> +	u64 n = 0;
>  
> -	strncpy((char *)&n, text, 8);
> +	memcpy((char *)&n, text, strnlen(text, sizeof(n)));
>  	return PS3_VENDOR_ID_NONE + (n >> 32) + index;
>  }

I guess it's a slight improvement, because people generally know
memcpy's behaviour better than strncpy.

The change log should be a bit more verbose and mention that the result
is the same, including the NULL padding done my strncpy().

cheers
