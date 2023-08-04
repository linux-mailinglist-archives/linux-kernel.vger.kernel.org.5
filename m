Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0C47705EC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjHDQZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjHDQZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:25:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E51349E0;
        Fri,  4 Aug 2023 09:25:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E084262089;
        Fri,  4 Aug 2023 16:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45E9C433C7;
        Fri,  4 Aug 2023 16:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691166308;
        bh=jjSTnzBTS7Nbc8Ju1cnYAAgflL3m3QxpQ4xoOfTJ380=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YuH03ZqnwShK6A13o3unRpSgqb6/igekHSMutA+Eo0RfiF8xzBDo2lQrzSlUarE4G
         A4D2wNgoJ/lzDWsynaz/dWmMnZz6leoLHCf5STsicR/NN+JnWC+6ix9gTiOukjd8+H
         2uvcpK9PaCFQL6XPp14LbgK5NhnEvBTlJIdkzamjg+UvXM8xZLt4qClDfdV+diKR1I
         /qjNihmwr5eY4yDOsqWAnEX3EC+YLQMZ7gtLWQrBZIrzaeuftw+vuPNrZ1TaMXNDgR
         efHQCl8kQpqypNx8VX/2DTx24oBypwUT0CdhG+i4m89F4VZwznbhQMv144cfQEFclH
         ExZfBkOFiptEA==
Date:   Fri, 4 Aug 2023 17:25:03 +0100
From:   Will Deacon <will@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] crypto: arm64/aes: remove Makefile hack
Message-ID: <20230804162502.GB30679@willie-the-truck>
References: <20230801101146.1550814-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801101146.1550814-1-masahiroy@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 07:11:46PM +0900, Masahiro Yamada wrote:
> Do it more simiply. This also fixes single target builds.
> 
> [before]
> 
>   $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- arch/arm64/crypto/aes-glue-ce.i
>     [snip]
>   make[4]: *** No rule to make target 'arch/arm64/crypto/aes-glue-ce.i'.  Stop.
> 
> [after]
> 
>   $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- arch/arm64/crypto/aes-glue-ce.i
>     [snip]
>     CPP     arch/arm64/crypto/aes-glue-ce.i
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/arm64/crypto/Makefile        | 5 -----
>  arch/arm64/crypto/aes-glue-ce.c   | 2 ++
>  arch/arm64/crypto/aes-glue-neon.c | 1 +
>  3 files changed, 3 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm64/crypto/aes-glue-ce.c
>  create mode 100644 arch/arm64/crypto/aes-glue-neon.c
> 
> diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
> index 4818e204c2ac..fbe64dce66e0 100644
> --- a/arch/arm64/crypto/Makefile
> +++ b/arch/arm64/crypto/Makefile
> @@ -81,11 +81,6 @@ aes-arm64-y := aes-cipher-core.o aes-cipher-glue.o
>  obj-$(CONFIG_CRYPTO_AES_ARM64_BS) += aes-neon-bs.o
>  aes-neon-bs-y := aes-neonbs-core.o aes-neonbs-glue.o
>  
> -CFLAGS_aes-glue-ce.o	:= -DUSE_V8_CRYPTO_EXTENSIONS
> -
> -$(obj)/aes-glue-%.o: $(src)/aes-glue.c FORCE
> -	$(call if_changed_rule,cc_o_c)
> -
>  quiet_cmd_perlasm = PERLASM $@
>        cmd_perlasm = $(PERL) $(<) void $(@)
>  
> diff --git a/arch/arm64/crypto/aes-glue-ce.c b/arch/arm64/crypto/aes-glue-ce.c
> new file mode 100644
> index 000000000000..7d309ceeddf3
> --- /dev/null
> +++ b/arch/arm64/crypto/aes-glue-ce.c
> @@ -0,0 +1,2 @@
> +#define USE_V8_CRYPTO_EXTENSIONS
> +#include "aes-glue.c"
> diff --git a/arch/arm64/crypto/aes-glue-neon.c b/arch/arm64/crypto/aes-glue-neon.c
> new file mode 100644
> index 000000000000..8ba046321064
> --- /dev/null
> +++ b/arch/arm64/crypto/aes-glue-neon.c
> @@ -0,0 +1 @@
> +#include "aes-glue.c"

Acked-by: Will Deacon <will@kernel.org>

I'm assuming Herbert will pick this up, but please let me know if I
should take it instead.

Will
