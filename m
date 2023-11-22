Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AC77F54ED
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjKVXnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjKVXnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:43:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8A8110
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:43:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBF1C433C7;
        Wed, 22 Nov 2023 23:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700696581;
        bh=yqmUff5XVNXC8Wm4UHYxS2M91ZTuDaavXhzkyaFXDHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vy6pHKFgXdGMNxEaNyTc/Fb0b9Wc4RbMbVPP8QkEeEFy9LcAdjXuz9Jz8xC1okuvS
         vIsnOBHy1c4D7UbGqHn30kJMuuqJMXPF65DEpbyht78HQ30AIHNICfTN7oETcR8zaX
         nUf/h0QJQ02TChlBJvmVMQ9XhCDsWYx38/xCh3vjbgdBMPuVONfjIJJh/R4xJ2zlyK
         iNQ9jjRe8GmbKad8YxuFsgbg+x9lsHlTYHacg/JCXxVmI+wKB7hAqke53/KeUfQ1fm
         5LePD1tMSgTZLKucrSNDDCrHGns8pAlvAbYPMaFvphP9tHzsX7Sl/0jDp7K0NbkkIy
         bAKb2TkSA5KUQ==
Date:   Wed, 22 Nov 2023 15:42:59 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jerry Shih <jerry.shih@sifive.com>
Cc:     Charlie Jenkins <charlie@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v4 00/12] RISC-V: support some cryptography accelerations
Message-ID: <20231122234259.GB1541@sol.localdomain>
References: <20230711153743.1970625-1-heiko@sntech.de>
 <20230914001144.GA924@sol.localdomain>
 <ZQJdnCwf99Glggin@ghost>
 <3A0F6A71-C521-44A5-A56C-076AF3E13897@gmail.com>
 <DD3113B1-AB9F-4D6D-BD6E-8F75A83DA45D@sifive.com>
 <20231006194741.GA68531@google.com>
 <AB98E114-A8DE-492E-B078-7394EE4FA83E@sifive.com>
 <20231102040333.GC1498@sol.localdomain>
 <20231121235109.GE2172@sol.localdomain>
 <3416A95B-8687-44F6-9F77-D30AD6516094@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3416A95B-8687-44F6-9F77-D30AD6516094@sifive.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 03:58:17PM +0800, Jerry Shih wrote:
> On Nov 22, 2023, at 07:51, Eric Biggers <ebiggers@kernel.org> wrote:
> > On Wed, Nov 01, 2023 at 09:03:33PM -0700, Eric Biggers wrote:
> >> 
> >> It would be nice to use a real assembler, so that people won't have to worry
> >> about potential mistakes or inconsistencies in the perl-based "assembler".  Also
> >> keep in mind that if we allow people to compile this code without the real
> >> assembler support from the beginning, it might end up staying that way for quite
> >> a while in order to avoid breaking the build for people.
> >> 
> >> Ultimately it's up to you though; I think that you and others who have been
> >> working on RISC-V crypto can make the best decision about what to do here.  I
> >> also don't want this patchset to be delayed waiting for other projects, so maybe
> >> that indeed means the perl-based "assembler" needs to be used for now.
> > 
> > Just wanted to bump up this discussion again.  In binutils, the vector crypto
> > v1.0.0 support was released 4 months ago in 2.41.  See the NEWS file at
> > https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=blob_plain;f=binutils/NEWS;hb=refs/heads/binutils-2_41-branch
> > 
> >    * The RISC-V port now supports the following new standard extensions:
> >      - Zicond (conditional zero instructions)
> >      - Zfa (additional floating-point instructions)
> >      - Zvbb, Zvbc, Zvkg, Zvkned, Zvknh[ab], Zvksed, Zvksh, Zvkn, Zvknc, Zvkng,
> >        Zvks, Zvksc, Zvkg, Zvkt (vector crypto instructions)
> > 
> > That's every extension listed in the vector crypto v1.0.0 specification
> > (https://github.com/riscv/riscv-crypto/releases/download/v1.0.0/riscv-crypto-spec-vector.pdf).
> 
> It doesn't fit all v1.0 spec.
> The `Zvkb` is missed in binutils. It's the subset of `Zvbb`. We needs some extra
> works if user just try to use `Zvkb`.
> https://github.com/riscv/riscv-crypto/blob/main/doc/vector/riscv-crypto-vector-zvkb.adoc
> Some crypto algorithms are already checking for `Zvkb` instead of `Zvbb`.

Yeah, that's unfortunate that Zvkb got missed in binutils.  However, since all
Zvkb instructions are part of Zvbb, which is supported, assembling Zvkb
instructions should still work --- right?

> > LLVM still has the vector crypto extensions marked as "experimental" extensions.
> > However, there is an open pull request to mark them non-experimental:
> > https://github.com/llvm/llvm-project/pull/69000
> > 
> > Could we just go ahead and remove riscv.pm, develop with binutils for now, and
> > prioritize getting the LLVM support finished?
> 
> Yes, we could.
> But we need to handle the extensions checking for toolchains like:
> https://github.com/torvalds/linux/commit/b6fcdb191e36f82336f9b5e126d51c02e7323480
> I could do that, but I think I need some times to test the builds. And it will introduce
> more dependency patch which is not related to actual crypto algorithms and the
> gluing code in kernel. I will send another patch for toolchain part after the v2 patch.
> And I am working for v2 patch with your new review comments. The v2 will still
> use `perlasm`.

Note that perlasm (.pl) vs assembly (.S), and ".inst" vs real assembler
instructions, are actually separate concerns.  We could use real assembler
instructions while still using perlasm.  Or we could use assembly while still
using macros that generate the instructions as .inst.

My preference is indeed both: assembly (.S) with real assembler instructions.
That would keep things more straightforward.

We do not necessarily need to do both before merging the code, though.  It will
be beneficial to get this code merged sooner rather than later, so that other
people can work on improving it.

I would prioritize the change to use real assembler instructions.  I do think
it's worth thinking about getting that change in from the beginning, so that the
toolchain prerequisites are properly in place from the beginning and people can
properly account for them and prioritize the toolchain work as needed.

- Eric
