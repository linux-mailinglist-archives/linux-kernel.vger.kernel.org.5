Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A3F7FB0FE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 05:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbjK1Eiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 23:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjK1Eit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 23:38:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878CF10CB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 20:38:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71197C433C8;
        Tue, 28 Nov 2023 04:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701146334;
        bh=okh53jySklBGnFmmAyg5idpxQ+nkjU2LJa1Z0hyQQf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tzG0kuansrDTnI3UvvMdfptVZHEeEwuCbsWaxDfrPRwZ11xb1ca+7ejaqRhULTHoK
         cwToWDPqZxpUeFTvmmSazzNqfrXVH0IzJpx4AXktcsGCQR4lNn1YT/dZ9poHZRfpd3
         zXGwVED/m0Shy95MyiwRa/TR1S2FF6gy/npEH1EmlSfS4QbC7NQNmna2A1z4NZ3Fd2
         gpkpTus8EZYBLiwU35kegPaRToTYoVk+V9VEv9y2pe3LZcsG2ajXTnz+t0yMlDF59d
         YMfKMGIDZndDOI6jMA9AGCcwGxxVXSiNHQ4iur3btFEYrhvdjBK35aQOCUpUAWtOt5
         /sw1eXcJ7UhhQ==
Date:   Mon, 27 Nov 2023 20:38:52 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jerry Shih <jerry.shih@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        Albert Ou <aou@eecs.berkeley.edu>, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com, ardb@kernel.org,
        heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 04/13] RISC-V: crypto: add Zvkned accelerated AES
 implementation
Message-ID: <20231128043852.GM1463@sol.localdomain>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
 <20231127070703.1697-5-jerry.shih@sifive.com>
 <20231128035630.GG1463@sol.localdomain>
 <8BE5BD19-7401-455D-838B-56264F78471B@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8BE5BD19-7401-455D-838B-56264F78471B@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 12:22:26PM +0800, Jerry Shih wrote:
> On Nov 28, 2023, at 11:56, Eric Biggers <ebiggers@kernel.org> wrote:
> > On Mon, Nov 27, 2023 at 03:06:54PM +0800, Jerry Shih wrote:
> >> +int riscv64_aes_setkey(struct crypto_aes_ctx *ctx, const u8 *key,
> >> +		       unsigned int keylen)
> >> +{
> >> +	int ret;
> >> +
> >> +	ret = aes_check_keylen(keylen);
> >> +	if (ret < 0)
> >> +		return -EINVAL;
> >> +
> >> +	/*
> >> +	 * The RISC-V AES vector crypto key expanding doesn't support AES-192.
> >> +	 * Use the generic software key expanding for that case.
> >> +	 */
> >> +	if ((keylen == 16 || keylen == 32) && crypto_simd_usable()) {
> >> +		/*
> >> +		 * All zvkned-based functions use encryption expanding keys for both
> >> +		 * encryption and decryption.
> >> +		 */
> >> +		kernel_vector_begin();
> >> +		rv64i_zvkned_set_encrypt_key(key, keylen, ctx);
> >> +		kernel_vector_end();
> >> +	} else {
> >> +		ret = aes_expandkey(ctx, key, keylen);
> >> +	}
> > 
> > rv64i_zvkned_set_encrypt_key() does not initialize crypto_aes_ctx::key_dec.
> > So, decryption results will be incorrect if !crypto_simd_usable() later.
> 
> Will we have the situation that `crypto_simd_usable()` condition is not consistent
> during the aes_setkey(), aes_enc/dec()? If yes, all accelerated(or HW specific)
> crypto algorithms should do the same implementations as the sw fallback path
> since the `crypto_simd_usable()` will change back and forth.

Yes, the calls to one "crypto_cipher" can happen in different contexts.  For
example, crypto_simd_usable() can be true during setkey and false during
decrypt, or vice versa.

If the RISC-V decryption code wants to use the regular key schedule (key_enc)
instead of the "Equivalent Inverse Cipher key schedule" (key_dec), that's
perfectly fine, but setkey still needs to initialize key_dec in case the
fallback to aes_decrypt() gets taken.

> >> diff --git a/arch/riscv/crypto/aes-riscv64-zvkned.pl b/arch/riscv/crypto/aes-riscv64-zvkned.pl
> >> new file mode 100644
> >> index 000000000000..303e82d9f6f0
> >> --- /dev/null
> >> +++ b/arch/riscv/crypto/aes-riscv64-zvkned.pl
> > [...]
> >> +L_enc_128:
> > [...]
> >> +L_enc_192:
> > [...]
> >> +L_enc_256:
> > 
> > There's some severe source code duplication going on in the AES assembly, with
> > the three AES variants having separate source code.  You can just leave this
> > as-is since this is what was merged into OpenSSL and we are borrowing that for
> > now, but I do expect that we'll want to clean this up later.
> 
> Do we prefer the code with the branches instead of the specified implementation?
> We could make AES-128/192/256 together like:
> 
>     @{[vaesz_vs $V24, $V1]}
>     @{[vaesem_vs $V24, $V2]}
>     @{[vaesem_vs $V24, $V3]}
>     @{[vaesem_vs $V24, $V4]}
>     @{[vaesem_vs $V24, $V5]}
>     @{[vaesem_vs $V24, $V6]}
>     @{[vaesem_vs $V24, $V7]}
>     @{[vaesem_vs $V24, $V8]}
>     @{[vaesem_vs $V24, $V9]}
>     @{[vaesem_vs $V24, $V10]}
>     beq $ROUND, $ROUND_11, 1f
>     @{[vaesem_vs $V24, $V11]}
>     @{[vaesem_vs $V24, $V12]}
>     beq $ROUND, $ROUND_13, 1f
>     @{[vaesem_vs $V24, $V13]}
>     @{[vaesem_vs $V24, $V14]}
> 1:
>     @{[vaesef_vs $V24, $V15]}
> 
> But we will have the additional costs for the branches.
> 

That needs to be decided on a case by case basis depending on the performance
impact and how much binary code is saved.  On some architectures, separate
binary code for AES-{128,192,256} has been found to be worthwhile.  However,
that does *not* mean that they need to have separate source code.  Take a look
at how arch/x86/crypto/aes_ctrby8_avx-x86_64.S generates code for all the AES
variants using macros, for example.

Anyway, I don't think you should bother making too many changes to the "perlasm"
files.  If we decide to make major cleanups I think we should just replace them
with .S files (which already support macros).

- Eric
