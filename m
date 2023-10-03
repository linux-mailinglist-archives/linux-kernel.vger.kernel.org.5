Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B64E7B6613
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239851AbjJCKGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239870AbjJCKGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:06:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A48B7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 03:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y1+tmyaL0mfLqyg9z7m8D+U6L4leAfoeDobjpunPmas=; b=kdcx664bWi3Ru6v29rSrH8Hwpz
        cul/BFAED2HQh/qZ1qwkwiDaoc9zNyaNf0rLMaqdfDACc//gjLmAuxwAZAmiAg0HH0WfskpzEyxue
        LH6BeiZy0QTR/sanI/1QvB+xx/NhL6IpkjoO4mLnOTIoViDRzJ4uj3n0gcLJZAeRFO/Feyxd5nUeD
        FO1kNxgWlvFkw8riI66HEPDT40IrDFkNCjde0dsNWcYDuVMTSBUzzV5/spFekza3PgrqeGRFF5KGu
        Grnb9WCq1lEdcb8UKEFIepXc93QR3+ENN+vkIMhuoldvJEM0MGpCyE8sxqTQkqx1ubPantjd0Wi3i
        fRRqN/cw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qncHz-00EP60-AM; Tue, 03 Oct 2023 10:06:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 023A2300348; Tue,  3 Oct 2023 12:06:03 +0200 (CEST)
Date:   Tue, 3 Oct 2023 12:06:02 +0200
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
Message-ID: <20231003100602.GF27267@noisy.programming.kicks-ass.net>
References: <20230804023218.75544-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804023218.75544-1-longman@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 10:32:18PM -0400, Waiman Long wrote:
> Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
> cpumask"), user provided CPU affinity via sched_setaffinity(2) is
> perserved even if the task is being moved to a different cpuset. However,
> that affinity is also being inherited by any subsequently created child
> processes which may not want or be aware of that affinity.
> 
> One way to solve this problem is to provide a way to back off from
> that user provided CPU affinity.  This patch implements such a scheme
> by using an empty cpumask to signal a reset of the cpumasks to the
> default as allowed by the current cpuset.

So I still don't like this much, the normal state is all bits set:

  $ grep allowed /proc/self/status
  Cpus_allowed:   ff,ffffffff

The all clear bitmask just feels weird for this.
