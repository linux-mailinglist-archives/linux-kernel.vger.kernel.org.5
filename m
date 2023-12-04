Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E657080314B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjLDLML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjLDLMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:12:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA881CC;
        Mon,  4 Dec 2023 03:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=57qN1iQssrdoPxO3vjOJxY+KkICDSFEOHy7vEhypSQY=; b=SJZWmelLjacxjQSc2rHFwC2yAL
        jTj9QZTX0X4Po4XPpfbs7mcPqcRffTzF+bRxA6cc+E5pWWustakRYKEHFrKYdsNMy0O3vYtMgKPqD
        g6mXsMan1PhPEuOos6p54MK0NRN6dhfjkQFxjjekcKPgEUo/P8hMw93tOmEpoCTiUedvGyLRD8Z9D
        HLkoFDqCUrQBEg2UU8X7XyyVtMWxis4xqXdL5iszhpV2f0OjzCwzyI6Idp1VXXqqWoC3vZQiQNbY4
        zqZ1Mcm2rpTcgt+Qe43CxSMZDe3gBiRFLdStRojeDIPpxLyqyFTKjjgekBA/xZqWFFnX93kfXBC7a
        /EPIZEzw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1rA6rJ-000b3j-D2; Mon, 04 Dec 2023 11:11:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6305A3003F0; Mon,  4 Dec 2023 12:11:28 +0100 (CET)
Date:   Mon, 4 Dec 2023 12:11:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Song Liu <song@kernel.org>, Song Liu <songliubraving@meta.com>,
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
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <20231204111128.GV8262@noisy.programming.kicks-ass.net>
References: <20231130133630.192490507@infradead.org>
 <20231130134204.136058029@infradead.org>
 <CAADnVQJqE=aE7mHVS54pnwwnDS0b67iJbr+t4j5F4HRyJSTOHw@mail.gmail.com>
 <20231204091334.GM3818@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204091334.GM3818@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 10:13:34AM +0100, Peter Zijlstra wrote:

> > Just running test_progs it splats right away:
> > 
> > [   74.047757] kmemleak: Found object by alias at 0xffffffffa0001d80
> > [   74.048272] CPU: 14 PID: 104 Comm: kworker/14:0 Tainted: G        W
> >  O       6.7.0-rc3-00702-g41c30fec304d-dirty #5241
> > [   74.049118] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> > [   74.050042] Workqueue: events bpf_prog_free_deferred
> > [   74.050448] Call Trace:
> > [   74.050663]  <TASK>
> > [   74.050841]  dump_stack_lvl+0x55/0x80
> > [   74.051141]  __find_and_remove_object+0xdb/0x110
> > [   74.051521]  kmemleak_free+0x41/0x70
> > [   74.051828]  vfree+0x36/0x130
> 
> Durr, I'll see if I can get that stuff running locally, and otherwise
> play with the robot as you suggested. Thanks!

I think it is bpf_jit_binary_pack_hdr(), which is using prog->bpf_func
as a start address for the image, instead of jit_data->image.

This used to be true, but now it's offset.

Let me see what to do about that...
