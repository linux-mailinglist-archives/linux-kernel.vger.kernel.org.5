Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6187D17C3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjJTVIh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Oct 2023 17:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjJTVIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:08:24 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D77A10C7;
        Fri, 20 Oct 2023 14:08:18 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-27d1373f631so994718a91.1;
        Fri, 20 Oct 2023 14:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697836097; x=1698440897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMQasgZjpOl1DCFinwfvRlcT3Yj5p5ETw7uv0PZtWMM=;
        b=FxsxZbfXueFAkIRz4x5l2J659W28JpAOQdLzmmRrhjjQQ78D51E1mxqZ6jZBCjabDR
         gKdk5CJ0f5ZL/N2re/M3bGGmooGtwllezIj8hLMo9KBMmcQ13skVersp+8HoXyNTANbJ
         /sboovUtkx3upt2w+9DDgp8WfJvTUmaBVf/mh8g1lom2hbmnNeJ3oNF80gOkCqswRDog
         MhSEOAfjo9XpaJpB4MmBe7AE61glo8/Csuh0WwIZQERZuYcMGGovRqeuhDxN0SCCa1ns
         ze//orVKvvEbjhibTkFu2sqzrFAXPZXshjClgMB0a5euZaGEALh+StSqeNMC2BQ+nYO7
         cuqw==
X-Gm-Message-State: AOJu0Yxz+BoQvMooM7BPfqjR/OVvtEgCm8YqBShIn8tR2pKTQ/Sm3O15
        TPmDuWemNWYoHR5ZoT7hIbiN06qS57UzXA0Mz7M=
X-Google-Smtp-Source: AGHT+IFWTqdHIsafpewxkk4ZrVoJcJsJ7XuBH0C0xeOS65OF9x/7j8Ee1yiZIKAaGC5lEaqhmBJHvmLMF9Lz1G5yLOM=
X-Received: by 2002:a17:90b:a16:b0:27d:9bef:1454 with SMTP id
 gg22-20020a17090b0a1600b0027d9bef1454mr2849617pjb.22.1697836097337; Fri, 20
 Oct 2023 14:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com> <20231012062359.1616786-14-irogers@google.com>
 <CAM9d7citTUkj5z4bu0HsF73Msnks=2vOBcZU5skT77zUri_Bag@mail.gmail.com> <CAP-5=fU6ghEpYqy0FhSvxUQ_RSan34Mjp0GDys84FyPcRz_W0w@mail.gmail.com>
In-Reply-To: <CAP-5=fU6ghEpYqy0FhSvxUQ_RSan34Mjp0GDys84FyPcRz_W0w@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 20 Oct 2023 14:08:06 -0700
Message-ID: <CAM9d7ciwWYeam0RfvKm+ck2op4q6x2rnp8rrP=zuzQzo1dMnPQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] perf machine thread: Remove exited threads by default
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        James Clark <james.clark@arm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Artem Savkov <asavkov@redhat.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 5:39 PM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Oct 18, 2023 at 4:30 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, Oct 11, 2023 at 11:24 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > struct thread values hold onto references to mmaps, dsos, etc. When a
> > > thread exits it is necessary to clean all of this memory up by
> > > removing the thread from the machine's threads. Some tools require
> > > this doesn't happen, such as perf report if offcpu events exist or if
> > > a task list is being generated, so add a symbol_conf value to make the
> > > behavior optional. When an exited thread is left in the machine's
> > > threads, mark it as exited.
> > >
> > > This change relates to commit 40826c45eb0b ("perf thread: Remove
> > > notion of dead threads"). Dead threads were removed as they had a
> > > reference count of 0 and were difficult to reason about with the
> > > reference count checker. Here a thread is removed from threads when it
> > > exits, unless via symbol_conf the exited thread isn't remove and is
> > > marked as exited. Reference counting behaves as it normally does.
> >
> > Maybe we can do it the other way around.  IOW tools can access
> > dead threads for whatever reason if they are dealing with a data
> > file.  And I guess the main concern is perf top to reduce memory
> > footprint, right?  Then we can declare to remove the dead threads
> > for perf top case only IMHO.
>
> Thanks I did consider this but I think this order makes most sense.
> The only tool relying on access to dead threads is perf report, but
> its uses are questionable:
>
>  - task printing - the tools wants to show all threads from a perf run
> and assumes they are in threads. By replacing tool.exit it would be
> easy to record dead threads for this, as the maps aren't required the
> memory overhead could be improved by just recording the necessary
> task's data.
>
>  - offcpu - it would be very useful to have offcpu samples be real
> samples, rather than an aggregated sample at the end of the data file
> with a timestamp greater-than when the thread exited. These samples
> would happen before the exit event is processed and so the reason to
> keep dead threads around would be removed. I think we could do some
> kind of sample aggregation using BPF, but I think we need to think it
> through with exit events. Perhaps we can fix things in the short-term
> by generating BPF samples with aggregation when threads exit in the
> offcpu BPF code, but then again, if you have this going it seems as
> easy just to keep to record all offcpu events as distinct.

Saving off-cpu event on every context switch might cause event loss
due to its frequency.  Generating aggregated samples on EXIT sounds
interesting, but then it'd iterated all possible keys for that thread
including stack trace ID and few more.  So I'm not 100% sure if it's ok
doing it on a task exit path.

>
> Other commands like perf top and perf script don't currently have
> dependencies on dead threads and I'm kind of glad, for
> understandability, memory footprint, etc. Having the default be that
> dead threads linger on will just encourage the kind of issues we see
> currently in perf report and having to have every tool, perf script
> declare it doesn't want dead threads seems burdensome.

Fair enough.

Thanks,
Namhyung
