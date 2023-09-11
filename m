Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB28379B83A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350140AbjIKVfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244446AbjIKUgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:36:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ECC127;
        Mon, 11 Sep 2023 13:36:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34974C433C7;
        Mon, 11 Sep 2023 20:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694464604;
        bh=yVeFYLRhbU/RAZJ0Yo6GGmsolJbZL5KOh1ydQnNikFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n++o38YD9g0rkZTjGjoVS58Qce5RnDBBcRebGc0mzehPYzDGSOiYt3Ys8E7B6nEpV
         grKF4Nv+NwZT1fhq1p+sIcuCTnWuzv39djNo42NCbCw+rnoWEzsmGqWS1CFyZtsOQq
         XnCh4D5D7T4/iPOMCPScod5ytfDZ6NcGDKPVN2606C9QJ5fjEnFDiI3PRVGI87wu8B
         +6dyKlGlZt78voQotkICd2ZNBXBwMgBGzZW6w5Sx34ztgX/fd3nKGUVL9WtvSrj9Sq
         Y7Qiq9jBmy/Va3KfEBeO5v62EffRy94l8v8ZufAyDKODCVpg5bgwSenh8SaKeM5gSO
         aOK/e3snuyX+g==
From:   SeongJae Park <sj@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: add a tracepoint for damos apply target regions
Date:   Mon, 11 Sep 2023 20:36:42 +0000
Message-Id: <20230911203642.1788-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911163127.167dccc2@gandalf.local.home>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023 16:31:27 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 11 Sep 2023 19:05:04 +0000
> SeongJae Park <sj@kernel.org> wrote:
> 
> > > Also, this if statement is only done when the trace event is enabled, so
> > > it's equivalent to:
> > > 
> > > 	if (trace_damos_before_apply_enabled()) {
> > > 		if (sdx >= 0)
> > > 			trace_damos_before_apply(cidx, sidx, tidx, r,
> > > 					damon_nr_regions(t));
> > > 	}  
> > 
> > Again, thank you very much for letting me know this awesome feature.  However,
> > sidx is supposed to be always >=0 here, since kdamond is running in single
> > thread and hence no race is expected.  If it exists, it's a bug.  So, I
> > wouldn't make this change.  Appreciate again for letting me know this very
> > useful feature, and please let me know if I'm missing something, though!
> 
> The race isn't with your code, but the enabling of tracing.
> 
> Let's say you enable tracing just ass it passed the first:
> 
> 	if (trace_damos_before_apply_enabled()) {
>    
> 		damon_for_each_scheme(siter, c) {
> 			if (siter == s)
> 				break;
> 			sidx++;
> 		}
> 		damon_for_each_target(titer, c) {
> 			if (titer == t)
> 				break;
> 			tidx++;
> 	}  
> 
> Now, sidx and tidx is zero (when they were not computed, thus, they
> shouldn't be zero.
> 
> Then tracing is fully enabled here, and now we enter:
> 
>  	if (trace_damos_before_apply_enabled()) {
> 		trace_damos_before_apply(cidx, sidx, tidx, r,
>  				damon_nr_regions(t));
>  	}
> 
> Now the trace event is hit with sidx and tidx zero when they should not be.
> This could confuse you when looking at the report.

Thank you so much for enlightening me with this kind explanation, Steve!  And
this all make sense.  I will follow your suggestion in the next spin.

> 
> What I suggested was to initialize sidx to zero,

Nit.  Initialize to not zero but -1, right?

> set it in the first trace_*_enabled() check, and ignore calling the
> tracepoint if it's not >= 0.
> 
> -- Steve
> 


Thanks,
SJ
