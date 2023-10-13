Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0B97C7D61
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjJMGCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjJMGCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:02:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B55CB8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 23:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697176903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uspCcCfbm2YmR5dZLZTo0epZzk54L6kfVVGxjNItAZs=;
        b=H1u6cRPXNGp1bzeyEQXh6MNW+bu/DY+e4cSNAd8jLh60QEFVQnc+o/2Hw6WFuqXJr3FqJ2
        hmeFmJbZUHunvkyCm8jpqBsW2lgz/tRfwRal7SdP7u0ElUaHieYAStn1fmmRd4PVbyWH37
        LJbATKFm52wT7tN1m0B1TRBsLvMzmWg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-QZR-wY5EOF-cukCasi9NeQ-1; Fri, 13 Oct 2023 02:01:39 -0400
X-MC-Unique: QZR-wY5EOF-cukCasi9NeQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38EC73813BCD;
        Fri, 13 Oct 2023 06:01:38 +0000 (UTC)
Received: from wtfbox.lan (unknown [10.45.224.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 620D81C060DF;
        Fri, 13 Oct 2023 06:01:36 +0000 (UTC)
Date:   Fri, 13 Oct 2023 08:01:34 +0200
From:   Artem Savkov <asavkov@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC PATCH bpf-next] bpf: change syscall_nr type to int in
 struct syscall_tp_t
Message-ID: <ZSjdPqQiPdqa-UTs@wtfbox.lan>
References: <20231005123413.GA488417@alecto.usersys.redhat.com>
 <20231012114550.152846-1-asavkov@redhat.com>
 <20231012094444.0967fa79@gandalf.local.home>
 <CAEf4BzZKWkJjOjw8x_eL_hsU-QzFuSzd5bkBH2EHtirN2hnEgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZKWkJjOjw8x_eL_hsU-QzFuSzd5bkBH2EHtirN2hnEgA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 04:32:51PM -0700, Andrii Nakryiko wrote:
> On Thu, Oct 12, 2023 at 6:43 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Thu, 12 Oct 2023 13:45:50 +0200
> > Artem Savkov <asavkov@redhat.com> wrote:
> >
> > > linux-rt-devel tree contains a patch (b1773eac3f29c ("sched: Add support
> > > for lazy preemption")) that adds an extra member to struct trace_entry.
> > > This causes the offset of args field in struct trace_event_raw_sys_enter
> > > be different from the one in struct syscall_trace_enter:
> > >
> > > struct trace_event_raw_sys_enter {
> > >         struct trace_entry         ent;                  /*     0    12 */
> > >
> > >         /* XXX last struct has 3 bytes of padding */
> > >         /* XXX 4 bytes hole, try to pack */
> > >
> > >         long int                   id;                   /*    16     8 */
> > >         long unsigned int          args[6];              /*    24    48 */
> > >         /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
> > >         char                       __data[];             /*    72     0 */
> > >
> > >         /* size: 72, cachelines: 2, members: 4 */
> > >         /* sum members: 68, holes: 1, sum holes: 4 */
> > >         /* paddings: 1, sum paddings: 3 */
> > >         /* last cacheline: 8 bytes */
> > > };
> > >
> > > struct syscall_trace_enter {
> > >         struct trace_entry         ent;                  /*     0    12 */
> > >
> > >         /* XXX last struct has 3 bytes of padding */
> > >
> > >         int                        nr;                   /*    12     4 */
> > >         long unsigned int          args[];               /*    16     0 */
> > >
> > >         /* size: 16, cachelines: 1, members: 3 */
> > >         /* paddings: 1, sum paddings: 3 */
> > >         /* last cacheline: 16 bytes */
> > > };
> > >
> > > This, in turn, causes perf_event_set_bpf_prog() fail while running bpf
> > > test_profiler testcase because max_ctx_offset is calculated based on the
> > > former struct, while off on the latter:
> > >
> > >   10488         if (is_tracepoint || is_syscall_tp) {
> > >   10489                 int off = trace_event_get_offsets(event->tp_event);
> > >   10490
> > >   10491                 if (prog->aux->max_ctx_offset > off)
> > >   10492                         return -EACCES;
> > >   10493         }
> > >
> > > What bpf program is actually getting is a pointer to struct
> > > syscall_tp_t, defined in kernel/trace/trace_syscalls.c. This patch fixes
> > > the problem by aligning struct syscall_tp_t with with struct
> > > syscall_trace_(enter|exit) and changing the tests to use these structs
> > > to dereference context.
> > >
> > > Signed-off-by: Artem Savkov <asavkov@redhat.com>
> >
> 
> I think these changes make sense regardless, can you please resend the
> patch without RFC tag so that our CI can run tests for it?

Ok, didn't know it was set up like that.

> > Thanks for doing a proper fix.
> >
> > Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> But looking at [0] and briefly reading some of the discussions you,
> Steven, had. I'm just wondering if it would be best to avoid
> increasing struct trace_entry altogether? It seems like preempt_count
> is actually a 4-bit field in trace context, so it doesn't seem like we
> really need to allocate an entire byte for both preempt_count and
> preempt_lazy_count. Why can't we just combine them and not waste 8
> extra bytes for each trace event in a ring buffer?
> 
>   [0] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=b1773eac3f29cbdcdfd16e0339f1a164066e9f71

I agree that avoiding increase in struct trace_entry size would be very
desirable, but I have no knowledge whether rt developers had reasons to
do it like this.

Nevertheless I think the issue with verifier running against a wrong
struct still needs to be addressed.

-- 
Regards,
  Artem

