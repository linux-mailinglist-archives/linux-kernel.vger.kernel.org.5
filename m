Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A227FADB6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjK0Wt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjK0Wt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:49:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD43192
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:50:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B4FC433C7;
        Mon, 27 Nov 2023 22:50:00 +0000 (UTC)
Date:   Mon, 27 Nov 2023 17:50:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        dmaluka@google.com, Sean Paul <seanpaul@chromium.org>,
        Arun Easi <aeasi@marvell.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [RFC][PATCH] tracing: Allow creating instances with specified
 system events
Message-ID: <20231127175021.0c0edc53@gandalf.local.home>
In-Reply-To: <20231127174108.3c331c9c@gandalf.local.home>
References: <20231127174108.3c331c9c@gandalf.local.home>
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

On Mon, 27 Nov 2023 17:41:08 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> A trace instance may only need to enable specific events. As the eventfs
> directory of an instance currently creates all events which adds overhead,
> allow internal instances to be created with just the events in systems
> that they care about. This currently only deals with systems and not
> individual events, but this should bring down the overhead of creating
> instances for specific use cases quite bit.

This change log is not very good. I didn't actually state what was done :-p

Anyway, function trace_array_get_by_name() has an added parameter "systems"
(and I forgot to update its kerneldoc). This parameter is a string of
comma, or space, or commas and spaces deliminators of event system names.
If it's not NULL, then it will only create the event system directories of
those event systems that match the systems parameter.

That is:

 trace_array_get_by_name("qla2xxx", "qla");

Will create an instance called "qla2xxx" and only have "qla" system events
in it.

Note, trace_array_printk() will still write into this instance, and it can
be read via trace-cmd with no problems.

-- Steve


> 
> The qla2xxx instance could just enable the systems it cares about, but that
> should be a separate patch.
> 
> Note that kprobes and synthetic events created after the creation of these
> instances, will be added to these instances, but those that are created
> before the creation of the instance will not be included.
> 
> Note, this may also be useful for creating instances in the eventfs, but
> I'm not sure how to do this there. I could add a deliminator:
> 
>   mkdir /sys/kernel/tracing/instances/foo::sched,timer
> 
> But if a tool already uses "::" as a deliminator, then this will break it.
> I could just have it work if all the events after the deliminator exist.
> 
>   Thoughts?
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  drivers/scsi/qla2xxx/qla_os.c       |  2 +-
>  include/linux/trace.h               |  4 ++--
>  kernel/trace/trace.c                | 22 ++++++++++++--------
>  kernel/trace/trace.h                |  3 ++-
>  kernel/trace/trace_boot.c           |  2 +-
>  kernel/trace/trace_events.c         | 31 ++++++++++++++++++++++++++---
>  samples/ftrace/sample-trace-array.c |  2 +-
>  7 files changed, 49 insertions(+), 17 deletions(-)
