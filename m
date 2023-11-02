Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB89C7DEAB7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 03:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348263AbjKBCdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 22:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348035AbjKBCdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 22:33:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5C711B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 19:33:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83546C433C8;
        Thu,  2 Nov 2023 02:32:59 +0000 (UTC)
Date:   Wed, 1 Nov 2023 22:32:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: Re: [PATCH] tracing: Have trace_event_file have ref counters
Message-ID: <20231101223254.7ec2a1e2@gandalf.local.home>
In-Reply-To: <20231102111433.5330cbb98cf204b4063924c0@kernel.org>
References: <20231031122453.7a48b923@gandalf.local.home>
        <20231102111433.5330cbb98cf204b4063924c0@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2023 11:14:33 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > 
> > What happens here is that the kprobe event creates a trace_event_file
> > "file" descriptor that represents the file in tracefs to the event. It
> > maintains state of the event (is it enabled for the given instance?).
> > Opening the "enable" file gets a reference to the event "file" descriptor
> > via the open file descriptor. When the kprobe event is deleted, the file is
> > also deleted from the tracefs system which also frees the event "file"
> > descriptor.  
> 
> Ouch! I thought the file descriptor has been hold by the opened process.

Well, the struct *filp is, but not the filp->private that points to the
struct trace_event_file *file.

> 
> > 
> > But as the tracefs file is still opened by user space, it will not be
> > totally removed until the final dput() is called on it. But this is not
> > true with the event "file" descriptor that is already freed. If the user
> > does a write to or simply closes the file descriptor it will reference the
> > event "file" descriptor that was just freed, causing a use-after-free bug.
> > 
> > To solve this, add a ref count to the event "file" descriptor as well as a
> > new flag called "FREED". The "file" will not be freed until the last
> > reference is released. But the FREE flag will be set when the event is
> > removed to prevent any more modifications to that event from happening,
> > even if there's still a reference to the event "file" descriptor.
> > 
> > Link: https://lore.kernel.org/linux-trace-kernel/20231031000031.1e705592@gandalf.local.home/
> >   
> 
> Looks good to me.
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> BTW, can we add some tracefs selftests to ftracetest or independent test?

Yes, I was thinking about this, but that will have to wait till after this
gets in mainline. I'm already way behind schedule.

Thanks,

-- Steve
