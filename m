Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86A57FC22D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345987AbjK1RWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346340AbjK1RWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:22:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590041FF6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:22:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE15C433C7;
        Tue, 28 Nov 2023 17:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701192126;
        bh=BxgWMmNBAAOSdm8WwYO/5VPHyP5a/HefoiG82LTsiXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IAOVcukNJWQoC/k0OdYjlcEP792sUnsYaWtVoTIo4iXOi/TA8Iw0d8UEWTi520RkM
         jF5s+XnbodDqETNhdgXZoVG2xKlSu/WgD9Ywvix02FSGf+X68Bs62BvAH3YXfV0Rli
         x9fCU1nlCNsaq0hwmvnUHSOkfPdf9a/3DNwprFErBki44OWBvyzB2N5durYIG7AA5F
         FKnLRzcw+2Uy+/6ny2AxqcyvitfRO5Bzbu7gFaoJp0uro8GInmVlrBfEj7PmTPR6vX
         lMhkqWuLynzYE/P6XcGaoIq0msxDNqxVW8Ew6Zqsb1VlWcBWEl3vchxLRTB7yvvl7N
         hqq1vB0ELYDwQ==
Date:   Tue, 28 Nov 2023 09:22:04 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jerry Shih <jerry.shih@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        Albert Ou <aou@eecs.berkeley.edu>, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com, ardb@kernel.org,
        heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 05/13] crypto: simd - Update `walksize` in simd
 skcipher
Message-ID: <20231128172204.GB1148@sol.localdomain>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
 <20231127070703.1697-6-jerry.shih@sifive.com>
 <20231128035814.GH1463@sol.localdomain>
 <56F07E23-CA7D-466B-84C7-643F2839E199@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56F07E23-CA7D-466B-84C7-643F2839E199@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 01:38:29PM +0800, Jerry Shih wrote:
> On Nov 28, 2023, at 11:58, Eric Biggers <ebiggers@kernel.org> wrote:
> > On Mon, Nov 27, 2023 at 03:06:55PM +0800, Jerry Shih wrote:
> >> The `walksize` assignment is missed in simd skcipher.
> >> 
> >> Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
> >> ---
> >> crypto/cryptd.c | 1 +
> >> crypto/simd.c   | 1 +
> >> 2 files changed, 2 insertions(+)
> >> 
> >> diff --git a/crypto/cryptd.c b/crypto/cryptd.c
> >> index bbcc368b6a55..253d13504ccb 100644
> >> --- a/crypto/cryptd.c
> >> +++ b/crypto/cryptd.c
> >> @@ -405,6 +405,7 @@ static int cryptd_create_skcipher(struct crypto_template *tmpl,
> >> 		(alg->base.cra_flags & CRYPTO_ALG_INTERNAL);
> >> 	inst->alg.ivsize = crypto_skcipher_alg_ivsize(alg);
> >> 	inst->alg.chunksize = crypto_skcipher_alg_chunksize(alg);
> >> +	inst->alg.walksize = crypto_skcipher_alg_walksize(alg);
> >> 	inst->alg.min_keysize = crypto_skcipher_alg_min_keysize(alg);
> >> 	inst->alg.max_keysize = crypto_skcipher_alg_max_keysize(alg);
> >> 
> >> diff --git a/crypto/simd.c b/crypto/simd.c
> >> index edaa479a1ec5..ea0caabf90f1 100644
> >> --- a/crypto/simd.c
> >> +++ b/crypto/simd.c
> >> @@ -181,6 +181,7 @@ struct simd_skcipher_alg *simd_skcipher_create_compat(const char *algname,
> >> 
> >> 	alg->ivsize = ialg->ivsize;
> >> 	alg->chunksize = ialg->chunksize;
> >> +	alg->walksize = ialg->walksize;
> >> 	alg->min_keysize = ialg->min_keysize;
> >> 	alg->max_keysize = ialg->max_keysize;
> > 
> > What are the consequences of this bug?  I wonder if it actually matters?  The
> > "inner" algorithm is the one that actually gets used for the "walk", right?
> > 
> > - Eric
> 
> Without this, we might still use chunksize or cra_blocksize as the walksize
> even though we setup with the larger walksize.
> 
> Here is the code for the walksize default value:
> 	static int skcipher_prepare_alg(struct skcipher_alg *alg)
> 	{
> 		...
> 		if (!alg->chunksize)
> 			alg->chunksize = base->cra_blocksize;
> 		if (!alg->walksize)
> 			alg->walksize = alg->chunksize;
> 
> And we already have the bigger walksize for x86 aes-xts.
> 		.base = {
> 			.cra_name		= "__xts(aes)",
> 			...
> 		},
> 		.walksize	= 2 * AES_BLOCK_SIZE,
> 
> The x86 aes-xts only uses one `walk` to handle the tail elements. It assumes
> that the walksize contains 2 aes blocks. If walksize is not set correctly, maybe
> some tail elements is not processed in simd-cipher mode for x86 aes-xts.

With the SIMD helper there are three "algorithms": the underlying algorithm, the
cryptd algorithm, and the simd algorithm.  This patch makes the "walksize"
property be propagated from the underlying algorithm to the cryptd and simd
algorithms.  I don't see how that actually makes a difference, since the only
place the skcipher_walk happens is on the underlying algorithm.  So it uses the
"walksize" from the underlying algorithm, right?

- Eric
