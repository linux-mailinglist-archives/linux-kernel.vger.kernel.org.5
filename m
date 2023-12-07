Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5639E80954D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 23:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbjLGW1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 17:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjLGW1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 17:27:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE851BEA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 14:27:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4245C433C8;
        Thu,  7 Dec 2023 22:27:21 +0000 (UTC)
Date:   Thu, 7 Dec 2023 17:27:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ring-buffer: Add offset of events in dump on mismatch
Message-ID: <20231207172752.01ec634c@gandalf.local.home>
In-Reply-To: <866d40a8-4e0c-465c-ab8c-b5d864c1a668@efficios.com>
References: <20231207171613.0592087d@gandalf.local.home>
        <866d40a8-4e0c-465c-ab8c-b5d864c1a668@efficios.com>
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

On Thu, 7 Dec 2023 17:19:24 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2023-12-07 17:16, Steven Rostedt wrote:
> 
> [...]
> 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 8d2a4f00eca9..b10deb8a5647 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -3424,23 +3424,27 @@ static void dump_buffer_page(struct buffer_data_page *bpage,
> >   		case RINGBUF_TYPE_TIME_EXTEND:
> >   			delta = rb_event_time_stamp(event);
> >   			ts += delta;
> > -			pr_warn("  [%lld] delta:%lld TIME EXTEND\n", ts, delta);
> > +			pr_warn(" %x: [%lld] delta:%lld TIME EXTEND\n",  
> 
> Please prefix hex values with "0x", as in:
> 
> pr_warn(" 0x%x: [%lld] delta:%lld TIME EXTEND\n"
> 
> Otherwise it can be confusing.
> 

Heh, sure. I'm so use to looking at hex for the ring buffer offsets, that I
seldom add the 0x in my debug anymore. But as this is permanent, and not
just a one off print, I'll make the update and post a v2.

Thanks,

-- Steve

