Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F167FB0D0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 05:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbjK1EHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 23:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjK1EHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 23:07:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4F8C1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 20:07:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2B1C433C7;
        Tue, 28 Nov 2023 04:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701144439;
        bh=V2rKuLTlh3qLJnd3xvBBMHtL+0fSAxw4uf0Z7xUqYvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=czIQF659i35wLPWZtbxx5n6+JFL9eXiHD6OAuVN/mbgn8XW6v+5P5y1PMeIjASfTV
         s0zyWtW9BM21cQLAN7NClQvzbCaIj7DKkD4eglqDDcLVCC20qxd6ChG2Y89ql8GZae
         vOPZMUlFJBLIF/q1OKOCxB5VEeIVJPHbNBcEuaTPQWHFPyYsKz075OFX4IUUaUR2GE
         qqRJftkRLSHhE1xJ33cjoaMlb4t5jnly1PTxyNztXtr63zMtJ81ytmFZMa/UO4z6dw
         MJKD59fZ98Z6zDcKn3AQKoTOhdJx4Iwa7tqoplMSXlWjsf4dvVd3koEdNWXC9xS5Lb
         WqnnmqDVzGFLg==
Date:   Mon, 27 Nov 2023 20:07:16 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jerry Shih <jerry.shih@sifive.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com, ardb@kernel.org,
        heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 07/13] RISC-V: crypto: add accelerated
 AES-CBC/CTR/ECB/XTS implementations
Message-ID: <20231128040716.GI1463@sol.localdomain>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
 <20231127070703.1697-8-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127070703.1697-8-jerry.shih@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 03:06:57PM +0800, Jerry Shih wrote:
> +typedef void (*aes_xts_func)(const u8 *in, u8 *out, size_t length,
> +			     const struct crypto_aes_ctx *key, u8 *iv,
> +			     int update_iv);

There's no need for this indirection, because the function pointer can only have
one value.

Note also that when Control Flow Integrity is enabled, assembly functions can
only be called indirectly when they use SYM_TYPED_FUNC_START.  That's another
reason to avoid indirect calls that aren't actually necessary.

> +			nbytes &= (~(AES_BLOCK_SIZE - 1));

Expressions like ~(n - 1) should not have another set of parentheses around them

