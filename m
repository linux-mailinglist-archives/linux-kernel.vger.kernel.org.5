Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C612976CBC5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbjHBL3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjHBL26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:28:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482222121
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nbWLCh6y7Cw+zeOnkHNhVKQHXAW0ky+JovdC+xMpaP8=; b=UV9eCJcAH106EAWOx6HE/59IMt
        K9/Gfwn4MzPjxhsvgRVKHRNyXkl/0BZwDj6rPwBUdJZKhDQdweL865E7benpWHT/G6tZRqok+C0aX
        QINbN36O2f738F1pCwsa6r7/gpB1V3MfHD2u6lSfn5zYHf7o0xTUaopl9PSR1wGtdaoAp3j4m/XfV
        +mEfM7OJ34usd0bvj1FxvUy1Cg1hu2X4J+LhhpmLaRUCx9refilehUisx5fRwR5u74u969qEwexUT
        EnYuWJ+t6hjax6QXZaamLmP8L9+p4K2g1o4TXE98G9oe4dnpGpPru/kAg5srulmBFFFQfhjHRapYU
        WV6ffkWg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRA1t-00EfzW-0X; Wed, 02 Aug 2023 11:28:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4F1263001DD;
        Wed,  2 Aug 2023 13:28:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2FE382066B200; Wed,  2 Aug 2023 13:28:36 +0200 (CEST)
Date:   Wed, 2 Aug 2023 13:28:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, rppt@kernel.org
Subject: Re: [RFC PATCH 2/4] sched/fair: Make tg->load_avg per node
Message-ID: <20230802112836.GA212435@hirez.programming.kicks-ass.net>
References: <20230718134120.81199-1-aaron.lu@intel.com>
 <20230718134120.81199-3-aaron.lu@intel.com>
 <20230719115358.GB3529734@hirez.programming.kicks-ass.net>
 <20230719134500.GB91858@ziqianlu-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719134500.GB91858@ziqianlu-dell>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 09:45:00PM +0800, Aaron Lu wrote:
> On Wed, Jul 19, 2023 at 01:53:58PM +0200, Peter Zijlstra wrote:
> > On Tue, Jul 18, 2023 at 09:41:18PM +0800, Aaron Lu wrote:
> > > +#if defined(CONFIG_FAIR_GROUP_SCHED) && defined(CONFIG_SMP)
> > > +static inline long tg_load_avg(struct task_group *tg)
> > > +{
> > > +	long load_avg = 0;
> > > +	int i;
> > > +
> > > +	/*
> > > +	 * The only path that can give us a root_task_group
> > > +	 * here is from print_cfs_rq() thus unlikely.
> > > +	 */
> > > +	if (unlikely(tg == &root_task_group))
> > > +		return 0;
> > > +
> > > +	for_each_node(i)
> > > +		load_avg += atomic_long_read(&tg->node_info[i]->load_avg);
> > > +
> > > +	return load_avg;
> > > +}
> > > +#endif
> > 
> > So I was working on something else numa and noticed that for_each_node()
> > (and most of the nodemask stuff) is quite moronic, afaict we should do
> > something like the below.
> > 
> > I now see Mike added the nr_node_ids thing fairly recent, but given
> > distros have NODES_SHIFT=10 and actual machines typically only have <=4
> > nodes, this would save a factor of 256 scanning.

More complete nodemask patch here:

  https://lkml.kernel.org/r/20230802112458.230221601%40infradead.org
