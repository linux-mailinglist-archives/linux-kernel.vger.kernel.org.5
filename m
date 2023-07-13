Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0D3752A3A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 20:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjGMSPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 14:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjGMSPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 14:15:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4ED726AF;
        Thu, 13 Jul 2023 11:14:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 545426185A;
        Thu, 13 Jul 2023 18:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37F7C433C8;
        Thu, 13 Jul 2023 18:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689272097;
        bh=gbBaDOLW8b5zJ6t+3hNGjxenn8ggPRUMHbXlJY7MZBk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tqNIuNvoYCyzicFL7M0IuA7oO/p8oI98C4Ha0s+IRm9ZZnYmfK0BLRV4vLQaiC4eU
         j6Q0phJZ8zXfU7jN/2u1/K/uYhEzzXG+XDM+cswy8+sRLzB82QGyczw3eN+mnoAvIG
         SyUOARlofcgKCqei4M6SkZonkhRn1I+dtcr4tjLJEYHIxMMGiJvsklygEF2ALi6rte
         uI0AN2u4p7sVxP4Mbjae6i3hVWGZlC9iubmvtqtZ0/SIYwrPmnriTJHknPK83Ju7bG
         LgklYKHbfP99PjVt07Qb0lYyG7hYBEIErmi1WKzhzuq+EtxWW8JJIWQEZgW2ARSoHx
         PzzCXkdpIMVMg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 325E8CE009F; Thu, 13 Jul 2023 11:14:57 -0700 (PDT)
Date:   Thu, 13 Jul 2023 11:14:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org,
        Will Shiu <Will.Shiu@mediatek.com>, kernel-team@android.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when
 !CONFIG_DEBUG_LOCK_ALLOC
Message-ID: <c62bd3db-5ed3-4dbf-bba9-d9dace23312c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230713003201.GA469376@google.com>
 <161f1615-3d85-cf47-d2d5-695adf1ca7d4@linux.alibaba.com>
 <0d9e7b4d-6477-47a6-b3d2-2c9d9b64903d@paulmck-laptop>
 <f124e041-6a82-2069-975c-4f393e5c4137@linux.alibaba.com>
 <87292a44-cc02-4d95-940e-e4e31d0bc6f2@paulmck-laptop>
 <f1c60dcb-e32f-7b7e-bf0d-5dec999e9299@linux.alibaba.com>
 <CAEXW_YSODXRfgkR0D2G-x=0uZdsqvF3kZL+LL3DcRX-5CULJ1Q@mail.gmail.com>
 <894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com>
 <CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
 <F7D5032D-908E-4227-8A38-AF740AC86CDC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F7D5032D-908E-4227-8A38-AF740AC86CDC@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 12:09:27AM +0800, Alan Huang wrote:
