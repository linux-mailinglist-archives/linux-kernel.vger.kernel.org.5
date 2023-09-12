Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA2679C2A5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbjILCVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbjILCUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:20:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15188A49;
        Mon, 11 Sep 2023 18:43:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DFFC116A1;
        Tue, 12 Sep 2023 01:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694482990;
        bh=MZfgo6MURz3BgruLFMBLXwS/8zrB+gqE+MzIheFwuyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q9uNrRTYqaajPGhKYGdTDqSCvE+I3yEoL60HbVUdoQoEJ7vzKYfmNUP53+Mypx2q1
         8OIwfqagUNN5TnPbd5zsQPJLoSvgv5bdmvWmyzpcegmaus2km+4OdqGibOxNLDgy5t
         k4RdZ78uKAfS++llOiKcM3aTM9rEajLrrCs7gXmwPg+j71glXOaXNbtJWPF87eym0b
         apqMKxjA67c24htXl1O76cWLhuaGPlRSk5sC7FsSVFbEupM5cwJOtiNnXoQqRqgB13
         NO903WTV7hKDNuhOb1PEAzexCl5j0DEkNDlXmS5f3K9yBmLmp3PAEtWy9bIj+Jm4cB
         9qAACSsgygBxQ==
From:   SeongJae Park <sj@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: add a tracepoint for damos apply target regions
Date:   Tue, 12 Sep 2023 01:43:08 +0000
Message-Id: <20230912014308.38298-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911165144.5002a0ac@gandalf.local.home>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023 16:51:44 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 11 Sep 2023 20:36:42 +0000
> SeongJae Park <sj@kernel.org> wrote:
> 
> > > Then tracing is fully enabled here, and now we enter:
> > > 
> > >  	if (trace_damos_before_apply_enabled()) {
> > > 		trace_damos_before_apply(cidx, sidx, tidx, r,
> > >  				damon_nr_regions(t));
> > >  	}
> > > 
> > > Now the trace event is hit with sidx and tidx zero when they should not be.
> > > This could confuse you when looking at the report.  
> > 
> > Thank you so much for enlightening me with this kind explanation, Steve!  And
> > this all make sense.  I will follow your suggestion in the next spin.
> > 
> > > 
> > > What I suggested was to initialize sidx to zero,  
> > 
> > Nit.  Initialize to not zero but -1, right?
> 
> Yeah, but I was also thinking of the reset of it too :-p
> 
> 	sidx = -1;
> 
> 	if (trace_damos_before_apply_enabled()) {
> 		sidx = 0;

Thank you for clarifying, Steve :)

Nevertheless, since the variable is unsigned int, I would need to use UINT_MAX
instead.  To make the code easier to understand, I'd prefer to add a third
parameter, as you suggested as another option at the original reply, like
below:

--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -997,6 +997,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
        unsigned int sidx = 0;
        struct damon_target *titer;     /* targets iterator */
        unsigned int tidx = 0;
+       bool do_trace = false;

        /* get indices for trace_damos_before_apply() */
        if (trace_damos_before_apply_enabled()) {
@@ -1010,6 +1011,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
                                break;
                        tidx++;
                }
+               do_trace = true;
        }

        if (c->ops.apply_scheme) {
@@ -1036,7 +1038,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
                        err = c->callback.before_damos_apply(c, t, r, s);
                if (!err) {
                        trace_damos_before_apply(cidx, sidx, tidx, r,
-                                       damon_nr_regions(t));
+                                       damon_nr_regions(t), do_trace);
                        sz_applied = c->ops.apply_scheme(c, t, r, s);
                }
                ktime_get_coarse_ts64(&end);


Thanks,
SJ

> 
> -- Steve
> 
> 
> > 
> > > set it in the first trace_*_enabled() check, and ignore calling the
> > > tracepoint if it's not >= 0.
> > > 
