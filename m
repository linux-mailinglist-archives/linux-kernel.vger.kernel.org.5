Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283C67E29C9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjKFQcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbjKFQbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:31:44 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D79DD47
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 08:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1699288298;
        bh=/r0fV53VLFri6xJZwakkB0teRAX33uU5uM/ke7kU0oQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CdfnAS5H7sN4lKTCW3PnJ+UYxM+eReB8tqeHZX6TqvspU1n8T397G7chtIdfJgObw
         x7teodQKIblVJZcLfcbrmI3TssJaIOcgvXgey9mQj1c0ozm5lkyh9+9j9Kk1cLTjLO
         VJce+ZVIitOM96W1MKHgeHfWF6vT3Jx6k2+ttJ6+Hq7w3lnSGmMktPnDUfQahfrNRn
         OKgP84PbC3tgIEmCZLHHf7u82sGydzdrXOpeWn4P/KrC4LnvZ++rXPw/LMtcGs21oy
         /iyo39lfhd8BPfREIchJvTsV8RgNV0k7/71Mt2lt8ofI+WQU0aTQ9Dhx39zQQlyaVp
         IElvEtsWPsbZw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SPH1554nlz1bBN;
        Mon,  6 Nov 2023 11:31:37 -0500 (EST)
Message-ID: <909fd5b2-a1c6-49cf-8efa-c71affb1a4fe@efficios.com>
Date:   Mon, 6 Nov 2023 11:32:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/2] sched/fair migration reduction features
Content-Language: en-US
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org
References: <20231019160523.1582101-1-mathieu.desnoyers@efficios.com>
 <85b710a9-5b26-b0df-8c21-c2768a21e182@amd.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <85b710a9-5b26-b0df-8c21-c2768a21e182@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-26 23:27, K Prateek Nayak wrote:
[...]
> --
> It is a mixed bag of results, as expected. I would love to hear your
> thoughts on the results. Meanwhile, I'll try to get some more data
> from other benchmarks.

I suspect that workloads that exhibit a client-server (1:1) pairing 
pattern are hurt by the bias towards leaving tasks on their prev 
runqueue: they benefit from moving both client/server tasks as close as 
possible so they share either the same core or a common cache.

The hackbench workload is also client-server, but there are N-client and 
N-server threads, creating a N:N relationship which really does not work 
well when trying to pull tasks on sync wakeup: tasks then bounce all 
over the place.

It's tricky though. If we try to fix the "1:1" client-server pattern 
with a heuristic, we may miss scenarios which are close to 1:1 but don't 
exactly match.

I'm working on a rewrite of select_task_rq_fair, with the aim to tackle 
the more general task placement problem taking into account the following:

- We want to converge towards a task placement that moves tasks with
   most waker/wakee interactions as close as possible in the cache
   topology,
- We can use the core util_est/capacity metrics to calculate whether we
   have capacity left to enqueue a task in a core's runqueue.
- The underlying assumption is that work conserving [1] is not a good
   characteristic to aim for, because it does not take into account the
   overhead associated with migrations, and thus lack of cache locality.

Thanks,

Mathieu

[1] I use the definition of "work conserving" found here:
     https://people.ece.ubc.ca/sasha/papers/eurosys16-final29.pdf

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

