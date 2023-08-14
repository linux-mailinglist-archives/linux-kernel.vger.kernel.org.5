Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A973A77BEEC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjHNR2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjHNR2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:28:45 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4578310DB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:28:44 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40a47e8e38dso19281cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692034123; x=1692638923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0ynxCVxUsDM8eCCK8zGMWKVxYfhvsg5eu7n+GQoFuQ=;
        b=a7KJAsBue20iQVGuNyvMysMBgKWMtOWTM6XzXiDvi/muAuOej2tlwrMQrCD3oyr1DB
         cV2ns+a8bqwUH+TUCAmi9NlLG2Klmv2cqPYYhX0eEzz8/Us/rkhd7DOIawTP+y50PlId
         rsgIjlJ0WIvZJ8gamfhVHRmmhBWXjDMVt2rS/w/P7kdgMTWckIt63EL0bEqpEQmwZvEz
         RiArh0Dj/1xSTv9YERC7CsBos76mhcl1FHMJ/Mmnnq8Ry2W6qtRA7CggnNGn/PXk9ws7
         57pS14UA5b3R+0YbgPi56ZdMJGKScyM1DbucoyphXeBrpnrO7Ev139227jZ2HO9tJVdS
         5NDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692034123; x=1692638923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0ynxCVxUsDM8eCCK8zGMWKVxYfhvsg5eu7n+GQoFuQ=;
        b=jG4dTGE76fEytOOpTGrVpC+gMrfhtCJkrURsHQdBDSls7WTSjz61RSsYby37KI2zNE
         NH+Ku52sqIeydM/89si2E+GP4fn7rfBEWpm80/iRQrzNEE4avyS4ldX8+V12Us3/glZJ
         U3qQOSbS6wh1P1lzCFyVjtiII+w9M0THMjUjTAieCgXpnPwajgfSzCGXGBgzOv+arKJZ
         O5Mj4RgRIc5VZVzzQ0CRY4W7zTFuusE3YhEDbsbOPrebMI4f0ottSOpbYydNfXghnqgL
         u5G84U8iH4jb6/i/PQtpWtQmTbKXkbisC1W/DnV1eEhsmD1XZLgab6T39wav7BW9YIfM
         BjsQ==
X-Gm-Message-State: AOJu0Yya5tzKnPu+UXgwCL18rUXi4gSRdZUYasoHfxnoHbvmRu2PhtXr
        JcSJ+nQo7Gl/Je8jwVdXoYvaYDi8VUEJ6cgyVoagjg==
X-Google-Smtp-Source: AGHT+IGIS3JZ+2r/EEnDwIFyidh6lYHE1I0NcfM4xWHTNBXg77WSE7GmnjFls0IJH/XfCefVDf0IfUs+JAfNBepKA8k=
X-Received: by 2002:ac8:4e55:0:b0:40f:ec54:973 with SMTP id
 e21-20020ac84e55000000b0040fec540973mr695644qtw.22.1692034123260; Mon, 14 Aug
 2023 10:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230731091857.10681-1-adrian.hunter@intel.com> <ZMwTYsh8KIwphOR5@kernel.org>
In-Reply-To: <ZMwTYsh8KIwphOR5@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Aug 2023 10:28:29 -0700
Message-ID: <CAP-5=fW+Y+4dk_TL2RuOJWwnqd3cvhVARoRVSdmhiiVaNwEnfw@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf dlfilter: Add a test for resolve_address()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 1:51=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Mon, Jul 31, 2023 at 12:18:55PM +0300, Adrian Hunter escreveu:
> > Extend the "dlfilter C API" test to test
> > perf_dlfilter_fns.resolve_address(). The test currently fails, but pass=
es
> > after a subsequent patch.
>
> Ian,
>
>         I think this is ok now, can you please take a look and perhaps
> provide an Acked-by or Reviewed-by?

Sorry, found this in my backlog. I'm a little confused over which
patch series is current but they all lgtm.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> - Arnaldo
>
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >  tools/perf/dlfilters/dlfilter-test-api-v0.c | 26 ++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/dlfilters/dlfilter-test-api-v0.c b/tools/perf/d=
lfilters/dlfilter-test-api-v0.c
> > index b1f51efd67d6..72f263d49121 100644
> > --- a/tools/perf/dlfilters/dlfilter-test-api-v0.c
> > +++ b/tools/perf/dlfilters/dlfilter-test-api-v0.c
> > @@ -254,6 +254,30 @@ static int check_addr_al(void *ctx)
> >       return 0;
> >  }
> >
> > +static int check_address_al(void *ctx, const struct perf_dlfilter_samp=
le *sample)
> > +{
> > +     struct perf_dlfilter_al address_al;
> > +     const struct perf_dlfilter_al *al;
> > +
> > +     al =3D perf_dlfilter_fns.resolve_ip(ctx);
> > +     if (!al)
> > +             return test_fail("resolve_ip() failed");
> > +
> > +     address_al.size =3D sizeof(address_al);
> > +     if (perf_dlfilter_fns.resolve_address(ctx, sample->ip, &address_a=
l))
> > +             return test_fail("resolve_address() failed");
> > +
> > +     CHECK(address_al.sym && al->sym);
> > +     CHECK(!strcmp(address_al.sym, al->sym));
> > +     CHECK(address_al.addr =3D=3D al->addr);
> > +     CHECK(address_al.sym_start =3D=3D al->sym_start);
> > +     CHECK(address_al.sym_end =3D=3D al->sym_end);
> > +     CHECK(address_al.dso && al->dso);
> > +     CHECK(!strcmp(address_al.dso, al->dso));
> > +
> > +     return 0;
> > +}
> > +
> >  static int check_attr(void *ctx)
> >  {
> >       struct perf_event_attr *attr =3D perf_dlfilter_fns.attr(ctx);
> > @@ -290,7 +314,7 @@ static int do_checks(void *data, const struct perf_=
dlfilter_sample *sample, void
> >       if (early && !d->do_early)
> >               return 0;
> >
> > -     if (check_al(ctx) || check_addr_al(ctx))
> > +     if (check_al(ctx) || check_addr_al(ctx) || check_address_al(ctx, =
sample))
> >               return -1;
> >
> >       if (early)
> > --
> > 2.34.1
> >
>
> --
>
> - Arnaldo
