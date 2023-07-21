Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D11C75BDA4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 07:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjGUFNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 01:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGUFNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 01:13:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550C4CC;
        Thu, 20 Jul 2023 22:12:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF11260C8E;
        Fri, 21 Jul 2023 05:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD864C433C7;
        Fri, 21 Jul 2023 05:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689916375;
        bh=WPeEnFdfCBLOPdp6eea7RsY9spio4gTJNjv/KaXILgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HY5vQyF/dWt+90AINhxoO3ErLd9GcWTIakKly9JVxzWJ0C6zfFvrIe/DE0hJVGBOp
         7wo6mQMj5x6B/ugcgr7Zb/sjR7+TbGiTkbgErOblnvpEyXzD3AjkAvwRUDKcxw4bhP
         dpLezp7X3XoDMiejvCbms8dE37rmLI+6+4hyTKs6DkqtaHDO9AN7VGVe8h0ZEzxp6v
         xQOjGmBsK/kATw1PlXfYOwlccNMrV4DbHIRncc2slu4yfgYp8hvo1qBwWCxOK5Gema
         NN+N+GgT8Ls8JpZoAc/KiG7MbT58VMSK9Ax6zpR6fJBVi9lCojHOjKzCetqaXpPQmH
         CGXcVEq1Nwm0w==
