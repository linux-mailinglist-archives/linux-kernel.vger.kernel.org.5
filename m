Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37A07AE4D7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 07:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjIZFGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 01:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjIZFGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 01:06:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258EDDC;
        Mon, 25 Sep 2023 22:06:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8E6C433C8;
        Tue, 26 Sep 2023 05:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695704805;
        bh=04dKfnOt6jEKPxwkniGL3P38q9oto41OSV6p0OgWBIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZldrbfxNPKu8jueRKGLY1eqPhp0ykF13KaryWKWN/pEIfaa3C++YV9AZUyEAI24Vo
         NsxEf+/LYSfsuppRdivywQq4TsHpsBvh/QY3jKTWZ88P08Joyega0mNtImbPaVTndP
         8t8ko1JTFu80b9LZk1Y6yo1QgOlmIu/7mMorE6o51LAJL7VB/mgeADtOK5U8PiihiN
         q0hiOXWfQehWhd83Tu7EPo4fv2dnoz70z3eQrb8IkXoRa1XcRwDdtoCFZThAMvn4+U
         PPz6xc/5S/uqoTOo6XaXaDTfbAxgpgG1WpMFI5WPk/u6BnY86fiYKSpD3tq+JA5TFy
         MaO2TDQh1onQg==
Date:   Mon, 25 Sep 2023 22:06:43 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net, x86@kernel.org
Subject: Re: [PATCH 1/3] crypto: x86/aesni - Refactor the common address
 alignment code
Message-ID: <20230926050643.GB3118@sol.localdomain>
References: <20230925151752.162449-1-chang.seok.bae@intel.com>
 <20230925151752.162449-2-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925151752.162449-2-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 08:17:50AM -0700, Chang S. Bae wrote:
> The address alignment code has been duplicated for each mode. Instead
> of duplicating the same code, refactor the alignment code and simplify
> the alignment helpers.
> 
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: linux-crypto@vger.kernel.org
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Link: https://lore.kernel.org/all/20230526065414.GB875@sol.localdomain/
> ---
>  arch/x86/crypto/aesni-intel_glue.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
> index 39d6a62ac627..241d38ae1ed9 100644
> --- a/arch/x86/crypto/aesni-intel_glue.c
> +++ b/arch/x86/crypto/aesni-intel_glue.c
> @@ -80,6 +80,13 @@ struct gcm_context_data {
>  	u8 hash_keys[GCM_BLOCK_LEN * 16];
>  };
>  
> +static inline void *aes_align_addr(void *addr)
> +{
> +	if (crypto_tfm_ctx_alignment() >= AESNI_ALIGN)
> +		return addr;
> +	return PTR_ALIGN(addr, AESNI_ALIGN);
> +}
> +
>  asmlinkage int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
>  			     unsigned int key_len);
>  asmlinkage void aesni_enc(const void *ctx, u8 *out, const u8 *in);
> @@ -201,32 +208,19 @@ static __ro_after_init DEFINE_STATIC_KEY_FALSE(gcm_use_avx2);
>  static inline struct
>  aesni_rfc4106_gcm_ctx *aesni_rfc4106_gcm_ctx_get(struct crypto_aead *tfm)
>  {
> -	unsigned long align = AESNI_ALIGN;
> -
> -	if (align <= crypto_tfm_ctx_alignment())
> -		align = 1;
> -	return PTR_ALIGN(crypto_aead_ctx(tfm), align);
> +	return (struct aesni_rfc4106_gcm_ctx *)aes_align_addr(crypto_aead_ctx(tfm));
>  }
>  
>  static inline struct
>  generic_gcmaes_ctx *generic_gcmaes_ctx_get(struct crypto_aead *tfm)
>  {
> -	unsigned long align = AESNI_ALIGN;
> -
> -	if (align <= crypto_tfm_ctx_alignment())
> -		align = 1;
> -	return PTR_ALIGN(crypto_aead_ctx(tfm), align);
> +	return (struct generic_gcmaes_ctx *)aes_align_addr(crypto_aead_ctx(tfm));
>  }
>  #endif
>  
>  static inline struct crypto_aes_ctx *aes_ctx(void *raw_ctx)
>  {
> -	unsigned long addr = (unsigned long)raw_ctx;
> -	unsigned long align = AESNI_ALIGN;
> -
> -	if (align <= crypto_tfm_ctx_alignment())
> -		align = 1;
> -	return (struct crypto_aes_ctx *)ALIGN(addr, align);
> +	return (struct crypto_aes_ctx *)aes_align_addr(raw_ctx);
>  }

The casts can be dropped, since aes_align_addr() returns 'void *'.

- Eric
