Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F687B7651
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 03:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239772AbjJDBhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 21:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjJDBho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 21:37:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF54AB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 18:37:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBC9C433C7;
        Wed,  4 Oct 2023 01:37:39 +0000 (UTC)
Date:   Tue, 3 Oct 2023 21:38:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Artem Savkov <asavkov@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC PATCH] tracing: change syscall number type in struct
 syscall_trace_*
Message-ID: <20231003213844.1de0c138@gandalf.local.home>
In-Reply-To: <20231002135242.247536-1-asavkov@redhat.com>
References: <20231002135242.247536-1-asavkov@redhat.com>
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

On Mon,  2 Oct 2023 15:52:42 +0200
Artem Savkov <asavkov@redhat.com> wrote:

> linux-rt-devel tree contains a patch that adds an extra member to struct
> trace_entry. This causes the offset of args field in struct
> trace_event_raw_sys_enter be different from the one in struct
> syscall_trace_enter:

This patch looks like it's fixing the symptom and not the issue. No code
should rely on the two event structures to be related. That's an unwanted
coupling, that will likely cause issues down the road (like the RT patch
you mentioned).


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

The above appears to be pointing to the real bug. The "is calculated based
on the former struct while off on the latter" Why are the two being used
together? They are supposed to be *unrelated*!


> 
>   10488         if (is_tracepoint || is_syscall_tp) {
>   10489                 int off = trace_event_get_offsets(event->tp_event);

So basically this is clumping together the raw_syscalls with the syscalls
events as if they are the same. But the are not. They are created
differently. It's basically like using one structure to get the offsets of
another structure. That would be a bug anyplace else in the kernel. Sounds
like it's a bug here too.

I think the issue is with this code, not the tracing code.

We could expose the struct syscall_trace_enter and syscall_trace_exit if
the offsets to those are needed.

-- Steve


>   10490
>   10491                 if (prog->aux->max_ctx_offset > off)
>   10492                         return -EACCES;
>   10493         }
> 
> This patch changes the type of nr member in syscall_trace_* structs to
> be long so that "args" offset is equal to that in struct
> trace_event_raw_sys_enter.
> 

