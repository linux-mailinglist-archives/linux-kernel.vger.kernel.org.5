Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C8E7B8162
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbjJDNw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjJDNwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:52:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCC4A9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 06:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/gMyA2N3WAtNVAOLvDM8BJ7C+Nl9C3EdFnjBkF7nCcs=; b=fofw+GC0ykQ4X03m5hpCquhSQp
        kzmiveduVynfsjLVA1u2J1rwPtmFv/9avC6ZSr4tjKi5T4fxHhUbIkUTHqntxMQwUu5W9yj5qLgE7
        jdxl8zPL+6izB3WoWjrl43FIZlXlbkhr9K3eA4nxbXY/pqLMvZWAZjnj14fSRAUfFzBPQkSbwQ726
        ugWfRqqSp95gdA6B+Ijg5AFP4el+W+375FASlpPJBt+2Ms+Ubq7CkHzyXezu9vqNXlVWGCpLB5p63
        h6EuPkoSzrrYB78UQFvL+Zm6PA9n47XNgWiuOlPguKSaYtR7/1hJG2LAqnou98YmRxDVHyCvpFATq
        nSIPw71Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qo2Il-00AqJX-0U;
        Wed, 04 Oct 2023 13:52:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4637C300392; Wed,  4 Oct 2023 15:52:36 +0200 (CEST)
Date:   Wed, 4 Oct 2023 15:52:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>
Subject: Re: [PATCH v4] sched/core: Use zero length to reset cpumasks in
 sched_setaffinity()
Message-ID: <20231004135236.GB19999@noisy.programming.kicks-ass.net>
References: <20231003205735.2921964-1-longman@redhat.com>
 <20231004083648.GI27267@noisy.programming.kicks-ass.net>
 <871qeaefco.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qeaefco.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 02:34:15PM +0200, Florian Weimer wrote:
> * Peter Zijlstra:
> 
> > Subject: sched: Add CPU_FILL()
> >
> > Add the CPU_FILL() macros to easily create an all-set cpumask.
> >
> > FreeBSD also provides this macro with this semantic.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> My main concer is that obtaining the size of the mask, or at least an
> approximiation is not exactly easy.  If there's an expectation that
> applications reset the mask more often than they do today (I don't have
> the full context here), then we'd some decent interface to get the
> approriate size.

Isn't sysconf(_SC_NPROCESSORS_CONF) the right number ?
