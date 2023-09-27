Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0FD7AFA34
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjI0Fmd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Sep 2023 01:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjI0Flu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:41:50 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658D13C21;
        Tue, 26 Sep 2023 17:50:41 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-79f989480e0so314028139f.3;
        Tue, 26 Sep 2023 17:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695775840; x=1696380640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49VLLRdtyvTR9zrUZJfnDfe9+Yw6E25El1lehQytcPs=;
        b=mM77ZXb39cItcCMSR6Vg7Yska+rnHCXT8ffib6LbemqdyTUEFR96NbIhNjAjJSoD0f
         nMmnxjz0uMzD3GL675fYRPekQwRqWaEc8XULgTWV/09XyrDjYOGdZwRCZvNCa4LFBCXY
         31b9p3S3eUhpAYaK1Ke+cw6hBCtE+ZzDlQO1bbcjyXgvifmluK0FdV86xE/jXXMO17sT
         gz5W6cbAi2tOwy9nvgefLIV1Hlt4lZoOc+BHtDzNMRF9/d1c3acNk+xOAMmH5836NLXa
         VKke8Unq5H6xfyi5JKEHMf6GPx7zTj7o8bT92Yz3IdrZ36KSLz3qoEgkmBkIDfTJ+EUu
         Hpyg==
X-Gm-Message-State: AOJu0YzCI7mC4IfjvxGxd/DTW4vljDoa+o2RFpV7UB7meHTpQdBui3C/
        QvZ9fQMPhR/CI5RT38DkcFVNtcUatz1YwA6aMuo=
X-Google-Smtp-Source: AGHT+IHfqddDhz0mWHuZuybn15arEe1k1jWr2QNcgQQvttagjCshwasBMO6deSBz8icSk4kdZ667J4Lr+E8uYwj9LoA=
X-Received: by 2002:a6b:6806:0:b0:79f:b6b3:9dde with SMTP id
 d6-20020a6b6806000000b0079fb6b39ddemr481066ioc.9.1695775840642; Tue, 26 Sep
 2023 17:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230922234444.3115821-1-namhyung@kernel.org> <CAP-5=fVMdX+vLPNBSe-8arKGvAGcdgHGt7ypEX-J-SZpUi2PGg@mail.gmail.com>
In-Reply-To: <CAP-5=fVMdX+vLPNBSe-8arKGvAGcdgHGt7ypEX-J-SZpUi2PGg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 26 Sep 2023 17:50:29 -0700
Message-ID: <CAM9d7cg0ZoGHJ1hMBFviEg4hSmx0V8nBZyTAP+hkiDzEQUZAKw@mail.gmail.com>
Subject: Re: [PATCH] perf record: Fix BTF type checks in the off-cpu profiling
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Sun, Sep 24, 2023 at 11:03 AM Ian Rogers <irogers@google.com> wrote:
>
> On Fri, Sep 22, 2023 at 4:44 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The BTF func proto for a tracepoint has one more argument than the
> > actual tracepoint function since it has a context argument at the
> > begining.  So it should compare to 5 when the tracepoint has 4
> > arguments.
> >
> >   typedef void (*btf_trace_sched_switch)(void *, bool, struct task_struct *, struct task_struct *, unsigned int);
> >
> > Also, recent change in the perf tool would use a hand-written minimal
> > vmlinux.h to generate BTF in the skeleton.  So it won't have the info
> > of the tracepoint.  Anyway it should use the kernel's vmlinux BTF to
> > check the type in the kernel.
> >
> > Fixes: b36888f71c85 ("perf record: Handle argument change in sched_switch")
> > Cc: Song Liu <song@kernel.org>
> > Cc: Hao Luo <haoluo@google.com>
> > CC: bpf@vger.kernel.org
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks for the review!

>
> > ---
> >  tools/perf/util/bpf_off_cpu.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
> > index 01f70b8e705a..21f4d9ba023d 100644
> > --- a/tools/perf/util/bpf_off_cpu.c
> > +++ b/tools/perf/util/bpf_off_cpu.c
> > @@ -98,7 +98,7 @@ static void off_cpu_finish(void *arg __maybe_unused)
> >  /* v5.18 kernel added prev_state arg, so it needs to check the signature */
> >  static void check_sched_switch_args(void)
> >  {
> > -       const struct btf *btf = bpf_object__btf(skel->obj);
> > +       const struct btf *btf = btf__load_vmlinux_btf();
> >         const struct btf_type *t1, *t2, *t3;
> >         u32 type_id;
> >
> > @@ -116,7 +116,8 @@ static void check_sched_switch_args(void)
> >                 return;
> >
> >         t3 = btf__type_by_id(btf, t2->type);
> > -       if (t3 && btf_is_func_proto(t3) && btf_vlen(t3) == 4) {
> > +       /* btf_trace func proto has one more argument for the context */
> > +       if (t3 && btf_is_func_proto(t3) && btf_vlen(t3) == 5) {
> >                 /* new format: pass prev_state as 4th arg */
>
> nit: does this comment need updating?

No, it's the 4th arg and the sched_switch is called like.

        trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next,
prev_state);

Thanks,
Namhyung
