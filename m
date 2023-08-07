Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D737725E0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbjHGNfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbjHGNe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:34:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C56F199E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:34:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A99461B4B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0885CC433C7;
        Mon,  7 Aug 2023 13:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691415287;
        bh=23g4TF7jUSDvHuW9nQLpzshE2Y0FqB478rLGyEZGXV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KGmRcSOWJcTpShFnZkD26ZLcyk040TecQjHCBiy3mDL16U8vVoRsJcxDiyh/brdeg
         rfa6GCkagDLqkVFGGkhTvxbfIhYjYl+7ln6wDT6ZMzz9AdzIIaTsu6UOjJmHW3Xt0X
         U4J4Jei768DZPs1BK2+gyNk+4xzQWA82hGt22Sa+10aWUv2Cg3X9rqD6HLenthqXtJ
         nCsKEatkLpYECotDwqg/2o0HqecgNBZWiRoYEsmT1qucGtm1HWzFzJFtUlHQFR6Vfp
         RWQIKR2vmbXruuP2hWVjBBwqo64hIQLnIOWPui8ZPJyPlOwUbdQLRvZL8WZvfV+Ree
         tUpaDywaZJPsw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 50E0B404DF; Mon,  7 Aug 2023 10:34:44 -0300 (-03)
Date:   Mon, 7 Aug 2023 10:34:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Artem Savkov <asavkov@redhat.com>
Cc:     Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Milian Wolff <milian.wolff@kdab.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] Revert "perf report: Append inlines to non-DWARF
 callchains"
Message-ID: <ZNDy9EBLsUlERql6@kernel.org>
References: <ZMl8VyhdwhClTM5g@kernel.org>
 <20230802074335.GA622710@alecto.usersys.redhat.com>
 <20230807110008.GA886657@alecto.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807110008.GA886657@alecto.usersys.redhat.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 07, 2023 at 01:00:08PM +0200, Artem Savkov escreveu:
> On Wed, Aug 02, 2023 at 09:43:40AM +0200, Artem Savkov wrote:
> > Hi Arnaldo,
> > 
> > On Tue, Aug 01, 2023 at 06:42:47PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Hi Artem,
> > > 
> > > 	Can you please double check this? I reproduced with:
> > > 
> > > git checkout 46d21ec067490ab9cdcc89b9de5aae28786a8b8e
> > > build it
> > > perf record -a -g sleep 5s
> > > perf report
> > > 
> > > 	Do you get the same slowness and then reverting it, i.e. just
> > > going to HEAD~ and rebuilding getting a fast 'perf report' startup, i.e.
> > > without the inlines in the callchains?
> > 
> > With a simple test like this I definitely get a slowdown, but not sure
> > if it can be called excessive.
> > 
> > Below are the times I got by running 'time perf report' and hitting 'q'
> > during load so that it quits as soon as it is loads up. Tested on a
> > freshly updated fedora 38.
> 
> My bad, I had wrong debuginfo installed for the kernel I tested. I can
> reproduce it with the correct one. Looks like vmlinux is just too much
> for addr2line. Maybe we can skip it but leave other inlines in, like so:

That is a possibilit, and probably we could make it cheaper by looking
at the cpumode, avoiding calling addr2line when we didn't makage to
resolve the symbol, etc.

We also may want to have this as an option that has to be explicitely
enabled, like --resolve-inlines, as this will add overhead no matter if
we stop calling addr2line and do it more efficiently, etc.

Fact is, we're late in the 6.5 schedule, so the best thing now is to
just revert the patch and then try again later, ok?

- Arnaldo
 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 11de3ca8d4fa7..fef309cd401f7 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2388,7 +2388,9 @@ static int add_callchain_ip(struct thread *thread,
>  	ms.map = map__get(al.map);
>  	ms.sym = al.sym;
>  
> -	if (!branch && append_inlines(cursor, &ms, ip) == 0)
> +	if (!branch && ms.map && ms.map->dso &&
> +	    strcmp(ms.map->dso->short_name, "[kernel.vmlinux]") &&
> +	    append_inlines(cursor, &ms, ip) == 0)
>  		goto out;
>  
>  	srcline = callchain_srcline(&ms, al.addr);
> 
> > > - Arnaldo
> > > 
> > > ----
> > > 
> > > This reverts commit 46d21ec067490ab9cdcc89b9de5aae28786a8b8e.
> > > 
> > > The tests were made with a specific workload, further tests on a
> > > recently updated fedora 38 system with a system wide perf.data file
> > > shows 'perf report' taking excessive time, so lets revert this until a
> > > full investigation and improvement on the addr2line support code is
> > > made.
> > > 
> > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > Cc: Artem Savkov <asavkov@redhat.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > Cc: Milian Wolff <milian.wolff@kdab.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > ---
> > >  tools/perf/util/machine.c | 5 -----
> > >  1 file changed, 5 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > > index 4e62843d51b7dbf9..f4cb41ee23cdbcfc 100644
> > > --- a/tools/perf/util/machine.c
> > > +++ b/tools/perf/util/machine.c
> > > @@ -45,7 +45,6 @@
> > >  
> > >  static void __machine__remove_thread(struct machine *machine, struct thread_rb_node *nd,
> > >  				     struct thread *th, bool lock);
> > > -static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms, u64 ip);
> > >  
> > >  static struct dso *machine__kernel_dso(struct machine *machine)
> > >  {
> > > @@ -2385,10 +2384,6 @@ static int add_callchain_ip(struct thread *thread,
> > >  	ms.maps = maps__get(al.maps);
> > >  	ms.map = map__get(al.map);
> > >  	ms.sym = al.sym;
> > > -
> > > -	if (!branch && append_inlines(cursor, &ms, ip) == 0)
> > > -		goto out;
> > > -
> > >  	srcline = callchain_srcline(&ms, al.addr);
> > >  	err = callchain_cursor_append(cursor, ip, &ms,
> > >  				      branch, flags, nr_loop_iter,
> > > -- 
> > > 2.41.0
> > > 
> > 
> > -- 
> >  Artem
> 
> -- 
>  Artem
> 

-- 

- Arnaldo
