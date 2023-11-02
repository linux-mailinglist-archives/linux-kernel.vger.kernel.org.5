Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715137DEB9C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 05:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348419AbjKBEDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 00:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348398AbjKBEDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 00:03:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B58131;
        Wed,  1 Nov 2023 21:03:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13E5C433C7;
        Thu,  2 Nov 2023 04:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698897815;
        bh=z1CJVAu9bc078uGAGfkWMIJJMJkesFaxTcqS0804NqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HrkO3QQiEApYXLUZUDNMyQcaUcE9RB6RWC/n1riSwundUKbH73zf5u8Kc4P41ntFo
         Jf6rQ/FT8nilsemPzXXxlfBgqcjSxf9uikItJ/61C/vUcNigHM+bAZVH5xzQ1Sb2Qn
         bIrJQfS7+OW0ULduVofgmVHbtXtfOXeBCZR1kNvmuNGsXYw470TXixzzGxRBrUOJFq
         GPEeKzGe8Hkmac7xNUxGK1IHinHBV8uJyKYF63Tsgii0QwwKR5IpaqrDV8J5do5cli
         rfxnQw3fdupMIFcTku+txaWjCuXQMdSEsbhJZqnH8pWyzVM93hj1TCUXsf44/JdNxJ
         qN8Bjq0tU0W8Q==
Date:   Wed, 1 Nov 2023 21:03:33 -0700
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
Message-ID: <20231102040333.GC1498@sol.localdomain>
References: <20230711153743.1970625-1-heiko@sntech.de>
 <20230914001144.GA924@sol.localdomain>
 <ZQJdnCwf99Glggin@ghost>
 <3A0F6A71-C521-44A5-A56C-076AF3E13897@gmail.com>
 <DD3113B1-AB9F-4D6D-BD6E-8F75A83DA45D@sifive.com>
 <20231006194741.GA68531@google.com>
 <AB98E114-A8DE-492E-B078-7394EE4FA83E@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AB98E114-A8DE-492E-B078-7394EE4FA83E@sifive.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerry,

(Just so you know, you still need to fix your email configuration.  Your emails
have a bogus Reply-To header, which makes replies not be sent to you by default.
I had to manually set the "To:" address when replying.)

On Tue, Oct 31, 2023 at 10:17:11AM +0800, Jerry Shih wrote:
> 
> The RISC-V vector crypto OpenSSL pr[1] is merged.
> And we also sent the vector-crypto patch based on Heiko's and OpenSSL
> works.
> Here is the link:
> https://lore.kernel.org/all/20231025183644.8735-1-jerry.shih@sifive.com/
> 
> [1]
> https://github.com/openssl/openssl/pull/21923

Awesome, thanks!

> 
> > I'm also wondering about riscv.pm and the choice of generating the crypto
> > instructions from .words instead of using the assembler.  It makes it
> > significantly harder to review the code, IMO.  Can we depend on assembler
> > support for these instructions, or is that just not ready yet?
> > 
> > - Eric
> 
> There is no public assembler supports the vector-crypto asm mnemonics.
> We should still use `opcode` for vector-crypto instructions. But we might
> use asm for standard rvv parts.
> In order to reuse the codes in OpenSSL as much as possible,  we still use
> the `riscv.pm` for all standard rvv and vector-crypto instructions. If the asm
> mnemonic is still a better approach,  I will `rewrite` all standard rvv parts
> with asm mnemonics in next patch.

Tip-of-tree gcc + binutils seems to support them.  Building some of the sample
code from the riscv-crypto repository:

    $ riscv64-linux-gnu-as --version
    GNU assembler (GNU Binutils) 2.41.50.20231021
    $ riscv64-linux-gnu-gcc --version
    riscv64-linux-gnu-gcc (GCC) 14.0.0 20231021 (experimental)
    $ riscv64-linux-gnu-gcc -march=rv64ivzvkned -c riscv-crypto/doc/vector/code-samples/zvkned.s

And tip-of-tree clang supports them experimentally:

    $ clang --version
    clang version 18.0.0 (https://github.com/llvm/llvm-project 30416f39be326b403e19f23da387009736483119)
    $ clang -menable-experimental-extensions -target riscv64-linux-gnu -march=rv64ivzvkned1 -c riscv-crypto/doc/vector/code-samples/zvkned.s

It would be nice to use a real assembler, so that people won't have to worry
about potential mistakes or inconsistencies in the perl-based "assembler".  Also
keep in mind that if we allow people to compile this code without the real
assembler support from the beginning, it might end up staying that way for quite
a while in order to avoid breaking the build for people.

Ultimately it's up to you though; I think that you and others who have been
working on RISC-V crypto can make the best decision about what to do here.  I
also don't want this patchset to be delayed waiting for other projects, so maybe
that indeed means the perl-based "assembler" needs to be used for now.

- Eric
