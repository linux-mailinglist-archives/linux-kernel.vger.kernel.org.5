Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8D779927C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 00:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344558AbjIHWvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 18:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242634AbjIHWvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 18:51:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20A11FF6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 15:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fZXJRL8nPOvN6Vw7zQ/cvPU2e3LHsiOLniAY/2LW660=; b=ilKhM7+23C7sjucxSsPzHD7Y4G
        4Ty+dzfIrbLlBmVx5veFESguTyVeih5qhjP1+wbu/0Wnj8iB9521UP25t3pZ23aw8LAid5xMEgV2b
        DgQM/Ufdfs2H5gAP/nFCvLoWvWleeY9rUyaXr/dLzsqCZKHfsPhuNW9d21Dtx6eSIAQdEE/lXH979
        jnRVqYPOkahdTGWgUnaivBjmuj94OojgWE1m+d6SOHQhwj8VCzEvlRe65/chc6cC3TtCVG1+PoI8W
        n+1Gnr0Elfb7yYx22KAEe87xryKpP+EL8SHmnEVWH1uNQdHzRLvNGEl3Aj/uwjecqLkIjFqiR3X+K
        W41Os04A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qekIs-002nUM-FC; Fri, 08 Sep 2023 22:50:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 202E8300353; Sat,  9 Sep 2023 00:50:18 +0200 (CEST)
Date:   Sat, 9 Sep 2023 00:50:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <20230908225018.GB32012@noisy.programming.kicks-ass.net>
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <CAHk-=wif4WMu-k9Pi9BoVRZwH6npjS6Km9DR9aROxANZzN2iRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wif4WMu-k9Pi9BoVRZwH6npjS6Km9DR9aROxANZzN2iRQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 10:15:07AM -0700, Linus Torvalds wrote:
> On Fri, 8 Sept 2023 at 00:03, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Which on a PREEMPT_COUNT=n build will cause preemption while holding the
> > spinlock. I think something like the below will cause sufficient
> > warnings to avoid growing patterns like that.
> 
> Hmm. I don't think that warning is valid.
> 
> Disabling preemption is actually fine if it's done in an interrupt,
> iow if we have
> 
>         allow_resched();
>            -> irq happens
>                 spin_lock();  // Ok and should *not* complain
>                 ...
>                 spin_unlock();
>             <- irq return (and preemption)

Indeed.

> 
> which actually makes me worry about the nested irq case, because this
> would *not* be ok:
> 
>         allow_resched();
>            -> irq happens
>                 -> *nested* irq happens
>                 <- nested irq return (and preemption)
> 
> ie the allow_resched() needs to still honor the irq count, and a
> nested irq return obviously must not cause any preemption.

I think we killed nested interrupts a fair number of years ago, but I'll
recheck -- but not today, sleep is imminent.

