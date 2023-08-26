Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495AC7893A0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 05:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjHZDSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 23:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjHZDSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 23:18:01 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DE3210C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 20:17:58 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c0e7e3d170so55735ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 20:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693019878; x=1693624678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NTpWWoAzCcGiRnwVxW+wyPGfNXm/UmsRStzWL2401ms=;
        b=teQLc7wAUgGrER8vTD1pcB6PLRVdVTwkVG9WKMNyN6+TCd5oCGlJESlTncu6f8VdQP
         qUYGszWCYKw4qYMn5yc0yrthvYgBgSEjpKMKYnCGVHpK2dSNWIYAOBz09QLbTDTK/1Q1
         e+bYeitkmm9iaYQYhYBPqMj2y0l7jOevVP32SGNN4ABk2Tj4mQsEobj1s5kMItYq8nJe
         4PoByq3CP7G/b9yV8es943koSrvFzG260D6zZwop7NaSILAS5xQVzp/8V2AjKtGPDYsg
         7Bbp6tmLgIdhfeHhg3uup4RLFA6hYT+jQ9mmApTUGNAFlg1hGDuhfthJ45DULTmXbV4G
         iMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693019878; x=1693624678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTpWWoAzCcGiRnwVxW+wyPGfNXm/UmsRStzWL2401ms=;
        b=KNY2+A2AuPmYNSDfsyFIdvQM5ECj5H9bP1islKV87hy66kq06jdUy7A2SZi2yaPi4K
         0s6Pm7wM35jWggpPcWMDOwWz0PdpMTEu8BxW2zsK1AyguMNxA1yXKoMhdGZfwO+dHgpw
         N++/PckeOVoESDawrY0m+k7KoILmBFv4cScy8L+VN6av8x55mXmYfBMFfoQVUBoZ9fKl
         ZW+/5n1LnKHxfgygtCIkqQCDKvgDY4JQs1CQLz7rVrpl0jgAka9ep47/o7KkDNAl2PYW
         TvYA0CjVc6inFnF96M+MeLM9ixDu9YhCt/UP7Kg9RIP/y0uv3GJd5CTX5N/kXPK0szgz
         lxAg==
X-Gm-Message-State: AOJu0YwffUHMGtCgL1QticnGHi8oAyCl0M8jJaGNOBR8MVeRGNTnC5NY
        lxN5UDJ8q6TBiVkG67ZzW01ekw==
X-Google-Smtp-Source: AGHT+IFgTjL85NMW7QVTfT1LIEunufc8m3DLUqvJfm8kEADFDEa+5LGQPIut13OdOpGUuedULTjPsw==
X-Received: by 2002:a17:902:c703:b0:1bd:b75a:e95f with SMTP id p3-20020a170902c70300b001bdb75ae95fmr128179plp.0.1693019877605;
        Fri, 25 Aug 2023 20:17:57 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:205:6671:452e:1913:d899])
        by smtp.gmail.com with ESMTPSA id a14-20020a62bd0e000000b006870ff20254sm2251739pff.125.2023.08.25.20.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 20:17:57 -0700 (PDT)
Date:   Fri, 25 Aug 2023 20:17:52 -0700
From:   Fangrui Song <maskray@google.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>, Helge Deller <deller@gmx.de>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Chanho Min <chanho.min@lge.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: [PATCH] lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit
 kernels
Message-ID: <20230826031752.gongmxkr56zyycol@google.com>
References: <ZOkGCSNr0VN2VIJJ@p100>
 <CAHk-=wjZwSymfuGvf7TX3UQLU1OMN1FZMnEA-Hja0ruqyhMK4A@mail.gmail.com>
 <CAHk-=whVvD05T0yD5DQj803uETLD6qDq-Vx-SiLPcrL=eO77LQ@mail.gmail.com>
 <CAKwvOdnYauyrzz7-ceH-MP_KZ5ED8oYxjRx_Xei68=tUOSeKyA@mail.gmail.com>
 <CAGG=3QWcZPYqHMcjwuYDz1+OQhzS40hmhdOvSBZBQOkhs8YAQQ@mail.gmail.com>
 <CAGG=3QX8AaTedPy-joWm6yp+TFHBVXm59OcvxkdLGsSuDjem5g@mail.gmail.com>
 <CAHk-=wjQpXpnGAwvv-oBi+cQ0g+D9rTK5STkXSSV4a90FPR+EQ@mail.gmail.com>
 <CAKwvOdm_y6UOnxFrAiDxou2jc8CRUvyhfH9kAdc3PG0=bEvduw@mail.gmail.com>
 <CAHk-=wgJzMzPFTCzejWs1WM4=74z2VENyOzySnucrXG3i=ajrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=wgJzMzPFTCzejWs1WM4=74z2VENyOzySnucrXG3i=ajrw@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-25, Linus Torvalds wrote:
>On Fri, 25 Aug 2023 at 17:52, Nick Desaulniers <ndesaulniers@google.com> wrote:
>>
>> So 2 concerns where "I'll do it in inline asm" can pessimize codegen:
>> 1. You alluded to this, but what happens when one of these functions
>> is called with a constant?
>
>This is why our headers have a lot of __builtin_constant_p()'s in them..
>
>In this particular case, see the x86 asm/bitops.h code:
>
>    #define ffs(x) (__builtin_constant_p(x) ? __builtin_ffs(x) :
>variable_ffs(x))

For the curious (like me),

__builtin_ffs
https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html#index-_005f_005fbuiltin_005fffs says

     Returns the number of leading 0-bits in x, starting at the most significant bit position. If x is 0, the result is undefined.

The hangling of 0 seems the cause that __builtin_ffs codegen is not as
well as inline asm.  Clang implemented the builtin in 2008 and took the
same constraint (penalty).



GCC compiles __builtin_ctzl(x) to xorl    %eax, %eax; tzcntq  %rdi, %rax
on most Intel processors (AMD -march= values are unaffected). The extra
xor is due to a false dependency issue
https://gcc.gnu.org/git/?p=gcc.git&a=commit;h=73543b2286027da1de561902440b53f775a03a86

Inline asm wins here as well since we know the argument 0 is undefined.

In May 2023, https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=cc6eb8b51f9568ae0caf46b80e2a0aff050030ce
"Disable avoid_false_dep_for_bmi for atom and icelake(and later) core processors."
removed the extra xor for icelake (and later) core processors.

>but this is actually quite a common pattern, and it's often not about
>something like __builtin_ffs() at all.
>
>See all the other __builtin_constant_p()'s that we have in that same
>file because we basically just use different code sequences for
>constants.
>
>And that file isn't even unusual. We use it quite a lot when we care
>about code generation for some particular case.
>
>> 2. by providing the definition of a symbol typically provided by libc
>> (and then not building with -ffreestanding) pessimizes libcall
>> optimization.
>
>.. and this is partly why we often avoid libgcc things, and do certain
>things by hand.
>
>The classic rule is "Don't do 64-bit divisions using the C '/' operator".
>
>So in the kernel you have to use do_div() and friends, because the
>library versions are often disgusting and might not know that 64/32 is
>much much cheaper and is what you want.
>
>And quite often we simply use other names - but then we also do *not*
>build with -freestanding, because -freestanding has at least
>traditionally meant that the compiler won't optimize the simple and
>obvious cases (typically things like "memcpy with a constant size").
>
>So we mix and match and pick the best option.
>
>The kernel really doesn't care about architecture portability, because
>honestly, something like "ffs()" is entirely *trivial* to get right,
>compared to the real differences between architectures (eg VM and IO
>differences etc).
>
>             Linus
>
