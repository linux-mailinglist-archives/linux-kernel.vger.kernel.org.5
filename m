Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CA98130D8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573235AbjLNNCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573240AbjLNNC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:02:27 -0500
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41160D41
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:02:24 -0800 (PST)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4SrXV80JDrzB0xYh;
        Thu, 14 Dec 2023 20:58:56 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 14 Dec
 2023 21:02:17 +0800
Date:   Thu, 14 Dec 2023 21:02:17 +0800
From:   Wang Jinchao <wangjinchao@xfusion.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
CC:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>, <stone.xulei@xfusion.com>
Subject: Re: Re: [PATCH] sched/fair: remove next_buddy_marked
Message-ID: <ZXr82WOsSCIxkuPa@fedora>
References: <202312141319+0800-wangjinchao@xfusion.com>
 <CAKfTPtCrBvyxJzeRDARFjbU8P5BYW27So7gYE4FPWBDC0=HL3Q@mail.gmail.com>
 <83099016-f609-4ac0-94ab-909ac9c96582@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <83099016-f609-4ac0-94ab-909ac9c96582@bytedance.com>
X-Originating-IP: [10.82.147.3]
X-ClientProxiedBy: wuxshcsitd00600.xfusion.com (10.32.133.213) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 08:21:53PM +0800, Abel Wu wrote:
> On 12/14/23 4:18 PM, Vincent Guittot Wrote:
> > On Thu, 14 Dec 2023 at 06:20, Wang Jinchao <wangjinchao@xfusion.com> wrote:
> > > 
> > > Remove unused `next_buddy_marked` in `check_preempt_wakeup_fair`
> > > 
> > 
> > Fixes: 5e963f2bd465 ("sched/fair: Commit to EEVDF")
> 
> After this commit @pse preempts curr without being the NEXT_BUDDY, but
> IMHO it should be, so how about this?
> 
> @@ -8259,8 +8259,11 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>         /*
>          * XXX pick_eevdf(cfs_rq) != se ?
>          */
> -       if (pick_eevdf(cfs_rq) == pse)
> +       if (pick_eevdf(cfs_rq) == pse) {
> +               if (!next_buddy_marked)
> +                       set_next_buddy(pse);
>                 goto preempt;
> +       }
> 
>         return;
> 
> which will align with before.
Seizing this opportunity to inquire about a question:
What does "buddy" mean in the context of the scheduler?

Is the effect the same between 
    preempting after pick_evfd(cfs_rq) == pse 
and 
    preempting after set_next_buddy(pse) followed by pick_evfd(cfs_rq) == pse?
Would both scenarios result in pse becoming the next scheduled se?"
