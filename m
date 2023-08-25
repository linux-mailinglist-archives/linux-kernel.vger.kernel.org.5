Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BBF788AFB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242104AbjHYOIo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Aug 2023 10:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242076AbjHYOIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:08:11 -0400
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF17E1BD9;
        Fri, 25 Aug 2023 07:07:47 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-48d0ceedda1so391122e0c.3;
        Fri, 25 Aug 2023 07:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692972405; x=1693577205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mQxmMAvnOZw0pwXo+btIZ2X2+HasX1mKXhjeR2nCxI=;
        b=gNIH5jhizrlRTcw6YLt130Dc/YAWeHf6w8W8fdTO/TI6wfkX9Fa7cUuvrMotqQPD34
         ebwnF2cYn8oTTY8JsN4s8RWOmChq8cDlCRoZ005If7LnqcnWwUar5mX3oelmOk3QjTbv
         JNdVAsSN77h7hsyra1aXyla8ReY14fzolDpNGn/0uUnAK+rF/dj1FYzo9z0JQV8ZFKEc
         EKCCW+YCTuogmzYNvQV0y3u8ndq6t7GvEuWXnP+ihDwXEx2+G8zsxPDw9zQfyScBJykv
         t6tBvEHtTJeGPVEU75Tjgb/SW445lIBqzIVIgozcbnpN9y/vqs/gPK3r6DXrp38rw8zx
         U0Aw==
X-Gm-Message-State: AOJu0YxnVHhEzy+EvHS0n9D/4sNEVd9YrRSlbInWoakGQEtFSiNNxcJX
        Q1WP1VUq6+bh0B0R4NONaFxnXkLGOGCh255EmkU=
X-Google-Smtp-Source: AGHT+IE66ZqEeKIuG7KEqy3UzGM8u4dlPsgiisDqkM6WiMgDFej8tEo4JRRCrMyzpRh/d0ffD1s4Kk2U52oB4q81/Go=
X-Received: by 2002:a1f:4a02:0:b0:48c:fc50:4292 with SMTP id
 x2-20020a1f4a02000000b0048cfc504292mr14506630vka.15.1692972405026; Fri, 25
 Aug 2023 07:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230807061652.2492167-1-namhyung@kernel.org> <b2332dd5-e01e-dc61-e19c-55cf9a684ca2@intel.com>
In-Reply-To: <b2332dd5-e01e-dc61-e19c-55cf9a684ca2@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 25 Aug 2023 07:06:32 -0700
Message-ID: <CAM9d7chY9415RDQ0CBFQgy3VYw+Ah8JSFL8A=o5_JB-HD6N2qw@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Handle old data in PERF_RECORD_ATTR
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Adrian,

Sorry for the late reply.

On Mon, Aug 14, 2023 at 12:11 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 7/08/23 09:16, Namhyung Kim wrote:
> > The PERF_RECORD_ATTR is used for a pipe mode to describe an event with
> > attribute and IDs.  The ID table comes after the attr and it calculate
> > size of the table using the total record size and the attr size.
> >
> >   n_ids = (total_record_size - end_of_the_attr_field) / sizeof(u64)
> >
> > This is fine for most use cases, but sometimes it saves the pipe output
> > in a file and then process it later.  And it becomes a problem if there
> > is a change in attr size between the record and report.
> >
> >   $ perf record -o- > perf-pipe.data  # old version
> >   $ perf report -i- < perf-pipe.data  # new version
> >
> > For example, if the attr size is 128 and it has 4 IDs, then it would
> > save them in 168 byte like below:
> >
> >    8 byte: perf event header { .type = PERF_RECORD_ATTR, .size = 168 },
> >  128 byte: perf event attr { .size = 128, ... },
> >   32 byte: event IDs [] = { 1234, 1235, 1236, 1237 },
> >
> > But when report later, it thinks the attr size is 136 then it only read
> > the last 3 entries as ID.
> >
> >    8 byte: perf event header { .type = PERF_RECORD_ATTR, .size = 168 },
> >  136 byte: perf event attr { .size = 136, ... },
> >   24 byte: event IDs [] = { 1235, 1236, 1237 },  // 1234 is missing
> >
> > So it should use the recorded version of the attr.  The attr has the
> > size field already then it should honor the size when reading data.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/header.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index 52fbf526fe74..f89321cbfdee 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -4381,7 +4381,8 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
> >                            union perf_event *event,
> >                            struct evlist **pevlist)
> >  {
> > -     u32 i, ids, n_ids;
> > +     u32 i, n_ids;
> > +     u64 *ids;
> >       struct evsel *evsel;
> >       struct evlist *evlist = *pevlist;
> >
> > @@ -4397,9 +4398,8 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
> >
> >       evlist__add(evlist, evsel);
> >
> > -     ids = event->header.size;
> > -     ids -= (void *)&event->attr.id - (void *)event;
> > -     n_ids = ids / sizeof(u64);
> > +     n_ids = event->header.size - sizeof(event->header) - event->attr.attr.size;
> > +     n_ids = n_ids / sizeof(u64);
> >       /*
> >        * We don't have the cpu and thread maps on the header, so
> >        * for allocating the perf_sample_id table we fake 1 cpu and
> > @@ -4408,8 +4408,9 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
> >       if (perf_evsel__alloc_id(&evsel->core, 1, n_ids))
> >               return -ENOMEM;
> >
> > +     ids = (void *)&event->attr.attr + event->attr.attr.size;
> >       for (i = 0; i < n_ids; i++) {
> > -             perf_evlist__id_add(&evlist->core, &evsel->core, 0, i, event->attr.id[i]);
> > +             perf_evlist__id_add(&evlist->core, &evsel->core, 0, i, ids[i]);
> >       }
> >
> >       return 0;
>
> This is a good catch!
>
> It looks like perf_event__hdr_swap() might also have this problem.

You mean perf_event__hdr_attr_swap(), right?  Yeah, looks so.
I'll change it too in v2.

>
> I wonder if we should remove 'id' from struct perf_record_header_attr
> since the position is not guaranteed?
>
> Probably could use a comment there either way.

Sounds good.  I'll remove the id field and add a comment.

>
> Also perhaps a fixes tag and cc stable

Sure, thanks for the review!

Namhyung
