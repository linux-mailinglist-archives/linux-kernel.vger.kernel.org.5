Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C543A800D9E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379237AbjLAOqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379221AbjLAOqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:46:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A37D6C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 06:46:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA937C433C7;
        Fri,  1 Dec 2023 14:46:14 +0000 (UTC)
Date:   Fri, 1 Dec 2023 09:46:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        zhengyejian1@huawei.com, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Simplify and fix "buffered event"
 synchronization
Message-ID: <20231201094639.03a1913c@gandalf.local.home>
In-Reply-To: <d404113e-4ffe-4e9c-ab45-1b076c1f498c@suse.com>
References: <20231127151248.7232-1-petr.pavlu@suse.com>
        <20231127151248.7232-2-petr.pavlu@suse.com>
        <20231127124130.1041ffd4@gandalf.local.home>
        <77037ca1-8116-4bc6-b286-67059db0848e@suse.com>
        <20231128102748.23328618@gandalf.local.home>
        <bb6c9771-1a7c-4367-bb14-63524d9c560a@suse.com>
        <20231129095826.1aec6381@gandalf.local.home>
        <d404113e-4ffe-4e9c-ab45-1b076c1f498c@suse.com>
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

On Fri, 1 Dec 2023 15:17:35 +0100
Petr Pavlu <petr.pavlu@suse.com> wrote:

> Ok, keeping the current approach, my plan for v2 is to prepare the
> following patches:
> 
> * Fix for the missing increment+decrement of trace_buffered_event_cnt
>   on the current CPU in trace_buffered_event_disable().
> 
>   Replace smp_call_function_many() with on_each_cpu_mask() in
>   trace_buffered_event_disable(). The on_each_cpu_mask() function has
>   also an advantage that it itself disables preemption so doing that can
>   be then removed from trace_buffered_event_disable().

OK.

> 
> * Fix the potential race between trace_buffered_event_enable() and
>   trace_event_buffer_lock_reserve() where the latter might already see
>   a valid trace_buffered_event pointer but not all initialization yet.
> 
>   I think this might be actually best to address by using the same
>   maintenance exclusion as is implemented in
>   trace_buffered_event_disable(). It would make both maintenance
>   operations consistent but for the cost of making the enable operation
>   somewhat slower.

I wouldn't do them the same just to make them consistent. I think the
smp_wmb() is sufficient. Don't you think?

> 
> * Fix the WARN_ON_ONCE(!trace_buffered_event_ref) issued in
>   trace_buffered_event_disable() when trace_buffered_event_enable()
>   previously fails.
> 
>   Add a variable/flag tracking whether trace_buffered_event is currently
>   allocated and use that for driving if a new allocation needs to be
>   done when trace_buffered_event_enable() is called, or the buffers
>   should be really freed when trace_buffered_event_disable() is invoked.
> 
>   Not sure if the mentioned alternative of leaving trace_buffered_event
>   partially initialized on failure is preferred instead.

I do not really have a preference for either solution. They both are bad if
it happens ;-)

> 
> * Fix the potential race between trace_buffered_event_disable() and
>   trace_event_buffer_lock_reserve() where the latter might still grab
>   a pointer from trace_buffered_event that is being freed.
> 
>   Replace smp_wmb() with synchronize_rcu() in
>   trace_buffered_event_disable().

Sounds good.

Thanks!

-- Steve
