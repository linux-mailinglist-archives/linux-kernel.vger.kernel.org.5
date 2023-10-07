Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E5D7BCA59
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 00:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344206AbjJGWQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 18:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344151AbjJGWQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 18:16:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E14D9F;
        Sat,  7 Oct 2023 15:16:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFD9C433C7;
        Sat,  7 Oct 2023 22:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696716969;
        bh=jxeYH0Vp6GKZ73eOXD963bZzBieH2C5SDVp050HzZ60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j/xlcuRxhAtsMxnJF5JD8IFMDXb548B+dLuG4Gu43b+0o6HqV/Efv4JhtbjBUkZD+
         T5slG3ZwFc+vnbZj7lZfWgl26mIfVnFXDN2iNnFokUZAXLJGp0BtMfq8MMfInqEbur
         3ZeNjNILTAuPfDX4VlLdPw4JEyIyvuiy2kXM4uDa6e5Ls0P3snLsDZvNWjm4X8LOmP
         EF0KsAyFJnUMc/dEWlB0ZFakwzfAjscVsVPq6gBhc79gsnUebWWbA1es9OZkHfVJL+
         a4vhq1AbUQ38bFD/91YRyqZJAlqtaJwI2vsFTN8xDP6xERbY+Z0k2gd5t64Ny10w28
         4hoOehSjGIjGA==
Date:   Sat, 7 Oct 2023 15:16:07 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     He-Jie Shih <bignose1007@gmail.com>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v4 00/12] RISC-V: support some cryptography accelerations
Message-ID: <20231007221607.GC174883@sol.localdomain>
References: <20230711153743.1970625-1-heiko@sntech.de>
 <20230914001144.GA924@sol.localdomain>
 <ZQJdnCwf99Glggin@ghost>
 <3A0F6A71-C521-44A5-A56C-076AF3E13897@gmail.com>
 <DD3113B1-AB9F-4D6D-BD6E-8F75A83DA45D@sifive.com>
 <20231006194741.GA68531@google.com>
 <7BC51820-61BC-422C-A2F7-B68CE679972C@gmail.com>
 <CAMj1kXF-m3pYs6u=Xhf5F-Kgmuu8Az1Q6WP86vWqFnVphVSmkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF-m3pYs6u=Xhf5F-Kgmuu8Az1Q6WP86vWqFnVphVSmkg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 01:33:48AM +0200, Ard Biesheuvel wrote:
> On Fri, 6 Oct 2023 at 23:01, He-Jie Shih <bignose1007@gmail.com> wrote:
> >
> > On Oct 7, 2023, at 03:47, Eric Biggers <ebiggers@kernel.org> wrote:
> > > On Fri, Sep 15, 2023 at 11:21:28AM +0800, Jerry Shih wrote:
> > >> On Sep 15, 2023, at 09:48, He-Jie Shih <bignose1007@gmail.com> wrote:
> > >> The OpenSSL PR is at [1].
> > >> And we are from SiFive.
> > >>
> > >> -Jerry
> > >>
> > >> [1]
> > >> https://github.com/openssl/openssl/pull/21923
> > >
> > > Hi Jerry, I'm wondering if you have an update on this?  Do you need any help?
> >
> > We have specialized aes-cbc/ecb/ctr patch locally and pass the `testmgr` test
> > cases. But the test patterns in `testmgr` are quite simple, I think it doesn't test the
> > corner case(e.g. aes-xts with tail element).
> >
> 
> There should be test cases for that.

Yes, non-block-aligned AES-XTS test vectors should be added to crypto/testmgr.h.
Though, that case should be already covered by the randomized tests enabled by
CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y, which I very strongly recommend enabling
during development.

