Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188D077E6CF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344877AbjHPQnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344949AbjHPQm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:42:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9760930D2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:42:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 333F366CFA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 16:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AF1C433C8;
        Wed, 16 Aug 2023 16:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692204153;
        bh=58unTFnXGEq3UBUCeC2OOQ34OOD9B4fl4PEKWgwKnBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qDsJ4PybcVzKHecuX6kYS/XWs0yKGqmYNteF7T/NL+/93pWCmql4uxXQ2pI2rJfdX
         6UQNv1XFXDcjCsKQCGrW35qSAi5xhYyztHRTVmCFcQ1Q/3NKP63VtpfOI6xSH3Ad6F
         bb4jahKCpOvIkedMgSEexaTY+Q3IzpKOEpN6zP0Uq+XwLzbBZMMN5PzIp942eFd6Zk
         wf/FVi8RSJ89Lbo0yfnZpDeNAEgXi8QYhdepy6rfIUWdmH1+nDo43oytuI1hs80oLP
         cAR1Ki1DXuTfQVjBUPLRvef12BfIQSkcHQKPwsovgQa0NvhWdpVT4z5YhkeT3pfcNZ
         uCEPjn0OiZSxQ==
Date:   Wed, 16 Aug 2023 09:42:31 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>, Guo Ren <guoren@kernel.org>,
        Deepak Gupta <debug@rivosinc.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] riscv: SCS support
Message-ID: <20230816164231.GA1653714@dev-arch.thelio-3990X>
References: <20230815203442.1608773-8-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815203442.1608773-8-samitolvanen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sami,

On Tue, Aug 15, 2023 at 08:34:43PM +0000, Sami Tolvanen wrote:
> Hi folks,
> 
> This series adds Shadow Call Stack (SCS) support for RISC-V. SCS
> uses compiler instrumentation to store return addresses in a
> separate shadow stack to protect them against accidental or
> malicious overwrites. More information about SCS can be found
> here:
> 
>   https://clang.llvm.org/docs/ShadowCallStack.html
> 
> Patch 1 is from Deepak, and it simplifies VMAP_STACK overflow
> handling by adding support for accessing per-CPU variables
> directly in assembly. The patch is included in this series to
> make IRQ stack switching cleaner with SCS, and I've simply
> rebased it. Patch 2 uses this functionality to clean up the stack
> switching by moving duplicate code into a single function. On
> RISC-V, the compiler uses the gp register for storing the current
> shadow call stack pointer, which is incompatible with global
> pointer relaxation. Patch 3 moves global pointer loading into a
> macro that can be easily disabled with SCS. Patch 4 implements
> SCS register loading and switching, and allows the feature to be
> enabled, and patch 5 adds separate per-CPU IRQ shadow call stacks
> when CONFIG_IRQ_STACKS is enabled. Patch 6 fixes the backward-
> edge CFI test in lkdtm for RISC-V.
> 
> Note that this series requires Clang 17. Earlier Clang versions
> support SCS on RISC-V, but use the x18 register instead of gp,
> which isn't ideal. gcc has SCS support for arm64, but I'm not
> aware of plans to support RISC-V. Once the Zicfiss extension is
> ratified, it's probably preferable to use hardware-backed shadow
> stacks instead of SCS on hardware that supports the extension,
> and we may want to consider implementing CONFIG_DYNAMIC_SCS to
> patch between the implementation at runtime (similarly to the
> arm64 implementation, which switches to SCS when hardware PAC
> support isn't available).

I took this series for a spin in QEMU with both LLVM 18.0.0 and
17.0.0-rc2 and the LKDTM test now passes with CONFIG_SHADOW_CALL_STACK=y
(and fails with LLVM 16.0.0, as CONFIG_SHADOW_CALL_STACK is not
selectable there).

Tested-by: Nathan Chancellor <nathan@kernel.org>

Cheers,
Nathan
