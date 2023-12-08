Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A52280AE71
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbjLHU5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjLHU5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:57:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CA61AD;
        Fri,  8 Dec 2023 12:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tsh6SZmjsiAnQNburkJFUqIGTSKo136cXIGADj2mGbk=; b=nka5h3yCL1hCZw1C09D5tWSVAL
        4oQHmkY/q1dbCaw6qBSKd5XLLGIKuHgbyn9RktMJngKJ2sNKt79QXC0EcciTcnntYjAWwUABeK5Jc
        DXBmAfjnz63AvHfOOdBAkoCfu6fYm4SLROgyQzZJIPKCJ/YGV8KMZtE/W3z86PxOEWqPjYFsjhXup
        Kspp6P26tuanNWKE+ldEJoXw8TQwn787U5ABY5A4BGUxEueMUccx2IZDmrEMBfPmXxeM7u22FagVf
        jk4SlD2jX4uZ6J5wYWrTcUhKwtVQtreODt+nuVfdAs2I6RbfoJuSeyqbH1OGoM94umgRc/l/HKq95
        UUw+dgnA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1rBhtv-006ZnV-M1; Fri, 08 Dec 2023 20:56:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 534BF3003F0; Fri,  8 Dec 2023 21:56:47 +0100 (CET)
Date:   Fri, 8 Dec 2023 21:56:47 +0100
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
Message-ID: <20231208205647.GL28727@noisy.programming.kicks-ass.net>
References: <20231206163814.GB36423@noisy.programming.kicks-ass.net>
 <20231206183713.GA35897@noisy.programming.kicks-ass.net>
 <zu5eb2robdqnp2ojwaxjhnglcummrnjaqbw6krdds6qac3bql2@5zx46c2s6ez4>
 <20231207093105.GA28727@noisy.programming.kicks-ass.net>
 <ivhrgimonsvy3tyj5iidoqmlcyqvtsh2ay3cm3ouemsdbvjzs4@6jlt6zv55tgh>
 <20231208102940.GB28727@noisy.programming.kicks-ass.net>
 <20231208134041.GD28727@noisy.programming.kicks-ass.net>
 <CAADnVQJFB_CPtFS3=VV=RwnP=EQRL3yEsR8wXVcicb07P8NODw@mail.gmail.com>
 <20231208201819.GE36716@noisy.programming.kicks-ass.net>
 <CAADnVQ+1nVBuKkjdvh0eu19p+J0UqbO9mcCf3yzVeQtALxzQ+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+1nVBuKkjdvh0eu19p+J0UqbO9mcCf3yzVeQtALxzQ+Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 12:45:51PM -0800, Alexei Starovoitov wrote:

> I mean we don't need to store a pointer to a func in stubs.
> Can it be, roughly:
> 
> extern void bpf_tcp_ca_cong_avoid(struct sock *sk, u32 ack, u32 acked);
> KCFI_MACRO(hash_of_cong_avoid, bpf_tcp_ca_cong_avoid);
> u32 __array_of_kcfi_hash[] = {hash_of_cong_avoid, hash_of_set_state,...};
>       .bpf_ops_stubs = __array_of_kcfi_hash,

But then how do I index this array? The bpf_ops_stubs thing having the
same layout at the target struct made it easy and we could use 'moff'
for both.

That also remains working if someone adds a member to the struct or
moves some members around.
