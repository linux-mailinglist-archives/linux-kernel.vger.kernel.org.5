Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811BA76B82D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjHAPCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjHAPCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:02:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105ED122;
        Tue,  1 Aug 2023 08:02:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99B1D615E1;
        Tue,  1 Aug 2023 15:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05A5C433C7;
        Tue,  1 Aug 2023 15:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690902153;
        bh=jayMFZbmXA6hS6EzhJH2WACDTI/dOjEKx7LKo+xz+4M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bSabkIv1MkB9X3AJgbDkNm2w6TETGIGeja/6rQw9T3cv1A5Waca49sHs43mrgVfST
         tP/DeXWfPNdr9e+OjZwcfyv3j/Msd/uRQFsXwbHV1nQtn+p3FAgDEs6W+QfqPPqpwz
         wQ3zTm80H57joCtUGQEdDtm8K1UhDp1q56XGDXCEV5vuEB7KBGEtQybnEXUw9+sRJb
         crpFgPhK54OR1re85olT9cPUVRYPL/YJvr/6ngqmz5GBCEU7vMHyeI8knQuEEdAh34
         qSgPJqrItCplfek0vkeBBBnhrENgyZ6YBTYvVrJGMHJmjkSSmAQZ/I8F8J8mG6KL3F
         bTopSM1/3AyTA==
Date:   Wed, 2 Aug 2023 00:02:28 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a
 struct/union
