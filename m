Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5F280BC06
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 16:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjLJPdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 10:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjLJPdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 10:33:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C096193
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 07:33:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4212C433C8;
        Sun, 10 Dec 2023 15:33:37 +0000 (UTC)
Date:   Sun, 10 Dec 2023 10:34:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] tracing: Have large events show up as '[LINE TOO BIG]'
 instead of nothing
Message-ID: <20231210103415.5afd45ca@gandalf.local.home>
In-Reply-To: <18d6a5e5-f7a5-4a86-aa0b-eec38652c0d5@efficios.com>
References: <20231209171058.78c1a026@gandalf.local.home>
        <18d6a5e5-f7a5-4a86-aa0b-eec38652c0d5@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2023 09:11:40 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2023-12-09 17:10, Steven Rostedt wrote:
> [...]
> >              <...>-852     [001] .....   121.550551: tracing_mark_write[LINE TOO BIG]
> >              <...>-852     [001] .....   121.550581: tracing_mark_write: 78901234  
> 
> Failing to print an entire message because it does not fit in the
> buffer size is rather inconvenient.

Yes I agree, and luckily it hasn't been called out as an issue. Note, I hit
this because I extended the trace_marker buffer before increasing the
trace_seq size. Otherwise, the trace_marker just breaks it up. This can now
only be triggered by internal changes.

> 
> It would be better to print the partial line, and end the line with
> a <TRUNCATED LINE> tag.

Agreed, but I don't have time to do that (I already spent way too much time
on this than I had allocated). I decided to just do what the trace_pipe
currently does, and leave "print partial line" to another day when I can
allocate time on this.

Hmm, this could be added to the "TODO" list that was talked about in
ksummit-discuss.

-- Steve

