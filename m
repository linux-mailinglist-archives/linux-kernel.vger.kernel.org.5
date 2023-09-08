Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2E5799267
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 00:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344209AbjIHWst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 18:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245597AbjIHWsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 18:48:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0D61FEB;
        Fri,  8 Sep 2023 15:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fRN1u2nqNkgfLlg5vCIRLVf7sVuYtWHo65n7KgqIXfY=; b=A7s/QcFH1OtqD4N1HXyJG63L4Q
        j5WyQcSA3kobfAFfAp2qYxX843GAGbLGVXdQI0/1s7vM7uNyVikJu6xNS+5sK3hXXGsi3gfQ8hEIn
        DV/ergTLfjJrGNYC0ah0hcQ+4GaeCgsJpEHiNILR0QQMQG5VZ2xDS/6HU90rXRSj3iqYcfKB8nJRA
        82gWfonMICNdxXKgyA9ufisOnxkiCAedDGmcgizcyrbEoe7rnnN/reG+L7gnvcAnQgpLniv4260pY
        zu2CRxZ7BcUQym6/C+2y1YHcN/Re8eMxC5BflhmYiIy1w+jWPjXiQd73Cehr2AgA4YVoev/LOPmSz
        Fsb8dAdA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qekH7-002nP4-LY; Fri, 08 Sep 2023 22:48:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F246300353; Sat,  9 Sep 2023 00:48:29 +0200 (CEST)
Date:   Sat, 9 Sep 2023 00:48:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>, kernel@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Prakash Viswalingam <quic_prakashv@quicinc.com>
Subject: Re: [PATCH v2] freezer,sched: Use saved_state to reduce some
 spurious wakeups
Message-ID: <20230908224829.GA32012@noisy.programming.kicks-ass.net>
References: <20230830-avoid-spurious-freezer-wakeups-v2-1-8877245cdbdc@quicinc.com>
 <20230904212324.GA2568@noisy.programming.kicks-ass.net>
 <df61af06-a43e-05c5-66e8-5a68b08ff14b@quicinc.com>
 <20230907094651.GB16872@noisy.programming.kicks-ass.net>
 <4c5b5a0b-6d78-878e-7e66-e08e83e6e1c8@quicinc.com>
 <20230908220804.GA29218@noisy.programming.kicks-ass.net>
 <783c60ef-5341-7893-e9e8-2b1b249f89c9@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <783c60ef-5341-7893-e9e8-2b1b249f89c9@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 03:30:43PM -0700, Elliot Berman wrote:
> 
> 
> On 9/8/2023 3:08 PM, Peter Zijlstra wrote:
> > On Fri, Sep 08, 2023 at 01:08:07PM -0700, Elliot Berman wrote:
> > 
> >>> Perhaps we should start off by doing the below, instead of making it
> >>> more complicated instead. I suppose you're right about the overhead, but
> >>> run a hackbench just to make sure or something.
> >>>
> >>
> >> I ran perf bench sched message -g 40 -l 40 with the v3 patch [1]. After 60
> >> iterations each, I don't see a significant difference on my arm64 platform:
> >> both samples ~normal and ~eq variance w/t-test p-value: 0.79.
> >>
> >> We also ran typical high level benchmarks for our SoCs (antutu,
> >> geekbench, et. al) and didn't see any regressions there.
> > 
> > So if you would've made this 2 patches, the first removing the ifdef,
> > then the changelog for that patch would be a good place to mention it
> > doesn't measurably regress things.
> 
> No problem, easily done.
> 
> > As a bonus, it then makes your other changes smaller too ;-)
> 
> Did you mean that each commit is smaller but overall delta is the same
> or something else? 

That.

> I still wanted to update comments on saved_state in
> kernel/sched/core.c as it gives good explanation of what is going on. I
> have split the commit but want to make sure I make the changes you were
> thinking :-)

well, it's nearly 1am, I'm not thinking very much :-) Changing those
comments seems fine when you add the freezer thing.
