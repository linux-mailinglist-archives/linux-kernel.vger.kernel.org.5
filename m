Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EC27C6F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378940AbjJLNn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347290AbjJLNnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:43:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DE991
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:43:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A10AC433C7;
        Thu, 12 Oct 2023 13:43:21 +0000 (UTC)
Date:   Thu, 12 Oct 2023 09:44:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Artem Savkov <asavkov@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC PATCH bpf-next] bpf: change syscall_nr type to int in
 struct syscall_tp_t
Message-ID: <20231012094444.0967fa79@gandalf.local.home>
In-Reply-To: <20231012114550.152846-1-asavkov@redhat.com>
References: <20231005123413.GA488417@alecto.usersys.redhat.com>
        <20231012114550.152846-1-asavkov@redhat.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 13:45:50 +0200
Artem Savkov <asavkov@redhat.com> wrote:

> linux-rt-devel tree contains a patch (b1773eac3f29c ("sched: Add support
> for lazy preemption")) that adds an extra member to struct trace_entry.
> This causes the offset of args field in struct trace_event_raw_sys_enter
> be different from the one in struct syscall_trace_enter:
> 
> struct trace_event_raw_sys_enter {
>         struct trace_entry         ent;                  /*     0    12 */
> 
>         /* XXX last struct has 3 bytes of padding */
>         /* XXX 4 bytes hole, try to pack */
> 
>         long int                   id;                   /*    16     8 */
>         long unsigned int          args[6];              /*    24    48 */
>         /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
>         char                       __data[];             /*    72     0 */
> 
>         /* size: 72, cachelines: 2, members: 4 */
>         /* sum members: 68, holes: 1, sum holes: 4 */
>         /* paddings: 1, sum paddings: 3 */
>         /* last cacheline: 8 bytes */
> };
> 
> struct syscall_trace_enter {
>         struct trace_entry         ent;                  /*     0    12 */
> 
>         /* XXX last struct has 3 bytes of padding */
> 
>         int                        nr;                   /*    12     4 */
>         long unsigned int          args[];               /*    16     0 */
> 
>         /* size: 16, cachelines: 1, members: 3 */
>         /* paddings: 1, sum paddings: 3 */
>         /* last cacheline: 16 bytes */
> };
> 
> This, in turn, causes perf_event_set_bpf_prog() fail while running bpf
> test_profiler testcase because max_ctx_offset is calculated based on the
> former struct, while off on the latter:
> 
>   10488         if (is_tracepoint || is_syscall_tp) {
>   10489                 int off = trace_event_get_offsets(event->tp_event);
>   10490
>   10491                 if (prog->aux->max_ctx_offset > off)
>   10492                         return -EACCES;
>   10493         }
> 
> What bpf program is actually getting is a pointer to struct
> syscall_tp_t, defined in kernel/trace/trace_syscalls.c. This patch fixes
> the problem by aligning struct syscall_tp_t with with struct
> syscall_trace_(enter|exit) and changing the tests to use these structs
> to dereference context.
> 
> Signed-off-by: Artem Savkov <asavkov@redhat.com>

Thanks for doing a proper fix.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
