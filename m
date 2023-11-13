Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48BF7EA18D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 17:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjKMQ4z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Nov 2023 11:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMQ4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 11:56:54 -0500
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A62DD59;
        Mon, 13 Nov 2023 08:56:51 -0800 (PST)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28120aa1c24so3659997a91.0;
        Mon, 13 Nov 2023 08:56:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699894610; x=1700499410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEHZ/5eQXUoMRhSwvlX5OX5XweAz1KoAyJIghiYBjiE=;
        b=r+qao+PI49IFLfZsD4/gvCw/YiU+dhJCc5k2Ki9GVYNCSfTg2exnOZbo5tG/C3Eld0
         HFA2tQsdOLX9BqSUChzpV/2pJCtkGsfAbfacquZAWwEkxSKqvtb0AN1pW2/wHaf+3w8N
         pMuYKKLgVIWCq2y8KUXP8idUalO9yoHipY4CgI2IHiZiNmyPjPfiNAbhOx6S7tR1TFAF
         TPKyhgkWsppfroy8G0XZD+FGgGC0jWyf+H9uOqPE0mIwZoPEKywB4ljLUQ0uV4bDzFZh
         IBHXXMDqLN5k6mlEwxREHDX2JG+ZlmEom5Qgh56p0rJtwhHDFJKQ/kxEy/8XA21skiNP
         0F4g==
X-Gm-Message-State: AOJu0YzN9+j8zJwGN2MCisSMlILFL/Ag1kppj7M4Q64qyQBzLvw9rIzu
        bwtRb9pM3tccB0HahuH/LW1LV+HAfdOb5VdEjsZxrQbl
X-Google-Smtp-Source: AGHT+IFbFLKKjOXzgsGVfi/YLBEppbtwj8HTlsELsg4Y03WjXM4+DTXuf+RMexoUE/2ytNLVO93Ko4MR+fX4P5lQ78E=
X-Received: by 2002:a17:90b:3808:b0:283:2805:7c7a with SMTP id
 mq8-20020a17090b380800b0028328057c7amr4373672pjb.43.1699894610511; Mon, 13
 Nov 2023 08:56:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699487758.git.jpoimboe@kernel.org> <d5def69b0c88bcbe2a85d0e1fd6cfca62b472ed4.1699487758.git.jpoimboe@kernel.org>
 <CAM9d7chZcqR8WCEYtjpP4KzUOeNdJ=kSvae0UrjsO8OgsepjDw@mail.gmail.com> <20231111184908.ym4l6cwzwnkl7e6m@treble>
In-Reply-To: <20231111184908.ym4l6cwzwnkl7e6m@treble>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 13 Nov 2023 08:56:39 -0800
Message-ID: <CAM9d7chgoiwc3ZfQ8SzO7gV0oQOKMK3bJAdxa63Pzgcqo4i7tQ@mail.gmail.com>
Subject: Re: [PATCH RFC 04/10] perf: Introduce deferred user callchains
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Indu Bhagat <indu.bhagat@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 10:49 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On Fri, Nov 10, 2023 at 10:57:58PM -0800, Namhyung Kim wrote:
> > On Wed, Nov 8, 2023 at 4:43 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > > +++ b/kernel/bpf/stackmap.c
> > > @@ -294,8 +294,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
> > >         if (max_depth > sysctl_perf_event_max_stack)
> > >                 max_depth = sysctl_perf_event_max_stack;
> > >
> > > -       trace = get_perf_callchain(regs, kernel, user, max_depth, false);
> > > -
> > > +       trace = get_perf_callchain(regs, kernel, user, max_depth, false, false);
> > >         if (unlikely(!trace))
> > >                 /* couldn't fetch the stack trace */
> > >                 return -EFAULT;
> > > @@ -420,7 +419,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
> > >                 trace = get_callchain_entry_for_task(task, max_depth);
> > >         else
> > >                 trace = get_perf_callchain(regs, kernel, user, max_depth,
> > > -                                          false);
> > > +                                          false, false);
> >
> > Hmm.. BPF is not supported.  Any plans?
>
> I'm not sure whether this feature makes sense for BPF.  If the BPF
> program runs in atomic context then it would have to defer the unwind
> until right before exiting to user space.  But then the program is no
> longer running.

Ok, then BPF gets no user call stacks even with sframes.

