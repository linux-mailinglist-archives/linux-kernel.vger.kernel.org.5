Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9198E7B816D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242701AbjJDNzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjJDNzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:55:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2CDA1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 06:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ROXXtmAjPeh1/YOvRF7YUBJoz3uZzkoxIMFjJkaEIgA=; b=LMp2eJUXhNoxPnNl15qOA7dttV
        eiL9rXbQ4V70h9r97M8I4rB75OFVp+iKyJ0NemPyMXUVU5rmilRObapLZXLSXOrIVU/hz6ReFgZ9u
        qe6Fndpulog9JU1PCLLZetuzT8ZiLeegApS+is6WUGpo/luE1e4+V/aYJhmPaxXnrsqiBOXKqk/AG
        Iv9UX19H+j3aQ4PKsrOxWSkGLiFx5qpaUy6ua94t6LZkW+41yr5+9tO7A3tiIlst03nUzllAolG50
        X65D5P0aOFmJD1Q3gcF0bEGnAJaz6FJtHozKqjfFsG4XbhTMb1Kyti77/LAKdHyZH1HrTseVXkpnp
        9BJ8v+Jw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qo2L0-003i8m-2f; Wed, 04 Oct 2023 13:54:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id BAB8D300392; Wed,  4 Oct 2023 15:54:53 +0200 (CEST)
Date:   Wed, 4 Oct 2023 15:54:53 +0200
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
Message-ID: <20231004135453.GB6337@noisy.programming.kicks-ass.net>
References: <20231003205735.2921964-1-longman@redhat.com>
 <20231004083648.GI27267@noisy.programming.kicks-ass.net>
 <871qeaefco.fsf@oldenburg.str.redhat.com>
 <20231004135236.GB19999@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004135236.GB19999@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 03:52:36PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 04, 2023 at 02:34:15PM +0200, Florian Weimer wrote:
> > * Peter Zijlstra:
> > 
> > > Subject: sched: Add CPU_FILL()
> > >
> > > Add the CPU_FILL() macros to easily create an all-set cpumask.
> > >
> > > FreeBSD also provides this macro with this semantic.
> > >
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > My main concer is that obtaining the size of the mask, or at least an
> > approximiation is not exactly easy.  If there's an expectation that
> > applications reset the mask more often than they do today (I don't have
> > the full context here),

Well, the only time a reset is useful, is if they first set an affinity.
So on the whole, you need the mask size thing solved either way around,
you need it for setting and then re-setting.

> > then we'd some decent interface to get the
> > approriate size.
> 
> Isn't sysconf(_SC_NPROCESSORS_CONF) the right number ?