> +static int xts_crypt(struct skcipher_request *req, aes_xts_func func)
> +{
> +	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
> +	const struct riscv64_aes_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
> +	struct skcipher_request sub_req;
> +	struct scatterlist sg_src[2], sg_dst[2];
> +	struct scatterlist *src, *dst;
> +	struct skcipher_walk walk;
> +	unsigned int walk_size = crypto_skcipher_walksize(tfm);
> +	unsigned int tail_bytes;
> +	unsigned int head_bytes;
> +	unsigned int nbytes;
> +	unsigned int update_iv = 1;
> +	int err;
> +
> +	/* xts input size should be bigger than AES_BLOCK_SIZE */
> +	if (req->cryptlen < AES_BLOCK_SIZE)
> +		return -EINVAL;
> +
> +	/*
> +	 * We split xts-aes cryption into `head` and `tail` parts.
> +	 * The head block contains the input from the beginning which doesn't need
> +	 * `ciphertext stealing` method.
> +	 * The tail block contains at least two AES blocks including ciphertext
> +	 * stealing data from the end.
> +	 */
> +	if (req->cryptlen <= walk_size) {
> +		/*
> +		 * All data is in one `walk`. We could handle it within one AES-XTS call in
> +		 * the end.
> +		 */
> +		tail_bytes = req->cryptlen;
> +		head_bytes = 0;
> +	} else {
> +		if (req->cryptlen & (AES_BLOCK_SIZE - 1)) {
> +			/*
> +			 * with ciphertext stealing
> +			 *
> +			 * Find the largest tail size which is small than `walk` size while the
> +			 * head part still fits AES block boundary.
> +			 */
> +			tail_bytes = req->cryptlen & (AES_BLOCK_SIZE - 1);
> +			tail_bytes = walk_size + tail_bytes - AES_BLOCK_SIZE;
> +			head_bytes = req->cryptlen - tail_bytes;
> +		} else {
> +			/* no ciphertext stealing */
> +			tail_bytes = 0;
> +			head_bytes = req->cryptlen;
> +		}
> +	}
> +
> +	riscv64_aes_encrypt_zvkned(&ctx->ctx2, req->iv, req->iv);
> +
> +	if (head_bytes && tail_bytes) {
> +		/* If we have to parts, setup new request for head part only. */
> +		skcipher_request_set_tfm(&sub_req, tfm);
> +		skcipher_request_set_callback(
> +			&sub_req, skcipher_request_flags(req), NULL, NULL);
> +		skcipher_request_set_crypt(&sub_req, req->src, req->dst,
> +					   head_bytes, req->iv);
> +		req = &sub_req;
> +	}
> +
> +	if (head_bytes) {
> +		err = skcipher_walk_virt(&walk, req, false);
> +		while ((nbytes = walk.nbytes)) {
> +			if (nbytes == walk.total)
> +				update_iv = (tail_bytes > 0);
> +
> +			nbytes &= (~(AES_BLOCK_SIZE - 1));
> +			kernel_vector_begin();
> +			func(walk.src.virt.addr, walk.dst.virt.addr, nbytes,
> +			     &ctx->ctx1, req->iv, update_iv);
> +			kernel_vector_end();
> +
> +			err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
> +		}
> +		if (err || !tail_bytes)
> +			return err;
> +
> +		/*
> +		 * Setup new request for tail part.
> +		 * We use `scatterwalk_next()` to find the next scatterlist from last
> +		 * walk instead of iterating from the beginning.
> +		 */
> +		dst = src = scatterwalk_next(sg_src, &walk.in);
> +		if (req->dst != req->src)
> +			dst = scatterwalk_next(sg_dst, &walk.out);
> +		skcipher_request_set_crypt(req, src, dst, tail_bytes, req->iv);
> +	}
> +
> +	/* tail */
> +	err = skcipher_walk_virt(&walk, req, false);
> +	if (err)
> +		return err;
> +	if (walk.nbytes != tail_bytes)
> +		return -EINVAL;
> +	kernel_vector_begin();
> +	func(walk.src.virt.addr, walk.dst.virt.addr, walk.nbytes, &ctx->ctx1,
> +	     req->iv, 0);
> +	kernel_vector_end();
> +
> +	return skcipher_walk_done(&walk, 0);
> +}

Did you consider writing xts_crypt() the way that arm64 and x86 do it?  The
above seems to reinvent sort of the same thing from first principles.  I'm
wondering if you should just copy the existing approach for now.  Then there
would be no need to add the scatterwalk_next() function, and also the handling
of inputs that don't need ciphertext stealing would be a bit more streamlined.

> +static int __init riscv64_aes_block_mod_init(void)
> +{
> +	int ret = -ENODEV;
> +
> +	if (riscv_isa_extension_available(NULL, ZVKNED) &&
> +	    riscv_vector_vlen() >= 128 && riscv_vector_vlen() <= 2048) {
> +		ret = simd_register_skciphers_compat(
> +			riscv64_aes_algs_zvkned,
> +			ARRAY_SIZE(riscv64_aes_algs_zvkned),
> +			riscv64_aes_simd_algs_zvkned);
> +		if (ret)
> +			return ret;
> +
> +		if (riscv_isa_extension_available(NULL, ZVBB)) {
> +			ret = simd_register_skciphers_compat(
> +				riscv64_aes_alg_zvkned_zvkb,
> +				ARRAY_SIZE(riscv64_aes_alg_zvkned_zvkb),
> +				riscv64_aes_simd_alg_zvkned_zvkb);
> +			if (ret)
> +				goto unregister_zvkned;

This makes the registration of the zvkned-zvkb algorithm conditional on zvbb,
not zvkb.  Shouldn't the extension checks actually look like:

    ZVKNED
        ZVKB
            ZVBB && ZVKG
        
- Eric
