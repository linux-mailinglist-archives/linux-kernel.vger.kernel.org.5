Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F3F752869
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjGMQeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjGMQeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:34:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FDE2D5D;
        Thu, 13 Jul 2023 09:33:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C98FC61A5E;
        Thu, 13 Jul 2023 16:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F979C433B7;
        Thu, 13 Jul 2023 16:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689266016;
        bh=uhsVmzJ8WaZFeuYmEIBKJxAUY3vj6kSqoRYxSMWJi0I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uCMTNTPSG1OYrO6FMZaMLROByerhlORvyPS/Wkrw5tdxY84k896W9urr+OWbUqWnX
         RFChbxILbMb3wPdh8c1R+YpDWXZZBHZzfdJsgM9rGUQFNZe4aB2akOzD1RTRWCh2V+
         oZMyEgMCP0HnuigbhmVdsujB56NjMHFoDQxMt+Sc5MHdvra4hIihLLoXHvMZHDvc7u
         aFMJviASDeeuNNReIz/gX9vb1Zh0prc1oqjEpXpWeltzp4kl8v+SJ03+b7xqzX81bP
         rEgM8s8wNUXhGKBeD1ZR6l96AOQ4AkRaKx434czeY3Vi9ziu45DzHjxEPkUtzpI7vq
         9j+5+u3kd3zCQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ADBA8CE009F; Thu, 13 Jul 2023 09:33:35 -0700 (PDT)
Date:   Thu, 13 Jul 2023 09:33:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
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
Message-ID: <58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAB=BE-Rm0ycTZXj=wHW_FBCCKbswG+dh3L+o1+CUW=Pg_oWnyw@mail.gmail.com>
 <20230713003201.GA469376@google.com>
 <161f1615-3d85-cf47-d2d5-695adf1ca7d4@linux.alibaba.com>
 <0d9e7b4d-6477-47a6-b3d2-2c9d9b64903d@paulmck-laptop>
 <f124e041-6a82-2069-975c-4f393e5c4137@linux.alibaba.com>
 <87292a44-cc02-4d95-940e-e4e31d0bc6f2@paulmck-laptop>
 <f1c60dcb-e32f-7b7e-bf0d-5dec999e9299@linux.alibaba.com>
 <CAEXW_YSODXRfgkR0D2G-x=0uZdsqvF3kZL+LL3DcRX-5CULJ1Q@mail.gmail.com>
 <894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com>
 <CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 11:33:24AM -0400, Joel Fernandes wrote:
