Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7F7759B48
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjGSQph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjGSQp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:45:29 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE4E213F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:45:14 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-401d1d967beso4611cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689785113; x=1692377113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eouzQn1DE3Woy1acpRFuk9bMIN105v+sSKwoOHp8Q8=;
        b=IbgjYuG3oCAbk2Ss+q74q4W9F25Eeq8BUOuDEmMhxAWrgzJ5V9vxVLkUriCO2ZViyi
         Ts51qXKLKaUYg6koQszGu7BAKGs7tOLsHM1GaCqF87EjE9NiH+j96ZGLV9Lf1+A63pVS
         haptMv8ibM4uu/LUclKR2ygVmqoCN6Bzus6kNffY4lJ51vLYKeotii1gBK3s2lvzzz6o
         OOTgVqxbimG8t5WA+bBOUlPlRkZT1zg/8asYOCkOto+TWfPvcA4pNBFIovUsZSzFdj5u
         YfenC57DXKxItYVqeO75sG8s693f26o2XCM/I6LFSTgFH4d+eIgbnkPF4y20ywQmIRcC
         QTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689785113; x=1692377113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eouzQn1DE3Woy1acpRFuk9bMIN105v+sSKwoOHp8Q8=;
        b=NvmJTf5ms6rd1/D9uOQTruOmr/LP26QrGZ0+9UDGJwE+r51x8J9OxPwUQWBhPSZZtn
         VI06W5dNRFmSOyDcIk4tQ/UO2OzdCPfL5PpwmnSXU1gxUEDWlS3pT1wYxZRgJSCNd9I2
         d469mqtid3nhOy/xKDhhMk/1yYGXPJwVw4z8potX1N1WyP5mVB/e82cYGJ9X5B1k+VW/
         eXidyTnsSPK+oD0i6eqDxIXOdkfWmEKzblTJLL/JpzWdgqIEzlYmznhdjQ9CagacqJDE
         N0gILH2u9Dha8WRKw/v3UjQfX+xzCGh/mD6a3wh9fCDcQn7FM28VGrxlIUI+iRbgrME8
         F5QA==
X-Gm-Message-State: ABy/qLYCMiUfAlhF1EFjEgDnfRei1y52YxQoBK8FcYYb/FGeySzei67c
        JceekL88niLnvxobrwDHShF9gGt1IMKBCUdsSXlLog==
X-Google-Smtp-Source: APBJJlEL8/G/yVptpWOuQ0guUBdI/DR3grNFP/ZpiVN+HoXzJ96I7quOyM5EFQoiqbygx2tM85uZiFrotTti9DDS5c4=
X-Received: by 2002:a05:622a:38b:b0:405:3a65:b3d6 with SMTP id
 j11-20020a05622a038b00b004053a65b3d6mr117111qtx.13.1689785107840; Wed, 19 Jul
 2023 09:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230715032915.97146-1-yangjihong1@huawei.com> <20230715032915.97146-3-yangjihong1@huawei.com>
In-Reply-To: <20230715032915.97146-3-yangjihong1@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 19 Jul 2023 09:44:56 -0700
Message-ID: <CAP-5=fVysKhUn1YsUr0NBU2kVBDgkoczO861XwK5VCtkeYSRJA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] perf evlist: Add evlist__findnew_tracking_event() helper
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, james.clark@arm.com,
        tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 8:31=E2=80=AFPM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> Currently, intel-bts, intel-pt, and arm-spe may add a dummy event for
> tracking to the evlist. We may need to search for the dummy event for
> some settings. Therefore, add evlist__findnew_tracking_event() helper.
>
> evlist__findnew_tracking_event() also deal with system_wide maps if
> system_wide is true.

I'm wondering if we can simplify the naming in the API, we have "dummy
event" which makes sense as we literally call the event "dummy",
"sideband" which refers to the kind of samples/events the dummy event
will record but "tracking" I think tends to get used as a verb rather
than a noun. So I think evlist__findnew_tracking_event should be
evlist__findnew_dummy_event.

Thanks,
Ian

> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/builtin-record.c | 11 +++--------
>  tools/perf/util/evlist.c    | 18 ++++++++++++++++++
>  tools/perf/util/evlist.h    |  1 +
>  3 files changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index aec18db7ff23..ca83599cc50c 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1295,14 +1295,9 @@ static int record__open(struct record *rec)
>          */
>         if (opts->target.initial_delay || target__has_cpu(&opts->target) =
||
>             perf_pmus__num_core_pmus() > 1) {
> -               pos =3D evlist__get_tracking_event(evlist);
> -               if (!evsel__is_dummy_event(pos)) {
> -                       /* Set up dummy event. */
> -                       if (evlist__add_dummy(evlist))
> -                               return -ENOMEM;
> -                       pos =3D evlist__last(evlist);
> -                       evlist__set_tracking_event(evlist, pos);
> -               }
> +               pos =3D evlist__findnew_tracking_event(evlist, false);
> +               if (!pos)
> +                       return -ENOMEM;
>
>                 /*
>                  * Enable the dummy event when the process is forked for
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 7ef43f72098e..25c3ebe2c2f5 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1694,6 +1694,24 @@ void evlist__set_tracking_event(struct evlist *evl=
ist, struct evsel *tracking_ev
>         tracking_evsel->tracking =3D true;
>  }
>
> +struct evsel *evlist__findnew_tracking_event(struct evlist *evlist, bool=
 system_wide)
> +{
> +       struct evsel *evsel;
> +
> +       evsel =3D evlist__get_tracking_event(evlist);
> +       if (!evsel__is_dummy_event(evsel)) {
> +               evsel =3D evlist__add_aux_dummy(evlist, system_wide);
> +               if (!evsel)
> +                       return NULL;
> +
> +               evlist__set_tracking_event(evlist, evsel);
> +       } else if (system_wide) {
> +               perf_evlist__go_system_wide(&evlist->core, &evsel->core);
> +       }
> +
> +       return evsel;
> +}
> +
>  struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const cha=
r *str)
>  {
>         struct evsel *evsel;
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 664c6bf7b3e0..98e7ddb2bd30 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -387,6 +387,7 @@ bool evlist_cpu_iterator__end(const struct evlist_cpu=
_iterator *evlist_cpu_itr);
>
>  struct evsel *evlist__get_tracking_event(struct evlist *evlist);
>  void evlist__set_tracking_event(struct evlist *evlist, struct evsel *tra=
cking_evsel);
> +struct evsel *evlist__findnew_tracking_event(struct evlist *evlist, bool=
 system_wide);
>
>  struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const cha=
r *str);
>
> --
> 2.30.GIT
>
