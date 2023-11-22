Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2B17F3B6E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343495AbjKVBmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKVBmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:42:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E713810C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:42:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076F8C433C8;
        Wed, 22 Nov 2023 01:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700617338;
        bh=BNdihuo6rMnCzk1/H6PiwRe9wn5OD68XRMeNziQ7hKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QvdIFPLM2XOIWcKAqJ/k3h+HTLKJW8KwrJsH1YD42WUtYML5oTfWjgYZcPZqhktiL
         ObmedCPih8bwLUhsNhT7IswXr4Fi3AlH4ekgn5ym+RCQpj9W5CAxJxkRevjyowspz/
         UgIBvI6egKKR6JWAUHeAKI09Zs4LeZ/R7SNXL1Qqxy38Fa2/18SzxWYHl082RI+fUq
         SdiZelsghStv/d3IlXC40lRpsGVtOI+baigtMua9K2aTokV6OMkzfxM+TR0Y4NfBc7
         LD3+QEnTT4w5zzmG0kciJ+1V688wsVUUFYhZvstXKPYpxNBp6MA7wPfj9iqp9BN0Sy
         20wWeFKRPGiaA==
Date:   Tue, 21 Nov 2023 17:42:16 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jerry Shih <jerry.shih@sifive.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, andy.chiu@sifive.com, greentime.hu@sifive.com,
        conor.dooley@microchip.com, guoren@kernel.org, bjorn@rivosinc.com,
        heiko@sntech.de, ardb@kernel.org, phoebe.chen@sifive.com,
        hongrong.hsu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 07/12] RISC-V: crypto: add Zvkg accelerated GCM GHASH
 implementation
Message-ID: <20231122014216.GI2172@sol.localdomain>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
 <20231025183644.8735-8-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025183644.8735-8-jerry.shih@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 02:36:39AM +0800, Jerry Shih wrote:
> +struct riscv64_ghash_context {
> +	be128 key;
> +};
> +
> +struct riscv64_ghash_desc_ctx {
> +	be128 shash;
> +	u8 buffer[GHASH_BLOCK_SIZE];
> +	u32 bytes;
> +};

I recommend calling the first struct 'riscv64_ghash_tfm_ctx', and making the
pointers to it be named 'tctx'.  That would more clearly distinguish it from the
desc_ctx / dctx.

> +
> +typedef void (*ghash_func)(be128 *Xi, const be128 *H, const u8 *inp,
> +			   size_t len);
> +
> +static inline void ghash_blocks(const struct riscv64_ghash_context *ctx,
> +				struct riscv64_ghash_desc_ctx *dctx,
> +				const u8 *src, size_t srclen, ghash_func func)
> +	if (crypto_simd_usable()) {
> +		kernel_vector_begin();
> +		func(&dctx->shash, &ctx->key, src, srclen);
> +		kernel_vector_end();

The indirection to ghash_func is unnecessary, since the only value is
gcm_ghash_rv64i_zvkg.

This also means that ghash_update() should be folded into ghash_update_zvkg(),
and ghash_final() into ghash_final_zvkg().

> +	} else {
> +		while (srclen >= GHASH_BLOCK_SIZE) {
> +			crypto_xor((u8 *)&dctx->shash, src, GHASH_BLOCK_SIZE);
> +			gf128mul_lle(&dctx->shash, &ctx->key);
> +			srclen -= GHASH_BLOCK_SIZE;
> +			src += GHASH_BLOCK_SIZE;
> +		}
> +	}

The assembly code uses the equivalent of the following do-while loop instead:

        do {
                srclen -= GHASH_BLOCK_SIZE;
        } while (srclen);

I.e., it assumes the length here is nonzero and a multiple of 16, which it is.

To avoid confusion, I recommend making the C code use the same do-while loop.


>        const struct riscv64_ghash_context *ctx =
>               crypto_tfm_ctx(crypto_shash_tfm(desc->tfm));

crypto_tfm_ctx(crypto_shash_tfm(tfm)) should be crypto_shash_ctx(tfm)

> +static int ghash_final(struct shash_desc *desc, u8 *out, ghash_func func)
> +{
> +	const struct riscv64_ghash_context *ctx =
> +		crypto_tfm_ctx(crypto_shash_tfm(desc->tfm));
> +	struct riscv64_ghash_desc_ctx *dctx = shash_desc_ctx(desc);
> +	int i;
> +
> +	if (dctx->bytes) {
> +		for (i = dctx->bytes; i < GHASH_BLOCK_SIZE; i++)
> +			dctx->buffer[i] = 0;
> +
> +		ghash_blocks(ctx, dctx, dctx->buffer, GHASH_BLOCK_SIZE, func);
> +		dctx->bytes = 0;
> +	}
> +

Setting dctx->bytes above is unnecessary.

> +static int ghash_init(struct shash_desc *desc)
> +{
> +	struct riscv64_ghash_desc_ctx *dctx = shash_desc_ctx(desc);
> +
> +	*dctx = (struct riscv64_ghash_desc_ctx){};
> +
> +	return 0;
> +}
> +
> +static int ghash_update_zvkg(struct shash_desc *desc, const u8 *src,
> +			     unsigned int srclen)
> +{
> +	return ghash_update(desc, src, srclen, gcm_ghash_rv64i_zvkg);
> +}
> +
> +static int ghash_final_zvkg(struct shash_desc *desc, u8 *out)
> +{
> +	return ghash_final(desc, out, gcm_ghash_rv64i_zvkg);
> +}
> +
> +static int ghash_setkey(struct crypto_shash *tfm, const u8 *key,
> +			unsigned int keylen)
> +{
> +	struct riscv64_ghash_context *ctx =
> +		crypto_tfm_ctx(crypto_shash_tfm(tfm));
> +
> +	if (keylen != GHASH_BLOCK_SIZE)
> +		return -EINVAL;
> +
> +	memcpy(&ctx->key, key, GHASH_BLOCK_SIZE);
> +
> +	return 0;
> +}
> +
> +static struct shash_alg riscv64_ghash_alg_zvkg = {
> +	.digestsize = GHASH_DIGEST_SIZE,
> +	.init = ghash_init,
> +	.update = ghash_update_zvkg,
> +	.final = ghash_final_zvkg,
> +	.setkey = ghash_setkey,

IMO it's helpful to order the shash functions as follows, both in their
definitions and their fields in struct shash_alg:

    setkey
    init
    update
    final

That matches the order in which they're called.

- Eric
