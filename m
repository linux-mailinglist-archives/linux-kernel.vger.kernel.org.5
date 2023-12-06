Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9838073C4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379216AbjLFPgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379142AbjLFPgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:36:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39B4112;
        Wed,  6 Dec 2023 07:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=34JGkeDw2fzo5aYJ5fytyFCmmA2EAJ4M9xy4pwn6wrM=; b=gTruqnlu8eDmXa3L0iyeSD2Nnn
        ePXXo7+GcN32qytdrXaWYSLANmme4ALZxhg0JQlNFwM/MH4cviy77G8UNNHVpyThWd9OSqLjvfyjH
        n+hvMI4zCb/iJgc+nB2YqllaE+P53evNS/9fuIg8TOPrU7vxPv0Z2HgxAq+kGffHXcdGVjW87Znxc
        j4vkPvTk0bS8qgVSzZs8fcJ4jZGSyPTxTSPz0Q2sEpN7Cn7GkfA4d44EOHD4gLC5FjiKQEaNcynfB
        DtD725Qv+e8+0LnA0+qRxiZ5Qcjpt7or8VjiV6p28m3HroSjoRF0w57Lro7i//DTiB2B6gCrZJ6mU
        cXJtqFlQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1rAtw5-0031PW-8d; Wed, 06 Dec 2023 15:35:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 36B6E300451; Wed,  6 Dec 2023 16:35:40 +0100 (CET)
Date:   Wed, 6 Dec 2023 16:35:40 +0100
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
Message-ID: <20231206153540.GA36423@noisy.programming.kicks-ass.net>
References: <20231130133630.192490507@infradead.org>
 <20231130134204.136058029@infradead.org>
 <CAADnVQJqE=aE7mHVS54pnwwnDS0b67iJbr+t4j5F4HRyJSTOHw@mail.gmail.com>
 <20231204091334.GM3818@noisy.programming.kicks-ass.net>
 <20231204111128.GV8262@noisy.programming.kicks-ass.net>
 <20231204125239.GA1319@noisy.programming.kicks-ass.net>
 <ZW4LjmUKj1q6RWdL@krava>
 <20231204181614.GA7299@noisy.programming.kicks-ass.net>
 <20231204183354.GC7299@noisy.programming.kicks-ass.net>
 <CAADnVQJwU5fCLcjBWM9zBY6jUcnME3+p=vvdgKK9FiLPWvXozg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJwU5fCLcjBWM9zBY6jUcnME3+p=vvdgKK9FiLPWvXozg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 05:18:31PM -0800, Alexei Starovoitov wrote:

> How about

> +int get_cfi_offset(void)
> +{
> +       switch (cfi_mode) {
> +       case CFI_FINEIBT:
> +               return 16;
> +       case CFI_KCFI:
> +#ifdef CONFIG_CALL_PADDING
> +               return 16;
> +#else
> +               return 5;
> +#endif
> +       default:
> +               return 0;
> +       }
> +}

Yeah, that works. I'll go make it happen.

> Separately we need to deal with bpf_for_each_array_elem()
> which doesn't look easy.
> And fix tcp_set_ca_state() as well (which is even harder).
> 
> Just to see where places like these are I did:
> +__nocfi
>  BPF_CALL_4(bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_ctx,
> +__nocfi
>  static long bpf_for_each_hash_elem(struct bpf_map *map,
> bpf_callback_t callback_fn,
> +__nocfi
>  static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
> +__nocfi
>  static int __bpf_rbtree_add(struct bpf_rb_root *root,
> +__nocfi
>  BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *, map,
> +__nocfi
>  void tcp_set_ca_state(struct sock *sk, const u8 ca_state)
> +__nocfi
>  void tcp_init_congestion_control(struct sock *sk)
> +__nocfi
>  void tcp_enter_loss(struct sock *sk)
> +__nocfi
>  static void tcp_cong_avoid(struct sock *sk, u32 ack, u32 acked)
> +__nocfi
>  static inline void tcp_in_ack_event(struct sock *sk, u32 flags)
> 
> and more... Which is clearly not a direction to go.
> 
> Instead of annotating callers is there a way to say that
> all bpf_callback_t calls are nocfi?

Well, ideally they would all actually use CFI, I'll go figure out how
all this works and think about it. Thanks!

> I feel the patches scratched the iceberg.

Yeah, clearly :/ I'll go stare at it all.
