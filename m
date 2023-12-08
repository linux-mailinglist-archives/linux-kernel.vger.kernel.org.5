Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E0080AE57
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 21:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbjLHUxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHUxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:53:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1220F1723;
        Fri,  8 Dec 2023 12:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=pY+mb/Qrc+JbGWeBCz5TAVT1HMlwaTqQprEMIVZfjU8=; b=WKHjeQTzRtUa3ehjWvBb5ptG7x
        X1dzOuu693YBY+CQHFy/qT0nKn2Rtrtilph4cDyUU95v7EfqZRN2J48VaQYxXO0T2gVnhWOXhE0VX
        e2RDNVyYfmERESlMze5ErEsZUmhi6JjG7R/f/Vilowo8kJYPyH89aai/nLxwgQEOZlMZyyOpI1eXu
        DOzbxNOqNhOZOlEiS95uxa0YfL8TLyAQ7SdFLWthPC+S3ZJZgmHNShsBWly0Hkz8oEDrmkn8W7jWu
        YwyK0LGYygYKKTgAEZ6IwlF4vKmbPECNkW13Q8NQI00pRT9EhYDKxuM6/3XNX7QDU331UhZ7nZZAG
        F0Y1aysQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1rBhpx-006ZJN-SO; Fri, 08 Dec 2023 20:52:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 28FDA3003F0; Fri,  8 Dec 2023 21:52:41 +0100 (CET)
Date:   Fri, 8 Dec 2023 21:52:41 +0100
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
Message-ID: <20231208205241.GK28727@noisy.programming.kicks-ass.net>
References: <20231206183713.GA35897@noisy.programming.kicks-ass.net>
 <zu5eb2robdqnp2ojwaxjhnglcummrnjaqbw6krdds6qac3bql2@5zx46c2s6ez4>
 <20231207093105.GA28727@noisy.programming.kicks-ass.net>
 <ivhrgimonsvy3tyj5iidoqmlcyqvtsh2ay3cm3ouemsdbvjzs4@6jlt6zv55tgh>
 <20231208102940.GB28727@noisy.programming.kicks-ass.net>
 <20231208134041.GD28727@noisy.programming.kicks-ass.net>
 <20231208172152.GD36716@noisy.programming.kicks-ass.net>
 <CAADnVQKsnZfFomQ4wTZz=jMZW5QCV2XiXVsi64bghHkAjJtcmA@mail.gmail.com>
 <20231208203535.GG36716@noisy.programming.kicks-ass.net>
 <CAADnVQJzCw=qcG+jHBYG0q0SxLPkwghni0wpgV4A4PkpgVbGPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJzCw=qcG+jHBYG0q0SxLPkwghni0wpgV4A4PkpgVbGPw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 12:41:03PM -0800, Alexei Starovoitov wrote:
> On Fri, Dec 8, 2023 at 12:35 PM Peter Zijlstra <peterz@infradead.org> wrote:

> > -__bpf_kfunc void bpf_task_release(struct task_struct *p)
> > +__bpf_kfunc void bpf_task_release(void *p)
> 
> Yeah. That won't work. We need a wrapper.
> Since bpf prog is also calling it directly.
> In progs/task_kfunc_common.h
> void bpf_task_release(struct task_struct *p) __ksym;
> 
> than later both libbpf and the verifier check that
> what bpf prog is calling actually matches the proto
> of what is in the kernel.
> Effectively we're doing strong prototype check at load time.

I'm still somewhat confused on how this works, where does BPF get the
address of the function from? and what should I call the wrapper?

> btw instead of EXPORT_SYMBOL_GPL(bpf_task_release)
> can __ADDRESSABLE be used ?
> Since it's not an export symbol.

No __ADDRESSABLE() is expressly ignored, but we have IBT_NOSEAL() that
should do it. I'll rename the thing and lift it out of x86 to avoid
breaking all other arch builds.

