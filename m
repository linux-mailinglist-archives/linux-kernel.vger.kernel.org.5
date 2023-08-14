Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302B577BF72
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjHNSAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjHNR7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:59:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDB01BD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:59:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3FE5637B7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88967C433C8;
        Mon, 14 Aug 2023 17:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692035971;
        bh=FS2sEL2B80bH8ltwGIi7XOqH2+c7YsqW7sPWp/SuQ2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n9Ga5o8ukskYsbpvWB8DCdAIH7+jkzTTwlEVWzn7Y9m1TeA0d3qL1/g0royEgWaZA
         XKRrzRa8QUIM8kfuAPH+KPAZnW9Si/53wBxUxcIRf9r7rtytGsAVNebXKzykpqil7/
         OqDI4NSi79K9fsQmivTcG9Y817LtdgjUBe/AmlmbLwHcA25Ox4ZZ+7kfQu4bg8B4ZY
         9cq05uEvOYFhgl+Id9gHFEM+6B+Jdtx/ZE3SVK0iQcbz+RmR2za9MFa1VqHZUjuTbP
         +EVrAfumNhvOLhl8aCy9WzqOUS/v+sCK5MB3TKfIb6M4zH/JgsgO9scOErtu5BmDOp
         bVd3IRztrPIHg==
Date:   Mon, 14 Aug 2023 10:59:28 -0700
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
Subject: Re: [PATCH 0/5] riscv: SCS support
Message-ID: <20230814175928.GA1028706@dev-arch.thelio-3990X>
References: <20230811233556.97161-7-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811233556.97161-7-samitolvanen@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sami,

On Fri, Aug 11, 2023 at 11:35:57PM +0000, Sami Tolvanen wrote:
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
> when CONFIG_IRQ_STACKS is enabled.
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

I took this series for a spin on top of 6.5-rc6 with both LLVM 18 (built
within the past couple of days) and LLVM 17.0.0-rc2 but it seems that
the CFI_BACKWARDS LKDTM test does not pass with
CONFIG_SHADOW_CALL_STACK=y.

  [   73.324652] lkdtm: Performing direct entry CFI_BACKWARD
  [   73.324900] lkdtm: Attempting unchecked stack return address redirection ...
  [   73.325178] lkdtm: Eek: return address mismatch! 0000000000000002 != ffffffff80614982
  [   73.325478] lkdtm: FAIL: stack return address manipulation failed!

Does the test need to be adjusted or is there some other issue?

Cheers,
Nathan
