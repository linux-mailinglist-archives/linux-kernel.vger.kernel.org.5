Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFC57D0DE3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377111AbjJTKsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377102AbjJTKsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:48:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2305D1738;
        Fri, 20 Oct 2023 03:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NYgUxqgWdWiMzMO4WM+VQrWOaxfIXpBf/TNYgsN2m04=; b=CZ9ruFd+h5Vi7bMFuAtlBHOGqB
        MUuPKrOC0TB6B9QwySakkov0zer+ZknduzdHLJYwjTIdt/04bn3V0l9bpGoieTV+PUCM6Jiy/1FYA
        dyD7Xka1BD1OQf0s0+rForFaZgbvHUaWUbDE1PckY21ImPPe+SNnRx24zHSdBjuUtBQSNpxoUHr94
        OaERJIzhxmfW11n7KtCEoV13L+fVW5QF+DCMScwllR30K4s8hyLq0vp1VyIFnb8YeBmr8NLTqY6B3
        94oYYMjoI/y5+dC70lPiHQC5bGeUHHlUNrTDydlOcAoYc9ETCpKswfUFePItYFP+vIizxHVrtyXdG
        cup/TrFQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qtn10-00AxZV-0J;
        Fri, 20 Oct 2023 10:46:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id BC5B8300392; Fri, 20 Oct 2023 12:46:01 +0200 (CEST)
Date:   Fri, 20 Oct 2023 12:46:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Igor Raits <igor.raits@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2] sched/core: Fix RQCF_ACT_SKIP leak
Message-ID: <20231020104601.GA33965@noisy.programming.kicks-ass.net>
References: <20231012090003.11450-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012090003.11450-1-jiahao.os@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 05:00:03PM +0800, Hao Jia wrote:
> Igor Raits and Bagas Sanjaya report a RQCF_ACT_SKIP leak warning.
> Link: https://lore.kernel.org/all/a5dd536d-041a-2ce9-f4b7-64d8d85c86dc@gmail.com
> 
> This warning may be triggered in the following situations:
> 
>     CPU0                                      CPU1
> 
> __schedule()
>   *rq->clock_update_flags <<= 1;*   unregister_fair_sched_group()
>   pick_next_task_fair+0x4a/0x410      destroy_cfs_bandwidth()
>     newidle_balance+0x115/0x3e0       for_each_possible_cpu(i) *i=0*
>       rq_unpin_lock(this_rq, rf)      __cfsb_csd_unthrottle()
>       raw_spin_rq_unlock(this_rq)
>                                       rq_lock(*CPU0_rq*, &rf)
>                                       rq_clock_start_loop_update()
>                                       rq->clock_update_flags & RQCF_ACT_SKIP <--
>       raw_spin_rq_lock(this_rq)
> 
> The purpose of RQCF_ACT_SKIP is to skip the update rq clock,
> but the update is very early in __schedule(), but we clear
> RQCF_*_SKIP very late, causing it to span that gap above
> and triggering this warning.
> 
> In __schedule() we can clear the RQCF_*_SKIP flag immediately
> after update_rq_clock() to avoid this RQCF_ACT_SKIP leak warning.
> And set rq->clock_update_flags to RQCF_UPDATED to avoid
> rq->clock_update_flags < RQCF_ACT_SKIP warning that may be triggered later.
> 

Thanks!
