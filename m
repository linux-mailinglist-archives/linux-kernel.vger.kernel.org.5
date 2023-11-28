Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49357FC1D3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346847AbjK1PfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346839AbjK1PfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:35:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB9710CA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:35:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84687C433C7;
        Tue, 28 Nov 2023 15:35:22 +0000 (UTC)
Date:   Tue, 28 Nov 2023 10:35:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        dmaluka@google.com, Sean Paul <seanpaul@chromium.org>,
        Arun Easi <aeasi@marvell.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [RFC][PATCH] tracing: Allow creating instances with specified
 system events
Message-ID: <20231128103544.2ef0d584@gandalf.local.home>
In-Reply-To: <20231129001738.5041154000c4c1df58f6c7a1@kernel.org>
References: <20231127174108.3c331c9c@gandalf.local.home>
        <20231129001738.5041154000c4c1df58f6c7a1@kernel.org>
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

On Wed, 29 Nov 2023 00:17:38 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi Steve,
> 
> On Mon, 27 Nov 2023 17:41:08 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > A trace instance may only need to enable specific events. As the eventfs
> > directory of an instance currently creates all events which adds overhead,
> > allow internal instances to be created with just the events in systems
> > that they care about. This currently only deals with systems and not
> > individual events, but this should bring down the overhead of creating
> > instances for specific use cases quite bit.  
> 
> This sounds good, but can the eventfs reduce such overhead because
> if the user doesn't touch the actual event, the event dentry will
> be released soon?

Yes, but this also removes the creation of the meta data behind it. Which
has a descriptor for every event. And since there are over a thousand
events, this is still quite a bit of savings. It also removes the
eventfs_inode that represents each directory.

> > Note, this may also be useful for creating instances in the eventfs, but
> > I'm not sure how to do this there. I could add a deliminator:
> > 
> >   mkdir /sys/kernel/tracing/instances/foo::sched,timer  
> 
> Can we limit this after making an instance? In that case, we can use
> rmdir to remove unused "systems" directories. Or, maybe we can create
> it afterwards with mkdir or use comand to a pseudo file.
> 
> echo sched:* timer:* > instances/foo/available_events

That, or I even thought of allowing rmdir on event systems, and even mkdir.

 # cd instance/foo/events
 # rmdir *
 # mkdir sched timer

-- Steve
