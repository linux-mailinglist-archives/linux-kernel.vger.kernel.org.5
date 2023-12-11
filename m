Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6B580D5C8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345143AbjLKS1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjLKS1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:27:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96F3E8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 10:27:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9ADBC433C8;
        Mon, 11 Dec 2023 18:27:57 +0000 (UTC)
Date:   Mon, 11 Dec 2023 13:28:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] trace_seq: Increase the buffer size to almost two pages
Message-ID: <20231211132837.24488ec1@gandalf.local.home>
In-Reply-To: <20231211214627.cff4ecfead14029ef22cd3ef@kernel.org>
References: <20231209175220.19867af4@gandalf.local.home>
        <20231211214627.cff4ecfead14029ef22cd3ef@kernel.org>
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

On Mon, 11 Dec 2023 21:46:27 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > 
> > By increasing the trace_seq buffer to almost two pages, it can now print
> > out the first line.
> > 
> > This also subtracts the rest of the trace_seq fields from the buffer, so
> > that the entire trace_seq is now PAGE_SIZE aligned.  
> 
> Ok, but I just a bit concern about the memory consumption.
> Since this is very specific case, can we make it configurable later?

I was concerned about this too, but it looks like it's allocated and later
freed in every location except for a couple of instances.

One is "tracepoint_print_iter" which is used to pipe tracepoints to printk.
I think we can possibly make that allocated too.

The other is in ftrace_dump, which I don't think we can easily allocate
that. Although, we could have it allocated at boot up if
ftrace_dump_on_oops() is enabled.

Another KTODO?

> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 

Thanks!

-- Steve
