Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95DE7B67C3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239909AbjJCLUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjJCLUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:20:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EC0AC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 04:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g5jU80hlu7hzguF/ewWt0WdyRug8yRAZnGTuHUaXgVg=; b=mxbrY1e5REZvzADGLf43OvnOkG
        gQnLPKlf6ST/75uG9HCcRxepKqHEBXF5Pj6gbKkQv20I/mAeNH4BU7ThNCZUje480oJ3V4sbhDCNb
        tVXSmFO8nBDmGKnmjOhX53IF82C7NTABbBdPiGx0pJ5OskgbE7X1mmxKSLI0TRXe7uJzoFoHLy2vr
        YY9yoS4qf3G5mlSw6RVDqMUpg0xCVlwF2TFmGK0KI75KNYGcWa9sKdi3oDCK2DVrmHacJeMGfqQyQ
        qf9RB5lzT/XpFnrZyfFFQ2l5mFx9CV+GCQe49Y8nv89TcsYWutn8NXQvTgthaRlL53xc9jQeW+wPF
        s78aS8Sg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qndS4-009qDt-0z;
        Tue, 03 Oct 2023 11:20:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D37A300348; Tue,  3 Oct 2023 13:20:33 +0200 (CEST)
Date:   Tue, 3 Oct 2023 13:20:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     hannes@cmpxchg.org, surenb@google.com, zhouchengming@bytedance.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] sched/psi: bail out early from irq time accounting
Message-ID: <20231003112033.GH27267@noisy.programming.kicks-ass.net>
References: <20230925123106.GB347250@cmpxchg.org>
 <20230926115722.467833-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926115722.467833-1-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 11:57:22AM +0000, Haifeng Xu wrote:
> We could bail out early when psi was disabled.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>

Thanks!

> ---
>  kernel/sched/psi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 81fca77397f6..e74e14762d49 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -1005,6 +1005,9 @@ void psi_account_irqtime(struct task_struct *task, u32 delta)
>  	struct psi_group_cpu *groupc;
>  	u64 now;
>  
> +	if (static_branch_likely(&psi_disabled))
> +		return;
> +
>  	if (!task->pid)
>  		return;
>  
> -- 
> 2.25.1
> 
