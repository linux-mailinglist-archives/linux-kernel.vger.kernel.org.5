Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087AF7D642C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbjJYH5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjJYH5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:57:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC5B90
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t4T3Ugl8aTqtrqNfvW9K9Od0cYDpOvgs7PFBhwGV3GI=; b=WpQu5flCwjDb90/+Kz/0JkU+V7
        X138Zi90kTHywDzM/InqKIsDe6cNw+04VX/k3RoLWIx4Mwy9EI56PvU/yYZaV8kc329Wbf1nGZSEI
        Kl9F+tGvfb8yQJn2S2dfeO8VG6t5SXuhXEPr5e3CDxKcYO64ynp2t79ll9zK+CLlnQN91jzG/DG9A
        3wipWfNo6xWK/nAZZSMUbzrIIO4pYQRM/PuRJR+O/8SSAXyM0nDkfmVv6iBfho7+inRfx6Le6eFAL
        QZYjaD3Gl/sEJ31xr8IL8S/YlbH4bseg2LQVMuTqeHjR9Lw7Fmsuanb7VWothLSsWgeoHvo10He5f
        ybxJTQAg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qvYkx-00GC1b-0n;
        Wed, 25 Oct 2023 07:56:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id E316330047C; Wed, 25 Oct 2023 09:56:46 +0200 (CEST)
Date:   Wed, 25 Oct 2023 09:56:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org
Subject: Re: [RFC PATCH v2 1/2] sched/fair: Introduce UTIL_FITS_CAPACITY
 feature (v2)
Message-ID: <20231025075646.GB37471@noisy.programming.kicks-ass.net>
References: <20231019160523.1582101-1-mathieu.desnoyers@efficios.com>
 <20231019160523.1582101-2-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019160523.1582101-2-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 12:05:22PM -0400, Mathieu Desnoyers wrote:

> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e93e006a942b..463e75084aed 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2090,6 +2090,11 @@ static const_debug __maybe_unused unsigned int sysctl_sched_features =
>  
>  #endif /* SCHED_DEBUG */
>  
> +static __always_inline bool sched_util_fits_capacity_active(void)
> +{
> +	return sched_feat(UTIL_EST) && sched_feat(UTIL_FITS_CAPACITY);
> +}

This generates pretty terrible code; it cannot collapse this into a
single branch. And since sched_feat is at best a debug interface for
people who knows wtf they're doing, just make this UTIL_FITS_CAPACITY
with a comment or so.
