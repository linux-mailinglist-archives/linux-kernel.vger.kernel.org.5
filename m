Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7407D7BC2FA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 01:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjJFXeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 19:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjJFXeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:34:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77452CF;
        Fri,  6 Oct 2023 16:34:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C40C433C8;
        Fri,  6 Oct 2023 23:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696635241;
        bh=hWtzHeFz+j3k+UkSoG0IJSUL0xQ6MFBnVQ7QnbQPsEM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oqEr4Y6+3yE/aQo7ozhua1ob6MO/9ZGu0ymzlBCE6CvSgxnII+/yR+k5S8B85wyrI
         mZRCEpkrfja91aVinXiFgW9RZcxnnPgqbtN/0zdKNekqhlt6v5HDTXWFqwxDzcY91E
         phr25WKzcfFBApqN7UwjGOPuwyyudxDG+o9uI7H3VOs5G+b8hqXjxagu8O49BKiDlx
         8RT+NNYnbIohXMpwo5a5Ragr3WKGts6BFG89PFf8Yvr/+4vodCrzHaSw9ptEpk7kt9
         Szyh/n5C+wJ/sjDEc3apFOi628jPQK1PajXowOVuHyMZk+r1asjEzvfemni25jqe57
         u73J5WUMVWiRw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50437c618b4so3286957e87.2;
        Fri, 06 Oct 2023 16:34:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YyEqH21ZqPXGnt5HCc5jI3BhcEBIxDXwLwRPzsxFuqyL9iCKSbP
        5Zr0KZh1il4W9rjJHW6yO4QhL1JAaw1z6KPXqs8=
X-Google-Smtp-Source: AGHT+IEzG0i5owuGW6XiwVBZg9sVceEwAvrO7irUhWwHObiL01Y/q8wm4gtly2tshgVUOUQo6SHq7KPJl3lg9GZ0vTs=
X-Received: by 2002:a19:f610:0:b0:500:ac76:4a61 with SMTP id
 x16-20020a19f610000000b00500ac764a61mr7207431lfe.65.1696635239905; Fri, 06
 Oct 2023 16:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230711153743.1970625-1-heiko@sntech.de> <20230914001144.GA924@sol.localdomain>
 <ZQJdnCwf99Glggin@ghost> <3A0F6A71-C521-44A5-A56C-076AF3E13897@gmail.com>
 <DD3113B1-AB9F-4D6D-BD6E-8F75A83DA45D@sifive.com> <20231006194741.GA68531@google.com>
 <7BC51820-61BC-422C-A2F7-B68CE679972C@gmail.com>
In-Reply-To: <7BC51820-61BC-422C-A2F7-B68CE679972C@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 7 Oct 2023 01:33:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF-m3pYs6u=Xhf5F-Kgmuu8Az1Q6WP86vWqFnVphVSmkg@mail.gmail.com>
Message-ID: <CAMj1kXF-m3pYs6u=Xhf5F-Kgmuu8Az1Q6WP86vWqFnVphVSmkg@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] RISC-V: support some cryptography accelerations
To:     20231006194741.GA68531@google.com
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2023 at 23:01, He-Jie Shih <bignose1007@gmail.com> wrote:
>
> On Oct 7, 2023, at 03:47, Eric Biggers <ebiggers@kernel.org> wrote:
> > On Fri, Sep 15, 2023 at 11:21:28AM +0800, Jerry Shih wrote:
> >> On Sep 15, 2023, at 09:48, He-Jie Shih <bignose1007@gmail.com> wrote:
> >> The OpenSSL PR is at [1].
> >> And we are from SiFive.
> >>
> >> -Jerry
> >>
> >> [1]
> >> https://github.com/openssl/openssl/pull/21923
> >
> > Hi Jerry, I'm wondering if you have an update on this?  Do you need any help?
>
> We have specialized aes-cbc/ecb/ctr patch locally and pass the `testmgr` test
> cases. But the test patterns in `testmgr` are quite simple, I think it doesn't test the
> corner case(e.g. aes-xts with tail element).
>

There should be test cases for that.

> For aes-xts, I'm trying to update the implementation from OpenSSL. The design
> philosophy is different between OpenSSL and linux. In linux crypto, the data will
> be split into `scatterlist`. I need to preserve the aes-xts's iv for each scatterlist
> entry call.

Yes, this applies to all block ciphers that take an IV.

> And I'm thinking about how to handle the tail data in a simple way.

The RISC-V vector ISA is quite advanced, so there may be a better
trick using predicates etc but otherwise, I suppose you could reuse
the same trick that other asm implementations use, which is to use
unaligned loads and stores for the final blocks, and to use a vector
permute with a permute table to shift the bytes in the registers. But
this is not performance critical, given that existing in-kernel users
use sector or page size inputs only.

> By the way, the `xts(aes)` implementation for arm and x86 are using
> `cra_blocksize= AES_BLOCK_SIZE`. I don't know why we need to handle the tail
> element. I think we will hit `EINVAL` error in `skcipher_walk_next()` if the data size
> it not be a multiple of block size.
>

No, both XTS and CBC-CTS permit inputs that are not a multiple of the
block size, and will use some form of ciphertext stealing for the
final tail. There is a generic CTS template that wraps CBC but
combining them in the same way (e.g., using vector permute) will speed
up things substantially. *However*, I'm not sure how relevant CBC-CTS
is in the kernel, given that only fscrypt uses it IIRC but actually
prefers something else so for new systems perhaps you shouldn't
bother.

> Overall, we will have
> 1) aes cipher
> 2) aes with cbc/ecb/ctr/xts mode
> 3) sha256/512 for `vlen>=128` platform
> 4) sm3 for `vlen>=128` platform
> 5) sm4
> 6) ghash
> 7) `chacha20` stream cipher
>
> The vector crypto pr in OpenSSL is under reviewing, we are still updating the
> perl file into linux.
>
> The most complicated `gcm(aes)` mode will be in our next plan.
>
> > I'm also wondering about riscv.pm and the choice of generating the crypto
> > instructions from .words instead of using the assembler.  It makes it
> > significantly harder to review the code, IMO.  Can we depend on assembler
> > support for these instructions, or is that just not ready yet?
>
> I have asked the same question before[1]. The reason is that Openssl could use
> very old compiler for compiling. Thus, the assembler might not know the standard
> rvv 1.0[2] and other vector crypto[3] instructions. That's why we use opcode for all
> vector instructions. IMO, I would prefer to use opcode for `vector crypto` only. The
> gcc-12 and clang-14 are already supporting rvv 1.0. Actually, I just read the `perl`
> file instead of the actually generated opcode for OpenSSL pr reviewing. And it's
> not hard to read the perl code.
>

I understand the desire to reuse code, and OpenSSL already relies on
so-called perlasm for this, but I think this is not a great choice,
and I actually think this was a mistake for RISC-V. OpenSSL relies on
perlasm for things like emittting different function pro-/epilogues
depending on the calling convention (SysV versus MS on x86_64, for
instance), but RISC-V does not have that much variety, and already
supports the insn_r / insn_i pseudo instructions to emit arbitrary
opcodes while still supporting named registers as usual. [Maybe my
experience does not quite extrapolate to the vector ISA, but I managed
to implement scalar AES [0] using the insn_r and insn_i pseudo
instructions (which are generally provided by the assembler but Linux
has fallback CPP macros for them as well), and this results on much
more maintainable code IMO.[

We are using some of the OpenSSL perlasm in the kernel already (and
some of it was introduced by me) but I don't think we should blindly
reuse all of the RISC-V code if  some of it can straight-forwardly be
written as normal .S files.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=riscv-scalar-aes
