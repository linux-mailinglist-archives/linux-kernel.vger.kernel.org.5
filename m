Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E6B7DD0B1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345074AbjJaPjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345023AbjJaPjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:39:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1CBC1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 08:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a/0oBLdEuvVG+FY65ee8Xo2Hssx33voepgZJiF3Skt4=; b=EtdtygmjGEf4PO7K9+svL2TCqy
        gmvbbtXlKH2DhmUD7B015ZFV+Bj8RQBzgV04CBw2s5zd9igOAZ7ckwO0cLO2uoDA7xI7fxvakquDa
        w9z31yG1MHck9yuS6vtkLeXY8rBTIPPq53TmrEusYvbiqfnEVAkXsMFwwZey8DWIW7bV3GFOgNxLM
        jP1WoorQ71rMdDmc+qMcxr6YzrASiRtv+UReFpXm8Tvt4hQGOiawaEMiihx88FxumSHw/YMz4lhPo
        qx6BT/k37nhmQ8JJaYfhINNPXZtuW0KwGHNOEmQMfTB7sDSLr18kUSl728bpTMvHol/r8oyCRmscb
        6KK/BAxg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qxqq0-004u1s-3C;
        Tue, 31 Oct 2023 15:39:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id A00CE300473; Tue, 31 Oct 2023 16:39:28 +0100 (CET)
Date:   Tue, 31 Oct 2023 16:39:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Keisuke Nishimura <keisuke.nishimura@inria.fr>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH v3] sched/fair: Fix the decision for load balance
Message-ID: <20231031153928.GD15024@noisy.programming.kicks-ass.net>
References: <20231031133821.1570861-1-keisuke.nishimura@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031133821.1570861-1-keisuke.nishimura@inria.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 02:38:22PM +0100, Keisuke Nishimura wrote:
> should_we_balance is called for the decision to do load-balancing.
> When sched ticks invoke this function, only one CPU should return
> true. However, in the current code, two CPUs can return true. The
> following situation, where b means busy and i means idle, is an
> example, because CPU 0 and CPU 2 return true.
> 
>         [0, 1] [2, 3]
>          b  b   i  b
> 
> This fix checks if there exists an idle CPU with busy sibling(s)
> after looking for a CPU on an idle core. If some idle CPUs with busy
> siblings are found, just the first one should do load-balancing.
> 
> Fixes: b1bfeab9b002 ("sched/fair: Consider the idle state of the whole core for load balance")
> Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
> Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> Reviewed-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

I'll sit on this until after the merge window, but then I'll queue it
for sched/urgent.

Thanks!
