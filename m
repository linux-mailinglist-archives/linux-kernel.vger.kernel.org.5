Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73549799701
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 11:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243520AbjIIJLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 05:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjIIJLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 05:11:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E029186
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 02:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J6dc+6NSHPUiqap67zIGPnA5Z+cjTQVe7iBQeklvGHQ=; b=Oj5jd4tWVjecGGvfQTs0yKoEYQ
        bqVAx+Ecdd94MX5MaaLpet74G7+xVDearUgxjyxYr+lY9e9NNymnFEQfX5DeCE/mSQYP6pBi8y1xI
        JtoP1t2z6GrhDc3uBS/+TJyB3I7m0m3DZEL/AKbRwx+bgBSq4bLGW8O3O3P2E8DKmoBdJ7aOcNyYw
        CRHVK/AD7RdrXvQr5yjsUFHyZGZ+y1zGpYDZ8LbGXrZqKNODSobw4TcU5cYC592l+1Gb0Z5OQBIrR
        DLeRAmK2J6YRCdBAugKz+/SUlG1E0TaBR5cLxnu1anE6Uqj7QR4yXMc5484QTSj4It0NbqaBfHeHq
        P8Dai3qA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qetzb-003BPu-2G;
        Sat, 09 Sep 2023 09:11:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id C7116300348; Sat,  9 Sep 2023 11:11:04 +0200 (CEST)
Date:   Sat, 9 Sep 2023 11:11:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <20230909091104.GA2771@noisy.programming.kicks-ass.net>
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <CAHk-=wif4WMu-k9Pi9BoVRZwH6npjS6Km9DR9aROxANZzN2iRQ@mail.gmail.com>
 <20230908225018.GB32012@noisy.programming.kicks-ass.net>
 <CAHk-=wiU+5XUG4mDcjjBZFbCrZO+mGY-LfCCMshRbt+NjSmWyA@mail.gmail.com>
 <87sf7n6ea4.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sf7n6ea4.fsf@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 11:39:47PM -0700, Ankur Arora wrote:

> Yeah, exactly. Though, not even a single context level, but a flag
> attached to a single context at the process level only. Using
> preempt_count() == 0 as the preemption boundary.
> 
> However, this has a problem with the PREEMPT_COUNT=n case because that
> doesn't have a preemption boundary.

So, with a little sleep, the nested exception/interrupt case should be
good, irqenrty_enter() / irqentry_nmi_enter() unconditionally increment
preempt_count with HARDIRQ_OFFSET / NMI_OFFSET.

So while regular preempt_{dis,en}able() will turn into a NOP, the entry
code *will* continue to increment preempt_count.
