Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D490771F10
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjHGLBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjHGLBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:01:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F1E10FA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 04:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691406017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R+iPVr47N7bKYNd0s7qLkiMufN9f9ERRqZmsaHbfMOk=;
        b=gWEC+WWVDYGB7P77M6FTBhdftRElH+azpAs/0YqKdXjTnjiSZqoXWTuzEfXm8DGVYs/q5F
        dJKxudrdeItwmHlrfYE6MAEQtRQ8Kh2DfiG6BLwWahGmFOTzw5lm3cnGuW1DB+5fbs1f70
        fLnpFgjNiOch4oV7aQDwlzZvbvvxK9o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-7IvRzP0UPe6JUkFbBOdltQ-1; Mon, 07 Aug 2023 07:00:15 -0400
X-MC-Unique: 7IvRzP0UPe6JUkFbBOdltQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F34E85CCE0;
        Mon,  7 Aug 2023 11:00:14 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.45.225.231])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B4CB403168;
        Mon,  7 Aug 2023 11:00:11 +0000 (UTC)
Date:   Mon, 7 Aug 2023 13:00:08 +0200
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
Message-ID: <20230807110008.GA886657@alecto.usersys.redhat.com>
References: <ZMl8VyhdwhClTM5g@kernel.org>
 <20230802074335.GA622710@alecto.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230802074335.GA622710@alecto.usersys.redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 09:43:40AM +0200, Artem Savkov wrote:
> Hi Arnaldo,
> 
> On Tue, Aug 01, 2023 at 06:42:47PM -0300, Arnaldo Carvalho de Melo wrote:
> > Hi Artem,
> > 
> > 	Can you please double check this? I reproduced with:
> > 
> > git checkout 46d21ec067490ab9cdcc89b9de5aae28786a8b8e
> > build it
> > perf record -a -g sleep 5s
> > perf report
> > 
> > 	Do you get the same slowness and then reverting it, i.e. just
> > going to HEAD~ and rebuilding getting a fast 'perf report' startup, i.e.
> > without the inlines in the callchains?
> 
> With a simple test like this I definitely get a slowdown, but not sure
> if it can be called excessive.
> 
> Below are the times I got by running 'time perf report' and hitting 'q'
> during load so that it quits as soon as it is loads up. Tested on a
> freshly updated fedora 38.

My bad, I had wrong debuginfo installed for the kernel I tested. I can
reproduce it with the correct one. Looks like vmlinux is just too much
for addr2line. Maybe we can skip it but leave other inlines in, like so:

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 11de3ca8d4fa7..fef309cd401f7 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2388,7 +2388,9 @@ static int add_callchain_ip(struct thread *thread,
 	ms.map = map__get(al.map);
 	ms.sym = al.sym;
 
-	if (!branch && append_inlines(cursor, &ms, ip) == 0)
+	if (!branch && ms.map && ms.map->dso &&
+	    strcmp(ms.map->dso->short_name, "[kernel.vmlinux]") &&
+	    append_inlines(cursor, &ms, ip) == 0)
 		goto out;
 
 	srcline = callchain_srcline(&ms, al.addr);

> > - Arnaldo
> > 
> > ----
> > 
> > This reverts commit 46d21ec067490ab9cdcc89b9de5aae28786a8b8e.
> > 
> > The tests were made with a specific workload, further tests on a
> > recently updated fedora 38 system with a system wide perf.data file
> > shows 'perf report' taking excessive time, so lets revert this until a
> > full investigation and improvement on the addr2line support code is
> > made.
> > 
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Artem Savkov <asavkov@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Milian Wolff <milian.wolff@kdab.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/machine.c | 5 -----
> >  1 file changed, 5 deletions(-)
> > 
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 4e62843d51b7dbf9..f4cb41ee23cdbcfc 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -45,7 +45,6 @@
> >  
> >  static void __machine__remove_thread(struct machine *machine, struct thread_rb_node *nd,
> >  				     struct thread *th, bool lock);
> > -static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms, u64 ip);
> >  
> >  static struct dso *machine__kernel_dso(struct machine *machine)
> >  {
> > @@ -2385,10 +2384,6 @@ static int add_callchain_ip(struct thread *thread,
> >  	ms.maps = maps__get(al.maps);
> >  	ms.map = map__get(al.map);
> >  	ms.sym = al.sym;
> > -
> > -	if (!branch && append_inlines(cursor, &ms, ip) == 0)
> > -		goto out;
> > -
> >  	srcline = callchain_srcline(&ms, al.addr);
> >  	err = callchain_cursor_append(cursor, ip, &ms,
> >  				      branch, flags, nr_loop_iter,
> > -- 
> > 2.41.0
> > 
> 
> -- 
>  Artem

-- 
 Artem

