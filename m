Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6D076C758
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbjHBHrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjHBHrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:47:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EA63C0F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690962227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JFUcGNyD24U1i9MJG6CCP0tDnMgYNxQlSEqN/mEfB+g=;
        b=b610DIcZ4VhaOL9B4zHACRxPzlwdLqTpHaGt06/Yh4zbtuY7mUwGXlz1r18UQRtWFL0fhQ
        25KYrNi6hfsv41JkC43m95kxYuXPV9zD3/s5arSVKJ4fAEdtdBwwxG+b07qi7n581MdbqW
        rCS45sQhQXpYVVKAfkdQIVm3jqCxtYs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-i4C96D6YMCaibwFKS7edOA-1; Wed, 02 Aug 2023 03:43:40 -0400
X-MC-Unique: i4C96D6YMCaibwFKS7edOA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15A448910E9;
        Wed,  2 Aug 2023 07:43:40 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 13CC840C2063;
        Wed,  2 Aug 2023 07:43:37 +0000 (UTC)
Date:   Wed, 2 Aug 2023 09:43:35 +0200
From:   Artem Savkov <asavkov@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
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
Message-ID: <20230802074335.GA622710@alecto.usersys.redhat.com>
References: <ZMl8VyhdwhClTM5g@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZMl8VyhdwhClTM5g@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Tue, Aug 01, 2023 at 06:42:47PM -0300, Arnaldo Carvalho de Melo wrote:
> Hi Artem,
> 
> 	Can you please double check this? I reproduced with:
> 
> git checkout 46d21ec067490ab9cdcc89b9de5aae28786a8b8e
> build it
> perf record -a -g sleep 5s
> perf report
> 
> 	Do you get the same slowness and then reverting it, i.e. just
> going to HEAD~ and rebuilding getting a fast 'perf report' startup, i.e.
> without the inlines in the callchains?

With a simple test like this I definitely get a slowdown, but not sure
if it can be called excessive.

Below are the times I got by running 'time perf report' and hitting 'q'
during load so that it quits as soon as it is loads up. Tested on a
freshly updated fedora 38.

For 'perf record -a -g sleep 60' (Event count (approx.): 774055090):

with inlines:
$ time ./perf report

real    0m1.477s
user    0m1.324s
sys     0m0.147s

without inlines:
$ time ./perf report

real    0m1.349s
user    0m1.232s
sys     0m0.111s

For 'perf record -a -g sleep 5' (Event count (approx.): 90179399):

with inlines:
$ time ./perf report

real    0m0.657s
user    0m0.555s
sys     0m0.099s

without inlines:
$ time ./perf report

real    0m0.559s
user    0m0.498s
sys     0m0.060s


> - Arnaldo
> 
> ----
> 
> This reverts commit 46d21ec067490ab9cdcc89b9de5aae28786a8b8e.
> 
> The tests were made with a specific workload, further tests on a
> recently updated fedora 38 system with a system wide perf.data file
> shows 'perf report' taking excessive time, so lets revert this until a
> full investigation and improvement on the addr2line support code is
> made.
> 
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Artem Savkov <asavkov@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Milian Wolff <milian.wolff@kdab.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/machine.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 4e62843d51b7dbf9..f4cb41ee23cdbcfc 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -45,7 +45,6 @@
>  
>  static void __machine__remove_thread(struct machine *machine, struct thread_rb_node *nd,
>  				     struct thread *th, bool lock);
> -static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms, u64 ip);
>  
>  static struct dso *machine__kernel_dso(struct machine *machine)
>  {
> @@ -2385,10 +2384,6 @@ static int add_callchain_ip(struct thread *thread,
>  	ms.maps = maps__get(al.maps);
>  	ms.map = map__get(al.map);
>  	ms.sym = al.sym;
> -
> -	if (!branch && append_inlines(cursor, &ms, ip) == 0)
> -		goto out;
> -
>  	srcline = callchain_srcline(&ms, al.addr);
>  	err = callchain_cursor_append(cursor, ip, &ms,
>  				      branch, flags, nr_loop_iter,
> -- 
> 2.41.0
> 

-- 
 Artem

