Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8034E7BA225
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjJEPQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjJEPOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:14:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F764CC9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696516564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+O64Js8IxZtTR27yFO6KKwoMlU4zaA+NA8IDEiNEsMA=;
        b=WE0QDp4OkQrcFbixAbDMchgUWDU+1DTZUfdtVs7y9wj/y0v8aQ558h26wWfeU8gxeY08KG
        rtq6i8u8rAvMhcO3F1i8Gd/iGYva4Ls01LFFFIAJhotbBpOxyYzq4kJ4IG2hUaHGPfpnBc
        1gkoB+iiDlGGOBFN2Hir/G+C/1tzF1U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-IQ-JXcVRMOuc1JjV0SXWSQ-1; Thu, 05 Oct 2023 08:34:17 -0400
X-MC-Unique: IQ-JXcVRMOuc1JjV0SXWSQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30E221E441DB;
        Thu,  5 Oct 2023 12:34:17 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 63A55140E953;
        Thu,  5 Oct 2023 12:34:15 +0000 (UTC)
Date:   Thu, 5 Oct 2023 14:34:13 +0200
From:   Artem Savkov <asavkov@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC PATCH] tracing: change syscall number type in struct
 syscall_trace_*
Message-ID: <20231005123413.GA488417@alecto.usersys.redhat.com>
References: <20231002135242.247536-1-asavkov@redhat.com>
 <20231003213844.1de0c138@gandalf.local.home>
 <20231004125547.GA409268@alecto.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231004125547.GA409268@alecto.usersys.redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 02:55:47PM +0200, Artem Savkov wrote:
> On Tue, Oct 03, 2023 at 09:38:44PM -0400, Steven Rostedt wrote:
> > On Mon,  2 Oct 2023 15:52:42 +0200
> > Artem Savkov <asavkov@redhat.com> wrote:
> > 
> > > linux-rt-devel tree contains a patch that adds an extra member to struct
> > > trace_entry. This causes the offset of args field in struct
> > > trace_event_raw_sys_enter be different from the one in struct
> > > syscall_trace_enter:
> > 
> > This patch looks like it's fixing the symptom and not the issue. No code
> > should rely on the two event structures to be related. That's an unwanted
> > coupling, that will likely cause issues down the road (like the RT patch
> > you mentioned).
> 
> I agree, but I didn't see a better solution and that was my way of
> starting conversation, thus the RFC.
> 
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
> > 
> > The above appears to be pointing to the real bug. The "is calculated based
> > on the former struct while off on the latter" Why are the two being used
> > together? They are supposed to be *unrelated*!
> > 
> > 
> > > 
> > >   10488         if (is_tracepoint || is_syscall_tp) {
> > >   10489                 int off = trace_event_get_offsets(event->tp_event);
> > 
> > So basically this is clumping together the raw_syscalls with the syscalls
> > events as if they are the same. But the are not. They are created
> > differently. It's basically like using one structure to get the offsets of
> > another structure. That would be a bug anyplace else in the kernel. Sounds
> > like it's a bug here too.
> > 
> > I think the issue is with this code, not the tracing code.
> > 
> > We could expose the struct syscall_trace_enter and syscall_trace_exit if
> > the offsets to those are needed.
> 
> I don't think we need syscall_trace_* offsets, looks like
> trace_event_get_offsets() should return offset trace_event_raw_sys_enter
> instead. I am still trying to figure out how all of this works together.
> Maybe Alexei or Andrii have more context here.

Turns out it is even more confusing. The tests dereference the context as
struct trace_event_raw_sys_enter so bpf verifier sets max_ctx_offset
based on that, then perf_event_set_bpf_prog() checks this offset against
the one in struct syscall_trace_enter, but what bpf prog really gets is
a pointer to struct syscall_tp_t from kernel/trace/trace_syscalls.c.

I don't know the history behind these decisions, but should the tests
dereference context as struct syscall_trace_enter instead and struct
syscall_tp_t be changed to have syscall_nr as int?

-- 
 Artem