>
> > > +++ b/kernel/events/callchain.c
> > > @@ -178,7 +178,7 @@ put_callchain_entry(int rctx)
> > >
> > >  struct perf_callchain_entry *
> > >  get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
> > > -                  u32 max_stack, bool add_mark)
> > > +                  u32 max_stack, bool add_mark, bool defer_user)
> > >  {
> > >         struct perf_callchain_entry *entry;
> > >         struct perf_callchain_entry_ctx ctx;
> > > @@ -207,6 +207,11 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
> > >                         regs = task_pt_regs(current);
> > >                 }
> > >
> > > +               if (defer_user) {
> > > +                       perf_callchain_store_context(&ctx, PERF_CONTEXT_USER_DEFERRED);
> > > +                       goto exit_put;
> >
> > Hmm.. ok.  Then now perf tools need to stitch the call stacks
> > in two (or more?) samples.
>
> Yes.  And it could be more than two samples if there were multiple NMIs
> before returning to user space.  In that case there would be a single
> user sample which needs to be stitched to each of the kernel samples.

Ok, but ...

>
> > > +               }
> > > +
> > >                 if (add_mark)
> > >                         perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
> > >
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index 5e41a3b70bcd..290e06b0071c 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -6751,6 +6751,12 @@ static void perf_pending_irq(struct irq_work *entry)
> > >         struct perf_event *event = container_of(entry, struct perf_event, pending_irq);
> > >         int rctx;
> > >
> > > +       if (!is_software_event(event)) {
> > > +               if (event->pending_unwind)
> > > +                       task_work_add(current, &event->pending_task, TWA_RESUME);
> >
> > I'm not familiar with this code.  Is it possible to the current task
> > is preempted before returning to user space (and run the
> > perf_pending_task_unwind) ?
>
> Yes, the task work (perf_pending_task_unwind) is preemptible.

If the task is preempted, the call stack would be from another
task (if it also has the pending call stacks) and we need to
check which user call stack matches which kernel call stack.
So there's no guarantee we can just use adjacent samples.

>
> > > +static void perf_pending_task_unwind(struct perf_event *event)
> > > +{
> > > +       struct pt_regs *regs = task_pt_regs(current);
> > > +       struct perf_output_handle handle;
> > > +       struct perf_event_header header;
> > > +       struct perf_sample_data data;
> > > +       struct perf_callchain_entry *callchain;
> > > +
> > > +       callchain = kmalloc(sizeof(struct perf_callchain_entry) +
> > > +                           (sizeof(__u64) * event->attr.sample_max_stack) +
> > > +                           (sizeof(__u64) * 1) /* one context */,
> > > +                           GFP_KERNEL);
> >
> > Any chance it can reuse get_perf_callchain() instead of
> > allocating the callchains every time?
>
> I don't think so, because if it gets preempted, the new task might also
> need to do an unwind.  But there's only one task-context callchain per
> CPU.
>
> The allocation is less than ideal.  I could just allocate it on the
> stack, and keep the number of entries bounded to 128 entries or so.

Yeah, probably that's better.

>
> > > +       if (!callchain)
> > > +               return;
> > > +
> > > +       callchain->nr = 0;
> > > +       data.callchain = callchain;
> > > +
> > > +       perf_sample_data_init(&data, 0, event->hw.last_period);
> >
> > It would double count the period for a sample.
> > I guess we want to set the period to 0.
>
> Ok.
>
> > > +
> > > +       data.deferred = true;
> > > +
> > > +       perf_prepare_sample(&data, event, regs);
> >
> > I don't think this would work properly.  Not to mention it duplicates
> > sample data unnecessarily, some data needs special handling to
> > avoid inefficient (full) data copy like for (user) stack, regs and aux.
>
> Yeah.  I tried sending only the sample ID and callchain, but perf tool
> didn't appreciate that ;-) So for the RFC I gave up and did this.

Right, it should have some compatible sample ID header fields.
It's dynamic and depends on the attr but at least it should have a
PID to match callchains.

>
> > Anyway I'm not sure it can support these additional samples for
> > deferred callchains without breaking the existing perf tools.
> > Anyway it doesn't know PERF_CONTEXT_USER_DEFERRED at least.
> > I think this should be controlled by a new feature bit in the
> > perf_event_attr.
> >
> > Then we might add a breaking change to have a special
> > sample record for the deferred callchains and sample ID only.
>
> Sounds like a good idea.  I'll need to study the code to figure out how
> to do that on the perf tool side.  Or would you care to write a patch?

Sure, I'd be happy to write one.

>
> > > -struct perf_callchain_entry *
> > > -perf_callchain(struct perf_event *event, struct pt_regs *regs)
> > > +void perf_callchain(struct perf_sample_data *data, struct perf_event *event,
> > > +                   struct pt_regs *regs)
> > >  {
> > >         bool kernel = !event->attr.exclude_callchain_kernel;
> > >         bool user   = !event->attr.exclude_callchain_user;
> > >         const u32 max_stack = event->attr.sample_max_stack;
> > > -       struct perf_callchain_entry *callchain;
> > > +       bool defer_user = IS_ENABLED(CONFIG_HAVE_PERF_CALLCHAIN_DEFERRED);
> >
> > Is it always enabled depending on the kernel config?
> > It could be controlled by event->attr.something..
>
> Possibly, depending on what y'all think.  Also, fp vs sframe could be an
> attr (though sframe implies deferred).
>
> Thanks for the review!

Thanks for your work,
Namhyung
