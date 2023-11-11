Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163D07E8A7A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 12:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjKKLIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 06:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjKKLIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 06:08:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EE53AA8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 03:08:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBB9C433CB;
        Sat, 11 Nov 2023 11:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699700924;
        bh=4+LCQxi4lcuWpBaGMskF95LLHsU3UkyAxY2T1MywU04=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=clkbeG9q9sb2fwcbWoyoubJxsdJWMxIyp7Tbr7gfLrqVwHjBqTM7wNE4RVJHKjcVV
         XH0jKeTYnPbPy9NL/Hlsp5PbGQ9bTwKiilREeEsed3J496rIRVKpLc82X8UUr0tz8x
         g7ToGxDWR7jdOEXjLo8pPG9MH3Xvxta2AjLZ/qSdFpWa7EqATaRx3GB99kKl1Xzbwy
         K4OUiB7S2FOiw8hfqpeuiFxf0/mbm6XZAi6Q/TqGGDH+gb5FEVbLVq5oaorcOovZTc
         LOPNmrwqmUU8z/1ITVSpLXtJJR5UCQh3KxD5YJuEt8eup8U0Ev8EfofArIUxBhxHNK
         DoGDxp1bcjZoQ==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so40453311fa.1;
        Sat, 11 Nov 2023 03:08:44 -0800 (PST)
X-Gm-Message-State: AOJu0YyuvL60i6WzYZ6y1WTchYwf8zPngkRLVksmisRQXSn9qvI053su
        qwR8d5OoOra90+TPsQOMQp3Ua2z52iRFumZm2nw=
X-Google-Smtp-Source: AGHT+IEsPJvoBX6VUXhVuSDBLKI8ICH8hwYcv6uwJD08sO4fiU5Og3JL4cUOmsdgJm+IkH5mGmEeqn3siNM5C1jNg+4=
X-Received: by 2002:a2e:22c3:0:b0:2c5:15dc:ba99 with SMTP id
 i186-20020a2e22c3000000b002c515dcba99mr1311935lji.51.1699700922378; Sat, 11
 Nov 2023 03:08:42 -0800 (PST)
MIME-Version: 1.0
References: <20231025183644.8735-1-jerry.shih@sifive.com> <20231025183644.8735-7-jerry.shih@sifive.com>
 <20231102051639.GF1498@sol.localdomain> <39126F19-8FEB-4E18-B61D-4494B59C43A1@sifive.com>
 <20231109071623.GB1245@sol.localdomain> <CABgGipXnGVB770ZA=60rD-6Hi5Fv_wh3tST+G+VFbTmMYzz0Mw@mail.gmail.com>
 <20231110054428.GC6572@sol.localdomain>
In-Reply-To: <20231110054428.GC6572@sol.localdomain>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 11 Nov 2023 21:08:31 +1000
X-Gmail-Original-Message-ID: <CAMj1kXHGWmdnOChbmiYhEib2Dgun0k8PVW5v_kLb-6c1BEhS=Q@mail.gmail.com>
Message-ID: <CAMj1kXHGWmdnOChbmiYhEib2Dgun0k8PVW5v_kLb-6c1BEhS=Q@mail.gmail.com>
Subject: Re: [PATCH 06/12] RISC-V: crypto: add accelerated AES-CBC/CTR/ECB/XTS implementations
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Andy Chiu <andy.chiu@sifive.com>,
        Jerry Shih <jerry.shih@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        Albert Ou <aou@eecs.berkeley.edu>, herbert@gondor.apana.org.au,
        davem@davemloft.net, greentime.hu@sifive.com,
        conor.dooley@microchip.com, guoren@kernel.org, bjorn@rivosinc.com,
        heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2023 at 15:44, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Fri, Nov 10, 2023 at 12:58:12PM +0800, Andy Chiu wrote:
