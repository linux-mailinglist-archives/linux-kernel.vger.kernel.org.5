Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675317517BE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjGMExJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbjGMEw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:52:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39711BF9;
        Wed, 12 Jul 2023 21:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6698B61A18;
        Thu, 13 Jul 2023 04:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6A0C433C7;
        Thu, 13 Jul 2023 04:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689223976;
        bh=/RC9j/bPcLEPBbYE6sNdriNBLYCampo1CDAJlbUog0E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=d8kgDpiCWMRdgqRGmNeulZUDHqr78WWvudcdh3IDjYU7b9n5/T3eF62LcM3XBdUNr
         WyZ8RGNLV3cxJIe/Id48S1yCIVwkszgGi7q4R5jb8yaRXAQ09qgWwzoov3EyyJlsF9
         OhsPbiI4Ry0wlM1pET9AUN230Md+sp+Inp7nVqqyKCH0/eTYRDc5jM6cH3L2P4bSPV
         lp0mDN7EIMr1g9yRC74gZgGi/NhFlUOxLddKRFP+qJ3sqfJK6bwGqRpkdfM+QCtLDb
         zYxHoTsopaihBV4otouSfFntPXt+Uosa9yPAWbsIN6885u3KJzABHGrG5tanPk0wbe
         h+zmRKrMvv+eQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5BD5ECE00AB; Wed, 12 Jul 2023 21:52:56 -0700 (PDT)
Date:   Wed, 12 Jul 2023 21:52:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
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
Message-ID: <87292a44-cc02-4d95-940e-e4e31d0bc6f2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230711233816.2187577-1-dhavale@google.com>
 <CAEXW_YQvpiFEaaNoS=Msgi17mU3kZD+q8bNBaHYasMArG9aPig@mail.gmail.com>
 <CAB=BE-Rm0ycTZXj=wHW_FBCCKbswG+dh3L+o1+CUW=Pg_oWnyw@mail.gmail.com>
 <20230713003201.GA469376@google.com>
 <161f1615-3d85-cf47-d2d5-695adf1ca7d4@linux.alibaba.com>
 <0d9e7b4d-6477-47a6-b3d2-2c9d9b64903d@paulmck-laptop>
 <f124e041-6a82-2069-975c-4f393e5c4137@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f124e041-6a82-2069-975c-4f393e5c4137@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 12:41:09PM +0800, Gao Xiang wrote:
> 
> 
> On 2023/7/13 12:27, Paul E. McKenney wrote:
> > On Thu, Jul 13, 2023 at 10:02:17AM +0800, Gao Xiang wrote:
> > > 
> > > 
> > > On 2023/7/13 08:32, Joel Fernandes wrote:
> > > > On Wed, Jul 12, 2023 at 02:20:56PM -0700, Sandeep Dhavale wrote:
> > > > [..]
> > > > > > As such this patch looks correct to me, one thing I noticed is that
> > > > > > you can check rcu_is_watching() like the lockdep-enabled code does.
> > > > > > That will tell you also if a reader-section is possible because in
> > > > > > extended-quiescent-states, RCU readers should be non-existent or
> > > > > > that's a bug.
> > > > > > 
> > > > > Please correct me if I am wrong, reading from the comment in
> > > > > kernel/rcu/update.c rcu_read_lock_held_common()
> > > > > ..
> > > > >     * The reason for this is that RCU ignores CPUs that are
> > > > >    * in such a section, considering these as in extended quiescent state,
> > > > >    * so such a CPU is effectively never in an RCU read-side critical section
> > > > >    * regardless of what RCU primitives it invokes.
> > > > > 
> > > > > It seems rcu will treat this as lock not held rather than a fact that
> > > > > lock is not held. Is my understanding correct?
> > > > 
> > > > If RCU treats it as a lock not held, that is a fact for RCU ;-). Maybe you
> > > > mean it is not a fact for erofs?
> > > 
> > > I'm not sure if I get what you mean, EROFS doesn't take any RCU read lock
> > > here:
> > 
> > The key point is that we need lockdep to report errors when
> > rcu_read_lock(), rcu_dereference(), and friends are used when RCU is
> > not watching.  We also need lockdep to report an error when someone
> > uses rcu_dereference() when RCU is not watching, but also forgets the
> > rcu_read_lock().
> > 
> > And this is the job of rcu_read_lock_held(), which is one reason why
> > that rcu_is_watching() is needed.
> > 
> > > z_erofs_decompressqueue_endio() is actually a "bio->bi_end_io", previously
> > > which can be called under two scenarios:
> > > 
> > >   1) under softirq context, which is actually part of device I/O compleltion;
> > > 
> > >   2) under threaded context, like what dm-verity or likewise calls.
> > > 
> > > But EROFS needs to decompress in a threaded context anyway, so we trigger
> > > a workqueue to resolve the case 1).
> > > 
> > > Recently, someone reported there could be some case 3) [I think it was
> > > introduced recently but I have no time to dig into it]:
> > > 
> > >   case 3: under RCU read lock context, which is shown by this:
> > > https://lore.kernel.org/r/4a8254eb-ac39-1e19-3d82-417d3a7b9f94@linux.alibaba.com/T/#u
> > > 
> > >   and such RCU read lock is taken in __blk_mq_run_dispatch_ops().
> > > 
> > > But as the commit shown, we only need to trigger a workqueue for case 1)
> > > and 3) due to performance reasons.
> > 
> > Just out of curiosity, exactly how much is it costing to trigger the
> > workqueue?
> 
> There are lots of performance issues here and even a plumber
> topic last year to show that, see:
> 
> [1] https://lore.kernel.org/r/20230519001709.2563-1-tj@kernel.org
> [2] https://lore.kernel.org/r/CAHk-=wgE9kORADrDJ4nEsHHLirqPCZ1tGaEPAZejHdZ03qCOGg@mail.gmail.com
> [3] https://lore.kernel.org/r/CAB=BE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW8GbO6wyUqFneQ@mail.gmail.com
> [4] https://lpc.events/event/16/contributions/1338/
> and more.
> 
> I'm not sure if it's necessary to look info all of that,
> andSandeep knows more than I am (the scheduling issue
> becomes vital on some aarch64 platform.)

Hmmm...  Please let me try again.

Assuming that this approach turns out to make sense, the resulting
patch will need to clearly state the performance benefits directly in
the commit log.

And of course, for the approach to make sense, it must avoid breaking
the existing lockdep-RCU debugging code.

Is that more clear?

							Thanx, Paul
