Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AF57E6431
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 08:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjKIHQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 02:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKIHQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 02:16:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8BA2590
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 23:16:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDEAC433C7;
        Thu,  9 Nov 2023 07:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699514186;
        bh=bXtq92H2lB9I1j4FNYbEXcH9mwbTZ3yucWnUpEsvSu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b53gh+xjIAMX5TIJgr2iD0QbJEC/4hWxmS8AAAUQYv7lmKQ9umk4k9gi9TCo1tw+M
         svu0/XvTdxJaZQA0lEBUbNkhDZB/L1yO9RA6pzgMHzL6rEnaRyljRDVxg2mQfwkCwh
         Kv/B2Oi0+gdx5gHMETqbd4aS93Zdnt7J811QH/+cqB+9Lk1LrOyy+haKhyJ6jNUiep
         9Ifm795/MqeHQa93xPifVoL7kn+wWIxkH0HqpRVGVzcuJr3ayofZwDBrg1uTL6a4Ys
         ut7HSxk6F8+NeWPjlRw4F3AaE6eagdYCANS8dzcSjXNf+WbLnKeBmxj/B1XCS0JIRC
         Vw9az8ujLLo9w==
Date:   Wed, 8 Nov 2023 23:16:23 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jerry Shih <jerry.shih@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        Albert Ou <aou@eecs.berkeley.edu>, herbert@gondor.apana.org.au,
        davem@davemloft.net, andy.chiu@sifive.com, greentime.hu@sifive.com,
        conor.dooley@microchip.com, guoren@kernel.org, bjorn@rivosinc.com,
        heiko@sntech.de, ardb@kernel.org, phoebe.chen@sifive.com,
        hongrong.hsu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 06/12] RISC-V: crypto: add accelerated
 AES-CBC/CTR/ECB/XTS implementations
Message-ID: <20231109071623.GB1245@sol.localdomain>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
 <20231025183644.8735-7-jerry.shih@sifive.com>
 <20231102051639.GF1498@sol.localdomain>
 <39126F19-8FEB-4E18-B61D-4494B59C43A1@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39126F19-8FEB-4E18-B61D-4494B59C43A1@sifive.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 04:53:13PM +0800, Jerry Shih wrote:
> On Nov 2, 2023, at 13:16, Eric Biggers <ebiggers@kernel.org> wrote:
> > On Thu, Oct 26, 2023 at 02:36:38AM +0800, Jerry Shih wrote:
> >> +static int ecb_encrypt(struct skcipher_request *req)
> >> +{
> >> +	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
> >> +	const struct riscv64_aes_ctx *ctx = crypto_skcipher_ctx(tfm);
> >> +	struct skcipher_walk walk;
> >> +	unsigned int nbytes;
> >> +	int err;
> >> +
> >> +	/* If we have error here, the `nbytes` will be zero. */
> >> +	err = skcipher_walk_virt(&walk, req, false);
> >> +	while ((nbytes = walk.nbytes)) {
> >> +		kernel_vector_begin();
> >> +		rv64i_zvkned_ecb_encrypt(walk.src.virt.addr, walk.dst.virt.addr,
> >> +					 nbytes & AES_BLOCK_VALID_SIZE_MASK,
> >> +					 &ctx->key);
> >> +		kernel_vector_end();
> >> +		err = skcipher_walk_done(
> >> +			&walk, nbytes & AES_BLOCK_REMAINING_SIZE_MASK);
> >> +	}
> >> +
> >> +	return err;
> >> +}
> > 
> > There's no fallback for !crypto_simd_usable() here.  I really like it this way.
> > However, for it to work (for skciphers and aeads), RISC-V needs to allow the
> > vector registers to be used in softirq context.  Is that already the case?
> 
> The kernel-mode-vector could be enabled in softirq, but we don't have nesting
> vector contexts. Will we have the case that kernel needs to jump to softirq for
> encryptions during the regular crypto function? If yes, we need to have fallbacks
> for all algorithms.

Are you asking what happens if a softirq is taken while the CPU is between
kernel_vector_begin() and kernel_vector_end()?  I think that needs to be
prevented by making kernel_vector_begin() and kernel_vector_end() disable and
re-enable softirqs, like what kernel_neon_begin() and kernel_neon_end() do on
arm64.  Refer to commit 13150149aa6ded which implemented that behavior on arm64.

- Eric
