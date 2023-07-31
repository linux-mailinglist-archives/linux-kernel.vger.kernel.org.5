Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81ACE76A45A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 00:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjGaWtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 18:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjGaWtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 18:49:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A8E1BCC
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 15:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ahdjnU/aZEg8hQeqIwNWmpju2UZuGxXlSNy7n0A7aSc=; b=cpSiKELBZ5h3LCVZdnTVpaRM0n
        /ae9paxwqpOr0ptZRDqtA067osyVwL3FQSi9FlMCyykqOZBm0syCGzsqSYg3R+EP0fDdt957aC2gS
        F8CjcHIpLt+lpSzmFyS/FjSfor+Cba6xoOTeqPfeq29paZs5YJP6X3KyJw9Rc23lAmkprDdnZlpzi
        w35NPFZwU6L/tfZ2f7WUxYO3xbcfpd99HRHtY+nC2AZeVcIFU8r7of31p7fnfAijpmEiB0YULuUAt
        S8l/BpVRV8lj47x5JJmSTIJIfsIEvJZeV5KSpUDon6QZGBc4k+z1fZuciDtTEsn0YwxBuEiMtzbll
        gtFblefw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQbhn-00D8le-2g;
        Mon, 31 Jul 2023 22:49:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 22E43300134;
        Tue,  1 Aug 2023 00:49:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE138200C570F; Tue,  1 Aug 2023 00:49:34 +0200 (CEST)
Date:   Tue, 1 Aug 2023 00:49:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v6 2/2] Sched/fair: Block nohz tick_stop when cfs
 bandwidth in use
Message-ID: <20230731224934.GD51835@hirez.programming.kicks-ass.net>
References: <20230712133357.381137-1-pauld@redhat.com>
 <20230712133357.381137-3-pauld@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712133357.381137-3-pauld@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 09:33:57AM -0400, Phil Auld wrote:
> CFS bandwidth limits and NOHZ full don't play well together.  Tasks
> can easily run well past their quotas before a remote tick does
> accounting.  This leads to long, multi-period stalls before such
> tasks can run again. Currently, when presented with these conflicting
> requirements the scheduler is favoring nohz_full and letting the tick
> be stopped. However, nohz tick stopping is already best-effort, there
> are a number of conditions that can prevent it, whereas cfs runtime
> bandwidth is expected to be enforced.
> 
> Make the scheduler favor bandwidth over stopping the tick by setting
> TICK_DEP_BIT_SCHED when the only running task is a cfs task with
> runtime limit enabled. We use cfs_b->hierarchical_quota to
> determine if the task requires the tick.
> 
> Add check in pick_next_task_fair() as well since that is where
> we have a handle on the task that is actually going to be running.
> 
> Add check in sched_can_stop_tick() to cover some edge cases such
> as nr_running going from 2->1 and the 1 remains the running task.

These appear fine to me, except:

> Add sched_feat HZ_BW (off by default) to control the tick_stop
> behavior.

What was the thinking here? This means nobody will be using this -- why
would you want this default disabled?

