Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A2478B6B3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjH1RrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjH1Rqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:46:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E47DEE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:46:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC04763D0A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 17:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47BCC433CC;
        Mon, 28 Aug 2023 17:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693244793;
        bh=rqIgUEJ2gFNDPW2upRgvZqXnuhfLL6A/8Oy8KbEhK4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b6pMM8AP7WAcW0DNuOjVIwOpbQKp0udmz2MPGL4OU24kjJSoblFbwTFvc9NL3kPF6
         vuEp7gsbBr02Aw1u3QfqhUP1MwmxHH5dAMy2i0BbwQJT8nmUy0KPys/Ss9fs9hXzMI
         HhkFpPLQ+N+memByUvgZa2aABT7+wtS/orJw+8nhT4eQi8pTC4YRkKBE2FE/gjumKD
         LpiHqqOaBuLFA7ESXjZT/RQ758nOSoQuogWyFr72yb4BSgibQVPGcJ3huO4YACaU7I
         pxLZnhYsDu40Baj+ilZaJ17edxzq08FoRbHflsv4Yqru4lMbEiST/PGMgvXwmtKN5q
         g+5DkhOy8+dNQ==
Date:   Mon, 28 Aug 2023 10:46:31 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     ndesaulniers@google.com
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Tom Rix <trix@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] Revert "Revert "powerpc/xmon: Relax frame size for
 clang""
Message-ID: <20230828174631.GA1255864@dev-arch.thelio-3990X>
References: <20230828-ppc_rerevert-v1-1-74f55b818907@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828-ppc_rerevert-v1-1-74f55b818907@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 10:35:26AM -0700, ndesaulniers@google.com wrote:
> This reverts commit 7f3c5d099b6f8452dc4dcfe4179ea48e6a13d0eb.
> 
> Turns out that this is reproducible still under specific compiler
> versions (mea culpa: I did not test every supported version of clang),
> and even a few randconfigs bots found.
> 
> We'll have to revisit this again in the future, for now back this out.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/252#issuecomment-1690371256
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/llvm/202308260344.Vc4Giuk7-lkp@intel.com/
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

I know this is just a straight reapplication of the original workaround
but could we use ccflags here instead of KBUILD_CFLAGS (with it placed
after the NO_MIMINAL_TOC assignment)?

  # clang stores addresses on the stack causing the frame size to blow
  # out. See https://github.com/ClangBuiltLinux/linux/issues/252
  ccflags-$(CONFIG_CC_IS_CLANG) += -Wframe-larger-than=4096

The addition to KBUILD_CFLAGS makes me think this flags will get applied
to the rest of the kernel but I have not actually verified.

Regardless:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Side note, seems like b4 is still doing the thing with "From:".

> ---
>  arch/powerpc/xmon/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
> index 7705aa74a24d..d334de392e6c 100644
> --- a/arch/powerpc/xmon/Makefile
> +++ b/arch/powerpc/xmon/Makefile
> @@ -10,6 +10,12 @@ KCSAN_SANITIZE := n
>  # Disable ftrace for the entire directory
>  ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
>  
> +ifdef CONFIG_CC_IS_CLANG
> +# clang stores addresses on the stack causing the frame size to blow
> +# out. See https://github.com/ClangBuiltLinux/linux/issues/252
> +KBUILD_CFLAGS += -Wframe-larger-than=4096
> +endif
> +
>  ccflags-$(CONFIG_PPC64) := $(NO_MINIMAL_TOC)
>  
>  obj-y			+= xmon.o nonstdio.o spr_access.o xmon_bpts.o
> 
> ---
> base-commit: 2ee82481c392eec06a7ef28df61b7f0d8e45be2e
> change-id: 20230828-ppc_rerevert-647427f04ce1
> 
> Best regards,
> -- 
> Nick Desaulniers <ndesaulniers@google.com>
> 