Message-Id: <20230802000228.158f1bd605e497351611739e@kernel.org>
In-Reply-To: <CAADnVQLaFpd2OhqP7W3xWB1b9P2GAKgrVQU1FU2yeNYKbCkT=Q@mail.gmail.com>
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
        <169078863449.173706.2322042687021909241.stgit@devnote2>
        <CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
        <20230801085724.9bb07d2c82e5b6c6a6606848@kernel.org>
        <CAADnVQLaFpd2OhqP7W3xWB1b9P2GAKgrVQU1FU2yeNYKbCkT=Q@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 17:29:49 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Mon, Jul 31, 2023 at 4:57 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Mon, 31 Jul 2023 14:59:47 -0700
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >
> > > On Mon, Jul 31, 2023 at 12:30 AM Masami Hiramatsu (Google)
> > > <mhiramat@kernel.org> wrote:
> > > >
> > > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > >
> > > > Add btf_find_struct_member() API to search a member of a given data structure
> > > > or union from the member's name.
> > > >
> > > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > > > ---
> > > >  Changes in v3:
> > > >   - Remove simple input check.
> > > >   - Fix unneeded IS_ERR_OR_NULL() check for btf_type_by_id().
> > > >   - Move the code next to btf_get_func_param().
> > > >   - Use for_each_member() macro instead of for-loop.
> > > >   - Use btf_type_skip_modifiers() instead of btf_type_by_id().
> > > >  Changes in v4:
> > > >   - Use a stack for searching in anonymous members instead of nested call.
> > > > ---
> > > >  include/linux/btf.h |    3 +++
> > > >  kernel/bpf/btf.c    |   40 ++++++++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 43 insertions(+)
> > > >
> > > > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > > > index 20e3a07eef8f..4b10d57ceee0 100644
> > > > --- a/include/linux/btf.h
> > > > +++ b/include/linux/btf.h
> > > > @@ -226,6 +226,9 @@ const struct btf_type *btf_find_func_proto(const char *func_name,
> > > >                                            struct btf **btf_p);
> > > >  const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
> > > >                                            s32 *nr);
> > > > +const struct btf_member *btf_find_struct_member(struct btf *btf,
> > > > +                                               const struct btf_type *type,
> > > > +                                               const char *member_name);
> > > >
> > > >  #define for_each_member(i, struct_type, member)                        \
> > > >         for (i = 0, member = btf_type_member(struct_type);      \
> > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > index f7b25c615269..8d81a4ffa67b 100644
> > > > --- a/kernel/bpf/btf.c
> > > > +++ b/kernel/bpf/btf.c
> > > > @@ -958,6 +958,46 @@ const struct btf_param *btf_get_func_param(const struct btf_type *func_proto, s3
> > > >                 return NULL;
> > > >  }
> > > >
> > > > +#define BTF_ANON_STACK_MAX     16
> > > > +
> > > > +/*
> > > > + * Find a member of data structure/union by name and return it.
> > > > + * Return NULL if not found, or -EINVAL if parameter is invalid.
> > > > + */
> > > > +const struct btf_member *btf_find_struct_member(struct btf *btf,
> > > > +                                               const struct btf_type *type,
> > > > +                                               const char *member_name)
> > > > +{
> > > > +       const struct btf_type *anon_stack[BTF_ANON_STACK_MAX];
> > > > +       const struct btf_member *member;
> > > > +       const char *name;
> > > > +       int i, top = 0;
> > > > +
> > > > +retry:
> > > > +       if (!btf_type_is_struct(type))
> > > > +               return ERR_PTR(-EINVAL);
> > > > +
> > > > +       for_each_member(i, type, member) {
> > > > +               if (!member->name_off) {
> > > > +                       /* Anonymous union/struct: push it for later use */
> > > > +                       type = btf_type_skip_modifiers(btf, member->type, NULL);
> > > > +                       if (type && top < BTF_ANON_STACK_MAX)
> > > > +                               anon_stack[top++] = type;
> > > > +               } else {
> > > > +                       name = btf_name_by_offset(btf, member->name_off);
> > > > +                       if (name && !strcmp(member_name, name))
> > > > +                               return member;
> > > > +               }
> > > > +       }
> > > > +       if (top > 0) {
> > > > +               /* Pop from the anonymous stack and retry */
> > > > +               type = anon_stack[--top];
> > > > +               goto retry;
> > > > +       }
> > >
> > > Looks good, but I don't see a test case for this.
> > > The logic is a bit tricky. I'd like to have a selftest that covers it.
> >
> > Thanks, and I agree about selftest.
> >
> > >
> > > You probably need to drop Alan's reviewed-by, since the patch is quite
> > > different from the time he reviewed it.
> >
> > OK. BTW, I found a problem on this function. I guess the member->offset will
> > be the offset from the intermediate anonymous union, it is usually 0, but
> > I need the offset from the given structure. Thus the interface design must
> > be changed. Passing a 'u32 *offset' and set the correct offset in it. If
> > it has nested intermediate anonymous unions, that offset must also be pushed.
> 
> With all that piling up have you considering reusing btf_struct_walk() ?
> It's doing the opposite off -> btf_id while you need name -> btf_id.
> But it will give an idea of overall complexity if you want to solve it
> for nested arrays and struct/union.

No, it seems a bit different. (and it may not return the name correctly for
anonymous struct/union) Of course it seems an interesting work. What I found
is returning btf_member is not enough because btf_member in the nested union
will have the offset from the nested structure. I have to accumulate the
offset. It is easy to fix (just stacking (tid,offset) instead of type*) :)

> 
> > >
> > > Assuming that is addressed. How do we merge the series?
> > > The first 3 patches have serious conflicts with bpf trees.
> > >
> > > Maybe send the first 3 with extra selftest for above recursion
> > > targeting bpf-next then we can have a merge commit that Steven can pull
> > > into tracing?
> > >
> > > Or if we can have acks for patches 4-9 we can pull the whole set into bpf-next.
> >
> > That's a good question. I don't like splitting the whole series in 2 -next
> > branches. So I can send this to the bpf-next.
> 
> Works for me.

Or, yet another option is keeping new btf APIs in trace/trace_probe.c in this
series, and move all of them to btf.c in the next series.
This will not make any merge problem between trees, but just needs 2 series
on different releases. (since unless the first one is merged, we cannot send
the second one)

> 
> > I need to work on another series(*) on fprobes which will not have conflicts with
> > this series. (*Replacing pt_regs with ftrace_regs on fprobe, which will take longer
> > time, and need to adjust with eBPF).
> 
> ftrace_regs?
> Ouch. For bpf we rely on pt_regs being an argument.

Yeah, that's a problem.

> fprobe should be 100% compatible replacement of kprobe-at-the-func-start.

No, fprobe is not such feature. It must provide more generic interface because
it is a probe version of ftrace, not kprobe.

> If it diverges from that it's a big issue for bpf.
> We'd have to remove all of fprobe usage.
> I could be missing something, of course.

Yes, so that's the discussion point. At first, I will disable fprobe on BPF
if ftrace_regs is not compatible with pt_regs, but eventually it should be
handled to support arm64. I believe BPF can do it since ftrace can do.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
