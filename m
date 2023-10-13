Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1B97C8748
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjJMOAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjJMOA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:00:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867AA95
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:00:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3004EC433C7;
        Fri, 13 Oct 2023 14:00:25 +0000 (UTC)
Date:   Fri, 13 Oct 2023 10:00:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Artem Savkov <asavkov@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC PATCH bpf-next] bpf: change syscall_nr type to int in
 struct syscall_tp_t
Message-ID: <20231013100023.5b0943ec@rorschach.local.home>
In-Reply-To: <ZSjdPqQiPdqa-UTs@wtfbox.lan>
References: <20231005123413.GA488417@alecto.usersys.redhat.com>
        <20231012114550.152846-1-asavkov@redhat.com>
        <20231012094444.0967fa79@gandalf.local.home>
        <CAEf4BzZKWkJjOjw8x_eL_hsU-QzFuSzd5bkBH2EHtirN2hnEgA@mail.gmail.com>
        <ZSjdPqQiPdqa-UTs@wtfbox.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Fri, 13 Oct 2023 08:01:34 +0200
Artem Savkov <asavkov@redhat.com> wrote:

> > But looking at [0] and briefly reading some of the discussions you,
> > Steven, had. I'm just wondering if it would be best to avoid
> > increasing struct trace_entry altogether? It seems like preempt_count
> > is actually a 4-bit field in trace context, so it doesn't seem like we
> > really need to allocate an entire byte for both preempt_count and
> > preempt_lazy_count. Why can't we just combine them and not waste 8
> > extra bytes for each trace event in a ring buffer?
> > 
> >   [0] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=b1773eac3f29cbdcdfd16e0339f1a164066e9f71  
> 
> I agree that avoiding increase in struct trace_entry size would be very
> desirable, but I have no knowledge whether rt developers had reasons to
> do it like this.
> 
> Nevertheless I think the issue with verifier running against a wrong
> struct still needs to be addressed.

Correct. My Ack is based on the current way things are done upstream.
It was just that linux-rt showed the issue, where the code was not as
robust as it should have been. To me this was a correctness issue, not
an issue that had to do with how things are done in linux-rt.

As for the changes in linux-rt, they are not upstream yet. I'll have my
comments on that code when that happens.

-- Steve