Date:   Thu, 20 Jul 2023 22:12:53 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v4 00/12] RISC-V: support some cryptography accelerations
Message-ID: <20230721051253.GC847@sol.localdomain>
References: <20230711153743.1970625-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711153743.1970625-1-heiko@sntech.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Tue, Jul 11, 2023 at 05:37:31PM +0200, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> 
> This series provides cryptographic implementations using the vector
> crypto extensions.
> 
> v13 of the vector patchset dropped the patches for in-kernel usage of
> vector instructions, I picked the ones from v12 over into this series
> for now.
> 
> My basic goal was to not re-invent cryptographic code, so the heavy
> lifting is done by those perl-asm scripts used in openssl and the perl
> code used here-in stems from code that is targetted at openssl [0] and is
> unmodified from there to limit needed review effort.
> 
> With a matching qemu (there are patches for vector-crypto flying around)
> the in-kernel crypto-selftests (also the extended ones) are very happy
> so far.
> 
> 
> changes in v4:
> - split off from scalar crypto patches but base on top of them
> - adapt to pending openssl code [0] using the now frozen vector crypto
>   extensions - with all its changes
>   [0] https://github.com/openssl/openssl/pull/20149
> 
> changes in v3:
> - rebase on top of 6.3-rc2
> - rebase on top of vector-v14 patchset
> - add the missing Co-developed-by mentions to showcase
>   the people that did the actual openSSL crypto code
> 
> changes in v2:
> - rebased on 6.2 + zbb series, so don't include already
>   applied changes anymore
> - refresh code picked from openssl as that side matures
> - more algorithms (SHA512, AES, SM3, SM4)
> 
> Greentime Hu (2):
>   riscv: Add support for kernel mode vector
>   riscv: Add vector extension XOR implementation
> 
> Heiko Stuebner (10):
>   RISC-V: add helper function to read the vector VLEN
>   RISC-V: add vector crypto extension detection
>   RISC-V: crypto: update perl include with helpers for vector (crypto)
>     instructions
>   RISC-V: crypto: add Zvbb+Zvbc accelerated GCM GHASH implementation
>   RISC-V: crypto: add Zvkg accelerated GCM GHASH implementation
>   RISC-V: crypto: add a vector-crypto-accelerated SHA256 implementation
>   RISC-V: crypto: add a vector-crypto-accelerated SHA512 implementation
>   RISC-V: crypto: add Zvkned accelerated AES encryption implementation
>   RISC-V: crypto: add Zvksed accelerated SM4 encryption implementation
>   RISC-V: crypto: add Zvksh accelerated SM3 hash implementation
> 
>  arch/riscv/crypto/Kconfig                     |  68 ++-
>  arch/riscv/crypto/Makefile                    |  44 +-
>  arch/riscv/crypto/aes-riscv-glue.c            | 168 ++++++
>  arch/riscv/crypto/aes-riscv64-zvkned.pl       | 530 ++++++++++++++++++
>  arch/riscv/crypto/ghash-riscv64-glue.c        | 245 ++++++++
>  arch/riscv/crypto/ghash-riscv64-zvbb-zvbc.pl  | 380 +++++++++++++
>  arch/riscv/crypto/ghash-riscv64-zvkg.pl       | 168 ++++++
>  arch/riscv/crypto/riscv.pm                    | 433 +++++++++++++-
>  arch/riscv/crypto/sha256-riscv64-glue.c       | 115 ++++
>  .../crypto/sha256-riscv64-zvbb-zvknha.pl      | 314 +++++++++++
>  arch/riscv/crypto/sha512-riscv64-glue.c       | 106 ++++
>  .../crypto/sha512-riscv64-zvbb-zvknhb.pl      | 377 +++++++++++++
>  arch/riscv/crypto/sm3-riscv64-glue.c          | 112 ++++
>  arch/riscv/crypto/sm3-riscv64-zvksh.pl        | 225 ++++++++
>  arch/riscv/crypto/sm4-riscv64-glue.c          | 162 ++++++
>  arch/riscv/crypto/sm4-riscv64-zvksed.pl       | 300 ++++++++++
>  arch/riscv/include/asm/hwcap.h                |   9 +
>  arch/riscv/include/asm/vector.h               |  28 +
>  arch/riscv/include/asm/xor.h                  |  82 +++
>  arch/riscv/kernel/Makefile                    |   1 +
>  arch/riscv/kernel/cpu.c                       |   8 +
>  arch/riscv/kernel/cpufeature.c                |  50 ++
>  arch/riscv/kernel/kernel_mode_vector.c        | 132 +++++
>  arch/riscv/lib/Makefile                       |   1 +
>  arch/riscv/lib/xor.S                          |  81 +++
>  25 files changed, 4136 insertions(+), 3 deletions(-)
>  create mode 100644 arch/riscv/crypto/aes-riscv-glue.c
>  create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned.pl
>  create mode 100644 arch/riscv/crypto/ghash-riscv64-zvbb-zvbc.pl
>  create mode 100644 arch/riscv/crypto/ghash-riscv64-zvkg.pl
>  create mode 100644 arch/riscv/crypto/sha256-riscv64-glue.c
>  create mode 100644 arch/riscv/crypto/sha256-riscv64-zvbb-zvknha.pl
>  create mode 100644 arch/riscv/crypto/sha512-riscv64-glue.c
>  create mode 100644 arch/riscv/crypto/sha512-riscv64-zvbb-zvknhb.pl
>  create mode 100644 arch/riscv/crypto/sm3-riscv64-glue.c
>  create mode 100644 arch/riscv/crypto/sm3-riscv64-zvksh.pl
>  create mode 100644 arch/riscv/crypto/sm4-riscv64-glue.c
>  create mode 100644 arch/riscv/crypto/sm4-riscv64-zvksed.pl
>  create mode 100644 arch/riscv/include/asm/xor.h
>  create mode 100644 arch/riscv/kernel/kernel_mode_vector.c
>  create mode 100644 arch/riscv/lib/xor.S
> 

Thanks for working on this patchset!  I'm glad to see that you and others are
working on this and the code in OpenSSL.  And thanks for running all the kernel
crypto self-tests and verifying that they pass.

I'm still a bit worried about there being two competing sets of crypto
extensions for RISC-V: scalar and vector.

However the vector crypto extensions are moving forwards (they were recently
frozen), from what I've heard are being implemented in CPUs, and based on this
patchset implementations of most algorithms are ready already.

So I'm wondering: do you still think that it's valuable to continue with your
other patchset that adds GHASH acceleration using the scalar extensions (which
this patchset is still based on)?  

I'm wondering if we should be 100% focused on the vector extensions for now to
avoid fragmentation of effort.

It's just not super clear to me what is driving the scalar crypto support right
now.  Maybe embedded systems?  Maybe it was just a mistep, perhaps due to being
started before the CPU even had a vector unit?  I don't know.  If you do indeed
have a strong reason for it, then you can go ahead -- I just wanted to make sure
we don't end up doing twice as much work unnecessarily.

- Eric
