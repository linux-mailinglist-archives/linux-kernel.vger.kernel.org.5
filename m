Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA9C813065
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573116AbjLNMmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573090AbjLNMmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:42:24 -0500
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7F012C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:42:28 -0800 (PST)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4SrX3B0SSpzB0xZZ;
        Thu, 14 Dec 2023 20:39:02 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 14 Dec
 2023 20:42:23 +0800
Date:   Thu, 14 Dec 2023 20:42:23 +0800
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
Subject: Re: Re: [PATCH] sched/fair: merge same code in enqueue_task_fair
Message-ID: <ZXr4L6R1W8QY/O98@fedora>
References: <202312101719+0800-wangjinchao@xfusion.com>
 <CAKfTPtCMOPVhjpLW3Y3fb4=rfYnAKzYeDmdMCRHjPzZdXYjVxg@mail.gmail.com>
 <ZXlXXaGUsiH14pUb@fedora>
 <CAKfTPtDCSQg_Nwh5osRVL0TEzvNZjrUmg_KsVmJySjV_XnOHzw@mail.gmail.com>
 <ZXrPTbXEyBlT+RgP@fedora>
 <6c89812d-a7ef-42df-9ca7-22092937f13c@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6c89812d-a7ef-42df-9ca7-22092937f13c@bytedance.com>
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

On Thu, Dec 14, 2023 at 08:10:57PM +0800, Abel Wu wrote:
> On 12/14/23 5:47 PM, Wang Jinchao Wrote:
> > On Wed, Dec 13, 2023 at 09:23:46AM +0100, Vincent Guittot wrote:
> > > On Wed, 13 Dec 2023 at 08:04, Wang Jinchao <wangjinchao@xfusion.com> wrote:
> > > > 
> > > > On Mon, Dec 11, 2023 at 04:23:52PM +0100, Vincent Guittot wrote:
> > > > > On Sun, 10 Dec 2023 at 10:22, WangJinchao <wangjinchao@xfusion.com> wrote:
> > > > > > 
> > > > > > 1. The code below is duplicated in two for loops and need to be
> > > > > >     consolidated
> > > > > > 2. Fix the bug where a se's on_rq is true but its parent is not
> > > > > 
> > > > > Could you clarify which bug you want to fix ?
> > > > Taking into account the additional information provided by Tim,
> > > > this is not a bug. Therefore, this patch is merely a logical
> > > > simplification.
> > > 
> > > If there is no bug why changing it ?
> > For two reasons:
> > 1. (from Abel Wu)
> > It doesn't need to, but it can actually bring some benefit from
> > the point of view of text size, especially in warehouse-scale
> > computers where icache is extremely contended.
> > 
> > add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-56 (-56)
> > Function                                     old     new   delta
> > enqueue_task_fair                            936     880     -56
> > Total: Before=64899, After=64843, chg -0.09%
> 
> But TBH this benefit is kind of weak to argue about, given that you
> don't have any data supporting it.
Agree. My initinal target is clear comprehension.
And thanks for your numbers.
> 
> > 
> > 2. For better code comprehension
> > I became curious when I reached this part, wondering why there is a lot of
> > repetition inside these two for-loops. Then I thought about 'do not repeat yourself,'
> > and I feel that merging them would lead to a clearer understanding. Of course,
> > it might be because I am just starting to read scheduler-related code and am not
> > yet familiar with the entire logic.
> > > 
> > > The duplication is done in order to have the same pattern in :
> > > enqueue_task_fair
> > > dequeue_task_fair
> > > throttle_cfs_rq
> > > unthrottle_cfs_rq
> > Due to the two points mentioned above, do we need to adjust all four functions?
> > > 
> > > so there is no need to change it
> > I plan to get familiar with the scheduler-related code first and then consider this.
> > 
> > Thanks
> > > 
