Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C9B7E3A1B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbjKGKmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjKGKmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:42:53 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B1BA3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VUPXmPqoD7zPq0gyHwJF1zhaeV4JZiznxUuuQGFLTF8=; b=Z3TsQ1y3zLXhKrXlNO8ZJ357kN
        pHUq+Vbfo12EfTkZuiBl41s657o9F4AFHrdbnGcPgjGTs20KrNvw9ekzbDm331iiJJSrF+0oIfDBH
        QytD7hDKbXHKvvPr12oV4cSysft1jCQdYFFuSfk2RRYfCmM0zgiqOiUTOlJZpEMXyrww1mb7shIpr
        F5pqfC86L6ZS6RezRrjmu/26CQveG5OfC0tFr3jQrJRZAP/jutXlFxUcW7HwvVwA8VEOafTRbk7TF
        pIE8aJvWB0TlCuDqMobYXr502kNB+wObx11vYiyngR9OF9XOuDIVFvKYjxjhdevUAtgymmXfH4hEg
        5C32V5HQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r0JX5-00Bvql-1d;
        Tue, 07 Nov 2023 10:42:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2DCDA30049D; Tue,  7 Nov 2023 11:42:07 +0100 (CET)
Date:   Tue, 7 Nov 2023 11:42:07 +0100
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
Subject: Re: [PATCH 3/4] sched/eevdf: O(1) fastpath for task selection
Message-ID: <20231107104207.GT8262@noisy.programming.kicks-ass.net>
References: <20231107090510.71322-1-wuyun.abel@bytedance.com>
 <20231107090510.71322-4-wuyun.abel@bytedance.com>
 <b2b70241-04fe-4064-ba72-c5ed03a4d4fd@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2b70241-04fe-4064-ba72-c5ed03a4d4fd@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 06:12:49PM +0800, Abel Wu wrote:

> > @@ -904,7 +905,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
> >   	 * in this cfs_rq, saving some cycles.
> >   	 */
> >   	if (cfs_rq->nr_running == 1)
> > -		return curr && curr->on_rq ? curr : __node_2_se(node);
> > +		return curr && curr->on_rq ? curr : se;
> 
> Maybe we can reduce memory footprint on curr by:
> 
> 		return se ? se : curr;

Irrespective, I think that logic makes more sense. If we know we have
but one task and the tree has a task, it must be that task, otherwise,
current must be it. 

Anyway, I was still staring at the previous patch, flipping the tree
around like that is clever. Yes I suppose that ought to work just fine.
