Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562C47E8BFC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 18:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjKKRw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 12:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKKRw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 12:52:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF71C3A82
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 09:52:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEABDC433C7;
        Sat, 11 Nov 2023 17:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699725145;
        bh=Orr1lVXJAQNOiV1zw2p7Bmk4rVn6JX2v4Z6LPYrVrlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hQ1cu9soq/zEhp4wwheNh28rvVac5cdJuUhrhjg1ieBqtxHdDcQGzSeh+l0jLEuS1
         pMbUagz8aIk6uakbvaLu0nr8d/5tXNbJPEu1ojHzqO2DsdFkS1vUs0bVEdwIEJ+IGK
         LlD5OlQWylD6m5ysrBy91/014CtokHp+hrLPZc5kqkp8/jkOuBea80D9ms7mhGCPwf
         ZrDxaVKE9OoOzlRjtM+kuGPgk6EwV/V9rvIlK85/A1aYgbuVmjzh+nmW5o/Y8ry4kO
         HxJepwXPUbUzoeF//ymz+RnVJIoCswOX1nGRxOFYHurlneNr1a9Rcu2sxui9HxKkzT
         Qza1qWAJKQDbQ==
Date:   Sat, 11 Nov 2023 09:52:22 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Andy Chiu <andy.chiu@sifive.com>,
        Jerry Shih <jerry.shih@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        Albert Ou <aou@eecs.berkeley.edu>, herbert@gondor.apana.org.au,
        davem@davemloft.net, greentime.hu@sifive.com,
        conor.dooley@microchip.com, guoren@kernel.org, bjorn@rivosinc.com,
        heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH 06/12] RISC-V: crypto: add accelerated
 AES-CBC/CTR/ECB/XTS implementations
Message-ID: <20231111175222.GB998@sol.localdomain>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
 <20231025183644.8735-7-jerry.shih@sifive.com>
 <20231102051639.GF1498@sol.localdomain>
 <39126F19-8FEB-4E18-B61D-4494B59C43A1@sifive.com>
 <20231109071623.GB1245@sol.localdomain>
 <CABgGipXnGVB770ZA=60rD-6Hi5Fv_wh3tST+G+VFbTmMYzz0Mw@mail.gmail.com>
 <20231110054428.GC6572@sol.localdomain>
 <CAMj1kXHGWmdnOChbmiYhEib2Dgun0k8PVW5v_kLb-6c1BEhS=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXHGWmdnOChbmiYhEib2Dgun0k8PVW5v_kLb-6c1BEhS=Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 09:08:31PM +1000, Ard Biesheuvel wrote:
> On Fri, 10 Nov 2023 at 15:44, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Fri, Nov 10, 2023 at 12:58:12PM +0800, Andy Chiu wrote:
> > > Hi Eric,
> > >
> > > On Thu, Nov 9, 2023 at 3:16 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > > >
> > > > On Tue, Nov 07, 2023 at 04:53:13PM +0800, Jerry Shih wrote:
> > > > > On Nov 2, 2023, at 13:16, Eric Biggers <ebiggers@kernel.org> wrote:
> > > > > > On Thu, Oct 26, 2023 at 02:36:38AM +0800, Jerry Shih wrote:
> > > > > >> +static int ecb_encrypt(struct skcipher_request *req)
> > > > > >> +{
> > > > > >> +  struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
> > > > > >> +  const struct riscv64_aes_ctx *ctx = crypto_skcipher_ctx(tfm);
> > > > > >> +  struct skcipher_walk walk;
> > > > > >> +  unsigned int nbytes;
> > > > > >> +  int err;
> > > > > >> +
> > > > > >> +  /* If we have error here, the `nbytes` will be zero. */
> > > > > >> +  err = skcipher_walk_virt(&walk, req, false);
> > > > > >> +  while ((nbytes = walk.nbytes)) {
> > > > > >> +          kernel_vector_begin();
> > > > > >> +          rv64i_zvkned_ecb_encrypt(walk.src.virt.addr, walk.dst.virt.addr,
> > > > > >> +                                   nbytes & AES_BLOCK_VALID_SIZE_MASK,
> > > > > >> +                                   &ctx->key);
> > > > > >> +          kernel_vector_end();
> > > > > >> +          err = skcipher_walk_done(
> > > > > >> +                  &walk, nbytes & AES_BLOCK_REMAINING_SIZE_MASK);
> > > > > >> +  }
> > > > > >> +
> > > > > >> +  return err;
> > > > > >> +}
> > > > > >
> > > > > > There's no fallback for !crypto_simd_usable() here.  I really like it this way.
> > > > > > However, for it to work (for skciphers and aeads), RISC-V needs to allow the
> > > > > > vector registers to be used in softirq context.  Is that already the case?
> > > > >
> > > > > The kernel-mode-vector could be enabled in softirq, but we don't have nesting
> > > > > vector contexts. Will we have the case that kernel needs to jump to softirq for
> > > > > encryptions during the regular crypto function? If yes, we need to have fallbacks
> > > > > for all algorithms.
> > > >
> > > > Are you asking what happens if a softirq is taken while the CPU is between
> > > > kernel_vector_begin() and kernel_vector_end()?  I think that needs to be
> > > > prevented by making kernel_vector_begin() and kernel_vector_end() disable and
> > > > re-enable softirqs, like what kernel_neon_begin() and kernel_neon_end() do on
> > > > arm64.  Refer to commit 13150149aa6ded which implemented that behavior on arm64.
> > >
> > > Yes, if making Vector available to softirq context is a must, then it
> > > is reasonable to call local_bh_disable() in kernel_vector_begin().
> > > However, softirq would not be the only user for Vector and disabling
> > > it may cause extra latencies. Meanwhile, simply disabling bh in
> > > kernel_vector_begin() will conflict with the patch[1] that takes an
> > > approach to run Preemptible Vector. Though it is not clear yet on
> > > whether we should run Vector without turning off preemption, I have
> > > tested running preemptible Vector and observed some latency
> > > improvements without sacrificing throughput. We will have a discussion
> > > on LPC2023[2] and it'd be great if you could join or continue to
> > > discuss it here.
> > >
> > > Approaches can be done such as nesting, if running Vector in softirq
> > > is required. Since it requires extra save/restore on nesting, I think
> > > we should run some tests to get more performance (latency/throughput)
> > > figure let the result decide the final direction. For example, we
> > > could run Vector in either nesting with preempt-V and  non-nesting
> > > without preempt-V and compare the following performance catachristics:
> > >  - System-wide latency impact
> > >  - Latency and throughput of softirq-Vector itself
> >
> > The skcipher and aead APIs do indeed need to work in softirq context.
> >
> > It's possible to use a fallback, either by falling back to scalar instructions
> > or by punting the encryption/decryption operation to a workqueue using
> > crypto/simd.c.  However, both approaches have some significant disadvantages.
> > It was nice that the need for them on arm64 was eliminated by commit
> > 13150149aa6ded.  Note that it's possible to yield the vector unit occasionally,
> > to keep preemption and softirqs from being disabled for too long.
> >
> 
> It is also quite feasible to start out with an implementation of
> kernel_vector_begin() that preserves all vector registers eagerly in a
> special per-CPU allocation if the call is made in softirq context (and
> BUG when called in hardirq/NMI context). This was my initial approach
> on arm64 too.
> 
> Assuming that RiSC-V systems with vector units are not flooding the
> market just yet, this gives you some time to study the issue without
> the need to implement non-vector fallback crypto algorithms
> everywhere.

Yes, that solution would be fine too.

- Eric
