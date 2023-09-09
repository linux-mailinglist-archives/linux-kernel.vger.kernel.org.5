Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AF7799700
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 11:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344179AbjIIJMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 05:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjIIJMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 05:12:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A1F186
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 02:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4Q41XD6aAL8qYQICasOpXthrfZvtnZ7Lrq/xMrmSAV8=; b=iGnpohwyzJhvUA6AuJWq4u5ctK
        WBYToF3pNM94A3OWWugWuegSB6MF8DV7z3EghQ3xJGkpgHE88KCSOdNnSRzAHWAXFXlGA3maMuU4H
        SpU8OmgsQtHjW6YZ/2QYXPBF2NWqB9cfuiOWPm3cZTvFDy8fOWX+7AboZq5SvTuqhqqgtwULwCyvc
        IIj/UlEOyDJUYjpU0kLMhxMahzdT+1n0Hg7m9d4x3p4XyUbULWzeWU3zrkGaADUSjKlgqsPANBcbY
        xgO7gM1pg7nWgxrvYhSCqe0+VsKCeB0zNws157zHyx3vWeCV1+Ej5Um0KxwNkrbOCsVLqEetW4drs
        NH0HE4pA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qeu0Z-003BRC-1Z;
        Sat, 09 Sep 2023 09:12:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8EBDA300348; Sat,  9 Sep 2023 11:12:04 +0200 (CEST)
Date:   Sat, 9 Sep 2023 11:12:04 +0200
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
Message-ID: <20230909091204.GB2771@noisy.programming.kicks-ass.net>
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <CAHk-=wif4WMu-k9Pi9BoVRZwH6npjS6Km9DR9aROxANZzN2iRQ@mail.gmail.com>
 <87v8cj9alq.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8cj9alq.fsf@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 10:30:57PM -0700, Ankur Arora wrote:

> > which actually makes me worry about the nested irq case, because this
> > would *not* be ok:
> >
> >         allow_resched();
> >            -> irq happens
> >                 -> *nested* irq happens
> >                 <- nested irq return (andapreemption)
> >
> > ie the allow_resched() needs to still honor the irq count, and a
> > nested irq return obviously must not cause any preemption.
> 
> IIUC, this should be equivalent to:
> 
> 01         allow_resched();
> 02            -> irq happens
> 03               preempt_count_add(HARDIRQ_OFFSET);
> 04                -> nested irq happens
> 05                   preempt_count_add(HARDIRQ_OFFSET);
> 06
> 07                   preempt_count_sub(HARDIRQ_OFFSET);
> 08                 <- nested irq return
> 09               preempt_count_sub(HARDIRQ_OFFSET);
> 
> So, even if there were nested interrrupts, then the !preempt_count()
> check in raw_irqentry_exit_cond_resched() should ensure that no
> preemption happens until after line 09.

Yes, this.
