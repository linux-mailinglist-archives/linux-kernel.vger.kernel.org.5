Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3715779F92
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 13:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjHLLVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 07:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjHLLV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 07:21:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CD919F
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 04:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=XhcE3Ku5pEeUNhsUkVKVqubmZgCIEBRqTamwtlZ6vlU=; b=HGAiXbc2S1cyoTi5KxCrZwzHMb
        5FV7Hgim1yQ9dQvGd7fs04Oj5mqQ9REXajARNfMYAGpXDdlfVsMTebgIWg/7G72vsMrIEgmQCmBI+
        goptux4b83qwmgmjqL4ZOP4Z8ZwJqRV5THLyFrSIA5bVd1WVKPcFTkSth392zYQNZS+LLhVzYNBmc
        LgjHQeiuXThh4UmPjbmR683hnxOs48+zNu56EYt1QT2imf/gP0b+a3K2q0iLeZ27Xyu4uiNQ8Bb67
        E8STdvMnun82NlxUcv+9NT+fhL++VfPsxoMCRmqWNNBjDQZMfvhETD//6F5CJZF8maUOU5Vqw3idP
        ojh3AqAw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qUmfy-008exo-0F;
        Sat, 12 Aug 2023 11:20:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 47B7330057E;
        Sat, 12 Aug 2023 13:20:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 25FB320410DA2; Sat, 12 Aug 2023 13:20:57 +0200 (CEST)
Date:   Sat, 12 Aug 2023 13:20:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, matz@suse.de, joao.moreira@intel.com,
        samitolvanen@google.com
Subject: Re: [RFC][PATCH 02/17] x86/cpu: Clean up SRSO return thunk mess
Message-ID: <20230812112057.GA749618@hirez.programming.kicks-ass.net>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.543939260@infradead.org>
 <20230810115148.GEZNTPVLBmPL6uz4Af@fat_crate.local>
 <20230810123756.GY212435@hirez.programming.kicks-ass.net>
 <20230811070123.GD220434@hirez.programming.kicks-ass.net>
 <CAKwvOd=UXhDShdPsofrWScxdF-mTNnDTCNYZDP1rAhhKCB7jVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOd=UXhDShdPsofrWScxdF-mTNnDTCNYZDP1rAhhKCB7jVA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 10:00:31AM -0700, Nick Desaulniers wrote:
> On Fri, Aug 11, 2023 at 12:01 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Aug 10, 2023 at 02:37:56PM +0200, Peter Zijlstra wrote:
> >
> > > After this patch things look equivalent to:
> > >
> > > SYM_FUNC_START(foo)
> > >       ...
> > >       ALTERNATIVE "ret; int3"
> > >                   "jmp __x86_return_thunk", X86_FEATURE_RETHUNK
> > >                   "jmp srso_return_thunk, X86_FEATURE_SRSO
> > >                   "jmp srsi_alias_return_thunk", X86_FEATURE_SRSO_ALIAS
> > > SYM_FUNC_END(foo)
> > >
> > > SYM_CODE_START(srso_return_thunk)
> > >       UNWIND_HINT_FUNC
> > >       ANNOTATE_NOENDBR
> > >       call srso_safe_ret;
> > >       ud2
> > > SYM_CODE_END(srso_return_thunk)
> > >
> > > SYM_CODE_START(srso_alias_return_thunk)
> > >       UNWIND_HINT_FUNC
> > >       ANNOTATE_NOENDBR
> > >       call srso_alias_safe_ret;
> > >       ud2
> > > SYM_CODE_END(srso_alias_return_thunk)
> > >
> >
> > So it looks like the compilers are still not emitting int3 after jmp,
> > even with the SLS options enabled :/
> >
> > This means the tail end of functions compiled with:
> >
> >   -mharden-sls=all -mfunction-return=thunk-extern
> >
> > Is still a regular: jmp __x86_return_thunk, no trailing trap.
> >
> >   https://godbolt.org/z/Ecqv76YbE
> 
> I don't have time to finish this today, but
> https://reviews.llvm.org/D157734 should do what you're looking for, I
> think.

Hmm, so your wording seems to imply regular SLS would already emit INT3
after jump, but I'm not seeing that in clang-16 output. Should I upgrade
my llvm?

[[edit]] Oooh, now I see, regular SLS would emit RET; INT3, but what I'm
alluding to was that sls=all should also emit INT3 after every JMP due
to AMD BTC. This is an SLS option that seems to have gone missing in
both compilers for a long while.


And yesterday I only quickly looked at bigger gcc output and not clang.
But when I look at clang-16 output I see things like:

1053:       2e e8 00 00 00 00       cs call 1059 <yield_to+0xe9>    1055: R_X86_64_PLT32    __x86_indirect_thunk_r11-0x4
1059:       84 c0                   test   %al,%al
105b:       74 1c                   je     1079 <yield_to+0x109>
105d:       eb 6e                   jmp    10cd <yield_to+0x15d>

No INT3

105f:       41 bc 01 00 00 00       mov    $0x1,%r12d
1065:       80 7c 24 04 00          cmpb   $0x0,0x4(%rsp)
106a:       74 0d                   je     1079 <yield_to+0x109>
106c:       4d 39 fe                cmp    %r15,%r14
106f:       74 08                   je     1079 <yield_to+0x109>
1071:       4c 89 ff                mov    %r15,%rdi
1074:       e8 00 00 00 00          call   1079 <yield_to+0x109>    1075: R_X86_64_PLT32    resched_curr-0x4
1079:       4d 39 fe                cmp    %r15,%r14
107c:       74 08                   je     1086 <yield_to+0x116>
107e:       4c 89 ff                mov    %r15,%rdi
1081:       e8 00 00 00 00          call   1086 <yield_to+0x116>    1082: R_X86_64_PLT32    _raw_spin_unlock-0x4
1086:       4c 89 f7                mov    %r14,%rdi
1089:       e8 00 00 00 00          call   108e <yield_to+0x11e>    108a: R_X86_64_PLT32    _raw_spin_unlock-0x4
108e:       f7 c3 00 02 00 00       test   $0x200,%ebx
1094:       74 06                   je     109c <yield_to+0x12c>
1096:       ff 15 00 00 00 00       call   *0x0(%rip)        # 109c <yield_to+0x12c>        1098: R_X86_64_PC32     pv_ops+0xfc
109c:       45 85 e4                test   %r12d,%r12d
109f:       7e 05                   jle    10a6 <yield_to+0x136>
10a1:       e8 00 00 00 00          call   10a6 <yield_to+0x136>    10a2: R_X86_64_PLT32    schedule-0x4
10a6:       44 89 e0                mov    %r12d,%eax
10a9:       48 83 c4 08             add    $0x8,%rsp
10ad:       5b                      pop    %rbx
10ae:       41 5c                   pop    %r12
10b0:       41 5d                   pop    %r13
10b2:       41 5e                   pop    %r14
10b4:       41 5f                   pop    %r15
10b6:       5d                      pop    %rbp
10b7:       2e e9 00 00 00 00       cs jmp 10bd <yield_to+0x14d>    10b9: R_X86_64_PLT32    __x86_return_thunk-0x4

CS padding!!

10bd:       41 bc fd ff ff ff       mov    $0xfffffffd,%r12d
10c3:       f7 c3 00 02 00 00       test   $0x200,%ebx


So since you (surprisingly!) CS pad the return thunk, I *could* pull it
off there, 6 bytes is enough space to write: 'CALL foo; INT3'

But really SLS *should* put INT3 after every JMP instruction -- of
course including the return thunk one.