> > Hi Eric,
> >
> > On Thu, Nov 9, 2023 at 3:16=E2=80=AFPM Eric Biggers <ebiggers@kernel.or=
g> wrote:
> > >
> > > On Tue, Nov 07, 2023 at 04:53:13PM +0800, Jerry Shih wrote:
> > > > On Nov 2, 2023, at 13:16, Eric Biggers <ebiggers@kernel.org> wrote:
> > > > > On Thu, Oct 26, 2023 at 02:36:38AM +0800, Jerry Shih wrote:
> > > > >> +static int ecb_encrypt(struct skcipher_request *req)
> > > > >> +{
> > > > >> +  struct crypto_skcipher *tfm =3D crypto_skcipher_reqtfm(req);
> > > > >> +  const struct riscv64_aes_ctx *ctx =3D crypto_skcipher_ctx(tfm=
);
> > > > >> +  struct skcipher_walk walk;
> > > > >> +  unsigned int nbytes;
> > > > >> +  int err;
> > > > >> +
> > > > >> +  /* If we have error here, the `nbytes` will be zero. */
> > > > >> +  err =3D skcipher_walk_virt(&walk, req, false);
> > > > >> +  while ((nbytes =3D walk.nbytes)) {
> > > > >> +          kernel_vector_begin();
> > > > >> +          rv64i_zvkned_ecb_encrypt(walk.src.virt.addr, walk.dst=
.virt.addr,
> > > > >> +                                   nbytes & AES_BLOCK_VALID_SIZ=
E_MASK,
> > > > >> +                                   &ctx->key);
> > > > >> +          kernel_vector_end();
> > > > >> +          err =3D skcipher_walk_done(
> > > > >> +                  &walk, nbytes & AES_BLOCK_REMAINING_SIZE_MASK=
);
> > > > >> +  }
> > > > >> +
> > > > >> +  return err;
> > > > >> +}
> > > > >
> > > > > There's no fallback for !crypto_simd_usable() here.  I really lik=
e it this way.
> > > > > However, for it to work (for skciphers and aeads), RISC-V needs t=
o allow the
> > > > > vector registers to be used in softirq context.  Is that already =
the case?
> > > >
> > > > The kernel-mode-vector could be enabled in softirq, but we don't ha=
ve nesting
> > > > vector contexts. Will we have the case that kernel needs to jump to=
 softirq for
> > > > encryptions during the regular crypto function? If yes, we need to =
have fallbacks
> > > > for all algorithms.
> > >
> > > Are you asking what happens if a softirq is taken while the CPU is be=
tween
> > > kernel_vector_begin() and kernel_vector_end()?  I think that needs to=
 be
> > > prevented by making kernel_vector_begin() and kernel_vector_end() dis=
able and
> > > re-enable softirqs, like what kernel_neon_begin() and kernel_neon_end=
() do on
> > > arm64.  Refer to commit 13150149aa6ded which implemented that behavio=
r on arm64.
> >
> > Yes, if making Vector available to softirq context is a must, then it
> > is reasonable to call local_bh_disable() in kernel_vector_begin().
> > However, softirq would not be the only user for Vector and disabling
> > it may cause extra latencies. Meanwhile, simply disabling bh in
> > kernel_vector_begin() will conflict with the patch[1] that takes an
> > approach to run Preemptible Vector. Though it is not clear yet on
> > whether we should run Vector without turning off preemption, I have
> > tested running preemptible Vector and observed some latency
> > improvements without sacrificing throughput. We will have a discussion
> > on LPC2023[2] and it'd be great if you could join or continue to
> > discuss it here.
> >
> > Approaches can be done such as nesting, if running Vector in softirq
> > is required. Since it requires extra save/restore on nesting, I think
> > we should run some tests to get more performance (latency/throughput)
> > figure let the result decide the final direction. For example, we
> > could run Vector in either nesting with preempt-V and  non-nesting
> > without preempt-V and compare the following performance catachristics:
> >  - System-wide latency impact
> >  - Latency and throughput of softirq-Vector itself
>
> The skcipher and aead APIs do indeed need to work in softirq context.
>
> It's possible to use a fallback, either by falling back to scalar instruc=
tions
> or by punting the encryption/decryption operation to a workqueue using
> crypto/simd.c.  However, both approaches have some significant disadvanta=
ges.
> It was nice that the need for them on arm64 was eliminated by commit
> 13150149aa6ded.  Note that it's possible to yield the vector unit occasio=
nally,
> to keep preemption and softirqs from being disabled for too long.
>

It is also quite feasible to start out with an implementation of
kernel_vector_begin() that preserves all vector registers eagerly in a
special per-CPU allocation if the call is made in softirq context (and
BUG when called in hardirq/NMI context). This was my initial approach
on arm64 too.

Assuming that RiSC-V systems with vector units are not flooding the
market just yet, this gives you some time to study the issue without
the need to implement non-vector fallback crypto algorithms
everywhere.
