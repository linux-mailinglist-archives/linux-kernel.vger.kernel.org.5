Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0FA7B5A81
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238803AbjJBSmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjJBSmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:42:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4561B0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 11:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nyWCVXS8PqBYuLCq0GKreS/wQJesJaUJKyaLwZQihgg=; b=vs9VL1IWPHTru7ozL6Wh/0gUsr
        fgshk/L0VduYyAUrlincQ0IA5G7RQe2lGO8kFO+IWBoBIVDAWl7ChgdfAOcm+Bmkk2J8fTL7jC1Ed
        Q9XRkkSPbqcBHdhT8k02bqqCnIFb8c0OGRzF96dp6TKHzG1N7aaiQdc5bmWs++fqU8HFBroxu7HqY
        u5E4XUFJvoCSc1bYgLWVvdRDUaTKKQtVOKF4WkPHGGTcdSJdiCopR+eAzrAU/GGBX/mwVrhGrZkbK
        PZiMf+WkgpdgMFqlxkWQoMHvr5ieDS8RPaJi28B/qLZtAuyBBBoZ07oq1ivv2pvrlil6+97PYX/Rt
        UQsoxWtQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qnNrN-00Aazz-DL; Mon, 02 Oct 2023 18:41:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id C1972300454; Mon,  2 Oct 2023 20:41:36 +0200 (CEST)
Date:   Mon, 2 Oct 2023 20:41:36 +0200
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
Message-ID: <20231002184136.GA1539@noisy.programming.kicks-ass.net>
References: <20230531115839.089944915@infradead.org>
 <dlbtvvm5cewqzh5bcpl4cqhcwxmnnjb6pdle5jzywiiznlactd@cmhnpim42m3p>
 <20230906131356.GG38741@noisy.programming.kicks-ass.net>
 <CA+q576MS0-MV1Oy-eecvmYpvNT3tqxD8syzrpxQ-Zk310hvRbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+q576MS0-MV1Oy-eecvmYpvNT3tqxD8syzrpxQ-Zk310hvRbw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 11:54:25AM -0500, Youssef Esmat wrote:
> >
> > EEVDF fundamentally supports per task request/slice sizes, which is the
> > primary motivator for finally finishing these patches.
> >
> > So the plan is to extend sched_setattr() to allow tasks setting their
> > own ideal slice length. But we're not quite there yet.
> >
> > Having just returned from PTO the mailbox is an utter trainwreck, but
> > I'll try and refresh those few patches this week for consideration.
> >
> > In the meantime I think you found the right knob to twiddle.
> 
> Hello Peter,
> 
> I am trying to understand a little better the need for the eligibility
> checks (entity_eligible). I understand the general concept, but I am
> trying to find a scenario where it is necessary. And maybe propose to
> have it toggled by a feature flag.

My initial response was that it ensures fairness, but thinking a little
about it I'm not so sure anymore.

I do think it features in section 6 lemma 4 and 5, which provide
interference bounds. But I'd have to think a little more about it.

The current setup, where all requests are of equal size, then virtual
deadline tree is basically identical to the virtual runtime tree, just
transposed (in the static state scenario).

When mixing request sizes things become a little more interesting.

Let me ponder this a little bit more.
