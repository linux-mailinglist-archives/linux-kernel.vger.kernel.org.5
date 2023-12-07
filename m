Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19535808635
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378630AbjLGJeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378491AbjLGJeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:34:00 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4A8D53;
        Thu,  7 Dec 2023 01:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vFTMUOzkVz1yhy1eVbvlXLTlgFpP3ARXqzrNiOd/DUQ=; b=BjH07tO6hYuSjTfilfl4n85dJn
        jwCzc+ni2sBN9SitG9DfFVJjs61YLkfrb8GoQfH8XUGR24A3w3hE+1+4eiXvch0bjuircH2TzwNe3
        2wib7xfIbfMu0ZZCat/L7nH7JGRv5WicJZ/YEBVBSbdkmRW3wvF7MqUwoqS1mwMuKRmY9XOrwRUQh
        gZqD610ihrIYCMrm8rtS55j06Xe9kiv0m2lp+eptll2P0QUCCn78OPoHJlJr2h6EdGWAwM+xhz9Qx
        BRv9z5wptGCweR1/JNdj+9h0GN55+WMsNwvvADN6sEL9iwgdTFdETyA1h0mlfWIcOHhLOs0Jjfqb4
        dnXvWrjA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rBAio-005war-2y;
        Thu, 07 Dec 2023 09:33:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id B8E6C300338; Thu,  7 Dec 2023 10:31:05 +0100 (CET)
Date:   Thu, 7 Dec 2023 10:31:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, Song Liu <song@kernel.org>,
        Song Liu <songliubraving@meta.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Joao Moreira <joao@overdrivepizza.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 2/2] x86/cfi,bpf: Fix BPF JIT call
Message-ID: <20231207093105.GA28727@noisy.programming.kicks-ass.net>
References: <20231204091334.GM3818@noisy.programming.kicks-ass.net>
 <20231204111128.GV8262@noisy.programming.kicks-ass.net>
 <20231204125239.GA1319@noisy.programming.kicks-ass.net>
 <ZW4LjmUKj1q6RWdL@krava>
 <20231204181614.GA7299@noisy.programming.kicks-ass.net>
 <20231204183354.GC7299@noisy.programming.kicks-ass.net>
 <CAADnVQJwU5fCLcjBWM9zBY6jUcnME3+p=vvdgKK9FiLPWvXozg@mail.gmail.com>
 <20231206163814.GB36423@noisy.programming.kicks-ass.net>
 <20231206183713.GA35897@noisy.programming.kicks-ass.net>
 <zu5eb2robdqnp2ojwaxjhnglcummrnjaqbw6krdds6qac3bql2@5zx46c2s6ez4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zu5eb2robdqnp2ojwaxjhnglcummrnjaqbw6krdds6qac3bql2@5zx46c2s6ez4>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 01:39:43PM -0800, Alexei Starovoitov wrote:


> All is ok until kCFI comes into picture.
> Here we probably need to teach arch_prepare_bpf_trampoline() to emit
> different __kcfi_typeid depending on kernel function proto,
> so that caller hash checking logic won't be tripped.
> I suspect that requires to reverse engineer an algorithm of computing kcfi from clang.
> other ideas?

I was going to try and extend bpf_struct_ops with a pointer, this
pointer will point to a struct of the right type with all ops filled out
as stubs.

Then I was going to have bpf_struct_ops_map_update_elem() pass a pointer
to the stub op (using moff) into bpf_struct_ops_prepare_trampoline() and
eventually arch_prepare_bpf_trampoline().

Additionally I was going to add BPF_TRAMP_F_INDIRECT.

Then when F_INDIRECT is set, have it generate the CFI preamble based on
the stub passed -- which will have the correct preamble for that method.

At least, that's what I'm thinking now, I've yet to try and implement
it.

> > > The other case:

> In the case of bpf_for_each_map_elem() the 'bloom_callback' is a subprog
> of bpf_callback_t type.
> So the kernel is doing:
>                 ret = callback_fn((u64)(long)map, (u64)(long)&key,
>                                   (u64)(long)val, (u64)(long)callback_ctx, 0);
> and that works on all archs including 32-bit.
> The kernel is doing conversion from native calling convention to bpf calling convention
> and for lucky archs like x86-64 the conversion is a true nop.
> It's a plain indirect call to JITed bpf prog.
> Note there is no interpreter support here. This works on archs with JITs only.
> No ftrace and no trampoline.
> 
> This case is easier to make work with kCFI.
> The JIT will use:
> cfi_bpf_hash:
>       .long   __kcfi_typeid___bpf_prog_runX  
> like your patch already does.
> And will use
> extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
> cfi_bpf_subprog_hash:
>       .long   __kcfi_typeid___bpf_callback_fn
> to JIT all subprogs. See bpf_is_subprog().

Aaah!, yes it should be trivial to use another hash value when
is_subprog in emit_prologue().

> btw there are two patchsets in progress that will touch core bits of JITs.
> This one:
> https://patchwork.kernel.org/project/netdevbpf/cover/20231201190654.1233153-1-song@kernel.org/
> and this one:
> https://patchwork.kernel.org/project/netdevbpf/cover/20231011152725.95895-1-hffilwlqm@gmail.com/
> 
> so do you mind resending your current set with get_cfi_offset() change and
> I can land it into bpf-next, so we can fix one bug at a time,
> build on top, and avoid conflicts?

I can do.

> The more we dig the more it looks like that the follow up you planned to do
> on top of this set isn't going to happen soon.
> So should be ok going through bpf-next and then you can follow up with x86 things
> after merge window?

Yes, we can do that. Plans have changed on my side too -- I'm taking a 6
week break soon, so I'll do whatever I can before I'm out, and then
continue from whatever state I find when I get back.


Thanks for the details!
