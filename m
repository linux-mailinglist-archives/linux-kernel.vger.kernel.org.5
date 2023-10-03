Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB577B7381
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241271AbjJCVsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjJCVsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:48:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA0AA1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GhmbQyYJOogKc2OlN+UN4K7WylEhZzt31aBp6zvEslc=; b=Y3CbxWdlVveozxN5h4v078B8Z5
        +Wo118ggvtjD/CzjdG682q9k6CA6vFHnSnudP3kbua15ncDUJn2gPEXD1X1aTYa638NQYszz776G+
        aWuwKrJVvbMm+aRJqDliGfA3xop9nwS1hQq5j2is1JXqZb4qRUyNPlAfGqNW1V90GWs0+IQGNMw0O
        dp+HJ7+xamXJ563CdQQXCj/Nm4MJR+ojEREPqSqPjKYNadn1Z+RbDiuOtqPRtxDDLig7MC27CtRQ/
        EwxVvqFba9Kaig78ui7arwKYUFeFMxi8WZPMs6PxuRXxLgT47u1WXwZowQoByNMwzGkggjsECPmVW
        MQbN7SYg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qnnFe-00HJM1-GL; Tue, 03 Oct 2023 21:48:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2E14830036C; Tue,  3 Oct 2023 23:48:22 +0200 (CEST)
Date:   Tue, 3 Oct 2023 23:48:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>
Subject: Re: [PATCH v3] sched/core: Use empty mask to reset cpumasks in
 sched_setaffinity()
Message-ID: <20231003214822.GI1539@noisy.programming.kicks-ass.net>
References: <20230804023218.75544-1-longman@redhat.com>
 <20231003100602.GF27267@noisy.programming.kicks-ass.net>
 <320f6e2e-c0ae-3cbd-bc43-d2eabcd70cc4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <320f6e2e-c0ae-3cbd-bc43-d2eabcd70cc4@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 02:58:58PM -0400, Waiman Long wrote:
> 
> On 10/3/23 06:06, Peter Zijlstra wrote:
> > On Thu, Aug 03, 2023 at 10:32:18PM -0400, Waiman Long wrote:
> > > Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
> > > cpumask"), user provided CPU affinity via sched_setaffinity(2) is
> > > perserved even if the task is being moved to a different cpuset. However,
> > > that affinity is also being inherited by any subsequently created child
> > > processes which may not want or be aware of that affinity.
> > > 
> > > One way to solve this problem is to provide a way to back off from
> > > that user provided CPU affinity.  This patch implements such a scheme
> > > by using an empty cpumask to signal a reset of the cpumasks to the
> > > default as allowed by the current cpuset.
> > So I still don't like this much, the normal state is all bits set:
> > 
> >    $ grep allowed /proc/self/status
> >    Cpus_allowed:   ff,ffffffff
> > 
> > The all clear bitmask just feels weird for this.
> 
> The main reason for using an empty bitmask is the presence of the CPU_ZERO()
> macro that can produce this empty cpumask. It is certainly possible to use
> an all set bitmask for reset purpose. The only problem is it is more
> complicated to generate such a bitmask as there is no existing CPU* macros
> that can be used.

Blergh, FreeBSD has CPU_FILL(), but it appears we don't have this.

Still, nothing a memset can't fix. CPU_ZERO() ends up in
__builtin_memset() too. I'm sure our glibc boys can add CPU_FILL()
eventually.

Anyway, I see you sent a v4, I'll go look at that in the am, sleep now.