> On Thu, Jul 13, 2023 at 10:34 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > On 2023/7/13 22:07, Joel Fernandes wrote:
> > > On Thu, Jul 13, 2023 at 12:59 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > >> On 2023/7/13 12:52, Paul E. McKenney wrote:
> > >>> On Thu, Jul 13, 2023 at 12:41:09PM +0800, Gao Xiang wrote:
> > >>
> > >> ...
> > >>
> > >>>>
> > >>>> There are lots of performance issues here and even a plumber
> > >>>> topic last year to show that, see:
> > >>>>
> > >>>> [1] https://lore.kernel.org/r/20230519001709.2563-1-tj@kernel.org
> > >>>> [2] https://lore.kernel.org/r/CAHk-=wgE9kORADrDJ4nEsHHLirqPCZ1tGaEPAZejHdZ03qCOGg@mail.gmail.com
> > >>>> [3] https://lore.kernel.org/r/CAB=BE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW8GbO6wyUqFneQ@mail.gmail.com
> > >>>> [4] https://lpc.events/event/16/contributions/1338/
> > >>>> and more.
> > >>>>
> > >>>> I'm not sure if it's necessary to look info all of that,
> > >>>> andSandeep knows more than I am (the scheduling issue
> > >>>> becomes vital on some aarch64 platform.)
> > >>>
> > >>> Hmmm...  Please let me try again.
> > >>>
> > >>> Assuming that this approach turns out to make sense, the resulting
> > >>> patch will need to clearly state the performance benefits directly in
> > >>> the commit log.
> > >>>
> > >>> And of course, for the approach to make sense, it must avoid breaking
> > >>> the existing lockdep-RCU debugging code.
> > >>>
> > >>> Is that more clear?
> > >>
> > >> Personally I'm not working on Android platform any more so I don't
> > >> have a way to reproduce, hopefully Sandeep could give actually
> > >> number _again_ if dm-verity is enabled and trigger another
> > >> workqueue here and make a comparsion why the scheduling latency of
> > >> the extra work becomes unacceptable.
> > >>
> > >
> > > Question from my side, are we talking about only performance issues or
> > > also a crash? It appears z_erofs_decompress_pcluster() takes
> > > mutex_lock(&pcl->lock);
> > >
> > > So if it is either in an RCU read-side critical section or in an
> > > atomic section, like the softirq path, then it may
> > > schedule-while-atomic or trigger RCU warnings.
> > >
> > > z_erofs_decompressqueue_endio
> > > -> z_erofs_decompress_kickoff
> > >   ->z_erofs_decompressqueue_work
> > >    ->z_erofs_decompress_queue
> > >     -> z_erofs_decompress_pcluster
> > >      -> mutex_lock
> > >
> >
> > Why does the softirq path not trigger a workqueue instead?
> 
> I said "if it is". I was giving a scenario. mutex_lock() is not
> allowed in softirq context or in an RCU-reader.
> 
> > > Per Sandeep in [1], this stack happens under RCU read-lock in:
> > >
> > > #define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops) \
> > > [...]
> > >                  rcu_read_lock();
> > >                  (dispatch_ops);
> > >                  rcu_read_unlock();
> > > [...]
> > >
> > > Coming from:
> > > blk_mq_flush_plug_list ->
> > >                             blk_mq_run_dispatch_ops(q,
> > >                                  __blk_mq_flush_plug_list(q, plug));
> > >
> > > and __blk_mq_flush_plug_list does this:
> > >            q->mq_ops->queue_rqs(&plug->mq_list);
> > >
> > > This somehow ends up calling the bio_endio and the
> > > z_erofs_decompressqueue_endio which grabs the mutex.
> > >
> > > So... I have a question, it looks like one of the paths in
> > > __blk_mq_run_dispatch_ops() uses SRCU.  Where are as the alternate
> > > path uses RCU. Why does this alternate want to block even if it is not
> > > supposed to? Is the real issue here that the BLK_MQ_F_BLOCKING should
> > > be set? It sounds like you want to block in the "else" path even
> > > though BLK_MQ_F_BLOCKING is not set:
> >
> > BLK_MQ_F_BLOCKING is not a flag that a filesystem can do anything with.
> > That is block layer and mq device driver stuffs. filesystems cannot set
> > this value.
> >
> > As I said, as far as I understand, previously,
> > .end_io() can only be called without RCU context, so it will be fine,
> > but I don't know when .end_io() can be called under some RCU context
> > now.
> 
> >From what Sandeep described, the code path is in an RCU reader. My
> question is more, why doesn't it use SRCU instead since it clearly
> does so if BLK_MQ_F_BLOCKING. What are the tradeoffs? IMHO, a deeper
> dive needs to be made into that before concluding that the fix is to
> use rcu_read_lock_any_held().

How can this be solved?

1.	Always use a workqueue.  Simple, but is said to have performance
	issues.

2.	Pass a flag in that indicates whether or not the caller is in an
	RCU read-side critical section.  Conceptually simple, but might
	or might not be reasonable to actually implement in the code as
	it exists now.	(You tell me!)

3.	Create a function in z_erofs that gives you a decent
	approximation, maybe something like the following.

4.	Other ideas here.

The following is untested, and is probably quite buggy, but it should
provide you with a starting point.

static bool z_erofs_wq_needed(void)
{
	if (IS_ENABLED(CONFIG_PREEMPTION) && rcu_preempt_depth())
		return true;  // RCU reader
	if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && !preemptible())
		return true;  // non-preemptible
	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
		return true;  // non-preeemptible kernel, so play it safe
	return false;
}

You break it, you buy it!  ;-)

							Thanx, Paul
