Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558A67E3838
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjKGJxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbjKGJxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:53:19 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E9AF3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U9Lxg3/IVucuIC640LqW8ilJ5zaulupFWF0vr4KtYrg=; b=Stu257lWKjxfNCZfd1EP7b6ILg
        vEzYEVGlco351B0NniblkYUjrLT8Zom9+EqpcMDRX/Fm471HyQV+oO/BXfY40y0nI2+3NwvrxEAov
        rdyIctVtd8S0zxkIa3rU+aompLQf62eI/rC7jBaVrSEJidG/TlwZovb/GMUovH9X8/Txqs7FKmLd/
        /K8C5VIoo+350XFLePmr6tNWxEHnVFF0RJEwE0j+xU/6t//VxZRNfRrPop496WV4uDspjoVdRendz
        7g+sT40fC+4NehODv+5eXUteopJ5cTUxXRe56mXxkM5JTivXZrBUcwj9ejU26x7Y9PpNG3/0a2vWz
        fBLw8ADw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r0Il6-00Btnf-2Q;
        Tue, 07 Nov 2023 09:52:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id E6E3B30049D; Tue,  7 Nov 2023 10:52:31 +0100 (CET)
Date:   Tue, 7 Nov 2023 10:52:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Barry Song <21cnbao@gmail.com>,
        Benjamin Segall <bsegall@google.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Mike Galbraith <efault@gmx.de>,
        Qais Yousef <qyousef@layalina.io>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Youssef Esmat <youssefesmat@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] sched/eevdf: Fix vruntime adjustment on reweight
Message-ID: <20231107095231.GS8262@noisy.programming.kicks-ass.net>
References: <20231107090510.71322-1-wuyun.abel@bytedance.com>
 <20231107090510.71322-2-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107090510.71322-2-wuyun.abel@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 05:05:07PM +0800, Abel Wu wrote:
> vruntime of the (on_rq && !0-lag) entity needs to be adjusted when
> it gets re-weighted, and the calculations can be simplified based
> on the fact that re-weight won't change the w-average of all the
> entities. Please check the proofs in comments.
> 
> But adjusting vruntime can also cause position change in RB-tree
> hence require re-queue to fix up which might be costly. This might
> be avoided by deferring adjustment to the time the entity actually
> leaves tree (dequeue/pick), but that will negatively affect task
> selection and probably not good enough either.
> 
> Fixes: 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling policy")
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>

Very good, thanks!

It's a bit sad we have to muck about with the tree now, but alas.

If only Google and FB could agree on what to do with this cgroup
nonsense, then maybe we could get rid of all this.
