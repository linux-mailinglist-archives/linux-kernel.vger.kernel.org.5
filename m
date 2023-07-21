Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4EE75C34D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjGUJnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjGUJnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:43:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E77E30DB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W/JkK75GgoPWuY+gA9/KSWjJhFbtA7PlToCKTztX/To=; b=K9Zi/vurpvdQ8W2CG0JGtqZWFH
        R05cIPMgwz+DsolIy8JjXnJeXpK/0blxQOF9VoqoWhiwCt0jtNBw5i1S6+uTJI37TEJOZHQKSFci4
        pKyY3InmMBmKicPWnquUnI4+/sV7ZGyqAn+IN0QVSeqAybPYTmXJyZdl0A/WrLzd7eVaEImiw3KvK
        5Wa1NoLDFux8VvgWyOTezTC2NgjC3bvTiJzmtUMpAKdezkNbJXc+JzQo5SWgnUuCVsDzAVCip2IZk
        ypoIjVR5FtQcfVtagpjgsoN37gXsO4qNx8v8Z6diTRuty2cYWOjy2y1KimZ5WlIjsyLVCKUt0EH/E
        +yi9p9pQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qMmeg-000zKW-7F; Fri, 21 Jul 2023 09:42:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 79824300274;
        Fri, 21 Jul 2023 11:42:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5BD4F29E775DB; Fri, 21 Jul 2023 11:42:33 +0200 (CEST)
Date:   Fri, 21 Jul 2023 11:42:33 +0200
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
Subject: Re: [PATCH v2] sched/core: Use empty mask to reset cpumasks in
 sched_setaffinity()
Message-ID: <20230721094233.GF3630545@hirez.programming.kicks-ass.net>
References: <20230717180243.3607603-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717180243.3607603-1-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 02:02:43PM -0400, Waiman Long wrote:
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
> 
> Before this patch, passing in an empty cpumask to sched_setaffinity(2)
> will always return an EINVAL error. With this patch, an error will no
> longer be returned if sched_setaffinity(2) has been called before to
> set up user_cpus_ptr. Instead, the user_cpus_ptr that stores the user
> provided affinity will be cleared and the task's CPU affinity will be
> reset to that of the current cpuset. No error will be returned in this
> case to signal that a reset has happened.
> 
> If sched_setaffinity(2) has not been called previously, an EINVAL error
> will be returned with an empty cpumask just like before. As a result,
> tests or tools that rely on this behavior will not be affected unless
> they have somehow called sched_setaffinity(2) before.
> 
> We will have to update the sched_setaffinity(2) manpage to document
> this possible side effect of passing in an empty cpumask.

So a normal task, that hasn't had it's affinity changed will have
possible_mask.

So why not use in_mask == possible_mask to clear the user state?
