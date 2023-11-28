Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32E07FB0BD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbjK1D41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 22:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjK1D40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 22:56:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F05918F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 19:56:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AB4C433C8;
        Tue, 28 Nov 2023 03:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701143792;
        bh=WjCFklQtOqf81uorIGsoppOMkx+RH2HrsqXNbDg296w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bXn+gVLYClewyVh4gauMobUQySkuWPZlNWRXYOqVBZOndYo80wvV+QXyKy7lyRrXR
         P4x9KxE+Z8BGAKzNtvE0/hUH/xuy7ochY4+j0gjlFgZ2VE/vE279bsx2IAZNTO5DBm
         t3jCbNSguAnMBfYueuZjUNc8nD2BkCjQXWEtZ1JkjLxSsayyR7ocfEVeLgUVKikHXJ
         Vsc4X4CjHaWvrzML0PPVbtfvUS0qcqWJalReTbX1zcbdUXv7gZkj4I6amM46ne/rSl
         XUjxBqTprF5Zbw01ztPhc37bJLmpAsaP1un28ub4bE/jHdgojhy3fr5nJcx57Up0nV
         1z10T2CiJb9Wg==
Date:   Mon, 27 Nov 2023 19:56:30 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jerry Shih <jerry.shih@sifive.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com, ardb@kernel.org,
        heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 04/13] RISC-V: crypto: add Zvkned accelerated AES
 implementation
Message-ID: <20231128035630.GG1463@sol.localdomain>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
 <20231127070703.1697-5-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127070703.1697-5-jerry.shih@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 03:06:54PM +0800, Jerry Shih wrote:
> +int riscv64_aes_setkey(struct crypto_aes_ctx *ctx, const u8 *key,
> +		       unsigned int keylen)
> +{
> +	int ret;
> +
> +	ret = aes_check_keylen(keylen);
> +	if (ret < 0)
> +		return -EINVAL;
> +
> +	/*
> +	 * The RISC-V AES vector crypto key expanding doesn't support AES-192.
> +	 * Use the generic software key expanding for that case.
> +	 */
> +	if ((keylen == 16 || keylen == 32) && crypto_simd_usable()) {
> +		/*
> +		 * All zvkned-based functions use encryption expanding keys for both
> +		 * encryption and decryption.
> +		 */
> +		kernel_vector_begin();
> +		rv64i_zvkned_set_encrypt_key(key, keylen, ctx);
> +		kernel_vector_end();
> +	} else {
> +		ret = aes_expandkey(ctx, key, keylen);
> +	}

rv64i_zvkned_set_encrypt_key() does not initialize crypto_aes_ctx::key_dec.
So, decryption results will be incorrect if !crypto_simd_usable() later.

> +static int aes_setkey(struct crypto_tfm *tfm, const u8 *key,
> +		      unsigned int keylen)

It's best to avoid generic-sounding function names like this that could collide
with functions in crypto/ or lib/crypto/.  A better name for this function, for
example, would be aes_setkey_zvkned().

> diff --git a/arch/riscv/crypto/aes-riscv64-zvkned.pl b/arch/riscv/crypto/aes-riscv64-zvkned.pl
> new file mode 100644
> index 000000000000..303e82d9f6f0
> --- /dev/null
> +++ b/arch/riscv/crypto/aes-riscv64-zvkned.pl
[...]
> +L_enc_128:
[...]
> +L_enc_192:
[...]
> +L_enc_256:

There's some severe source code duplication going on in the AES assembly, with
the three AES variants having separate source code.  You can just leave this
as-is since this is what was merged into OpenSSL and we are borrowing that for
now, but I do expect that we'll want to clean this up later.

- Eric
