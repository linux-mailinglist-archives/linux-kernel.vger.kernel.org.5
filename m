Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230947FDA9A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbjK2O6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjK2O56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:57:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3907EA3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:58:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A6BC433C8;
        Wed, 29 Nov 2023 14:58:04 +0000 (UTC)
Date:   Wed, 29 Nov 2023 09:58:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        zhengyejian1@huawei.com, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Simplify and fix "buffered event"
 synchronization
Message-ID: <20231129095826.1aec6381@gandalf.local.home>
In-Reply-To: <bb6c9771-1a7c-4367-bb14-63524d9c560a@suse.com>
References: <20231127151248.7232-1-petr.pavlu@suse.com>
        <20231127151248.7232-2-petr.pavlu@suse.com>
        <20231127124130.1041ffd4@gandalf.local.home>
        <77037ca1-8116-4bc6-b286-67059db0848e@suse.com>
        <20231128102748.23328618@gandalf.local.home>
        <bb6c9771-1a7c-4367-bb14-63524d9c560a@suse.com>
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

On Wed, 29 Nov 2023 10:22:23 +0100
Petr Pavlu <petr.pavlu@suse.com> wrote:

> Yes, I believe this should address this potential race condition.
> 
> An alternative would be instead to update
> trace_event_buffer_lock_reserve() as follows:
> 
> 	if (this_cpu_inc_return(trace_buffered_event_cnt) == 1) {
> 		smp_rmb();

This is the problem I have with your approach. That smp_rmb() is in the
highly critical path. On some architectures, this has a significant impact
on the overhead of this code. This path is called during code execution and
increases the overhead of the tracing infrastructure.

If I'm given two solutions where one adds a smp_rmb() to the critical path
and the other just slows down the non-critical path more, I'll take the
slow down of non-critical path every time.

> 		if ((entry = __this_cpu_read(trace_buffered_event))) {
> 			[...]
> 
> That saves the synchronize_rcu() call but additionally modifies
> trace_buffered_event_cnt even if trace_buffered_event is currently NULL.
> 
> Another alternative is the approach taken by my patch which avoids more
> RCU work and unnecessary memory modifications.
> 
> I'd be interested if you could have a look again at what I'm proposing
> in my patch. I think it simplifies the code while addressing these
> problems as well. However, if you have reservations about that approach
> then it is ok, I can fix the found problems individually as discussed.

Fix this without adding any memory barriers to the critical path, then I'll
take another look.

FYI, this code was designed in the first place to avoid adding memory
barriers in the critical path.

Thanks!

-- Steve