> 
> > 2023年7月13日 23:33，Joel Fernandes <joel@joelfernandes.org> 写道：
> > 
> > On Thu, Jul 13, 2023 at 10:34 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >> 
> >> 
> >> 
> >> On 2023/7/13 22:07, Joel Fernandes wrote:
> >>> On Thu, Jul 13, 2023 at 12:59 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >>>> On 2023/7/13 12:52, Paul E. McKenney wrote:
> >>>>> On Thu, Jul 13, 2023 at 12:41:09PM +0800, Gao Xiang wrote:
> >>>>>> 
> >>>>>> 
> >>>> 
> >>>> ...
> >>>> 
> >>>>>> 
> >>>>>> There are lots of performance issues here and even a plumber
> >>>>>> topic last year to show that, see:
> >>>>>> 
> >>>>>> [1] https://lore.kernel.org/r/20230519001709.2563-1-tj@kernel.org
> >>>>>> [2] https://lore.kernel.org/r/CAHk-=wgE9kORADrDJ4nEsHHLirqPCZ1tGaEPAZejHdZ03qCOGg@mail.gmail.com
> >>>>>> [3] https://lore.kernel.org/r/CAB=BE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW8GbO6wyUqFneQ@mail.gmail.com
> >>>>>> [4] https://lpc.events/event/16/contributions/1338/
> >>>>>> and more.
> >>>>>> 
> >>>>>> I'm not sure if it's necessary to look info all of that,
> >>>>>> andSandeep knows more than I am (the scheduling issue
> >>>>>> becomes vital on some aarch64 platform.)
> >>>>> 
> >>>>> Hmmm...  Please let me try again.
> >>>>> 
> >>>>> Assuming that this approach turns out to make sense, the resulting
> >>>>> patch will need to clearly state the performance benefits directly in
> >>>>> the commit log.
> >>>>> 
> >>>>> And of course, for the approach to make sense, it must avoid breaking
> >>>>> the existing lockdep-RCU debugging code.
> >>>>> 
> >>>>> Is that more clear?
> >>>> 
> >>>> Personally I'm not working on Android platform any more so I don't
> >>>> have a way to reproduce, hopefully Sandeep could give actually
> >>>> number _again_ if dm-verity is enabled and trigger another
> >>>> workqueue here and make a comparsion why the scheduling latency of
> >>>> the extra work becomes unacceptable.
> >>>> 
> >>> 
> >>> Question from my side, are we talking about only performance issues or
> >>> also a crash? It appears z_erofs_decompress_pcluster() takes
> >>> mutex_lock(&pcl->lock);
> >>> 
> >>> So if it is either in an RCU read-side critical section or in an
> >>> atomic section, like the softirq path, then it may
> >>> schedule-while-atomic or trigger RCU warnings.
> >>> 
> >>> z_erofs_decompressqueue_endio
> >>> -> z_erofs_decompress_kickoff
> >>>  ->z_erofs_decompressqueue_work
> >>>   ->z_erofs_decompress_queue
> >>>    -> z_erofs_decompress_pcluster
> >>>     -> mutex_lock
> >>> 
> >> 
> >> Why does the softirq path not trigger a workqueue instead?
> > 
> > I said "if it is". I was giving a scenario. mutex_lock() is not
> > allowed in softirq context or in an RCU-reader.
> > 
> >>> Per Sandeep in [1], this stack happens under RCU read-lock in:
> >>> 
> >>> #define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops) \
> >>> [...]
> >>>                 rcu_read_lock();
> >>>                 (dispatch_ops);
> >>>                 rcu_read_unlock();
> >>> [...]
> >>> 
> >>> Coming from:
> >>> blk_mq_flush_plug_list ->
> >>>                            blk_mq_run_dispatch_ops(q,
> >>>                                 __blk_mq_flush_plug_list(q, plug));
> >>> 
> >>> and __blk_mq_flush_plug_list does this:
> >>>           q->mq_ops->queue_rqs(&plug->mq_list);
> >>> 
> >>> This somehow ends up calling the bio_endio and the
> >>> z_erofs_decompressqueue_endio which grabs the mutex.
> >>> 
> >>> So... I have a question, it looks like one of the paths in
> >>> __blk_mq_run_dispatch_ops() uses SRCU.  Where are as the alternate
> >>> path uses RCU. Why does this alternate want to block even if it is not
> >>> supposed to? Is the real issue here that the BLK_MQ_F_BLOCKING should
> >>> be set? It sounds like you want to block in the "else" path even
> >>> though BLK_MQ_F_BLOCKING is not set:
> >> 
> >> BLK_MQ_F_BLOCKING is not a flag that a filesystem can do anything with.
> >> That is block layer and mq device driver stuffs. filesystems cannot set
> >> this value.
> >> 
> >> As I said, as far as I understand, previously,
> >> .end_io() can only be called without RCU context, so it will be fine,
> >> but I don't know when .end_io() can be called under some RCU context
> >> now.
> > 
> > From what Sandeep described, the code path is in an RCU reader. My
> > question is more, why doesn't it use SRCU instead since it clearly
> > does so if BLK_MQ_F_BLOCKING. What are the tradeoffs? IMHO, a deeper
> > dive needs to be made into that before concluding that the fix is to
> > use rcu_read_lock_any_held().
> 
> Copied from [1]:
> 
> "Background: Historically erofs would always schedule a kworker for
>  decompression which would incur the scheduling cost regardless of
>  the context. But z_erofs_decompressqueue_endio() may not always
>  be in atomic context and we could actually benefit from doing the
>  decompression in z_erofs_decompressqueue_endio() if we are in
>  thread context, for example when running with dm-verity.
>  This optimization was later added in patch [2] which has shown
>  improvement in performance benchmarks.”
> 
> I’m not sure if it is a design issue.

I have no official opinion myself, but there are quite a few people
who firmly believe that any situation like this one (where driver or
file-system code needs to query the current context to see if blocking
is OK) constitutes a design flaw.  Such people might argue that this
code path should have a clearly documented context, and that if that
documentation states that the code might be in atomic context, then the
driver/fs should assume atomic context.  Alternatively, if driver/fs
needs the context to be non-atomic, the callers should make it so.

See for example in_atomic() and its comment header:

/*
 * Are we running in atomic context?  WARNING: this macro cannot
 * always detect atomic context; in particular, it cannot know about
 * held spinlocks in non-preemptible kernels.  Thus it should not be
 * used in the general case to determine whether sleeping is possible.
 * Do not use in_atomic() in driver code.
 */
#define in_atomic()	(preempt_count() != 0)

In the immortal words of Dan Frye, this should be good clean fun!  ;-)

							Thanx, Paul

> [1] https://lore.kernel.org/all/20230621220848.3379029-1-dhavale@google.com/
> 
> > 
> > - Joel
> 
> 
