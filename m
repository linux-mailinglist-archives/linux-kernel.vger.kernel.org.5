Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACC77908AF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 18:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbjIBQ2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 12:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjIBQ2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 12:28:33 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A3710EF
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 09:28:29 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40a47e8e38dso132821cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 09:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693672108; x=1694276908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EzO8S4Wgh7aLnDzjIxs6gMwkMUowdVILp40w0jb3Y4=;
        b=NEExwjUHJ9/EanixSe0yfg6Sw51X50L1ub9WUz6WNUpSkC5fV0A/H81+RvT+j2EANC
         qkPLVsrhbJ8kldIshxJ3/GnrDHtlSRegcK5VwkatUMiW4vgtiU3O7R3fzFXLAyNJDWL0
         q8hpuqQYy3PMEeSQvrlDdAW0g7GYq31Lb4pee2MiUfwh3ZWhfbgxrPL1iUlZrsdXq00Q
         tcuqFGanw4SN06obaW/arti9Js4yzo3yxl7eebRVe6IShWQIXdA9Vf5CSELBbtWZCInP
         veZ2C3FbWLhQngJwXi4ISkjzOgj0XsUeIHI89GPrbQ3XRegNJqo5E5eVLmyo1ZIGWCV4
         sERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693672108; x=1694276908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EzO8S4Wgh7aLnDzjIxs6gMwkMUowdVILp40w0jb3Y4=;
        b=G5Z5Hc+TLQmW+xU84TbSQTKJtLtsNM7S9R07PJj9AEfbeNcsGYh67UCW6bcBWg36Fa
         5Z8pR4Ku5nbod9ZPZQdUM3k5ciM08+qWOqH3oLTevqv3h24vK5MvbrBl3efGMR6orHS/
         6PH3J4cvGIuo98Odry6xPNSYngZZfModD9m5BY6xYsAISYyOM65D51Hlp+YOp0dvscGC
         IZfgHD5xeLdKDdczPUe9k+bkHzMNuPJAP2lXXpwpUl4ARfNONpbhCNh4KnjPODukS8UX
         g7toE2c9l9g+b4aSRkKbZU++9liUSJioDKO73Cf1KAjPxW2/oxMC75Hj+xqxeVrL7xDR
         pD4w==
X-Gm-Message-State: AOJu0Yy93KijDeHvKhHXJxvi2VnluNhYneaJc6gVYhjUGTw1YbUahCPR
        /s0cY0Hx/BpTuALZgd1VrpRc9zfOdj88T8OYtvvReg==
X-Google-Smtp-Source: AGHT+IEKMy80sTC1s8FDtCBrWDPYntvznx6mxqd4AqN03guFXd18x6Nt+TizIqK72/hvER4kV8aZDbsUMn9oBQnNzY4=
X-Received: by 2002:ac8:5852:0:b0:403:96e3:4745 with SMTP id
 h18-20020ac85852000000b0040396e34745mr192243qth.20.1693672107993; Sat, 02 Sep
 2023 09:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230901233949.2930562-1-irogers@google.com> <ZPMYU2lvkhfmPYyG@kernel.org>
In-Reply-To: <ZPMYU2lvkhfmPYyG@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 2 Sep 2023 09:28:15 -0700
Message-ID: <CAP-5=fVHNE2JDcZ1cbX=vj1kxHWWescjizKprjCKe+yL0xxuCQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] perf parse-events: Fixes relating to no_value terms
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 2, 2023 at 4:11=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Fri, Sep 01, 2023 at 04:39:44PM -0700, Ian Rogers escreveu:
> > A term may have no value in which case it is assumed to have a value
> > of 1. It doesn't just apply to alias/event terms so change the
> > parse_events_term__to_strbuf assert.
> >
> > Commit 99e7138eb789 ("perf tools: Fail on using multiple bits long
> > terms without value") made it so that no_value terms could only be for
> > a single bit. Prior to commit 64199ae4b8a3 ("perf parse-events: Fix
> > propagation of term's no_value when cloning") this missed a test case
> > where config1 had no_value.
> >
> > Fixes: 64199ae4b8a3 ("perf parse-events: Fix propagation of term's no_v=
alue when cloning")
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> I'm trying to minimize the number of patches that aren't strict fixes
> this late in the process for v6.6, so I think I'll get just this first
> one and defer the other cleanups/improvements for v6.7, ok?

Makes sense, this is why I put the fix first in the series.

Thanks,
Ian

> Thanks,
>
> - Arnaldo
>
> > ---
> >  tools/perf/tests/parse-events.c | 2 +-
> >  tools/perf/util/parse-events.c  | 2 +-
> >  tools/perf/util/parse-events.h  | 4 ++--
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-e=
vents.c
> > index d86076d575ed..d47f1f871164 100644
> > --- a/tools/perf/tests/parse-events.c
> > +++ b/tools/perf/tests/parse-events.c
> > @@ -2170,7 +2170,7 @@ static const struct evlist_test test__events[] =
=3D {
> >
> >  static const struct evlist_test test__events_pmu[] =3D {
> >       {
> > -             .name  =3D "cpu/config=3D10,config1,config2=3D3,period=3D=
1000/u",
> > +             .name  =3D "cpu/config=3D10,config1=3D1,config2=3D3,perio=
d=3D1000/u",
> >               .valid =3D test__pmu_cpu_valid,
> >               .check =3D test__checkevent_pmu,
> >               /* 0 */
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-eve=
nts.c
> > index 68fe2c4ff49f..65608a3cba81 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -2607,7 +2607,7 @@ int parse_events_term__to_strbuf(struct list_head=
 *term_list, struct strbuf *sb)
> >
> >               if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_NUM)
> >                       if (term->no_value) {
> > -                             assert(term->type_term =3D=3D PARSE_EVENT=
S__TERM_TYPE_USER);
> > +                             assert(term->val.num =3D=3D 1);
> >                               ret =3D strbuf_addf(sb, "%s", term->confi=
g);
> >                       } else
> >                               ret =3D strbuf_addf(sb, "%s=3D%#"PRIx64, =
term->config, term->val.num);
> > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-eve=
nts.h
> > index 855b0725c5d4..594e5d2dc67f 100644
> > --- a/tools/perf/util/parse-events.h
> > +++ b/tools/perf/util/parse-events.h
> > @@ -124,8 +124,8 @@ struct parse_events_term {
> >        */
> >       bool weak;
> >       /**
> > -      * @no_value: Is there no value. TODO: this should really be part=
 of
> > -      * type_val.
> > +      * @no_value: Is there no value. If a numeric term has no value t=
hen the
> > +      * value is assumed to be 1. An event name also has no value.
> >        */
> >       bool no_value;
> >  };
> > --
> > 2.42.0.283.g2d96d420d3-goog
> >
>
> --
>
> - Arnaldo
