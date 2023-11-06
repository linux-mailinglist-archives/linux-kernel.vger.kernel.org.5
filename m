Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444517E21D6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjKFMgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjKFMf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:35:56 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4D3BD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 04:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E2D25b0T1SaBIcOpulqdRtTqmMwhLs8nGieykVM8w6U=; b=Dbl/bj+khTCKPDiAJmqK7zDnXD
        pqyFkXV9/jjIPDf9BNykJ+u0tDyUubFs2ueUG3mS7m5NcAgHqTtNZIFGMTXC+/sdkjUaCJwLIuDBn
        f5Yw1MiqPWHjouTMetWRjLL1p5j7O6/qZLTnlppV028xxcHYbeartXL72hrl4+S69+CjxSZJ0k2M6
        7fEiZe0NzT5e+SB5gORE5TJt8V/n0r5xFgdLNCkmPGQKL/EdH6BuMSSl5d3ZaRc8cW8TwUdsxMwc1
        kg07co3lvae/T4WpIkXkhbb3RWvm3J5WGxhOS29kiatoJmDU4b+72s13xYCoLf2mfh0gH8vDIh2mJ
        6CJP+H1Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qzypQ-00AVzS-0C;
        Mon, 06 Nov 2023 12:35:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5AFD230049D; Mon,  6 Nov 2023 13:35:39 +0100 (CET)
Date:   Mon, 6 Nov 2023 13:35:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Use update_current_exec_runtime simplify code
Message-ID: <20231106123539.GL8262@noisy.programming.kicks-ass.net>
References: <20231031125928.235685-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031125928.235685-1-yajun.deng@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 08:59:25PM +0800, Yajun Deng wrote:
> update_current_exec_runtime would update execution time for each task,
> we can use update_current_exec_runtime simplify code.
> 
> The 1st and 2nd patch update update_current_exec_runtime() applies to all
> callers.
> The 3rd patch use update_current_exec_runtime simplify update_curr.
> 
> Yajun Deng (3):
>   sched: Don't account execution time for task group
>   sched: Don't trace stat runtime for task group
>   sched/fair: Simplify update_curr()
> 
>  kernel/sched/deadline.c  |  4 +---
>  kernel/sched/fair.c      | 13 +++----------
>  kernel/sched/rt.c        |  5 ++---
>  kernel/sched/sched.h     | 11 +++++++----
>  kernel/sched/stop_task.c |  2 +-
>  5 files changed, 14 insertions(+), 21 deletions(-)


Hurmph, so I'm having conflicts against this:

  https://lkml.kernel.org/r/54d148a144f26d9559698c4dd82d8859038a7380.1699095159.git.bristot@kernel.org

(obviously).. I've resolved the first patch, which also mostly includes
the second patch.

However, your second patch isn't entirely right, it now unconditionally
traces ->vruntime, which isn't the same. Imagine a regular task getting
a PI boost to RT, in that case ->vruntime will be non-zero and the RT
task will now be logging a vruntime.

Anyway, that tracepoint doesn't really make sense to me anyway, that is,
it logs a delta_exec and an absolute vruntime, that's inconsistent.
Also, a delta vruntime can be easily computed because the weight should
be known.

I think I'm going to simply remove the vruntime from that tracepoint and
avoid the whole problem.

This then also makes resolving patch 3 easier.

Let me go squish all this and then I'll post a link to whatever came
out.
