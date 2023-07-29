Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45212767D47
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 10:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjG2IrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 04:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjG2IrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 04:47:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7BF130;
        Sat, 29 Jul 2023 01:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=hZxS+x+pcA2ToPDaUJGjYOohekYFrjewNaNVS7Ilstc=; b=COUwAi2vBLkFax60GDJ079xgm7
        l9atmYYOgcbl+kn4l8Iy5pde/3yCNOX1xwYwYPppKrWajErYPJWWPcSjrRz2Xg0pq3NFeABGUkVqj
        QSiC+NDeBcYciIqfXb/n70jnsE/R8tWpmeG71q6XzVlZoqdLD4+bpa2BAAlWs9fbypot/+rfR5aPZ
        LilTjokhsJmLovenFArcFVt2SRIgliUdgSu91064hDqzzK5lr1rpvDWib+barevsAjmYcte6J0krP
        RTEuuetlKQnoeoeeVwNUQ/nXyV5M3xAhCkBklEZinOfDcbBDwtW0IVGDIIUWbKZYtnD+/3YE+pqTy
        8f3xefvQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qPfb2-009uZE-Cq; Sat, 29 Jul 2023 08:46:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6FFF93002CE;
        Sat, 29 Jul 2023 10:46:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 588B3202C39FE; Sat, 29 Jul 2023 10:46:44 +0200 (CEST)
Date:   Sat, 29 Jul 2023 10:46:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     anna-maria@linutronix.de, tglx@linutronix.de, frederic@kernel.org,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Subject: Re: [RFC][PATCH 3/3] cpuidle,teo: Improve state selection
Message-ID: <20230729084644.GC3945851@hirez.programming.kicks-ass.net>
References: <20230728145515.990749537@infradead.org>
 <20230728145808.970594909@infradead.org>
 <CAJZ5v0jk9DApNSo7Nq3ZMJh93NT89u310eHtkDwoS2mRj5N+=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jk9DApNSo7Nq3ZMJh93NT89u310eHtkDwoS2mRj5N+=Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 07:07:02PM +0200, Rafael J. Wysocki wrote:
> On Fri, Jul 28, 2023 at 5:01 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > When selecting a state, stop when history tells us 66% of recent idles
> > were at or below our current state.
> 
> This is not really about "recent idles" AFAICS.  It stops the
> selection when 66% of the total sum of the "hits" and "intercepts"
> signals comes from the current state and the states below it.  This
> covers the entire history, while the "recent" ones are counted
> separately.

Ah, bad wording perhaps. I found that 'recent' list teo has very hard to
use, also the regular state isn't that long lived as per the reply on
the previous patch.


