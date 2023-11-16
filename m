Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAC17EE2EC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344087AbjKPOfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjKPOfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:35:10 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40700187;
        Thu, 16 Nov 2023 06:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=FtGcrsM0yGKSH60fh1aa98gMbQ7lZQIB+/J2Fm0HBWM=; b=q5cXJFF50QMSpguEg0T5HooloM
        CGzHXbgPEopW+DHviNWzN8yOIGB2B5k645B4XW+8pU9likX6mqsGBTtfs2KvBRGoSmijKwtibklEj
        aVSEux5TSFxYsODfIrWRkpUdgr6mMVVgNUz58i2Jk+Zn8GdqviCK6B5yFq8HbKw/B3frgvc9L04sF
        HMmp1xggZoFKZcZZkgLmtiCmjfkJjqenqUxRe1wCu7W/KswnbLnimRRNG2+QDmcBDhGngf8BJquvL
        dOmwcc4/byDjYB9GSRW9S5e17yJUsTq5W1G74yTjIoMi50+gIFU5j8K6eAhwHkzMaTJB98JbmtKvd
        b7Q2+pUw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r3dSE-005bav-2V;
        Thu, 16 Nov 2023 14:34:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 717613002BE; Thu, 16 Nov 2023 15:34:50 +0100 (CET)
Date:   Thu, 16 Nov 2023 15:34:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, viresh.kumar@linaro.org,
        qyousef@layalina.io, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, lukasz.luba@arm.com, wyes.karny@amd.com,
        beata.michalska@arm.com
Subject: Re: [PATCH v3 0/2] Rework interface between scheduler and schedutil
 governor
Message-ID: <20231116143450.GF8262@noisy.programming.kicks-ass.net>
References: <20231103131821.1176294-1-vincent.guittot@linaro.org>
 <CAJZ5v0g4N2UojiQqJn7fxWj2=h=6sgFfGEqEVx1wuh2VdvaH6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0g4N2UojiQqJn7fxWj2=h=6sgFfGEqEVx1wuh2VdvaH6Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 04:05:40PM +0100, Rafael J. Wysocki wrote:
> On Fri, Nov 3, 2023 at 2:18 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Following the discussion with Qais [1] about how to handle uclamp
> > requirements and after syncing with him, we agreed that I should move
> > forward on the patchset to rework the interface between scheduler and
> > schedutil governor to provide more information to the latter. Scheduler
> > (and EAS in particular) doesn't need anymore to guess estimate which
> > headroom the governor wants to apply and will directly ask for the target
> > freq. Then the governor directly gets the actual utilization and new
> > minimum and maximum boundaries to select this target frequency and
> > doesn't have to deal anymore with scheduler internals like uclamp when
> > including iowait boost.
> >
> > [1] https://lore.kernel.org/lkml/CAKfTPtA5JqNCauG-rP3wGfq+p8EEVx9Tvwj6ksM3SYCwRmfCTg@mail.gmail.com/
> >
> > Changes since v2:
> > - remove useless target variable
> >
> > Changes since v1:
> > - fix a bug (always set max even when returning early)
> > - fix typos
> >
> > Vincent Guittot (2):
> >   sched/schedutil: Rework performance estimation
> >   sched/schedutil: Rework iowait boost
> >
> >  include/linux/energy_model.h     |  1 -
> >  kernel/sched/core.c              | 82 ++++++++++++-------------------
> >  kernel/sched/cpufreq_schedutil.c | 69 ++++++++++++++++----------
> >  kernel/sched/fair.c              | 22 +++++++--
> >  kernel/sched/sched.h             | 84 +++-----------------------------
> >  5 files changed, 100 insertions(+), 158 deletions(-)
> >
> > --
> 
> For the schedutil changes in the series:
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> 
> and I'm assuming this series to be targeted at sched.

Sure, I'll go queue it. Thanks!
