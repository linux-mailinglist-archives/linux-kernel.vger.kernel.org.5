Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C61378D1F9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 04:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241679AbjH3CQo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Aug 2023 22:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241664AbjH3CQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 22:16:14 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3E01AE;
        Tue, 29 Aug 2023 19:16:11 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-792979d4cb5so120508939f.2;
        Tue, 29 Aug 2023 19:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693361771; x=1693966571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CjFi6cUVZY0g7eLFe1AGRgz8trR5f1SXBrW6/YjzboQ=;
        b=eaDfWgvfkUGvRzGX/Cjzz5eA9kPA/GTGa/hLpou7q4fuoZ9VSx05WCy0AOkgvhVqaY
         f5W6csjksA4m++UixpG5Glv1gPmRPKtYYZJsK30z7Okbqlzq8YTmBK/lb8v6RWIPfPBL
         C3SqZyw13lnkxtuPclM5To351+d/PNI6rZJ0VXFHTZ4NZUuLGeEWjkHXk9WUbL58kRW8
         G70kyiK9EcVUvs4NuGTBwMNND1wD/EZdzPQxa8pF1ILy1fY4B12D0eOATyPnUlmmmmTQ
         tF0fxgW2rlu8x33eq7BBza4NOPT4Qzj0xLRX1PNFSpktEA1RAi+pVZ/UzYVHoLL2+113
         ZBrQ==
X-Gm-Message-State: AOJu0YzhWqS6MLvXx+avQ4oIgofofrYz1COq4yxZsVFIQHwh6XvKtIRT
        NKVFmsETBJ4151JFEq2ItPjNrqzpHNbCkFqNWAVMwxex
X-Google-Smtp-Source: AGHT+IFbvE5KcHjMCpNqBiJFqddcYy3/FON1NepXaJumsQXY8SIPlKGArwrU2r+HbgY+nUfnzmwyPhpd4i56oOnioV0=
X-Received: by 2002:a6b:e317:0:b0:790:9f0c:3069 with SMTP id
 u23-20020a6be317000000b007909f0c3069mr1138122ioc.9.1693361770797; Tue, 29 Aug
 2023 19:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230825152552.112913-1-namhyung@kernel.org> <20230825152552.112913-3-namhyung@kernel.org>
 <150a4c24-6082-cf74-035d-c6cf4dacc46d@intel.com>
In-Reply-To: <150a4c24-6082-cf74-035d-c6cf4dacc46d@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 29 Aug 2023 19:15:58 -0700
Message-ID: <CAM9d7cg5vaD6zUThLWSpL-j3nXJgs3PK=_ensRw8P0Xye-VcfA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] perf tools: Convert to perf_record_header_attr_id()
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Mon, Aug 28, 2023 at 12:59 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 25/08/23 18:25, Namhyung Kim wrote:
> > Instead of accessing the attr.id directly, use the
> > perf_record_header_attr_id() helper to handle old versions.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/header.c           | 2 +-
> >  tools/perf/util/session.c          | 4 ++--
> >  tools/perf/util/synthetic-events.c | 2 +-
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index f89321cbfdee..63967c34157d 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -4408,7 +4408,7 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
> >       if (perf_evsel__alloc_id(&evsel->core, 1, n_ids))
> >               return -ENOMEM;
> >
> > -     ids = (void *)&event->attr.attr + event->attr.attr.size;
> > +     ids = perf_record_header_attr_id(event);
> >       for (i = 0; i < n_ids; i++) {
> >               perf_evlist__id_add(&evlist->core, &evsel->core, 0, i, ids[i]);
> >       }
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index 00d18c74c090..1e9aa8ed15b6 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -833,8 +833,8 @@ static void perf_event__hdr_attr_swap(union perf_event *event,
> >       perf_event__attr_swap(&event->attr.attr);
> >
> >       size = event->header.size;
> > -     size -= (void *)&event->attr.id - (void *)event;
> > -     mem_bswap_64(event->attr.id, size);
> > +     size -= perf_record_header_attr_id(event) - (void *)event;
> > +     mem_bswap_64(perf_record_header_attr_id(event), size);
>
> Should this and below also be a fix for stable?

Then it'd need the perf_record_header_attr_id() change as well.
Also I'm not sure if it's really needed for stable as it's a pipe output
(saved to a file though) so very unlikely to have a different endian.

Thanks,
Namhyung

>
> >  }
> >
> >  static void perf_event__event_update_swap(union perf_event *event,
> > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> > index 45714a2785fd..a0579c7d7b9e 100644
> > --- a/tools/perf/util/synthetic-events.c
> > +++ b/tools/perf/util/synthetic-events.c
> > @@ -2145,7 +2145,7 @@ int perf_event__synthesize_attr(struct perf_tool *tool, struct perf_event_attr *
> >               return -ENOMEM;
> >
> >       ev->attr.attr = *attr;
> > -     memcpy(ev->attr.id, id, ids * sizeof(u64));
> > +     memcpy(perf_record_header_attr_id(ev), id, ids * sizeof(u64));
> >
> >       ev->attr.header.type = PERF_RECORD_HEADER_ATTR;
> >       ev->attr.header.size = (u16)size;
>
