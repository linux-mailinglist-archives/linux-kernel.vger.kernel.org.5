Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF828077A8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378839AbjLFShw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378792AbjLFShv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:37:51 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D12A139;
        Wed,  6 Dec 2023 10:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XjoZdIcJ4x0UyyYTC1Lhh7F1PH0NzGpQF/40WH8h+PE=; b=BYNASHq+jpc/8U1rxz8DCtJj7+
        Kj4N1eQTG2Yt2dhsGMUSAsRvsSvY1FhmPVaE0bDvw43eARsX1ZWtS2CBnuadPcFc6dtE6LRNOVGYC
        aZ2nVg6qJ3DRN1Hp3FWYd3h9zWB52+NlCnToyCdRhHDIKgfbalWxEmF1K/m3eh4ebIrexUdcllOya
        iu5XU6Bs3e8b974e0dREPyH7SvE4bOjVN1reX+MSUGOm2oV7UaqlGMgKIz6Oc8/zxxrHtpEzX/N0v
        5ZcnLPsxBaGRexjqTtzyz3w5P1owRBXyAq+dLtjk8i17Z+dITkegtGZouRvQyKoYP2c/NWK6ZBrP6
        SEUC5Jqg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAwln-005Edk-1B;
        Wed, 06 Dec 2023 18:37:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 061D930057E; Wed,  6 Dec 2023 19:37:14 +0100 (CET)
Date:   Wed, 6 Dec 2023 19:37:13 +0100
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
Message-ID: <20231206183713.GA35897@noisy.programming.kicks-ass.net>
References: <20231130134204.136058029@infradead.org>
 <CAADnVQJqE=aE7mHVS54pnwwnDS0b67iJbr+t4j5F4HRyJSTOHw@mail.gmail.com>
 <20231204091334.GM3818@noisy.programming.kicks-ass.net>
 <20231204111128.GV8262@noisy.programming.kicks-ass.net>
 <20231204125239.GA1319@noisy.programming.kicks-ass.net>
 <ZW4LjmUKj1q6RWdL@krava>
 <20231204181614.GA7299@noisy.programming.kicks-ass.net>
 <20231204183354.GC7299@noisy.programming.kicks-ass.net>
 <CAADnVQJwU5fCLcjBWM9zBY6jUcnME3+p=vvdgKK9FiLPWvXozg@mail.gmail.com>
 <20231206163814.GB36423@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206163814.GB36423@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 05:38:14PM +0100, Peter Zijlstra wrote:
> On Mon, Dec 04, 2023 at 05:18:31PM -0800, Alexei Starovoitov wrote:
> 
> > [   13.978497]  ? asm_exc_invalid_op+0x1a/0x20
> > [   13.978798]  ? tcp_set_ca_state+0x51/0xd0
> > [   13.979087]  tcp_v6_syn_recv_sock+0x45c/0x6c0
> > [   13.979401]  tcp_check_req+0x497/0x590
> 
> > The stack trace doesn't have any bpf, but it's a bpf issue too.
> > Here tcp_set_ca_state() calls
> > icsk->icsk_ca_ops->set_state(sk, ca_state);
> > which calls bpf prog via bpf trampoline.
> 
> 
> 
> Specifically, I think this is
> tools/testing/selftests/bpf/progs/bpf_cubic.c, which has:
> 
>         .set_state      = (void *)bpf_cubic_state,
> 
> which comes from:
> 
> BPF_STRUCT_OPS(bpf_cubic_state, struct sock *sk, __u8 *new_state)
> 
> which then wraps:
> 
> BPF_PROG()
> 
> which ends up generating:
> 
> static __always_inline ___bpf_cubic_state(unsigned long long *ctx, struct sock *sk, __u8 *new_state)
> {
> 	...
> }
> 
> void bpf_cubic_state(unsigned long long *ctx)
> {
> 	return ____bpf_cubic_state(ctx, ctx[0], ctx[1]);
> }
> 
> 
> I think this then uses arch_prepare_bpf_trampoline(), but I'm entirely
> lost how this all comes together, because the way I understand it the
> whole bpf_trampoline is used to hook into an ftrace __fentry hook.
> 
> And a __fentry hook is very much not a function pointer. Help!?!?

kernel/bpf/bpf_struct_ops.c:bpf_struct_ops_prepare_trampoline()

And yeah, it seems to use the ftrace trampoline for indirect calls here,
*sigh*.

> The other case:
> 
> For tools/testing/selftests/bpf/progs/bloom_filter_bench.c we have:
> 
>         bpf_for_each_map_elem(&array_map, bloom_callback, &data, 0);
> 
> and here bloom callback appears like a normal function:
> 
> static __u64
> bloom_callback(struct bpf_map *map, __u32 *key, void *val,
>                struct callback_ctx *data)
> 
> 
> But what do functions looks like in the JIT? What's the actual address
> that's then passed into the helper function. Given this seems to work
> without kCFI, it should at least have an ENDBR, but there's only 3 of
> those afaict:
> 
>   - emit_prologue() first insn
>   - emit_prologue() tail-call site
>   - arch_preprare_bpf_trampoline()
> 
> If the function passed to the helper is from do_jit()/emit_prologue(),
> then how do I tell what 'function' is being JIT'ed ?
> 
> If it is arch_prepare_bpf_trampoline(), then we're back at the previous
> question and I don't see how a __fentry site becomes a callable function
> pointer.
> 
> 
> Any clues would be much appreciated.

Still not figured out how this one works...