> 
> > For aes-xts, I'm trying to update the implementation from OpenSSL. The design
> > philosophy is different between OpenSSL and linux. In linux crypto, the data will
> > be split into `scatterlist`. I need to preserve the aes-xts's iv for each scatterlist
> > entry call.
> 
> Yes, this applies to all block ciphers that take an IV.
> 
> > And I'm thinking about how to handle the tail data in a simple way.
> 
> The RISC-V vector ISA is quite advanced, so there may be a better
> trick using predicates etc but otherwise, I suppose you could reuse
> the same trick that other asm implementations use, which is to use
> unaligned loads and stores for the final blocks, and to use a vector
> permute with a permute table to shift the bytes in the registers. But
> this is not performance critical, given that existing in-kernel users
> use sector or page size inputs only.
> 
> > By the way, the `xts(aes)` implementation for arm and x86 are using
> > `cra_blocksize= AES_BLOCK_SIZE`. I don't know why we need to handle the tail
> > element. I think we will hit `EINVAL` error in `skcipher_walk_next()` if the data size
> > it not be a multiple of block size.
> >
> 
> No, both XTS and CBC-CTS permit inputs that are not a multiple of the
> block size, and will use some form of ciphertext stealing for the
> final tail. There is a generic CTS template that wraps CBC but
> combining them in the same way (e.g., using vector permute) will speed
> up things substantially. *However*, I'm not sure how relevant CBC-CTS
> is in the kernel, given that only fscrypt uses it IIRC but actually
> prefers something else so for new systems perhaps you shouldn't
> bother.
> 
> > Overall, we will have
> > 1) aes cipher
> > 2) aes with cbc/ecb/ctr/xts mode
> > 3) sha256/512 for `vlen>=128` platform
> > 4) sm3 for `vlen>=128` platform
> > 5) sm4
> > 6) ghash
> > 7) `chacha20` stream cipher
> >
> > The vector crypto pr in OpenSSL is under reviewing, we are still updating the
> > perl file into linux.
> >
> > The most complicated `gcm(aes)` mode will be in our next plan.
> >
> > > I'm also wondering about riscv.pm and the choice of generating the crypto
> > > instructions from .words instead of using the assembler.  It makes it
> > > significantly harder to review the code, IMO.  Can we depend on assembler
> > > support for these instructions, or is that just not ready yet?
> >
> > I have asked the same question before[1]. The reason is that Openssl could use
> > very old compiler for compiling. Thus, the assembler might not know the standard
> > rvv 1.0[2] and other vector crypto[3] instructions. That's why we use opcode for all
> > vector instructions. IMO, I would prefer to use opcode for `vector crypto` only. The
> > gcc-12 and clang-14 are already supporting rvv 1.0. Actually, I just read the `perl`
> > file instead of the actually generated opcode for OpenSSL pr reviewing. And it's
> > not hard to read the perl code.
> >
> 
> I understand the desire to reuse code, and OpenSSL already relies on
> so-called perlasm for this, but I think this is not a great choice,
> and I actually think this was a mistake for RISC-V. OpenSSL relies on
> perlasm for things like emittting different function pro-/epilogues
> depending on the calling convention (SysV versus MS on x86_64, for
> instance), but RISC-V does not have that much variety, and already
> supports the insn_r / insn_i pseudo instructions to emit arbitrary
> opcodes while still supporting named registers as usual. [Maybe my
> experience does not quite extrapolate to the vector ISA, but I managed
> to implement scalar AES [0] using the insn_r and insn_i pseudo
> instructions (which are generally provided by the assembler but Linux
> has fallback CPP macros for them as well), and this results on much
> more maintainable code IMO.[
> 
> We are using some of the OpenSSL perlasm in the kernel already (and
> some of it was introduced by me) but I don't think we should blindly
> reuse all of the RISC-V code if  some of it can straight-forwardly be
> written as normal .S files.
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=riscv-scalar-aes

I'm not a huge fan of perlasm either.  Normal .S files can be much easier to
understand, and they do still support basic features like macros.  (Of course,
this only works if the .S file is the real source code.  If the real source code
is the perlasm, dumping it to a .S file doesn't make it more readable.)

Ultimately, it needs to decided on an algorithm-by-algorithm basis whether it
makes sense to use the .pl file directly from OpenSSL or write a normal .S file.
Sharing code can save time, but it can also waste time if/when things don't
match up and need to be changed for the kernel anyway.  If you look at the other
architectures, sharing the OpenSSL .pl file is most common for Poly1305 and
SHA-2.  It's rarer for AES modes.

In any case, regardless of .pl or .S, it would be nice to rely on the assembler
for the mapping from readable instruction to 32-bit words.  Yes, I understand
that the algorithm code reads mostly the some either way, but it introduces
nonstandard notation (e.g. due to having to avoid the period character) and a
possibility for error.  It's not the 1940s anymore; we should be able to have an
assembler.  Why not make OpenSSL and Linux only enable this code when the
assembler supports it?  Note that Linux already does this for many of the x86
extensions, so there is precedent for this; see arch/x86/Kconfig.assembler.

- Eric 
