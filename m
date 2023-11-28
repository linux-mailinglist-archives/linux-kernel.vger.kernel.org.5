Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AAD7FC525
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345483AbjK1UTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK1UTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:19:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE7A12C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:19:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C04C433C7;
        Tue, 28 Nov 2023 20:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701202770;
        bh=vKcCjyLVw3bjH2nAbGvTRYUZk8vCUBzOv+eNIVNniKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EwPP8Zh/wIMSUwPd+LCbXfoffVFwUTvypXR+81vo/8CGQlhdfbd5t/1wKeP4XCEou
         DaF5P2lGIOhuJxY34ENDBKvIuTFqmdYH027AlRVFasP74O9azyDo89rob4Bz6Dv8/h
         jyhHu6kwcyz3q2YI7aQh5dTv2/46XiKrmR3VbRJgHVvaQD4KRkREQnyQcurVtrYgtE
         h8U5NgrZGmfBFSFEHlgemFt94lS507L/Hz4DIsQTk2VF5GCSXOfAQ5siE+rhX1HQol
         6gHNd4f9GRCumC/FHpxKp49dTEKQT+7m0vqoaHdszKj5JjKGDrQ/9dJ7J6mzdxKw5/
         1uLkoj9C9qycA==
Date:   Tue, 28 Nov 2023 12:19:28 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph =?iso-8859-1?Q?M=FCllner?= <christoph.muellner@vrull.eu>
Cc:     Jerry Shih <jerry.shih@sifive.com>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v4 00/12] RISC-V: support some cryptography accelerations
Message-ID: <20231128201928.GF1148@sol.localdomain>
References: <ZQJdnCwf99Glggin@ghost>
 <3A0F6A71-C521-44A5-A56C-076AF3E13897@gmail.com>
 <DD3113B1-AB9F-4D6D-BD6E-8F75A83DA45D@sifive.com>
 <20231006194741.GA68531@google.com>
 <AB98E114-A8DE-492E-B078-7394EE4FA83E@sifive.com>
 <20231102040333.GC1498@sol.localdomain>
 <20231121235109.GE2172@sol.localdomain>
 <3416A95B-8687-44F6-9F77-D30AD6516094@sifive.com>
 <20231122234259.GB1541@sol.localdomain>
 <CAEg0e7iPGnaMKR9bT01-bGOUUToUG0o3Q7NBS_m8CbZdYWeBXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEg0e7iPGnaMKR9bT01-bGOUUToUG0o3Q7NBS_m8CbZdYWeBXA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 01:36:34AM +0100, Christoph Müllner wrote:
> On Thu, Nov 23, 2023 at 12:43 AM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Wed, Nov 22, 2023 at 03:58:17PM +0800, Jerry Shih wrote:
> > > On Nov 22, 2023, at 07:51, Eric Biggers <ebiggers@kernel.org> wrote:
> > > > On Wed, Nov 01, 2023 at 09:03:33PM -0700, Eric Biggers wrote:
> > > >>
> > > >> It would be nice to use a real assembler, so that people won't have to worry
> > > >> about potential mistakes or inconsistencies in the perl-based "assembler".  Also
> > > >> keep in mind that if we allow people to compile this code without the real
> > > >> assembler support from the beginning, it might end up staying that way for quite
> > > >> a while in order to avoid breaking the build for people.
> > > >>
> > > >> Ultimately it's up to you though; I think that you and others who have been
> > > >> working on RISC-V crypto can make the best decision about what to do here.  I
> > > >> also don't want this patchset to be delayed waiting for other projects, so maybe
> > > >> that indeed means the perl-based "assembler" needs to be used for now.
> > > >
> > > > Just wanted to bump up this discussion again.  In binutils, the vector crypto
> > > > v1.0.0 support was released 4 months ago in 2.41.  See the NEWS file at
> > > > https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=blob_plain;f=binutils/NEWS;hb=refs/heads/binutils-2_41-branch
> > > >
> > > >    * The RISC-V port now supports the following new standard extensions:
> > > >      - Zicond (conditional zero instructions)
> > > >      - Zfa (additional floating-point instructions)
> > > >      - Zvbb, Zvbc, Zvkg, Zvkned, Zvknh[ab], Zvksed, Zvksh, Zvkn, Zvknc, Zvkng,
> > > >        Zvks, Zvksc, Zvkg, Zvkt (vector crypto instructions)
> > > >
> > > > That's every extension listed in the vector crypto v1.0.0 specification
> > > > (https://github.com/riscv/riscv-crypto/releases/download/v1.0.0/riscv-crypto-spec-vector.pdf).
> > >
> > > It doesn't fit all v1.0 spec.
> > > The `Zvkb` is missed in binutils. It's the subset of `Zvbb`. We needs some extra
> > > works if user just try to use `Zvkb`.
> > > https://github.com/riscv/riscv-crypto/blob/main/doc/vector/riscv-crypto-vector-zvkb.adoc
> > > Some crypto algorithms are already checking for `Zvkb` instead of `Zvbb`.
> >
> > Yeah, that's unfortunate that Zvkb got missed in binutils.  However, since all
> > Zvkb instructions are part of Zvbb, which is supported, assembling Zvkb
> > instructions should still work --- right?
> 
> Not forgotten, but the Zvkb extension did not exist when the patchset
> was merged.
> RISC-V extension support is typically merged when specifications are "frozen".
> This means a high bar for changes, but they are possible until the
> spec is ratified.
> Often nothing is changed until ratification, but here Zvkb has been
> (re-)introduced.
> 
> I was not aware of this untils I read this email, so I just wrote a
> patch that fills the gap:
>   https://sourceware.org/pipermail/binutils/2023-November/130762.html
> 

Thanks Christoph!  That binutils patch looks good to me.

- Eric
