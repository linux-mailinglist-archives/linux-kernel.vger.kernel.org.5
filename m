Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C6C79C312
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239325AbjILChZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239125AbjILChJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:37:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B2013E0CF;
        Mon, 11 Sep 2023 19:02:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D463EC433C9;
        Mon, 11 Sep 2023 20:51:28 +0000 (UTC)
Date:   Mon, 11 Sep 2023 16:51:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: add a tracepoint for damos apply
 target regions
Message-ID: <20230911165144.5002a0ac@gandalf.local.home>
In-Reply-To: <20230911203642.1788-1-sj@kernel.org>
References: <20230911163127.167dccc2@gandalf.local.home>
        <20230911203642.1788-1-sj@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023 20:36:42 +0000
SeongJae Park <sj@kernel.org> wrote:

> > Then tracing is fully enabled here, and now we enter:
> > 
> >  	if (trace_damos_before_apply_enabled()) {
> > 		trace_damos_before_apply(cidx, sidx, tidx, r,
> >  				damon_nr_regions(t));
> >  	}
> > 
> > Now the trace event is hit with sidx and tidx zero when they should not be.
> > This could confuse you when looking at the report.  
> 
> Thank you so much for enlightening me with this kind explanation, Steve!  And
> this all make sense.  I will follow your suggestion in the next spin.
> 
> > 
> > What I suggested was to initialize sidx to zero,  
> 
> Nit.  Initialize to not zero but -1, right?

Yeah, but I was also thinking of the reset of it too :-p

	sidx = -1;

	if (trace_damos_before_apply_enabled()) {
		sidx = 0;

-- Steve


> 
> > set it in the first trace_*_enabled() check, and ignore calling the
> > tracepoint if it's not >= 0.
> > 
