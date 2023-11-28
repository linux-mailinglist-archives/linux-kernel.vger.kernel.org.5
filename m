Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51C97FB0C0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbjK1D6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 22:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjK1D6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 22:58:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440DAC1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 19:58:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808A6C433C9;
        Tue, 28 Nov 2023 03:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701143896;
        bh=klY2qd5BBTUFI2nKApEyF/o8Si9A4Wtb/ZgzMzwBObU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SzevbdpqhmhpmwTwMiKkHq1bskohNUwuQfXQeOf7Ch/TVNVhZeVRK1CT1GjSQOmoF
         C6bhekI0ZJVb1FVTvBskim8XI7ZODFyyf8iuS9eeCnyBMmkcu6VE3HnRAoAE2TH7UZ
         KI7oVZ+kXnp8gby6MaWucK8q7ZgmwCim2keIlGrl1Dsknz9XJTTDbEJ7gWc/puMijd
         9q4ekHg9SVrHHlIiSPuty/WEaZ94iY0t6L7lU3fe+8Bfkn6FnNxVFpZKnpXnbDh2Q/
         4W0BjIlI4QU7x0Mt+wRtDzeFPZ8ka7d7mEsacC6BpgevdejvAbOXC9Kheb/q5UpD2O
         LQi7JQFnaXHAw==
Date:   Mon, 27 Nov 2023 19:58:14 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jerry Shih <jerry.shih@sifive.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com, ardb@kernel.org,
        heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 05/13] crypto: simd - Update `walksize` in simd
 skcipher
Message-ID: <20231128035814.GH1463@sol.localdomain>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
 <20231127070703.1697-6-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127070703.1697-6-jerry.shih@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 03:06:55PM +0800, Jerry Shih wrote:
> The `walksize` assignment is missed in simd skcipher.
> 
> Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
> ---
>  crypto/cryptd.c | 1 +
>  crypto/simd.c   | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/crypto/cryptd.c b/crypto/cryptd.c
> index bbcc368b6a55..253d13504ccb 100644
> --- a/crypto/cryptd.c
> +++ b/crypto/cryptd.c
> @@ -405,6 +405,7 @@ static int cryptd_create_skcipher(struct crypto_template *tmpl,
>  		(alg->base.cra_flags & CRYPTO_ALG_INTERNAL);
>  	inst->alg.ivsize = crypto_skcipher_alg_ivsize(alg);
>  	inst->alg.chunksize = crypto_skcipher_alg_chunksize(alg);
> +	inst->alg.walksize = crypto_skcipher_alg_walksize(alg);
>  	inst->alg.min_keysize = crypto_skcipher_alg_min_keysize(alg);
>  	inst->alg.max_keysize = crypto_skcipher_alg_max_keysize(alg);
>  
> diff --git a/crypto/simd.c b/crypto/simd.c
> index edaa479a1ec5..ea0caabf90f1 100644
> --- a/crypto/simd.c
> +++ b/crypto/simd.c
> @@ -181,6 +181,7 @@ struct simd_skcipher_alg *simd_skcipher_create_compat(const char *algname,
>  
>  	alg->ivsize = ialg->ivsize;
>  	alg->chunksize = ialg->chunksize;
> +	alg->walksize = ialg->walksize;
>  	alg->min_keysize = ialg->min_keysize;
>  	alg->max_keysize = ialg->max_keysize;

What are the consequences of this bug?  I wonder if it actually matters?  The
"inner" algorithm is the one that actually gets used for the "walk", right?

- Eric
