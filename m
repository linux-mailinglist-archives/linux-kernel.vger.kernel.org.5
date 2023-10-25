Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196EB7D73DC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjJYTEe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Oct 2023 15:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbjJYTEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:04:31 -0400
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A50186;
        Wed, 25 Oct 2023 12:04:28 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-27d5fe999caso31384a91.1;
        Wed, 25 Oct 2023 12:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698260668; x=1698865468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0d7Dj62K3ZkBF/x+7OimkWn3bFsJf98qoG9lznGMZYY=;
        b=QcR0M2nkjcY7viuaoOfalEYrKXMHwnx3m69vSkTAwdGLGlzMaLfX0xIZUFvSra4y+g
         /391W4gGKGqOLnN5M4qaloDEie9h9pGkROdtSPVii9pEGSZgsHVbAwsnM7kubTCcOjPo
         bKjzH9X0UlMEenbr74IC9U2wftCG4hQE6z3UF6xGzrsuyH5b1MJrafYnwz83oYXm26QI
         NeZ3bDdluG2weJ15TSmOG+ez7H7+GVZaGaDanNEWOoeDgLbPlJH8mPOSgGxNZFScsw1D
         /+gqPPaAjur89SpdwU1VqViM1dOmu6YzDWSPx+UJGVUhvWFB2o7w8uf5cVo2CkLuSc/T
         vq/w==
X-Gm-Message-State: AOJu0YziyV2wIUcXqauOybzUY+lsz9NMWc0HESGMAW4GNOtOAW2ZQz3o
        hZds/4jl7YG3OPIBTEomUp1vDOSeonfHL8PqDBc=
X-Google-Smtp-Source: AGHT+IFtj8r3INFp3+LJ6S90V8QanjDNAEDWoS87P1NLH6bTl5+yfbimS2A4dnP9l2yNdG0FpTpXoYAX5CITqQOLr/c=
X-Received: by 2002:a17:90b:2786:b0:274:111c:c14d with SMTP id
 pw6-20020a17090b278600b00274111cc14dmr12568239pjb.13.1698260667789; Wed, 25
 Oct 2023 12:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com> <20231024222353.3024098-21-irogers@google.com>
 <7516348d-fe6d-9768-049e-328cfcda89ee@huawei.com> <CAP-5=fX2Mk9uUfbnF75B=2xFjGy3HWtjPaM-B0-_KWaHjBW0qQ@mail.gmail.com>
In-Reply-To: <CAP-5=fX2Mk9uUfbnF75B=2xFjGy3HWtjPaM-B0-_KWaHjBW0qQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 25 Oct 2023 12:04:16 -0700
Message-ID: <CAM9d7cj4QbsMoqzrCy+9MU-eOo=TNoew_h7V-mkD+X7AkZR7Dw@mail.gmail.com>
Subject: Re: [PATCH v3 20/50] perf record: Be lazier in allocating lost
 samples buffer
To:     Ian Rogers <irogers@google.com>
Cc:     Yang Jihong <yangjihong1@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 10:01 AM Ian Rogers <irogers@google.com> wrote:
>
> On Tue, Oct 24, 2023 at 8:44 PM Yang Jihong <yangjihong1@huawei.com> wrote:
> >
> > Hello,
> >
> > On 2023/10/25 6:23, Ian Rogers wrote:
> > > Wait until a lost sample occurs to allocate the lost samples buffer,
> > > often the buffer isn't necessary. This saves a 64kb allocation and
> > > 5.3kb of peak memory consumption.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >   tools/perf/builtin-record.c | 29 +++++++++++++++++++----------
> > >   1 file changed, 19 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > > index 9b4f3805ca92..b6c8c1371b39 100644
> > > --- a/tools/perf/builtin-record.c
> > > +++ b/tools/perf/builtin-record.c
> > > @@ -1924,21 +1924,13 @@ static void __record__save_lost_samples(struct record *rec, struct evsel *evsel,
> > >   static void record__read_lost_samples(struct record *rec)
> > >   {
> > >       struct perf_session *session = rec->session;
> > > -     struct perf_record_lost_samples *lost;
> > > +     struct perf_record_lost_samples *lost = NULL;
> > >       struct evsel *evsel;
> > >
> > >       /* there was an error during record__open */
> > >       if (session->evlist == NULL)
> > >               return;
> > >
> > > -     lost = zalloc(PERF_SAMPLE_MAX_SIZE);
> > > -     if (lost == NULL) {
> > > -             pr_debug("Memory allocation failed\n");
> > > -             return;
> > > -     }
> > > -
> > > -     lost->header.type = PERF_RECORD_LOST_SAMPLES;
> > > -
> > >       evlist__for_each_entry(session->evlist, evsel) {
> > >               struct xyarray *xy = evsel->core.sample_id;
> > >               u64 lost_count;
> > > @@ -1961,6 +1953,14 @@ static void record__read_lost_samples(struct record *rec)
> > >                               }
> > >
> > >                               if (count.lost) {
> > > +                                     if (!lost) {
> > > +                                             lost = zalloc(PERF_SAMPLE_MAX_SIZE);
> > > +                                             if (!lost) {
> > > +                                                     pr_debug("Memory allocation failed\n");
> > > +                                                     return;
> > > +                                             }
> > > +                                             lost->header.type = PERF_RECORD_LOST_SAMPLES;
> > > +                                     }
> > >                                       __record__save_lost_samples(rec, evsel, lost,
> > >                                                                   x, y, count.lost, 0);
> > >                               }
> > > @@ -1968,9 +1968,18 @@ static void record__read_lost_samples(struct record *rec)
> > >               }
> > >
> > >               lost_count = perf_bpf_filter__lost_count(evsel);
> > > -             if (lost_count)
> > > +             if (lost_count) {
> > > +                     if (!lost) {
> > > +                             lost = zalloc(PERF_SAMPLE_MAX_SIZE);
> > > +                             if (!lost) {
> > > +                                     pr_debug("Memory allocation failed\n");
> > > +                                     return;
> > > +                             }
> > > +                             lost->header.type = PERF_RECORD_LOST_SAMPLES;
> > > +                     }
> > >                       __record__save_lost_samples(rec, evsel, lost, 0, 0, lost_count,
> > >                                                   PERF_RECORD_MISC_LOST_SAMPLES_BPF);
> > > +             }
> > >       }
> >
> > Can zalloc for `lost` be moved to __record__save_lost_samples?
> > This simplifies the code.
>
> Hmm.. seems marginal. This change makes the code not return in
> record__read_lost_samples when the memory allocation fails, so I'm
> 50/50 on it.

Maybe you can make it return the failure.

> >
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index dcf288a4fb9a..8d2eb746031a 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
[SNIP]
> >   out:
> > -       free(lost);
> > +       if (lost)
> > +               free(lost);

This is unnecessary as free() can handle NULL pointers.

Thanks,
Namhyung


> >   }
> >
> >   static volatile sig_atomic_t workload_exec_errno;
> >
> >
> > Thanks,
> > Yang
> >
