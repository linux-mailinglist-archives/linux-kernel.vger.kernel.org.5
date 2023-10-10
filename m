Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEA07BF537
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442653AbjJJIDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442525AbjJJIC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:02:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350C394
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cpAt5iVG7Way5FzBP9yMZ8IQuk91smI+CwYPCmk6OKo=; b=l0XATpaIXlue167p8SPdbIpAOg
        jtw9xOrVS5FEyouEbrTDZpuUyZHoWXXGJ6ZvIfAYp7L2jGHybUpiIJbWpuX9Upo0rkIb3NrAYPSi+
        hFrPApadG+vjhMAj9hQdPU5bMZLXcL9y6DSOkfCEnyIe6HuiZ+0SxwsC0njkx8e9vc1ezZtkmlEqw
        5minCKWzEl9gnfBMyBNKfeT8XTtmKqfn9x+29MH95VHwv+AN6sG0SZJ7ydqK+e204DU18sfTcHK2d
        fRmxDMCAs3WlDnTCJX3nm+fcLAn6uCXmXZnRLK5fHwX+2E2rmmVP9+hjWmljttF0MAA8t7hoVPVpI
        v8Bdv2tw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qq7gg-00GhFn-0V;
        Tue, 10 Oct 2023 08:01:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 45241300392; Tue, 10 Oct 2023 10:01:55 +0200 (CEST)
Date:   Tue, 10 Oct 2023 10:01:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Youssef Esmat <youssefesmat@chromium.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de
Subject: Re: [PATCH 00/15] sched: EEVDF and latency-nice and/or slice-attr
Message-ID: <20231010080155.GB377@noisy.programming.kicks-ass.net>
References: <20230531115839.089944915@infradead.org>
 <dlbtvvm5cewqzh5bcpl4cqhcwxmnnjb6pdle5jzywiiznlactd@cmhnpim42m3p>
 <20230906131356.GG38741@noisy.programming.kicks-ass.net>
 <CA+q576MS0-MV1Oy-eecvmYpvNT3tqxD8syzrpxQ-Zk310hvRbw@mail.gmail.com>
 <20231002184136.GA1539@noisy.programming.kicks-ass.net>
 <20231005120557.GA743@noisy.programming.kicks-ass.net>
 <20231007220400.GA5581@noisy.programming.kicks-ass.net>
 <CA+q576Mov1jpdfZhPBoy_hiVh3xSWuJjXdP3nS4zfpqfOXtq7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+q576Mov1jpdfZhPBoy_hiVh3xSWuJjXdP3nS4zfpqfOXtq7Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 07:51:03PM -0500, Youssef Esmat wrote:

> > Playing around with it a little:
> >
> > EEVDF                                   EVDF
> >
> > slice 30000000                          slice 30000000
> > # Min Latencies: 00014                  # Min Latencies: 00048
> > # Avg Latencies: 00692                  # Avg Latencies: 188239
> > # Max Latencies: 94633                  # Max Latencies: 961241
> >
> > slice 3000000                           slice 3000000
> > # Min Latencies: 00054                  # Min Latencies: 00055
> > # Avg Latencies: 00522                  # Avg Latencies: 00673
> > # Max Latencies: 41475                  # Max Latencies: 13297
> >
> > slice 300000                            slice 300000
> > # Min Latencies: 00018                  # Min Latencies: 00024
> > # Avg Latencies: 00344                  # Avg Latencies: 00056
> > # Max Latencies: 20061                  # Max Latencies: 00860
> >
> 
> Thanks for sharing. Which workload was used to generate these numbers?

This is hackbench vs cyclictest, where cyclictest gets a custom slice
set, the big slice is 10 * normal, the middle slice is normal (equal to
hackbench) and the short slice is normal / 10.
