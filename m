Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948DB76B6A4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbjHAODO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbjHAODH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:03:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6512130
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 07:02:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 276C6615B8
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 14:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68729C433C7;
        Tue,  1 Aug 2023 14:02:49 +0000 (UTC)
Date:   Tue, 1 Aug 2023 10:02:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: move back to RT_GROUP_SCHED and rename it
 child
Message-ID: <20230801100247.169b3a9c@gandalf.local.home>
In-Reply-To: <20230801100030.5efec7e2@gandalf.local.home>
References: <20230801062714.3424299-1-yajun.deng@linux.dev>
        <20230801100030.5efec7e2@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2023 10:00:30 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  1 Aug 2023 14:27:14 +0800
> Yajun Deng <yajun.deng@linux.dev> wrote:
> 
> > @@ -228,13 +228,10 @@ void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
> >  	if (!rt_se)
> >  		return;

Ah, I missed the second part of your change log where you said parent is
only NULL when rt_se is NULL.

I would then add:

	if (!rt_se)
		return;

	if (WARN_ON_ONCE(!parent))
		return;

-- Steve


> >  
> > -	if (!parent)
> > -		rt_se->rt_rq = &rq->rt;
> > -	else
> > -		rt_se->rt_rq = parent->my_q;
> > -
> > +	rt_se->rt_rq = parent->my_q;  
> 
> So when this is called with parent = NULL, this will crash?
> 
> -- Steve
> 
> >  	rt_se->my_q = rt_rq;
> >  	rt_se->parent = parent;
> > +	parent->child = rt_se;
> >  	INIT_LIST_HEAD(&rt_se->run_list);
> >  }
> >    


